public with sharing class ReportConverterPage1Cntrl {
    public static String reportId {get; set;}

    public ReportConverterPage1Cntrl() {}

    public static PageReference goNext(){
        try {
            PageReference newPage = page.ReportToPDF;
            newPage.getParameters().put('reportId', reportId);
            newPage.setRedirect(true);
            return newPage;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
