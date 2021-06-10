---IST 659 Divya,Ken,Andrew up/down/insert for final project
--status_lookup,subscibers,billings,users,app_ratings,user_plays,user_types,
--audio,lyrics,artists,songs,advertisments,albums,song_genre_id,genre
--down-----------------------------down--------------down------------------------------------------down-----------------------down
if exists(select*from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
        where CONSTRAINT_NAME='fk_song_genre_lookup_song_genre_genre_id')
        alter table song_genre_lookup drop constraint fk_song_genre_lookup_song_genre_genre_id 
go    
if exists(select*from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
        where CONSTRAINT_NAME='fk_song_genre_lookup_song_genre_id')
        alter table song_genre_lookup drop constraint fk_song_genre_lookup_song_genre_id 
go    
if exists(select*from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
        where CONSTRAINT_NAME='fk_albums_album_artist_id_id')
        alter table albums drop constraint fk_albums_album_artist_id_id 
go    
if exists(select*from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
        where CONSTRAINT_NAME='fk_albums_album_song_id_id')
        alter table albums drop constraint fk_albums_album_song_id_id 
go    
drop table if exists genres
GO
drop table if exists song_genre_lookup
GO
drop table if exists albums
go
if exists(select*from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
        where CONSTRAINT_NAME='fk_advertisement_advertisement_song_id_id')
        alter table advertisements drop constraint fk_advertisement_advertisement_song_id_id 
go      
if exists(select*from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
        where CONSTRAINT_NAME='fk_artists_artist_song_id')
        alter table artists drop constraint fk_artists_artist_song_id 
go      
drop table if exists advertisements
go
drop table if exists artists
go
--down--2
if exists(select*from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
        where CONSTRAINT_NAME='fk_inputs_input_song_id')
        alter table inputs drop constraint fk_inputs_input_song_id
go
if exists(select*from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
        where CONSTRAINT_NAME='fk_inputs_input_user_id')
        alter table inputs drop constraint fk_inputs_input_user_id
go
drop table if exists songs
go
drop table if exists inputs
go
drop table if exists app_ratings
go
if exists(select*from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
        where CONSTRAINT_NAME='fk_subscriptions_subscriber_user_id')
        alter table subscriptions drop constraint fk_subscriptions_subscriber_user_id
drop table if exists users
go
drop table if exists subscriptions
GO

--up----------------------------------------------up--------------------------------------up------------------------------------------


create table subscriptions(
    subscription_id int not null,
    subscription_title varchar(50) not NULL,
    subscriber_status varchar(30) not NULL,
    subscriber_user_id int not NULL,
    constraint pk_subscriptions_suscription_id PRIMARY KEY (subscription_id),
)

--up--2

create table users(
    user_id int not NULL,
    user_username varchar(50) not NULL,
    user_email_address VARCHAR(50) not null,
    user_first_name VARCHAR(50) not NULL,
    user_lastname VARCHAR(50) not null,
    user_phone_number int not null,
    user_street varchar(50) not null,
    user_city varchar(50) not null,
    user_state varchar(50) not null,
    user_zip_code int not null,
    user_credit_card_no varchar(50) not null,
    constraint pk_users_user_id PRIMARY KEY (user_id),
    CONSTRAINT u_users_username unique(user_username),
    CONSTRAINT u_users_user_email_address unique(user_email_address),
    
)
GO
alter table subscriptions
    add CONSTRAINT fk_subscriptions_subscriber_user_id FOREIGN KEY (subscriber_user_id)
        REFERENCES users(user_id)
go
create table app_ratings(
    app_rating_rating_id int not null,
    app_rating_rating int not NULL,
    app_rating_user_id int not null,
    constraint pk_app_ratings_rating_id PRIMARY KEY (app_rating_rating_id),
    constraint u_app_ratings_rating_user_id unique(app_rating_user_id)

)
alter table app_ratings
    add CONSTRAINT fk_app_ratings_app_rating_user_id FOREIGN KEY (app_rating_user_id)
        REFERENCES users(user_id)
go

--up--3
create table inputs(
    input_id int not null,
    input_lyrics varchar(50) not null,
    input_audio varchar(50) not null,
    input_date date not NULL,
    input_user_id int not null,
    input_song_id int null,
    constraint pk_inputs_input_id PRIMARY KEY (input_id),
)
go
create table songs(
    song_id int not null,
    song_song_name varchar(50) not NULL,
    song_lyrics varchar(50) not null,
    song_audio varchar(50) not null,
    constraint pk_songs_song_id PRIMARY KEY (song_id),
    constraint u_songs_id unique (song_song_name)
)

go
alter table inputs
    add CONSTRAINT fk_inputs_input_user_id FOREIGN KEY (input_user_id)
        REFERENCES users(user_id)
go
alter table inputs
    add CONSTRAINT fk_inputs_input_song_id FOREIGN KEY (input_song_id)
        REFERENCES songs(song_id)
go
create table artists(
    artist_id int not NULL,
    artist_name varchar(50) not NULL,
    arist_birthdate varchar(30) null,
    artist_birth_place varchar(30) null,
    artist_song_id int not null,
    constraint pk_artists_artist_id PRIMARY KEY (artist_id),
    CONSTRAINT u_artist_artist_name unique (artist_name)
)
go
create table advertisements(
    advertisement_id int not null,
    advertisement_brand_name varchar(50) not null,
    advertisement_status varchar(30) not null,
    advertisement_art varchar(30) null,
    advertisement_song_id int not null,
    constraint pk_advertisements_advertisement_id PRIMARY KEY (advertisement_id),

)
go
alter table artists
    add CONSTRAINT fk_artists_artist_song_id FOREIGN KEY (artist_song_id)
        REFERENCES songs(song_id)
go
alter table advertisements
    add CONSTRAINT fk_advertisement_advertisement_song_id_id FOREIGN KEY (advertisement_song_id)
        REFERENCES songs(song_id)
go
create table albums(
    album_id int not null,
    album_title varchar(50) not null,
    album_release_year varchar(30) not null,
    album_art varchar(50) null,
    album_song_id int not null,
    album_artist_id int not null,
    CONSTRAINT pk_albums_album_id primary key(album_id),
    CONSTRAINT u_albums_composite_id unique(album_title,album_artist_id)
)
go
create table song_genre_lookup(
    song_genre_id int not NULL,
    song_genre_genre_id int not null,
    CONSTRAINT pk_song_genre_lookup_composite_id primary key(song_genre_id,song_genre_genre_id),
)
go
create table genres(
    genre_id int not null,
    genre_title varchar(50) not NULL
    CONSTRAINT pk_genres_genre_id primary key(genre_id),
    CONSTRAINT u_genres_genre_title unique (genre_title),
)
go
alter table albums
    add CONSTRAINT fk_albums_album_song_id_id FOREIGN KEY (album_song_id)
        REFERENCES songs(song_id)
go
alter table albums
    add CONSTRAINT fk_albums_album_artist_id_id FOREIGN KEY (album_artist_id)
        REFERENCES artists(artist_id)
go
alter table song_genre_lookup
    add CONSTRAINT fk_song_genre_lookup_song_genre_id FOREIGN KEY (song_genre_id)
        REFERENCES songs(song_id)
go
alter table song_genre_lookup
    add constraint fk_song_genre_lookup_song_genre_genre_id FOREIGN KEY (song_genre_genre_id)
        references genres(genre_id)
go

----order is important!Foreign keys mess up if this is out of order
--tables
--status_lookup,subscibers,billings,users,app_ratings,user_plays,user_types,
--audio,lyrics,artists,songs,advertisments,albums,song_genre_id,genre
insert into users
        ( user_id,user_username,user_email_address,user_first_name,user_lastname,
    user_phone_number,user_street,user_city,user_state,user_zip_code,user_credit_card_no)
        Values
        (1,'bigsongster','songsareme@yahoo.com','Bob','Vance',293,'Beale Ave','Tampa Bay','FL',12121,111222331123),
        (2,'strokesfanatic123','ijustnod@yahoo.com','Corn','Hobart',332,'Strict Street','Syracuse','NY',32031,112322333322),
        (3,'ambientking','anothergreenworld@gmail.com','Brian','Eno',213,'Berlin Place','Las Vegas','NV',13432,1122121344),
        (4,'screenslayer','parrfamily@yahoo.com','Bob','Parr',098,'Ex Ave','Los Angeles','CA',23456,21223349493205098),
        (5,'dababyinstalive','billiondollarbaby@yahoo.com','Kirk','isMyDad',456,'1 Way','Charlotte','NC',76483,24864391203321)
insert into subscriptions
    (subscription_id,subscription_title,subscriber_status,subscriber_user_id)
    VALUES
    (6,'Platinum','Active',1),
    (7,'Gold','Inactive',2),
    (8,'Gold','Active',3),
    (9,'Bronze','Inactive',4),
    (10,'Silver','Active',5)
GO--------The INSERT statement conflicted with the FOREIGN KEY constraint "fk_subscribers_subsriber_user_id". The conflict occurred in database "tinyu", table "dbo.users", column 'user_id'.

insert into app_ratings
        (app_rating_rating_id,app_rating_rating,app_rating_user_id)
        VALUES
        (111,4,4),
        (112,2,3),
        (113,3,2)
go
insert into songs
    (song_id,song_song_name,song_lyrics,song_audio)
        VALUES
        (1111,'Cheap Thrills','Come on Come on turn the radio on','audiocheapthrills.mp3'),
        (1112,'Shape of you','the club isnt the best place to find a lover','audioshapeof you.mp3'),
        (1113,'Circles','Run away but were running in circles','ausiocircles.mp3'),
        (1114,'Desert Rose','I dream of gradens in the desert sand','audiodesertrose.mp3'),
        (1115,'Jolene','Jolene im begging of you please dont take my man','audiojolene.mp3'),
        (1116,'Under your spell','Im under your spell Surging like the sea','audioUnderYourSpell.mp3')
GO
insert into inputs
                (input_id,input_lyrics,input_audio,input_date, input_user_id,input_song_id)
                VALUES
                (111,'They see me rollin','NONE','2020-02-02',1,1113),
                (112,'NONE','input2.mp3','2020-02-03',2,1116),
                (113,'New whip just hopped in','NONE','2020-03-01',1,1114),
                (114,'NONE','input4.mp4','2020-03-04',1,1111)
go
insert into artists
            (artist_id,artist_name,artist_birth_place,arist_birthdate,artist_song_id)
            VALUES
        (1,'Sia Furler','Adelaide, Australia','18 December 1975', 1111),
        (2,'Ed Sheeran','Halifax, United Kingdom','17 February 1991',1112),
        (3,'Post Malone','Syracuse, New York, USA ','4 July 1995',1113),
        (4,'Sting','Wallsend, United Kingdom',' 2 October 1951',1114),
        (5,'Dolly Parton','Tennessee, USA','19 January 1946',1115),
        (6,'Nathaniel Miller','USA','18 December 1975',1116)
insert into albums
            (album_id,album_title,album_release_year,album_song_id,album_artist_id)
            VALUES
        (1,'This Is Acting','2016',1111,1),
        (2,'Epic Album Moment','2010',1113,3),
        (3,'Big time Ken and Divya"s favorite Album','2011',1115,5),
        (4,'brand New day','2012',1116,6)
        
insert into genres
        (genre_id,genre_title)
            VALUES
            (1,'mumblerap'),
            (2,'satire'),
            (3,'edm')

insert into song_genre_lookup
        (song_genre_id,song_genre_genre_id)
            VALUES
            (1111,1),
            (1112,2),
            (1113,2)

insert into advertisements
            (advertisement_id,advertisement_brand_name,advertisement_status,advertisement_song_id)
        VALUES
                (1,'bartstool','Active',1111),-------------------lookup table?
                (2,'syracuse','Active',1112)

/*
SELECT * from users
SELECT * from songs
SELECT * from artists
SELECT * from app_ratings
SELECT * from genres
SELECT * from subscriptions
SELECT * from inputs
SELECT * from advertisements
SELECT * from albums



select*from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
        where CONSTRAINT_NAME like'fk%' */