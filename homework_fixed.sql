-- Таблица жанров
CREATE TABLE IF NOT EXISTS Genre (
    genre_id SERIAL PRIMARY KEY,
    name VARCHAR(20) NOT NULL
);

-- Таблица исполнителей
CREATE TABLE IF NOT EXISTS Artist (
    artist_id SERIAL PRIMARY KEY,
    name VARCHAR(40) NOT NULL,
    CONSTRAINT artist_name_unique UNIQUE (name) -- Уникальное имя исполнителя
);

-- Таблица связи исполнителей и жанров (многие ко многим)
CREATE TABLE IF NOT EXISTS Artist_Genre (
    artist_id INTEGER REFERENCES Artist(artist_id) ON DELETE CASCADE,
    genre_id INTEGER REFERENCES Genre(genre_id) ON DELETE CASCADE,
    CONSTRAINT pk PRIMARY KEY (artist_id, genre_id)
);

-- Таблица альбомов
CREATE TABLE IF NOT EXISTS Album (
    album_id SERIAL PRIMARY KEY,
    title VARCHAR(40) NOT NULL,
    release_year INTEGER NOT NULL CHECK (release_year >= 1900), -- Ограничение на год выпуска
    CONSTRAINT album_title_unique UNIQUE (title) -- Уникальное название альбома
);

-- Таблица связи исполнителей и альбомов (многие ко многим)
CREATE TABLE IF NOT EXISTS Artist_Album (
    artist_id INTEGER REFERENCES Artist(artist_id) ON DELETE CASCADE,
    album_id INTEGER REFERENCES Album(album_id) ON DELETE CASCADE,
    CONSTRAINT pk PRIMARY KEY (artist_id, album_id)
);

-- Таблица треков
CREATE TABLE IF NOT EXISTS Track (
    track_id SERIAL PRIMARY KEY,
    title VARCHAR(40) NOT NULL,
    duration INTEGER NOT NULL CHECK (duration > 0), -- Длительность трека в секундах
    album_id INTEGER NOT NULL REFERENCES Album(album_id) ON DELETE CASCADE,
    CONSTRAINT track_title_unique UNIQUE (title, album_id) -- Уникальность названия в рамках альбома
);

-- Таблица сборников
CREATE TABLE IF NOT EXISTS Compilation (
    compilation_id SERIAL PRIMARY KEY,
    title VARCHAR(40) NOT NULL,
    release_year INTEGER NOT NULL CHECK (release_year >= 1900), -- Ограничение на год выпуска
    CONSTRAINT compilation_title_unique UNIQUE (title) -- Уникальное название сборника
);

-- Таблица связи сборников и треков (многие ко многим)
CREATE TABLE IF NOT EXISTS Compilation_Track (
    compilation_id INTEGER REFERENCES Compilation(compilation_id) ON DELETE CASCADE,
    track_id INTEGER REFERENCES Track(track_id) ON DELETE CASCADE,
    CONSTRAINT pk PRIMARY KEY (compilation_id, track_id)
);
	
	