public with sharing class ReportConverterHandler {
    private Report rep;

    public ReportConverterHandler(Id reportId) {
        this.rep = [
            SELECT Name, Description, Format
            FROM Report
            WHERE Id = :reportId
        ];
    }

    public ReportWrap retrieveReport() {
        switch on rep.Format {
            when 'Tabular' {
                return composeWrappedReport();
            }
            when else {
                return null;
            }
        }
    }

    private ReportWrap composeWrappedReport() {
        ReportWrap wrapped = new ReportWrap();
        wrapped.description = rep.description;
        wrapped.name = rep.Name;
        wrapped.data = ReportConverterHelper.readTabularReport(rep.Id);
        wrapped.columns = ReportConverterHelper.colNames;
        return wrapped;
    }
}
