# CS Curricular Planning Data Modeling

## Course Models

### Semester
* `academic_year` : string
* `academic_semester` : string (ex. fall or spring)
* `courses_offered`: [Offering]

### Course
* `course_id` : string (ex. "TUT 100" / "CSC 151")
* `title` : string
* `description` : string
* `required` : boolean
* `offerings` : [Offering]

### Offering
* `course` : Course
* `professor` : Professor
* `time` : string
* `semester` : Semester
* `students_planned` : [Student]
* `capacity` : integer

## Other Possible Models

### Student
* `name` : nametype
* `password` : hashed string
* `graduating_year` : integer
* `advisor` : Professor
* `courses_planned` : [Offering]

### Professor
* `name` : nametype
* `password` : hashed string
* `advisees` : [Student]
* `teaches` : [Offering]

## Relationships

* `Student` to `Offering` is many-to-many
* `Semester` has many `Offering`s; and `Offering` has one `Semester`
* `Course` has many `Offering`s; and `Offering` has one `Course`
* `Student` has a `Professor` (advisor); and `Professor` has many `Student`s
* `Offering` has a `Professor`; and `Professor` has many `Offering`s
