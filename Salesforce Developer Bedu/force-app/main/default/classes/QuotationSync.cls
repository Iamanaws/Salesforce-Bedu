public interface QuotationSync {
    
    Boolean confirmProductExistByCode(String productCode);

    Integer searchProductByCode(String productCode);
}