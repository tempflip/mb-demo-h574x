import { LightningElement, wire, api } from 'lwc';
import getConversationMessages from '@salesforce/apex/MessageBirdConversationController.getConversationMessages';
import sendMessage from '@salesforce/apex/MessageBirdConversationController.sendMessage';

export default class MessageBirdConverastionMessages extends LightningElement {
    @api conversationId; // = '22bcc0e502e04903935a419738660b18';
    @api channelId;
    @api contactId;

    @wire(getConversationMessages, {conversationId : '$conversationId'}) conversation;

    get messageArray() {
        if (!this.conversation.data) return [];
        console.log(';;;', this.conversation.data);
        return [...this.conversation.data.items]
                    .reverse()
                    .map(el => ({...el, isInbound : el.direction === 'received'}))
                    ;
    }

    sendMessage(event) {
        console.log('##');
        const messageText = this.template.querySelector('.agentMessage').value;
        sendMessage({
                to  : this.contactId,
                xfrom : this.channelId,
                message : messageText
            }).then(r => {
                console.log('looks good!', r);
                this.template.querySelector('.agentMessage').value = null;
            }).catch(err => {
                console.log('st went wrong', err);
            })
    }
}