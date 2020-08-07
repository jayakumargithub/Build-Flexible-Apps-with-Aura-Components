public   class MyPropertyController {
    @AuraEnabled  
    public static List<Property__c> getSimilarProperties (Id recordId, String searchCriteria, Decimal beds, Decimal price, Decimal priceRange ) {
        if (searchCriteria == 'Bedrooms') {
            system.debug('searchCriteria 1 ' + searchCriteria);
            return [
                SELECT Id, Name, Beds__c, Baths__c, Price__c, Broker__c, Status__c, Thumbnail__c
                FROM Property__c WHERE Id != :recordId AND Beds__c = :beds
            ];
        } else {
            system.debug('searchCriteria 2 ' + searchCriteria);
            Decimal range;
            if (priceRange == null) {
                range = 100000;
            } else {
                range = priceRange;
            }
            return [
                SELECT Id, Name, Beds__c, Baths__c, Price__c, Broker__c, Status__c, Thumbnail__c
                FROM Property__c WHERE Id != :recordId AND Price__c > :price - range AND Price__c < :price + range
            ];
        }
    }}