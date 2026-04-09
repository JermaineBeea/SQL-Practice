SELECT
    id,
    date_purchase,
    customer_email,
    product_name,
    quantity_purchased,
    SUM(quantity_purchased) OVER (
        ORDER BY date_purchase, id
        ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
    ) AS running_total
FROM purchases
ORDER BY date_purchase, id;



'SELECT
    id,
    date_purchase,
    customer_email,
    product_name,
    quantity_purchased,
    SUM(quantity_purchased) OVER (
        ORDER BY date_purchase, id
        ROWS FOLLOWING UNBOUNDED
    ) AS running_total
FROM purchases
ORDER BY date_purchase, id;

❌ Why this is invalid
SQLROWS FOLLOWING UNBOUNDEDShow more lines
There are two problems here:


Wrong word order
SQL requires the keyword UNBOUNDED to come before FOLLOWING.


Incomplete frame definition
ROWS FOLLOWING UNBOUNDED does not specify where the frame starts.


Window frames must always define a start boundary and (optionally) an end boundary.

✅ Correct syntax for “everything after the current row”
If what you meant was:

“From the current row to the last row”

then the correct statement is:
SQLSELECT    id,    date_purchase,    customer_email,    product_name,    quantity_purchased,    SUM(quantity_purchased) OVER (        ORDER BY date_purchase, id        ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING    ) AS running_totalFROM purchasesORDER BY date_purchase, id;Show more lines

✅ What this actually computes (important!)
This is not a normal running total.
It is a reverse running total (also called a suffix sum).
Meaning in plain English
For each row:

Sum this row and all rows that come after it


✅ Example behavior
Given quantities:
5, 4, 4, 5, 2, 7

The results will be:
Row 1 → 5+4+4+5+2+7 = 27
Row 2 →   4+4+5+2+7 = 22
Row 3 →     4+5+2+7 = 18
Row 4 →       5+2+7 = 14
Row 5 →         2+7 = 9
Row 6 →           7 = 7

✅ Totals decrease as you move down
✅ Looks forward, not backward

✅ Compare all common patterns (this locks it in)

























GoalCorrect frameNormal running totalROWS UNBOUNDED PRECEDINGSliding window (last 3 rows)ROWS BETWEEN 2 PRECEDING AND CURRENT ROWForward-looking windowROWS BETWEEN CURRENT ROW AND 2 FOLLOWINGReverse running totalROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING

🚫 Invalid forms to remember
These are never valid:
SQLROWS PRECEDINGROWS FOLLOWINGROWS FOLLOWING UNBOUNDEDROWS BETWEEN CURRENT ROW AND 2 PRECEDINGShow more lines
SQL requires:

direction and
boundary and
correct ordering


✅ One‑sentence takeaway

UNBOUNDED is a boundary, PRECEDING/FOLLOWING is a direction — and window frames must be written from start → end.

You’re now reasoning about window frames exactly like the SQL engine does 👌
Provide your feedback on BizChat'