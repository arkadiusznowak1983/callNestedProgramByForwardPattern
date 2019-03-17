CREATE OR REPLACE PACKAGE p_ut_packageWithNestedCode IS

  -- Author  : arkadiusz.nowak1983@gmail.com
  -- Created : 3/16/2019 6:48:09 PM
  -- Purpose : Package with procedures and functions that contains nested code to test
  
  -- Public type declarations
  --
  
  -- Public constant declarations
  s_objectName CONSTANT VARCHAR2(200) := 'p_ut_packageWithNestedCode';

  -- Public variable declarations
  l_utHelperObj  t_utHelperCallNestedCode;

  -- Public function and procedure declarations
  PROCEDURE procedure_withNestedCode; 

END p_ut_packageWithNestedCode;
/
CREATE OR REPLACE PACKAGE BODY p_ut_packageWithNestedCode IS

  -- Private type declarations
  --
  
  -- Private constant declarations
  --

  -- Private variable declarations
  -- 

  -- Function and procedure implementations
  PROCEDURE procedure_withNestedCode IS
		PROCEDURE procedure_nestedWithoutParams IS
		BEGIN
			dbms_output.put_line( 'procedure_withNestedCode - procedure_nestedWithoutParams' ); 
		END procedure_nestedWithoutParams;
		
		PROCEDURE procedure_nestedWithParams( p_param_number NUMBER
			                                   ,p_param_string VARCHAR2
																				 ) 
		IS
		BEGIN
			dbms_output.put_line( 'procedure_withNestedCode - procedure_nestedWithParams - p_param_number :' || p_param_number ); 
      dbms_output.put_line( 'procedure_withNestedCode - procedure_nestedWithParams - p_param_string :' || p_param_string ); 
		END procedure_nestedWithParams;
	
	  PROCEDURE ut_forward_call IS
    BEGIN
			-- compare helper attribute 'subProgramName' with local procedures names and run it with required parameters
      CASE l_utHelperObj.subProgramName
        WHEN 'procedure_nestedWithoutParams' 
					THEN procedure_nestedWithoutParams;
        WHEN 'procedure_nestedWithParams'
					THEN procedure_nestedWithParams( p_param_number => l_utHelperObj.subProgramParam_1.AccessNumber
					                                ,p_param_string => l_utHelperObj.subProgramParam_2.AccessVarchar2
																			    );
      END CASE;
			
			-- EXCEPTION WHEN OTHERS THEN NULL;
    end ut_forward_call;
	BEGIN
		IF l_utHelperObj.check__utMode THEN
			ut_forward_call;
			RETURN;
		END IF;
		 
	  procedure_nestedWithoutParams;
		procedure_nestedWithParams( p_param_number => 123
		                           ,p_param_string => 'string when normal mode' );
	END procedure_withNestedCode;

BEGIN
  -- Initialization
  l_utHelperObj  := NEW t_utHelperCallNestedCode( s_objectName );
END p_ut_packageWithNestedCode;
/
