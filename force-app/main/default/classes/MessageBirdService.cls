public with sharing class MessageBirdService {

    private static String baseURL = 'https://conversations.messagebird.com/v1';

    public static MessageBird.PaginatedConversations getConversations() {
        return (MessageBird.PaginatedConversations) JSON.deserialize(
            from_to_xfrom(
                HttpHelper.HttpGET(baseURL + '/conversations')
            ),
            MessageBird.PaginatedConversations.class
        );
    }

    public static MessageBird.PaginatedMessages getConversationMessages(String conversationId) {
        return (MessageBird.PaginatedMessages) JSON.deserialize(
            from_to_xfrom(
                HttpHelper.HttpGET(baseURL + '/conversations/' + conversationId + '/messages')
            ),
            MessageBird.PaginatedMessages.class
        );
    }

    public static MessageBird.MessageResponse sendMessage(MessageBird.Message payload) {
        return (MessageBird.MessageResponse) JSON.deserialize(
            HttpHelper.HttpPOST(baseURL + '/send', xfrom_to_from(JSON.serialize(payload))),
            MessageBird.MessageResponse.class
        );
    }

    public static MessageBird.Conversation startConversation(MessageBird.Message payload) {
        payload.channelId = payload.xfrom;
        payload.xfrom = null;
        return (MessageBird.Conversation) JSON.deserialize(
            HttpHelper.HttpPOST(baseURL + '/conversations/start', xfrom_to_from(JSON.serialize(payload))),
            MessageBird.Conversation.class
        );
    }

    public static MessageBird.Conversation archiveConversation(String conversationId) {
        Map<String, String> payload = new Map<String, String>{'status' => 'archived'};
        return (MessageBird.Conversation) JSON.deserialize(
            HttpHelper.HttpPATCH(baseURL + '/conversations/' + conversationId, xfrom_to_from(JSON.serialize(payload))),
            MessageBird.Conversation.class
        );
    }

    private static String xfrom_to_from(String s) {
        return s.replaceAll('"xfrom"', '"from"');
    }

    private static String from_to_xfrom(String s) {
        return s.replaceAll('"from"', '"xfrom"');
    }

    
}
