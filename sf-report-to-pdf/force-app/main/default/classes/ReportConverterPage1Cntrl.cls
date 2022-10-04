public with sharing class ReportConverterPage1Cntrl {
    public List<String> formats { get; set; }
    public String reportId { get; set; }
    public String format { get; set; }
    public Boolean isError;
    private ReportConverterSettings__mdt settings;

    public ReportConverterPage1Cntrl() {
        settings = ReportConverterSettings__mdt.getInstance('Page_Settings');
        formats = retrieveFormats(settings.Available_Formats__c);
        format = retrieveFormat(settings.Default_Format__c);
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

    private String retrieveFormat(String defaultFormat) {
        String result = formats[0] + '_landscape';

        if (defaultFormat == null) {
            return result;
        }

        List<String> parts = defaultFormat.split('_');
        if (
            parts.size() != 2 ||
            !formats.contains(parts[0]) ||
            (parts[1] != 'landscape' &&
            parts[1] != 'portrait')
        ) {
            return result;
        }

        return defaultFormat;
    }
}
