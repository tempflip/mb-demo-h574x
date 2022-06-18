public with sharing class HttpHelper {
    private static String APIKey;
    
    public class HttpHelperException extends Exception {}

    public static String HttpGET(String endpoint) {
        return HttpReq(endpoint, 'GET', null);
    }

    public static String HttpPOST(String endpoint, String body) {
        return HttpReq(endpoint, 'POST', body);
    }

    private static String HttpReq(String endpoint, String method, String body) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod(method);
        request.setHeader('Authorization', 'AccessKey ' + getAPIKey());
        if (body != null) {
            request.setBody(body);
        }
        HttpResponse response = http.send(request);
        system.debug('#############################' + response.getStatusCode());
        system.debug('#############################' + response.getBody());
        if (response.getStatusCode() == 200) {
            return response.getBody();
        }
        throw new HttpHelperException('HTTP error: ' + response.getStatusCode() + ' |||| ' + response.getBody());
    }

    private static String getAPIKey() {
        if (APIKey == null) {
            MessageBird_API_Creds__c[] creds = [SELECT API_Key__c
                                                FROM MessageBird_API_Creds__c
                                                LIMIT 1];
            if (creds.size() != 1) throw new HttpHelperException('you have no API keys');
            APIKey = creds[0].API_Key__c;
        }
        return APIKey;

    }
}
