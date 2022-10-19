public with sharing class ReportConverterHelper {
    private Reports.ReportResults reportData;
    public List<String> colNames;
    public List<List<String>> repData;

    public ReportConverterHelper(Id reportId) {
        this.reportData = Reports.ReportManager.runReport(reportId, true);
        this.colNames = ReportConverterUtils.getColumnNames(reportData);
        this.repData = readTabularReport();
    }

    private List<List<String>> readTabularReport() {
        List<List<String>> report = new List<List<String>>();

        Map<String, Reports.ReportFact> factMap = reportData.getFactMap();

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
