with orders as (
    select
        sales_order_id,
        territory_id,
        line_total
    from {{ ref('brnz_sales_orders') }}
),

territory_metrics as (
    select
        territory_id,
        count(distinct sales_order_id) as total_orders,
        sum(line_total) as total_revenue
    from orders
    group by territory_id
),

territories as (
    select
        territory_id,
        territory_name
    from {{ ref('brnz_territories') }}
)

select
    m.territory_id,
    t.territory_name,
    m.total_orders,
    m.total_revenue,
    m.total_revenue / nullif(m.total_orders, 0)
        as avg_order_value
from territory_metrics m
left join territories t
    on m.territory_id = t.territory_id