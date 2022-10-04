public with sharing class ReportConverterPage1Cntrl {
    public List<String> formats { get; set; }
    public String reportId { get; set; }
    public String format { get; set; }
    public Boolean isError;
    private ReportConverterSettings__mdt settings;

    public ReportConverterPage1Cntrl() {
        settings = ReportConverterSettings__mdt.getInstance('Page_Settings');
        formats = retrieveFormats(settings.Available_Formats__c);
        format = retrieveFormat(settings.Favourite_Format__c);
    }

    public String getFormat() {
        return 'A4_landscape';
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

    private List<String> retrieveFormats(String availableFormats) {
        List<String> result = new List<String>();
        for (String f : availableFormats.split(',')) {
            result.add(f.replaceAll(' ', ''));
        }
        return result;
    }

    private String retrieveFormat(String favouriteFormat) {
        return favouriteFormat != null
            ? favouriteFormat
            : formats[0] + '_landscape';
    }
}
