;;; --- WRAPPER-SET-ENTITY-DXF-CODE-VALUE Sub Function---												
;;; Notes:																
;;;																	
;;; Alex Lundin																
;;; 09-01-2017																
;;; Example call															
;;;(setq allBlocks (ssget "X" '((0 . "INSERT")(8 . "WATTSTOPPER" ) (66 . 1 ))))								
;;;(setq trueNameList (list "GENERIC-SQUARE" "GENERIC-CIRCLE" "GENERIC-SUN" "GENERIC-X" "GENERIC-SWITCH"))				
;;;(setq finalSet allBlocks)														
;;;(setq returnedList (SELECTION-WITH-TRUENAME-FILTER finalSet trueNameList))								
;;;(setq selectionSet returnedList)													
;;;																	
;;; Wrapper																
;;; move blocks that are not part of the DLM Riser from the WATTSTOPPER layer to the 0 layer						
;;;(setq associationListNumber 8)													
;;;(setq associationListValue "0")													
;;;(SELECTION-SET-SET-ENTITY-DXF-CODE-VALUE dxfNumber dxfValue selectionSet)							

(defun SELECTION-SET-SET-ENTITY-DXF-CODE-VALUE
       	(
	dxfNumber dxfValue selectionSet
	/
	*error* RETURNEDSET THECALLINGFUNCTIONSNAME
	)
;;; Arguments:																
;;;	associationListNumber 	- dxf code number to modify										
;;;	associationListValue	- value to put into dxf association list								
;;;	selectionSet 		- any valid selectionSet										
;;; Return:																
;;;	None																

  
	;;; Wrapper for DEFAULT-ERROR-HANDLER											
	(defun *error* ( msg )
		(setq theCallingFunctionsName "WRAPPER-SET-ENTITY-DXF-CODE-VALUE")
		(DEFAULT-ERROR-HANDLER theCallingFunctionsName msg)
	)
  													
	(WRAPPER-SET-ENTITY-DXF-CODE-VALUE dxfNumber dxfValue selectionSet)

)


