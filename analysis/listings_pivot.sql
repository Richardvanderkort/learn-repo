with listings as (
  select * from LEARN_ANALYTICS.DBT_JCOHEN.LISTINGS
),

pivoted as (

  select  neighbourhood,
          {%- for property_type in ['Apartment','House'] -%}

          sum(case when property_type = '{{property_type}}'
            then 1 else 0 end) as {{property_type}}__count{{- ',' if not loop.last -}}

          {% endfor %}

  from    listings
  group by 1
)

select * from pivoted
