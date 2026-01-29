# Salesforce Engagement Assignment

## Overview
This project implements Engagement management features in Salesforce, including list views, automation, reporting, and a custom Lightning Web Component.

## Assumptions
- Engagement is a custom object related to Account, Contact, and Opportunity.
- Activities (Tasks and Events) are related to Engagement.
- Task creation is handled via Apex for compatibility.

## How to Test

### List Views
- Navigate to Engagements
- Open "My Open Engagements"
- Verify list view chart

### Flow Automation
- Update an Opportunity Stage to Negotiation/Review
- Ensure Related Engagement is populated
- Verify Task creation

### LWC + Apex
- Open an Engagement record
- Verify Opportunity Amount and activity counts
- Click "Quick Follow-Up Call"
- Confirm Task creation in Activities

### Reporting
- Open report "Engagement Pipeline"
- Verify columns and chart

## Code References
- LWC: force-app/main/default/lwc/engagementSummary
- Apex: force-app/main/default/classes/EngagementSummaryController.cls

## Reports & List Views
- Report: Engagement Pipeline
- List Views:
  - My Open Engagements
  - Q Engagements by Account
