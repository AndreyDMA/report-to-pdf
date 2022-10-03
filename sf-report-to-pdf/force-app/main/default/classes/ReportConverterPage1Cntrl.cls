public with sharing class ReportConverterPage1Cntrl {
    public String reportId { get; set; }
    public String format { get; set; }
    public Boolean isError;

    public ReportConverterPage1Cntrl() {
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
}
