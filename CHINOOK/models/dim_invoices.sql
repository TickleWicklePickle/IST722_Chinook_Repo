
with stg_invoice as (
    select * from {{ source('chinook','invoice')}}
)
select  {{ dbt_utils.generate_surrogate_key(['stg_invoice.invoiceid']) }} as invoicekey, 
    stg_invoice.* 
from stg_invoice

