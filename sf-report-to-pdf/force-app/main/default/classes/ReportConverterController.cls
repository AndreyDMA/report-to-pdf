public with sharing class ReportConverterController {
    @AuraEnabled(Cacheable=true)
    public static ReportWrap retrieveReport(String reportId){
        try {
            ReportConverterHandler handler = new ReportConverterHandler(reportId);
            return handler.retrieveReport();
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
