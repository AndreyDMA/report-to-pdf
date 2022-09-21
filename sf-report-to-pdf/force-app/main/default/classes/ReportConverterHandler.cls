public with sharing class ReportConverterHandler {
    public static String retrieveReport(Id reportId) {
        Report rep = [
            SELECT Name, Description, Format
            FROM Report
            WHERE Id = :reportId
        ];
        ReportConverterHelper helper = new ReportConverterHelper(reportId);
        String result;
        switch on rep.Format {
            when 'Tabular' {
                return helper.readTabularReport();
            }
            when 'Summary' {
                return helper.readSummaryReport();
            }
            when 'Matrix' {
                return helper.readMatrixReport();
            }
            when 'Multiblock' {
                return helper.readMultiblockReport();
            }
            when else {
                throw new AuraHandledException('Something went wrong');
            }
        }
    }
}
