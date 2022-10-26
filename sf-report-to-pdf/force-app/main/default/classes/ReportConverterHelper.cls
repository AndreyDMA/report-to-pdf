public with sharing class ReportConverterHelper {
    public static List<String> colNames;

    public static List<List<String>> readTabularReport(Id reportId) {
        Reports.ReportResults repResult = Reports.ReportManager.runReport(reportId, true);
        colNames = ReportConverterUtils.getColumnNames(repResult);
        List<List<String>> report = new List<List<String>>();

        Map<String, Reports.ReportFact> factMap = repResult.getFactMap();

        for (String factMapKey : factMap.keySet()) {
            Reports.ReportFactWithDetails factDetails = (Reports.ReportFactWithDetails) factMap.get(
                factMapKey
            );
            Integer count = 1;
            for (Reports.ReportDetailRow detailRow : factDetails.getRows()) {
                List<String> row = new List<String>();
                row.add(String.valueOf(count));
                for (Reports.ReportDataCell elem : detailRow.getDataCells()) {
                    row.add(elem.getLabel());
                }
                count++;
                report.add(row);
            }
        }

        return report;
    }

    public static List<List<String>> readSummaryReport(Id reportId) {
        Reports.ReportResults repResult = Reports.ReportManager.runReport(reportId, true);
        colNames = ReportConverterUtils.getColumnNames(repResult);
        // Get the first down-grouping in the report
        Reports.Dimension dim = repResult.getGroupingsDown();
        Reports.GroupingValue groupingVal = dim.getGroupings()[0];
        System.debug('Key: ' + groupingVal.getKey());
        System.debug('Label: ' + groupingVal.getLabel());
        System.debug('Value: ' + groupingVal.getValue());

        // Construct a fact map key, using the grouping key value
        String factMapKey = groupingVal.getKey() + '!T';

        // Get the fact map from the report reportData
        Reports.ReportFactWithDetails factDetails = (Reports.ReportFactWithDetails) repResult.getFactMap()
            .get(factMapKey);

        // Get the first summary amount from the fact map
        Reports.SummaryValue sumVal = factDetails.getAggregates()[0];
        System.debug('Summary Value: ' + sumVal.getLabel());

        // Get the field value from the first data cell of the first row of the report
        Reports.ReportDetailRow detailRow = factDetails.getRows()[0];
        System.debug(
            'DataCell label: ' + detailRow.getDataCells()[0].getLabel()
        );
        return null;
    }
}