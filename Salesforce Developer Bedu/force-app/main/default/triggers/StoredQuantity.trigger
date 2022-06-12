trigger StoredQuantity on QuoteLineItem (after insert) {
	
    List<ID> QLI_productID = new List<ID>();
    List<Double> QLI_quantity = new List<Double>();
    
    for(QuoteLineItem item: Trigger.New) {        
        QLI_productID.add(item.Product2Id);
        QLI_quantity.add(item.Quantity);
    }
    
    QuotationHelper QH = new QuotationHelper();
    
    QH.updateReservedQuantity(QLI_productID, QLI_quantity);
}