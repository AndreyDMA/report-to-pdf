public with sharing class ReportWrap {
    @AuraEnabled
    public List<String> columns { get; set; }
    
    @AuraEnabled
    public List<List<String>> data { get; set; }
    
    @AuraEnabled
    public String description { get; set; }

    @AuraEnabled
    public String name { get; set; }

    @AuraEnabled
    public String type { get; set; }
}