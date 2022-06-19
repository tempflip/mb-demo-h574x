import { LightningElement, wire } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import xgetConversations from '@salesforce/apex/MessageBirdConversationController.xgetConversations';
import archiveConversation from '@salesforce/apex/MessageBirdConversationController.archiveConversation';
import startConversation from '@salesforce/apex/MessageBirdConversationController.startConversation';

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
        this.reset();
    }

    onArchiveClick(ev) {
        archiveConversation({conversationId : this.conversationId})
            .then(r => {
                this.reset();
                // looks like the api is slow, add some timing
                setTimeout(() => {refreshApex(this.conversations)}, 3000);
            })
            .catch(err => {
                console.log('st went wrong...', err);
            })
    }
    
    onStartClick(ev) {
        const phone = this.template.querySelector('.phone').value;
        const message = this.template.querySelector('.message').value;
        const channelId = this.template.querySelector('.channel').value;

        startConversation({
            to : phone,
            xfrom : channelId,
            message : message
        }).then(r => {
            console.log('started', r);
            refreshApex(this.conversations);
            this.reset();
            this.conversationId = r.id;
        })
        .catch(err => {
            console.log('st went wrong...', err);
        })
    
    }

    reset() {
        this.conversationId = undefined;
        this.contactId = undefined;
        this.channelId = undefined;
        this.template.querySelector('.message').value = '';
        this.template.querySelector('.phone').value = '';
 
        refreshApex(this.conversations);
    }
}