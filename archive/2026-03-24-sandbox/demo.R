suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
  library(stringr)
  library(tibble)
  library(ggplot2)
})

set.seed(2026)

cat("\n=== Chapter 6 Demo (Focused on 6.5.2 and 6.5.3) ===\n")
cat("Run this script once, then follow the printed Databot steps.\n\n")

# -----------------------------------------------------------------------------
# 0) One-time manual setup in Positron (for Databot screenshots)
# -----------------------------------------------------------------------------

cat("=== Manual setup checklist ===\n")
cat("1) Enable Positron Assistant: positron.assistant.enable\n")
cat("2) Reload window: Developer: Reload Window\n")
cat("3) Configure provider: Positron Assistant: Configure Language Model Providers\n")
cat("4) Install Databot extension (if not installed)\n")
cat("5) Acknowledge research preview: databot.researchPreviewAcknowledgment = 'Acknowledged'\n")
cat("6) Open Databot: Command Palette -> Open Databot\n\n")

# -----------------------------------------------------------------------------
# 1) Create demo folders and data used by 6.5.2 / 6.5.3
# -----------------------------------------------------------------------------

dir.create("data/ch6_demo", recursive = TRUE, showWarnings = FALSE)
dir.create("data/ch6_images", recursive = TRUE, showWarnings = FALSE)

student_data <- tibble(
  id = sprintf("S%03d", 1:120),
  grade = sample(c("Grade 6", "Grade 7", "Grade 8"), 120, replace = TRUE),
  score = round(rnorm(120, mean = 76, sd = 12), 1),
  gender = sample(c("Female", "Male", "Non-binary"), 120, replace = TRUE),
  attendance_rate = round(runif(120, 0.70, 1.00), 2),
  district = sample(c("North", "South", "East", "West"), 120, replace = TRUE)
)

# Missing values + messy strings for realistic cleaning/validation behavior
student_data$score[sample(1:nrow(student_data), 12)] <- NA
student_data$district[sample(1:nrow(student_data), 8)] <- c(
  " North", "South  ", "  East", "West ",
  " North ", " South", "East  ", "  West"
)

teacher_survey <- tibble(
  teacher_id = sprintf("T%03d", 1:60),
  school_level = sample(c("Elementary", "Middle", "High"), 60, replace = TRUE),
  years_experience = sample(0:35, 60, replace = TRUE),
  ai_confidence = sample(1:5, 60, replace = TRUE),
  pd_hours = round(rnorm(60, mean = 18, sd = 6), 1),
  district = sample(c("North", "South", "East", "West"), 60, replace = TRUE)
)

# Inject invalid values for 6.5.3 validation screenshot
teacher_survey$ai_confidence[c(5, 18)] <- c(0, 7)
teacher_survey$years_experience[12] <- -2

write_csv(student_data, "data/ch6_demo/student_scores.csv")
write_csv(teacher_survey, "data/ch6_demo/teacher_survey.csv")

cat("Created data:\n")
cat("- data/ch6_demo/student_scores.csv\n")
cat("- data/ch6_demo/teacher_survey.csv\n\n")

# -----------------------------------------------------------------------------
# 2) Optional: quick checks in console so you know data is ready
# -----------------------------------------------------------------------------

student_check <- read_csv("data/ch6_demo/student_scores.csv", show_col_types = FALSE)
teacher_check <- read_csv("data/ch6_demo/teacher_survey.csv", show_col_types = FALSE)

cat("Quick checks:\n")
cat(sprintf("- student_scores rows: %d\n", nrow(student_check)))
cat(sprintf("- teacher_survey rows: %d\n", nrow(teacher_check)))
cat(sprintf("- score NA count: %d\n", sum(is.na(student_check$score))))
cat(sprintf("- ai_confidence outside 1-5: %d\n", sum(!(teacher_check$ai_confidence %in% 1:5))))
cat(sprintf("- negative years_experience: %d\n\n", sum(teacher_check$years_experience < 0)))

# -----------------------------------------------------------------------------
# 3) Exact screenshot playbook for 6.5.2 and 6.5.3
# -----------------------------------------------------------------------------

prompt_652 <- paste(
  "Create a reusable R function named import_data(file_path) that reads CSV files",
  "from data/ch6_demo using readr::read_csv().",
  "Use explicit col_types for id, grade, score, gender, attendance_rate, district,",
  "set na = c('', 'NA', 'N/A', 'null'), and trim string whitespace.",
  "Then show one example call for student_scores.csv."
)

prompt_653 <- paste(
  "Generate an R function validate_teacher_survey(df) with checks for:",
  "(1) required columns teacher_id, school_level, years_experience, ai_confidence, pd_hours, district;",
  "(2) ai_confidence must be between 1 and 5;",
  "(3) years_experience must be >= 0;",
  "(4) print clear error messages and return TRUE if all checks pass.",
  "Then show how to run it on data/ch6_demo/teacher_survey.csv."
)

cat("=== Screenshot actions: Section 6.5.2 (Databot import template) ===\n")
cat("A1. Open Databot panel.\n")
cat("A2. Paste this prompt exactly:\n")
cat(prompt_652, "\n")
cat("A3. Wait until Databot prints the full import function.\n")
cat("A4. Screenshot only Databot panel with the generated function visible.\n")
cat("A5. Save screenshot as: data/ch6_images/databot-import-template.png\n\n")

cat("=== Screenshot actions: Section 6.5.3 (Databot validation checks) ===\n")
cat("B1. In the same Databot session, paste this prompt exactly:\n")
cat(prompt_653, "\n")
cat("B2. Wait until Databot prints validation function + example usage.\n")
cat("B3. Screenshot Databot output where checks/rules are visible.\n")
cat("B4. Save screenshot as: data/ch6_images/databot-validation-checks.png\n\n")

# -----------------------------------------------------------------------------
# 4) Fallback (if Databot is unavailable): use Assistant chat
# -----------------------------------------------------------------------------

cat("=== Fallback option (if Databot not available) ===\n")
cat("Use Positron Assistant chat with the same prompts above.\n")
cat("Keep chapter text as Databot, but screenshots can still show generated import/validation code.\n\n")

# -----------------------------------------------------------------------------
# 5) Remaining chapter image file map
# -----------------------------------------------------------------------------

cat("=== Chapter 6 image filenames ===\n")
cat("data/ch6_images/assistant-panel-overview.png\n")
cat("data/ch6_images/assistant-enable-setting.png\n")
cat("data/ch6_images/assistant-preferences.png\n")
cat("data/ch6_images/assistant-code-explanation.png\n")
cat("data/ch6_images/assistant-debug-suggestion.png\n")
cat("data/ch6_images/databot-import-template.png\n")
cat("data/ch6_images/databot-validation-checks.png\n")
cat("data/ch6_images/complete-workflow-positron.png\n\n")

cat("Done. You can now capture 6.5.2 and 6.5.3 screenshots reliably.\n")
