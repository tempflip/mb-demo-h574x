public with sharing class MessageBirdService {

    private static String baseURL = 'https://conversations.messagebird.com/v1';

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

    private static String xfrom_to_from(String s) {
        return s.replaceAll('"xfrom"', '"from"');
    }

    private static String from_to_xfrom(String s) {
        return s.replaceAll('"from"', '"xfrom"');
    }
    
}
