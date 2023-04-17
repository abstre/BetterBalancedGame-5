UPDATE Units SET Combat=53 WHERE UnitType='UNIT_MALI_MANDEKALU_CAVALRY';

-- 17/04/23 from 1 faith per adjacent desert tiles to 2 faith if 2 desert tiles in the city
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES
    ('BBG_MALI_FAITH_IF_2_DESERT_TILES', 'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_CHANGE', 'BBG_REQUIRES_CITY_CENTER_REQSET');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
    ('BBG_MALI_FAITH_IF_2_DESERT_TILES', 'YieldType', 'YIELD_FAITH'),
    ('BBG_MALI_FAITH_IF_2_DESERT_TILES', 'Amount', '2');
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
    ('BBG_REQUIRES_CITY_CENTER_REQSET', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
    ('BBG_REQUIRES_CITY_CENTER_REQSET', 'REQUIRES_DISTRICT_IS_CITY_CENTER'),
    ('BBG_REQUIRES_CITY_CENTER_REQSET', 'BBG_REQUIRES_CITY_HAS_2_DESERT');
INSERT INTO Requirements (RequirementId, RequirementType) VALUES
    ('BBG_REQUIRES_CITY_HAS_2_DESERT', 'REQUIREMENT_CITY_HAS_X_TERRAIN_TYPE');
INSERT INTO RequirementArguments (RequirementId, Name, Value) VALUES
    ('BBG_REQUIRES_CITY_HAS_2_DESERT', 'TerrainType', 'TERRAIN_DESERT'),
    ('BBG_REQUIRES_CITY_HAS_2_DESERT', 'Hills', '1'),
-- Necessits X+1...
    ('BBG_REQUIRES_CITY_HAS_2_DESERT', 'Amount', '3');

DELETE FROM TraitModifiers WHERE TraitType = 'TRAIT_CIVILIZATION_MALI_GOLD_DESERT' AND ModifierId = 'TRAIT_DESERT_CITY_CENTER_FAITH';
DELETE FROM TraitModifiers WHERE TraitType = 'TRAIT_CIVILIZATION_MALI_GOLD_DESERT' AND ModifierId = 'TRAIT_DESERT_HILLS_CITY_CENTER_FAITH';
INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
    ('TRAIT_CIVILIZATION_MALI_GOLD_DESERT', 'BBG_MALI_FAITH_IF_2_DESERT_TILES');

--17/04/23 Reduce purchase discount from Suguba
UPDATE ModifierArguments SET Value=5 WHERE ModifierId IN ('SUGUBA_CHEAPER_BUILDING_PURCHASE', 'SUGUBA_CHEAPER_DISTRICT_PURCHASE');
UPDATE ModifierArguments SET Value=5 WHERE ModifierId='SUGUBA_CHEAPER_UNIT_PURCHASE' AND Name='Amount';

--17/04/23 Reduction to buy desert tiles
INSERT INTO Modifiers (ModifierId, ModifierType) VALUES
    ('BBG_DESERT_PLOT_COST', 'MODIFIER_PLAYER_CITIES_ADJUST_PLOT_PURCHASE_COST_TERRAIN'),
    ('BBG_DESERT_HILLS_PLOT_COST', 'MODIFIER_PLAYER_CITIES_ADJUST_PLOT_PURCHASE_COST_TERRAIN');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
    ('BBG_DESERT_PLOT_COST', 'TerrainType', 'TERRAIN_DESERT'),
    ('BBG_DESERT_PLOT_COST', 'Amount', -50),
    ('BBG_DESERT_HILLS_PLOT_COST', 'TerrainType', 'TERRAIN_DESERT_HILLS'),
    ('BBG_DESERT_HILLS_PLOT_COST', 'Amount', -50);
INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
    ('TRAIT_CIVILIZATION_MALI_GOLD_DESERT', 'BBG_DESERT_PLOT_COST'),
    ('TRAIT_CIVILIZATION_MALI_GOLD_DESERT', 'BBG_DESERT_HILLS_PLOT_COST');

-- 17/04/23 Rework Mali so no need anymore
-- DELETE FROM TraitModifiers WHERE TraitType = 'TRAIT_CIVILIZATION_MALI_GOLD_DESERT' AND ModifierId = 'TRAIT_LESS_UNIT_PRODUCTION';
-- DELETE FROM TraitModifiers WHERE TraitType = 'TRAIT_CIVILIZATION_MALI_GOLD_DESERT' AND ModifierId = 'TRAIT_LESS_BUILDING_PRODUCTION';

-- INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
--     ('TRAIT_CIVILIZATION_MALI_GOLD_DESERT', 'BBG_TRAIT_MALI_LESS_CITY_PRODUCTION'),
--     ('TRAIT_CIVILIZATION_MALI_GOLD_DESERT', 'BBG_TRAIT_MALI_LESS_CHOP_PRODUCTION_GIVER'),
--     ('TRAIT_CIVILIZATION_MALI_GOLD_DESERT', 'BBG_TRAIT_MALI_NORMAL_WONDER_PRODUCTION'),
--     ('TRAIT_CIVILIZATION_MALI_GOLD_DESERT', 'BBG_TRAIT_MALI_NORMAL_DISTRICT_PRODUCTION'),
--     ('TRAIT_CIVILIZATION_MALI_GOLD_DESERT', 'BBG_TRAIT_MALI_NORMAL_PROJECT_PRODUCTION');

-- INSERT INTO Modifiers(ModifierId, ModifierType) VALUES
--     ('BBG_TRAIT_MALI_LESS_CHOP_PRODUCTION_GIVER', 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER'),
--     ('BBG_TRAIT_MALI_LESS_CHOP_PRODUCTION', 'MODIFIER_CITY_ADJUST_RESOURCE_HARVEST_BONUS'),
--     ('BBG_TRAIT_MALI_LESS_CITY_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER'),
--     ('BBG_TRAIT_MALI_NORMAL_WONDER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_WONDER_PRODUCTION'),
--     ('BBG_TRAIT_MALI_NORMAL_DISTRICT_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_ALL_DISTRICTS_PRODUCTION'),
--     ('BBG_TRAIT_MALI_NORMAL_PROJECT_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_ALL_PROJECTS_PRODUCTION');

-- INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
--     ('BBG_TRAIT_MALI_LESS_CITY_PRODUCTION', 'YieldType', 'YIELD_PRODUCTION'),
--     ('BBG_TRAIT_MALI_LESS_CITY_PRODUCTION', 'Amount', '-30'),
--     ('BBG_TRAIT_MALI_NORMAL_WONDER_PRODUCTION', 'Amount', '43'),
--     ('BBG_TRAIT_MALI_NORMAL_DISTRICT_PRODUCTION', 'Amount', '43'),
--     ('BBG_TRAIT_MALI_NORMAL_PROJECT_PRODUCTION', 'Amount', '43');

-- INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
--     ('BBG_TRAIT_MALI_LESS_CHOP_PRODUCTION_GIVER', 'ModifierId', 'BBG_TRAIT_MALI_LESS_CHOP_PRODUCTION'),
--     ('BBG_TRAIT_MALI_LESS_CHOP_PRODUCTION', 'Amount', '-30');


-- --15/12/22 Mali mines from 4 base gold to 1 getting +1 at currency, banks and economics
-- UPDATE ModifierArguments SET Value=1 WHERE ModifierId='TRAIT_MALI_MINES_GOLD' AND Name='Amount';

-- INSERT INTO RequirementSets(RequirementSetId, RequirementSetType) VALUES
--     ('BBG_MINE_AND_CURRENCY', 'REQUIREMENTSET_TEST_ALL'),
--     ('BBG_MINE_AND_BANKING', 'REQUIREMENTSET_TEST_ALL'),
--     ('BBG_MINE_AND_ECONOMICS', 'REQUIREMENTSET_TEST_ALL');
-- INSERT INTO RequirementSetRequirements(RequirementSetId, RequirementId) VALUES
--     ('BBG_MINE_AND_CURRENCY', 'REQUIRES_PLOT_HAS_MINE'),
--     ('BBG_MINE_AND_CURRENCY', 'BBG_UTILS_PLAYER_HAS_TECH_CURRENCY_REQUIREMENT'),
--     ('BBG_MINE_AND_BANKING', 'REQUIRES_PLOT_HAS_MINE'),
--     ('BBG_MINE_AND_BANKING', 'BBG_UTILS_PLAYER_HAS_TECH_BANKING_REQUIREMENT'),
--     ('BBG_MINE_AND_ECONOMICS', 'REQUIRES_PLOT_HAS_MINE'),
--     ('BBG_MINE_AND_ECONOMICS', 'BBG_UTILS_PLAYER_HAS_TECH_ECONOMICS_REQUIREMENT');

-- INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES
--     ('BBG_TRAIT_MALI_MINES_GOLD_CURRENCY', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 'BBG_MINE_AND_CURRENCY'),
--     ('BBG_TRAIT_MALI_MINES_GOLD_BANKING', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 'BBG_MINE_AND_BANKING'),
--     ('BBG_TRAIT_MALI_MINES_GOLD_ECONOMICS', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 'BBG_MINE_AND_ECONOMICS');
-- INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
--     ('BBG_TRAIT_MALI_MINES_GOLD_CURRENCY', 'YieldType', 'YIELD_GOLD'),
--     ('BBG_TRAIT_MALI_MINES_GOLD_CURRENCY', 'Amount', '1'),
--     ('BBG_TRAIT_MALI_MINES_GOLD_BANKING', 'YieldType', 'YIELD_GOLD'),
--     ('BBG_TRAIT_MALI_MINES_GOLD_BANKING', 'Amount', '1'),
--     ('BBG_TRAIT_MALI_MINES_GOLD_ECONOMICS', 'YieldType', 'YIELD_GOLD'),
--     ('BBG_TRAIT_MALI_MINES_GOLD_ECONOMICS', 'Amount', '1');

-- INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
--     ('TRAIT_CIVILIZATION_MALI_GOLD_DESERT', 'BBG_TRAIT_MALI_MINES_GOLD_CURRENCY'),
--     ('TRAIT_CIVILIZATION_MALI_GOLD_DESERT', 'BBG_TRAIT_MALI_MINES_GOLD_BANKING'),
--     ('TRAIT_CIVILIZATION_MALI_GOLD_DESERT', 'BBG_TRAIT_MALI_MINES_GOLD_ECONOMICS');
-- -- citizen yields
-- UPDATE District_CitizenYieldChanges SET YieldChange=4 WHERE YieldType='YIELD_GOLD' AND DistrictType='DISTRICT_SUGUBA';

-- --Mali Engineer Fix
-- INSERT INTO Requirements(RequirementId, RequirementType, Inverse) VALUES
--     ('PLAYER_IS_MALI_BBG_REQ', 'REQUIREMENT_PLAYER_TYPE_MATCHES', 0),
--     ('PLAYER_IS_NOT_MALI_BBG_REQ', 'REQUIREMENT_PLAYER_TYPE_MATCHES', 1);
-- INSERT INTO RequirementArguments(RequirementId, Name, Value) VALUES
--     ('PLAYER_IS_MALI_BBG_REQ', 'CivilizationType', 'CIVILIZATION_MALI'),
--     ('PLAYER_IS_NOT_MALI_BBG_REQ', 'CivilizationType', 'CIVILIZATION_MALI');
-- INSERT INTO RequirementSets(RequirementSetId, RequirementSetType) VALUES
--     ('PLAYER_IS_MALI_BBG_REQSET', 'REQUIREMENTSET_TEST_ALL'),
--     ('PLAYER_IS_NOT_MALI_BBG_REQSET', 'REQUIREMENTSET_TEST_ALL');   
-- INSERT INTO RequirementSetRequirements(RequirementSetId, RequirementId) VALUES
--     ('PLAYER_IS_MALI_BBG_REQSET', 'PLAYER_IS_MALI_BBG_REQ'),
--     ('PLAYER_IS_NOT_MALI_BBG_REQSET', 'PLAYER_IS_NOT_MALI_BBG_REQ');
-- UPDATE Modifiers SET SubjectRequirementSetId = 'PLAYER_IS_NOT_MALI_BBG_REQSET' WHERE ModifierId = 'GREATPERSON_GRANT_PRODUCTION_IN_CITY_MEDIEVAL';
-- UPDATE Modifiers SET SubjectRequirementSetId = 'PLAYER_IS_NOT_MALI_BBG_REQSET' WHERE ModifierId = 'GREATPERSON_GRANT_PRODUCTION_IN_CITY_RENAISSANCE';
-- UPDATE Modifiers SET SubjectRequirementSetId = 'PLAYER_IS_NOT_MALI_BBG_REQSET' WHERE ModifierId = 'GREATPERSON_GRANT_PRODUCTION_IN_CITY_INDUSTRIAL';
-- UPDATE Modifiers SET SubjectRequirementSetId = 'PLAYER_IS_NOT_MALI_BBG_REQSET' WHERE ModifierId = 'GREATPERSON_GRANT_PRODUCTION_IN_CITY_EARLY_SPACE_RACE';
-- INSERT INTO Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) VALUES
--     ('GREATPERSON_GRANT_PRODUCTION_IN_CITY_MEDIEVAL_MALI_BBG', 'MODIFIER_SINGLE_CITY_GRANT_PRODUCTION_IN_CITY', 'PLAYER_IS_MALI_BBG_REQSET');
-- INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, SubjectRequirementSetId) VALUES
--     ('GREATPERSON_GRANT_PRODUCTION_IN_CITY_RENAISSANCE_MALI_BBG', 'MODIFIER_SINGLE_CITY_GRANT_PRODUCTION_IN_CITY', 1, 1, 'PLAYER_IS_MALI_BBG_REQSET'),
--     ('GREATPERSON_GRANT_PRODUCTION_IN_CITY_INDUSTRIAL_MALI_BBG', 'MODIFIER_SINGLE_CITY_GRANT_PRODUCTION_IN_CITY', 1, 1, 'PLAYER_IS_MALI_BBG_REQSET'),
--     ('GREATPERSON_GRANT_PRODUCTION_IN_CITY_EARLY_SPACE_RACE_MALI_BBG', 'MODIFIER_SINGLE_CITY_GRANT_PRODUCTION_IN_CITY', 1, 1, 'PLAYER_IS_MALI_BBG_REQSET');
-- INSERT INTO ModifierArguments(ModifierId, Name, Type, Value) VALUES
--     ('GREATPERSON_GRANT_PRODUCTION_IN_CITY_MEDIEVAL_MALI_BBG', 'Amount', 'ScaleByGameSpeed', 151),
--     ('GREATPERSON_GRANT_PRODUCTION_IN_CITY_MEDIEVAL_MALI_BBG', 'KeepOverflow', 'ARGTYPE_IDENTITY', 0),
--     ('GREATPERSON_GRANT_PRODUCTION_IN_CITY_RENAISSANCE_MALI_BBG', 'Amount', 'ScaleByGameSpeed', 222),
--     ('GREATPERSON_GRANT_PRODUCTION_IN_CITY_RENAISSANCE_MALI_BBG', 'KeepOverflow', 'ARGTYPE_IDENTITY', 0),
--     ('GREATPERSON_GRANT_PRODUCTION_IN_CITY_INDUSTRIAL_MALI_BBG', 'Amount', 'ScaleByGameSpeed', 338),
--     ('GREATPERSON_GRANT_PRODUCTION_IN_CITY_INDUSTRIAL_MALI_BBG', 'KeepOverflow', 'ARGTYPE_IDENTITY', 0),
--     ('GREATPERSON_GRANT_PRODUCTION_IN_CITY_EARLY_SPACE_RACE_MALI_BBG', 'Amount', 'ScaleByGameSpeed', 1056),
--     ('GREATPERSON_GRANT_PRODUCTION_IN_CITY_EARLY_SPACE_RACE_MALI_BBG', 'KeepOverflow', 'ARGTYPE_IDENTITY', 0);
-- INSERT INTO GreatPersonIndividualActionModifiers(GreatPersonIndividualType, ModifierId, AttachmentTargetType) VALUES
--     ('GREAT_PERSON_INDIVIDUAL_ISIDORE_OF_MILETUS', 'GREATPERSON_GRANT_PRODUCTION_IN_CITY_MEDIEVAL_MALI_BBG', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_DISTRICT_WONDER_IN_TILE'),
--     ('GREAT_PERSON_INDIVIDUAL_FILIPPO_BRUNELLESCHI', 'GREATPERSON_GRANT_PRODUCTION_IN_CITY_RENAISSANCE_MALI_BBG', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_DISTRICT_WONDER_IN_TILE'),
--     ('GREAT_PERSON_INDIVIDUAL_GUSTAVE_EIFFEL', 'GREATPERSON_GRANT_PRODUCTION_IN_CITY_INDUSTRIAL_MALI_BBG', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_DISTRICT_WONDER_IN_TILE'),
--     ('GREAT_PERSON_INDIVIDUAL_SERGEI_KOROLEV', 'GREATPERSON_GRANT_PRODUCTION_IN_CITY_EARLY_SPACE_RACE_MALI_BBG', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_DISTRICT_IN_TILE');
-- --Mali Engineer Bug
-- --Isidore - prod 215
-- --Imotep - 175 - 350
-- --Filippo Brunelleschi  - 315
-- --Eiffel 480
-- --Korolev 1500
