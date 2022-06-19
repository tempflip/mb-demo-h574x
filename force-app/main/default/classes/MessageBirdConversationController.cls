public with sharing class MessageBirdConversationController {
    
    @AuraEnabled(cacheable=true)
    public static MessageBird.PaginatedConversations xgetConversations() {
        // system.assert(false, 'baaa');
        return MessageBirdService.getConversations();
        // return new MessageBird.PaginatedConversations();
    }

    @AuraEnabled(cacheable=true)
    public static MessageBird.PaginatedMessages getConversationMessages(String conversationId) {
        return MessageBirdService.getConversationMessages(conversationId);
    }


    @AuraEnabled
    public static MessageBird.Conversation archiveConversation(String conversationId) {
        return MessageBirdService.archiveConversation(conversationId);
    }

    @AuraEnabled
    public static MessageBird.MessageResponse sendMessage(String to, String xfrom, String message) {
        return MessageBirdService.sendMessage(new MessageBird.Message(to, xfrom, message));
    }

    @AuraEnabled
    public static MessageBird.Conversation startConversation(String to, String xfrom, String message) {
        return MessageBirdService.startConversation(new MessageBird.Message(to, xfrom, message));
    }
    
}
