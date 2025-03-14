-- Hunter Scholz / Brody Couture

DROP TABLE IF EXISTS _Character;
DROP TABLE IF EXISTS _Class;
DROP TABLE IF EXISTS Origin;
DROP TABLE IF EXISTS Starting_Equipment;
DROP TABLE IF EXISTS Char_Stats;
DROP TABLE IF EXISTS Is_Proficient_With;
DROP TABLE IF EXISTS Proficiency;
DROP TABLE IF EXISTS Casts;
DROP TABLE IF EXISTS Spell;
DROP TABLE IF EXISTS Knows;
DROP TABLE IF EXISTS Feature;
DROP TABLE IF EXISTS Class_Gives;
DROP TABLE IF EXISTS Origin_Gives;

CREATE TABLE _Class (
	name VARCHAR(50) NOT NULL PRIMARY KEY,
	subclass VARCHAR(50),
	hit_dice int,
	starting_hp int
);

CREATE TABLE Origin (
	oid int NOT NULL PRIMARY KEY,
	race VARCHAR(50),
	background VARCHAR(50),
	alignment VARCHAR(50)
);

CREATE TABLE _Character (
	cid int NOT NULL PRIMARY KEY,
	name VARCHAR(50),
	_level int,
	proficiency_bonus int,
	age int,
	speed int,
	_class VARCHAR(50),
	oid int,
	FOREIGN KEY (_class) REFERENCES _Class(name),
	FOREIGN KEY (oid) REFERENCES Origin(oid)	
);

CREATE TABLE Starting_Equipment (
	cid int NOT NULL,
	starting_equipment VARCHAR(500) NOT NULL,
	PRIMARY KEY (cid, starting_equipment),
	FOREIGN KEY (cid) REFERENCES _Character(cid)
);

CREATE TABLE Char_Stats (
	cid int NOT NULL PRIMARY KEY,
	_str int,
	con int,
	dex int,
	_int int,
	wis int,
	cha int,
	FOREIGN KEY (cid) REFERENCES _Character(cid)
);

CREATE TABLE Proficiency (
	name VARCHAR(50) NOT NULL PRIMARY KEY,
	_type VARCHAR(50),
	description VARCHAR (500)
);

CREATE TABLE Is_Proficient_With (
	cid int NOT NULL,
	proficiency VARCHAR(50) NOT NULL, 
	PRIMARY KEY (cid, proficiency),
	FOREIGN KEY (cid) REFERENCES _Character(cid),
	FOREIGN KEY (proficiency) REFERENCES Proficiency(name)
);


CREATE TABLE Spell (
	name VARCHAR(50) NOT NULL PRIMARY KEY,
	spell_level int,
	school VARCHAR(50),
	description VARCHAR(500),
	casting_time VARCHAR(50),
	is_concentration BOOLEAN
);

CREATE TABLE Casts (
	cid int NOT NULL,
	spell VARCHAR(50) NOT NULL,
	prepared BOOLEAN,
	FOREIGN KEY (spell) REFERENCES Spell(name),
	FOREIGN KEY (cid) REFERENCES _Character(cid)
);

CREATE TABLE Feature (
	name VARCHAR(50) NOT NULL PRIMARY KEY,
	description VARCHAR(500)
);

CREATE TABLE Knows (
	cid int NOT NULL,
	feature VARCHAR(50) NOT NULL, 
	PRIMARY KEY (cid, feature),
	FOREIGN KEY (cid) REFERENCES _Character(cid),
	FOREIGN KEY (feature) REFERENCES Feature(name)
);

CREATE TABLE Class_Gives (
	class_name VARCHAR(20) NOT NULL,
	feature VARCHAR(50) NOT NULL,
	PRIMARY KEY (class_name, feature),
	FOREIGN KEY (class_name) REFERENCES _Class(name),
	FOREIGN KEY (feature) REFERENCES Feature(name)
);

CREATE TABLE Origin_Gives (
	oid int NOT NULL,
	feature VARCHAR(50) NOT NULL,
	PRIMARY KEY (oid, feature),
	FOREIGN KEY (oid) REFERENCES Origin(oid),
	FOREIGN KEY (feature) REFERENCES Feature(name)
);

-- Sample Data --

-- CLASSES --

-- Fighter
INSERT INTO _Class (name, subclass, hit_dice, starting_hp)
VALUES ('Fighter', NULL, 10, 10);

-- Rogue
INSERT INTO _Class (name, subclass, hit_dice, starting_hp)
VALUES ('Rogue', 'Theif', 8, 9);

-- Wizard
INSERT INTO _Class (name, subclass, hit_dice, starting_hp)
VALUES ('Wizard', 'Evocation', 6, 8);

-- Cleric
INSERT INTO _Class (name, subclass, hit_dice, starting_hp)
VALUES ('Cleric', 'Life', 8, 12);

-- Paladin
INSERT INTO _Class (name, subclass, hit_dice, starting_hp)
VALUES ('Paladin', 'Devotion', 10, 13);

-- ORIGINS --

-- Vailynn Origin
INSERT INTO Origin (oid, race, background, alignment)
VALUES (01, 'Half-Elf', 'Sage', 'Chaotic Good');

-- John Fighterman Origin
INSERT INTO Origin (oid, race, background, alignment)
VALUES (02, 'Human', 'Folk Hero', 'Neutral Good');

-- Astarion Origin
INSERT INTO Origin (oid, race, background, alignment)
VALUES (03, 'Vampire', 'Charlatan', 'Lawful Evil');

-- Chess Origin
INSERT INTO Origin (oid, race, background, alignment)
VALUES (04, 'Dire Wolf', 'Outlander', 'Unaligned');

-- Lulu Origin
INSERT INTO Origin (oid, race, background, alignment)
VALUES (05, 'Hollyphant', 'Acolyte', 'Lawful Good');

-- CHARACTERS --

-- Vailynn
INSERT INTO _Character (cid, name, _level, proficiency_bonus, age, speed, _class, oid)
VALUES (01, 'Vailynn', 11, 4, 26, 30, 'Wizard', 01);

-- John Fighterman
INSERT INTO _Character (cid, name, _level, proficiency_bonus, age, speed, _class, oid)
VALUES (02, 'John Fighterman', 1, 2, 40, 30, 'Fighter', 02);

-- Astarion
INSERT INTO _Character (cid, name, _level, proficiency_bonus, age, speed, _class, oid)
VALUES (03, 'Astarion', 12, 4, 350, 40, 'Rogue', 03);

-- Chess
INSERT INTO _Character (cid, name, _level, proficiency_bonus, age, speed, _class, oid)
VALUES (04, 'Chess', 5, 3, 2, 50, 'Paladin', 04);

-- Lulu
INSERT INTO _Character (cid, name, _level, proficiency_bonus, age, speed, _class, oid)
VALUES (05, 'Lulu', 20, 6, 1000, 120, 'Cleric', 05);



-- STARTING EQUIPMENT --

-- Vailynn Equipment
INSERT INTO Starting_Equipment(cid, starting_equipment)
VALUES (01, 'Spellbook');
INSERT INTO Starting_Equipment (cid, starting_equipment)
VALUES (01, 'Wand');

-- John Fighterman Equipment
INSERT INTO Starting_Equipment (cid, starting_equipment)
VALUES (02, 'Longsword');
INSERT INTO Starting_Equipment (cid, starting_equipment)
VALUES (02, 'Chain Mail Armor');

-- Astarion Equipment
INSERT INTO Starting_Equipment (cid, starting_equipment)
VALUES (03, 'Two Daggers');

-- CHAR STATS --

-- Vailynn Stats
INSERT INTO Char_Stats (cid, _str, dex, con, _int, wis, cha)
VALUES (01, 13, 12, 15, 18, 6, 14);

-- John Fighterman Stats
INSERT INTO Char_Stats (cid, _str, dex, con, _int, wis, cha)
VALUES (02, 18, 10, 16, 10, 10, 10);

-- Astarion Stats
INSERT INTO Char_Stats (cid, _str, dex, con, _int, wis, cha)
VALUES (03, 8, 17, 14, 14, 10, 12);

-- Chess Stats
INSERT INTO Char_Stats (cid, _str, dex, con, _int, wis, cha)
VALUES (04, 20, 15, 18, 3, 12, 6);

-- Lulu Stats
INSERT INTO Char_Stats (cid, _str, dex, con, _int, wis, cha)
VALUES (05, 5, 16, 18, 10, 20, 10);

-- PROFICIENCIES --

INSERT INTO Proficiency (name, _type, description)
VALUES('Wisdom Saves', 'Saving Throw', 'Character adds their proficiency bonus to wisdom saving throws');

INSERT INTO Proficiency (name, _type, description)
VALUES('Heavy Armor', 'Equipment', 'Character can use Heavy Armor');

INSERT INTO Proficiency (name, _type, description)
VALUES('Thieves Tools', 'Tools', 'Character adds their proficiency bonus ability checks made to disarm traps or open locks');

INSERT INTO Proficiency (name, _type, description)
VALUES('Athletics', 'Ability Score', 'Character adds their proficiency bonus to athletics checks');

INSERT INTO Proficiency (name, _type, description)
VALUES('Charisma Saves', 'Saving Throw', 'Character adds their proficiency bonus to charisma saving throws');


-- IS_PROFICIENT_WITH --

INSERT INTO Is_Proficient_With (cid, proficiency)
VALUES (01, 'Wisdom Saves');

INSERT INTO Is_Proficient_With (cid, proficiency)
VALUES (02, 'Heavy Armor');

INSERT INTO Is_Proficient_With (cid, proficiency)
VALUES (03, 'Thieves Tools');

INSERT INTO Is_Proficient_With (cid, proficiency)
VALUES (04, 'Charisma Saves');

INSERT INTO Is_Proficient_With (cid, proficiency)
VALUES (05, 'Athletics');

-- SPELLS --

INSERT INTO Spell(name, spell_level, school, description, casting_time, is_concentration)
VALUES ('Magic Missile', 1, 'Evocation', 'Character fires 3 missiles that can each target 1 creature and always hit, dealing 1d4 + 1 force damage.', '1 action', false);

INSERT INTO Spell(name, spell_level, school, description, casting_time, is_concentration)
VALUES ('Fireball', 3, 'Evocation', 'A bright streak flashes from your pointing finger to a point you choose within range and then blossoms with a low roar into an explosion of flame. Each creature in a 20-foot-radius sphere centered on that point must make a Dexterity saving throw. A target takes 8d6 fire damage on a failed save, or half as much damage on a successful one.', '1 action', false);

INSERT INTO Spell(name, spell_level, school, description, casting_time, is_concentration)
VALUES ('Divine Smite', 1, 'Evocation', 'Adds 2d8 radiant damage to an attack with a weapon', 'Free Action', false);

INSERT INTO Spell(name, spell_level, school, description, casting_time, is_concentration)
VALUES ('Revivify', 3, 'Necromancy', 'Brings a creature who died within the last minute back to life at 1 hp', '1 action', false);

INSERT INTO Spell(name, spell_level, school, description, casting_time, is_concentration)
VALUES ('Hold Person', 2, 'Enchantment', 'Target makes a wisdom save, on a fail it is paralyzed', '1 action', true);

-- CASTS --

INSERT INTO Casts (cid, spell, prepared)
VALUES (01, 'Magic Missile', True);

INSERT INTO Casts (cid, spell, prepared)
VALUES (04, 'Divine Smite', True);

INSERT INTO Casts(cid, spell, prepared)
VALUES (01, 'Hold Person', False);

INSERT INTO Casts (cid, spell, prepared)
VALUES (05, 'Revivify', True);

INSERT INTO Casts (cid, spell, prepared)
VALUES (01, 'Fireball', False);

-- FEATURES

INSERT INTO Feature (name, description)
VALUES ('Channel Divinity', 'Cleric Ability that performs actions based on the chosen subclass');

INSERT INTO Feature (name, description)
VALUES ('Darkvision', 'Allows character to see in low light');

INSERT INTO Feature (name, description)
VALUES ('Action Surge', 'Free action that grants the character another action in a turn');

INSERT INTO Feature(name, description)
VALUES ('Fey Ancestry', 'Character cannot be put to sleep and has advantage on saving throws against being charmed');

INSERT INTO Feature (name, description)
VALUES ('Sneak Attack', 'Add a number of d6s equal to half of your level rounded up to your damage dice');

INSERT INTO Feature (name, description)
VALUES ('Extra Attack', 'Character can attack twice in one turn');

INSERT INTO Feature (name, description)
VALUES ('Pack Tactics', 'Character has advantage on attack rolls when within 5 feet of another friendly creature');

-- CLASS GIVES

INSERT INTO Class_Gives (class_name, feature)
VALUES ('Cleric', 'Channel Divinity');

INSERT INTO Class_Gives (class_name, feature)
VALUES ('Fighter', 'Action Surge');

INSERT INTO Class_Gives (class_name, feature)
VALUES ('Rogue', 'Sneak Attack');

INSERT INTO Class_Gives (class_name, feature)
VALUES ('Fighter', 'Extra Attack');

INSERT INTO Class_Gives (class_name, feature)
VALUES ('Paladin', 'Extra Attack');

-- ORIGIN GIVES

INSERT INTO Origin_Gives(oid, feature)
VALUES (01, 'Fey Ancestry');

INSERT INTO Origin_Gives(oid, feature)
VALUES (01, 'Darkvision');

INSERT INTO Origin_Gives(oid, feature)
VALUES (03, 'Darkvision');

INSERT INTO Origin_Gives(oid, feature)
VALUES (03, 'Fey Ancestry');

INSERT INTO Origin_Gives(oid, feature)
VALUES (04, 'Pack Tactics');

-- Knows

INSERT INTO Knows(cid, feature)
VALUES (02, 'Action Surge');

INSERT INTO Knows(cid, feature)
VALUES (02, 'Extra Attack');

INSERT INTO Knows(cid, feature)
VALUES (01, 'Fey Ancestry');

INSERT INTO Knows(cid, feature)
VALUES (03, 'Fey Ancestry');

INSERT INTO Knows(cid, feature)
VALUES (03, 'Darkvision');

INSERT INTO Knows(cid, feature)
VALUES (03, 'Sneak Attack');

INSERT INTO Knows(cid, feature)
VALUES (05, 'Channel Divinity');

INSERT INTO Knows(cid, feature)
VALUES (04, 'Extra Attack');

