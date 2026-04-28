## ============================================================
## run_analysis.R
## Getting and Cleaning Data - Course Project
## UCI HAR Dataset
## ============================================================
library(dplyr)
# ---------------------------------------------------------
# 0. Télécharger et dézipper les données (si pas encore fait)
# ---------------------------------------------------------
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists("UCI_HAR_Dataset.zip")) {
  download.file(url, destfile = "UCI_HAR_Dataset.zip", method = "curl")
}
if (!dir.exists("UCI HAR Dataset")) {
  unzip("UCI_HAR_Dataset.zip")
}
setwd("UCI HAR Dataset")
# ---------------------------------------------------------
# ÉTAPE 1 : Fusionner train et test en un seul dataset
# ---------------------------------------------------------
# Données d'entraînement
X_train      <- read.table("train/X_train.txt")
y_train      <- read.table("train/y_train.txt",      col.names = "activity")
subject_train <- read.table("train/subject_train.txt", col.names = "subject")
# Données de test
X_test      <- read.table("test/X_test.txt")
y_test      <- read.table("test/y_test.txt",      col.names = "activity")
subject_test <- read.table("test/subject_test.txt", col.names = "subject")
# Fusion
X       <- rbind(X_train, X_test)
y       <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
cat("Étape 1 terminée : dataset fusionné -", nrow(X), "observations\n")
# ---------------------------------------------------------
# ÉTAPE 2 : Extraire uniquement mean() et std()
# ---------------------------------------------------------
features <- read.table("features.txt", col.names = c("id", "name"))
# Colonnes contenant mean() ou std()
idx      <- grep("mean\\(\\)|std\\(\\)", features$name)
X        <- X[, idx]
cat("Étape 2 terminée :", ncol(X), "variables sélectionnées (mean & std)\n")
# ---------------------------------------------------------
# ÉTAPE 3 : Utiliser des noms d'activités descriptifs
# ---------------------------------------------------------
activity_labels <- read.table("activity_labels.txt",
                               col.names = c("id", "label"))
y$activity <- activity_labels$label[y$activity]
cat("Étape 3 terminée : activités nommées\n")
print(unique(y$activity))
# ---------------------------------------------------------
# ÉTAPE 4 : Nommer les variables avec des noms descriptifs
# ---------------------------------------------------------
var_names <- features$name[idx]
# Nettoyage des noms
var_names <- gsub("^t",         "Time_",        var_names)
var_names <- gsub("^f",         "Frequency_",   var_names)
var_names <- gsub("Acc",        "Accelerometer",var_names)
var_names <- gsub("Gyro",       "Gyroscope",    var_names)
var_names <- gsub("Mag",        "Magnitude",    var_names)
var_names <- gsub("BodyBody",   "Body",         var_names)
var_names <- gsub("-mean\\(\\)","_Mean",        var_names)
var_names <- gsub("-std\\(\\)", "_Std",         var_names)
var_names <- gsub("-",          "_",            var_names)
var_names <- gsub("[()]",       "",             var_names)
names(X) <- var_names
# Assembler le dataset complet
data_full <- cbind(subject, y, X)
cat("Étape 4 terminée : variables renommées\n")
# ---------------------------------------------------------
# ÉTAPE 5 : Dataset tidy avec moyenne par activité et sujet
# ---------------------------------------------------------
tidy_data <- data_full %>%
  group_by(subject, activity) %>%
  summarise(across(everything(), mean, .names = "{.col}"), .groups = "drop")
# Sauvegarder
write.table(tidy_data, "../tidy_data.txt", row.names = FALSE)
cat("\nÉtape 5 terminée !\n")
cat("Tidy dataset sauvegardé : tidy_data.txt\n")
cat("Dimensions :", nrow(tidy_data), "x", ncol(tidy_data), "\n")
cat("\nAperçu :\n")
print(head(tidy_data[, 1:5]))