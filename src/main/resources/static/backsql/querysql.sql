CREATE SEQUENCE tblassignment_assignmentid_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 4
  CACHE 1;
ALTER TABLE tblassignment_assignmentid_seq
  OWNER TO tnis;

CREATE SEQUENCE tblcuti_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE tblcuti_seq
  OWNER TO tnis;

CREATE SEQUENCE tblgroup_groupid_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 4
  CACHE 1;
ALTER TABLE tblgroup_groupid_seq
  OWNER TO tnis;

CREATE SEQUENCE tblmodule_moduleid_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 10
  CACHE 1;
ALTER TABLE tblmodule_moduleid_seq
  OWNER TO tnis;


CREATE SEQUENCE tblpermission_permissionid_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 11
  CACHE 1;
ALTER TABLE tblpermission_permissionid_seq
  OWNER TO tnis;

CREATE SEQUENCE tblprofile_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE tblprofile_seq
  OWNER TO tnis;


CREATE TABLE tblmodule
(
  modulename character varying(255) DEFAULT NULL::character varying,
  moduleid bigint NOT NULL DEFAULT nextval('tblmodule_moduleid_seq'::regclass),
  modulelink character varying(255) DEFAULT NULL::character varying,
  deleted bigint DEFAULT 0,
  CONSTRAINT tbl_module_pkey PRIMARY KEY (moduleid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE tblmodule
  OWNER TO tnis;


CREATE TABLE tblassignment
(
  assignmentid bigint NOT NULL DEFAULT nextval('tblassignment_assignmentid_seq'::regclass),
  name character varying(255) DEFAULT NULL::character varying,
  deleted bigint DEFAULT 0,
  CONSTRAINT tblassignment_pkey PRIMARY KEY (assignmentid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE tblassignment
  OWNER TO tnis;
COMMENT ON TABLE tblassignment
  IS 'stores company name';


CREATE TABLE cuti
(
  cutiid bigint NOT NULL DEFAULT nextval('tblcuti_seq'::regclass),
  keperluan character varying(255) DEFAULT NULL::character varying,
  datefrom character varying(255) DEFAULT NULL::character varying,
  dateto character varying(255) DEFAULT NULL::character varying,
  description text,
  deleted bigint DEFAULT 0,
  CONSTRAINT tblcuti_pkey PRIMARY KEY (cutiid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE cuti
  OWNER TO tnis;

CREATE TABLE tblgroup
(
  groupid bigint NOT NULL DEFAULT nextval('tblgroup_groupid_seq'::regclass),
  name character varying(255) DEFAULT NULL::character varying,
  assignmentid bigint,
  deleted bigint DEFAULT 0,
  CONSTRAINT tblgroup_pkey PRIMARY KEY (groupid),
  CONSTRAINT tblassigmentid FOREIGN KEY (assignmentid)
      REFERENCES tblassignment (assignmentid) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE
)
WITH (
  OIDS=FALSE
);
ALTER TABLE tblgroup
  OWNER TO tnis;
COMMENT ON TABLE tblgroup
  IS 'stores user group';


CREATE TABLE tblpermissions
(
  permissionid bigint NOT NULL DEFAULT nextval('tblpermission_permissionid_seq'::regclass),
  assignmentid bigint,
  moduleid bigint,
  pread boolean DEFAULT false,
  CONSTRAINT tblpermissions_pkey PRIMARY KEY (permissionid),
  CONSTRAINT tblpermission_fk_assignment FOREIGN KEY (assignmentid)
      REFERENCES tblassignment (assignmentid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE tblpermissions
  OWNER TO tnis;


CREATE TABLE profile
(
  userid bigint NOT NULL DEFAULT nextval('tblprofile_seq'::regclass),
  groupid bigint,
  name character varying(255) DEFAULT NULL::character varying,
  password character varying(255) DEFAULT NULL::character varying,
  tnisvalidasi bigint DEFAULT 0,
  schema character varying(255),
  deleted bigint DEFAULT 0,
  CONSTRAINT tbluser_pk PRIMARY KEY (userid),
  CONSTRAINT tbluser_fk FOREIGN KEY (groupid)
      REFERENCES tblgroup (groupid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE profile
  OWNER TO tnis;



INSERT INTO tbl_module(modulename, modulelink)VALUES ('Profile', '/profil');
INSERT INTO tbl_module(modulename, modulelink)VALUES ('Cuti', '/cuti');
INSERT INTO tbl_module(modulename, modulelink)VALUES ('Assignment', '/assignment');
INSERT INTO tbl_module(modulename, modulelink)VALUES ('Module', '/module');
INSERT INTO tbl_module(modulename, modulelink)VALUES ('Group Profile', '/groupprofile');

INSERT INTO tblassignment(name)VALUES ('Atasan');
INSERT INTO tblassignment(name)VALUES ('Karyawan');

INSERT INTO tblgroup(name, assignmentid)
VALUES ('Group Atasan',(select assignmentid from tblassignment where name = 'Atasan' limit 1) );
INSERT INTO tblgroup(name, assignmentid)
VALUES ('Group Karyawan',(select assignmentid from tblassignment where name = 'Karyawan' limit 1) );

INSERT INTO tblpermissions(assignmentid, moduleid,pread)
VALUES ((select assignmentid from tblassignment where name = 'Atasan' limit 1), (select moduleid from tbl_module where modulename = 'Profile' limit 1),true);
INSERT INTO tblpermissions(assignmentid, moduleid,pread)
VALUES ((select assignmentid from tblassignment where name = 'Atasan' limit 1), (select moduleid from tbl_module where modulename = 'Cuti' limit 1),true);
INSERT INTO tblpermissions(assignmentid, moduleid,pread)
VALUES ((select assignmentid from tblassignment where name = 'Atasan' limit 1), (select moduleid from tbl_module where modulename = 'Assignment' limit 1),true);
INSERT INTO tblpermissions(assignmentid, moduleid,pread)
VALUES ((select assignmentid from tblassignment where name = 'Atasan' limit 1), (select moduleid from tbl_module where modulename = 'Module' limit 1),true);
INSERT INTO tblpermissions(assignmentid, moduleid,pread)
VALUES ((select assignmentid from tblassignment where name = 'Atasan' limit 1), (select moduleid from tbl_module where modulename = 'Group Profile' limit 1),true);

INSERT INTO tblpermissions(assignmentid, moduleid,pread)
VALUES ((select assignmentid from tblassignment where name = 'Karyawan' limit 1), (select moduleid from tbl_module where modulename = 'Profile' limit 1),true);
INSERT INTO tblpermissions(assignmentid, moduleid,pread)
VALUES ((select assignmentid from tblassignment where name = 'Karyawan' limit 1), (select moduleid from tbl_module where modulename = 'Cuti' limit 1),true);
INSERT INTO tblpermissions(assignmentid, moduleid,pread)
VALUES ((select assignmentid from tblassignment where name = 'Karyawan' limit 1), (select moduleid from tbl_module where modulename = 'Assignment' limit 1),false);
INSERT INTO tblpermissions(assignmentid, moduleid,pread)
VALUES ((select assignmentid from tblassignment where name = 'Karyawan' limit 1), (select moduleid from tbl_module where modulename = 'Module' limit 1),false);
INSERT INTO tblpermissions(assignmentid, moduleid,pread)
VALUES ((select assignmentid from tblassignment where name = 'Karyawan' limit 1), (select moduleid from tbl_module where modulename = 'Group Profile' limit 1),false);


CREATE SEQUENCE standar_tnis_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE standar_tnis_seq
  OWNER TO dbl;



CREATE OR REPLACE FUNCTION f_standar_tns_seq(dataparam character varying)
  RETURNS character AS
$BODY$
declare
validasidata 	  character varying;
validasidatatime 	  character varying;
r record;
BEGIN
		
		for r in	
				select 
				(dataparam || to_char(now()::date,'yy') || to_char(now()::date,'mm') || to_char(now()::date,'dd') || last_value) as paramno					
				from dbl1.standar_dbl_seq
		loop
				validasidata = r.paramno;
		end loop;
	begin
		validasidatatime = (SELECT setval('standar_tnis_seq', (select last_value+'1'::bigint from standar_tnis_seq), true));
	end;
    return validasidata;
END;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION f_standar_tns_seq(character varying)
  OWNER TO postgres;


-- Function: f_insert_profile_zone(json)

-- DROP FUNCTION f_insert_profile_zone(json);

CREATE OR REPLACE FUNCTION f_insert_profile(dataparam json)
  RETURNS character AS
$BODY$
declare
validasidata 	  character varying;
val0         character varying;
val1         character varying;
val2  character varying;
val3 character varying;
r record;
BEGIN
		val1 = '';
		val2 = '';
		val3 = '';
		val0 = '';
		
		for r in	
					select 
					(obj ->> 'schema')::character varying as schema,
					(obj ->> 'groupid')::character varying as groupid,
					(obj ->> 'name')::character varying as name,
					(obj ->> 'password')::character varying as password,
					(select count(*) from profile where name = (obj ->> 'name')::character varying  and password = (obj ->> 'password')::character varying) as count
					from json_array_elements(dataparam -> 'data') obj 

		loop
			begin
				val1          = r.groupid;
				val2          = r.name;
				val3 = r.password;
				if r.count > 0 then			        
				   validasidata = 'update';
				else				
				   validasidata = 'insert';	
				   val0          = (select f_standar_tnis_seq::character varying as nomorsequance from f_standar_tnis_seq('PROF'));			     
			        end if;
			end;
    end loop;

      begin
	      if validasidata = 'update' then
		  UPDATE profile    SET groupid=val1, name=val2, password=val3   where userid = val0;
	      else
		  INSERT INTO profile(userid, groupid, name, password) VALUES (val0, val1, val2, val3);
				   
	      end if;
       end;  
    
    return validasidata;
END;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION f_insert_profile(json)
  OWNER TO postgres;


ALTER TABLE cuti  ADD COLUMN status character varying(255);
ALTER TABLE cuti  ADD COLUMN cutino character varying(255);


CREATE OR REPLACE FUNCTION f_insert_cuti(dataparam json)
  RETURNS character AS
$BODY$
declare
validasidata 	  character varying;
val0         character varying;
val1         character varying;
val2  character varying;
val3 character varying;
val4 character varying;
val5 character varying;

r record;
BEGIN
		val0 = '';
		val1 = '';
		val2 = '';
		val3 = '';
		val4 = '';
		val5 = '';
		
		for r in	
					select 
					(obj ->> 'schema')::character varying as schema,
					(obj ->> 'keperluan')::character varying as groupid,
					(obj ->> 'datefrom')::character varying as name,
					(obj ->> 'dateto')::character varying as password,
					(obj ->> 'description')::character varying as description,
					(obj ->> 'status')::character varying as status
					from json_array_elements(dataparam -> 'data') obj 

		loop
			begin
				val1          = r.keperluan;
				val2          = r.datefrom;
				val3          = r.dateto;		
				val4          = r.description;	
				val5          = r.status;							
				validasidata = 'insert';	
				val0          = (select f_standar_tnis_seq::character varying as nomorsequance from f_standar_tnis_seq('CUTI'));
			end;
    end loop;

      begin
		  INSERT INTO cuti(cutino, keperluan, datefrom, dateto, description,status)VALUES (val0, val1, val2, val3, val4,val5);

       end;  
    
    return validasidata;
END;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION f_insert_cuti(json)
  OWNER TO postgres;




