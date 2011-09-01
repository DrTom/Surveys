--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: -
--

CREATE OR REPLACE PROCEDURAL LANGUAGE plpgsql;


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: masterimages; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE masterimages (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: masterimages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE masterimages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: masterimages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE masterimages_id_seq OWNED BY masterimages.id;


--
-- Name: surveys; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE surveys (
    id integer NOT NULL,
    name character varying(255),
    opened_at timestamp without time zone,
    closed_at timestamp without time zone,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: opensurveys; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW opensurveys AS
    SELECT surveys.id, surveys.name, surveys.opened_at, surveys.closed_at, surveys.created_at, surveys.updated_at, surveys.id AS survey_id FROM surveys WHERE ((surveys.closed_at IS NULL) AND (surveys.opened_at IS NOT NULL)) ORDER BY surveys.opened_at DESC LIMIT 1;


--
-- Name: questionnaires; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE questionnaires (
    id integer NOT NULL,
    user_id integer,
    survey_id integer,
    virtualdesktop_id integer,
    perf_compile integer,
    perf_app integer,
    sys_stability integer,
    rdp_perf integer,
    rdp_stability integer,
    conf_num_cpu boolean,
    conf_size_ram boolean,
    conf_size_diskc boolean,
    conf_size_diskd boolean,
    toolset_general boolean,
    toolset_completeness boolean,
    usage integer,
    fallback boolean,
    verdict boolean,
    comment text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    is_admin boolean DEFAULT false,
    is_client boolean DEFAULT true,
    is_manager boolean DEFAULT false,
    uid character varying(255) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: virtualdesktops; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE virtualdesktops (
    id integer NOT NULL,
    name character varying(255),
    user_id integer,
    masterimage_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    rundown timestamp without time zone
);


--
-- Name: notifyusers; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW notifyusers AS
    SELECT users.id, users.uid, users.id AS user_id FROM users WHERE ((NOT (users.id IN (SELECT DISTINCT questionnaires.user_id FROM (questionnaires JOIN opensurveys ON ((questionnaires.survey_id = opensurveys.id))) ORDER BY questionnaires.user_id))) AND (users.id IN (SELECT DISTINCT users.id AS user_id FROM (users JOIN virtualdesktops ON ((users.id = virtualdesktops.user_id))) ORDER BY users.id)));


--
-- Name: questionnaires_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE questionnaires_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: questionnaires_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE questionnaires_id_seq OWNED BY questionnaires.id;


--
-- Name: reportbysurveybymasterimages; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW reportbysurveybymasterimages AS
    SELECT questionnaires.survey_id AS id, questionnaires.survey_id, virtualdesktops.masterimage_id, count(*) AS count, round(avg(questionnaires.perf_compile), 1) AS perf_compile, round(avg(questionnaires.perf_app), 1) AS perf_app, round(avg(questionnaires.sys_stability), 1) AS sys_stability, round(avg(questionnaires.rdp_perf), 1) AS rdp_perf, round(avg(questionnaires.rdp_stability), 1) AS rdp_stability, round((((((sum((questionnaires.conf_num_cpu)::integer))::integer)::double precision / (count(*))::double precision) * (100)::double precision))::numeric, 0) AS conf_num_cpu, round((((((sum((questionnaires.conf_size_ram)::integer))::integer)::double precision / (count(*))::double precision) * (100)::double precision))::numeric, 0) AS conf_size_ram, round((((((sum((questionnaires.conf_size_diskc)::integer))::integer)::double precision / (count(*))::double precision) * (100)::double precision))::numeric, 0) AS conf_size_diskc, round((((((sum((questionnaires.conf_size_diskd)::integer))::integer)::double precision / (count(*))::double precision) * (100)::double precision))::numeric, 0) AS conf_size_diskd, round((((((sum((questionnaires.toolset_general)::integer))::integer)::double precision / (count(*))::double precision) * (100)::double precision))::numeric, 0) AS toolset_general, round((((((sum((questionnaires.toolset_completeness)::integer))::integer)::double precision / (count(*))::double precision) * (100)::double precision))::numeric, 0) AS toolset_completeness, round(avg(questionnaires.usage), 0) AS usage, round((((((sum((questionnaires.fallback)::integer))::integer)::double precision / (count(*))::double precision) * (100)::double precision))::numeric, 0) AS fallback, round((((((sum((questionnaires.verdict)::integer))::integer)::double precision / (count(*))::double precision) * (100)::double precision))::numeric, 0) AS verdict FROM (questionnaires LEFT JOIN virtualdesktops ON ((questionnaires.virtualdesktop_id = virtualdesktops.id))) GROUP BY questionnaires.survey_id, virtualdesktops.masterimage_id ORDER BY questionnaires.survey_id, virtualdesktops.masterimage_id;


--
-- Name: reportbysurveys; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW reportbysurveys AS
    SELECT questionnaires.survey_id AS id, questionnaires.survey_id, count(*) AS count, round(avg(questionnaires.perf_compile), 1) AS perf_compile, round(avg(questionnaires.perf_app), 1) AS perf_app, round(avg(questionnaires.sys_stability), 1) AS sys_stability, round(avg(questionnaires.rdp_perf), 1) AS rdp_perf, round(avg(questionnaires.rdp_stability), 1) AS rdp_stability, round((((((sum((questionnaires.conf_num_cpu)::integer))::integer)::double precision / (count(*))::double precision) * (100)::double precision))::numeric, 0) AS conf_num_cpu, round((((((sum((questionnaires.conf_size_ram)::integer))::integer)::double precision / (count(*))::double precision) * (100)::double precision))::numeric, 0) AS conf_size_ram, round((((((sum((questionnaires.conf_size_diskc)::integer))::integer)::double precision / (count(*))::double precision) * (100)::double precision))::numeric, 0) AS conf_size_diskc, round((((((sum((questionnaires.conf_size_diskd)::integer))::integer)::double precision / (count(*))::double precision) * (100)::double precision))::numeric, 0) AS conf_size_diskd, round((((((sum((questionnaires.toolset_general)::integer))::integer)::double precision / (count(*))::double precision) * (100)::double precision))::numeric, 0) AS toolset_general, round((((((sum((questionnaires.toolset_completeness)::integer))::integer)::double precision / (count(*))::double precision) * (100)::double precision))::numeric, 0) AS toolset_completeness, round(avg(questionnaires.usage), 0) AS usage, round((((((sum((questionnaires.fallback)::integer))::integer)::double precision / (count(*))::double precision) * (100)::double precision))::numeric, 0) AS fallback, round((((((sum((questionnaires.verdict)::integer))::integer)::double precision / (count(*))::double precision) * (100)::double precision))::numeric, 0) AS verdict FROM questionnaires GROUP BY questionnaires.survey_id ORDER BY questionnaires.survey_id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: surveys_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE surveys_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: surveys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE surveys_id_seq OWNED BY surveys.id;


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: virtualdesktops_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE virtualdesktops_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: virtualdesktops_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE virtualdesktops_id_seq OWNED BY virtualdesktops.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE masterimages ALTER COLUMN id SET DEFAULT nextval('masterimages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE questionnaires ALTER COLUMN id SET DEFAULT nextval('questionnaires_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE surveys ALTER COLUMN id SET DEFAULT nextval('surveys_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE virtualdesktops ALTER COLUMN id SET DEFAULT nextval('virtualdesktops_id_seq'::regclass);


--
-- Name: masterimages_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY masterimages
    ADD CONSTRAINT masterimages_pkey PRIMARY KEY (id);


--
-- Name: questionnaires_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY questionnaires
    ADD CONSTRAINT questionnaires_pkey PRIMARY KEY (id);


--
-- Name: surveys_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY surveys
    ADD CONSTRAINT surveys_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: virtualdesktops_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY virtualdesktops
    ADD CONSTRAINT virtualdesktops_pkey PRIMARY KEY (id);


--
-- Name: index_masterimages_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_masterimages_on_name ON masterimages USING btree (name);


--
-- Name: index_questionnaires_on_survey_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_questionnaires_on_survey_id ON questionnaires USING btree (survey_id);


--
-- Name: index_questionnaires_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_questionnaires_on_user_id ON questionnaires USING btree (user_id);


--
-- Name: index_surveys_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_surveys_on_name ON surveys USING btree (name);


--
-- Name: index_users_on_uid; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_uid ON users USING btree (uid);


--
-- Name: index_virtualdesktops_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_virtualdesktops_on_name ON virtualdesktops USING btree (name);


--
-- Name: surveys_closed_at_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX surveys_closed_at_idx ON surveys USING btree (closed_at);


--
-- Name: surveys_opened_at_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX surveys_opened_at_idx ON surveys USING btree (opened_at);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

INSERT INTO schema_migrations (version) VALUES ('20110314111300');

INSERT INTO schema_migrations (version) VALUES ('20110314120152');

INSERT INTO schema_migrations (version) VALUES ('20110314121211');

INSERT INTO schema_migrations (version) VALUES ('20110327052257');

INSERT INTO schema_migrations (version) VALUES ('20110327052558');

INSERT INTO schema_migrations (version) VALUES ('20110329164249');

INSERT INTO schema_migrations (version) VALUES ('20110403171948');

INSERT INTO schema_migrations (version) VALUES ('20110405090945');

INSERT INTO schema_migrations (version) VALUES ('20110409101201');

INSERT INTO schema_migrations (version) VALUES ('20110412193013');

INSERT INTO schema_migrations (version) VALUES ('20110503181717');