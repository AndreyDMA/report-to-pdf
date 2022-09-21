public with sharing class ReportConverterController {
    @AuraEnabled(Cacheable=true)
    public static String retrieveReport(String reportId){
        try {
            return ReportConverterHandler.retrieveReport(reportId);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
