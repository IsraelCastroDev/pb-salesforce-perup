import { LightningElement, api, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getSummary from '@salesforce/apex/EngagementSummaryController.getSummary';
import createFollowUpCall from '@salesforce/apex/EngagementSummaryController.createFollowUpCall';
import { createRecord } from 'lightning/uiRecordApi';

export default class EngagementSummary extends LightningElement {
  @api recordId;

  summary;
  error;

  @wire(getSummary, { engagementId: '$recordId' })
  wiredSummary({ data, error }) {
    if (data) {
      this.summary = data;
      this.error = undefined;
    } else if (error) {
      this.error = error;
      this.summary = undefined;
    }
  }

  handleQuickCall() {
    createFollowUpCall({ engagementId: this.recordId })
      .then(() => {
        this.dispatchEvent(
          new ShowToastEvent({
            title: 'Success',
            message: 'Follow-up call task created',
            variant: 'success'
          })
        );
      })
      .catch(error => {
        this.dispatchEvent(
          new ShowToastEvent({
            title: 'Error',
            message: error.body.message,
            variant: 'error'
          })
        );
      });
  }  
  
}
