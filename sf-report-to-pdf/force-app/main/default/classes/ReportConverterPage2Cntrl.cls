public with sharing class ReportConverterPage2Cntrl {
    public ReportWrap report { get; set; }
    public String pageSize { get; set; }

    public ReportConverterPage2Cntrl() {
        report = retrieveReport(
            apexpages.currentPage()
                .getParameters()
                .get('reportId')
                .escapeHtml4()
        );

        pageSize = composeResourceUrl(
            apexpages.currentPage().getParameters().get('format').escapeHtml4()
        );
    }

    private ReportWrap retrieveReport(String reportId) {
        try {
            ReportConverterHandler handler = new ReportConverterHandler(
                reportId
            );
            ReportWrap report = handler.retrieveReport();
            if (report == null) {
                ApexPages.addMessage(
                    new ApexPages.Message(
                        ApexPages.Severity.ERROR,
                        System.Label.Error_To_Convert_Report
                    )
                );
            }
            return report;
        } catch (Exception e) {
            ApexPages.addMessage(
                new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage())
            );
        }
    }

    private String composeResourceUrl(String target) {
        String address =
            URL.getSalesforceBaseUrl().toExternalForm() +
            '' +
            PageReference.forResource('ReportConverterRecources').getUrl(); 
        if (!Test.isRunningTest()) {
            address = address.subString(0, address.indexOf('?'));
        }
        address += '/css/' + target + '.css';

        return address;
    }
}
