

{% snapshot report_classifications_snapshot %}
    select * from {{ ref('report_classifications') }}
{% endsnapshot %}