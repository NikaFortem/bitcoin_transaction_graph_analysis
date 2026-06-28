SELECT
  input.spent_transaction_hash AS source_tx,
  t.hash AS target_tx,
  t.block_timestamp,
  DATE(t.block_timestamp) AS tx_date,
  t.input_count,
  t.output_count,
  t.input_value,
  t.output_value,
  t.fee,
  t.size,
  t.virtual_size,
  input.value AS input_value_edge
FROM `bigquery-public-data.crypto_bitcoin.transactions` AS t,
UNNEST(t.inputs) AS input
WHERE t.block_timestamp_month = DATE '2026-03-01'
  AND DATE(t.block_timestamp) BETWEEN DATE '2026-03-09' AND DATE '2026-03-15'
  AND input.spent_transaction_hash IS NOT NULL
  AND t.is_coinbase IS FALSE
QUALIFY ROW_NUMBER() OVER (
  ORDER BY FARM_FINGERPRINT(t.hash)
) <= 500000;