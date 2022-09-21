public with sharing class ReportConverterUtils {
    public static List<String> getColumnNames(
        Reports.ReportResults reportData
    ) {
        Reports.ReportExtendedMetadata rmd = reportData.getReportExtendedMetadata();
        Map<String, Reports.DetailColumn> colMap = rmd.getDetailColumnInfo();
        List<String> colNames = new List<String>();

        for (String key : colMap.KeySet()) {
            colNames.add(colMap.get(key).getLabel());
        }

        return colNames;
    }
}
