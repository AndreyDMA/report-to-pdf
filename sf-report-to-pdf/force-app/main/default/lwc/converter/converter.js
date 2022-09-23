import { LightningElement, api } from "lwc";
import {
    composeHeaderHTML,
    composeTableHTML,
    composeListHTML,
    wrapHTML
} from "./converterHelper.js";
import retrieveReport from "@salesforce/apex/ReportConverterController.retrieveReport";

export default class Converter extends LightningElement {
    @api reportId;
    @api view;
    @api target;
    reportData;
    reportDescr;
    reportHTML = "";

    doConvert() {
        try {
            this.loadData();
            this.composeData();
            this.download("test", this.reportHTML);
        } catch (e) {
            console.log(e.message);
        }
    }

    loadData() {
        retrieveReport({ reportId: this.reportId })
            .then((result) => {
                this.reportData = JSON.parse(result.data);
                this.reportDescr = JSON.parse(result.description);
            })
            .catch((error) => {
                console.log(error.message);
            });
    }

    composeData() {
        if (this.target === "HTML") {
            this.composeHTML();
        } else if (this.target === "PDF") {
            this.composePDF();
        }
    }

    composeHTML() {
        this.reportHTML += composeHeaderHTML(this.reportDescr);

        if (this.view === "List view") {
            this.reportHTML += composeListHTML(this.reportData);
        } else if (this.view === "Tabular view") {
            this.reportHTML += composeTableHTML(this.reportData);
        }

        this.reportHTML = wrapHTML(this.reportHTML);
    }

    download(filename, data) {
        const blob = new Blob([data], {
            type: "application/pdf"
        });
        if (window.navigator.msSaveOrOpenBlob) {
            window.navigator.msSaveBlob(blob, filename);
        } else {
            const docURL = window.URL.createObjectURL(blob);
            const elem = window.document.createElement("a");
            elem.href = docURL;
            elem.download = filename;
            document.body.appendChild(elem);
            elem.click();
            document.body.removeChild(elem);
            URL.revokeObjectURL(docURL);
        }
    }

    composePDF() {}
}
