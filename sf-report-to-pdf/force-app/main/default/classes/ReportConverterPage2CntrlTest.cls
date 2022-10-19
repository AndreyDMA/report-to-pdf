@isTest
public with sharing class ReportConverterPage2CntrlTest {
    
    @isTest(SeeAllData=true)
    private static void retrieveReportSuccess() {
        Test.startTest();

        List<Report> reports = [
            SELECT Id, Name, Description
            FROM Report
            WHERE Name = 'Test Tabular Report' AND Format = 'Tabular'
            LIMIT 1
        ];
        Report rep = reports[0];

        PageReference pr = page.ReportToPDF;
        pr.getParameters().put('reportId', rep.Id);
        pr.getParameters().put('format', 'A4_landscape');

        Test.setCurrentPage(pr);

        ReportConverterPage2Cntrl controller = new ReportConverterPage2Cntrl();
        ReportWrap report = controller.report;

        Test.stopTest();

        System.assertEquals(false, report == null, 'Report was not retrieved');
    }

    @isTest(SeeAllData=true)
    private static void retrieveReportError() {
        Test.startTest();

        PageReference pr = page.ReportToPDF;
        pr.getParameters().put('reportId', 'incorrect ID');
        pr.getParameters().put('format', 'A4_landscape');

        Test.setCurrentPage(pr);

        Boolean hasError = false;

        try {
            ReportConverterPage2Cntrl controller = new ReportConverterPage2Cntrl();
        } catch (Exception e) {
            hasError = ApexPages.hasMessages(ApexPages.Severity.ERROR);
        }

        Test.stopTest();

        System.assertEquals(true, hasError, 'Error was not detected');
    }
}
