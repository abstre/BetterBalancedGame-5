--==================
-- India (Chandra)
--==================
-- replace Territorial Expansion Declaration Bonus with +1 movement
-- 15/12/22
-- reduce 1 global movement
-- holy site gives 1 general point
-- 1 movement for units from city with shrine
-- 1 vision for units from city with temple
-- 2 combat strength from unit with t3 building
DELETE FROM TraitModifiers WHERE TraitType='TRAIT_LEADER_ARTHASHASTRA';

-- INSERT OR IGNORE INTO TraitModifiers (TraitType , ModifierId)
-- 	VALUES ('TRAIT_LEADER_ARTHASHASTRA' , 'TRAIT_EXPANSION_MOVEMENT_BONUS_CPLMOD');
-- INSERT OR IGNORE INTO Modifiers (ModifierId , ModifierType)
-- 	VALUES ('TRAIT_EXPANSION_MOVEMENT_BONUS_CPLMOD' , 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER');
-- INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)
-- 	VALUES ('TRAIT_EXPANSION_MOVEMENT_BONUS_CPLMOD' , 'ModifierId', 'EXPANSION_MOVEMENT_BONUS_MODIFIER_CPLMOD');

-- INSERT OR IGNORE INTO Modifiers (ModifierId , ModifierType , OwnerRequirementSetId)
-- 	VALUES ('EXPANSION_MOVEMENT_BONUS_MODIFIER_CPLMOD' , 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT' , 'REQUIREMENTSET_LAND_MILITARY_CPLMOD');
-- INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)
-- 	VALUES ('EXPANSION_MOVEMENT_BONUS_MODIFIER_CPLMOD' , 'Amount' , '1');

-- INSERT OR IGNORE INTO RequirementSets (RequirementSetId , RequirementSetType)
-- 	VALUES ('REQUIREMENTSET_LAND_MILITARY_CPLMOD' , 'REQUIREMENTSET_TEST_ANY');
-- INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId , RequirementId)
-- 	VALUES ('REQUIREMENTSET_LAND_MILITARY_CPLMOD' , 'REQUIREMENTS_LAND_MILITARY_CPLMOD');
-- INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId , RequirementId)
-- 	VALUES ('REQUIREMENTSET_LAND_MILITARY_CPLMOD' , 'REQUIRES_UNIT_IS_RELIGIOUS_ALL');
-- INSERT OR IGNORE INTO Requirements (RequirementId , RequirementType)
-- 	VALUES ('REQUIREMENTS_LAND_MILITARY_CPLMOD', 'REQUIREMENT_UNIT_FORMATION_CLASS_MATCHES');
-- INSERT OR IGNORE INTO RequirementArguments (RequirementId , Name , Value)
-- 	VALUES ('REQUIREMENTS_LAND_MILITARY_CPLMOD' , 'UnitFormationClass' , 'FORMATION_CLASS_LAND_COMBAT');


INSERT INTO RequirementSets(RequirementSetId , RequirementSetType) VALUES
    ('BBG_PLAYER_IS_CHANDRAGUPTA', 'REQUIREMENTSET_TEST_ANY');
INSERT INTO RequirementSetRequirements(RequirementSetId , RequirementId) VALUES
    ('BBG_PLAYER_IS_CHANDRAGUPTA', 'BBG_PLAYER_IS_CHANDRAGUPTA_REQUIREMENT');
INSERT INTO Requirements(RequirementId , RequirementType) VALUES
    ('BBG_PLAYER_IS_CHANDRAGUPTA_REQUIREMENT' , 'REQUIREMENT_PLAYER_LEADER_TYPE_MATCHES');
INSERT INTO RequirementArguments(RequirementId , Name, Value) VALUES
    ('BBG_PLAYER_IS_CHANDRAGUPTA_REQUIREMENT' , 'LeaderType', 'LEADER_CHANDRAGUPTA');
    
--15/12/22 Chandra holy sites now give general points
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES
    ('BBG_CHANDRA_GENERAL_POINT_WITH_HOLYSITE', 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER', null),
    ('BBG_CHANDRA_GENERAL_POINT_WITH_HOLYSITE_MODIFIER', 'MODIFIER_SINGLE_CITY_DISTRICTS_ADJUST_GREAT_PERSON_POINTS', 'DISTRICT_IS_HOLY_SITE');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
    ('BBG_CHANDRA_GENERAL_POINT_WITH_HOLYSITE', 'ModifierId', 'BBG_CHANDRA_GENERAL_POINT_WITH_HOLYSITE_MODIFIER'),
    ('BBG_CHANDRA_GENERAL_POINT_WITH_HOLYSITE_MODIFIER', 'GreatPersonClassType', 'GREAT_PERSON_CLASS_GENERAL'),
    ('BBG_CHANDRA_GENERAL_POINT_WITH_HOLYSITE_MODIFIER', 'Amount', '1');
INSERT INTO TraitModifiers (TraitType , ModifierId) VALUES
    ('TRAIT_LEADER_ARTHASHASTRA' , 'BBG_CHANDRA_GENERAL_POINT_WITH_HOLYSITE');


-- bonus per building of HS
INSERT INTO Types(Type, Kind) VALUES
    ('BBG_CHANDRA_MOVEMENT_ABILITY', 'KIND_ABILITY'),
    ('BBG_CHANDRA_SIGHT_ABILITY', 'KIND_ABILITY'),
    ('BBG_CHANDRA_CS_ABILITY', 'KIND_ABILITY');
INSERT INTO TypeTags(Type, Tag) VALUES
    ('BBG_CHANDRA_MOVEMENT_ABILITY', 'CLASS_ALL_COMBAT_UNITS'),
    ('BBG_CHANDRA_SIGHT_ABILITY', 'CLASS_ALL_COMBAT_UNITS'),
    ('BBG_CHANDRA_CS_ABILITY', 'CLASS_ALL_COMBAT_UNITS');
INSERT INTO UnitAbilities(UnitAbilityType, Name, Description, Inactive) VALUES
    ('BBG_CHANDRA_MOVEMENT_ABILITY', 'LOC_BBG_CHANDRA_MOVEMENT_ABILITY_NAME', 'LOC_BBG_CHANDRA_MOVEMENT_ABILITY_DESC', 1),
    ('BBG_CHANDRA_SIGHT_ABILITY', 'LOC_BBG_CHANDRA_SIGHT_ABILITY_NAME', 'LOC_BBG_CHANDRA_SIGHT_ABILITY_DESC', 1),
    ('BBG_CHANDRA_CS_ABILITY', 'LOC_BBG_CHANDRA_CS_ABILITY_NAME', 'LOC_BBG_CHANDRA_CS_ABILITY_DESC', 1);
INSERT INTO UnitAbilityModifiers(UnitAbilityType, ModifierId) VALUES
    ('BBG_CHANDRA_MOVEMENT_ABILITY', 'BBG_CHANDRA_MOVEMENT_MODIFIER'),
    ('BBG_CHANDRA_SIGHT_ABILITY', 'BBG_CHANGRA_SIGHT_MODIFIER'),
    ('BBG_CHANDRA_CS_ABILITY', 'BBG_CHANDRA_CS_MODIFIER');
INSERT INTO Modifiers(ModifierId, ModifierType, Permanent, OwnerRequirementSetId) VALUES
    ('BBG_CHANDRA_GIVE_MOVEMENT_ABILITY', 'MODIFIER_SINGLE_CITY_GRANT_ABILITY_FOR_TRAINED_UNITS', 0, 'BBG_PLAYER_IS_CHANDRAGUPTA'),
    ('BBG_CHANDRA_MOVEMENT_MODIFIER', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', 1, null),
    ('BBG_CHANDRA_GIVE_SIGHT_ABILITY', 'MODIFIER_SINGLE_CITY_GRANT_ABILITY_FOR_TRAINED_UNITS', 0, 'BBG_PLAYER_IS_CHANDRAGUPTA'),
    ('BBG_CHANGRA_SIGHT_MODIFIER', 'MODIFIER_PLAYER_UNIT_ADJUST_SIGHT', 1, null),
    ('BBG_CHANDRA_GIVE_CS_ABILITY', 'MODIFIER_SINGLE_CITY_GRANT_ABILITY_FOR_TRAINED_UNITS', 0, 'BBG_PLAYER_IS_CHANDRAGUPTA'),
    ('BBG_CHANDRA_CS_MODIFIER', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 1, null);
    
INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
    ('BBG_CHANDRA_GIVE_MOVEMENT_ABILITY', 'AbilityType', 'BBG_CHANDRA_MOVEMENT_ABILITY'),
    ('BBG_CHANDRA_MOVEMENT_MODIFIER', 'Amount', '1'),
    ('BBG_CHANDRA_GIVE_SIGHT_ABILITY', 'AbilityType', 'BBG_CHANDRA_SIGHT_ABILITY'),
    ('BBG_CHANGRA_SIGHT_MODIFIER', 'Amount', '1'),
    ('BBG_CHANDRA_GIVE_CS_ABILITY', 'AbilityType', 'BBG_CHANDRA_CS_ABILITY'),
    ('BBG_CHANDRA_CS_MODIFIER', 'Amount', '2');
INSERT INTO BuildingModifiers (BuildingType , ModifierId) VALUES
    ('BUILDING_SHRINE', 'BBG_CHANDRA_GIVE_MOVEMENT_ABILITY'),
    ('BUILDING_TEMPLE', 'BBG_CHANDRA_GIVE_SIGHT_ABILITY'),
    ('BUILDING_CATHEDRAL', 'BBG_CHANDRA_GIVE_CS_ABILITY'),
    ('BUILDING_GURDWARA', 'BBG_CHANDRA_GIVE_CS_ABILITY'),
    ('BUILDING_MEETING_HOUSE', 'BBG_CHANDRA_GIVE_CS_ABILITY'),
    ('BUILDING_MOSQUE', 'BBG_CHANDRA_GIVE_CS_ABILITY'),
    ('BUILDING_PAGODA', 'BBG_CHANDRA_GIVE_CS_ABILITY'),
    ('BUILDING_SYNAGOGUE', 'BBG_CHANDRA_GIVE_CS_ABILITY'),
    ('BUILDING_WAT', 'BBG_CHANDRA_GIVE_CS_ABILITY'),
    ('BUILDING_STUPA', 'BBG_CHANDRA_GIVE_CS_ABILITY'),
    ('BUILDING_DAR_E_MEHR', 'BBG_CHANDRA_GIVE_CS_ABILITY');

INSERT INTO ModifierStrings (ModifierId, Context, Text) VALUES
    ('BBG_CHANDRA_CS_MODIFIER', 'Preview', 'LOC_BBG_CHANDRA_CS_ABILITY_DESC');