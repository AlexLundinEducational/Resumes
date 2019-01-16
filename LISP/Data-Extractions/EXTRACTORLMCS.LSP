;;; <Function Name>																	
;;; c:EXTRACTORLMCS																	
;;; </Function Name>																	
;;; <User Notes>																	
;;; Extracts data from floor plan blocks (Block Name and ROOMID) to a csv file with headings to match LMCS 4.3						
;;; </User Notes>																	
;;; <Developer Notes>																	
;;; Alex Lundin																		
;;; 12-07-2018																		
;;; Write a brief summary of this functions design for future developers										
;;; Example call																	
;;; (c:EXTRACTORLMCS)																	
;;; </Developer Notes>																	
(defun c:EXTRACTORLMCS
       		(
		;arguments
		/
		;local variables
		*ERROR*
		ACADAPP BILLOFMATERIALSFROMCURRENTDRAWING CSVFILELOCATION CSVHEADERROW CURRENTFOLDER DEFAULTPALETTESSOURCEDRAWINGSFOLDERDATA DRAWING DRAWINGEXTRACTIONFOLDER DRAWINGFULLNAME DRAWINGNAME EXTRACTIONNAME
		)

;;; <Arguments and Return>			
;;; Arguments:					
;;;	None					
;;; Return:					
;;;	None					
;;; </Arguments and Return>			

;;; Standard *error* function for Legrand														
;;; View the file below for a working example and more in depth notes on how to implement and use it							
;;; C:\WS_Blocks\Default\LISP\Lisp Functions\Subfunction Library\DEFAULT-ERROR-HANDLER.LSP								
	(defun *error* ( msg / THECALLINGFUNCTIONSNAME)
		(setq theCallingFunctionsName "c:EXTRACTORLMCS")
		(DEFAULT-ERROR-HANDLER theCallingFunctionsName msg)
	)

;;; function body																	


	;;; create *files* variable from the preferences of the current instance of AutoCAD
	(setq acadApp (vlax-get-acad-object))
  	(setq drawing (vla-get-activedocument acadApp))
  
  
  	;;; save information about the drawing file name			
   	(setq drawingFullName (vla-get-name drawing))
  	(setq drawingName (vl-filename-base drawingFullName))
  	(setq drawingExtractionFolder (vl-filename-directory drawingFullName))
  
	(setq currentFolder (getvar 'DWGPREFIX))													
																			
  	(setq extractionName (strcat drawingName "-LMCS"))														
																			
	;;; set csv file location															
  	(setq csvFileLocation (strcat currentFolder "\\" extractionName ".csv"))							
																			
																			
																							
  	;;; create lists to hold header and data for csv columns											
  	(setq csvHeaderRow (list "ROOMID" "Name"))												
  	(setq billOfMaterialsFromCurrentDrawing (cons csvHeaderRow billOfMaterialsFromCurrentDrawing))							
																			
																			
	;;; get list of all drawings in folder that contain WS in the name										
	(setq drawingExtractionFolder defaultPalettesSourceDrawingsFolderData)
  
  	(setq billOfMaterialsFromCurrentDrawing (LMCS-4-3-GET-LAYOUT-BLOCK-COUNT-FROM-CURRENT-DRAWING billOfMaterialsFromCurrentDrawing))	
  																			
  	(WRITE-TO-CSV csvFileLocation billOfMaterialsFromCurrentDrawing)											
																			
  																																											
	(princ "\nLMCS extraction complete.")														
  	(princ)																		

)