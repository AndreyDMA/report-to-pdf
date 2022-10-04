public with sharing class ReportConverterPage2Cntrl {
    public ReportWrap report { get; set; }
    public String pageSize { get; set; }

    public ReportConverterPage2Cntrl() {
        report = retrieveReport(apexpages.currentPage()
        .getParameters()
        .get('reportId')
        .escapeHtml4());

        pageSize = composeResourceUrl(apexpages.currentPage()
        .getParameters()
        .get('format')
        .escapeHtml4());
    }

    private ReportWrap retrieveReport(String reportId) {
        try {
            ReportConverterHandler handler = new ReportConverterHandler(
                reportId
            );
            ReportWrap report = handler.retrieveReport();
            return report != null ? report : new ReportWrap('Sorry this type of Report can not be converted...');
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    private String composeResourceUrl(String target) {
        String address = PageReference.forResource('ReportConverterRecources').getUrl();
        address = address.subString(0, address.indexOf('?'));
        address += '/css/' + target + '.css';
        return address;
    }
}
