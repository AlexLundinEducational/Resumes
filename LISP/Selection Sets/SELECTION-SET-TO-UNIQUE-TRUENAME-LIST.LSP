;;; ----------------------------------------------------------------------------------------------------------------------------------------------------
;;;																			
;;; ZZ example																		
;;; Write an example call to the Subfunction here													
;;; This will allow other developers to verify how you intend your code to work										
;;; Example function c:ZZ with SELECTION-SET-TO-UNIQUE-TRUENAME-LIST Subfunction Call									
;;;(defun c:ZZ ( / LAYOUTBLOCKS UNIQUETRUENAMELIST)													
;;; 	;;; standard *error* function for Legrand													
;;; 	;;; View the file below for a working example and more in depth notes on how to implement and use it						
;;; 	;;; C:\WS_Blocks\Default\LISP\Lisp Functions\Subfunction Library\DEFAULT-ERROR-HANDLER.LSP							
;;;	(defun *error* ( msg / THECALLINGFUNCTIONSNAME)													
;;;		(setq theCallingFunctionsName "c:ZZ")													
;;;		(DEFAULT-ERROR-HANDLER theCallingFunctionsName msg)											
;;;	)																		
;;;  	;;; c:ZZ function body																
;;;  	(setq layoutBlocks (ssget "x" '((8 . "WATTSTOPPER")(410 . "Model"))))										
;;;	(setq uniqueTrueNameList (SELECTION-SET-TO-UNIQUE-TRUENAME-LIST layoutBlocks))									
;;;	(princ)																		
;;;)																			
;;;-----------------------------------------------------------------------------------------------------------------------------------------------------
;;; --- SELECTION-SET-TO-UNIQUE-TRUENAME-LIST Sub Function---												
;;; Notes:																		
;;; Uncomment the c:ZZ function above for a working example of SELECTION-SET-TO-UNIQUE-TRUENAME-LIST							
;;; Write a brief summary of the functions intended use here												
;;; Alex Lundin																		
;;; 02-20-2018																		
(defun SELECTION-SET-TO-UNIQUE-TRUENAME-LIST
       		(
		;arguments
		selectionSet
		/
		;local variables
		*ERROR*
		ARGUMENTTYPECHECK BLOCKLIST CMAX CNTR DXF0 ENTDXF ENTITY ILLEGALARGUEMENTFLAG ILLEGALENTITYFLAG LISTTOTALLENGTH MSG NAMELIST OUTLIST RETURNLIST X
		)
;;; Arguments:													
;;;	selectionSet	- selection set of blocks only, function will validate					
;;; Return:													
;;;	returnList	- list of block truenames from selection set without duplicates				
	
;;; Standard *error* function for Legrand														
;;; View the file below for a working example and more in depth notes on how to implement and use it							
;;; C:\WS_Blocks\Default\LISP\Lisp Functions\Subfunction Library\DEFAULT-ERROR-HANDLER.LSP								
	(defun *error* ( msg / THECALLINGFUNCTIONSNAME)
		(setq theCallingFunctionsName "SELECTION-SET-TO-UNIQUE-TRUENAME-LIST")
		(DEFAULT-ERROR-HANDLER theCallingFunctionsName msg)
	)

;;; function body																	


  
	;;; validate argument
	(setq illegalArguementFlag 0)
	(setq argumentTypeCheck (type selectionSet))
  	(if
	  	(/= argumentTypeCheck 'PICKSET)
	  	(progn
		(setq illegalArguementFlag 1)
		(setq msg "Illegal argument, expected selection set")
		(*error* msg)
		)
	)
  
	(setq illegalEntityFlag 0)
	(setq cntr 0)
  	(setq cmax (sslength selectionSet))
  	(while
	  	(< cntr cmax)
		(setq entity (ssname selectionSet cntr))
		(setq entDXF (entget entity))
	  	(setq dxf0 (cdr (assoc 0 entDXF)))
		
	  	(if
		  	(/= dxf0 "INSERT")
		  	(progn
			(setq illegalEntityFlag 1)
			(setq msg "Illegal entity type in selection set, expected inserts only")
			(*error* msg)
			)
		)
	  
		(setq cntr (+ cntr 1))
	)



  	;;; begin function work
  
	(setq blockList   (mapcar 'vlax-ename->vla-object							;use mapcar on each item from the list described below, the mapcar function is using vla-ename to object on each item
			     (vl-remove-if									;remove element if it fails the test condition below
			       'listp										;check if the follwing element is a list with listp
			       (mapcar 'cadr (ssnamex selectionSet))						;use ssnamex to return the entire list of all entity names in blSet, which will be the second item, so cadr is used to retrieve the second item
			     ) ;_ end of vl-remove-if
		     ) ;_ end of mapcar
	    nameList (vl-sort (mapcar '(lambda (X) (vla-get-effectivename x)) blockList) '<)			;blList evaluates first, then create nameList from the truenames of each item in blList, use mapcar to define a in-line function to store each item from blList in x and loop through
	    listTotalLength  (length nameList)									;finally store the total length of nameList in listTotalLength
	) ;_ end of setq
	;End of Residential Symbol Handling

	(while nameList												;while nameList still exists

		(setq outList (cons (car nameList)								;create the outList from the first item of nameList, accumlate each of these values for the entire namelist
				    outList
			      ) ;_ end of cons
		) ;_ end of setq
	  
		(setq nameList
			(vl-remove (car nameList) nameList)							;remove any items that match the first element of nameList, car returns the first element
		)
	  
	  
	) ;_ end of while

	(setq returnList outList)

)


