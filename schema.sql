--
-- PostgreSQL database dump
--

-- Dumped from database version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)
-- Dumped by pg_dump version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)

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
-- Name: artworks; Type: TABLE; Schema: public; Owner: omar-alaween
--

CREATE TABLE public.artworks (
    id integer NOT NULL,
    artist_id integer,
    title character varying(255),
    description text,
    image_url text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    price numeric(10,2)
);


ALTER TABLE public.artworks OWNER TO "omar-alaween";

--
-- Name: artworks_id_seq; Type: SEQUENCE; Schema: public; Owner: omar-alaween
--

CREATE SEQUENCE public.artworks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.artworks_id_seq OWNER TO "omar-alaween";

--
-- Name: artworks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: omar-alaween
--

ALTER SEQUENCE public.artworks_id_seq OWNED BY public.artworks.id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: omar-alaween
--

CREATE TABLE public.comments (
    id integer NOT NULL,
    user_id integer,
    artwork_id integer,
    text text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.comments OWNER TO "omar-alaween";

--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: omar-alaween
--

CREATE SEQUENCE public.comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comments_id_seq OWNER TO "omar-alaween";

--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: omar-alaween
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- Name: follows; Type: TABLE; Schema: public; Owner: omar-alaween
--

CREATE TABLE public.follows (
    id integer NOT NULL,
    follower_id integer,
    followed_artist_id integer
);


ALTER TABLE public.follows OWNER TO "omar-alaween";

--
-- Name: follows_id_seq; Type: SEQUENCE; Schema: public; Owner: omar-alaween
--

CREATE SEQUENCE public.follows_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.follows_id_seq OWNER TO "omar-alaween";

--
-- Name: follows_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: omar-alaween
--

ALTER SEQUENCE public.follows_id_seq OWNED BY public.follows.id;


--
-- Name: likes; Type: TABLE; Schema: public; Owner: omar-alaween
--

CREATE TABLE public.likes (
    id integer NOT NULL,
    user_id integer,
    artwork_id integer
);


ALTER TABLE public.likes OWNER TO "omar-alaween";

--
-- Name: likes_id_seq; Type: SEQUENCE; Schema: public; Owner: omar-alaween
--

CREATE SEQUENCE public.likes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.likes_id_seq OWNER TO "omar-alaween";

--
-- Name: likes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: omar-alaween
--

ALTER SEQUENCE public.likes_id_seq OWNED BY public.likes.id;


--
-- Name: purchases; Type: TABLE; Schema: public; Owner: omar-alaween
--

CREATE TABLE public.purchases (
    id integer NOT NULL,
    user_id integer,
    artwork_id integer
);


ALTER TABLE public.purchases OWNER TO "omar-alaween";

--
-- Name: saves_id_seq; Type: SEQUENCE; Schema: public; Owner: omar-alaween
--

CREATE SEQUENCE public.saves_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.saves_id_seq OWNER TO "omar-alaween";

--
-- Name: saves_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: omar-alaween
--

ALTER SEQUENCE public.saves_id_seq OWNED BY public.purchases.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: omar-alaween
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    password text NOT NULL,
    role character varying(10),
    avatar_url text,
    banner_url text,
    bio text,
    CONSTRAINT users_role_check CHECK (((role)::text = ANY ((ARRAY['artist'::character varying, 'buyer'::character varying])::text[])))
);


ALTER TABLE public.users OWNER TO "omar-alaween";

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: omar-alaween
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO "omar-alaween";

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: omar-alaween
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: artworks id; Type: DEFAULT; Schema: public; Owner: omar-alaween
--

ALTER TABLE ONLY public.artworks ALTER COLUMN id SET DEFAULT nextval('public.artworks_id_seq'::regclass);


--
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: omar-alaween
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- Name: follows id; Type: DEFAULT; Schema: public; Owner: omar-alaween
--

ALTER TABLE ONLY public.follows ALTER COLUMN id SET DEFAULT nextval('public.follows_id_seq'::regclass);


--
-- Name: likes id; Type: DEFAULT; Schema: public; Owner: omar-alaween
--

ALTER TABLE ONLY public.likes ALTER COLUMN id SET DEFAULT nextval('public.likes_id_seq'::regclass);


--
-- Name: purchases id; Type: DEFAULT; Schema: public; Owner: omar-alaween
--

ALTER TABLE ONLY public.purchases ALTER COLUMN id SET DEFAULT nextval('public.saves_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: omar-alaween
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: artworks; Type: TABLE DATA; Schema: public; Owner: omar-alaween
--

COPY public.artworks (id, artist_id, title, description, image_url, created_at, price) FROM stdin;
4	1	test1	test1	https://www.artic.edu/iiif/2/8883eecd-bff2-df0c-f4fc-dc157560cee8/full/843,/0/default.jpg	2025-06-17 19:10:41.433564	134.00
5	1	test 2	test 2	https://www.artic.edu/iiif/2/a91e7cd3-9da8-1d42-f86f-bd5593aa8cd9/full/843,/0/default.jpg	2025-06-17 19:12:33.495996	3423.00
6	1	test3	test3	https://www.artic.edu/iiif/2/f4b94d6c-9d94-d423-87f9-953ac0f45fec/full/843,/0/default.jpg	2025-06-17 19:13:02.928839	45.00
7	1	test 4	test 4	https://www.artic.edu/iiif/2/31f251e0-254c-1326-e5e5-f349a9d51d98/full/843,/0/default.jpg	2025-06-17 19:15:07.773752	53.00
\.


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: omar-alaween
--

COPY public.comments (id, user_id, artwork_id, text, created_at) FROM stdin;
1	23	7	hi	2025-06-18 15:55:09.133504
2	23	7	hello	2025-06-18 15:57:18.072385
3	23	7	h	2025-06-18 15:57:20.562015
4	23	7	h	2025-06-18 15:57:20.962158
5	23	7	h	2025-06-18 15:57:21.153941
6	23	7	h	2025-06-18 15:57:21.329962
7	23	7	h	2025-06-18 15:57:21.52961
8	21	7	hello	2025-06-18 17:43:25.982477
\.


--
-- Data for Name: follows; Type: TABLE DATA; Schema: public; Owner: omar-alaween
--

COPY public.follows (id, follower_id, followed_artist_id) FROM stdin;
4	21	1
5	24	1
\.


--
-- Data for Name: likes; Type: TABLE DATA; Schema: public; Owner: omar-alaween
--

COPY public.likes (id, user_id, artwork_id) FROM stdin;
4	21	7
5	21	6
\.


--
-- Data for Name: purchases; Type: TABLE DATA; Schema: public; Owner: omar-alaween
--

COPY public.purchases (id, user_id, artwork_id) FROM stdin;
1	21	7
2	21	6
4	21	4
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: omar-alaween
--

COPY public.users (id, username, email, password, role, avatar_url, banner_url, bio) FROM stdin;
12	test2	test2@email.com	0000	artist	\N	\N	\N
21	test3	test3@email.com	0000	buyer	\N	\N	\N
22	test4	test4@email.com	0000	buyer	\N	\N	\N
1	test1	test1@email.com	0000	artist	https://images.unsplash.com/photo-1534528741775-53994a69daeb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NjUzNjV8MHwxfHNlYXJjaHw0fHxwb3J0cmFpdHxlbnwwfDF8fHwxNzUwMTc5MDE4fDA&ixlib=rb-4.1.0&q=80&w=1080	https://images.unsplash.com/photo-1590845947670-c009801ffa74?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NjUzNjV8MHwxfHNlYXJjaHw1fHxiYW5uZXJ8ZW58MHwwfHx8MTc1MDE3OTI1M3ww&ixlib=rb-4.1.0&q=80&w=1080	hello, i love you 
23	test5	test5@email.com		buyer	https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NjUzNjV8MHwxfHNlYXJjaHw3fHxwb3J0cmFpdHxlbnwwfDF8fHwxNzUwMTc5MDE4fDA&ixlib=rb-4.1.0&q=80&w=1080	https://images.unsplash.com/photo-1513542789411-b6a5d4f31634?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NjUzNjV8MHwxfHNlYXJjaHw4fHxiYW5uZXJ8ZW58MHwwfHx8MTc1MDE3OTI1M3ww&ixlib=rb-4.1.0&q=80&w=1080	i am test 5
24	test6	test6@email.com	0000	artist	\N	\N	\N
\.


--
-- Name: artworks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: omar-alaween
--

SELECT pg_catalog.setval('public.artworks_id_seq', 7, true);


--
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: omar-alaween
--

SELECT pg_catalog.setval('public.comments_id_seq', 8, true);


--
-- Name: follows_id_seq; Type: SEQUENCE SET; Schema: public; Owner: omar-alaween
--

SELECT pg_catalog.setval('public.follows_id_seq', 5, true);


--
-- Name: likes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: omar-alaween
--

SELECT pg_catalog.setval('public.likes_id_seq', 5, true);


--
-- Name: saves_id_seq; Type: SEQUENCE SET; Schema: public; Owner: omar-alaween
--

SELECT pg_catalog.setval('public.saves_id_seq', 4, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: omar-alaween
--

SELECT pg_catalog.setval('public.users_id_seq', 24, true);


--
-- Name: artworks artworks_pkey; Type: CONSTRAINT; Schema: public; Owner: omar-alaween
--

ALTER TABLE ONLY public.artworks
    ADD CONSTRAINT artworks_pkey PRIMARY KEY (id);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: omar-alaween
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: follows follows_follower_id_followed_artist_id_key; Type: CONSTRAINT; Schema: public; Owner: omar-alaween
--

ALTER TABLE ONLY public.follows
    ADD CONSTRAINT follows_follower_id_followed_artist_id_key UNIQUE (follower_id, followed_artist_id);


--
-- Name: follows follows_pkey; Type: CONSTRAINT; Schema: public; Owner: omar-alaween
--

ALTER TABLE ONLY public.follows
    ADD CONSTRAINT follows_pkey PRIMARY KEY (id);


--
-- Name: likes likes_pkey; Type: CONSTRAINT; Schema: public; Owner: omar-alaween
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT likes_pkey PRIMARY KEY (id);


--
-- Name: likes likes_user_id_artwork_id_key; Type: CONSTRAINT; Schema: public; Owner: omar-alaween
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT likes_user_id_artwork_id_key UNIQUE (user_id, artwork_id);


--
-- Name: purchases saves_pkey; Type: CONSTRAINT; Schema: public; Owner: omar-alaween
--

ALTER TABLE ONLY public.purchases
    ADD CONSTRAINT saves_pkey PRIMARY KEY (id);


--
-- Name: purchases saves_user_id_artwork_id_key; Type: CONSTRAINT; Schema: public; Owner: omar-alaween
--

ALTER TABLE ONLY public.purchases
    ADD CONSTRAINT saves_user_id_artwork_id_key UNIQUE (user_id, artwork_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: omar-alaween
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: omar-alaween
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: artworks artworks_artist_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: omar-alaween
--

ALTER TABLE ONLY public.artworks
    ADD CONSTRAINT artworks_artist_id_fkey FOREIGN KEY (artist_id) REFERENCES public.users(id);


--
-- Name: comments comments_artwork_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: omar-alaween
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_artwork_id_fkey FOREIGN KEY (artwork_id) REFERENCES public.artworks(id);


--
-- Name: comments comments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: omar-alaween
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: purchases fk_artwork; Type: FK CONSTRAINT; Schema: public; Owner: omar-alaween
--

ALTER TABLE ONLY public.purchases
    ADD CONSTRAINT fk_artwork FOREIGN KEY (artwork_id) REFERENCES public.artworks(id);


--
-- Name: purchases fk_user; Type: FK CONSTRAINT; Schema: public; Owner: omar-alaween
--

ALTER TABLE ONLY public.purchases
    ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: follows follows_followed_artist_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: omar-alaween
--

ALTER TABLE ONLY public.follows
    ADD CONSTRAINT follows_followed_artist_id_fkey FOREIGN KEY (followed_artist_id) REFERENCES public.users(id);


--
-- Name: follows follows_follower_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: omar-alaween
--

ALTER TABLE ONLY public.follows
    ADD CONSTRAINT follows_follower_id_fkey FOREIGN KEY (follower_id) REFERENCES public.users(id);


--
-- Name: likes likes_artwork_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: omar-alaween
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT likes_artwork_id_fkey FOREIGN KEY (artwork_id) REFERENCES public.artworks(id);


--
-- Name: likes likes_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: omar-alaween
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT likes_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: purchases saves_artwork_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: omar-alaween
--

ALTER TABLE ONLY public.purchases
    ADD CONSTRAINT saves_artwork_id_fkey FOREIGN KEY (artwork_id) REFERENCES public.artworks(id);


--
-- Name: purchases saves_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: omar-alaween
--

ALTER TABLE ONLY public.purchases
    ADD CONSTRAINT saves_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

