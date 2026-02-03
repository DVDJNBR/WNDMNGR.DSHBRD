# Wind Manager Dashboard

## Connection Status

```sql tables
SELECT * FROM information_schema.tables 
WHERE table_schema = 'public'
LIMIT 5
```

<DataTable data={tables} />
