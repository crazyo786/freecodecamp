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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

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
-- Name: asteroid; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.asteroid (
    asteroid_id integer NOT NULL,
    name character varying(30) NOT NULL,
    distance_from_earth numeric(4,1),
    size_in_width integer
);


ALTER TABLE public.asteroid OWNER TO freecodecamp;

--
-- Name: asteroid_asteroid_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.asteroid_asteroid_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.asteroid_asteroid_id_seq OWNER TO freecodecamp;

--
-- Name: asteroid_asteroid_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.asteroid_asteroid_id_seq OWNED BY public.asteroid.asteroid_id;


--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(30) NOT NULL,
    age_in_millions_of_years double precision NOT NULL,
    distance_from_earth double precision,
    galaxy_type character varying(60)
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(30) NOT NULL,
    distance_from_earth double precision,
    size_in_km double precision,
    has_water boolean,
    planet_id integer
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(30) NOT NULL,
    age_in_millions_of_years double precision NOT NULL,
    has_life boolean,
    is_spherical boolean,
    no_of_moons integer,
    description text,
    galaxy_id integer
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(30) NOT NULL,
    age_in_millions_of_years double precision NOT NULL,
    distance_from_earth double precision,
    size_in_km double precision,
    surface_temp double precision,
    galaxy_id integer
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: asteroid asteroid_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.asteroid ALTER COLUMN asteroid_id SET DEFAULT nextval('public.asteroid_asteroid_id_seq'::regclass);


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Data for Name: asteroid; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.asteroid VALUES (1, 'Apophis', 319.0, 1100);
INSERT INTO public.asteroid VALUES (2, 'Eros', 315.0, 3773);
INSERT INTO public.asteroid VALUES (3, 'Nereus', 1.2, 330);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Milky Way', 1101, 923330, 'spiral');
INSERT INTO public.galaxy VALUES (2, 'Large Magellanic Cloud', 10010, 158200, 'irregular dwarf galaxies');
INSERT INTO public.galaxy VALUES (3, 'Andromeda', 73, 2.537, 'spiral');
INSERT INTO public.galaxy VALUES (4, 'Triangulum', 13270, 2.723, 'spiral');
INSERT INTO public.galaxy VALUES (5, 'Centaurus A', 13310, 13.05, 'elliptical');
INSERT INTO public.galaxy VALUES (6, 'Bodes', 4503, 11.74, 'spiral');


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 'Moon', 400, 3474.8, true, 3);
INSERT INTO public.moon VALUES (2, 'Phobos', 23458, 11.267, true, 4);
INSERT INTO public.moon VALUES (3, 'Deimos', 23458, 6.2, true, 4);
INSERT INTO public.moon VALUES (4, 'Europa', 390.4, 1560.8, true, 6);
INSERT INTO public.moon VALUES (5, 'Ganymede', 1070000, 2634.1, true, 6);
INSERT INTO public.moon VALUES (6, 'lo', 628.3, 1821.6, false, 6);
INSERT INTO public.moon VALUES (7, 'lapetus', 1.272, 734.5, true, 7);
INSERT INTO public.moon VALUES (8, 'Enceladus', 1272, 504.2, true, 7);
INSERT INTO public.moon VALUES (9, 'Tethys', 294660, 1062, true, 7);
INSERT INTO public.moon VALUES (10, 'Miranda', 2.723, 235.8, true, 8);
INSERT INTO public.moon VALUES (11, 'Umbriel', 266000, 584.7, true, 8);
INSERT INTO public.moon VALUES (12, 'Titania', 436300, 1576.8, true, 8);
INSERT INTO public.moon VALUES (13, 'Triton', 4338, 1353.4, true, 9);
INSERT INTO public.moon VALUES (14, 'Nereid', 5513818, 170, true, 9);
INSERT INTO public.moon VALUES (15, 'Nix', 48694, 56, true, 10);
INSERT INTO public.moon VALUES (16, 'Kerberos', 396100, 12, true, 10);
INSERT INTO public.moon VALUES (17, 'Hiiaka', 7821534669, 310, true, 11);
INSERT INTO public.moon VALUES (18, 'Namaka', 7800423123, 170, true, 11);
INSERT INTO public.moon VALUES (19, 'MK2', 7821534669, 80, false, 12);
INSERT INTO public.moon VALUES (20, 'Dysnomea', 10125000000, 585, true, 13);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 'Mercury', 4503, false, true, NULL, 'Mercury is the smallest planet in the Solar System and the closest to the Sun.', 1);
INSERT INTO public.planet VALUES (2, 'Venus', 4503, false, true, NULL, 'Venus is the second planet from the Sun and is Earths closest planetary neighbor.', 1);
INSERT INTO public.planet VALUES (3, 'Earth', 4543, true, true, 1, 'Earth is the fifth largest planet in our solar system.', 1);
INSERT INTO public.planet VALUES (4, 'Mars', 4603, false, true, 2, 'Mars is the fourth planet from the Sun – a dusty,  cold,  desert world with a very thin atmosphere.', 1);
INSERT INTO public.planet VALUES (5, 'Crese', 4573, false, true, NULL, 'Ceres is a dwarf planet in the asteroid belt between the orbits of Mars and Jupiter.', 1);
INSERT INTO public.planet VALUES (6, 'Jupiter', 4603, false, true, 2, 'Jupiter is,  by far,  the largest planet in the solar system – more than twice as massive as all the other planets combined.', 1);
INSERT INTO public.planet VALUES (7, 'Saturn', 4503, false, true, 2, 'Saturn is the sixth planet from the Sun and the second-largest planet in our solar system.', 1);
INSERT INTO public.planet VALUES (8, 'Uranus', 4503, false, true, 2, 'Uranus is the seventh planet from the Sun,  and has the third-largest diameter in our solar system.', 1);
INSERT INTO public.planet VALUES (9, 'Neptune', 4503, false, true, 2, 'Neptune,  third most massive planet of the solar system and the eighth and outermost planet from the Sun.', 1);
INSERT INTO public.planet VALUES (10, 'Pluto', 4600, false, true, 2, 'Pluto is a dwarf planet in the Kuiper Belt,  a donut-shaped region of icy bodies beyond the orbit of Neptune.', 1);
INSERT INTO public.planet VALUES (11, 'Haumea', 4503, false, true, 2, 'Dwarf planet Haumea is a member of a group of objects that orbit in a disc-like zone beyond the orbit of Neptune called the Kuiper Belt.', 1);
INSERT INTO public.planet VALUES (12, 'MakeMake', 4503, false, true, 1, 'Makemake is 1, 300 times brighter than its moon and is also much larger,  at 870 miles across.', 1);
INSERT INTO public.planet VALUES (13, 'Eris', 4503, false, true, 1, 'Eris is one of the largest known dwarf planets in our solar system. Its about the same size as Pluto but is three times farther from the Sun.', 1);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'Proxima Centauri', 4853, 4.246, 214550, 3042, 1);
INSERT INTO public.star VALUES (2, 'Alpha Centauri B', 6000, 4.35, 1.2016, 5260, 1);
INSERT INTO public.star VALUES (3, 'Alpha Centauri A', 6000, 4.367, 1.7022, 5790, 1);
INSERT INTO public.star VALUES (4, 'Barnards Star', 10100, 5.978, 136360, 3134, 1);
INSERT INTO public.star VALUES (5, 'Lalande 21185', 10000, 8.307, 273530, 3828, 1);
INSERT INTO public.star VALUES (6, 'Sirius', 242, 8.611, 2.4, 44900, 1);


--
-- Name: asteroid_asteroid_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.asteroid_asteroid_id_seq', 3, true);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 6, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 20, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 13, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 6, true);


--
-- Name: asteroid asteroid_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.asteroid
    ADD CONSTRAINT asteroid_name_key UNIQUE (name);


--
-- Name: asteroid asteroid_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.asteroid
    ADD CONSTRAINT asteroid_pkey PRIMARY KEY (asteroid_id);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

