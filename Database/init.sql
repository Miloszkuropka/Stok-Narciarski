--
-- PostgreSQL database dump
--

-- Dumped from database version 14.7 (Debian 14.7-1.pgdg110+1)
-- Dumped by pg_dump version 14.7

-- Started on 2023-05-18 10:31:50 UTC

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 209 (class 1259 OID 16385)
-- Name: Carnets; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."Carnets" (
    id uuid NOT NULL,
    seller_id uuid,
    customer_id uuid NOT NULL,
    ticket_offer_id uuid NOT NULL,
    carnet_type text NOT NULL,
    purchase_date timestamp without time zone NOT NULL,
    starts timestamp without time zone NOT NULL,
    ends timestamp without time zone NOT NULL,
    total_points integer NOT NULL,
    points_left integer NOT NULL
);


ALTER TABLE public."Carnets" OWNER TO admin;

--
-- TOC entry 210 (class 1259 OID 16390)
-- Name: Customers; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."Customers" (
    id uuid NOT NULL,
    phone_number text NOT NULL,
    username text NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    surname text NOT NULL,
    salted_password_hash text NOT NULL
);


ALTER TABLE public."Customers" OWNER TO admin;

--
-- TOC entry 211 (class 1259 OID 16395)
-- Name: Employees; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."Employees" (
    id uuid NOT NULL,
    phone_number text NOT NULL,
    username text NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    surname text NOT NULL,
    salted_password_hash text NOT NULL,
    role text NOT NULL
);


ALTER TABLE public."Employees" OWNER TO admin;

--
-- TOC entry 212 (class 1259 OID 16400)
-- Name: Entries; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."Entries" (
    id uuid NOT NULL,
    carnet_id uuid NOT NULL,
    entry_date date NOT NULL,
    ski_lift_id uuid NOT NULL
);


ALTER TABLE public."Entries" OWNER TO admin;

--
-- TOC entry 213 (class 1259 OID 16403)
-- Name: OpeningSchedule; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."OpeningSchedule" (
    id uuid NOT NULL,
    lift_id uuid NOT NULL,
    day_of_week integer NOT NULL,
    opening timestamp without time zone NOT NULL,
    closing timestamp without time zone NOT NULL
);


ALTER TABLE public."OpeningSchedule" OWNER TO admin;

--
-- TOC entry 214 (class 1259 OID 16406)
-- Name: Purchase; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."Purchase" (
    id uuid NOT NULL,
    offer_id uuid NOT NULL,
    customer_id uuid NOT NULL,
    seller_id uuid NOT NULL,
    date timestamp without time zone NOT NULL
);


ALTER TABLE public."Purchase" OWNER TO admin;

--
-- TOC entry 215 (class 1259 OID 16409)
-- Name: SkiLifts; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."SkiLifts" (
    id uuid NOT NULL,
    name text NOT NULL,
    location text NOT NULL,
    cost integer NOT NULL,
    if_active boolean DEFAULT false NOT NULL,
    distance integer NOT NULL
);


ALTER TABLE public."SkiLifts" OWNER TO admin;

--
-- TOC entry 216 (class 1259 OID 16415)
-- Name: TicketOffers; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."TicketOffers" (
    id uuid NOT NULL,
    ticket_type text NOT NULL,
    offer_starts date NOT NULL,
    offer_ends date NOT NULL,
    full_price money NOT NULL,
    reduced_price money NOT NULL,
    days integer NOT NULL,
    hours integer NOT NULL,
    points integer NOT NULL
);


ALTER TABLE public."TicketOffers" OWNER TO admin;

--
-- TOC entry 217 (class 1259 OID 16420)
-- Name: WeatherConditions; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."WeatherConditions" (
    temperature double precision NOT NULL,
    snow_cm integer NOT NULL,
    date timestamp without time zone NOT NULL,
    lifts_open integer NOT NULL
);


ALTER TABLE public."WeatherConditions" OWNER TO admin;

--
-- TOC entry 3370 (class 0 OID 16385)
-- Dependencies: 209
-- Data for Name: Carnets; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."Carnets" (id, seller_id, customer_id, ticket_offer_id, carnet_type, purchase_date, starts, ends, total_points, points_left) FROM stdin;
ebeed7d8-ed10-11ed-a05b-0242ac120003	44ac0368-ecfe-11ed-a05b-0242ac120003	4c8d87bc-ed05-11ed-a05b-0242ac120003	ed799874-ed13-11ed-a05b-0242ac120003	points	2023-05-05 00:00:00	2023-05-07 00:00:00	2023-05-07 00:00:00	9	5
ebeedac6-ed10-11ed-a05b-0242ac120003	44ac157e-ecfe-11ed-a05b-0242ac120003	4c8d8c1c-ed05-11ed-a05b-0242ac120003	ed799874-ed13-11ed-a05b-0242ac120003	periodic	2023-05-04 00:00:00	2023-05-07 00:00:00	2023-05-07 00:00:00	0	0
ebeee16a-ed10-11ed-a05b-0242ac120003	44ac1268-ecfe-11ed-a05b-0242ac120003	4c8d8da2-ed05-11ed-a05b-0242ac120003	ed799874-ed13-11ed-a05b-0242ac120003	periodic	2023-05-02 00:00:00	2023-05-07 00:00:00	2023-05-07 00:00:00	0	0
ebeee2d2-ed10-11ed-a05b-0242ac120003	44ac0f48-ecfe-11ed-a05b-0242ac120003	4c8d92f2-ed05-11ed-a05b-0242ac120003	ed799874-ed13-11ed-a05b-0242ac120003	points	2023-05-01 00:00:00	2023-05-07 00:00:00	2023-05-07 00:00:00	9	3
ebeee3f4-ed10-11ed-a05b-0242ac120003	44ac18bc-ecfe-11ed-a05b-0242ac120003	4c8d946e-ed05-11ed-a05b-0242ac120003	ed799874-ed13-11ed-a05b-0242ac120003	points	2023-05-01 00:00:00	2023-05-07 00:00:00	2023-05-07 00:00:00	6	1
ebeee516-ed10-11ed-a05b-0242ac120003	44ac0f48-ecfe-11ed-a05b-0242ac120003	4c8d95c2-ed05-11ed-a05b-0242ac120003	ed799874-ed13-11ed-a05b-0242ac120003	periodic	2023-05-01 00:00:00	2023-05-07 00:00:00	2023-05-07 00:00:00	0	0
ebeee62e-ed10-11ed-a05b-0242ac120003	44ac157e-ecfe-11ed-a05b-0242ac120003	4c8d9720-ed05-11ed-a05b-0242ac120003	ed799874-ed13-11ed-a05b-0242ac120003	periodic	2023-05-02 00:00:00	2023-05-07 00:00:00	2023-05-07 00:00:00	0	0
ebeee750-ed10-11ed-a05b-0242ac120003	44ac140c-ecfe-11ed-a05b-0242ac120003	4c8d986a-ed05-11ed-a05b-0242ac120003	ed799874-ed13-11ed-a05b-0242ac120003	points	2023-05-03 00:00:00	2023-05-07 00:00:00	2023-05-07 00:00:00	6	0
ebeee8ea-ed10-11ed-a05b-0242ac120003	44ac1c22-ecfe-11ed-a05b-0242ac120003	4c8d99b4-ed05-11ed-a05b-0242ac120003	ed799874-ed13-11ed-a05b-0242ac120003	periodic	2023-05-05 00:00:00	2023-05-07 00:00:00	2023-05-07 00:00:00	0	0
ebeeed22-ed10-11ed-a05b-0242ac120003	44ac1268-ecfe-11ed-a05b-0242ac120003	4c8d9b26-ed05-11ed-a05b-0242ac120003	ed799874-ed13-11ed-a05b-0242ac120003	points	2023-05-05 00:00:00	2023-05-07 00:00:00	2023-05-07 00:00:00	9	5
ebeeee4e-ed10-11ed-a05b-0242ac120003	44ac1c22-ecfe-11ed-a05b-0242ac120003	4c8d9f0e-ed05-11ed-a05b-0242ac120003	ed799874-ed13-11ed-a05b-0242ac120003	periodic	2023-05-04 00:00:00	2023-05-07 00:00:00	2023-05-07 00:00:00	0	0
ebeeef70-ed10-11ed-a05b-0242ac120003	44ac1268-ecfe-11ed-a05b-0242ac120003	4c8da076-ed05-11ed-a05b-0242ac120003	ed799874-ed13-11ed-a05b-0242ac120003	points	2023-05-05 00:00:00	2023-05-07 00:00:00	2023-05-07 00:00:00	9	0
ebeef092-ed10-11ed-a05b-0242ac120003	44ac1c22-ecfe-11ed-a05b-0242ac120003	4c8da1d4-ed05-11ed-a05b-0242ac120003	ed799874-ed13-11ed-a05b-0242ac120003	periodic	2023-05-04 00:00:00	2023-05-07 00:00:00	2023-05-07 00:00:00	0	0
ebeef1be-ed10-11ed-a05b-0242ac120003	44ac1a42-ecfe-11ed-a05b-0242ac120003	4c8da346-ed05-11ed-a05b-0242ac120003	ed799874-ed13-11ed-a05b-0242ac120003	points	2023-05-03 00:00:00	2023-05-07 00:00:00	2023-05-07 00:00:00	6	0
ebeef2d6-ed10-11ed-a05b-0242ac120003	44ac0f48-ecfe-11ed-a05b-0242ac120003	4c8da4a4-ed05-11ed-a05b-0242ac120003	ed799874-ed13-11ed-a05b-0242ac120003	periodic	2023-05-05 00:00:00	2023-05-07 00:00:00	2023-05-07 00:00:00	0	0
ebeef3ee-ed10-11ed-a05b-0242ac120003	44ac1a42-ecfe-11ed-a05b-0242ac120003	4c8da5e4-ed05-11ed-a05b-0242ac120003	ed799874-ed13-11ed-a05b-0242ac120003	points	2023-05-05 00:00:00	2023-05-07 00:00:00	2023-05-07 00:00:00	9	4
ebeef614-ed10-11ed-a05b-0242ac120003	44ac1c22-ecfe-11ed-a05b-0242ac120003	4c8da72e-ed05-11ed-a05b-0242ac120003	ed799874-ed13-11ed-a05b-0242ac120003	periodic	2023-05-04 00:00:00	2023-05-07 00:00:00	2023-05-07 00:00:00	0	0
ebeef98e-ed10-11ed-a05b-0242ac120003	44ac18bc-ecfe-11ed-a05b-0242ac120003	4c8dabe8-ed05-11ed-a05b-0242ac120003	ed799874-ed13-11ed-a05b-0242ac120003	points	2023-05-02 00:00:00	2023-05-07 00:00:00	2023-05-07 00:00:00	6	0
ebeefaa6-ed10-11ed-a05b-0242ac120003	44ac0f48-ecfe-11ed-a05b-0242ac120003	4c8dad5a-ed05-11ed-a05b-0242ac120003	ed799874-ed13-11ed-a05b-0242ac120003	periodic	2023-05-05 00:00:00	2023-05-07 00:00:00	2023-05-07 00:00:00	0	0
ebeefbbe-ed10-11ed-a05b-0242ac120003	44ac140c-ecfe-11ed-a05b-0242ac120003	4c8daeae-ed05-11ed-a05b-0242ac120003	ed799874-ed13-11ed-a05b-0242ac120003	points	2023-05-05 00:00:00	2023-05-07 00:00:00	2023-05-07 00:00:00	6	0
ebeefd08-ed10-11ed-a05b-0242ac120003	44ac140c-ecfe-11ed-a05b-0242ac120003	4c8db03e-ed05-11ed-a05b-0242ac120003	ed799874-ed13-11ed-a05b-0242ac120003	periodic	2023-05-01 00:00:00	2023-05-07 00:00:00	2023-05-07 00:00:00	0	0
ebeeffb0-ed10-11ed-a05b-0242ac120003	44ac1268-ecfe-11ed-a05b-0242ac120003	4c8db17e-ed05-11ed-a05b-0242ac120003	ed799874-ed13-11ed-a05b-0242ac120003	points	2023-05-05 00:00:00	2023-05-07 00:00:00	2023-05-07 00:00:00	9	2
ebef0104-ed10-11ed-a05b-0242ac120003	44ac172c-ecfe-11ed-a05b-0242ac120003	4c8db2c8-ed05-11ed-a05b-0242ac120003	ed799874-ed13-11ed-a05b-0242ac120003	points	2023-05-03 00:00:00	2023-05-07 00:00:00	2023-05-07 00:00:00	9	9
ebef021c-ed10-11ed-a05b-0242ac120003	44ac0f48-ecfe-11ed-a05b-0242ac120003	4c8db412-ed05-11ed-a05b-0242ac120003	ed799874-ed13-11ed-a05b-0242ac120003	periodic	2023-05-03 00:00:00	2023-05-07 00:00:00	2023-05-07 00:00:00	0	0
ebef032a-ed10-11ed-a05b-0242ac120003	44ac157e-ecfe-11ed-a05b-0242ac120003	4c8db886-ed05-11ed-a05b-0242ac120003	ed799874-ed13-11ed-a05b-0242ac120003	periodic	2023-05-05 00:00:00	2023-05-07 00:00:00	2023-05-07 00:00:00	0	0
ebef0884-ed10-11ed-a05b-0242ac120003	44ac0f48-ecfe-11ed-a05b-0242ac120003	4c8db9f8-ed05-11ed-a05b-0242ac120003	ed799874-ed13-11ed-a05b-0242ac120003	points	2023-05-03 00:00:00	2023-05-07 00:00:00	2023-05-07 00:00:00	6	1
ebef0b4a-ed10-11ed-a05b-0242ac120003	44ac172c-ecfe-11ed-a05b-0242ac120003	4c8dbb4c-ed05-11ed-a05b-0242ac120003	ed799874-ed13-11ed-a05b-0242ac120003	periodic	2023-05-05 00:00:00	2023-05-07 00:00:00	2023-05-07 00:00:00	0	0
ebef0c9e-ed10-11ed-a05b-0242ac120003	44ac140c-ecfe-11ed-a05b-0242ac120003	4c8dbcb4-ed05-11ed-a05b-0242ac120003	ed799874-ed13-11ed-a05b-0242ac120003	points	2023-05-04 00:00:00	2023-05-07 00:00:00	2023-05-07 00:00:00	9	5
ebef0dca-ed10-11ed-a05b-0242ac120003	44ac0f48-ecfe-11ed-a05b-0242ac120003	4c8dbdf4-ed05-11ed-a05b-0242ac120003	ed799874-ed13-11ed-a05b-0242ac120003	points	2023-05-02 00:00:00	2023-05-07 00:00:00	2023-05-07 00:00:00	9	4
ebef0ed8-ed10-11ed-a05b-0242ac120003	44ac1c22-ecfe-11ed-a05b-0242ac120003	4c8dbf52-ed05-11ed-a05b-0242ac120003	ed799874-ed13-11ed-a05b-0242ac120003	periodic	2023-05-01 00:00:00	2023-05-07 00:00:00	2023-05-07 00:00:00	0	0
d6cd1207-c5a4-4318-888d-e4be9d4b0719	44ac0368-ecfe-11ed-a05b-0242ac120003	4c8d87bc-ed05-11ed-a05b-0242ac124747	ed799874-ed13-11ed-a05b-0242ac120004	periodic	2023-05-17 13:01:26.446098	0202-05-17 13:01:00	0202-05-17 16:01:00	1	5
bb077b58-d6c5-4d9c-a7ab-45757f98e7fe	44ac0368-ecfe-11ed-a05b-0242ac120003	4c8d87bc-ed05-11ed-a05b-0242ac124747	ed799874-ed13-11ed-a05b-0242ac120003	periodic	2023-05-17 13:06:38.321487	0202-05-25 19:26:00	0202-05-26 01:26:00	1	5
54e57025-50cc-4383-9fb8-0e0879a7cbad	44ac0368-ecfe-11ed-a05b-0242ac120003	4c8d87bc-ed05-11ed-a05b-0242ac124747	ed799874-ed13-11ed-a05b-0242ac120004	periodic	2023-05-17 13:07:15.116412	0202-05-27 15:29:00	0202-05-27 18:29:00	1	5
6d56d01c-52aa-450b-8e1c-f944a99e5cf9	44ac0368-ecfe-11ed-a05b-0242ac120003	4c8d87bc-ed05-11ed-a05b-0242ac124747	ed799874-ed13-11ed-a05b-0242ac120004	periodic	2023-05-17 13:09:09.342329	0202-05-27 15:22:00	0202-05-27 18:22:00	1	5
3a862e70-68c5-4f9d-9d6b-4914ae90013e	44ac0368-ecfe-11ed-a05b-0242ac120003	4c8d87bc-ed05-11ed-a05b-0242ac124747	ed799874-ed13-11ed-a05b-0242ac120003	periodic	2023-05-17 21:01:52.437543	0202-05-18 10:20:00	0202-05-18 16:20:00	1	5
\.


--
-- TOC entry 3371 (class 0 OID 16390)
-- Dependencies: 210
-- Data for Name: Customers; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."Customers" (id, phone_number, username, name, email, surname, salted_password_hash) FROM stdin;
4c8d87bc-ed05-11ed-a05b-0242ac120003	+48 600600600	jakusko731	Jakub	jakusko731@gmail.com	Skoczylas	monkey
4c8d8c1c-ed05-11ed-a05b-0242ac120003	+48 986543234	adam.nowak32	Adam	adam.nowak32@gmail.com	Nowak	2$def456abc123
4c8d8da2-ed05-11ed-a05b-0242ac120003	+48 984567345	anna67	Anna	anna67@gmail.com	Malinowska	ghi789jkl012
4c8d92f2-ed05-11ed-a05b-0242ac120003	+48 981234456	kasia.dabrowska	Katarzyna	kasia.dabrowska@gmail.com	Dąbrowska	$mno345pqr678
4c8d946e-ed05-11ed-a05b-0242ac120003	+48 982345567	piotr.wolski22	Piotr	piotr.wolski22@gmail.com	Wolski	$stu90x234
4c8d95c2-ed05-11ed-a05b-0242ac120003	+48 983456678	agnieszka.adamska	Agnieszka	agnieszka.adamska@gmail.com	Adamska	$2a$12$ycde678
4c8d9720-ed05-11ed-a05b-0242ac120003	+48 984567789	mariusz.mazur1	Mariusz	mariusz.mazur1@gmail.com	Mazur	$2a$78ijk901
4c8d986a-ed05-11ed-a05b-0242ac120003	+48 985678890	marzena41	Marzena	marzena41@gmail.com	Szczepańska	lmn234opq567
4c8d99b4-ed05-11ed-a05b-0242ac120003	+48 986789901	pawel.jablonski	Paweł	pawel.jablonski@gmail.com	Jabłoński	$rst890uvw123
4c8d9b26-ed05-11ed-a05b-0242ac120003	+48 981234012	ewa99	Ewa	ewa99@gmail.com	Nowicka	yz456abc789
4c8d9f0e-ed05-11ed-a05b-0242ac120003	+48 123456789	janek123	Jan	janek@example.com	Kowalski	a4fGn92kPj
4c8da076-ed05-11ed-a05b-0242ac120003	+48 123456790	ania567	Anna	ania@example.com	Nowak	GhT1sL9pZd
4c8da1d4-ed05-11ed-a05b-0242ac120003	+48 123456791	jacek098	Jacek	jacek@example.com	Kaczmarek	xTf8mN3lBq
4c8da346-ed05-11ed-a05b-0242ac120003	+48 123456792	adam555	Adam	adam@example.com	Wójcik	iUg6pR2jMn
4c8da4a4-ed05-11ed-a05b-0242ac120003	+48 123456793	kasia345	Katarzyna	kasia@example.com	Piotrowska	lMn9iK3pQb
4c8da5e4-ed05-11ed-a05b-0242ac120003	+48 123456794	maciej123	Maciej	maciej@example.com	Lewandowski	yHn8jK2oLm
4c8da72e-ed05-11ed-a05b-0242ac120003	+48 123456795	iza777	Izabela	iza@example.com	Zielińska	cSd4fG1hTj
4c8dabe8-ed05-11ed-a05b-0242ac120003	+48 123456796	marta222	Marta	marta@example.com	Dąbrowska	qBw5eR2tYh
4c8dad5a-ed05-11ed-a05b-0242ac120003	+48 123456797	pawel321	Paweł	pawel@example.com	Włodarczyk	zKj6hG8fNp
4c8daeae-ed05-11ed-a05b-0242ac120003	+48 121456797	julia123	Julia	julia123@gmail.com	Nowak	$2a$1vglKN2DTpTnYW
4c8db03e-ed05-11ed-a05b-0242ac120003	+48 122456797	adam456	Adam	adam456@gmail.com	Kowalski	$2a$12$FpGEHP6
4c8db17e-ed05-11ed-a05b-0242ac120003	+48 124456797	marta789	Marta	marta789@gmail.com	Nowak	$2a$12$7hzh3lS
4c8db2c8-ed05-11ed-a05b-0242ac120003	+48 125456797	fan.maty	Milosz	fan.maty@gmail.com	Kuropatwa	bjj!
4c8db412-ed05-11ed-a05b-0242ac120003	+48 126456797	kasia567	Kasia	kasia567@gmail.com	Wójcik	$2a$12$8wLezlr4S
4c8db886-ed05-11ed-a05b-0242ac120003	+48 127456797	michal890	Michał	michal890@gmail.com	Lewandowski	$2amYEXN8gu
4c8db9f8-ed05-11ed-a05b-0242ac120003	+48 128456797	agata123	Agata	agata123@gmail.com	Jankowska	$2a$12$twGvPRO
4c8dbb4c-ed05-11ed-a05b-0242ac120003	+48 129456797	piotr456	Piotr	piotr456@gmail.com	Nowakowski	$2a$18K9nO
4c8dbcb4-ed05-11ed-a05b-0242ac120003	+48 120456797	natalia789	Natalia	natalia789@gmail.com	Kowalczyk	$2a$12
4c8dbdf4-ed05-11ed-a05b-0242ac120003	+48 120436797	andy.barcelona	Andrzej	andybarcelona@gmail.com	Masztal	barca!
4c8dbf52-ed05-11ed-a05b-0242ac120003	+48 120459797	natan.natural	Natan	natan.natural@gmail.com	Marcoń	tren!
4c8d87bc-ed05-11ed-a05b-0242ac124747	123123123	client	client	client@client.pl	client	client
e23db89c-68c6-421c-a278-568dac3eb8ea	123123123	nazwa_uzytkownika	Jan	jak@kowalski.pl	Kowalski	1234
\.


--
-- TOC entry 3372 (class 0 OID 16395)
-- Dependencies: 211
-- Data for Name: Employees; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."Employees" (id, phone_number, username, name, email, surname, salted_password_hash, role) FROM stdin;
44ac0368-ecfe-11ed-a05b-0242ac120003	364 345 555	adam1	Adam	adam1@gmail.com	Spinka	haslo1	assistant
44ac06b0-ecfe-11ed-a05b-0242ac120003	+48 501501501	karolina.nowak	Karolina	karolina.nowak@gmail.com	Nowak	cat	admin
44ac0f48-ecfe-11ed-a05b-0242ac120003	+48 502502502	krzysztof.adamczyk	Krzysztof	krzysztof.adamczyk@gmail.com	Adamczyk	dog	admin
44ac1268-ecfe-11ed-a05b-0242ac120003	+48 503503503	agnieszka.wójcik	Agnieszka	agnieszka.wojcik@gmail.com	Wójcik	hamster	assistant
44ac140c-ecfe-11ed-a05b-0242ac120003	+48 504504504	bartosz.kozłowski	Bartosz	bartosz.kozlowski@gmail.com	Kozłowski	lion	assistant
44ac157e-ecfe-11ed-a05b-0242ac120003	+48 505505505	maria.lewandowska	Maria	maria.lewandowska@gmail.com	Lewandowska	parrot	assistant
44ac172c-ecfe-11ed-a05b-0242ac120003	+48 506506506	andrzej.piotrowski	Andrzej	andrzej.piotrowski@gmail.com	Piotrowski	rabbit	assistant
44ac18bc-ecfe-11ed-a05b-0242ac120003	+48 507507507	anna.jakubowska	Anna	anna.jakubowska@gmail.com	Jakubowska	tiger	assistant
44ac1a42-ecfe-11ed-a05b-0242ac120003	+48 508508508	kamil.nowicki	Kamil	kamil.nowicki@gmail.com	Nowicki	zebra	assistant
44ac1c22-ecfe-11ed-a05b-0242ac120003	+48 509509509	patryk.adamski	Patryk	patryk.adamski@gmail.com	Adamski	elephant	assistant
44ac0368-ecfe-11ed-a05b-0242ac120074	123123123	assist	assist	assist	assist	assist	assistant
44ac0368-ecfe-11ed-a05b-0242ac120047	123123123	admin	admin	admin@admin.com	admin	admin	admin
\.


--
-- TOC entry 3373 (class 0 OID 16400)
-- Dependencies: 212
-- Data for Name: Entries; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."Entries" (id, carnet_id, entry_date, ski_lift_id) FROM stdin;
57091036-ed22-11ed-a05b-0242ac120003	ebeed7d8-ed10-11ed-a05b-0242ac120003	2023-05-07	b500f04a-ed0f-11ed-a05b-0242ac120003
57091612-ed22-11ed-a05b-0242ac120003	ebeed7d8-ed10-11ed-a05b-0242ac120003	2023-05-07	b500f3f6-ed0f-11ed-a05b-0242ac120003
570917b6-ed22-11ed-a05b-0242ac120003	ebeedac6-ed10-11ed-a05b-0242ac120003	2023-05-07	b500f3f6-ed0f-11ed-a05b-0242ac120003
57091932-ed22-11ed-a05b-0242ac120003	ebef0ed8-ed10-11ed-a05b-0242ac120003	2023-05-07	b500f3f6-ed0f-11ed-a05b-0242ac120003
57091aa4-ed22-11ed-a05b-0242ac120003	ebeee16a-ed10-11ed-a05b-0242ac120003	2023-05-07	b500f9be-ed0f-11ed-a05b-0242ac120003
57091c0c-ed22-11ed-a05b-0242ac120003	ebeee16a-ed10-11ed-a05b-0242ac120003	2023-05-07	b500f04a-ed0f-11ed-a05b-0242ac120003
57091d9c-ed22-11ed-a05b-0242ac120003	ebeee2d2-ed10-11ed-a05b-0242ac120003	2023-05-07	b500f04a-ed0f-11ed-a05b-0242ac120003
57091f22-ed22-11ed-a05b-0242ac120003	ebeee2d2-ed10-11ed-a05b-0242ac120003	2023-05-07	b500f04a-ed0f-11ed-a05b-0242ac120003
57092080-ed22-11ed-a05b-0242ac120003	ebeee3f4-ed10-11ed-a05b-0242ac120003	2023-05-07	b500f3f6-ed0f-11ed-a05b-0242ac120003
5709251c-ed22-11ed-a05b-0242ac120003	ebeee3f4-ed10-11ed-a05b-0242ac120003	2023-05-07	b500f3f6-ed0f-11ed-a05b-0242ac120003
570926ac-ed22-11ed-a05b-0242ac120003	ebeee516-ed10-11ed-a05b-0242ac120003	2023-05-07	b500f9be-ed0f-11ed-a05b-0242ac120003
57092832-ed22-11ed-a05b-0242ac120003	ebeee516-ed10-11ed-a05b-0242ac120003	2023-05-07	b500f04a-ed0f-11ed-a05b-0242ac120003
570929e0-ed22-11ed-a05b-0242ac120003	ebeee516-ed10-11ed-a05b-0242ac120003	2023-05-07	b500f3f6-ed0f-11ed-a05b-0242ac120003
57092b98-ed22-11ed-a05b-0242ac120003	ebeee62e-ed10-11ed-a05b-0242ac120003	2023-05-07	b500f3f6-ed0f-11ed-a05b-0242ac120003
57092d64-ed22-11ed-a05b-0242ac120003	ebeee62e-ed10-11ed-a05b-0242ac120003	2023-05-06	b500f04a-ed0f-11ed-a05b-0242ac120003
57092efe-ed22-11ed-a05b-0242ac120003	ebeee750-ed10-11ed-a05b-0242ac120003	2023-05-06	b500f9be-ed0f-11ed-a05b-0242ac120003
57093264-ed22-11ed-a05b-0242ac120003	ebeee750-ed10-11ed-a05b-0242ac120003	2023-05-06	b500f3f6-ed0f-11ed-a05b-0242ac120003
5709343a-ed22-11ed-a05b-0242ac120003	ebeee8ea-ed10-11ed-a05b-0242ac120003	2023-05-06	b500f9be-ed0f-11ed-a05b-0242ac120003
5709361a-ed22-11ed-a05b-0242ac120003	ebeee8ea-ed10-11ed-a05b-0242ac120003	2023-05-06	b500f04a-ed0f-11ed-a05b-0242ac120003
57093778-ed22-11ed-a05b-0242ac120003	ebeeed22-ed10-11ed-a05b-0242ac120003	2023-05-06	b500f04a-ed0f-11ed-a05b-0242ac120003
570938ea-ed22-11ed-a05b-0242ac120003	ebeeed22-ed10-11ed-a05b-0242ac120003	2023-05-06	b500f04a-ed0f-11ed-a05b-0242ac120003
57093a84-ed22-11ed-a05b-0242ac120003	ebeeee4e-ed10-11ed-a05b-0242ac120003	2023-05-06	b500f3f6-ed0f-11ed-a05b-0242ac120003
57093c00-ed22-11ed-a05b-0242ac120003	ebeeee4e-ed10-11ed-a05b-0242ac120003	2023-05-06	b500f9be-ed0f-11ed-a05b-0242ac120003
57093fe8-ed22-11ed-a05b-0242ac120003	ebeeef70-ed10-11ed-a05b-0242ac120003	2023-05-06	b500f3f6-ed0f-11ed-a05b-0242ac120003
570941d2-ed22-11ed-a05b-0242ac120003	ebeeef70-ed10-11ed-a05b-0242ac120003	2023-05-06	b500f9be-ed0f-11ed-a05b-0242ac120003
57094358-ed22-11ed-a05b-0242ac120003	ebeef092-ed10-11ed-a05b-0242ac120003	2023-05-06	b500f04a-ed0f-11ed-a05b-0242ac120003
570944ca-ed22-11ed-a05b-0242ac120003	ebeef092-ed10-11ed-a05b-0242ac120003	2023-05-05	b500f9be-ed0f-11ed-a05b-0242ac120003
5709461e-ed22-11ed-a05b-0242ac120003	ebeef1be-ed10-11ed-a05b-0242ac120003	2023-05-05	b500f3f6-ed0f-11ed-a05b-0242ac120003
57094772-ed22-11ed-a05b-0242ac120003	ebeef1be-ed10-11ed-a05b-0242ac120003	2023-05-05	b500f3f6-ed0f-11ed-a05b-0242ac120003
5709490c-ed22-11ed-a05b-0242ac120003	ebeef2d6-ed10-11ed-a05b-0242ac120003	2023-05-05	b500f04a-ed0f-11ed-a05b-0242ac120003
57094c86-ed22-11ed-a05b-0242ac120003	ebeef2d6-ed10-11ed-a05b-0242ac120003	2023-05-05	b500f9be-ed0f-11ed-a05b-0242ac120003
57094dd0-ed22-11ed-a05b-0242ac120003	ebeef3ee-ed10-11ed-a05b-0242ac120003	2023-05-05	b500f3f6-ed0f-11ed-a05b-0242ac120003
570950c8-ed22-11ed-a05b-0242ac120003	ebeef3ee-ed10-11ed-a05b-0242ac120003	2023-05-05	b500f9be-ed0f-11ed-a05b-0242ac120003
5709524e-ed22-11ed-a05b-0242ac120003	ebeef3ee-ed10-11ed-a05b-0242ac120003	2023-05-05	b500f04a-ed0f-11ed-a05b-0242ac120003
570953de-ed22-11ed-a05b-0242ac120003	ebeef614-ed10-11ed-a05b-0242ac120003	2023-05-05	b500f9be-ed0f-11ed-a05b-0242ac120003
5709555a-ed22-11ed-a05b-0242ac120003	ebeef614-ed10-11ed-a05b-0242ac120003	2023-05-04	b500f3f6-ed0f-11ed-a05b-0242ac120003
570956a4-ed22-11ed-a05b-0242ac120003	ebeef614-ed10-11ed-a05b-0242ac120003	2023-05-04	b500f9be-ed0f-11ed-a05b-0242ac120003
57095ba4-ed22-11ed-a05b-0242ac120003	ebeef98e-ed10-11ed-a05b-0242ac120003	2023-05-04	b500f04a-ed0f-11ed-a05b-0242ac120003
57095d16-ed22-11ed-a05b-0242ac120003	ebeef98e-ed10-11ed-a05b-0242ac120003	2023-05-04	b500f04a-ed0f-11ed-a05b-0242ac120003
57095e6a-ed22-11ed-a05b-0242ac120003	ebeefaa6-ed10-11ed-a05b-0242ac120003	2023-05-04	b500f04a-ed0f-11ed-a05b-0242ac120003
57095fb4-ed22-11ed-a05b-0242ac120003	ebeefbbe-ed10-11ed-a05b-0242ac120003	2023-05-04	b500f9be-ed0f-11ed-a05b-0242ac120003
57096108-ed22-11ed-a05b-0242ac120003	ebeefd08-ed10-11ed-a05b-0242ac120003	2023-05-04	b500f9be-ed0f-11ed-a05b-0242ac120003
57096266-ed22-11ed-a05b-0242ac120003	ebeeffb0-ed10-11ed-a05b-0242ac120003	2023-05-04	b500f04a-ed0f-11ed-a05b-0242ac120003
570963c4-ed22-11ed-a05b-0242ac120003	ebef0104-ed10-11ed-a05b-0242ac120003	2023-05-04	b500f04a-ed0f-11ed-a05b-0242ac120003
57096518-ed22-11ed-a05b-0242ac120003	ebef021c-ed10-11ed-a05b-0242ac120003	2023-05-04	b500f9be-ed0f-11ed-a05b-0242ac120003
570967f2-ed22-11ed-a05b-0242ac120003	ebef032a-ed10-11ed-a05b-0242ac120003	2023-05-04	b500f3f6-ed0f-11ed-a05b-0242ac120003
5709695a-ed22-11ed-a05b-0242ac120003	ebef0884-ed10-11ed-a05b-0242ac120003	2023-05-04	b500f3f6-ed0f-11ed-a05b-0242ac120003
57096a9a-ed22-11ed-a05b-0242ac120003	ebef0b4a-ed10-11ed-a05b-0242ac120003	2023-05-04	b500f04a-ed0f-11ed-a05b-0242ac120003
57096c34-ed22-11ed-a05b-0242ac120003	ebef0c9e-ed10-11ed-a05b-0242ac120003	2023-05-04	b500f9be-ed0f-11ed-a05b-0242ac120003
57096db0-ed22-11ed-a05b-0242ac120003	ebef0dca-ed10-11ed-a05b-0242ac120003	2023-05-04	b500f9be-ed0f-11ed-a05b-0242ac120003
\.


--
-- TOC entry 3374 (class 0 OID 16403)
-- Dependencies: 213
-- Data for Name: OpeningSchedule; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."OpeningSchedule" (id, lift_id, day_of_week, opening, closing) FROM stdin;
\.


--
-- TOC entry 3375 (class 0 OID 16406)
-- Dependencies: 214
-- Data for Name: Purchase; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."Purchase" (id, offer_id, customer_id, seller_id, date) FROM stdin;
\.


--
-- TOC entry 3376 (class 0 OID 16409)
-- Dependencies: 215
-- Data for Name: SkiLifts; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."SkiLifts" (id, name, location, cost, if_active, distance) FROM stdin;
b500f04a-ed0f-11ed-a05b-0242ac120003	charlift1	red	20	f	100
b500f3f6-ed0f-11ed-a05b-0242ac120003	charlift2	blue	30	t	200
b500f9be-ed0f-11ed-a05b-0242ac120003	charlift3	black	50	t	300
\.


--
-- TOC entry 3377 (class 0 OID 16415)
-- Dependencies: 216
-- Data for Name: TicketOffers; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."TicketOffers" (id, ticket_type, offer_starts, offer_ends, full_price, reduced_price, days, hours, points) FROM stdin;
ed799874-ed13-11ed-a05b-0242ac120003	periodic	2023-05-05	2023-08-08	$30.00	$15.00	0	6	0
ed799874-ed13-11ed-a05b-0242ac120004	periodic	2023-05-05	2023-08-08	$20.00	$10.00	0	3	0
ed799874-ed13-11ed-a05b-0242ac120005	periodic	2023-05-05	2023-08-08	$10.00	$5.00	0	1	0
\.


--
-- TOC entry 3378 (class 0 OID 16420)
-- Dependencies: 217
-- Data for Name: WeatherConditions; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."WeatherConditions" (temperature, snow_cm, date, lifts_open) FROM stdin;
2	3	2023-05-10 11:01:10.093717	0
123	1	2023-05-10 11:05:11.012603	0
3	5	2023-05-10 11:33:38.286269	2
\.


--
-- TOC entry 3200 (class 2606 OID 16424)
-- Name: Carnets Carnets_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Carnets"
    ADD CONSTRAINT "Carnets_pkey" PRIMARY KEY (id);


--
-- TOC entry 3202 (class 2606 OID 16426)
-- Name: Customers Customers_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Customers"
    ADD CONSTRAINT "Customers_pkey" PRIMARY KEY (id);


--
-- TOC entry 3204 (class 2606 OID 16428)
-- Name: Employees Employees_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Employees"
    ADD CONSTRAINT "Employees_pkey" PRIMARY KEY (id);


--
-- TOC entry 3206 (class 2606 OID 16430)
-- Name: Entries Entries_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Entries"
    ADD CONSTRAINT "Entries_pkey" PRIMARY KEY (id);


--
-- TOC entry 3208 (class 2606 OID 16432)
-- Name: SkiLifts SkiLifts_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."SkiLifts"
    ADD CONSTRAINT "SkiLifts_pkey" PRIMARY KEY (id);


--
-- TOC entry 3210 (class 2606 OID 16434)
-- Name: TicketOffers TicketOffers_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."TicketOffers"
    ADD CONSTRAINT "TicketOffers_pkey" PRIMARY KEY (id);


--
-- TOC entry 3211 (class 2606 OID 16435)
-- Name: Carnets Carnets_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Carnets"
    ADD CONSTRAINT "Carnets_customer_id_fkey" FOREIGN KEY (customer_id) REFERENCES public."Customers"(id) NOT VALID;


--
-- TOC entry 3212 (class 2606 OID 16440)
-- Name: Carnets Carnets_customer_id_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Carnets"
    ADD CONSTRAINT "Carnets_customer_id_fkey1" FOREIGN KEY (customer_id) REFERENCES public."Customers"(id) NOT VALID;


--
-- TOC entry 3213 (class 2606 OID 16445)
-- Name: Carnets Carnets_seller_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Carnets"
    ADD CONSTRAINT "Carnets_seller_id_fkey" FOREIGN KEY (seller_id) REFERENCES public."Employees"(id) NOT VALID;


--
-- TOC entry 3214 (class 2606 OID 16450)
-- Name: Carnets Carnets_seller_id_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Carnets"
    ADD CONSTRAINT "Carnets_seller_id_fkey1" FOREIGN KEY (seller_id) REFERENCES public."Employees"(id) NOT VALID;


--
-- TOC entry 3215 (class 2606 OID 16455)
-- Name: Carnets Carnets_ticket_offer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Carnets"
    ADD CONSTRAINT "Carnets_ticket_offer_id_fkey" FOREIGN KEY (ticket_offer_id) REFERENCES public."TicketOffers"(id) NOT VALID;


--
-- TOC entry 3216 (class 2606 OID 16460)
-- Name: Entries Entries_carnet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Entries"
    ADD CONSTRAINT "Entries_carnet_id_fkey" FOREIGN KEY (carnet_id) REFERENCES public."Carnets"(id) NOT VALID;


--
-- TOC entry 3217 (class 2606 OID 16465)
-- Name: Entries Entries_carnet_id_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Entries"
    ADD CONSTRAINT "Entries_carnet_id_fkey1" FOREIGN KEY (carnet_id) REFERENCES public."Carnets"(id) NOT VALID;


--
-- TOC entry 3218 (class 2606 OID 16470)
-- Name: Entries Entries_ski_lift_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Entries"
    ADD CONSTRAINT "Entries_ski_lift_id_fkey" FOREIGN KEY (ski_lift_id) REFERENCES public."SkiLifts"(id) NOT VALID;


--
-- TOC entry 3219 (class 2606 OID 16475)
-- Name: Entries Entries_ski_lift_id_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Entries"
    ADD CONSTRAINT "Entries_ski_lift_id_fkey1" FOREIGN KEY (ski_lift_id) REFERENCES public."SkiLifts"(id) NOT VALID;


--
-- TOC entry 3220 (class 2606 OID 16480)
-- Name: OpeningSchedule OpeningSchedule_lift_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."OpeningSchedule"
    ADD CONSTRAINT "OpeningSchedule_lift_id_fkey" FOREIGN KEY (lift_id) REFERENCES public."SkiLifts"(id) NOT VALID;


--
-- TOC entry 3221 (class 2606 OID 16485)
-- Name: OpeningSchedule OpeningSchedule_lift_id_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."OpeningSchedule"
    ADD CONSTRAINT "OpeningSchedule_lift_id_fkey1" FOREIGN KEY (lift_id) REFERENCES public."SkiLifts"(id) NOT VALID;


--
-- TOC entry 3222 (class 2606 OID 16490)
-- Name: OpeningSchedule OpeningSchedule_lift_id_fkey2; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."OpeningSchedule"
    ADD CONSTRAINT "OpeningSchedule_lift_id_fkey2" FOREIGN KEY (lift_id) REFERENCES public."SkiLifts"(id) NOT VALID;


--
-- TOC entry 3223 (class 2606 OID 16495)
-- Name: OpeningSchedule OpeningSchedule_lift_id_fkey3; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."OpeningSchedule"
    ADD CONSTRAINT "OpeningSchedule_lift_id_fkey3" FOREIGN KEY (lift_id) REFERENCES public."SkiLifts"(id) NOT VALID;


--
-- TOC entry 3224 (class 2606 OID 16500)
-- Name: OpeningSchedule OpeningSchedule_lift_id_fkey4; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."OpeningSchedule"
    ADD CONSTRAINT "OpeningSchedule_lift_id_fkey4" FOREIGN KEY (lift_id) REFERENCES public."SkiLifts"(id) NOT VALID;


--
-- TOC entry 3225 (class 2606 OID 16505)
-- Name: OpeningSchedule OpeningSchedule_lift_id_fkey5; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."OpeningSchedule"
    ADD CONSTRAINT "OpeningSchedule_lift_id_fkey5" FOREIGN KEY (lift_id) REFERENCES public."SkiLifts"(id) NOT VALID;


--
-- TOC entry 3226 (class 2606 OID 16510)
-- Name: Purchase Purchase_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Purchase"
    ADD CONSTRAINT "Purchase_customer_id_fkey" FOREIGN KEY (customer_id) REFERENCES public."Customers"(id) NOT VALID;


--
-- TOC entry 3227 (class 2606 OID 16515)
-- Name: Purchase Purchase_customer_id_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Purchase"
    ADD CONSTRAINT "Purchase_customer_id_fkey1" FOREIGN KEY (customer_id) REFERENCES public."Customers"(id) NOT VALID;


--
-- TOC entry 3228 (class 2606 OID 16520)
-- Name: Purchase Purchase_offer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Purchase"
    ADD CONSTRAINT "Purchase_offer_id_fkey" FOREIGN KEY (offer_id) REFERENCES public."TicketOffers"(id) NOT VALID;


--
-- TOC entry 3229 (class 2606 OID 16525)
-- Name: Purchase Purchase_seller_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Purchase"
    ADD CONSTRAINT "Purchase_seller_id_fkey" FOREIGN KEY (seller_id) REFERENCES public."Employees"(id) NOT VALID;


--
-- TOC entry 3230 (class 2606 OID 16530)
-- Name: Purchase Purchase_seller_id_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Purchase"
    ADD CONSTRAINT "Purchase_seller_id_fkey1" FOREIGN KEY (seller_id) REFERENCES public."Employees"(id) NOT VALID;


-- Completed on 2023-05-18 10:31:50 UTC

--
-- PostgreSQL database dump complete
--

