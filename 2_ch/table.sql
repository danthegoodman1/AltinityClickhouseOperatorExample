-- only need to creat this table on one node, then can run `show tables` on another to see it's there
CREATE TABLE test_s3 ON CLUSTER replcluster
(
    `id` Int64
)
ENGINE = MergeTree
PARTITION BY intDiv(id, 100)
ORDER BY id
SETTINGS storage_policy = 's3'
