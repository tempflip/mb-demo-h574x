public with sharing class MessageBird {

    // Interface IItem {
    //     String id;
    // }

    abstract class Paginated {
        public Integer count;
        // public Integer limit;
        public Integer offset;
        public Integer totalCount;
        // public IItem[] items;
    }

    public class PaginatedConversations extends Paginated {
        @AuraEnabled public Conversation[] items;
    }

    public class PaginatedMessages extends Paginated {
        @AuraEnabled public Message[] items;
        @AuraEnabled public Channel[] channels;
    }

    public class Conversation {
        @AuraEnabled public String id;
        @AuraEnabled public String contactId;
        @AuraEnabled public MessageBirdContact contact;
        @AuraEnabled public DateTime createdDatetime;
        @AuraEnabled public DateTime updatedDatetime;
        @AuraEnabled public Channel[] channels;
    }

    public class Message {
        @AuraEnabled public String id;
        public String conversationId;                
        @AuraEnabled public String channelId;                
        @AuraEnabled public String direction;
        @AuraEnabled public String xfrom;
        @AuraEnabled public String to;
        public String type;
        @AuraEnabled public MessageContent content;

        public Message(String to, String xfrom, String text) {
            this.to = to;
            this.xfrom = xfrom;
            this.type = 'text';
            this.content = new MessageContent(text);
        }
    }

    public class MessageContent {
        @AuraEnabled public String text;

        public MessageContent(String text) {
            this.text = text;
        }
    }

    public class MessageResponse {
        public String id;
        public String status;
    }

    public class Channel {
        @AuraEnabled public String id;
    }

    public class MessageBirdContact {
        @AuraEnabled public String id;
        @AuraEnabled public String msisdn;
        @AuraEnabled public String displayName;
    }

}
