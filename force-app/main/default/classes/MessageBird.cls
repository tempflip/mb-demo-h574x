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
        Conversation[] items;
    }

    public class PaginatedMessages extends Paginated {
        Message[] items;
    }

    public class Conversation {
        public String id;
        public String contactId;
    }

    public class Message {
        public String id;
        public String conversationId;                
        public String channelId;                
        public String direction;
        public String xfrom;
        public String to;
        public String type;
        public MessageContent content;

        public Message(String to, String xfrom, String text) {
            this.to = to;
            this.xfrom = xfrom;
            this.type = 'text';
            this.content = new MessageContent(text);
        }
    }

    public class MessageContent {
        public String text;

        public MessageContent(String text) {
            this.text = text;
        }
    }

    public class MessageResponse {
        public String id;
        public String status;
    }

}
