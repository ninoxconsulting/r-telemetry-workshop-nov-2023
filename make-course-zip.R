# This makes a zip file in the current directory of the files the learners
# will need for the course. They can download it and extract it directly,
# or use usethis::use_course()

d <- withr::local_tempdir()
projdir <- file.path(d, "r-telemetry-workshop")

usethis::create_project(projdir, rstudio = TRUE, open = FALSE)

dir.create(file.path(projdir, "clean_data"))

file.copy("raw_data", projdir, recursive = TRUE)

unlink(file.path(projdir, c("R", ".gitignore")), recursive = TRUE)

outdir <- getwd()

withr::with_dir(projdir, {
  zip(
    file.path(outdir, "r-telemetry-workshop.zip"),
    files = list.files(".", recursive = TRUE, all.files = TRUE, include.dirs = TRUE)
  )
})
