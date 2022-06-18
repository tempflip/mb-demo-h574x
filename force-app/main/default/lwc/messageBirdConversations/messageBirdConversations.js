import { LightningElement, wire } from 'lwc';
import xgetConversations from '@salesforce/apex/MessageBirdConversationController.xgetConversations';

export default class MessageBirdConversations extends LightningElement {
    @wire(xgetConversations) conversations;

    conversationId;
    channelId;
    contactId;

    get conversationList() {
        console.log('####', this.conversations);
        if (!this.conversations.data) return [];
        return this.conversations.data.items;
    }
    
    get conversationSelected() {
        return !!this.conversationId;
    }

    onConversationSelectClick(ev) {
        this.conversationId = ev.target.value;
        const myConversation = this.conversationList.find(el => el.id);
        console.log('@@@@', myConversation);
        this.contactId = myConversation.contact.id;
        this.channelId = myConversation.channels[0].id;
        console.log('### ', this.conversationId, this.contactId, this.channelId);
    }

    onBackClick(ev) {
        this.conversationId = undefined;
        this.contactId = undefined;
        this.channelId = undefined;
    }
}