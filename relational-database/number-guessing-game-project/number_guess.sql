--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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
-- Name: games; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.games (
    game_id integer NOT NULL,
    user_id integer NOT NULL,
    number_of_guesses integer,
    secret_number integer
);


ALTER TABLE public.games OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.games_game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_game_id_seq OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.games_game_id_seq OWNED BY public.games.game_id;


--
-- Name: players; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.players (
    user_id integer NOT NULL,
    username character varying(50) NOT NULL
);


ALTER TABLE public.players OWNER TO freecodecamp;

--
-- Name: players_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.players_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.players_user_id_seq OWNER TO freecodecamp;

--
-- Name: players_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.players_user_id_seq OWNED BY public.players.user_id;


--
-- Name: games game_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games ALTER COLUMN game_id SET DEFAULT nextval('public.games_game_id_seq'::regclass);


--
-- Name: players user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.players ALTER COLUMN user_id SET DEFAULT nextval('public.players_user_id_seq'::regclass);


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.games VALUES (1, 1, 3, 708);
INSERT INTO public.games VALUES (2, 2, 63, 62);
INSERT INTO public.games VALUES (3, 2, 105, 104);
INSERT INTO public.games VALUES (4, 3, 481, 480);
INSERT INTO public.games VALUES (5, 3, 321, 320);
INSERT INTO public.games VALUES (6, 2, 882, 879);
INSERT INTO public.games VALUES (7, 2, 613, 612);
INSERT INTO public.games VALUES (8, 2, 480, 479);
INSERT INTO public.games VALUES (9, 4, 673, 672);
INSERT INTO public.games VALUES (10, 4, 184, 183);
INSERT INTO public.games VALUES (11, 5, 31, 30);
INSERT INTO public.games VALUES (12, 5, 545, 544);
INSERT INTO public.games VALUES (13, 4, 405, 402);
INSERT INTO public.games VALUES (14, 4, 294, 293);
INSERT INTO public.games VALUES (15, 4, 229, 228);
INSERT INTO public.games VALUES (16, 6, 89, 88);
INSERT INTO public.games VALUES (17, 7, 886, 885);
INSERT INTO public.games VALUES (18, 7, 340, 339);
INSERT INTO public.games VALUES (19, 6, 461, 458);
INSERT INTO public.games VALUES (20, 6, 293, 292);
INSERT INTO public.games VALUES (21, 6, 630, 629);
INSERT INTO public.games VALUES (22, 8, 591, 590);
INSERT INTO public.games VALUES (23, 8, 827, 826);
INSERT INTO public.games VALUES (24, 9, 762, 761);
INSERT INTO public.games VALUES (25, 9, 407, 406);
INSERT INTO public.games VALUES (26, 8, 49, 46);
INSERT INTO public.games VALUES (27, 8, 477, 476);
INSERT INTO public.games VALUES (28, 8, 844, 843);
INSERT INTO public.games VALUES (29, 10, 365, 364);
INSERT INTO public.games VALUES (30, 10, 463, 462);
INSERT INTO public.games VALUES (31, 11, 621, 620);
INSERT INTO public.games VALUES (32, 11, 591, 590);
INSERT INTO public.games VALUES (33, 10, 235, 232);
INSERT INTO public.games VALUES (34, 10, 244, 243);
INSERT INTO public.games VALUES (35, 10, 598, 597);
INSERT INTO public.games VALUES (36, 12, 729, 728);
INSERT INTO public.games VALUES (37, 13, 847, 846);
INSERT INTO public.games VALUES (38, 13, 479, 478);
INSERT INTO public.games VALUES (39, 12, 847, 844);
INSERT INTO public.games VALUES (40, 12, 872, 871);
INSERT INTO public.games VALUES (41, 12, 727, 726);
INSERT INTO public.games VALUES (42, 14, 682, 681);
INSERT INTO public.games VALUES (43, 14, 374, 373);
INSERT INTO public.games VALUES (44, 15, 565, 564);
INSERT INTO public.games VALUES (45, 14, 562, 559);
INSERT INTO public.games VALUES (46, 14, 694, 693);
INSERT INTO public.games VALUES (47, 14, 743, 742);
INSERT INTO public.games VALUES (48, 16, 33, 32);
INSERT INTO public.games VALUES (49, 17, 20, 19);
INSERT INTO public.games VALUES (50, 17, 433, 432);
INSERT INTO public.games VALUES (51, 16, 818, 815);
INSERT INTO public.games VALUES (52, 16, 352, 351);
INSERT INTO public.games VALUES (53, 16, 383, 382);
INSERT INTO public.games VALUES (54, 18, 46, 45);
INSERT INTO public.games VALUES (55, 18, 751, 750);
INSERT INTO public.games VALUES (56, 19, 745, 744);
INSERT INTO public.games VALUES (57, 19, 522, 521);
INSERT INTO public.games VALUES (58, 18, 799, 796);
INSERT INTO public.games VALUES (59, 18, 91, 90);
INSERT INTO public.games VALUES (60, 18, 281, 280);
INSERT INTO public.games VALUES (61, 20, 685, 684);
INSERT INTO public.games VALUES (62, 20, 239, 238);
INSERT INTO public.games VALUES (63, 21, 717, 716);
INSERT INTO public.games VALUES (64, 21, 52, 51);
INSERT INTO public.games VALUES (65, 20, 386, 383);
INSERT INTO public.games VALUES (66, 20, 25, 24);
INSERT INTO public.games VALUES (67, 20, 141, 140);
INSERT INTO public.games VALUES (68, 22, 836, 835);
INSERT INTO public.games VALUES (69, 22, 249, 248);
INSERT INTO public.games VALUES (70, 23, 122, 121);
INSERT INTO public.games VALUES (71, 23, 512, 511);
INSERT INTO public.games VALUES (72, 22, 577, 574);
INSERT INTO public.games VALUES (73, 22, 959, 958);
INSERT INTO public.games VALUES (74, 22, 366, 365);
INSERT INTO public.games VALUES (75, 24, 635, 634);
INSERT INTO public.games VALUES (76, 25, 915, 914);
INSERT INTO public.games VALUES (77, 25, 725, 724);
INSERT INTO public.games VALUES (78, 24, 578, 575);
INSERT INTO public.games VALUES (79, 24, 412, 411);
INSERT INTO public.games VALUES (80, 24, 976, 975);
INSERT INTO public.games VALUES (81, 26, 84, 83);
INSERT INTO public.games VALUES (82, 26, 664, 663);
INSERT INTO public.games VALUES (83, 27, 53, 52);
INSERT INTO public.games VALUES (84, 27, 239, 238);
INSERT INTO public.games VALUES (85, 26, 590, 587);
INSERT INTO public.games VALUES (86, 26, 125, 124);
INSERT INTO public.games VALUES (87, 26, 438, 437);
INSERT INTO public.games VALUES (88, 28, 38, 37);
INSERT INTO public.games VALUES (89, 28, 797, 796);
INSERT INTO public.games VALUES (90, 29, 325, 324);
INSERT INTO public.games VALUES (91, 29, 672, 671);
INSERT INTO public.games VALUES (92, 28, 849, 846);
INSERT INTO public.games VALUES (93, 28, 497, 496);
INSERT INTO public.games VALUES (94, 28, 320, 319);
INSERT INTO public.games VALUES (95, 30, 275, 274);
INSERT INTO public.games VALUES (96, 30, 942, 941);
INSERT INTO public.games VALUES (97, 31, 59, 58);
INSERT INTO public.games VALUES (98, 31, 30, 29);
INSERT INTO public.games VALUES (99, 30, 1002, 999);
INSERT INTO public.games VALUES (100, 30, 928, 927);
INSERT INTO public.games VALUES (101, 30, 961, 960);
INSERT INTO public.games VALUES (102, 32, 612, 611);
INSERT INTO public.games VALUES (103, 32, 163, 162);
INSERT INTO public.games VALUES (104, 33, 335, 334);
INSERT INTO public.games VALUES (105, 33, 905, 904);
INSERT INTO public.games VALUES (106, 32, 972, 969);
INSERT INTO public.games VALUES (107, 32, 638, 637);
INSERT INTO public.games VALUES (108, 32, 351, 350);
INSERT INTO public.games VALUES (109, 34, 741, 740);
INSERT INTO public.games VALUES (110, 34, 532, 531);
INSERT INTO public.games VALUES (111, 35, 573, 572);
INSERT INTO public.games VALUES (112, 35, 225, 224);
INSERT INTO public.games VALUES (113, 34, 616, 613);
INSERT INTO public.games VALUES (114, 34, 520, 519);
INSERT INTO public.games VALUES (115, 34, 342, 341);
INSERT INTO public.games VALUES (116, 36, 275, 274);
INSERT INTO public.games VALUES (117, 36, 645, 644);
INSERT INTO public.games VALUES (118, 37, 57, 56);
INSERT INTO public.games VALUES (119, 37, 108, 107);
INSERT INTO public.games VALUES (120, 36, 604, 601);
INSERT INTO public.games VALUES (121, 36, 462, 461);
INSERT INTO public.games VALUES (122, 36, 818, 817);
INSERT INTO public.games VALUES (123, 38, 468, 467);
INSERT INTO public.games VALUES (124, 38, 308, 307);
INSERT INTO public.games VALUES (125, 39, 207, 206);
INSERT INTO public.games VALUES (126, 39, 608, 607);
INSERT INTO public.games VALUES (127, 38, 14, 11);
INSERT INTO public.games VALUES (128, 38, 449, 448);
INSERT INTO public.games VALUES (129, 38, 243, 242);
INSERT INTO public.games VALUES (130, 40, 80, 79);
INSERT INTO public.games VALUES (131, 40, 768, 767);
INSERT INTO public.games VALUES (132, 41, 441, 440);
INSERT INTO public.games VALUES (133, 41, 210, 209);
INSERT INTO public.games VALUES (134, 40, 45, 42);
INSERT INTO public.games VALUES (135, 40, 954, 953);
INSERT INTO public.games VALUES (136, 40, 516, 515);
INSERT INTO public.games VALUES (137, 42, 201, 200);
INSERT INTO public.games VALUES (138, 42, 741, 740);
INSERT INTO public.games VALUES (139, 43, 888, 887);
INSERT INTO public.games VALUES (140, 43, 393, 392);
INSERT INTO public.games VALUES (141, 42, 303, 300);
INSERT INTO public.games VALUES (142, 42, 128, 127);
INSERT INTO public.games VALUES (143, 42, 877, 876);
INSERT INTO public.games VALUES (144, 44, 978, 977);
INSERT INTO public.games VALUES (145, 44, 951, 950);
INSERT INTO public.games VALUES (146, 45, 923, 922);
INSERT INTO public.games VALUES (147, 45, 125, 124);
INSERT INTO public.games VALUES (148, 44, 466, 463);
INSERT INTO public.games VALUES (149, 44, 944, 943);
INSERT INTO public.games VALUES (150, 44, 794, 793);


--
-- Data for Name: players; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.players VALUES (1, 'Mb');
INSERT INTO public.players VALUES (2, 'user_1683206260791');
INSERT INTO public.players VALUES (3, 'user_1683206260790');
INSERT INTO public.players VALUES (4, 'user_1683256853544');
INSERT INTO public.players VALUES (5, 'user_1683256853543');
INSERT INTO public.players VALUES (6, 'user_1683256947479');
INSERT INTO public.players VALUES (7, 'user_1683256947478');
INSERT INTO public.players VALUES (8, 'user_1683256978506');
INSERT INTO public.players VALUES (9, 'user_1683256978505');
INSERT INTO public.players VALUES (10, 'user_1683256994800');
INSERT INTO public.players VALUES (11, 'user_1683256994799');
INSERT INTO public.players VALUES (12, 'user_1683257008723');
INSERT INTO public.players VALUES (13, 'user_1683257008722');
INSERT INTO public.players VALUES (14, 'user_1683257031623');
INSERT INTO public.players VALUES (15, 'user_1683257031622');
INSERT INTO public.players VALUES (16, 'user_1683257108023');
INSERT INTO public.players VALUES (17, 'user_1683257108022');
INSERT INTO public.players VALUES (18, 'user_1683257129974');
INSERT INTO public.players VALUES (19, 'user_1683257129973');
INSERT INTO public.players VALUES (20, 'user_1683257156002');
INSERT INTO public.players VALUES (21, 'user_1683257156001');
INSERT INTO public.players VALUES (22, 'user_1683257166644');
INSERT INTO public.players VALUES (23, 'user_1683257166643');
INSERT INTO public.players VALUES (24, 'user_1683257182360');
INSERT INTO public.players VALUES (25, 'user_1683257182359');
INSERT INTO public.players VALUES (26, 'user_1683257196138');
INSERT INTO public.players VALUES (27, 'user_1683257196137');
INSERT INTO public.players VALUES (28, 'user_1683257210568');
INSERT INTO public.players VALUES (29, 'user_1683257210567');
INSERT INTO public.players VALUES (30, 'user_1683257297813');
INSERT INTO public.players VALUES (31, 'user_1683257297812');
INSERT INTO public.players VALUES (32, 'user_1683257406374');
INSERT INTO public.players VALUES (33, 'user_1683257406373');
INSERT INTO public.players VALUES (34, 'user_1683257469817');
INSERT INTO public.players VALUES (35, 'user_1683257469816');
INSERT INTO public.players VALUES (36, 'user_1683257489824');
INSERT INTO public.players VALUES (37, 'user_1683257489823');
INSERT INTO public.players VALUES (38, 'user_1683257503797');
INSERT INTO public.players VALUES (39, 'user_1683257503796');
INSERT INTO public.players VALUES (40, 'user_1683257515517');
INSERT INTO public.players VALUES (41, 'user_1683257515516');
INSERT INTO public.players VALUES (42, 'user_1683257539715');
INSERT INTO public.players VALUES (43, 'user_1683257539714');
INSERT INTO public.players VALUES (44, 'user_1683258638658');
INSERT INTO public.players VALUES (45, 'user_1683258638657');


--
-- Name: games_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.games_game_id_seq', 150, true);


--
-- Name: players_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.players_user_id_seq', 45, true);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (game_id);


--
-- Name: players players_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_pkey PRIMARY KEY (user_id);


--
-- Name: players players_username_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_username_key UNIQUE (username);


--
-- Name: games games_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.players(user_id);


--
-- PostgreSQL database dump complete
--

