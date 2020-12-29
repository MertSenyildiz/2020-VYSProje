--
-- PostgreSQL database dump
--

-- Dumped from database version 13.0
-- Dumped by pg_dump version 13.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: GameDB; Type: DATABASE; Schema: -; Owner: postgres
--


SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: Archive; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "Archive";


ALTER SCHEMA "Archive" OWNER TO postgres;

--
-- Name: Baslaticilar; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "Baslaticilar";


ALTER SCHEMA "Baslaticilar" OWNER TO postgres;

--
-- Name: Ekstralar; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "Ekstralar";


ALTER SCHEMA "Ekstralar" OWNER TO postgres;

--
-- Name: Hesaplar; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "Hesaplar";


ALTER SCHEMA "Hesaplar" OWNER TO postgres;

--
-- Name: Oyunlar; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "Oyunlar";


ALTER SCHEMA "Oyunlar" OWNER TO postgres;

--
-- Name: kayit(); Type: FUNCTION; Schema: Archive; Owner: postgres
--

CREATE FUNCTION "Archive".kayit() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
       INSERT INTO "Archive"."kayitlar"(e_posta,k_date) VALUES(NEW.kmail,(SELECT CURRENT_TIMESTAMP));
       RETURN NEW;
    END;
$$;


ALTER FUNCTION "Archive".kayit() OWNER TO postgres;

--
-- Name: moveadded(); Type: FUNCTION; Schema: Archive; Owner: postgres
--

CREATE FUNCTION "Archive".moveadded() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
       INSERT INTO "Archive"."yeniOyun"(oyn_id,hes_id,e_date) VALUES(NEW.oyun,NEW.hesap,(SELECT CURRENT_TIMESTAMP));
       RETURN NEW;
    END;
$$;


ALTER FUNCTION "Archive".moveadded() OWNER TO postgres;

--
-- Name: movedeleted(); Type: FUNCTION; Schema: Archive; Owner: postgres
--

CREATE FUNCTION "Archive".movedeleted() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
       INSERT INTO "Archive"."eskiOyun"(oyun_kodu,hesap_kodu,d_date) VALUES(OLD.oyun,OLD.hesap,(SELECT CURRENT_TIMESTAMP));
       RETURN OLD;
    END;
$$;


ALTER FUNCTION "Archive".movedeleted() OWNER TO postgres;

--
-- Name: moveupdate(); Type: FUNCTION; Schema: Archive; Owner: postgres
--

CREATE FUNCTION "Archive".moveupdate() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
       INSERT INTO "Archive"."oyunGuncelleme"(idisi,eski_adi,yeni_adi,u_date) VALUES(OLD.oyun_id,OLD."oAd",NEW."oAd",(SELECT CURRENT_TIMESTAMP));
       RETURN NEW;
    END;
$$;


ALTER FUNCTION "Archive".moveupdate() OWNER TO postgres;

--
-- Name: giris(character varying, character varying); Type: FUNCTION; Schema: Hesaplar; Owner: postgres
--

CREATE FUNCTION "Hesaplar".giris(mail character varying, sifre character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE 
    durum integer;
BEGIN
    durum:= (SELECT count( * ) FROM "Hesaplar"."Kullanici" WHERE kmail LIKE mail AND "Ksifre" LIKE sifre);
    return durum;
END;
$$;


ALTER FUNCTION "Hesaplar".giris(mail character varying, sifre character varying) OWNER TO postgres;

--
-- Name: toplamoyun(integer); Type: FUNCTION; Schema: Hesaplar; Owner: postgres
--

CREATE FUNCTION "Hesaplar".toplamoyun(id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE 
    toplam integer;
BEGIN
    toplam:= (select count(*) From "Oyunlar"."SahipOlunan" Where hesap =ANY (SELECT hesap_id from "Hesaplar"."Hesap" WHERE kullanici = id ));
    return toplam;
END;
$$;


ALTER FUNCTION "Hesaplar".toplamoyun(id integer) OWNER TO postgres;

--
-- Name: oyunekle(integer, integer); Type: FUNCTION; Schema: Oyunlar; Owner: postgres
--

CREATE FUNCTION "Oyunlar".oyunekle(oyn integer, hsp integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
   INSERT INTO "Oyunlar"."SahipOlunan" (oyun,hesap) VALUES(oyn,hsp);
END;
$$;


ALTER FUNCTION "Oyunlar".oyunekle(oyn integer, hsp integer) OWNER TO postgres;

--
-- Name: oyunsil(integer, integer); Type: FUNCTION; Schema: Oyunlar; Owner: postgres
--

CREATE FUNCTION "Oyunlar".oyunsil(oyn integer, hsp integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
   DELETE From "Oyunlar"."SahipOlunan" Where oyun=oyn And hesap =hsp ;
END;
$$;


ALTER FUNCTION "Oyunlar".oyunsil(oyn integer, hsp integer) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: eskiOyun; Type: TABLE; Schema: Archive; Owner: postgres
--

CREATE TABLE "Archive"."eskiOyun" (
    oyun_kodu integer NOT NULL,
    hesap_kodu integer NOT NULL,
    d_date timestamp with time zone NOT NULL
);


ALTER TABLE "Archive"."eskiOyun" OWNER TO postgres;

--
-- Name: kayitlar; Type: TABLE; Schema: Archive; Owner: postgres
--

CREATE TABLE "Archive".kayitlar (
    k_date timestamp with time zone NOT NULL,
    e_posta character varying NOT NULL
);


ALTER TABLE "Archive".kayitlar OWNER TO postgres;

--
-- Name: oyunGuncelleme; Type: TABLE; Schema: Archive; Owner: postgres
--

CREATE TABLE "Archive"."oyunGuncelleme" (
    idisi integer NOT NULL,
    eski_adi character varying NOT NULL,
    yeni_adi character varying NOT NULL,
    u_date timestamp with time zone NOT NULL
);


ALTER TABLE "Archive"."oyunGuncelleme" OWNER TO postgres;

--
-- Name: yeniOyun; Type: TABLE; Schema: Archive; Owner: postgres
--

CREATE TABLE "Archive"."yeniOyun" (
    hes_id integer NOT NULL,
    oyn_id integer NOT NULL,
    e_date timestamp with time zone NOT NULL
);


ALTER TABLE "Archive"."yeniOyun" OWNER TO postgres;

--
-- Name: Baslatici; Type: TABLE; Schema: Baslaticilar; Owner: postgres
--

CREATE TABLE "Baslaticilar"."Baslatici" (
    baslatici_id integer NOT NULL,
    "bAd" character varying(40) NOT NULL
);


ALTER TABLE "Baslaticilar"."Baslatici" OWNER TO postgres;

--
-- Name: Baslatici_baslatici_id_seq; Type: SEQUENCE; Schema: Baslaticilar; Owner: postgres
--

CREATE SEQUENCE "Baslaticilar"."Baslatici_baslatici_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Baslaticilar"."Baslatici_baslatici_id_seq" OWNER TO postgres;

--
-- Name: Baslatici_baslatici_id_seq; Type: SEQUENCE OWNED BY; Schema: Baslaticilar; Owner: postgres
--

ALTER SEQUENCE "Baslaticilar"."Baslatici_baslatici_id_seq" OWNED BY "Baslaticilar"."Baslatici".baslatici_id;


--
-- Name: Dagitici; Type: TABLE; Schema: Ekstralar; Owner: postgres
--

CREATE TABLE "Ekstralar"."Dagitici" (
    dagitici_id integer NOT NULL,
    "dAd" character varying NOT NULL
);


ALTER TABLE "Ekstralar"."Dagitici" OWNER TO postgres;

--
-- Name: Dagitici_dagitici_id_seq; Type: SEQUENCE; Schema: Ekstralar; Owner: postgres
--

CREATE SEQUENCE "Ekstralar"."Dagitici_dagitici_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Ekstralar"."Dagitici_dagitici_id_seq" OWNER TO postgres;

--
-- Name: Dagitici_dagitici_id_seq; Type: SEQUENCE OWNED BY; Schema: Ekstralar; Owner: postgres
--

ALTER SEQUENCE "Ekstralar"."Dagitici_dagitici_id_seq" OWNED BY "Ekstralar"."Dagitici".dagitici_id;


--
-- Name: Tur; Type: TABLE; Schema: Ekstralar; Owner: postgres
--

CREATE TABLE "Ekstralar"."Tur" (
    tur_id integer NOT NULL,
    "tAd" character varying NOT NULL
);


ALTER TABLE "Ekstralar"."Tur" OWNER TO postgres;

--
-- Name: Tur_tur_id_seq; Type: SEQUENCE; Schema: Ekstralar; Owner: postgres
--

CREATE SEQUENCE "Ekstralar"."Tur_tur_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Ekstralar"."Tur_tur_id_seq" OWNER TO postgres;

--
-- Name: Tur_tur_id_seq; Type: SEQUENCE OWNED BY; Schema: Ekstralar; Owner: postgres
--

ALTER SEQUENCE "Ekstralar"."Tur_tur_id_seq" OWNED BY "Ekstralar"."Tur".tur_id;


--
-- Name: Yapimci; Type: TABLE; Schema: Ekstralar; Owner: postgres
--

CREATE TABLE "Ekstralar"."Yapimci" (
    yapimci_id integer NOT NULL,
    "yAd" character varying NOT NULL
);


ALTER TABLE "Ekstralar"."Yapimci" OWNER TO postgres;

--
-- Name: Yapimci_yapimci_id_seq; Type: SEQUENCE; Schema: Ekstralar; Owner: postgres
--

CREATE SEQUENCE "Ekstralar"."Yapimci_yapimci_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Ekstralar"."Yapimci_yapimci_id_seq" OWNER TO postgres;

--
-- Name: Yapimci_yapimci_id_seq; Type: SEQUENCE OWNED BY; Schema: Ekstralar; Owner: postgres
--

ALTER SEQUENCE "Ekstralar"."Yapimci_yapimci_id_seq" OWNED BY "Ekstralar"."Yapimci".yapimci_id;


--
-- Name: Hesap; Type: TABLE; Schema: Hesaplar; Owner: postgres
--

CREATE TABLE "Hesaplar"."Hesap" (
    hesap_id integer NOT NULL,
    hmail character varying(40) NOT NULL,
    "Hsifre" character varying NOT NULL,
    kullanici integer NOT NULL,
    baslatici integer NOT NULL
);


ALTER TABLE "Hesaplar"."Hesap" OWNER TO postgres;

--
-- Name: Hesap_hesap_id_seq; Type: SEQUENCE; Schema: Hesaplar; Owner: postgres
--

CREATE SEQUENCE "Hesaplar"."Hesap_hesap_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Hesaplar"."Hesap_hesap_id_seq" OWNER TO postgres;

--
-- Name: Hesap_hesap_id_seq; Type: SEQUENCE OWNED BY; Schema: Hesaplar; Owner: postgres
--

ALTER SEQUENCE "Hesaplar"."Hesap_hesap_id_seq" OWNED BY "Hesaplar"."Hesap".hesap_id;


--
-- Name: Kullanici; Type: TABLE; Schema: Hesaplar; Owner: postgres
--

CREATE TABLE "Hesaplar"."Kullanici" (
    kullanici_id integer NOT NULL,
    kmail character varying(40) NOT NULL,
    "Ksifre" character varying NOT NULL,
    kullanici_adi character varying(15) NOT NULL
);


ALTER TABLE "Hesaplar"."Kullanici" OWNER TO postgres;

--
-- Name: Kullanici_kullanici_id_seq; Type: SEQUENCE; Schema: Hesaplar; Owner: postgres
--

CREATE SEQUENCE "Hesaplar"."Kullanici_kullanici_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Hesaplar"."Kullanici_kullanici_id_seq" OWNER TO postgres;

--
-- Name: Kullanici_kullanici_id_seq; Type: SEQUENCE OWNED BY; Schema: Hesaplar; Owner: postgres
--

ALTER SEQUENCE "Hesaplar"."Kullanici_kullanici_id_seq" OWNED BY "Hesaplar"."Kullanici".kullanici_id;


--
-- Name: Oyun; Type: TABLE; Schema: Oyunlar; Owner: postgres
--

CREATE TABLE "Oyunlar"."Oyun" (
    oyun_id integer NOT NULL,
    "oAd" character varying NOT NULL,
    yapim_yili date,
    puan integer,
    tur integer NOT NULL,
    yapimci integer NOT NULL,
    dagitici integer NOT NULL,
    CONSTRAINT puan CHECK (((puan >= 0) AND (puan <= 100)))
);


ALTER TABLE "Oyunlar"."Oyun" OWNER TO postgres;

--
-- Name: Oyun_oyun_id_seq; Type: SEQUENCE; Schema: Oyunlar; Owner: postgres
--

CREATE SEQUENCE "Oyunlar"."Oyun_oyun_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Oyunlar"."Oyun_oyun_id_seq" OWNER TO postgres;

--
-- Name: Oyun_oyun_id_seq; Type: SEQUENCE OWNED BY; Schema: Oyunlar; Owner: postgres
--

ALTER SEQUENCE "Oyunlar"."Oyun_oyun_id_seq" OWNED BY "Oyunlar"."Oyun".oyun_id;


--
-- Name: SahipOlunan; Type: TABLE; Schema: Oyunlar; Owner: postgres
--

CREATE TABLE "Oyunlar"."SahipOlunan" (
    hesap integer NOT NULL,
    oyun integer NOT NULL,
    tarih date
);


ALTER TABLE "Oyunlar"."SahipOlunan" OWNER TO postgres;

--
-- Name: Baslatici baslatici_id; Type: DEFAULT; Schema: Baslaticilar; Owner: postgres
--

ALTER TABLE ONLY "Baslaticilar"."Baslatici" ALTER COLUMN baslatici_id SET DEFAULT nextval('"Baslaticilar"."Baslatici_baslatici_id_seq"'::regclass);


--
-- Name: Dagitici dagitici_id; Type: DEFAULT; Schema: Ekstralar; Owner: postgres
--

ALTER TABLE ONLY "Ekstralar"."Dagitici" ALTER COLUMN dagitici_id SET DEFAULT nextval('"Ekstralar"."Dagitici_dagitici_id_seq"'::regclass);


--
-- Name: Tur tur_id; Type: DEFAULT; Schema: Ekstralar; Owner: postgres
--

ALTER TABLE ONLY "Ekstralar"."Tur" ALTER COLUMN tur_id SET DEFAULT nextval('"Ekstralar"."Tur_tur_id_seq"'::regclass);


--
-- Name: Yapimci yapimci_id; Type: DEFAULT; Schema: Ekstralar; Owner: postgres
--

ALTER TABLE ONLY "Ekstralar"."Yapimci" ALTER COLUMN yapimci_id SET DEFAULT nextval('"Ekstralar"."Yapimci_yapimci_id_seq"'::regclass);


--
-- Name: Hesap hesap_id; Type: DEFAULT; Schema: Hesaplar; Owner: postgres
--

ALTER TABLE ONLY "Hesaplar"."Hesap" ALTER COLUMN hesap_id SET DEFAULT nextval('"Hesaplar"."Hesap_hesap_id_seq"'::regclass);


--
-- Name: Kullanici kullanici_id; Type: DEFAULT; Schema: Hesaplar; Owner: postgres
--

ALTER TABLE ONLY "Hesaplar"."Kullanici" ALTER COLUMN kullanici_id SET DEFAULT nextval('"Hesaplar"."Kullanici_kullanici_id_seq"'::regclass);


--
-- Name: Oyun oyun_id; Type: DEFAULT; Schema: Oyunlar; Owner: postgres
--

ALTER TABLE ONLY "Oyunlar"."Oyun" ALTER COLUMN oyun_id SET DEFAULT nextval('"Oyunlar"."Oyun_oyun_id_seq"'::regclass);


--
-- Data for Name: eskiOyun; Type: TABLE DATA; Schema: Archive; Owner: postgres
--



--
-- Data for Name: kayitlar; Type: TABLE DATA; Schema: Archive; Owner: postgres
--

INSERT INTO "Archive".kayitlar VALUES
	('2020-12-29 21:54:25.301345+03', 'mert@mert.mert');


--
-- Data for Name: oyunGuncelleme; Type: TABLE DATA; Schema: Archive; Owner: postgres
--



--
-- Data for Name: yeniOyun; Type: TABLE DATA; Schema: Archive; Owner: postgres
--

INSERT INTO "Archive"."yeniOyun" VALUES
	(6, 2, '2020-12-29 19:48:13.460659+03'),
	(6, 1, '2020-12-29 19:48:31.262216+03');


--
-- Data for Name: Baslatici; Type: TABLE DATA; Schema: Baslaticilar; Owner: postgres
--

INSERT INTO "Baslaticilar"."Baslatici" VALUES
	(1, 'Steam'),
	(2, 'PlayStation Network'),
	(3, 'Xbox Live'),
	(4, 'Epic Games Store'),
	(5, 'Origin'),
	(6, 'Uplay'),
	(7, 'Battle.net'),
	(8, 'GoG'),
	(9, 'Rockstar Games Launcher');


--
-- Data for Name: Dagitici; Type: TABLE DATA; Schema: Ekstralar; Owner: postgres
--

INSERT INTO "Ekstralar"."Dagitici" VALUES
	(1, 'CD PROJECT RED'),
	(2, 'Rockstar Games'),
	(3, 'Bethesda Softworks'),
	(4, 'Valve'),
	(5, 'Supergiant Games'),
	(6, 'Wube Software LTD.'),
	(7, 'Re-Logic'),
	(8, '505 Games'),
	(9, 'Ubisoft');


--
-- Data for Name: Tur; Type: TABLE DATA; Schema: Ekstralar; Owner: postgres
--

INSERT INTO "Ekstralar"."Tur" VALUES
	(1, 'RPG'),
	(2, 'Action-Adventure'),
	(3, 'Rogue-like'),
	(4, 'MMO'),
	(5, 'FPS'),
	(6, 'Puzzle-Platform'),
	(7, 'Strategy');


--
-- Data for Name: Yapimci; Type: TABLE DATA; Schema: Ekstralar; Owner: postgres
--

INSERT INTO "Ekstralar"."Yapimci" VALUES
	(1, 'CD PROJECT RED'),
	(2, 'Valve'),
	(3, 'Ubisoft'),
	(4, 'Bioware'),
	(5, 'Remedy Entertainment'),
	(6, 'Electronic Arts'),
	(7, 'Naughty Dog'),
	(8, 'Square Enix'),
	(9, 'Capcom'),
	(10, 'Epic Games'),
	(11, 'Take-Two Interactive'),
	(12, 'id Software'),
	(13, 'Paradox Interactive'),
	(14, 'Supergiant Games'),
	(15, 'Wube Software LTD.'),
	(16, 'Re-Logic');


--
-- Data for Name: Hesap; Type: TABLE DATA; Schema: Hesaplar; Owner: postgres
--

INSERT INTO "Hesaplar"."Hesap" VALUES
	(1, 'steamMert@xyz.xyz', 'steam', 1, 1),
	(2, 'epicMert@xyz.xyz', 'epic', 1, 4),
	(4, 'uplayMert@xyz.xyz', 'uplay', 1, 6),
	(5, 'gogMert@xyz.xyz', 'gog', 1, 8),
	(3, 'originMert@xyz.xyz', 'origin', 1, 5),
	(6, 'stMS@abc.xyz', 'st', 2, 1);


--
-- Data for Name: Kullanici; Type: TABLE DATA; Schema: Hesaplar; Owner: postgres
--

INSERT INTO "Hesaplar"."Kullanici" VALUES
	(1, 'mert.senyildiz@ogr.sakarya.edu.tr', '1234', 'Mert Senyildiz'),
	(2, 'mertSenyildiz@abc.xyz', '1234', 'MS'),
	(3, 'mert@mert.mert', '1234', 'Mert');


--
-- Data for Name: Oyun; Type: TABLE DATA; Schema: Oyunlar; Owner: postgres
--

INSERT INTO "Oyunlar"."Oyun" VALUES
	(1, 'The Witcher 3: Wild Hunt', '2015-05-18', 93, 1, 1, 1),
	(2, 'Cyberpunk 2077', '2020-12-10', 86, 1, 1, 1),
	(5, 'Factorio', '2020-08-14', 94, 7, 15, 6),
	(6, 'Terraria', '2011-05-16', 83, 2, 16, 7),
	(7, 'Control', '2019-08-27', 82, 2, 5, 8),
	(8, 'Assassin''s Creed Odyssey', '2018-10-05', 83, 2, 3, 9),
	(3, 'Portal 2', '2011-04-19', 95, 6, 2, 4),
	(4, 'Hades', '2020-09-17', 93, 3, 14, 5);


--
-- Data for Name: SahipOlunan; Type: TABLE DATA; Schema: Oyunlar; Owner: postgres
--

INSERT INTO "Oyunlar"."SahipOlunan" VALUES
	(2, 7, NULL),
	(4, 8, NULL),
	(5, 1, NULL),
	(1, 3, NULL),
	(1, 2, NULL),
	(1, 4, NULL),
	(1, 1, NULL),
	(6, 2, NULL),
	(6, 1, NULL);


--
-- Name: Baslatici_baslatici_id_seq; Type: SEQUENCE SET; Schema: Baslaticilar; Owner: postgres
--

SELECT pg_catalog.setval('"Baslaticilar"."Baslatici_baslatici_id_seq"', 9, true);


--
-- Name: Dagitici_dagitici_id_seq; Type: SEQUENCE SET; Schema: Ekstralar; Owner: postgres
--

SELECT pg_catalog.setval('"Ekstralar"."Dagitici_dagitici_id_seq"', 9, true);


--
-- Name: Tur_tur_id_seq; Type: SEQUENCE SET; Schema: Ekstralar; Owner: postgres
--

SELECT pg_catalog.setval('"Ekstralar"."Tur_tur_id_seq"', 7, true);


--
-- Name: Yapimci_yapimci_id_seq; Type: SEQUENCE SET; Schema: Ekstralar; Owner: postgres
--

SELECT pg_catalog.setval('"Ekstralar"."Yapimci_yapimci_id_seq"', 16, true);


--
-- Name: Hesap_hesap_id_seq; Type: SEQUENCE SET; Schema: Hesaplar; Owner: postgres
--

SELECT pg_catalog.setval('"Hesaplar"."Hesap_hesap_id_seq"', 6, true);


--
-- Name: Kullanici_kullanici_id_seq; Type: SEQUENCE SET; Schema: Hesaplar; Owner: postgres
--

SELECT pg_catalog.setval('"Hesaplar"."Kullanici_kullanici_id_seq"', 3, true);


--
-- Name: Oyun_oyun_id_seq; Type: SEQUENCE SET; Schema: Oyunlar; Owner: postgres
--

SELECT pg_catalog.setval('"Oyunlar"."Oyun_oyun_id_seq"', 8, true);


--
-- Name: Baslatici bAd; Type: CONSTRAINT; Schema: Baslaticilar; Owner: postgres
--

ALTER TABLE ONLY "Baslaticilar"."Baslatici"
    ADD CONSTRAINT "bAd" UNIQUE ("bAd");


--
-- Name: Baslatici baslatici_id; Type: CONSTRAINT; Schema: Baslaticilar; Owner: postgres
--

ALTER TABLE ONLY "Baslaticilar"."Baslatici"
    ADD CONSTRAINT baslatici_id PRIMARY KEY (baslatici_id);


--
-- Name: Dagitici dAd; Type: CONSTRAINT; Schema: Ekstralar; Owner: postgres
--

ALTER TABLE ONLY "Ekstralar"."Dagitici"
    ADD CONSTRAINT "dAd" UNIQUE ("dAd");


--
-- Name: Dagitici dagitici_id; Type: CONSTRAINT; Schema: Ekstralar; Owner: postgres
--

ALTER TABLE ONLY "Ekstralar"."Dagitici"
    ADD CONSTRAINT dagitici_id PRIMARY KEY (dagitici_id);


--
-- Name: Tur tAd; Type: CONSTRAINT; Schema: Ekstralar; Owner: postgres
--

ALTER TABLE ONLY "Ekstralar"."Tur"
    ADD CONSTRAINT "tAd" UNIQUE ("tAd");


--
-- Name: Tur tur_id; Type: CONSTRAINT; Schema: Ekstralar; Owner: postgres
--

ALTER TABLE ONLY "Ekstralar"."Tur"
    ADD CONSTRAINT tur_id PRIMARY KEY (tur_id);


--
-- Name: Yapimci yAd; Type: CONSTRAINT; Schema: Ekstralar; Owner: postgres
--

ALTER TABLE ONLY "Ekstralar"."Yapimci"
    ADD CONSTRAINT "yAd" UNIQUE ("yAd");


--
-- Name: Yapimci yapimci_id; Type: CONSTRAINT; Schema: Ekstralar; Owner: postgres
--

ALTER TABLE ONLY "Ekstralar"."Yapimci"
    ADD CONSTRAINT yapimci_id PRIMARY KEY (yapimci_id);


--
-- Name: Hesap hesap_id; Type: CONSTRAINT; Schema: Hesaplar; Owner: postgres
--

ALTER TABLE ONLY "Hesaplar"."Hesap"
    ADD CONSTRAINT hesap_id PRIMARY KEY (hesap_id);


--
-- Name: Hesap hmail; Type: CONSTRAINT; Schema: Hesaplar; Owner: postgres
--

ALTER TABLE ONLY "Hesaplar"."Hesap"
    ADD CONSTRAINT hmail UNIQUE (hmail);


--
-- Name: Kullanici kmail; Type: CONSTRAINT; Schema: Hesaplar; Owner: postgres
--

ALTER TABLE ONLY "Hesaplar"."Kullanici"
    ADD CONSTRAINT kmail UNIQUE (kmail);


--
-- Name: Kullanici kullanici_adi; Type: CONSTRAINT; Schema: Hesaplar; Owner: postgres
--

ALTER TABLE ONLY "Hesaplar"."Kullanici"
    ADD CONSTRAINT kullanici_adi UNIQUE (kullanici_adi);


--
-- Name: Kullanici kullanici_id; Type: CONSTRAINT; Schema: Hesaplar; Owner: postgres
--

ALTER TABLE ONLY "Hesaplar"."Kullanici"
    ADD CONSTRAINT kullanici_id PRIMARY KEY (kullanici_id);


--
-- Name: SahipOlunan SahipOlunan_pkey; Type: CONSTRAINT; Schema: Oyunlar; Owner: postgres
--

ALTER TABLE ONLY "Oyunlar"."SahipOlunan"
    ADD CONSTRAINT "SahipOlunan_pkey" PRIMARY KEY (hesap, oyun);


--
-- Name: Oyun oAd; Type: CONSTRAINT; Schema: Oyunlar; Owner: postgres
--

ALTER TABLE ONLY "Oyunlar"."Oyun"
    ADD CONSTRAINT "oAd" UNIQUE ("oAd");


--
-- Name: Oyun oyun_id; Type: CONSTRAINT; Schema: Oyunlar; Owner: postgres
--

ALTER TABLE ONLY "Oyunlar"."Oyun"
    ADD CONSTRAINT oyun_id PRIMARY KEY (oyun_id);


--
-- Name: Kullanici kayit; Type: TRIGGER; Schema: Hesaplar; Owner: postgres
--

CREATE TRIGGER kayit AFTER INSERT ON "Hesaplar"."Kullanici" FOR EACH ROW EXECUTE FUNCTION "Archive".kayit();


--
-- Name: SahipOlunan moveadded; Type: TRIGGER; Schema: Oyunlar; Owner: postgres
--

CREATE TRIGGER moveadded AFTER INSERT ON "Oyunlar"."SahipOlunan" FOR EACH ROW EXECUTE FUNCTION "Archive".moveadded();


--
-- Name: SahipOlunan movedeleted; Type: TRIGGER; Schema: Oyunlar; Owner: postgres
--

CREATE TRIGGER movedeleted BEFORE DELETE ON "Oyunlar"."SahipOlunan" FOR EACH ROW EXECUTE FUNCTION "Archive".movedeleted();


--
-- Name: Oyun moveupdate; Type: TRIGGER; Schema: Oyunlar; Owner: postgres
--

CREATE TRIGGER moveupdate AFTER UPDATE ON "Oyunlar"."Oyun" FOR EACH ROW EXECUTE FUNCTION "Archive".moveupdate();


--
-- Name: kayitlar e_posta; Type: FK CONSTRAINT; Schema: Archive; Owner: postgres
--

ALTER TABLE ONLY "Archive".kayitlar
    ADD CONSTRAINT e_posta FOREIGN KEY (e_posta) REFERENCES "Hesaplar"."Kullanici"(kmail) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: yeniOyun hes_id; Type: FK CONSTRAINT; Schema: Archive; Owner: postgres
--

ALTER TABLE ONLY "Archive"."yeniOyun"
    ADD CONSTRAINT hes_id FOREIGN KEY (hes_id) REFERENCES "Hesaplar"."Hesap"(hesap_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: eskiOyun hesap_kodu; Type: FK CONSTRAINT; Schema: Archive; Owner: postgres
--

ALTER TABLE ONLY "Archive"."eskiOyun"
    ADD CONSTRAINT hesap_kodu FOREIGN KEY (hesap_kodu) REFERENCES "Hesaplar"."Hesap"(hesap_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: yeniOyun oyn_id; Type: FK CONSTRAINT; Schema: Archive; Owner: postgres
--

ALTER TABLE ONLY "Archive"."yeniOyun"
    ADD CONSTRAINT oyn_id FOREIGN KEY (oyn_id) REFERENCES "Oyunlar"."Oyun"(oyun_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: eskiOyun oyun_kodu; Type: FK CONSTRAINT; Schema: Archive; Owner: postgres
--

ALTER TABLE ONLY "Archive"."eskiOyun"
    ADD CONSTRAINT oyun_kodu FOREIGN KEY (oyun_kodu) REFERENCES "Oyunlar"."Oyun"(oyun_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Hesap baslatici; Type: FK CONSTRAINT; Schema: Hesaplar; Owner: postgres
--

ALTER TABLE ONLY "Hesaplar"."Hesap"
    ADD CONSTRAINT baslatici FOREIGN KEY (baslatici) REFERENCES "Baslaticilar"."Baslatici"(baslatici_id);


--
-- Name: Hesap kullanici; Type: FK CONSTRAINT; Schema: Hesaplar; Owner: postgres
--

ALTER TABLE ONLY "Hesaplar"."Hesap"
    ADD CONSTRAINT kullanici FOREIGN KEY (kullanici) REFERENCES "Hesaplar"."Kullanici"(kullanici_id);


--
-- Name: Oyun dagitici; Type: FK CONSTRAINT; Schema: Oyunlar; Owner: postgres
--

ALTER TABLE ONLY "Oyunlar"."Oyun"
    ADD CONSTRAINT dagitici FOREIGN KEY (dagitici) REFERENCES "Ekstralar"."Dagitici"(dagitici_id);


--
-- Name: SahipOlunan hesap; Type: FK CONSTRAINT; Schema: Oyunlar; Owner: postgres
--

ALTER TABLE ONLY "Oyunlar"."SahipOlunan"
    ADD CONSTRAINT hesap FOREIGN KEY (hesap) REFERENCES "Hesaplar"."Hesap"(hesap_id);


--
-- Name: SahipOlunan oyun; Type: FK CONSTRAINT; Schema: Oyunlar; Owner: postgres
--

ALTER TABLE ONLY "Oyunlar"."SahipOlunan"
    ADD CONSTRAINT oyun FOREIGN KEY (oyun) REFERENCES "Oyunlar"."Oyun"(oyun_id);


--
-- Name: Oyun tur; Type: FK CONSTRAINT; Schema: Oyunlar; Owner: postgres
--

ALTER TABLE ONLY "Oyunlar"."Oyun"
    ADD CONSTRAINT tur FOREIGN KEY (tur) REFERENCES "Ekstralar"."Tur"(tur_id);


--
-- Name: Oyun yapimci; Type: FK CONSTRAINT; Schema: Oyunlar; Owner: postgres
--

ALTER TABLE ONLY "Oyunlar"."Oyun"
    ADD CONSTRAINT yapimci FOREIGN KEY (yapimci) REFERENCES "Ekstralar"."Yapimci"(yapimci_id);


--
-- PostgreSQL database dump complete
--

