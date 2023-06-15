# Altinity Clickhouse S3 disk on k8s example

Tested with DOKS, change the storage class for different providers as needed.

You need to have decent sized disks for ZK and CH so that there is plenty of space for metadata as well. This is a decent sized example but something north of 100GB might be good for long-term.

See for resizable:
https://github.com/Altinity/clickhouse-operator/blob/master/docs/chi-examples/03-persistent-volume-05-resizeable-volume-1.yaml
https://github.com/Altinity/clickhouse-operator/blob/master/docs/chi-examples/03-persistent-volume-05-resizeable-volume-2.yaml


See for backing up S3 tables without replicating data (just copying the metadata): https://blog.danthegoodman.com/backing-up-clickhouse-s3-disk-tables-without-duplicating-data

Make sure you are using `Replicated*` tables (see https://github.com/Altinity/clickhouse-operator/blob/master/docs/replication_setup.md). If you lose zookeeper, you can run `system restore replica` on every node to restore the info, event if using zero copy replication.

```
$ cat restore_meta.sql
select 'system restore replica '|| database||'.'|| table||';' from system.replicas where is_readonly format TSVRaw;

$ clickhouse-client < restore_meta.sql |clickhouse-client -mn
```

Thanks to Denny Crane for this (writing down for docs), this restores all replicas on the current node.
