SELECT
    INVOICELINEID AS invoicelineid,  -- Line item on an invoice
    INVOICEID AS invoiceid,          -- FK from invoice table
    TRACKID AS trackid,              -- FK from track table
    UNITPRICE AS unitprice,          -- Price of the line item
    QUANTITY AS quantity             -- Quantity of items
FROM raw.chinook.invoiceline
