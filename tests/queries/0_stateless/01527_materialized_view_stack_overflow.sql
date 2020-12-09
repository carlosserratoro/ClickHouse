DROP TABLE IF EXISTS t;
DROP TABLE IF EXISTS v;

CREATE TABLE t (c String) ENGINE = Memory;

CREATE MATERIALIZED VIEW v to v AS SELECT c FROM t; -- { serverError 36 }
CREATE MATERIALIZED VIEW v to t AS SELECT * FROM v; -- { serverError 60 }

DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;
DROP TABLE IF EXISTS v1;
DROP TABLE IF EXISTS v2;

CREATE TABLE t1 (c String) ENGINE = Memory;
CREATE TABLE t2 (c String) ENGINE = Memory;

CREATE MATERIALIZED VIEW v1 to t1 AS SELECT * FROM t2;
CREATE MATERIALIZED VIEW v2 to t2 AS SELECT * FROM t1;

INSERT INTO t1 VALUES ('Hello'); -- { serverError 306 }
INSERT INTO t2 VALUES ('World'); -- { serverError 306 }

DROP TABLE IF EXISTS t;
DROP TABLE IF EXISTS v;
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;
DROP TABLE IF EXISTS v1;
DROP TABLE IF EXISTS v2;
