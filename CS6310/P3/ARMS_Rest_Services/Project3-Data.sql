-- University
insert into ARMS_DB.University( name ) values( "Georgia Tech" );

-- Course Stuff
insert into ARMS_DB.Courses( name, availableTerms, enrollmentLimit, University_id ) values( "CS 6210 Advanced Operating Systems", "Fall", 50, 1 );
insert into ARMS_DB.Courses( name, availableTerms, enrollmentLimit, University_id ) values( "CS 6250 Computer Networks", "Fall Spring Summer", 50, 1 );
insert into ARMS_DB.Courses( name, availableTerms, enrollmentLimit, University_id ) values( "CS 6300 Software Development Process", "Fall Spring Summer", 50, 1 );
insert into ARMS_DB.Courses( name, availableTerms, enrollmentLimit, University_id ) values( "CS 7641 Machine Learning", "Fall Spring Summer", 50, 1 );
insert into ARMS_DB.Courses( name, availableTerms, enrollmentLimit, University_id ) values( "CS 6290 High Performance Computer Architecture", "Spring", 50, 1 );
insert into ARMS_DB.Courses( name, availableTerms, enrollmentLimit, University_id ) values( "CS 6310 Software Architecture and Design", "Fall Spring Summer", 50, 1 );
insert into ARMS_DB.Courses( name, availableTerms, enrollmentLimit, University_id ) values( "CS 6440 Intro to Health Informatics", "Fall", 50, 1 );
insert into ARMS_DB.Courses( name, availableTerms, enrollmentLimit, University_id ) values( "CS 6505 Computability, Complexity and Algorithms", "Fall Spring Summer", 50, 1 );
insert into ARMS_DB.Courses( name, availableTerms, enrollmentLimit, University_id ) values( "CS 7637 Knowledge-Based Artifical Intelligence", "Fall Spring Summer", 50, 1 );
insert into ARMS_DB.Courses( name, availableTerms, enrollmentLimit, University_id ) values( "CS 4495 Computer Vision", "Spring", 50, 1 );
insert into ARMS_DB.Courses( name, availableTerms, enrollmentLimit, University_id ) values( "CS 6475 Computational Photography", "Fall", 50, 1 );
insert into ARMS_DB.Courses( name, availableTerms, enrollmentLimit, University_id ) values( "CS 8803 Special Topics: Operating Systems", "Fall Spring Summer", 50, 1 );
insert into ARMS_DB.Courses( name, availableTerms, enrollmentLimit, University_id ) values( "CS 8803 Special Topics: AI for Robotics", "Fall Spring Summer", 50, 1 );
insert into ARMS_DB.Courses( name, availableTerms, enrollmentLimit, University_id ) values( "CS 6025 Introduction to Information Security", "Spring", 50, 1 );
insert into ARMS_DB.Courses( name, availableTerms, enrollmentLimit, University_id ) values( "CS 6220 High-Performance Computing", "Fall", 50, 1 );
insert into ARMS_DB.Courses( name, availableTerms, enrollmentLimit, University_id ) values( "CS 7646 Machine Learning for Trading", "Spring", 50, 1 );
insert into ARMS_DB.Courses( name, availableTerms, enrollmentLimit, University_id ) values( "CS 7646 Special Topics: Reinforcement Learning", "Fall", 50, 1 );
insert into ARMS_DB.Courses( name, availableTerms, enrollmentLimit, University_id ) values( "CS 8803 Special Topics: Big Data", "Spring", 50, 1 );
 
-- Prerequisites

insert into ARMS_DB.Prerequisites( MainID, PrerequisiteId ) values( 5, 1 );
insert into ARMS_DB.Prerequisites( MainID, PrerequisiteId ) values( 5, 2 );
insert into ARMS_DB.Prerequisites( MainID, PrerequisiteId ) values( 6, 3 );
insert into ARMS_DB.Prerequisites( MainID, PrerequisiteId ) values( 10, 1 );
insert into ARMS_DB.Prerequisites( MainID, PrerequisiteId ) values( 11, 10 );
insert into ARMS_DB.Prerequisites( MainID, PrerequisiteId ) values( 12, 1 );
insert into ARMS_DB.Prerequisites( MainID, PrerequisiteId ) values( 12, 8 );
insert into ARMS_DB.Prerequisites( MainID, PrerequisiteId ) values( 13, 4 );
insert into ARMS_DB.Prerequisites( MainID, PrerequisiteId ) values( 13, 9 );
insert into ARMS_DB.Prerequisites( MainID, PrerequisiteId ) values( 13, 10 );
insert into ARMS_DB.Prerequisites( MainID, PrerequisiteId ) values( 14, 2 );
insert into ARMS_DB.Prerequisites( MainID, PrerequisiteId ) values( 15, 1 );
insert into ARMS_DB.Prerequisites( MainID, PrerequisiteId ) values( 15, 5 );
insert into ARMS_DB.Prerequisites( MainID, PrerequisiteId ) values( 15, 6 );
insert into ARMS_DB.Prerequisites( MainID, PrerequisiteId ) values( 16, 4 );
insert into ARMS_DB.Prerequisites( MainID, PrerequisiteId ) values( 17, 13 );
insert into ARMS_DB.Prerequisites( MainID, PrerequisiteId ) values( 17, 16 );
insert into ARMS_DB.Prerequisites( MainID, PrerequisiteId ) values( 18, 9 );
