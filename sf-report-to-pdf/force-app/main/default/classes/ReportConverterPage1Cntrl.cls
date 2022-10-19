public with sharing class ReportConverterPage1Cntrl {
    public List<String> formats { get; set; }
    public String reportId { get; set; }
    public String format { get; set; }
    public Boolean isError;
    private ReportConverterSettings__mdt settings;

    public ReportConverterPage1Cntrl() {
        settings = ReportConverterSettings__mdt.getInstance('Page_Settings');
        formats = ReportConverterUtils.retrieveFormats(settings.Available_Formats__c);
        format = ReportConverterUtils.retrieveFormat(formats, settings.Default_Format__c);
    }

    public Boolean getIsError() {
        return isError;
    }

    public PageReference goNext() {
        try {
            if (reportId instanceof Id) {
                PageReference newPage = page.ReportToPDF;
                newPage.getParameters().put('reportId', reportId);
                newPage.getParameters().put('format', format);
                newPage.setRedirect(true);
                return newPage;
            } else {
                isError = true;
                return null;
            }
        } catch (Exception e) {
            isError = true;
            throw new AuraHandledException(e.getMessage());
        }
    }
}