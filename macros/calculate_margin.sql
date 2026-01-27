{% macro calculate_margin(cost, price) %}
    (({{ price }} - {{ cost }}) / {{ price }}) * 100
{% endmacro %}