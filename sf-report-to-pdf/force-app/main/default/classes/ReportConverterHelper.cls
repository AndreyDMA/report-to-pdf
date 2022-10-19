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
}