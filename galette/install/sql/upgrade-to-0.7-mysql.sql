-- Set adherents table type to InnoDB so  we can use foreign keys
ALTER TABLE galette_adherents ENGINE = InnoDB;

-- Add new or missing preferences;
INSERT INTO galette_preferences (nom_pref, val_pref) VALUES ('pref_slogan', '');
UPDATE galette_preferences SET val_pref='fr_FR' WHERE nom_pref='french';
UPDATE galette_preferences SET val_pref='en_EN' WHERE nom_pref='english';
UPDATE galette_preferences SET val_pref='es_ES' WHERE nom_pref='spanish';
UPDATE galette_adherents SET pref_lang='fr_FR' WHERE pref_lang='french';
UPDATE galette_adherents SET pref_lang='en_EN' WHERE pref_lang='english';
UPDATE galette_adherents SET pref_lang='es_ES' WHERE pref_lang='spanish';
ALTER TABLE `galette_adherents` CHANGE `pref_lang` `pref_lang` VARCHAR( 20 ) NULL DEFAULT 'fr_FR';
UPDATE galette_preferences SET nom_pref='pref_mail_smtp_host' WHERE nom_pref='pref_mail_smtp';
INSERT INTO galette_preferences (nom_pref, val_pref) VALUES ('pref_card_abrev', 'Galette');
INSERT INTO galette_preferences (nom_pref, val_pref) VALUES ('pref_card_strip','Gestion d Adherents en Ligne Extrêmement Tarabiscoté');
INSERT INTO galette_preferences (nom_pref, val_pref) VALUES ('pref_card_tcol', 'FFFFFF');
INSERT INTO galette_preferences (nom_pref, val_pref) VALUES ('pref_card_scol', '8C2453');
INSERT INTO galette_preferences (nom_pref, val_pref) VALUES ('pref_card_bcol', '53248C');
INSERT INTO galette_preferences (nom_pref, val_pref) VALUES ('pref_card_hcol', '248C53');
INSERT INTO galette_preferences (nom_pref, val_pref) VALUES ('pref_bool_display_title', '');
INSERT INTO galette_preferences (nom_pref, val_pref) VALUES ('pref_card_address', '1');
INSERT INTO galette_preferences (nom_pref, val_pref) VALUES ('pref_card_year', '2007');
INSERT INTO galette_preferences (nom_pref, val_pref) VALUES ('pref_card_marges_v', '15');
INSERT INTO galette_preferences (nom_pref, val_pref) VALUES ('pref_card_marges_h', '20');
INSERT INTO galette_preferences (nom_pref, val_pref) VALUES ('pref_card_vspace', '5');
INSERT INTO galette_preferences (nom_pref, val_pref) VALUES ('pref_card_hspace', '10');
INSERT INTO galette_preferences (nom_pref, val_pref) VALUES ('pref_card_self', '1');
INSERT INTO galette_preferences (nom_pref, val_pref) VALUES ('pref_editor_enabled', '');
INSERT INTO galette_preferences (nom_pref, val_pref) VALUES ('pref_theme', 'default');
INSERT INTO galette_preferences (nom_pref, val_pref) VALUES ('pref_mail_smtp_auth', 'false');
INSERT INTO galette_preferences (nom_pref, val_pref) VALUES ('pref_mail_smtp_secure', 'false');
INSERT INTO galette_preferences (nom_pref, val_pref) VALUES ('pref_mail_smtp_port', '25');
INSERT INTO galette_preferences (nom_pref, val_pref) VALUES ('pref_mail_smtp_user', '');
INSERT INTO galette_preferences (nom_pref, val_pref) VALUES ('pref_mail_smtp_password', '');

-- Table for dynamic required fields;
DROP TABLE IF EXISTS galette_required;
CREATE TABLE galette_required (
    field_id varchar(15) NOT NULL,
    required tinyint(1) NOT NULL,
    PRIMARY KEY  (field_id)
) TYPE=MyISAM DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

-- Add new table for automatic mails and their translations;
DROP TABLE IF EXISTS galette_texts;
CREATE TABLE IF NOT EXISTS galette_texts (
  tid smallint(6) NOT NULL auto_increment,
  tref varchar(20) NOT NULL,
  tsubject varchar(256) NOT NULL,
  tbody text NOT NULL,
  tlang varchar(16) NOT NULL,
  tcomment varchar(64) NOT NULL,
  PRIMARY KEY  (tid)
) TYPE=MyISAM DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

-- Modify table picture to allow for negative indexes;
ALTER TABLE galette_pictures CHANGE id_adh id_adh INT( 10 ) NOT NULL DEFAULT '0';

-- Add a new table to store models descriptions for documents
DROP TABLE IF EXISTS galette_models;
CREATE TABLE IF NOT EXISTS galette_models (
  mod_id int(11) NOT NULL,
  mod_name varchar(64)  NOT NULL,
  mod_xml text NOT NULL,
  PRIMARY KEY  (mod_id)
) TYPE=MyISAM DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

--
-- Contenu de la table `galette_texts`;
--
INSERT INTO galette_texts (tid, tref, tsubject, tbody, tlang, tcomment) VALUES (1, 'sub', 'Your identifiers', 'Hello,\r\n\r\nYou''ve just been subscribed on the members management system of {NAME}.\r\n\r\nIt is now possible to follow in real time the state of your subscription and to update your preferences from the web interface.\r\n\r\nPlease login at this address:\r\n{LOGIN_URI}\r\n\r\nUsername: {LOGIN}\r\nPassword: {PASSWORD}\r\n\r\nSee you soon!\r\n\r\n(this mail was sent automatically)', 'en_EN', 'New user registration');
INSERT INTO galette_texts (tid, tref, tsubject, tbody, tlang, tcomment) VALUES (2, 'sub', 'Votre adhésion', 'Bonjour,\r\n\r\nVous venez d''adhérer à {NAME}.\r\n\r\nVous pouvez désormais accéder à vos coordonnées et souscriptions en vous connectant à l''adresse suivante:\r\n\r\n{LOGIN_URI} \r\n\r\nIdentifiant: {LOGIN}\r\nMot de passe: {PASSWORD}\r\n\r\nA bientôt!\r\n\r\n(Ce courriel est un envoi automatique)', 'fr_FR', 'Nouvelle adhésion');
INSERT INTO galette_texts (tid, tref, tsubject, tbody, tlang, tcomment) VALUES (4, 'pwd', 'Your identifiers', 'Hello,\r\n\r\nSomeone (probably you) asked to recover your password.\r\n\r\nPlease login at this address to set your new password :\r\n{CHG_PWD_URI}\r\n\r\nUsername: {LOGIN}\r\nTemporary password: {PASSWORD}\r\n\r\nSee you soon!\r\n\r\n(this mail was sent automatically)', 'en_EN', 'Lost password email');
INSERT INTO galette_texts (tid, tref, tsubject, tbody, tlang, tcomment) VALUES (5, 'pwd', 'Vos Identifiants', 'Bonjour,\r\n\r\nQuelqu''un (probablement vous) a demandé la récupération de votre mot de passe.\r\n\r\nConnectez vous à cette adresse pour valider le nouveau mot de passe:\r\n{CHG_PWD_URI}\r\n\r\nIdentifiant: {LOGIN}\r\nMot de passe Temporaire: {PASSWORD}\r\n\r\nA Bientôt!\r\n\r\n(Courrier envoyé automatiquement)', 'fr_FR', 'Récupération du mot de passe');

-- Add missing primary keys
ALTER TABLE `galette_dynamic_fields` ADD PRIMARY KEY ( `item_id` , `field_id` , `field_form` , `val_index` );
ALTER TABLE `galette_l10n` DROP INDEX `text_orig`, ADD PRIMARY KEY (`text_orig` (20), `text_locale` (5));

-- that fiels was created in 0.63 under postgres... not mysql :(
ALTER TABLE `galette_adherents` ADD `lieu_naissance` `lieu_naissance` VARCHAR( 50 ) NULL DEFAULT NULL;

-- Changes "boolean" fields to tinyint ; enum is not enough standard
ALTER TABLE `galette_adherents` CHANGE `activite_adh` `activite_adh` VARCHAR( 1 ) NOT NULL DEFAULT 0;
ALTER TABLE `galette_adherents` CHANGE `activite_adh` `activite_adh` TINYINT( 1 ) NOT NULL DEFAULT 0;
ALTER TABLE `galette_adherents` CHANGE `bool_admin_adh` `bool_admin_adh` TINYINT( 1 ) NOT NULL DEFAULT 0;
ALTER TABLE `galette_adherents` CHANGE `bool_exempt_adh` `bool_exempt_adh` TINYINT( 1 ) NOT NULL DEFAULT 0;
ALTER TABLE `galette_adherents` CHANGE `bool_display_info` `bool_display_info` TINYINT( 1 ) NOT NULL DEFAULT 0;
ALTER TABLE `galette_types_cotisation` CHANGE `cotis_extension` `cotis_extension` TINYINT( 1 ) NOT NULL DEFAULT 0;
ALTER TABLE `galette_field_types` CHANGE `field_required` `field_required` TINYINT( 1 ) NOT NULL DEFAULT 0;

-- New table for fields categories
DROP TABLE IF EXISTS galette_fields_categories;
CREATE TABLE galette_fields_categories (
  id_field_category int(2) NOT NULL AUTO_INCREMENT,
  category varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  position int(2) NOT NULL,
  PRIMARY KEY (id_field_category)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Base fields categories
INSERT INTO `galette_fields_categories` (`id_field_category`, `category`, `position`) VALUES (1, 'Identity:', 1);
INSERT INTO `galette_fields_categories` (`id_field_category`, `category`, `position`) VALUES (2, 'Galette-related data:', 2);
INSERT INTO `galette_fields_categories` (`id_field_category`, `category`, `position`) VALUES (3, 'Contact information:', 3);

-- New table for fields configuration
DROP TABLE IF EXISTS galette_fields_config;
CREATE TABLE IF NOT EXISTS galette_fields_config (
  table_name varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  field_id varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  required tinyint(1) NOT NULL,
  visible tinyint(1) NOT NULL,
  position int(2) NOT NULL,
  id_field_category int(2) NOT NULL,
  CONSTRAINT galette_fields_config_categories
    FOREIGN KEY (id_field_category)
    REFERENCES galette_fields_categories (id_field_category)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Table for mailing history storage;
DROP TABLE IF EXISTS galette_mailing_history;
CREATE TABLE galette_mailing_history (
  mailing_id smallint(6) NOT NULL auto_increment,
  mailing_sender int(10) unsigned NOT NULL,
  mailing_subject varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  mailing_body text NOT NULL,
  mailing_date date NOT NULL default '0000-00-00',
  PRIMARY KEY (mailing_id)
  INDEX (mailing_sender)
  CONSTRAINT galette_mailing_history_sender
    FOREIGN KEY (mailing_sender)
    REFERENCES galette_adherents (id_adh)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Table for mailing history recipients;
DROP TABLE IF EXSTS galette_mailing_history_recipients;
CREATE TABLE galette_mailing_history_recipients (
  mailing_id smallint(6) NOT NULL,
  id_adh int(10) unsigned NOT NULL,
  PRIMARY KEY (mailing_id, id_adh),
  INDEX (mailing_id),
  INDEX (id_adh),
  CONSTRAINT galette_mailing_history_recipients_mailing
    FOREIGN KEY (mailing_id)
    REFERENCES galette_mailing_history (mailing_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT galette_mailing_history_recipients_adh
    FOREIGN KEY (id_adh)
    REFERENCES galette_adherents (id_adh)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;