;;; <Function Name>																	
;;; c:EXTRACTORWSQTCSV																	
;;; </Function Name>																	
;;; <User Notes>																	
;;; Extracts data from floor plan blocks ("Count" "Name" "ROOMID" "Drawing Name") to a csv file with headings to match WS Quote Tool CSV Import 1.0.31	
;;; </User Notes>																	
;;; <Developer Notes>																	
;;; Alex Lundin																		
;;; 12-07-2018																		
;;; Write a brief summary of this functions design for future developers										
;;; Example call																	
;;; (c:EXTRACTORWSQTCSV)																
;;; </Developer Notes>																	
(defun c:EXTRACTORWSQTCSV
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
		(setq theCallingFunctionsName "c:EXTRACTORWSQTCSV")
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
																			
  	(setq extractionName (strcat drawingName "-WS-QUOTE-TOOL"))														
																			
	;;; set csv file location															
  	(setq csvFileLocation (strcat currentFolder "\\" extractionName ".csv"))							
																																					
																																													
  	;;; create lists to hold header and data for csv columns											
  	(setq csvHeaderRow (list "Count" "Name" "ROOMID" "Drawing Name"))												
  	(setq billOfMaterialsFromCurrentDrawing (cons csvHeaderRow billOfMaterialsFromCurrentDrawing))							
																			
																			

  	(setq billOfMaterialsFromCurrentDrawing (WS-QUOTE-TOOL-CSV-1-0-31-GET-LAYOUT-BLOCK-COUNT-FROM-CURRENT-DRAWING billOfMaterialsFromCurrentDrawing))
  
																																							
  	(WRITE-TO-CSV csvFileLocation billOfMaterialsFromCurrentDrawing)											
																			
  																																											
	(princ "\nWS Quote Tool CSV extraction complete.")														
  	(princ)																		

)