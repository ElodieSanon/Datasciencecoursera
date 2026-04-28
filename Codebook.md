## Source
Data from Human Activity Recognition Using Smartphones project.
Collected from accelerometers of the Samsung Galaxy S smartphone.

## Identification Variables

- subject : Participant ID (1 to 30)
- activity : Activity performed (6 levels)
- WALKING
- WALKING_UPSTAIRS
- WALKING_DOWNSTAIRS
- SITTING
- STANDING
- LAYING

## Measurement Variables (66 variables)

Each variable is the MEAN of the original measurements
grouped by subject and activity.

Variable naming convention:
- Time_ : time domain signal
- Frequency_ : frequency domain signal (FFT)
- Accelerometer : accelerometer sensor
- Gyroscope : gyroscope sensor
- Body : body component
- Gravity : gravity component
- Magnitude : Euclidean magnitude
- _Mean : mean value
- _Std : standard deviation
- _X / _Y / _Z : axis of measurement

## Transformations

1. Merged train and test into one dataset (10,299 observations)
2. Selected 66 variables containing mean() and std()
3. Replaced numeric activity codes with descriptive labels
4. Renamed variables with full descriptive names
5. Computed average of each variable per subject and activity
Final dataset: 180 rows x 68 columns

## Units
All signals are normalized (no unit, between -1 and 1).
All values in tidy_data.txt are means of normalized signals.