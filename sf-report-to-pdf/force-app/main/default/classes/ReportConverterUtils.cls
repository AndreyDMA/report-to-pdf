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

    public static String composeResourceUrl(String target) {
        String address =
            URL.getSalesforceBaseUrl().toExternalForm() +
            '' +
            PageReference.forResource('ReportConverterRecources').getUrl(); 
        if (!Test.isRunningTest()) {
            address = address.subString(0, address.indexOf('?'));
        }
        address += '/css/' + target + '.css';

        return address;
    }

    
    public static List<String> retrieveFormats(String availableFormats) {
        List<String> result = new List<String>();
        for (String f : availableFormats.split(',')) {
            result.add(f.replaceAll(' ', ''));
        }
        return result;
    }

    public static String retrieveFormat(List<String> formats, String defaultFormat) {
        String result = formats[0] + '_landscape';

        if (defaultFormat == null) {
            return result;
        }

        List<String> parts = defaultFormat.split('_');
        if (
            parts.size() != 2 ||
            !formats.contains(parts[0]) ||
            (parts[1] != 'landscape' &&
            parts[1] != 'portrait')
        ) {
            return result;
        }

        return defaultFormat;
    }
}
