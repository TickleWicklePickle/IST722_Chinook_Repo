SELECT
    T.GENREID AS genreid,                       -- FK linking to the genre dimension
    G.NAME AS genrename,                       -- Name of the genre
    SUM(IL.UNITPRICE * IL.QUANTITY) AS total_order_amount, -- Total revenue per genre
    SUM(IL.QUANTITY) AS quantityoforder,       -- Total quantity purchased per genre
    I.INVOICEDATE AS purchase_date             -- Date of purchase
FROM raw.chinook.invoice I
JOIN raw.chinook.invoiceline IL ON I.INVOICEID = IL.INVOICEID
JOIN raw.chinook.track T ON IL.TRACKID = T.TRACKID
JOIN raw.chinook.genre G ON T.GENREID = G.GENREID
GROUP BY
    T.GENREID,
    G.NAME,
    I.INVOICEDATE
