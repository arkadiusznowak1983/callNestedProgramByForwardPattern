PL/SQL Developer Test script 3.0
42
-- Created on 3/16/2019 by arkadiusz.nowak1983@gmail.com
DECLARE 
	-- test package normal code execution
	PROCEDURE test__code_execution IS
	BEGIN
		dbms_output.put_line( 'Test package normal code execution' ); 
		p_ut_packageWithNestedCode.procedure_withNestedCode;
	END test__code_execution;
	
	-- test package Unit Test execution
	PROCEDURE test__ut IS
	BEGIN
		p_ut_packageWithNestedCode.l_utHelperObj.set__callMethodMode(                                                                   /* set execution mode to Unit Test */
		                                    callMethodMode => p_ut_packageWithNestedCode.l_utHelperObj.s_callMethod_unitTest 
																				);
		
		dbms_output.put_line( CHR(10)||'calling procedure procedure_nestedWithoutParams' ); 
		p_ut_packageWithNestedCode.l_utHelperObj.set__subProgramName( subProgramName => 'procedure_nestedWithoutParams' );
		p_ut_packageWithNestedCode.procedure_withNestedCode;                                                                            /* call nested procedure by global procedure and forward pattern */
		
		dbms_output.put_line( CHR(10)||'calling procedure procedure_nestedWithParams' ); 
		p_ut_packageWithNestedCode.l_utHelperObj.set__subProgramName  ( subProgramName    => 'procedure_nestedWithParams' );            /* set nested procedure name to call */
		p_ut_packageWithNestedCode.l_utHelperObj.set__subProgramParams( subProgramParam_1 => ANYDATA.ConvertNumber(444)                 /* assign all required values to params */
		                                                               ,subProgramParam_2 => ANYDATA.ConvertVarchar2('PARAM2 STRING')   
																			                             );
		p_ut_packageWithNestedCode.procedure_withNestedCode;                                                                            /* call nested procedure by global procedure and forward pattern */
		
		p_ut_packageWithNestedCode.l_utHelperObj.set__callMethodMode;                                                                   /* reset execution mode to default */
	END test__ut;
	
/* main */
BEGIN
  dbms_output.put_line( 'Start testing Unit Test Helper for execute nested codes' ); 	

	-- test package normal code execution
	test__code_execution;
	
	-- test package Unit Test execution
	test__ut;
	
	dbms_output.put_line( 'End of testing Unit Test Helper for execute nested codes' ); 
END;
0
0
