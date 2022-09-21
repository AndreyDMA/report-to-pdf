import { LightningElement } from 'lwc';
import retrieveFromURI from './saveToHTMLHelper.js';

const LIST_VIEW = "List view";
const TAB_VIEW = "Tabular view";
const SELECT_REPORT = "Open Report you want to convert and press 'Get ID' button";

export default class SaveToHTML extends LightningElement {
    LABELS = {
        LIST_VIEW,
        TAB_VIEW,
        SELECT_REPORT
    };
    
    view = TAB_VIEW;
    reportId;

    connectedCallback() {
        if (!this.reportId) {
            this.getReportId();
        }
    }

    get options() {
        return [
            { label: TAB_VIEW, value: TAB_VIEW },
            { label: LIST_VIEW, value: LIST_VIEW },
        ];
    }

    changeView(evt) {
        this.view = evt.target.value;
    }

    getReportId() {
        this.reportId = retrieveFromURI(document.baseURI);
    }
}