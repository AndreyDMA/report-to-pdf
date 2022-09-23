import * as renderer from "c/renderer";

function composeHeaderHTML(reportDescr) {
    return `
    <div class="slds-page-header">
        <h1>
            <span class="slds-page-header__title slds-truncate" title="${reportDescr.name}">${reportDescr.name}s</span>
        </h1>
        <p class="slds-page-header__name-meta">${reportDescr.description}</p>
    </div>
    `;
}

// function composeHeaderHTML(reportDescr) {
//     let header = renderer.createElement('div', { class : 'slds-page-header' });
//     let headerTitle = renderer.createElement('h1');
//     let headerTitleText = renderer.createElement('span', { class : 'slds-page-header__title slds-truncate' });
//     headerTitleText.innerText = reportDescr.name;
//     renderer.addChild(headerTitle, headerTitleText);
//     renderer.addChild(header, headerTitle);

//     let headerDescrText = renderer.createElement('p', { class : 'slds-page-header__meta-text slds-truncate' });
//     headerDescrText.innerText = reportDescr.description;
//     renderer.addChild(header, headerDescrText);

//     return header;
// }

function composeTableHTML(reportData) {
    const head = composeTableHead(Object.keys(reportData[0]));
    const body = composeTableBody(reportData);

    return `
    <table class="slds-table slds-table_cell-buffer slds-table_bordered slds-table_col-bordered">
        ${head}
        ${body}
    </table>
    `;
}

function composeTableHead(colNames) {
    let columns = '';
    colNames.forEach((element) => {
        columns +=
        `<th class="" scope="col">
            <div class="slds-truncate" title="${element}">${element}</div>
        </th>`
    });

    return `
    <thead>
        <tr class="slds-line-height_reset">
            <th class="" scope="col">
                <div class="slds-truncate" title="Сount"></div>
            </th>
            ${columns}
        </tr>
    </thead>
    `;
}

function composeTableBody(data) {
    let body = '';
    let count = 0;
    data.forEach((element) => {
        count++;
        body += composeTableRow(element, count);
    });

    return `
    <tbody>
        ${body}
    </tbody>
    `;
}

function composeTableRow(elem, count) {
    let row = '';
    for (const [key, value] of Object.entries(elem)) {
        row +=
        `<td data-label="${key}">
            <div class="slds-truncate" title="${value}">${value}</div>
        </td>`
      }

    return `
    <tr class="slds-hint-parent">
        <td data-label="Count">
            <div class="slds-truncate" title="Row number">${count}</div>
        </td>
        ${row}
    </tr>
    `;
}

function wrapHTML(body) {
    return `
    <!DOCTYPE html>
    <html>
        <head>
            <link
                rel="stylesheet"
                href="https://cdnjs.cloudflare.com/ajax/libs/design-system/2.5.0/styles/salesforce-lightning-design-system.min.css"
            />
        </head>
        <body>
        ${body}
        </body>
    </html>
    `;
}

function composeListHTML(reportData) {}

export { composeHeaderHTML, composeTableHTML, composeListHTML, wrapHTML };
