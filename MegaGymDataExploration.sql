SELECT *
FROM MegaGymDataset

--adding comma to the values of rating
UPDATE MegaGymDataset
SET Rating = CONCAT(SUBSTRING(CAST(Rating AS VARCHAR(10)), 1, LEN(CAST(Rating AS VARCHAR(10))) - 1), '.', RIGHT(CAST(Rating AS VARCHAR(10)), 1))
WHERE LEN(CAST(Rating AS VARCHAR(10))) > 1;

SELECT Rating
FROM MegaGymDataset
GROUP BY Rating
ORDER BY Rating DESC


--delete unsual columns
ALTER TABLE MegaGymDataset
DROP COLUMN column1

SELECT *
FROM MegaGymDataset

--showing the highest rating based on exercise
SELECT Title, Rating
FROM MegaGymDataset
WHERE Rating = 9.6

--showing the lowest rating based on exercise
SELECT Title, Rating
FROM MegaGymDataset
WHERE Rating = 0

--showing the average rating based on exercise
SELECT AVG(Rating)
FROM MegaGymDataset

SELECT Title, Rating
FROM MegaGymDataset
WHERE Rating = 5.9

--show how many exercises based on body part
SELECT  BodyPart, COUNT(Title) as CountExercise
FROM MegaGymDataset
GROUP BY BodyPart
ORDER BY CountExercise DESC

--show the best exercise for chest
SELECT BodyPart, Title, Rating, Level
FROM MegaGymDataset
WHERE BodyPart = 'Chest' and Title IN ('Pushups', 'Dumbbell Bench Press', 'Incline dumbbell bench press')
ORDER BY Rating DESC


--show the best exercise for abs
SELECT BodyPart, Title, Rating, Level
FROM MegaGymDataset
WHERE BodyPart = 'Abdominals' and Title IN ('Landmine twist', 'Dumbbell V-Sit Cross Jab', 'Bottoms Up')
ORDER BY Rating DESC


--show the best exercise for quads
SELECT BodyPart, Title, Rating, Level
FROM MegaGymDataset
WHERE BodyPart = 'Quadriceps' and Title in ('Single-Leg Press', 'Clean from Blocks', 'Barbell Full Squat')
ORDER BY Rating DESC


--show the best exercise for shoulders
SELECT DISTINCT BodyPart, Title, Rating, Level
FROM MegaGymDataset
WHERE BodyPart = 'Shoulders' and Title in ('Dumbbell front raise to lateral raise', 'Clean and press', 'Military press')
ORDER BY Rating DESC


--show the best exercise for biceps
SELECT DISTINCT BodyPart, Title, Rating, Level
FROM MegaGymDataset
WHERE BodyPart = 'Biceps' and Title in ('Incline Hammer Curls', 'Wide-grip barbell curl', 'EZ-bar spider curl')
ORDER BY Rating DESC


--show the best exercise for Triceps
SELECT DISTINCT BodyPart, Title, Rating, Level
FROM MegaGymDataset
WHERE BodyPart = 'Triceps' and Title in ('Triceps dip', 'Decline EZ-bar skullcrusher', 'Dumbbell floor press')
ORDER BY Rating DESC


--show the best exercise for lats
SELECT DISTINCT BodyPart, Title, Rating, Level
FROM MegaGymDataset
WHERE BodyPart = 'Lats' and Title in ('Weighted pull-up', 'Pullups', 'Rocky Pull-Ups/Pulldowns')
ORDER BY Rating DESC


--show the best exercise for hamstring
SELECT DISTINCT BodyPart, Title, Rating, Level
FROM MegaGymDataset
WHERE BodyPart = 'Hamstrings' and Title in ('Barbell Deadlift', 'Clean Deadlift', 'Romanian Deadlift With Dumbbells')
ORDER BY Rating DESC

--show the best exercise for Middle Back
SELECT DISTINCT BodyPart, Title, Rating, Level
FROM MegaGymDataset
WHERE BodyPart = 'Middle Back' and Title in ('T-Bar Row with Handle', 'Reverse-grip bent-over row', 'One-Arm Dumbbell Row')
ORDER BY Rating DESC


--show the best exercise for Lower Back
SELECT DISTINCT BodyPart, Title, Rating, Level
FROM MegaGymDataset
WHERE BodyPart = 'Lower Back' and Title in ('Atlas Stones', 'Barbell deficit deadlift', 'Back extension')
ORDER BY Rating DESC


--show the best exercise for Glutes
SELECT DISTINCT BodyPart, Title, Rating, Level
FROM MegaGymDataset
WHERE BodyPart = 'Glutes' and Title in ('Barbell glute bridge', 'Barbell Hip Thrust', 'Single-leg cable hip extension')
ORDER BY Rating DESC

--show the best exercise for Calves
SELECT DISTINCT BodyPart, Title, Rating, Level
FROM MegaGymDataset
WHERE BodyPart = 'Calves' and Title in ('Smith Machine Calf Raise', 'Standing Calf Raises','Calf Press On The Leg Press Machine')
ORDER BY Rating DESC

--show the best exercise for Forearms
SELECT DISTINCT BodyPart, Title, Rating, Level
FROM MegaGymDataset
WHERE BodyPart = 'Forearms' and Title in ('Rickshaw Carry', 'Palms-down wrist curl over bench', 'Dumbbell Farmer''s Walk')
ORDER BY Rating DESC

--show the best exercise for Traps
SELECT DISTINCT BodyPart, Title, Rating, Level
FROM MegaGymDataset
WHERE BodyPart = 'Traps' and Title in ('Leverage Shrug', 'Standing dumbbell shrug', 'Smith Machine Shrug')
ORDER BY Rating DESC

--show the best exercise for Abductors
SELECT DISTINCT BodyPart, Title, Rating, Level
FROM MegaGymDataset
WHERE BodyPart = 'Abductors'and Title in ('Standing Hip Circles', 'Iliotibial band SMR', 'Thigh abductor')
ORDER BY Rating DESC

--show the best exercise for Adductors
SELECT DISTINCT BodyPart, Title, Rating, Level
FROM MegaGymDataset
WHERE BodyPart = 'Adductors'and Title in ('Thigh adductor', 'Groiners', 'Band Hip Adductions')
ORDER BY Rating DESC

--show the best exercise for Neck
SELECT DISTINCT BodyPart, Title, Rating, Level
FROM MegaGymDataset
WHERE BodyPart = 'Neck'and Title in ('Lying Face Down Plate Neck Resistance', 'Lying Face Up Plate Neck Resistance', 'Seated Head Harness Neck Resistance')
ORDER BY Rating DESC

CREATE TABLE Top3Exercises
(BodyPart nvarchar(50) NOT NULL, 
Exercise nvarchar(100) NOT NULL, 
Rating float NOT NULL, 
Level nvarchar(50) NOT NULL
);

-- Insert for Chest
INSERT INTO Top3Exercises (BodyPart, Exercise, Rating, Level)
SELECT BodyPart, Title, Rating, Level
FROM MegaGymDataset
WHERE BodyPart = 'Chest' and Title IN ('Pushups', 'Dumbbell Bench Press', 'Incline dumbbell bench press')
ORDER BY Rating DESC;

-- Insert for Abdominals
INSERT INTO Top3Exercises (BodyPart, Exercise, Rating, Level)
SELECT BodyPart, Title, Rating, Level
FROM MegaGymDataset
WHERE BodyPart = 'Abdominals' and Title IN ('Landmine twist', 'Dumbbell V-Sit Cross Jab', 'Bottoms Up')
ORDER BY Rating DESC;

-- Insert for Quadriceps
INSERT INTO Top3Exercises (BodyPart, Exercise, Rating, Level)
SELECT BodyPart, Title, Rating, Level
FROM MegaGymDataset
WHERE BodyPart = 'Quadriceps' and Title in ('Single-Leg Press', 'Clean from Blocks', 'Barbell Full Squat')
ORDER BY Rating DESC;

-- Insert for Shoulders
INSERT INTO Top3Exercises (BodyPart, Exercise, Rating, Level)
SELECT DISTINCT BodyPart, Title, Rating, Level
FROM MegaGymDataset
WHERE BodyPart = 'Shoulders' and Title in ('Dumbbell front raise to lateral raise', 'Clean and press', 'Military press')
ORDER BY Rating DESC;

-- Insert for Biceps
INSERT INTO Top3Exercises (BodyPart, Exercise, Rating, Level)
SELECT DISTINCT BodyPart, Title, Rating, Level
FROM MegaGymDataset
WHERE BodyPart = 'Biceps' and Title in ('Incline Hammer Curls', 'Wide-grip barbell curl', 'EZ-bar spider curl')
ORDER BY Rating DESC;

-- Insert for Triceps
INSERT INTO Top3Exercises (BodyPart, Exercise, Rating, Level)
SELECT DISTINCT BodyPart, Title, Rating, Level
FROM MegaGymDataset
WHERE BodyPart = 'Triceps' and Title in ('Triceps dip', 'Decline EZ-bar skullcrusher', 'Dumbbell floor press')
ORDER BY Rating DESC;

-- Insert for Lats
INSERT INTO Top3Exercises (BodyPart, Exercise, Rating, Level)
SELECT DISTINCT BodyPart, Title, Rating, Level
FROM MegaGymDataset
WHERE BodyPart = 'Lats' and Title in ('Weighted pull-up', 'Pullups', 'Rocky Pull-Ups/Pulldowns')
ORDER BY Rating DESC;

-- Insert for Hamstrings
INSERT INTO Top3Exercises (BodyPart, Exercise, Rating, Level)
SELECT DISTINCT BodyPart, Title, Rating, Level
FROM MegaGymDataset
WHERE BodyPart = 'Hamstrings' and Title in ('Barbell Deadlift', 'Clean Deadlift', 'Romanian Deadlift With Dumbbells')
ORDER BY Rating DESC;

-- Insert for Middle Back
INSERT INTO Top3Exercises (BodyPart, Exercise, Rating, Level)
SELECT DISTINCT BodyPart, Title, Rating, Level
FROM MegaGymDataset
WHERE BodyPart = 'Middle Back' and Title in ('T-Bar Row with Handle', 'Reverse-grip bent-over row', 'One-Arm Dumbbell Row')
ORDER BY Rating DESC;

-- Insert for Lower Back
INSERT INTO Top3Exercises (BodyPart, Exercise, Rating, Level)
SELECT DISTINCT BodyPart, Title, Rating, Level
FROM MegaGymDataset
WHERE BodyPart = 'Lower Back' and Title in ('Atlas Stones', 'Barbell deficit deadlift', 'Back extension')
ORDER BY Rating DESC;

-- Insert for Glutes
INSERT INTO Top3Exercises (BodyPart, Exercise, Rating, Level)
SELECT DISTINCT BodyPart, Title, Rating, Level
FROM MegaGymDataset
WHERE BodyPart = 'Glutes' and Title in ('Barbell glute bridge', 'Barbell Hip Thrust', 'Single-leg cable hip extension')
ORDER BY Rating DESC;

-- Insert for Calves
INSERT INTO Top3Exercises (BodyPart, Exercise, Rating, Level)
SELECT DISTINCT BodyPart, Title, Rating, Level
FROM MegaGymDataset
WHERE BodyPart = 'Calves' and Title in ('Smith Machine Calf Raise', 'Standing Calf Raises', 'Calf Press On The Leg Press Machine')
ORDER BY Rating DESC;

-- Insert for Forearms
INSERT INTO Top3Exercises (BodyPart, Exercise, Rating, Level)
SELECT DISTINCT BodyPart, Title, Rating, Level
FROM MegaGymDataset
WHERE BodyPart = 'Forearms' and Title in ('Rickshaw Carry', 'Palms-down wrist curl over bench', 'Dumbbell Farmer''s Walk')
ORDER BY Rating DESC;

-- Insert for Traps
INSERT INTO Top3Exercises (BodyPart, Exercise, Rating, Level)
SELECT DISTINCT BodyPart, Title, Rating, Level
FROM MegaGymDataset
WHERE BodyPart = 'Traps' and Title in ('Leverage Shrug', 'Standing dumbbell shrug', 'Smith Machine Shrug')
ORDER BY Rating DESC;

-- Insert for Abductors
INSERT INTO Top3Exercises (BodyPart, Exercise, Rating, Level)
SELECT DISTINCT BodyPart, Title, Rating, Level
FROM MegaGymDataset
WHERE BodyPart = 'Abductors' and Title in ('Standing Hip Circles', 'Iliotibial band SMR', 'Thigh abductor')
ORDER BY Rating DESC;

-- Insert for Adductors
INSERT INTO Top3Exercises (BodyPart, Exercise, Rating, Level)
SELECT DISTINCT BodyPart, Title, Rating, Level
FROM MegaGymDataset
WHERE BodyPart = 'Adductors' and Title in ('Thigh adductor', 'Groiners', 'Band Hip Adductions')
ORDER BY Rating DESC;

-- Insert for Neck
INSERT INTO Top3Exercises (BodyPart, Exercise, Rating, Level)
SELECT DISTINCT BodyPart, Title, Rating, Level
FROM MegaGymDataset
WHERE BodyPart = 'Neck' and Title in ('Lying Face Down Plate Neck Resistance', 'Lying Face Up Plate Neck Resistance', 'Seated Head Harness Neck Resistance')
ORDER BY Rating DESC;

--show total type of exercise
SELECT Type, COUNT(Type) AS TotalType
FROM MegaGymDataset
GROUP BY Type
ORDER BY TotalType DESC

SELECT Type, Title
FROM MegaGymDataset
WHERE Type = 'Strength'

--show total equipment that is used
SELECT Equipment, COUNT(Equipment) AS TotalEquipment
FROM MegaGymDataset
GROUP BY Equipment
ORDER BY TotalEquipment DESC

--show the level of exercise
SELECT Level, COUNT(Level) AS TotalExercise
FROM MegaGymDataset
GROUP BY Level
ORDER BY TotalExercise









