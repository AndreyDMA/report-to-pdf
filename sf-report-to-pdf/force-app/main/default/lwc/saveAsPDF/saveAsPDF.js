import { LightningElement } from 'lwc';

export default class SaveAsPDF extends LightningElement {
    snapReport() {
        return document.body.querySelector('.reportsReportBuilder').contentDocument.firstElementChild.querySelector('.widgets');
    }

    doConvert() {
        console.log('pressed');
        debugger;
        const d = document;
        console.log(d);
    }
}