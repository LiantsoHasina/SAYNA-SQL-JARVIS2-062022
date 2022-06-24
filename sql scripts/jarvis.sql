-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema jarvis
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema jarvis
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `jarvis` DEFAULT CHARACTER SET utf8mb4 ;
USE `jarvis` ;

-- -----------------------------------------------------
-- Table `jarvis`.`Utilisateur`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jarvis`.`Utilisateur` (
  `id_u` INT NOT NULL AUTO_INCREMENT,
  `prenom_u` VARCHAR(45) NULL,
  `nom_u` VARCHAR(45) NULL,
  `date_de_naissance` DATE NOT NULL,
  `email_u` VARCHAR(45) NULL,
  `sexe_u` VARCHAR(1) NULL COMMENT 'M: Male\nF: Female',
  `mdp_u` VARCHAR(45) NULL,
  `lien_parente` VARCHAR(45) NULL,
  PRIMARY KEY (`id_u`),
  UNIQUE INDEX `email_u_UNIQUE` (`email_u` ASC) VISIBLE)
ENGINE = InnoDB;
-- INSERT INTO `utilisateur` VALUES (1,'Chris','Redfield','1980-05-21','Chrisred@BSAA.com','M','birArms','Frere'),(2,'Claire','Redfield','1990-07-10','survivorred@cap.com','F','lsfjie','Soeur'),(3,'Leon','S. Kennedy','1992-06-10','jackpot@dmc.com','M','shtj','ami'),(4,'Sherry','Birkin','1998-02-25','birkingirl@dmc.com','F','GKljis','fille');

-- -----------------------------------------------------
-- Table `jarvis`.`membre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jarvis`.`membre` (
  `id_m` INT NOT NULL AUTO_INCREMENT,
  `Utilisateur_id_u` INT NOT NULL,
  PRIMARY KEY (`id_m`, `Utilisateur_id_u`),
  INDEX `fk_membre_Utilisateur_idx` (`Utilisateur_id_u` ASC) VISIBLE,
  CONSTRAINT `fk_membre_Utilisateur`
    FOREIGN KEY (`Utilisateur_id_u`)
    REFERENCES `jarvis`.`Utilisateur` (`id_u`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jarvis`.`Co-proprietaire`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jarvis`.`Co-proprietaire` (
  `id_co` INT NOT NULL AUTO_INCREMENT,
  `Utilisateur_id_u` INT NOT NULL,
  PRIMARY KEY (`id_co`, `Utilisateur_id_u`),
  INDEX `fk_Co-proprietaire_Utilisateur1_idx` (`Utilisateur_id_u` ASC) VISIBLE,
  CONSTRAINT `fk_Co-proprietaire_Utilisateur1`
    FOREIGN KEY (`Utilisateur_id_u`)
    REFERENCES `jarvis`.`Utilisateur` (`id_u`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jarvis`.`Proprietaire`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jarvis`.`Proprietaire` (
  `id_pro` INT NOT NULL AUTO_INCREMENT,
  `Utilisateur_id_u` INT NOT NULL,
  PRIMARY KEY (`id_pro`, `Utilisateur_id_u`),
  INDEX `fk_Proprietaire_Utilisateur1_idx` (`Utilisateur_id_u` ASC) VISIBLE,
  CONSTRAINT `fk_Proprietaire_Utilisateur1`
    FOREIGN KEY (`Utilisateur_id_u`)
    REFERENCES `jarvis`.`Utilisateur` (`id_u`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jarvis`.`piece`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jarvis`.`piece` (
  `id_p` INT NOT NULL AUTO_INCREMENT,
  `nom_p` VARCHAR(45) NULL,
  PRIMARY KEY (`id_p`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jarvis`.`appareils`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jarvis`.`appareils` (
  `id_app` INT NOT NULL AUTO_INCREMENT,
  `nom_app` VARCHAR(45) NULL,
  `type_app` VARCHAR(45) NULL,
  PRIMARY KEY (`id_app`))
ENGINE = InnoDB;
-- INSERT INTO `appareils` VALUES (1,'My Phone','Iphone'),(2,'thisOne','Android'),(3,'Catalyst','Laptop'),(4,'My_app','Laptop'),(5,'Last','Desktop');

-- -----------------------------------------------------
-- Table `jarvis`.`domicile`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jarvis`.`domicile` (
  `id_dom` INT NOT NULL AUTO_INCREMENT,
  `nom_dom` VARCHAR(45) NULL,
  `anne_construction` DATE NULL,
  `superficie` INT NULL,
  PRIMARY KEY (`id_dom`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jarvis`.`contenir`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jarvis`.`contenir` (
  `id_contenir` INT NOT NULL AUTO_INCREMENT,
  `piece_id_p` INT NOT NULL,
  `domicile_id_dom` INT NOT NULL,
  PRIMARY KEY (`id_contenir`, `piece_id_p`, `domicile_id_dom`),
  INDEX `fk_contenir_piece1_idx` (`piece_id_p` ASC) VISIBLE,
  INDEX `fk_contenir_domicile1_idx` (`domicile_id_dom` ASC) VISIBLE,
  CONSTRAINT `fk_contenir_piece1`
    FOREIGN KEY (`piece_id_p`)
    REFERENCES `jarvis`.`piece` (`id_p`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contenir_domicile1`
    FOREIGN KEY (`domicile_id_dom`)
    REFERENCES `jarvis`.`domicile` (`id_dom`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jarvis`.`avoir`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jarvis`.`avoir` (
  `id_avoir` INT NOT NULL AUTO_INCREMENT,
  `Utilisateur_id_u` INT NOT NULL,
  `domicile_id_dom` INT NOT NULL,
  PRIMARY KEY (`id_avoir`, `Utilisateur_id_u`, `domicile_id_dom`),
  INDEX `fk_avoir_Utilisateur1_idx` (`Utilisateur_id_u` ASC) VISIBLE,
  INDEX `fk_avoir_domicile1_idx` (`domicile_id_dom` ASC) VISIBLE,
  CONSTRAINT `fk_avoir_Utilisateur1`
    FOREIGN KEY (`Utilisateur_id_u`)
    REFERENCES `jarvis`.`Utilisateur` (`id_u`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_avoir_domicile1`
    FOREIGN KEY (`domicile_id_dom`)
    REFERENCES `jarvis`.`domicile` (`id_dom`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jarvis`.`setrouve`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jarvis`.`setrouve` (
  `id_setrouve` INT NOT NULL AUTO_INCREMENT,
  `appareils_id_app` INT NOT NULL,
  `piece_id_p` INT NOT NULL,
  PRIMARY KEY (`id_setrouve`, `appareils_id_app`, `piece_id_p`),
  INDEX `fk_setrouve_appareils1_idx` (`appareils_id_app` ASC) VISIBLE,
  INDEX `fk_setrouve_piece1_idx` (`piece_id_p` ASC) VISIBLE,
  CONSTRAINT `fk_setrouve_appareils1`
    FOREIGN KEY (`appareils_id_app`)
    REFERENCES `jarvis`.`appareils` (`id_app`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_setrouve_piece1`
    FOREIGN KEY (`piece_id_p`)
    REFERENCES `jarvis`.`piece` (`id_p`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jarvis`.`inviter`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jarvis`.`inviter` (
  `id_inviter` INT NOT NULL AUTO_INCREMENT,
  `Proprietaire_id_pro` INT NOT NULL,
  `Proprietaire_Utilisateur_id_u` INT NOT NULL,
  PRIMARY KEY (`id_inviter`, `Proprietaire_id_pro`, `Proprietaire_Utilisateur_id_u`),
  INDEX `fk_inviter_Proprietaire1_idx` (`Proprietaire_id_pro` ASC, `Proprietaire_Utilisateur_id_u` ASC) VISIBLE,
  CONSTRAINT `fk_inviter_Proprietaire1`
    FOREIGN KEY (`Proprietaire_id_pro` , `Proprietaire_Utilisateur_id_u`)
    REFERENCES `jarvis`.`Proprietaire` (`id_pro` , `Utilisateur_id_u`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- INSERT INTO `proprietaire` VALUES (1,3);
-- INSERT INTO `domicile` VALUES (1,'1999-05-02',200),(2,'2002-12-22',500);
-- INSERT INTO `co-proprietaire` VALUES (1,4);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
