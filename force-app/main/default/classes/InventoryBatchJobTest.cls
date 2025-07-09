@isTest
public class InventoryBatchJobTest {

    @testSetup
    static void setupTestData() {
        List<HandsMen_Product__c> products = new List<HandsMen_Product__c>();

        for (Integer i = 0; i < 5; i++) {
            products.add(new HandsMen_Product__c(
                Name = 'Test Product ' + i,
                Stock_Quantity__c = 5  // Below threshold to trigger update
            ));
        }

        insert products;
    }

    @isTest
    static void testBatchExecution() {
        InventoryBatchJob batch = new InventoryBatchJob();

        // Run the batch with small scope for test
        Test.startTest();
        Database.executeBatch(batch, 2);
        Test.stopTest();

        // Assert that stock quantity increased
        List<HandsMen_Product__c> updatedProducts = [
            SELECT Stock_Quantity__c FROM HandsMen_Product__c
        ];
        for (HandsMen_Product__c prod : updatedProducts) {
            System.assert(prod.Stock_Quantity__c >= 55, 'Product not updated properly.');
        }
    }

    @isTest
    static void testScheduledJob() {
        Test.startTest();

        String cronExp = '0 0 0 15 8 ? 2025'; // August 15, 2025, 12:00 AM
        System.schedule('Test Scheduled Inventory Job', cronExp, new InventoryBatchJob());

        Test.stopTest();
    }
}