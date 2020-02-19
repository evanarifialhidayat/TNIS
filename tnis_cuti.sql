--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: tblcuti_seq; Type: SEQUENCE; Schema: public; Owner: tnis
--

CREATE SEQUENCE tblcuti_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tblcuti_seq OWNER TO tnis;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: cuti; Type: TABLE; Schema: public; Owner: tnis; Tablespace: 
--

CREATE TABLE cuti (
    cutiid bigint DEFAULT nextval('tblcuti_seq'::regclass) NOT NULL,
    keperluan character varying(255) DEFAULT NULL::character varying,
    datefrom character varying(255) DEFAULT NULL::character varying,
    dateto character varying(255) DEFAULT NULL::character varying,
    description text,
    deleted bigint DEFAULT 0
);


ALTER TABLE public.cuti OWNER TO tnis;

--
-- Name: tblprofile_seq; Type: SEQUENCE; Schema: public; Owner: tnis
--

CREATE SEQUENCE tblprofile_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tblprofile_seq OWNER TO tnis;

--
-- Name: profile; Type: TABLE; Schema: public; Owner: tnis; Tablespace: 
--

CREATE TABLE profile (
    userid bigint DEFAULT nextval('tblprofile_seq'::regclass) NOT NULL,
    groupid bigint,
    name character varying(255) DEFAULT NULL::character varying,
    password character varying(255) DEFAULT NULL::character varying,
    tnisvalidasi bigint DEFAULT 0,
    schema character varying(255),
    deleted bigint DEFAULT 0
);


ALTER TABLE public.profile OWNER TO tnis;

--
-- Name: tblassignment_assignmentid_seq; Type: SEQUENCE; Schema: public; Owner: tnis
--

CREATE SEQUENCE tblassignment_assignmentid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tblassignment_assignmentid_seq OWNER TO tnis;

--
-- Name: tblassignment; Type: TABLE; Schema: public; Owner: tnis; Tablespace: 
--

CREATE TABLE tblassignment (
    assignmentid bigint DEFAULT nextval('tblassignment_assignmentid_seq'::regclass) NOT NULL,
    name character varying(255) DEFAULT NULL::character varying,
    deleted bigint DEFAULT 0
);


ALTER TABLE public.tblassignment OWNER TO tnis;

--
-- Name: TABLE tblassignment; Type: COMMENT; Schema: public; Owner: tnis
--

COMMENT ON TABLE tblassignment IS 'stores company name';


--
-- Name: tblgroup_groupid_seq; Type: SEQUENCE; Schema: public; Owner: tnis
--

CREATE SEQUENCE tblgroup_groupid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tblgroup_groupid_seq OWNER TO tnis;

--
-- Name: tblgroup; Type: TABLE; Schema: public; Owner: tnis; Tablespace: 
--

CREATE TABLE tblgroup (
    groupid bigint DEFAULT nextval('tblgroup_groupid_seq'::regclass) NOT NULL,
    name character varying(255) DEFAULT NULL::character varying,
    assignmentid bigint,
    deleted bigint DEFAULT 0
);


ALTER TABLE public.tblgroup OWNER TO tnis;

--
-- Name: TABLE tblgroup; Type: COMMENT; Schema: public; Owner: tnis
--

COMMENT ON TABLE tblgroup IS 'stores user group';


--
-- Name: tblmodule_moduleid_seq; Type: SEQUENCE; Schema: public; Owner: tnis
--

CREATE SEQUENCE tblmodule_moduleid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tblmodule_moduleid_seq OWNER TO tnis;

--
-- Name: tblmodule; Type: TABLE; Schema: public; Owner: tnis; Tablespace: 
--

CREATE TABLE tblmodule (
    modulename character varying(255) DEFAULT NULL::character varying,
    moduleid bigint DEFAULT nextval('tblmodule_moduleid_seq'::regclass) NOT NULL,
    modulelink character varying(255) DEFAULT NULL::character varying,
    deleted bigint DEFAULT 0
);


ALTER TABLE public.tblmodule OWNER TO tnis;

--
-- Name: tblpermission_permissionid_seq; Type: SEQUENCE; Schema: public; Owner: tnis
--

CREATE SEQUENCE tblpermission_permissionid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tblpermission_permissionid_seq OWNER TO tnis;

--
-- Name: tblpermissions; Type: TABLE; Schema: public; Owner: tnis; Tablespace: 
--

CREATE TABLE tblpermissions (
    permissionid bigint DEFAULT nextval('tblpermission_permissionid_seq'::regclass) NOT NULL,
    assignmentid bigint,
    moduleid bigint,
    pread boolean DEFAULT false
);


ALTER TABLE public.tblpermissions OWNER TO tnis;

--
-- Data for Name: cuti; Type: TABLE DATA; Schema: public; Owner: tnis
--

COPY cuti (cutiid, keperluan, datefrom, dateto, description, deleted) FROM stdin;
\.


--
-- Data for Name: profile; Type: TABLE DATA; Schema: public; Owner: tnis
--

COPY profile (userid, groupid, name, password, tnisvalidasi, schema, deleted) FROM stdin;
\.


--
-- Data for Name: tblassignment; Type: TABLE DATA; Schema: public; Owner: tnis
--

COPY tblassignment (assignmentid, name, deleted) FROM stdin;
3	Atasan	0
4	Karyawan	0
\.


--
-- Name: tblassignment_assignmentid_seq; Type: SEQUENCE SET; Schema: public; Owner: tnis
--

SELECT pg_catalog.setval('tblassignment_assignmentid_seq', 4, true);


--
-- Name: tblcuti_seq; Type: SEQUENCE SET; Schema: public; Owner: tnis
--

SELECT pg_catalog.setval('tblcuti_seq', 1, false);


--
-- Data for Name: tblgroup; Type: TABLE DATA; Schema: public; Owner: tnis
--

COPY tblgroup (groupid, name, assignmentid, deleted) FROM stdin;
3	Group Atasan	3	0
4	Group Karyawan	4	0
\.


--
-- Name: tblgroup_groupid_seq; Type: SEQUENCE SET; Schema: public; Owner: tnis
--

SELECT pg_catalog.setval('tblgroup_groupid_seq', 4, true);


--
-- Data for Name: tblmodule; Type: TABLE DATA; Schema: public; Owner: tnis
--

COPY tblmodule (modulename, moduleid, modulelink, deleted) FROM stdin;
Profile	6	/profil	0
Cuti	7	/cuti	0
Assignment	8	/assignment	0
Module	9	/module	0
Group Profile	10	/groupprofile	0
\.


--
-- Name: tblmodule_moduleid_seq; Type: SEQUENCE SET; Schema: public; Owner: tnis
--

SELECT pg_catalog.setval('tblmodule_moduleid_seq', 10, true);


--
-- Name: tblpermission_permissionid_seq; Type: SEQUENCE SET; Schema: public; Owner: tnis
--

SELECT pg_catalog.setval('tblpermission_permissionid_seq', 11, true);


--
-- Data for Name: tblpermissions; Type: TABLE DATA; Schema: public; Owner: tnis
--

COPY tblpermissions (permissionid, assignmentid, moduleid, pread) FROM stdin;
2	3	6	t
3	3	7	t
4	3	8	t
5	3	9	t
6	3	10	t
7	4	6	t
8	4	7	t
9	4	8	f
10	4	9	f
11	4	10	f
\.


--
-- Name: tblprofile_seq; Type: SEQUENCE SET; Schema: public; Owner: tnis
--

SELECT pg_catalog.setval('tblprofile_seq', 1, false);


--
-- Name: tbl_module_pkey; Type: CONSTRAINT; Schema: public; Owner: tnis; Tablespace: 
--

ALTER TABLE ONLY tblmodule
    ADD CONSTRAINT tbl_module_pkey PRIMARY KEY (moduleid);


--
-- Name: tblassignment_pkey; Type: CONSTRAINT; Schema: public; Owner: tnis; Tablespace: 
--

ALTER TABLE ONLY tblassignment
    ADD CONSTRAINT tblassignment_pkey PRIMARY KEY (assignmentid);


--
-- Name: tblcuti_pkey; Type: CONSTRAINT; Schema: public; Owner: tnis; Tablespace: 
--

ALTER TABLE ONLY cuti
    ADD CONSTRAINT tblcuti_pkey PRIMARY KEY (cutiid);


--
-- Name: tblgroup_pkey; Type: CONSTRAINT; Schema: public; Owner: tnis; Tablespace: 
--

ALTER TABLE ONLY tblgroup
    ADD CONSTRAINT tblgroup_pkey PRIMARY KEY (groupid);


--
-- Name: tblpermissions_pkey; Type: CONSTRAINT; Schema: public; Owner: tnis; Tablespace: 
--

ALTER TABLE ONLY tblpermissions
    ADD CONSTRAINT tblpermissions_pkey PRIMARY KEY (permissionid);


--
-- Name: tbluser_pk; Type: CONSTRAINT; Schema: public; Owner: tnis; Tablespace: 
--

ALTER TABLE ONLY profile
    ADD CONSTRAINT tbluser_pk PRIMARY KEY (userid);


--
-- Name: tblassigmentid; Type: FK CONSTRAINT; Schema: public; Owner: tnis
--

ALTER TABLE ONLY tblgroup
    ADD CONSTRAINT tblassigmentid FOREIGN KEY (assignmentid) REFERENCES tblassignment(assignmentid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: tblpermission_fk_assignment; Type: FK CONSTRAINT; Schema: public; Owner: tnis
--

ALTER TABLE ONLY tblpermissions
    ADD CONSTRAINT tblpermission_fk_assignment FOREIGN KEY (assignmentid) REFERENCES tblassignment(assignmentid);


--
-- Name: tbluser_fk; Type: FK CONSTRAINT; Schema: public; Owner: tnis
--

ALTER TABLE ONLY profile
    ADD CONSTRAINT tbluser_fk FOREIGN KEY (groupid) REFERENCES tblgroup(groupid);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

