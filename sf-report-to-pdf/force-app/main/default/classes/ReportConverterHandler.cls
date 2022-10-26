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
                return composeWrappedReport(ReportConverterHelper.readTabularReport(rep.Id));
            }
            when 'Summary' {
                return composeWrappedReport(ReportConverterHelper.readSummaryReport(rep.Id));
            }
            when else {
                return null;
            }
        }
    }

    private ReportWrap composeWrappedReport(List<List<String>> repData) {
        ReportWrap wrapped = new ReportWrap();
        wrapped.description = rep.description;
        wrapped.name = rep.Name;
        wrapped.data = repData;
        wrapped.columns = ReportConverterHelper.colNames;
        wrapped.type = rep.Format;
        return wrapped;
    }
}
