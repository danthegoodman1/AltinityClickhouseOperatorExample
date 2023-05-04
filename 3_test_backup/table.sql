CREATE TABLE test_s3
(
    `id` Int64
)
ENGINE = MergeTree
PARTITION BY intDiv(id, 100)
ORDER BY id
SETTINGS storage_policy = 's3'


insert into test_s3 values (1), (2), (3)
