import { LightningElement, wire } from 'lwc';
import getConversation from '@salesforce/apex/MessageBirdConversationController.getConversation';

export default class MessageBirdConverastion extends LightningElement {
    conversationId = '22bcc0e502e04903935a419738660b18';
    @wire(getConversation, {conversationId : '$conversationId'}) conversation;

    get conv() {
        if (!this.conversation.data) return undefined;
        console.log('###', this.conversation.data);
        return JSON.stringify(this.conversation.data);
    }    
}