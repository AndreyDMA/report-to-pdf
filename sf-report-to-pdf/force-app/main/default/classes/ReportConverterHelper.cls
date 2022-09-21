public with sharing class ReportConverterHelper {
    private Reports.ReportResults reportData;

    public ReportConverterHelper(Id reportId) {
        this.reportData = Reports.ReportManager.runReport(reportId, true);
    }

    public String readTabularReport() {
        List<Map<String, String>> report = new List<Map<String, String>>();
        List<String> colNames = ReportConverterUtils.getColumnNames(reportData);

        Map<String, Reports.ReportFact> factMap = reportData.getFactMap();

        for (String factMapKey : factMap.keySet()) {
            Reports.ReportFactWithDetails factDetails = (Reports.ReportFactWithDetails) factMap.get(
                factMapKey
            );
            Map<String, String> row = new Map<String, String>();
            for (Reports.ReportDetailRow detailRow : factDetails.getRows()) {
                for (Integer i = 0; i < colNames.size(); i++) {
                    row.put(colNames[i], detailRow.getDataCells()[i].getLabel());
                }
            }
            report.add(row);
        }

        return JSON.serialize(report);
    }

    public String readSummaryReport() {
        // Get the first down-grouping in the report
        Reports.Dimension dim = reportData.getGroupingsDown();
        Reports.GroupingValue groupingVal = dim.getGroupings()[0];
        System.debug('Key: ' + groupingVal.getKey());
        System.debug('Label: ' + groupingVal.getLabel());
        System.debug('Value: ' + groupingVal.getValue());

        // Construct a fact map key, using the grouping key value
        String factMapKey = groupingVal.getKey() + '!T';

        // Get the fact map from the report reportData
        Reports.ReportFactWithDetails factDetails = (Reports.ReportFactWithDetails) reportData.getFactMap()
            .get(factMapKey);

        // Get the first summary amount from the fact map
        Reports.SummaryValue sumVal = factDetails.getAggregates()[0];
        System.debug('Summary Value: ' + sumVal.getLabel());

        // Get the field value from the first data cell of the first row of the report
        Reports.ReportDetailRow detailRow = factDetails.getRows()[0];
        System.debug(
            'DataCell label: ' + detailRow.getDataCells()[0].getLabel()
        );
        return '';
    }

    public String readMatrixReport() {
        return '';
    }

    public String readMultiblockReport() {
        return '';
    }
}
