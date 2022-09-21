public with sharing class ReportWrap {
    @AuraEnabled
    public String description { get; set; }

    @AuraEnabled
    public String data { get; set; }

}
