SELECT
  DATE(block_timestamp) AS day,
  COUNT(*) AS transactions
FROM `bigquery-public-data.crypto_bitcoin.transactions`
WHERE DATE(block_timestamp)
      BETWEEN '2026-01-01' AND '2026-05-31'
GROUP BY day
ORDER BY day