public with sharing class ReportConverterPage2Cntrl {
    public String reportId {get; set;}
    public ReportWrap report {get; set;}
    public Integer count;

    public ReportConverterPage2Cntrl() {
        reportId = apexpages.currentPage().getParameters().get('reportId').escapeHtml4();
        report = retrieveReport(reportId);
        count = 0;
    }

    private ReportWrap retrieveReport(String reportId){
        try {
            ReportConverterHandler handler = new ReportConverterHandler(reportId);
            return handler.retrieveReport();
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    public Integer getCount() {
        count++;
        return count;
    }
}
