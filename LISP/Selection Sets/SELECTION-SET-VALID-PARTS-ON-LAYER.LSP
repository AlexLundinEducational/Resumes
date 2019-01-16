;;; ----------------------------------------------------------------------------------------------------------------------------------------------------
;;; The bracketed notation is configured so VLEX can read the file, don't add any more angle brackets in the file, other than what already exists.	
;;; Write an example call to the Subfunction here.													
;;; This will allow other developers to verify how you intend your code to work.									
;;; Make sure to return a list of string data, containing information of test results for writing to log file.						
;;; <ZZ-example>																	
(defun c:ZZ																		
		(																	
		;;; Arguments																
		;;; none																
		/																	
		;;; local variables															
		*ERROR*																	
		LINE1 LINE2 LINE3 LINE4 LINE5 OUTPUTDATA RETURNLIST SUBFUNCTIONNAME
		)       																
 	;;; standard *error* function for Legrand													
 	;;; View the file below for a working example and more in depth notes on how to implement and use it						
 	;;; C:\WS_Blocks\Default\LISP\Lisp Functions\Subfunction Library\DEFAULT-ERROR-HANDLER.LSP							
	(defun *error* ( msg / THECALLINGFUNCTIONSNAME)													
		(setq theCallingFunctionsName "c:ZZ")													
		(DEFAULT-ERROR-HANDLER theCallingFunctionsName msg)											
	)																		
  	;;; c:ZZ function body																
																			
	(setq subFunctionName "SELECTION-SET-VALID-PARTS-ON-LAYER")														
																			
	;;; <- here is where you can perform whatever actions are neccessary for your test								
  	(setq listBit 0)
  	(setq layer "WATTSTOPPER")
	(setq filteredSelection (SELECTION-SET-VALID-PARTS-ON-LAYER listBit layer))																
  																			
  	;;; make sure to include valid reasons in your output data so the test is useful for regression tests						
	(setq line1 (strcat "Tests for \n"subFunctionName"\n"))												
  	(setq line2 "\nTest 1 Passed")															
  	(setq line3 "\n\tReason 1 is...")
  											
  	(setq line4 "\nTest 2 Passed")															
  	(setq line5 "\n\tReason 1 is ...")
  
  	;;; store as many lines to outputdata as you need to make it clear what your tests did								
	(setq OUTPUTDATA (list line1 line2 line3 line4 line5))											
																	
	;;; Return																	
	(setq returnList OUTPUTDATA)	;;; list of data containing test output information, ready for writing to log file				
																			
)																			
;;; </ZZ-example>																	
;;;-----------------------------------------------------------------------------------------------------------------------------------------------------
;;; <Subfunction Name> 																	
;;; SELECTION-SET-VALID-PARTS-ON-LAYER 															
;;; </Subfunction Name>																	
;;; <Developer Notes>																	
;;; Alex Lundin																		
;;; 01-04-2018																		
;;; Creates selection of only valid part names on a particular layer											
(defun SELECTION-SET-VALID-PARTS-ON-LAYER
       		(
		;;; <Arguments>							
		listBit	;;; 0 returns string list, 1 returns assocation list	
		layer	;;; layer to select blocks from				
		;;; </Arguments>						
		 
		/
		;local variables
		*ERROR*
		
		)


;;; Standard *error* function for Legrand														
;;; View the file below for a working example and more in depth notes on how to implement and use it							
;;; C:\WS_Blocks\Default\LISP\Lisp Functions\Subfunction Library\DEFAULT-ERROR-HANDLER.LSP								
	(defun *error* ( msg / THECALLINGFUNCTIONSNAME)

		(setq theCallingFunctionsName "SELECTION-SET-VALID-PARTS-ON-LAYER")
		(DEFAULT-ERROR-HANDLER theCallingFunctionsName msg)
	)

;;; function body																	


  	(setq listBit 0)
	(setq validProductLayoutBlockNamesList (GET-VALID-PRODUCT-BLOCK-NAME-LIST-FROM-DEFAULT-EXCEL listBit))
  
  
  	(setq ss (ssget "x" (list (cons 0 "INSERT")(cons 8 layer))))

  	(setq trueNameList validProductLayoutBlockNamesList)
  	(setq selectionSet ss)
  	(setq filteredSelectionSet (SELECTION-WITH-TRUENAME-FILTER selectionSet trueNameList))
  
  
	;;; <Return>																	
	(setq returnList filteredSelectionSet)	;;; list containing 3 strings										
	;;; </Return>																	
	
)