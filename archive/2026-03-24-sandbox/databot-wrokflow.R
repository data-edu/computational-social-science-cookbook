
import_data <- function(file_path) {
  readr::read_csv(
    file_path,
    col_types = readr::cols(
      id = readr::col_character(),
      grade = readr::col_character(),
      score = readr::col_double(),
      gender = readr::col_character(),
      attendance_rate = readr::col_double(),
      district = readr::col_character()
    ),
    na = c("", "NA", "N/A", "null"),
    trim_ws = TRUE
  )
}



validate_teacher_survey <- function(df) {
  required_cols <- c(
    "teacher_id", "school_level", "years_experience",
    "ai_confidence", "pd_hours", "district"
  )

  missing_cols <- setdiff(required_cols, names(df))
  if (length(missing_cols) > 0) {
    stop(sprintf("Missing required column(s): %s", paste(missing_cols, collapse = ", ")))
  }

  if (!is.numeric(df$ai_confidence)) {
    stop("ai_confidence must be numeric")
  }
  bad_ai <- which(!is.na(df$ai_confidence) & (df$ai_confidence < 1 | df$ai_confidence > 5))
  if (length(bad_ai) > 0) {
    stop(sprintf(
      "ai_confidence out of range 1-5 in %d row(s): %s",
      length(bad_ai),
      paste(head(bad_ai, 10), collapse = ", ")
    ))
  }

  if (!is.numeric(df$years_experience)) {
    stop("years_experience must be numeric")
  }
  bad_years <- which(!is.na(df$years_experience) & df$years_experience < 0)
  if (length(bad_years) > 0) {
    stop(sprintf(
      "years_experience negative in %d row(s): %s",
      length(bad_years),
      paste(head(bad_years, 10), collapse = ", ")
    ))
  }

  message("All validation checks passed")
  TRUE
}








student_data <- import_data("data/ch6_demo/student_scores.csv")
teacher_df <- readr::read_csv("data/ch6_demo/teacher_survey.csv", show_col_types = FALSE)
validate_teacher_survey(teacher_df)

student_summary <- student_data |>
  dplyr::filter(!is.na(score)) |>
  dplyr::group_by(grade) |>
  dplyr::summarize(mean_score = mean(score, na.rm = TRUE), n = dplyr::n(), .groups = "drop")
p_scores <- ggplot2::ggplot(student_data, ggplot2::aes(x = grade, y = score, fill = grade)) +
  ggplot2::geom_boxplot(na.rm = TRUE) +
  ggplot2::theme_minimal()
student_summary
p_scores