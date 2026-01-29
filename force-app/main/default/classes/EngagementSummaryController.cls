public with sharing class EngagementSummaryController {

    @AuraEnabled
    public static void createFollowUpCall(Id engagementId) {
        Engagement__c eng = [
            SELECT Id, Name
            FROM Engagement__c
            WHERE Id = :engagementId
            LIMIT 1
        ];

        Task t = new Task(
            Subject = 'Follow-up on ' + eng.Name,
            ActivityDate = Date.today().addDays(1),
            Status = 'Not Started',
            Priority = 'High',
            TaskSubtype = 'Call',
            WhatId = engagementId
        );

        insert t;
    }


    @AuraEnabled(cacheable=true)
    public static EngagementSummaryData getSummary(Id engagementId) {

        Engagement__c eng = [
            SELECT Id, Name, Related_Opportunity__r.Amount
            FROM Engagement__c
            WHERE Id = :engagementId
            LIMIT 1
        ];

        Integer completedTasks = [
            SELECT COUNT()
            FROM Task
            WHERE WhatId = :engagementId
            AND Status = 'Completed'
        ];

        Integer upcomingEvents = [
            SELECT COUNT()
            FROM Event
            WHERE WhatId = :engagementId
            AND ActivityDate >= :Date.today()
        ];

        return new EngagementSummaryData(
            eng.Related_Opportunity__r != null ? eng.Related_Opportunity__r.Amount : null,
            completedTasks,
            upcomingEvents,
            eng.Name
        );
    }

    public class EngagementSummaryData {
        @AuraEnabled public Decimal opportunityAmount;
        @AuraEnabled public Integer completedTasks;
        @AuraEnabled public Integer upcomingEvents;
        @AuraEnabled public String engagementName;

        public EngagementSummaryData(
            Decimal opportunityAmount,
            Integer completedTasks,
            Integer upcomingEvents,
            String engagementName
        ) {
            this.opportunityAmount = opportunityAmount;
            this.completedTasks = completedTasks;
            this.upcomingEvents = upcomingEvents;
            this.engagementName = engagementName;
        }
    }
}
