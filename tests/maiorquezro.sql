select
    customer_id,
    from {{ ref('stg_customers' )}}
where quantity < 0