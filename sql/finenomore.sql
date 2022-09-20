DROP TABLE IF EXISTS "fines";
DROP SEQUENCE IF EXISTS fines_id_seq;
CREATE SEQUENCE fines_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;

CREATE TABLE "public"."fines" (
    "id" integer DEFAULT nextval('fines_id_seq') NOT NULL,
    "number_id" integer NOT NULL,
    "fine_date" timestamp NOT NULL,
    "fine_text" text NOT NULL,
    "fine_sum" integer NOT NULL,
    CONSTRAINT "fines_pkey" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "fines_number_id" ON "public"."fines" USING btree ("number_id");

INSERT INTO "fines" ("id", "number_id", "fine_date", "fine_text", "fine_sum") VALUES
(1,	1,	'2022-07-30 10:02:13',	'Ст. 12.9 КоАП РФ, п. 2',	500),
(2,	1,	'2022-08-04 13:50:49',	'Ст. 12.9 КоАП РФ, п. 3',	1000),
(3,	2,	'2022-07-04 13:50:49',	'Ст. 12.9 КоАП РФ, п. 2',	500),
(4,	3,	'2002-02-03 12:11:10',	'Ст. 12.9 КоАП РФ, п. 2',	500);

DROP TABLE IF EXISTS "numbers";
DROP SEQUENCE IF EXISTS numbers_id_seq;
CREATE SEQUENCE numbers_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;

CREATE TABLE "public"."numbers" (
    "id" integer DEFAULT nextval('numbers_id_seq') NOT NULL,
    "number" character(9) NOT NULL,
    CONSTRAINT "numbers_pkey" PRIMARY KEY ("id")
) WITH (oids = false);

INSERT INTO "numbers" ("id", "number") VALUES
(1,	'В215ОР777'),
(2,	'Н644ТН777'),
(3,	'О258ВН97 ');

