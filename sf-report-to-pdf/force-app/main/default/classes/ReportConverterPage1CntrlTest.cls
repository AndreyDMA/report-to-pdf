@isTest
public with sharing class ReportConverterPage1CntrlTest {
    @isTest(SeeAllData=true)
    private static void redirectToNextPageSuccess() {
        Test.startTest();

        List<Report> reports = [
            SELECT Id, Name, Description
            FROM Report
            WHERE Name = 'Test Tabular Report' AND Format = 'Tabular'
            LIMIT 1
        ];
        Report rep = reports[0];

        PageReference pr1 = Page.ReportToPDF_settings;

        Test.setCurrentPage(pr1);

        ReportConverterPage1Cntrl controller = new ReportConverterPage1Cntrl();
        controller.reportId = rep.Id;

        PageReference pr2 = controller.goNext();

        Test.stopTest();

        System.assertEquals(
            false,
            pr1.getUrl() == pr2.getUrl(),
            'User was not redirected to the next page'
        );
        System.assertEquals(
            true,
            pr2.getUrl().contains(rep.Id),
            'Report ID was not transfered to the next page controller'
        );
        System.assertEquals(
            true,
            pr2.getUrl().contains('_landscape') ||
            pr2.getUrl().contains('_portrait'),
            'Page format was not transfered to the next page controller'
        );
    }

    @isTest
    private static void redirectToNextPageError() {
        Test.startTest();

        PageReference pr1 = Page.ReportToPDF_settings;

        Test.setCurrentPage(pr1);

        ReportConverterPage1Cntrl controller = new ReportConverterPage1Cntrl();
        controller.reportId = 'bad ID';

        PageReference pr2 = controller.goNext();
        Boolean isError = controller.getIsError();

        Test.stopTest();
        
        System.assertEquals(
            null,
            pr2,
            'Error was not thrown'
        );
        System.assertEquals(
            true,
            isError,
            'isError field is not written'
        );
    }
}
