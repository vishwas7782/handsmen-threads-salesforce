@isTest
public class OrderTriggerHandlerTest {

    @isTest
    static void testConfirmedStatus_Valid() {
        HandsMen_Order__c order = new HandsMen_Order__c(
            Status__c = 'Confirmed',
            Quantity__c = 600 // valid
        );
        insert order;
        System.assertEquals(600, order.Quantity__c);
    }

    @isTest
    static void testConfirmedStatus_Invalid() {
        HandsMen_Order__c order = new HandsMen_Order__c(
            Status__c = 'Confirmed',
            Quantity__c = 300 // invalid
        );

        Test.startTest();
        try {
            insert order;
            System.assert(false, 'Expected error for Confirmed status');
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('Confirmed'));
        }
        Test.stopTest();
    }

    @isTest
    static void testPendingStatus_Valid() {
        HandsMen_Order__c order = new HandsMen_Order__c(
            Status__c = 'Pending',
            Quantity__c = 300 // valid
        );
        insert order;
        System.assertEquals(300, order.Quantity__c);
    }

    @isTest
    static void testPendingStatus_Invalid() {
        HandsMen_Order__c order = new HandsMen_Order__c(
            Status__c = 'Pending',
            Quantity__c = 150 // invalid
        );

        Test.startTest();
        try {
            insert order;
            System.assert(false, 'Expected error for Pending status');
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('Pending'));
        }
        Test.stopTest();
    }

    @isTest
    static void testRejectionStatus_Valid() {
        HandsMen_Order__c order = new HandsMen_Order__c(
            Status__c = 'Rejection',
            Quantity__c = 0 // valid
        );
        insert order;
        System.assertEquals(0, order.Quantity__c);
    }

    @isTest
    static void testRejectionStatus_Invalid() {
        HandsMen_Order__c order = new HandsMen_Order__c(
            Status__c = 'Rejection',
            Quantity__c = 5 // invalid
        );

        Test.startTest();
        try {
            insert order;
            System.assert(false, 'Expected error for Rejection status');
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('Rejection'));
        }
        Test.stopTest();
    }

    @isTest
    static void testUpdateFlow() {
        HandsMen_Order__c order = new HandsMen_Order__c(
            Status__c = 'Pending',
            Quantity__c = 250
        );
        insert order;

        order.Status__c = 'Confirmed';
        order.Quantity__c = 550; // valid update
        update order;

        System.assertEquals('Confirmed', order.Status__c);
        System.assertEquals(550, order.Quantity__c);
    }
}