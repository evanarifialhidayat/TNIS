CREATE SEQUENCE tblprofile_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE tblprofile_seq
  OWNER TO tnis;


CREATE TABLE tblprofile
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
ALTER TABLE tblprofile
  OWNER TO tnis;



CREATE SEQUENCE tblcuti_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE tblcuti_seq
  OWNER TO tnis;

  CREATE TABLE tblcuti
(
  cutiid bigint NOT NULL DEFAULT nextval('tblcuti_seq'::regclass),
  keperluan character varying(255) DEFAULT NULL::character varying,
  datefrom character varying(255) DEFAULT NULL::character varying,
  dateto character varying(255) DEFAULT NULL::character varying,
  description text DEFAULT NULL::text,
  deleted bigint DEFAULT 0,
  PRIMARY KEY (cutiid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE tblcuti
  OWNER TO tnis;




CREATE SEQUENCE tblmodule_moduleid_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE tblmodule_moduleid_seq
  OWNER TO dbl;

CREATE TABLE tbl_module
(
  modulename character varying(255) DEFAULT NULL::character varying,
  moduleid bigint NOT NULL DEFAULT nextval('tblmodule_moduleid_seq'::regclass),
  modulelink character varying(255) DEFAULT NULL::character varying,
  deleted bigint DEFAULT 0,
  PRIMARY KEY (moduleid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE tbl_module
  OWNER TO tnis;



CREATE SEQUENCE tblassignment_assignmentid_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE tblassignment_assignmentid_seq
  OWNER TO tnis;


CREATE TABLE tblassignment
(
  assignmentid bigint NOT NULL DEFAULT nextval('tblassignment_assignmentid_seq'::regclass),
  name character varying(255) DEFAULT NULL::character varying,
  deleted bigint DEFAULT 0,
  PRIMARY KEY (assignmentid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE tblassignment
  OWNER TO tnis;
COMMENT ON TABLE tblassignment
  IS 'stores company name';


CREATE SEQUENCE tblgroup_groupid_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE tblgroup_groupid_seq
  OWNER TO tnis;

CREATE TABLE tblgroup
(
  groupid bigint NOT NULL DEFAULT nextval('tblgroup_groupid_seq'::regclass),
  name character varying(255) DEFAULT NULL::character varying,
  assignmentid bigint,
  deleted bigint DEFAULT 0,
  PRIMARY KEY (groupid),
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


CREATE SEQUENCE tblpermission_permissionid_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE tblpermission_permissionid_seq
  OWNER TO tnis;



CREATE TABLE tblpermissions
(
  permissionid bigint NOT NULL DEFAULT nextval('tblpermission_permissionid_seq'::regclass),
  userid bigint,
  assignmentid bigint,
  moduleid bigint,
  pread boolean DEFAULT false,
  PRIMARY KEY (permissionid),
  CONSTRAINT tblpermission_fk_assignment FOREIGN KEY (assignmentid)
      REFERENCES tblassignment (assignmentid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT tblpermission_fk_user FOREIGN KEY (userid)
      REFERENCES tblprofile (userid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE tblpermissions
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
