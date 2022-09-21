public with sharing class ReportConverterHelper {
    private Reports.reportResults results;

    public ReportConverterHelper(Id reportId) {
        this.results = Reports.ReportManager.runReport(reportId, true);
    }

    public void runTabularReport() {
    }

    public void runSummaryReport() {
        // Get the first down-grouping in the report
        Reports.Dimension dim = results.getGroupingsDown();
        Reports.GroupingValue groupingVal = dim.getGroupings()[0];
        System.debug('Key: ' + groupingVal.getKey());
        System.debug('Label: ' + groupingVal.getLabel());
        System.debug('Value: ' + groupingVal.getValue());

        // Construct a fact map key, using the grouping key value
        String factMapKey = groupingVal.getKey() + '!T';

        // Get the fact map from the report results
        Reports.ReportFactWithDetails factDetails = (Reports.ReportFactWithDetails) results.getFactMap()
            .get(factMapKey);

        // Get the first summary amount from the fact map
        Reports.SummaryValue sumVal = factDetails.getAggregates()[0];
        System.debug('Summary Value: ' + sumVal.getLabel());

        // Get the field value from the first data cell of the first row of the report
        Reports.ReportDetailRow detailRow = factDetails.getRows()[0];
        System.debug(
            'DataCell label: ' + detailRow.getDataCells()[0].getLabel()
        );
    }

    public void runMatrixReport() {
    }

    public void runMultiblockReport() {
    }
}
