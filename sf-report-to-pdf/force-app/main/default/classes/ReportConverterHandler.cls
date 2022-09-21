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
                return composeWrappedReport(helper.readTabularReport());
            }
            when 'Summary' {
                return composeWrappedReport(helper.readSummaryReport());
            }
            when 'Matrix' {
                return composeWrappedReport(helper.readMatrixReport());
            }
            when 'Multiblock' {
                return composeWrappedReport(helper.readMultiblockReport());
            }
            when else {
                throw new AuraHandledException('Something went wrong');
            }
        }
    }

    private ReportWrap composeWrappedReport(String repData) {
        ReportWrap wrapped = new ReportWrap();
        wrapped.description = JSON.serialize(
            new Map<String, String>{
                'name' => rep.Name,
                'description' => rep.description
            }
        );
        wrapped.data = repData;
        return wrapped;
    }
}
