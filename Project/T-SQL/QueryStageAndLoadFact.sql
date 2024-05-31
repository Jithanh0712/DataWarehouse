--fact
--StudentAssessment
SELECT        a.code_module, a.code_presentation, a.id_assessment, a.date , s.id_student, s.date_submitted, s.is_banked, s.score, a.assessment_type
FROM            assessments AS a 
INNER JOIN studentAssessment AS s 
ON a.id_assessment = s.id_assessment;


CREATE TABLE [stgStudentAssessment] (
    [code_module] nvarchar(50),
    [code_presentation] nvarchar(50),
    [id_assessment] bigint,
    [date] int,
    [id_student] bigint,
    [date_submitted] int,
    [is_banked] bit,
    [score] bigint,
    [assessment_type] nvarchar(50)
);

SELECT        si.studentInfoKey, c.code_module_Key, t.code_presentation_Key, st.assessment_typeKey, sr.date, sr.date_submitted, sr.is_banked, sr.score, sr.id_assessment
FROM            stgStudentAssessment AS sr INNER JOIN
                         HigherEducationDW.dbo.DimStudentInfo AS si ON sr.id_student = si.id_student INNER JOIN
                         HigherEducationDW.dbo.DimTerms AS t ON sr.code_presentation = t.code_presentation INNER JOIN
                         HigherEducationDW.dbo.DimCourses AS c ON sr.code_module = c.code_module INNER JOIN
                         HigherEducationDW.dbo.DimAssessmentTypes AS st ON sr.assessment_type = st.assessment_type

--StudentVle
SELECT  st.id_student, st.id_site, st.date, st.sum_click, vl.activity_type, vl.week_from, vl.week_to, st.code_module, st.code_presentation
FROM studentVle AS st 
INNER JOIN vle AS vl 
ON st.id_site = vl.id_site;

CREATE TABLE [stgStudentVle] (
    [code_module] nvarchar(50),
    [code_presentation] nvarchar(50),
    [id_student] bigint,
    [id_site] bigint,
    [date] int,
    [sum_click] int,
    [activity_type] nvarchar(50),
    [week_from] int,
    [week_to] int
);

SELECT si.studentInfoKey, c.code_module_Key, t.code_presentation_Key, v.vle_activity_type_Key, id_site, date, 
sum_click, week_from, week_to
FROM HigherEducationStage.dbo.stgStudentVle sr
JOIN HigherEducationDW.dbo.DimStudentInfo si ON sr.id_student = si.id_student
JOIN HigherEducationDW.dbo.DimTerms t ON sr.code_presentation = t.code_presentation
JOIN HigherEducationDW.dbo.DimCourses c ON sr.code_module = c.code_module
JOIN HigherEducationDW.dbo.DimVle v on sr.activity_type= v.vle_activity_type;

--StudentCourses
CREATE TABLE [stgStudentCourses] (
    [code_module] nvarchar(50),
    [code_presentation] nvarchar(50),
    [module_presentation_length] int
);

SELECT        si.studentInfoKey, c.code_module_Key, t.code_presentation_Key, st.assessment_typeKey, sr.date, sr.date_submitted, sr.is_banked, sr.score, sr.id_assessment
FROM            stgStudentAssessment AS sr INNER JOIN
                         HigherEducationDW.dbo.DimStudentInfo AS si ON sr.id_student = si.id_student INNER JOIN
                         HigherEducationDW.dbo.DimTerms AS t ON sr.code_presentation = t.code_presentation INNER JOIN
                         HigherEducationDW.dbo.DimCourses AS c ON sr.code_module = c.code_module INNER JOIN
                         HigherEducationDW.dbo.DimAssessmentTypes AS st ON sr.assessment_type = st.assessment_type;

--StudentRegistration
CREATE TABLE [stgStudentRegistration] (
    [code_module] nvarchar(50),
    [code_presentation] nvarchar(50),
    [id_student] bigint,
    [date_registration] int,
    [date_unregistration] int
);

SELECT si.studentInfoKey, c.code_module_Key, t.code_presentation_Key, sr.date_registration, sr.date_unregistration
FROM HigherEducationStage.dbo.stgStudentRegistration sr
INNER JOIN HigherEducationDW.dbo.DimStudentInfo si ON sr.id_student = si.id_student
INNER JOIN HigherEducationDW.dbo.DimTerms t ON sr.code_presentation = t.code_presentation
INNER JOIN HigherEducationDW.dbo.DimCourses c ON sr.code_module = c.code_module;