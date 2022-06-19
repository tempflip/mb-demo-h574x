import { LightningElement, wire, api } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import getConversationMessages from '@salesforce/apex/MessageBirdConversationController.getConversationMessages';
import sendMessage from '@salesforce/apex/MessageBirdConversationController.sendMessage';

export default class MessageBirdConverastionMessages extends LightningElement {
    @api conversationId;
    @api channelId;
    @api contactId;

    @wire(getConversationMessages, {conversationId : '$conversationId'}) conversation;

    get messageArray() {
        if (!this.conversation.data) return [];
        return [...this.conversation.data.items]
                    .reverse()
                    .map(el => ({...el, isInbound : el.direction === 'received'}))
                    ;
    }

    sendMessage(event) {
        const messageText = this.template.querySelector('.agentMessage').value;
        sendMessage({
                to  : this.contactId,
                xfrom : this.channelId,
                message : messageText
            }).then(r => {
                console.log('looks good!', r);
                this.template.querySelector('.agentMessage').value = null;
                refreshApex(this.conversation)
            }).catch(err => {
                console.log('st went wrong', err);
            })
    }
}