select
    TerritoryID as territory_id,
    Name as territory_name
from {{ source('adventureworks', 'SalesTerritory') }}