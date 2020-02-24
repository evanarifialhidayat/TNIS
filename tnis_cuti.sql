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
-- Name: f_insert_cuti(json); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION f_insert_cuti(dataparam json) RETURNS character
    LANGUAGE plpgsql
    AS $$
declare
validasidata 	  character varying;
val0         character varying;
val1         character varying;
val2  character varying;
val3 character varying;
val4 character varying;
val5 character varying;
val6 character varying;
val7 character varying;
r record;
BEGIN
		val0 = '';
		val1 = '';
		val2 = '';
		val3 = '';
		val4 = '';
		val5 = '';
		val6 ='';
		val7 ='';
		for r in	
					select 
					(obj ->> 'validasi')::character varying as validasi,
					(obj ->> 'keperluan')::character varying as keperluan,
					(obj ->> 'datefrom')::character varying as datefrom,
					(obj ->> 'dateto')::character varying as dateto,
					(obj ->> 'description')::character varying as description,
					(obj ->> 'status')::character varying as status,
					(obj ->> 'cutiid')::character varying as cutiid,
					(obj ->> 'userid')::character varying as userid,
					(select count(*) from cuti where datefrom = (obj ->> 'datefrom')::character varying  and dateto = (obj ->> 'dateto')::character varying) as count
					from json_array_elements(dataparam -> 'data') obj 

		loop
			begin
				val1          = r.keperluan;
				val2          = r.datefrom;
				val3          = r.dateto;		
				val4          = r.description;	
				val5          = r.status;	
				val6          = r.cutiid;
				val7	      = r.userid;
				if r.validasi = 'new' then	
				        if r.count > 0 then	
						validasidata = 'update';
						val6 = (select cutiid from cuti where datefrom = val2::character varying and dateto = val3::character varying limit 1);
					else
						validasidata = 'insert';
						val0          = (select f_standar_tnis_seq::character varying as nomorsequance from f_standar_tnis_seq('CUTI'));			     
					end if;
				else
					validasidata = 'update';	
				end if;
			end;
    end loop;

      begin
	      if validasidata = 'update' then
		  UPDATE cuti   SET keperluan=val1, datefrom=val2, dateto=val3, description=val4, status=val5 WHERE cutiid = val6::numeric;
	      else
		  INSERT INTO cuti(cutino, keperluan, datefrom, dateto, description,status,userid)VALUES (val0, val1, val2, val3, val4,val5,val7::numeric);   
	      end if;
       end;  
    
    return validasidata;
END;

$$;


ALTER FUNCTION public.f_insert_cuti(dataparam json) OWNER TO postgres;

--
-- Name: f_insert_profile(json); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION f_insert_profile(dataparam json) RETURNS character
    LANGUAGE plpgsql
    AS $$
declare
validasidata 	  character varying;
val0         character varying;
val1         character varying;
val2  character varying;
val3 character varying;
val4 character varying;
r record;
BEGIN
		val1 = '';
		val2 = '';
		val3 = '';
		val0 = '';
		val4 = '';
		for r in	
					select 
					(obj ->> 'validasi')::character varying as validasi,
					(obj ->> 'groupid')::numeric as groupid,
					(obj ->> 'name')::character varying as name,
					(obj ->> 'password')::character varying as password,
					(obj ->> 'userid')::character varying as userid,
					(select count(*) from profile where name = (obj ->> 'name')::character varying  and password = (obj ->> 'password')::character varying) as count
					from json_array_elements(dataparam -> 'data') obj 

		loop
			begin
				val1          = r.groupid;
				val2          = r.name;
				val3 = r.password;
				val4  = r.userid;	
				if r.validasi = 'new' then	
						if r.count > 0 then									
						   validasidata = 'update';
						   val4 = (select userid from profile where name = val2::character varying and password = val3::character varying limit 1);
						else				
						   validasidata = 'insert';	
						   val0          = (select f_standar_tnis_seq::character varying as nomorsequance from f_standar_tnis_seq('PROF'));			     
						end if;
				else
					validasidata = 'update';
				end if;
			end;
    end loop;

      begin
	      if validasidata = 'update' then
		  UPDATE profile    SET groupid=val1::numeric, name=val2, password=val3   where userid::numeric = val4::numeric;
	      else
		  INSERT INTO profile(profileno, groupid, name, password) VALUES (val0, val1::numeric, val2, val3);				   
	      end if;
       end;  
    
    return validasidata;
END;

$$;


ALTER FUNCTION public.f_insert_profile(dataparam json) OWNER TO postgres;

--
-- Name: f_standar_tnis_seq(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION f_standar_tnis_seq(dataparam character varying) RETURNS character
    LANGUAGE plpgsql
    AS $$
declare
validasidata 	  character varying;
validasidatatime 	  character varying;
r record;
BEGIN
		
		for r in	
				select 
				(dataparam || to_char(now()::date,'yy') || to_char(now()::date,'mm') || to_char(now()::date,'dd') || last_value) as paramno					
				from standar_tnis_seq
		loop
				validasidata = r.paramno;
		end loop;
	begin
		validasidatatime = (SELECT setval('standar_tnis_seq', (select last_value+'1'::bigint from standar_tnis_seq), true));
	end;
    return validasidata;
END;

$$;


ALTER FUNCTION public.f_standar_tnis_seq(dataparam character varying) OWNER TO postgres;

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
    deleted bigint DEFAULT 0,
    status character varying(255),
    cutino character varying(255) DEFAULT nextval('tblcuti_seq'::regclass),
    userid bigint
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
    deleted bigint DEFAULT 0,
    profileno character varying DEFAULT nextval('tblprofile_seq'::regclass) NOT NULL
);


ALTER TABLE public.profile OWNER TO tnis;

--
-- Name: spring_session; Type: TABLE; Schema: public; Owner: tnis; Tablespace: 
--

CREATE TABLE spring_session (
    primary_id character(36) NOT NULL,
    session_id character(36) NOT NULL,
    creation_time bigint NOT NULL,
    last_access_time bigint NOT NULL,
    max_inactive_interval integer NOT NULL,
    expiry_time bigint NOT NULL,
    principal_name character varying(100)
);


ALTER TABLE public.spring_session OWNER TO tnis;

--
-- Name: spring_session_attributes; Type: TABLE; Schema: public; Owner: tnis; Tablespace: 
--

CREATE TABLE spring_session_attributes (
    session_primary_id character(36) NOT NULL,
    attribute_name character varying(200) NOT NULL,
    attribute_bytes bytea NOT NULL
);


ALTER TABLE public.spring_session_attributes OWNER TO tnis;

--
-- Name: standar_tnis_seq; Type: SEQUENCE; Schema: public; Owner: tnis
--

CREATE SEQUENCE standar_tnis_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.standar_tnis_seq OWNER TO tnis;

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

COPY cuti (cutiid, keperluan, datefrom, dateto, description, deleted, status, cutino, userid) FROM stdin;
6	melahirkan	2020-02-12	2020-02-14	testing	0	Belum Di Setujui	CUTI20022412	5
1	sakit hati	2020-02-12	2020-02-26	xxxxxxxxxx	0	Belum Di Setujui	CUTI2002235	3
\.


--
-- Data for Name: profile; Type: TABLE DATA; Schema: public; Owner: tnis
--

COPY profile (userid, groupid, name, password, tnisvalidasi, schema, deleted, profileno) FROM stdin;
5	4	tnis	tnis	0	\N	0	PROF2002239
3	3	root	root001	1	\N	0	PROF2002223
\.


--
-- Data for Name: spring_session; Type: TABLE DATA; Schema: public; Owner: tnis
--

COPY spring_session (primary_id, session_id, creation_time, last_access_time, max_inactive_interval, expiry_time, principal_name) FROM stdin;
d17ae5f2-86c4-4358-b48b-5759dcb83b77	1479c012-6162-485c-a914-1e4837943781	1582534414448	1582536982421	1800	1582538782421	\N
\.


--
-- Data for Name: spring_session_attributes; Type: TABLE DATA; Schema: public; Owner: tnis
--

COPY spring_session_attributes (session_primary_id, attribute_name, attribute_bytes) FROM stdin;
d17ae5f2-86c4-4358-b48b-5759dcb83b77	userid	\\xaced00057372000e6a6176612e6c616e672e4c6f6e673b8be490cc8f23df0200014a000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b02000078700000000000000003
d17ae5f2-86c4-4358-b48b-5759dcb83b77	loginsuper	\\xaced000574000a6c6f67696e7375706572
\.


--
-- Name: standar_tnis_seq; Type: SEQUENCE SET; Schema: public; Owner: tnis
--

SELECT pg_catalog.setval('standar_tnis_seq', 15, true);


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

SELECT pg_catalog.setval('tblcuti_seq', 6, true);


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

SELECT pg_catalog.setval('tblprofile_seq', 7, true);


--
-- Name: profile_pkey; Type: CONSTRAINT; Schema: public; Owner: tnis; Tablespace: 
--

ALTER TABLE ONLY profile
    ADD CONSTRAINT profile_pkey PRIMARY KEY (userid);


--
-- Name: spring_session_attributes_pk; Type: CONSTRAINT; Schema: public; Owner: tnis; Tablespace: 
--

ALTER TABLE ONLY spring_session_attributes
    ADD CONSTRAINT spring_session_attributes_pk PRIMARY KEY (session_primary_id, attribute_name);


--
-- Name: spring_session_pk; Type: CONSTRAINT; Schema: public; Owner: tnis; Tablespace: 
--

ALTER TABLE ONLY spring_session
    ADD CONSTRAINT spring_session_pk PRIMARY KEY (primary_id);


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
-- Name: spring_session_ix1; Type: INDEX; Schema: public; Owner: tnis; Tablespace: 
--

CREATE UNIQUE INDEX spring_session_ix1 ON spring_session USING btree (session_id);


--
-- Name: spring_session_ix2; Type: INDEX; Schema: public; Owner: tnis; Tablespace: 
--

CREATE INDEX spring_session_ix2 ON spring_session USING btree (expiry_time);


--
-- Name: spring_session_ix3; Type: INDEX; Schema: public; Owner: tnis; Tablespace: 
--

CREATE INDEX spring_session_ix3 ON spring_session USING btree (principal_name);


--
-- Name: profile_groupid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tnis
--

ALTER TABLE ONLY profile
    ADD CONSTRAINT profile_groupid_fkey FOREIGN KEY (groupid) REFERENCES tblgroup(groupid);


--
-- Name: spring_session_attributes_fk; Type: FK CONSTRAINT; Schema: public; Owner: tnis
--

ALTER TABLE ONLY spring_session_attributes
    ADD CONSTRAINT spring_session_attributes_fk FOREIGN KEY (session_primary_id) REFERENCES spring_session(primary_id) ON DELETE CASCADE;


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
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

