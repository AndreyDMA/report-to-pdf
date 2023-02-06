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
        ReportConverterHelper helper = new ReportConverterHelper(rep.Id);
        ReportWrap rw = composeWrappedReport(helper.colNames);

        switch on rep.Format {
            when 'Tabular' {
                rw.data = helper.readTabularReport();
                return rw;
            }
            when 'Summary' {
                rw.sumData = helper.readSummaryReport();
                return rw;
            }
            when else {
                return null;
            }
        }
    }

    private ReportWrap composeWrappedReport(List<String> colNames) {
        ReportWrap wrapped = new ReportWrap();
        wrapped.description = rep.description;
        wrapped.name = rep.Name;
        wrapped.columns = colNames;
        wrapped.type = rep.Format;
        return wrapped;
    }
}
