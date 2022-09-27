public with sharing class ReportConverterHandler {
    private Report rep;
    private ReportConverterHelper helper;

    public ReportConverterHandler(Id reportId) {
        this.rep = [
            SELECT Name, Description, Format
            FROM Report
            WHERE Id = :reportId
        ];
        this.helper = new ReportConverterHelper(reportId);
    }

    public ReportWrap retrieveReport() {
        switch on rep.Format {
            when 'Tabular' {
                return composeWrappedReport(helper.repData);
            }
           
            when else {
                throw new AuraHandledException('Something went wrong');
            }
        }
    }

    private ReportWrap composeWrappedReport(List<List<String>> repData) {
        ReportWrap wrapped = new ReportWrap();
        wrapped.description = rep.description;
        wrapped.name = rep.Name;
        wrapped.data = repData;
        wrapped.columns = helper.colNames;
        return wrapped;
    }
}
