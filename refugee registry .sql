

-- Step 1: Create the database
DROP DATABASE IF EXISTS refugee_registry;
CREATE DATABASE refugee_registry;
USE refugee_registry;

-- Step 2: Lookup table for towns
CREATE TABLE towns (
    town_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL
);

-- Step 3: Main refugee table
CREATE TABLE refugees (
    refugee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    surname VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    town_id INT,
    FOREIGN KEY (town_id) REFERENCES towns(town_id)
);

-- Step 4: Health information
CREATE TABLE health_info (
    health_id INT AUTO_INCREMENT PRIMARY KEY,
    refugee_id INT,
    covid_test_result ENUM('Positive', 'Negative'),
    vaccinated TINYINT(1) NOT NULL,
    vaccination_date DATE,
    health_doc_path VARCHAR(255),
    FOREIGN KEY (refugee_id) REFERENCES refugees(refugee_id) ON DELETE CASCADE
);

-- Step 5: ID verification
CREATE TABLE id_documents (
    doc_id INT AUTO_INCREMENT PRIMARY KEY,
    refugee_id INT,
    document_type ENUM('Passport', 'ID card', 'Other'),
    document_path VARCHAR(255) NOT NULL,
    verified TINYINT(1) DEFAULT 0,
    FOREIGN KEY (refugee_id) REFERENCES refugees(refugee_id) ON DELETE CASCADE
);

-- Step 6: Language skills
CREATE TABLE language_skills (
    skill_id INT AUTO_INCREMENT PRIMARY KEY,
    refugee_id INT,
    language VARCHAR(50) NOT NULL,
    proficiency_level ENUM('Basic', 'Intermediate', 'Fluent') NOT NULL,
    FOREIGN KEY (refugee_id) REFERENCES refugees(refugee_id) ON DELETE CASCADE
);

-- Step 7: Work experience
CREATE TABLE work_experience (
    experience_id INT AUTO_INCREMENT PRIMARY KEY,
    refugee_id INT,
    profession VARCHAR(100) NOT NULL,
    years_experience INT CHECK (years_experience >= 0),
    FOREIGN KEY (refugee_id) REFERENCES refugees(refugee_id) ON DELETE CASCADE
);

-- Step 8: Family connections
CREATE TABLE family_links (
    refugee_id INT,
    related_refugee_id INT,
    relationship ENUM('parent', 'spouse', 'sibling', 'other'),
    PRIMARY KEY (refugee_id, related_refugee_id),
    FOREIGN KEY (refugee_id) REFERENCES refugees(refugee_id) ON DELETE CASCADE,
    FOREIGN KEY (related_refugee_id) REFERENCES refugees(refugee_id) ON DELETE CASCADE,
    CHECK (refugee_id <> related_refugee_id)
);

-- Step 9: Indexes
CREATE INDEX idx_refugees_surname ON refugees(surname);
CREATE INDEX idx_refugees_town_id ON refugees(town_id);
CREATE INDEX idx_language_skills_language ON language_skills(language);
CREATE INDEX idx_work_experience_profession ON work_experience(profession);
CREATE INDEX idx_family_links_refugee ON family_links(refugee_id);

-- INSERT towns before refugees to satisfy FK constraint
INSERT INTO towns (name) VALUES
('Aleppo'), ('Damascus'), ('Homs'), ('Idlib'), ('Raqqa');


INSERT INTO refugees (refugee_id, first_name, surname, date_of_birth, town_id) VALUES
(6, 'Michael', 'Rice', '2001-08-17', 5),
(7, 'Randall', 'Bowers', '1978-04-23', 2),
(8, 'Tiffany', 'Singh', '2003-10-12', 3),
(9, 'Cynthia', 'Watkins', '2006-05-06', 3),
(10, 'Joseph', 'Ibarra', '1973-11-22', 5),
(11, 'Micheal', 'Wilson', '1997-12-07', 1),
(12, 'Vanessa', 'Washington', '1997-06-11', 2),
(13, 'Laura', 'Ballard', '1989-10-24', 2),
(14, 'Deborah', 'Cabrera', '1980-04-13', 3),
(15, 'Barbara', 'Kelly', '1966-03-21', 4),
(16, 'Timothy', 'Phillips', '1972-07-22', 5),
(17, 'Jonathan', 'Larson', '1995-10-30', 1),
(18, 'Kari', 'Hines', '1972-12-07', 2),
(19, 'Krista', 'Romero', '1998-06-13', 4),
(20, 'Alison', 'Matthews', '2002-03-10', 3),
(21, 'Alexander', 'Murray', '1997-06-10', 1),
(22, 'Michael', 'Wilson', '1985-11-30', 4),
(23, 'Elizabeth', 'Anthony', '1984-04-16', 3),
(24, 'Patricia', 'Hammond', '1971-06-03', 2),
(25, 'Tyler', 'Wilson', '1982-06-16', 2),
(26, 'Leah', 'Farley', '1995-02-02', 5),
(27, 'Stephanie', 'Cabrera', '1983-08-21', 4),
(28, 'Jesse', 'Brown', '1975-08-25', 1),
(29, 'Ashley', 'Robinson', '2006-07-07', 5),
(30, 'Carolyn', 'Brown', '1990-09-16', 4),
(31, 'Martha', 'Smith', '1987-08-21', 2),
(32, 'Barbara', 'Rasmussen', '1977-08-20', 1),
(33, 'Christina', 'Smith', '1979-09-25', 5),
(34, 'James', 'Aguilar', '1983-07-09', 2),
(35, 'Alfred', 'Morton', '2004-03-25', 1),
(36, 'Julian', 'Turner', '2002-12-13', 1),
(37, 'Brent', 'Nixon', '1996-06-19', 2),
(38, 'Patricia', 'Jackson', '1974-09-13', 5),
(39, 'Ashley', 'Edwards', '1983-05-12', 2),
(40, 'Makayla', 'Cooper', '1990-09-04', 4),
(41, 'Laurie', 'Hall', '1967-04-09', 2),
(42, 'Julia', 'Price', '1997-09-12', 3),
(43, 'Guy', 'Sanchez', '1994-10-25', 5),
(44, 'Kevin', 'Wilkerson', '1968-04-18', 5),
(45, 'Dustin', 'Lee', '1971-11-13', 3),
(46, 'Cheryl', 'Smith', '1967-06-10', 1),
(47, 'Suzanne', 'Lopez', '1965-02-18', 5),
(48, 'Elizabeth', 'Herrera', '1994-07-28', 3),
(49, 'Claudia', 'Boyer', '1989-02-09', 3),
(50, 'Maureen', 'Wilson', '2007-03-05', 4),
(51, 'David', 'Douglas', '1979-03-04', 1),
(52, 'Michelle', 'Henry', '2004-07-09', 4),
(53, 'Bradley', 'Vaughn', '1974-11-26', 4),
(54, 'Zachary', 'Weber', '1976-07-31', 2),
(55, 'Sandy', 'Gomez', '1968-01-13', 4);

INSERT INTO health_info (refugee_id, covid_test_result, vaccinated, vaccination_date, health_doc_path) VALUES
(6, 'Negative', 0, NULL, '/docs/michael_health.pdf'),
(7, 'Positive', 1, '2025-01-17', '/docs/randall_health.pdf'),
(8, 'Negative', 0, NULL, '/docs/tiffany_health.pdf'),
(9, 'Positive', 1, '2023-09-12', '/docs/cynthia_health.pdf'),
(10, 'Positive', 1, '2023-07-31', '/docs/joseph_health.pdf'),
(11, 'Negative', 0, NULL, '/docs/micheal_health.pdf'),
(12, 'Positive', 0, NULL, '/docs/vanessa_health.pdf'),
(13, 'Positive', 0, NULL, '/docs/laura_health.pdf'),
(14, 'Negative', 0, NULL, '/docs/deborah_health.pdf'),
(15, 'Negative', 0, NULL, '/docs/barbara_health.pdf'),
(16, 'Positive', 0, NULL, '/docs/timothy_health.pdf'),
(17, 'Positive', 1, '2023-07-25', '/docs/jonathan_health.pdf'),
(18, 'Negative', 0, NULL, '/docs/kari_health.pdf'),
(19, 'Positive', 1, '2024-09-29', '/docs/krista_health.pdf'),
(20, 'Negative', 0, NULL, '/docs/alison_health.pdf'),
(21, 'Positive', 1, '2024-11-25', '/docs/alexander_health.pdf'),
(22, 'Positive', 0, NULL, '/docs/michael_health.pdf'),
(23, 'Negative', 1, '2024-01-23', '/docs/elizabeth_health.pdf'),
(24, 'Negative', 1, '2023-06-26', '/docs/patricia_health.pdf'),
(25, 'Positive', 1, '2023-11-21', '/docs/tyler_health.pdf'),
(26, 'Negative', 1, '2024-02-09', '/docs/leah_health.pdf'),
(27, 'Negative', 1, '2024-10-26', '/docs/stephanie_health.pdf'),
(28, 'Positive', 1, '2025-06-08', '/docs/jesse_health.pdf'),
(29, 'Positive', 1, '2023-11-27', '/docs/ashley_health.pdf'),
(30, 'Positive', 1, '2023-08-06', '/docs/carolyn_health.pdf'),
(31, 'Positive', 0, NULL, '/docs/martha_health.pdf'),
(32, 'Negative', 0, NULL, '/docs/barbara_health.pdf'),
(33, 'Positive', 1, '2025-05-02', '/docs/christina_health.pdf'),
(34, 'Negative', 1, '2024-10-17', '/docs/james_health.pdf'),
(35, 'Negative', 1, '2025-05-28', '/docs/alfred_health.pdf'),
(36, 'Negative', 0, NULL, '/docs/julian_health.pdf'),
(37, 'Negative', 1, '2024-12-21', '/docs/brent_health.pdf'),
(38, 'Negative', 0, NULL, '/docs/patricia_health.pdf'),
(39, 'Positive', 1, '2024-10-19', '/docs/ashley_health.pdf'),
(40, 'Positive', 1, '2024-11-25', '/docs/makayla_health.pdf'),
(41, 'Positive', 0, NULL, '/docs/laurie_health.pdf'),
(42, 'Negative', 0, NULL, '/docs/julia_health.pdf'),
(43, 'Negative', 1, '2023-07-21', '/docs/guy_health.pdf'),
(44, 'Positive', 1, '2025-05-21', '/docs/kevin_health.pdf'),
(45, 'Positive', 1, '2025-01-07', '/docs/dustin_health.pdf'),
(46, 'Negative', 0, NULL, '/docs/cheryl_health.pdf'),
(47, 'Negative', 1, '2024-12-29', '/docs/suzanne_health.pdf'),
(48, 'Positive', 0, NULL, '/docs/elizabeth_health.pdf'),
(49, 'Negative', 0, NULL, '/docs/claudia_health.pdf'),
(50, 'Positive', 1, '2023-09-20', '/docs/maureen_health.pdf'),
(51, 'Positive', 0, NULL, '/docs/david_health.pdf'),
(52, 'Positive', 1, '2023-10-27', '/docs/michelle_health.pdf'),
(53, 'Positive', 0, NULL, '/docs/bradley_health.pdf'),
(54, 'Negative', 0, NULL, '/docs/zachary_health.pdf'),
(55, 'Negative', 1, '2023-08-26', '/docs/sandy_health.pdf');

INSERT INTO id_documents (refugee_id, document_type, document_path, verified) VALUES
(6, 'ID card', '/docs/michael_id.pdf', 0),
(7, 'Passport', '/docs/randall_id.pdf', 1),
(8, 'Other', '/docs/tiffany_id.pdf', 0),
(9, 'Passport', '/docs/cynthia_id.pdf', 0),
(10, 'ID card', '/docs/joseph_id.pdf', 1),
(11, 'Other', '/docs/micheal_id.pdf', 0),
(12, 'ID card', '/docs/vanessa_id.pdf', 1),
(13, 'Other', '/docs/laura_id.pdf', 0),
(14, 'Other', '/docs/deborah_id.pdf', 0),
(15, 'Other', '/docs/barbara_id.pdf', 0),
(16, 'Passport', '/docs/timothy_id.pdf', 1),
(17, 'Other', '/docs/jonathan_id.pdf', 0),
(18, 'ID card', '/docs/kari_id.pdf', 1),
(19, 'Other', '/docs/krista_id.pdf', 1),
(20, 'ID card', '/docs/alison_id.pdf', 1),
(21, 'ID card', '/docs/alexander_id.pdf', 0),
(22, 'Other', '/docs/michael_id.pdf', 0),
(23, 'Passport', '/docs/elizabeth_id.pdf', 1),
(24, 'Other', '/docs/patricia_id.pdf', 1),
(25, 'Other', '/docs/tyler_id.pdf', 1),
(26, 'Passport', '/docs/leah_id.pdf', 0),
(27, 'Other', '/docs/stephanie_id.pdf', 1),
(28, 'ID card', '/docs/jesse_id.pdf', 1),
(29, 'Other', '/docs/ashley_id.pdf', 0),
(30, 'Passport', '/docs/carolyn_id.pdf', 0),
(31, 'ID card', '/docs/martha_id.pdf', 0),
(32, 'Other', '/docs/barbara_id.pdf', 0),
(33, 'Passport', '/docs/christina_id.pdf', 1),
(34, 'Other', '/docs/james_id.pdf', 0),
(35, 'Other', '/docs/alfred_id.pdf', 0),
(36, 'ID card', '/docs/julian_id.pdf', 0),
(37, 'Other', '/docs/brent_id.pdf', 0),
(38, 'Passport', '/docs/patricia_id.pdf', 1),
(39, 'Other', '/docs/ashley_id.pdf', 0),
(40, 'Passport', '/docs/makayla_id.pdf', 0),
(41, 'ID card', '/docs/laurie_id.pdf', 1),
(42, 'ID card', '/docs/julia_id.pdf', 1),
(43, 'Passport', '/docs/guy_id.pdf', 1),
(44, 'Other', '/docs/kevin_id.pdf', 0),
(45, 'ID card', '/docs/dustin_id.pdf', 0),
(46, 'Other', '/docs/cheryl_id.pdf', 0),
(47, 'Other', '/docs/suzanne_id.pdf', 0),
(48, 'Passport', '/docs/elizabeth_id.pdf', 1),
(49, 'ID card', '/docs/claudia_id.pdf', 1),
(50, 'ID card', '/docs/maureen_id.pdf', 1),
(51, 'ID card', '/docs/david_id.pdf', 1),
(52, 'ID card', '/docs/michelle_id.pdf', 1),
(53, 'Other', '/docs/bradley_id.pdf', 1),
(54, 'Passport', '/docs/zachary_id.pdf', 1),
(55, 'Other', '/docs/sandy_id.pdf', 0);

INSERT INTO language_skills (refugee_id, language, proficiency_level) VALUES
(6, 'Ukrainian', 'Basic'),
(6, 'Russian', 'Basic'),
(7, 'French', 'Basic'),
(7, 'Russian', 'Fluent'),
(8, 'English', 'Basic'),
(9, 'Arabic', 'Basic'),
(9, 'English', 'Fluent'),
(9, 'English', 'Basic'),
(10, 'Russian', 'Fluent'),
(10, 'Turkish', 'Intermediate'),
(11, 'Ukrainian', 'Intermediate'),
(11, 'French', 'Fluent'),
(11, 'Turkish', 'Intermediate'),
(12, 'Ukrainian', 'Intermediate'),
(12, 'Ukrainian', 'Basic'),
(13, 'French', 'Fluent'),
(14, 'German', 'Intermediate'),
(14, 'Russian', 'Basic'),
(15, 'French', 'Fluent'),
(15, 'Arabic', 'Basic'),
(16, 'Turkish', 'Basic'),
(16, 'French', 'Fluent'),
(17, 'English', 'Basic'),
(17, 'Ukrainian', 'Intermediate'),
(18, 'Turkish', 'Fluent'),
(19, 'Arabic', 'Basic'),
(20, 'Arabic', 'Fluent'),
(20, 'French', 'Basic'),
(20, 'English', 'Fluent'),
(21, 'English', 'Fluent'),
(22, 'Russian', 'Fluent'),
(22, 'Arabic', 'Basic'),
(23, 'Arabic', 'Fluent'),
(24, 'Ukrainian', 'Fluent'),
(24, 'English', 'Intermediate'),
(25, 'Arabic', 'Fluent'),
(25, 'French', 'Intermediate'),
(25, 'German', 'Intermediate'),
(26, 'French', 'Basic'),
(26, 'Turkish', 'Fluent'),
(26, 'Turkish', 'Fluent'),
(27, 'French', 'Fluent'),
(28, 'Russian', 'Basic'),
(28, 'French', 'Basic'),
(28, 'German', 'Intermediate'),
(29, 'Ukrainian', 'Intermediate'),
(30, 'Turkish', 'Intermediate'),
(31, 'Arabic', 'Intermediate'),
(32, 'German', 'Intermediate'),
(32, 'English', 'Intermediate'),
(32, 'Turkish', 'Basic'),
(33, 'Ukrainian', 'Fluent'),
(34, 'French', 'Basic'),
(34, 'Arabic', 'Fluent'),
(34, 'Arabic', 'Intermediate'),
(35, 'Arabic', 'Intermediate'),
(35, 'Russian', 'Fluent'),
(35, 'Ukrainian', 'Fluent'),
(36, 'French', 'Intermediate'),
(36, 'German', 'Intermediate'),
(36, 'Russian', 'Intermediate'),
(37, 'Turkish', 'Fluent'),
(37, 'Ukrainian', 'Basic'),
(37, 'French', 'Fluent'),
(38, 'Arabic', 'Basic'),
(38, 'German', 'Intermediate'),
(39, 'English', 'Intermediate'),
(39, 'German', 'Fluent'),
(39, 'Arabic', 'Intermediate'),
(40, 'Arabic', 'Fluent'),
(40, 'French', 'Basic'),
(40, 'Ukrainian', 'Intermediate'),
(41, 'German', 'Fluent'),
(42, 'French', 'Intermediate'),
(43, 'Ukrainian', 'Intermediate'),
(44, 'German', 'Basic'),
(45, 'English', 'Fluent'),
(45, 'Turkish', 'Basic'),
(45, 'English', 'Basic'),
(46, 'Arabic', 'Fluent'),
(46, 'Russian', 'Intermediate'),
(46, 'Russian', 'Basic'),
(47, 'English', 'Intermediate'),
(48, 'Arabic', 'Fluent'),
(48, 'Russian', 'Intermediate'),
(48, 'Arabic', 'Basic'),
(49, 'Russian', 'Intermediate'),
(49, 'Arabic', 'Fluent'),
(49, 'Russian', 'Fluent'),
(50, 'Russian', 'Intermediate'),
(51, 'English', 'Fluent'),
(52, 'Turkish', 'Intermediate'),
(52, 'French', 'Intermediate'),
(52, 'Turkish', 'Fluent'),
(53, 'Ukrainian', 'Intermediate'),
(54, 'Turkish', 'Fluent'),
(54, 'German', 'Fluent'),
(54, 'Ukrainian', 'Intermediate'),
(55, 'French', 'Fluent'),
(55, 'Arabic', 'Intermediate');

INSERT INTO work_experience (refugee_id, profession, years_experience) VALUES
(6, 'Nurse', 18),
(6, 'Carpenter', 7),
(7, 'Nurse', 1),
(8, 'Nurse', 19),
(9, 'Teacher', 5),
(10, 'Cook', 20),
(11, 'Plumber', 17),
(11, 'Cook', 2),
(12, 'Electrician', 15),
(13, 'Mechanic', 1),
(14, 'Teacher', 10),
(15, 'Plumber', 16),
(16, 'Plumber', 19),
(17, 'Mechanic', 8),
(17, 'Plumber', 5),
(18, 'Electrician', 3),
(19, 'Electrician', 10),
(20, 'Carpenter', 12),
(21, 'Nurse', 18),
(21, 'Mechanic', 0),
(22, 'Nurse', 13),
(23, 'Cook', 12),
(24, 'Carpenter', 15),
(24, 'Carpenter', 9),
(25, 'Carpenter', 7),
(26, 'Carpenter', 8),
(27, 'Nurse', 1),
(28, 'Electrician', 19),
(29, 'Mechanic', 0),
(29, 'Plumber', 1),
(30, 'Cook', 9),
(30, 'Nurse', 1),
(31, 'Plumber', 11),
(31, 'Nurse', 17),
(32, 'Teacher', 6),
(33, 'Mechanic', 2),
(33, 'Carpenter', 16),
(34, 'Nurse', 5),
(34, 'Electrician', 6),
(35, 'Mechanic', 20),
(35, 'Cook', 20),
(36, 'Nurse', 2),
(36, 'Teacher', 14),
(37, 'Mechanic', 7),
(37, 'Nurse', 18),
(38, 'Nurse', 5),
(38, 'Plumber', 2),
(39, 'Plumber', 13),
(40, 'Electrician', 18),
(40, 'Nurse', 13),
(41, 'Plumber', 11),
(42, 'Teacher', 3),
(43, 'Teacher', 10),
(44, 'Electrician', 7),
(44, 'Cook', 4),
(45, 'Electrician', 10),
(46, 'Cook', 7),
(47, 'Electrician', 6),
(48, 'Mechanic', 11),
(49, 'Teacher', 15),
(50, 'Mechanic', 15),
(50, 'Teacher', 5),
(51, 'Plumber', 1),
(52, 'Mechanic', 15),
(52, 'Carpenter', 10),
(53, 'Plumber', 16),
(53, 'Carpenter', 17),
(54, 'Carpenter', 13),
(54, 'Nurse', 16),
(55, 'Electrician', 15);

INSERT INTO family_links (refugee_id, related_refugee_id, relationship) VALUES
(6, 45, 'other'),
(37, 52, 'sibling'),
(32, 33, 'parent'),
(32, 22, 'other'),
(37, 19, 'sibling'),
(52, 50, 'spouse'),
(32, 37, 'parent'),
(45, 16, 'parent'),
(11, 36, 'spouse'),
(35, 55, 'sibling'),
(36, 40, 'sibling'),
(53, 54, 'spouse'),
(39, 53, 'other'),
(9, 8, 'spouse'),
(11, 51, 'sibling'),
(51, 26, 'spouse'),
(40, 38, 'parent'),
(42, 21, 'sibling'),
(27, 17, 'sibling'),
(48, 39, 'other'),
(20, 31, 'sibling'),
(35, 23, 'spouse'),
(13, 11, 'spouse'),
(45, 26, 'spouse'),
(53, 36, 'sibling'),
(17, 10, 'other'),
(29, 50, 'other'),
(35, 9, 'parent');

-- Views

-- View 1: Unvaccinated Refugees
CREATE VIEW unvaccinated_refugees AS
SELECT r.refugee_id, r.first_name, r.surname, h.vaccinated, h.vaccination_date
FROM refugees r
JOIN health_info h ON r.refugee_id = h.refugee_id
WHERE h.vaccinated = 0;

-- View 2: Refugee Employment and Language Skills
CREATE VIEW refugee_employment_language AS
SELECT DISTINCT r.refugee_id, r.first_name, r.surname,
       w.profession, w.years_experience,
       l.language, l.proficiency_level
FROM refugees r
JOIN work_experience w ON r.refugee_id = w.refugee_id
JOIN language_skills l ON r.refugee_id = l.refugee_id;

-- View 3: Refugee Family Links
CREATE VIEW refugee_family_links AS
SELECT r1.refugee_id AS person_id, r1.first_name AS person_name,
       r2.refugee_id AS relative_id, r2.first_name AS relative_name,
       f.relationship
FROM family_links f
JOIN refugees r1 ON f.refugee_id = r1.refugee_id
JOIN refugees r2 ON f.related_refugee_id = r2.refugee_id;

-- View 4: Referral Readiness Report that has 4 conditions town of origin proficiency level  and vaccination
CREATE VIEW referral_readiness_report AS
SELECT
    r.refugee_id,
    r.first_name,
    r.surname,
    t.name AS town_of_origin,
    CASE WHEN h.vaccinated = 1 THEN 'Vaccinated' ELSE 'Not Vaccinated' END AS vaccination_status,
    CASE WHEN d.verified = 1 THEN 'Verified ID' ELSE 'Unverified ID' END AS id_status,
    MAX(CASE
        WHEN l.proficiency_level = 'Fluent' THEN 3
        WHEN l.proficiency_level = 'Intermediate' THEN 2
        WHEN l.proficiency_level = 'Basic' THEN 1
        ELSE 0
    END) AS language_score,
    MAX(COALESCE(w.years_experience, 0)) AS experience_years,
    CASE
        WHEN h.vaccinated = 1 AND d.verified = 1 AND
             MAX(CASE
                 WHEN l.proficiency_level = 'Fluent' THEN 3
                 WHEN l.proficiency_level = 'Intermediate' THEN 2
                 WHEN l.proficiency_level = 'Basic' THEN 1
                 ELSE 0
             END) >= 2 AND
             MAX(COALESCE(w.years_experience, 0)) >= 3
        THEN 'Ready for Referral'
        ELSE 'Needs Follow-Up'
    END AS readiness_status
FROM refugees r
LEFT JOIN towns t ON r.town_id = t.town_id
LEFT JOIN health_info h ON r.refugee_id = h.refugee_id
LEFT JOIN id_documents d ON r.refugee_id = d.refugee_id
LEFT JOIN language_skills l ON r.refugee_id = l.refugee_id
LEFT JOIN work_experience w ON r.refugee_id = w.refugee_id
GROUP BY r.refugee_id, r.first_name, r.surname, t.name, h.vaccinated, d.verified;

-- View 5: Vaccinated Refugees
CREATE VIEW vaccinated_refugees AS
SELECT r.first_name, r.surname, h.vaccinated, h.vaccination_date
FROM refugees r
JOIN health_info h ON r.refugee_id = h.refugee_id
WHERE h.vaccinated = 1;

-- View 6: Refugee Count by Profession
CREATE VIEW refugee_count_by_profession AS
SELECT w.profession, COUNT(DISTINCT r.refugee_id) AS number_of_refugees
FROM work_experience w
JOIN refugees r ON w.refugee_id = r.refugee_id
GROUP BY w.profession
ORDER BY number_of_refugees DESC;

-- View 7: Refugee Count by Town
CREATE VIEW refugee_count_by_town AS
SELECT t.name AS town, COUNT(r.refugee_id) AS number_of_refugees
FROM towns t
LEFT JOIN refugees r ON t.town_id = r.town_id
GROUP BY t.name;

-- View 8: Health Reports for Test Centers
CREATE VIEW health_reports AS
SELECT r.refugee_id, r.first_name, r.surname, h.covid_test_result,
       h.vaccinated, h.vaccination_date, h.health_doc_path, t.name AS town_name
FROM refugees r
JOIN health_info h ON r.refugee_id = h.refugee_id
LEFT JOIN towns t ON r.town_id = t.town_id;

-- SELECTs for quick view testing 
SELECT * FROM vaccinated_refugees;
SELECT * FROM referral_readiness_report;
SELECT * FROM unvaccinated_refugees;
SELECT * FROM refugee_employment_language;
SELECT * FROM refugee_family_links;
SELECT * FROM refugee_count_by_profession;
SELECT * FROM refugee_count_by_town;
SELECT * FROM health_reports;

