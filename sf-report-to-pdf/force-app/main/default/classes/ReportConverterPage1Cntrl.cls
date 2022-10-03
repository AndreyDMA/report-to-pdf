public with sharing class ReportConverterPage1Cntrl {
    public static String reportId {get; set;}
    public static String size {get; set;}

    public ReportConverterPage1Cntrl() {}

    public static PageReference goNext(){
        try {
            PageReference newPage = page.ReportToPDF;
            newPage.getParameters().put('reportId', reportId);
            newPage.getParameters().put('size', 'A3_landscape');
            newPage.setRedirect(true);
            return newPage;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}