public with sharing class ReportConverterHelper {
    public List<String> colNames;
    Reports.ReportResults repResult;

    public ReportConverterHelper(Id reportId) {
        this.repResult = Reports.ReportManager.runReport(
            reportId,
            true
        );
        this.colNames = ReportConverterUtils.getColumnNames(repResult);
    }

    public List<List<String>> readTabularReport() {
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

    public Map<String, List<List<String>>> readSummaryReport() {
        Map<String, List<List<String>>> report = new Map<String, List<List<String>>>();
        readGroupings(repResult.getFactMap(), repResult.getGroupingsDown().getGroupings(), report);
        // Reports.Dimension dim = repResult.getGroupingsDown();
        // Map<String, Reports.ReportFact> factMap = repResult.getFactMap();
        // Reports.ReportFactWithDetails factDetails;
        // for (Reports.GroupingValue groupingVal : dim.getGroupings()) {
        //     factDetails = (Reports.ReportFactWithDetails) factMap.get(
        //         groupingVal.getKey() + '!T'
        //     );
        //     String groupingCell = groupingVal.getLabel() + ' (' + factDetails.getAggregates()[0].getLabel() + ')';
            
        //     List<List<String>> rows = new List<List<String>>();
        //     for (Reports.ReportDetailRow detailRow : factDetails.getRows()) {
        //         List<String> row = new List<String>();
        //         for (Reports.ReportDataCell data : detailRow.getDataCells()) {
        //             row.add(data.getLabel());
        //         }
        //         rows.add(row);
        //     }
        //     report.put(groupingCell, rows);

        //     for (Reports.GroupingValue grVal : groupingVal.getGroupings()) {
        //         System.debug('Key: ' + grVal.getKey());
        //         System.debug('Label: ' + grVal.getLabel());
        //         System.debug('Field: ' + grVal.getValue());
        //         factDetails = (Reports.ReportFactWithDetails) factMap.get(
        //             grVal.getKey() + '!T'
        //         );
        //         // Get the first summary amount from the fact map
        //         for (
        //             Reports.SummaryValue sumVal : factDetails.getAggregates()
        //         ) {
        //             System.debug('Summary Value: ' + sumVal.getLabel());
        //         }

        //         // Get the field value from the first data cell of the first row of the report
        //         for (
        //             Reports.ReportDetailRow detailRow : factDetails.getRows()
        //         ) {
        //             for (
        //                 Reports.ReportDataCell data : detailRow.getDataCells()
        //             ) {
        //                 System.debug('DataCell: ' + data.getLabel());
        //             }
        //         }
        //         for (Reports.GroupingValue gV : grVal.getGroupings()) {
        //             System.debug('Key: ' + gV.getKey());
        //             System.debug('Label: ' + gV.getLabel());
        //             System.debug('Field: ' + gV.getValue());
        //             factDetails = (Reports.ReportFactWithDetails) factMap.get(
        //                 gV.getKey() + '!T'
        //             );
        //             // Get the first summary amount from the fact map
        //             for (
        //                 Reports.SummaryValue sumVal : factDetails.getAggregates()
        //             ) {
        //                 System.debug('Summary Value: ' + sumVal.getLabel());
        //             }

        //             // Get the field value from the first data cell of the first row of the report
        //             for (
        //                 Reports.ReportDetailRow detailRow : factDetails.getRows()
        //             ) {
        //                 for (
        //                     Reports.ReportDataCell data : detailRow.getDataCells()
        //                 ) {
        //                     System.debug('DataCell: ' + data.getLabel());
        //                 }
        //             }
        //         }
        //     }
        // }

        return report;
    }

    private void readGroupings(Map<String, Reports.ReportFact> factMap, List<Reports.GroupingValue> groupings, Map<String, List<List<String>>> report) {
        if (groupings.isEmpty()) {
            return;
        }
        Reports.ReportFactWithDetails factDetails;
        for (Reports.GroupingValue groupingVal : groupings) {
            factDetails = (Reports.ReportFactWithDetails) factMap.get(
                groupingVal.getKey() + '!T'
            );
            String groupingCell = groupingVal.getLabel() + ' (' + factDetails.getAggregates()[0].getLabel() + ')';
            
            List<List<String>> rows = new List<List<String>>();
            for (Reports.ReportDetailRow detailRow : factDetails.getRows()) {
                List<String> row = new List<String>();
                for (Reports.ReportDataCell data : detailRow.getDataCells()) {
                    row.add(data.getLabel());
                }
                rows.add(row);
            }
            report.put(groupingCell, rows);
            readGroupings(factMap, groupingVal.getGroupings(), report);
        }
    }
}
