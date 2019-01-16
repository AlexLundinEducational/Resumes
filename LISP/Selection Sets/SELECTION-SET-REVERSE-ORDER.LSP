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
		CLOSEDOROPENBIT ENTITY FIRSTITEMBEFORE LASTITEMAFTER LAYER LINETYPE POINTLIST SS SS2 WIDTH
		ENTDXF FIRSTITEMBEFOREREVERSE HANDLE HANDLE2 LASTITEMAFTERREVERSE
		)       																
 	;;; standard *error* function for Legrand													
 	;;; View the file below for a working example and more in depth notes on how to implement and use it						
 	;;; C:\WS_Blocks\Default\LISP\Lisp Functions\Subfunction Library\DEFAULT-ERROR-HANDLER.LSP							
	(defun *error* ( msg / THECALLINGFUNCTIONSNAME)													
		(setq theCallingFunctionsName "c:ZZ")													
		(DEFAULT-ERROR-HANDLER theCallingFunctionsName msg)											
	)																		
  	;;; c:ZZ function body																
																			
	(setq subFunctionName "SELECTION-SET-REVERSE-ORDER")														
																			
	;;; <- here is where you can perform whatever actions are neccessary for your test								
	
	;;; draw entities																
	(setq ss (ssadd))

  	(setq closedOrOpenBit 0)															
  	(setq layer "0")																
  	(setq linetype "bylayer")															
  	(setq pointList (list (list 0 0) (list -200 0) (list 0 -200) (list -200 -200)))									
  	(setq width 5)																	
	(setq entity (ENTMAKEX-POLYLINE layer linetype pointList width))
  	(setq ss (ssadd entity ss))
  															
  	(setq pointList (list (list 1000 1000) (list -200 0) (list 0 -200) (list -200 -200)))									
  	(setq width 10)																	
	(setq entity (ENTMAKEX-POLYLINE layer linetype pointList width))
  	(setq ss (ssadd entity ss))
  
    	(setq pointList (list (list -1000 -1000) (list -200 0) (list 0 -200) (list -200 -200)))									
  	(setq width 20)																	
	(setq entity (ENTMAKEX-POLYLINE layer linetype pointList width))
  	(setq ss (ssadd entity ss))

  
  	;;; save first item before reverse														
	(setq firstItemBeforeReverse (ssname ss 0))
  	(setq entDXF (entget firstItemBeforeReverse))
	(setq handle (cdr (assoc 5 entDXF)))
  
  	;;; reverse																	
  	(setq ss2 (SELECTION-SET-REVERSE-ORDER ss))																	

	;;; save last item after reverse														
  	(setq lastItemAfterReverse (ssname ss2 (- (sslength ss2) 1 )))
	(setq entDXF (entget lastItemAfterReverse))
  	(setq handle2 (cdr (assoc 5 entDXF)))
  
  	;;; check first item equal to last														
	(if
	  	(= handle handle2)
	  	(progn
	  	;;; make sure to include valid reasons in your output data so the test is useful for regression tests					
		(setq line1 (strcat "Tests for \n"subFunctionName"\n"))												
	  	(setq line2 "\nTest 1 Passed")															
	  	(setq line3 "\n\tReason 1 is first item before reverse matched last item after reverse.")
		)
	  	(progn
		(setq line1 (strcat "Tests for \n"subFunctionName"\n"))												
	  	(setq line2 "\nTest 1 Failed")															
	  	(setq line3 "\n\tReason 1 is first item before reverse DID NOT MATCH last item after reverse.")
		)
	)

  	;;; delete polylines after test															
	(command "erase" ss2 "")
  
  	;;; store as many lines to outputdata as you need to make it clear what your tests did								
	(setq OUTPUTDATA (list line1 line2 line3))											
																	
	;;; Return																	
	(setq returnList OUTPUTDATA)	;;; list of data containing test output information, ready for writing to log file				
																			
)																			
;;; </ZZ-example>																	
;;;-----------------------------------------------------------------------------------------------------------------------------------------------------
;;; <Subfunction Name> 																	
;;; SELECTION-SET-REVERSE-ORDER 															
;;; </Subfunction Name>																	
;;; <Developer Notes>																	
;;; Loops over an input selection set and reverses the order, by adding 1 entity at a time, to a new selection set.					
;;; Alex Lundin																		
;;; 01-07-2019																		
;;; </Developer Notes>																	
(defun SELECTION-SET-REVERSE-ORDER
       		(
		;;; <Arguments>						
		inputSelectionSet ;;; valid selection set to reverse	
		;;; </Arguments>					
		/
		;;; local variables	
		*ERROR*
		I RETURNLIST RETURNSELECTIONSET
		)


;;; Standard *error* function for Legrand														
;;; View the file below for a working example and more in depth notes on how to implement and use it							
;;; C:\WS_Blocks\Default\LISP\Lisp Functions\Subfunction Library\DEFAULT-ERROR-HANDLER.LSP								
	(defun *error* ( msg / THECALLINGFUNCTIONSNAME)

		(setq theCallingFunctionsName "SELECTION-SET-REVERSE-ORDER")
		(DEFAULT-ERROR-HANDLER theCallingFunctionsName msg)
	)

;;; function body																	

	;;; if inputSelectionSet is not nil														
  	(if
	  	(/= inputSelectionSet nil)
	  	(progn
	  	(setq i (1- (sslength inputSelectionSet)))
		(setq returnSelectionSet (ssadd))    
		)
	)

	;;; loop backwards over the inputSelectionSet													
	;;; store each item into the returnSelectionSet													
	(while
	  	(>= i 0)
		(setq returnSelectionSet (ssadd (ssname inputSelectionSet i) returnSelectionSet))
		(setq i (1- i))
	)
	
	
	;;; <Return>																	
	(setq returnList returnSelectionSet)	;;; list containing 3 strings										
	;;; </Return>																	
																
	
)