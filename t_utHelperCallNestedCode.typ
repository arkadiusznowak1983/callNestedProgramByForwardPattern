CREATE OR REPLACE TYPE t_utHelperCallNestedCode AS OBJECT
(
  -- Author  : arkadiusz.nowak1983@gmail.com
  -- Created : 3/16/2019 5:31:45 PM
  -- Purpose : It gives ability to call nested code (nested functions and procedures). Especialy needed for Unit Tests
  
  -- Constants setted by constructors
  s_callMethod_codeExecution  VARCHAR2(200)
 ,s_callMethod_unitTest       VARCHAR2(200)
 ,s_callMethod_default        VARCHAR2(200)  /* default execute mode CodeExecution or UnitTestExecution */
 
  -- Attributes
 ,s_callMethodMode            VARCHAR2(200)  /* assigned sql schema object program name */
 ,assignedObjectName          VARCHAR2(200)  /* assigned sql schema object name  */
 ,assignedObjectProgram       VARCHAR2(200)  /* assigned sql schema object program name */
 
  -- Attributes using after constructor, so constructor CAN'T set this attributes
 ,subProgramName              VARCHAR2(200)  /* nested local program name */
 ,subProgramParam_1           ANYDATA        /* nested local program parameters 1..9 */
 ,subProgramParam_2           ANYDATA
 ,subProgramParam_3           ANYDATA
 ,subProgramParam_4           ANYDATA
 ,subProgramParam_5           ANYDATA
 ,subProgramParam_6           ANYDATA
 ,subProgramParam_7           ANYDATA
 ,subProgramParam_8           ANYDATA
 ,subProgramParam_9           ANYDATA
  
	-- Constructors
	/* User constructor for attribute 'assignedObjectName' 
	   required when assigning helper to sql schema object like package, procedure, function, type */
 ,CONSTRUCTOR FUNCTION t_utHelperCallNestedCode( SELF IN OUT NOCOPY t_utHelperCallNestedCode
                                                ,assignedObjectName VARCHAR2 
																								)RETURN SELF AS RESULT
  
  -- Member functions and procedures
	/* Assign constants values to attributes where its required */
 ,MEMBER PROCEDURE init               ( SELF IN OUT NOCOPY t_utHelperCallNestedCode )
 
 -- Setters for self attributes 
 ,MEMBER PROCEDURE set__callMethodMode( SELF IN OUT NOCOPY t_utHelperCallNestedCode
                                       ,callMethodMode     VARCHAR2   DEFAULT NULL
                                       )
																			 
 ,MEMBER PROCEDURE set__subProgramName( SELF IN OUT NOCOPY t_utHelperCallNestedCode
                                       ,subProgramName     VARCHAR2   DEFAULT NULL
                                       )
																			 
 ,MEMBER PROCEDURE set__subProgramParams( SELF IN OUT NOCOPY t_utHelperCallNestedCode
                                         ,subProgramParam_1  ANYDATA  DEFAULT NULL
                                         ,subProgramParam_2  ANYDATA  DEFAULT NULL
                                         ,subProgramParam_3  ANYDATA  DEFAULT NULL
                                         ,subProgramParam_4  ANYDATA  DEFAULT NULL
                                         ,subProgramParam_5  ANYDATA  DEFAULT NULL
                                         ,subProgramParam_6  ANYDATA  DEFAULT NULL
                                         ,subProgramParam_7  ANYDATA  DEFAULT NULL
                                         ,subProgramParam_8  ANYDATA  DEFAULT NULL
                                         ,subProgramParam_9  ANYDATA  DEFAULT NULL
                                         )   
																				 
 ,MEMBER FUNCTION check__utMode	RETURN BOOLEAN																	                                     
);
/
CREATE OR REPLACE TYPE BODY t_utHelperCallNestedCode IS
  
  -- Constructors
	/* User constructor for attribute 'assignedObjectName' 
	   required when assigning helper to sql schema object like package, procedure, function, type */
  CONSTRUCTOR FUNCTION t_utHelperCallNestedCode( SELF IN OUT NOCOPY t_utHelperCallNestedCode
                                                ,assignedObjectName VARCHAR2 
																								)RETURN SELF AS RESULT AS
  BEGIN
    SELF.assignedObjectName := assignedObjectName;
    SELF.init;
    RETURN;
  END t_utHelperCallNestedCode;
  
  -- Member functions and procedures
	/* Assign constants and self variables values where it's required */
  MEMBER PROCEDURE init( SELF IN OUT NOCOPY t_utHelperCallNestedCode ) IS
  BEGIN
		-- constants
    SELF.s_callMethod_codeExecution  := 'CodeExecution';
    SELF.s_callMethod_unitTest       := 'UnitTestExecution';
    SELF.s_callMethod_default        := SELF.s_callMethod_codeExecution;
		
		-- variables
		SELF.set__callMethodMode;
  END init;
  
	-- Setters for self attributes 
	MEMBER PROCEDURE set__callMethodMode( SELF IN OUT NOCOPY t_utHelperCallNestedCode
                                       ,callMethodMode     VARCHAR2   DEFAULT NULL
                                       )IS
  BEGIN
		-- if null or not in CodeExecution, UnitTestExecution then set default
		IF   callMethodMode IS NULL 
			OR callMethodMode NOT IN ( SELF.s_callMethod_codeExecution, SELF.s_callMethod_unitTest ) 
		  THEN SELF.s_callMethodMode := SELF.s_callMethod_default;
		  ELSE SELF.s_callMethodMode := callMethodMode;
		END IF;
	END set__callMethodMode;
																			 
  MEMBER PROCEDURE set__subProgramName( SELF IN OUT NOCOPY t_utHelperCallNestedCode
                                       ,subProgramName     VARCHAR2 DEFAULT NULL
                                       )IS
  BEGIN
    SELF.subProgramName := subProgramName;
		SELF.set__subProgramParams;
  END set__subProgramName;
	
	MEMBER PROCEDURE set__subProgramParams( SELF IN OUT NOCOPY t_utHelperCallNestedCode
                                         ,subProgramParam_1  ANYDATA DEFAULT NULL
                                         ,subProgramParam_2  ANYDATA DEFAULT NULL
                                         ,subProgramParam_3  ANYDATA DEFAULT NULL
                                         ,subProgramParam_4  ANYDATA DEFAULT NULL
                                         ,subProgramParam_5  ANYDATA DEFAULT NULL
                                         ,subProgramParam_6  ANYDATA DEFAULT NULL
                                         ,subProgramParam_7  ANYDATA DEFAULT NULL
                                         ,subProgramParam_8  ANYDATA DEFAULT NULL
                                         ,subProgramParam_9  ANYDATA DEFAULT NULL
                                         )IS
	BEGIN
		SELF.subProgramParam_1  := subProgramParam_1;
	  SELF.subProgramParam_2  := subProgramParam_2;
	  SELF.subProgramParam_3  := subProgramParam_3;
	  SELF.subProgramParam_4  := subProgramParam_4;
	  SELF.subProgramParam_5  := subProgramParam_5;
	  SELF.subProgramParam_6  := subProgramParam_6;
	  SELF.subProgramParam_7  := subProgramParam_7;
	  SELF.subProgramParam_8  := subProgramParam_8;
	  SELF.subProgramParam_9  := subProgramParam_9;
	END set__subProgramParams;	
	
	/* returns true when object in Unit Test Execution mode */
	MEMBER FUNCTION check__utMode	RETURN BOOLEAN IS
	BEGIN 
		IF SELF.s_callMethodMode = SELF.s_callMethod_unitTest THEN 
			RETURN TRUE;  
		END IF;
		RETURN FALSE;
	END check__utMode;															 
  
END;
/
