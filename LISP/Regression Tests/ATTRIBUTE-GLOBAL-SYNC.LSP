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
		LINE1 LINE2 LINE3 LINE4 LINE5 OUTPUTDATA RETURNLIST SUBFUNCTIONNAME FAILFLAG PASSFLAG TEST1OUTPUTDATA
		)       																
 	;;; standard *error* function for Legrand													
 	;;; View the file below for a working example and more in depth notes on how to implement and use it						
 	;;; C:\WS_Blocks\Default\LISP\Lisp Functions\Subfunction Library\DEFAULT-ERROR-HANDLER.LSP							
	(defun *error* ( msg / THECALLINGFUNCTIONSNAME)													
		(setq theCallingFunctionsName "c:ZZ")													
		(DEFAULT-ERROR-HANDLER theCallingFunctionsName msg)											
	)																		
  	;;; c:ZZ function body																
																			
	(setq subFunctionName "ATTRIBUTE-GLOBAL-SYNC")														
																			
	;;; <- here is where you can perform whatever actions are neccessary for your test								
	(ATTRIBUTE-GLOBAL-SYNC)
  
  	;;; each test output data list must start with either a pass or fail flag									
	(setq passFlag "T")
	(setq failFlag "F")
	
	;;; test 1																	
  	;;; document why this test exists														
	;;; include valid reasons in your output data so the test is useful for regression tests							
  	(setq line1 "\nTest 1 Passed")															
  	(setq line2 "\n\tReason is attributes synced")
  	(setq dataLines (list line1 line2))
  	(setq test1OutputData (list passFlag dataLines))																					
	
   	;;; store as many lines to outputdata as you need to make it clear what your tests did								
	(setq OUTPUTDATA (list test1OutputData)) 											
																	
	;;; Return																	
	(setq returnList OUTPUTDATA)	;;; list of data containing test output information, ready for writing to log file				
																			
)																			
;;; </ZZ-example>																	
;;;-----------------------------------------------------------------------------------------------------------------------------------------------------
;;; <Subfunction Name> 																	
;;; ATTRIBUTE-GLOBAL-SYNC 																
;;; </Subfunction Name>																	
;;; <Developer Notes>																	
;;;; Uses block table in current drawing to update all inserted blocks in current drawing								
;;; Alex Lundin																		
;;; 01-29-2018																		
;;; </Developer Notes>																	
(defun ATTRIBUTE-GLOBAL-SYNC
       		(
		;;; <Arguments>		
		;;; none		
		;;; </Arguments>	
		/
		;;; local variables	
		*ERROR*
		BLOCK CMAX CNTR EN ENTDXF OLDECHO OLDOSM SS TRUENAME TRUENAMELIST UNIQUETRUENAMELIST VLAOBJECT X	
		)


;;; Standard *error* function for Legrand														
;;; View the file below for a working example and more in depth notes on how to implement and use it							
;;; C:\WS_Blocks\Default\LISP\Lisp Functions\Subfunction Library\DEFAULT-ERROR-HANDLER.LSP								
	(defun *error* ( msg / THECALLINGFUNCTIONSNAME)

		(setq theCallingFunctionsName "ATTRIBUTE-GLOBAL-SYNC")
		(DEFAULT-ERROR-HANDLER theCallingFunctionsName msg)
	)

;;; function body																	

  	;;; save and toggle system variables
	(setq oldecho (getvar "CMDECHO"))
	(setq oldosm (getvar "OSMODE"))
	(setvar "CMDECHO" 0)
	(setvar "OSMODE" 0)
  
  	(vl-load-com)
	(setq ss(ssget "x" '((0 . "INSERT"))))										;create selection set from all objects that are inserted blocks
  	(setq cntr 0)

	(if
	  	(/= ss nil)
	  	(progn
  		(setq cmax (sslength ss))										;set cmax to length of blocks selection set
		)
	)
  
	(while 	(< cntr cmax)												;set loop to continue while the counter varaible cntr is less that the number of objects in the selection set blocks
		(setq en(ssname ss cntr))										;set variable en to the name of the block that matches the current counter value
		  	(setq vlaobject (vlax-ename->vla-object en))							;helper function to handle Anonymous names -- set vlaobject to the converted vla name from the entity name of block
		    	(setq truename(vlax-get-property vlaobject							;set the truename variable  name of block
		        	(if (vlax-property-available-p vlaobject 'effectivename)				;only if the property called effective name exisits inside block (this entire block fails when if statement is false)
		            	'effectivename										;to the effective name property
		            	'name
		        	)
		    	)
			)
	 
	(setq EntDxf (entget en))

	(setq truenamelist (cons truename truenamelist))
	(setq cntr(+ cntr 1))												;once while loop reaches this point, increment counter varaible by one			
	)														;end while loop

  
	(setq truenamelist (reverse truenamelist))
      	(while  truenamelist												;create a list of unique truenames
        	(setq x (car  truenamelist)										;set x to first item from all the truenames
              		 truenamelist (vl-remove x (cdr  truenamelist))							;remove any other instances of x from the entire list truenames
              		uniquetruenamelist (cons x uniquetruenamelist)							;add x to the new list
        		)
    		)													;end while
	(setq uniquetruenamelist (reverse uniquetruenamelist))								;reverse the unique list to account for cons property
	(setq truenamelist uniquetruenamelist)
	
	
  	(setq cntr 0)
	(if
	  	(/= truenamelist nil)
	  	(progn
  		(setq cmax (length truenamelist))									;set cmax to length of truenames
		)
	)
  		
	(while 	(< cntr cmax)												;set loop to continue while the counter varaible cntr is less that the number of truenames in list
		(setq block(nth cntr truenamelist))									;set variable en to the name of the block that matches the current counter value
		(vl-cmdf "_.attsync" "_N" block)
	(setq cntr(+ cntr 1))												;once while loop reaches this point, increment counter varaible by one
	)


	(setvar "CMDECHO" oldecho)
	(setvar "OSMODE" oldosm)
  
	(princ)	
	
	;;; <Return>	
	;;; none 	
	;;; </Return>	
	

)

