/*  Allows you to filter and select specific values within a window
    where the unique identifier you're using (IE object ID) would
    potentially appear more than once and you just need the row
    with the MIN or MAX value of a certain attribute
*/

WITH ranked_data AS (
    SELECT
        table_name.*,
        ROW_NUMBER() OVER (
            /* Row number 1 is the newest record based on date_created */
            PARTITION BY object_id ORDER BY table_name.date_created DESC
        ) AS rn
      FROM table_name
    )

SELECT
    *
FROM
    ranked_data
WHERE
    ranked_data.rn = 1
