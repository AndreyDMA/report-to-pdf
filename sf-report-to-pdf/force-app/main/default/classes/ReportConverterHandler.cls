public with sharing class ReportConverterHandler {
    public static void retrieveReport(Id reportId) {
        Report rep = [
            SELECT Name, Description, Format
            FROM Report
            WHERE Id = :reportId
        ];
        ReportConverterHelper helper = new ReportConverterHelper(reportId);

        switch on rep.Format {
            when 'Tabular' {
                helper.runTabularReport();
            }
            when 'Summary' {
                helper.runSummaryReport();
            }
            when 'Matrix' {
                helper.runMatrixReport();
            }
            when 'Multiblock' {
                helper.runMultiblockReport();
            }
            when else {
                throw new AuraHandledException('Something went wrong');
            }
        }
    }
}
