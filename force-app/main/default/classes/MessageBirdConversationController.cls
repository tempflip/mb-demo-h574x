public with sharing class MessageBirdConversationController {
    @AuraEnabled(cacheable=true)
    public static MessageBird.PaginatedMessages getConversation(String conversationId) {
        return MessageBirdService.getConversationMessages(conversationId);
    }

    
}
