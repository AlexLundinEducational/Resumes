;;; ----------------------------------------------------------------------------------------------------------------------------------------------------
;;; <ZZ-example>																	
;;; Write an example call to the Subfunction here													
;;; This will allow other developers to verify how you intend your code to work										
;;; Example function c:ZZ with LMCS-43-GET-LAYOUT-BLOCK-COUNT-FROM-CURRENT-DRAWING Subfunction Call								
(defun c:ZZT ( / APPENDBIT billOfMaterialsFromCurrentDrawing CLOSEDDRAWINGS CSVFILELOCATION CSVHEADERROW CURRENTFOLDER DEFAULTLISPTESTOUTPUTFOLDERASSOCIATION DEFAULTLISPTESTOUTPUTFOLDERDATA DEFAULTLISPTESTOUTPUTFOLDERKEY DEFAULTPALETTESSOURCEDRAWINGSFOLDERASSOCIATION DEFAULTPALETTESSOURCEDRAWINGSFOLDERDATA DEFAULTPALETTESSOURCEDRAWINGSFOLDERKEY DRAWINGEXTRACTIONFOLDER DRAWINGS EXTRACTIONNAME FILENAME FILEPATH LINE1 LINE2 LINE3 OPENDRAWINGS OUTPUTDATA RETURNEDLIST RETURNLIST STRINGFLAG STRINGLOCATIONASSOCATIONLIST TESTOUTPUTFILENAME)																	
 	;;; standard *error* function for Legrand													
 	;;; View the file below for a working example and more in depth notes on how to implement and use it						
 	;;; C:\WS_Blocks\Default\LISP\Lisp Functions\Subfunction Library\DEFAULT-ERROR-HANDLER.LSP							
	(defun *error* ( msg / THECALLINGFUNCTIONSNAME)													
		(setq theCallingFunctionsName "c:ZZ")													
		(DEFAULT-ERROR-HANDLER theCallingFunctionsName msg)											
	)																		
  	;;; c:ZZ function body																
	(setq subFunctionName "LMCS-43-GET-LAYOUT-BLOCK-COUNT-FROM-CURRENT-DRAWING")									
																			
  	;;; get string locations for the support path from the string constant function									
	;;; GET-IMPORTANT-SOURCE-FOLDERS-AND-FILES													
	(setq returnList ( GET-IMPORTANT-SOURCE-FOLDERS-AND-FILES nil))											
  	(setq stringLocationAssocationList returnList)													
																			
 	(setq defaultPalettesSourceDrawingsFolderAssociation (assoc "DEFAULT-TOOL-PALETTES-SOURCE-DRAWINGS" stringLocationAssocationList))		
  	(setq defaultPalettesSourceDrawingsFolderKey (car defaultPalettesSourceDrawingsFolderAssociation))						
  	(setq defaultPalettesSourceDrawingsFolderData (cdr defaultPalettesSourceDrawingsFolderAssociation))						
  																			
  	(setq defaultLISPTestOutputFolderAssociation (assoc "DEFAULT-LISP-TEST-OUTPUT" stringLocationAssocationList))					
  	(setq defaultLISPTestOutputFolderKey (car defaultLISPTestOutputFolderAssociation))								
  	(setq defaultLISPTestOutputFolderData (cdr defaultLISPTestOutputFolderAssociation))								
																			
  	;;; this file name gets updated during the sub-function template save										
	(setq FileName (strcat "TEST-" subFunctionName ".txt"))												
  	;;; this is the full file path of your test output												
  	(setq testOutputFileName (strcat defaultLISPTestOutputFolderData "\\" FileName))								
																			
  	;;; <- here is where you can perform whatever actions are neccessary for your test								
	;;; get current drawing location														
	(setq currentFolder (getvar 'DWGPREFIX))													
																			
  	(setq extractionName subFunctionName)														
																			
	;;; set csv file location															
  	(setq csvFileLocation (strcat defaultLISPTestOutputFolderData "\\" extractionName ".csv"))							
																			
																			
																							
  	;;; create lists to hold header and data for csv columns											
  	(setq csvHeaderRow (list "ROOMID" "Name"))												
  	(setq billOfMaterialsFromCurrentDrawing (cons csvHeaderRow billOfMaterialsFromCurrentDrawing))							
																			
																			
	;;; get list of all drawings in folder that contain WS in the name										
	(setq drawingExtractionFolder defaultPalettesSourceDrawingsFolderData)
  
  	(setq billOfMaterialsFromCurrentDrawing (LMCS-43-GET-LAYOUT-BLOCK-COUNT-FROM-CURRENT-DRAWING billOfMaterialsFromCurrentDrawing))	
  																			
  	(WRITE-TO-CSV csvFileLocation billOfMaterialsFromCurrentDrawing)											
																			
  																			
  	;;; this is the write to text file function call after your tests are complete									
  	;;; make sure to include valid reasons in your output file so the test is useful for regression tests						
	(setq APPENDBIT 0)																
	(setq FILEPATH testOutputFileName)														
	(setq line1 "Tests for \n"subFunctionName"\n")													
  	(setq line2 "\nTest 1 Passed")															
  	(setq line3 "\n\tReason All drawings from current folder extracted from.")									
	(setq OUTPUTDATA (list line1 line2 line3))													
	(WRITE-TO-TEXT-FILE APPENDBIT FILEPATH OUTPUTDATA)												
																			
  																			
	(princ "\nCounts extraction complete.")														
  	(princ)																		
)																			
;;; </ZZ-example>																	
;;;-----------------------------------------------------------------------------------------------------------------------------------------------------
;;; <Subfunction Name> 																	
;;; LMCS-43-GET-LAYOUT-BLOCK-COUNT-FROM-CURRENT-DRAWING 													
;;; </Subfunction Name>																	
;;; <Developer Notes>																	
;;; Alex Lundin																		
;;; 10-08-2018																		
;;; Uncomment the c:ZZ function above for a working example of LMCS-43-GET-LAYOUT-BLOCK-COUNT-FROM-CURRENT-DRAWING						
;;; This function loops through a set of drawings, and loads them into a database interface.								
;;; The loop accesses the blocks in modelspace of the database object and counts the valid layout block names						
;;; </Developer Notes>																	
(defun LMCS-43-GET-LAYOUT-BLOCK-COUNT-FROM-CURRENT-DRAWING
       		(
		;;; <Arguments>	
		billOfMaterialsFromCurrentDrawing ;;; 2D list with the csv header already in the first slot	
		;;; </Arguments>
		/
		;local variables
		*ERROR*
		BLOCKNAME DRAWINGNAME ITEM NEWITEM NEWLIST QUANTITY BLOCKNAME DRAWINGNAME ERRORHEADER ERRORMESSAGE ERRORMESSAGELIST ERRORMESSAGESTRINGLIST ISTHEREANERROR ITEM NEWITEM NEWLIST QUANTITY THECALLINGFUNCTIONSNAME BLOCKQUANTITYLIST DRAWINGNAME NEWITEM NEWLIST X BLOCKQUANTITYLIST DRAWINGNAME NEWITEM NEWLIST X blockList ACADVERSION ASSOCATIONDATA BLOCKQUANTITYLIST MODELSPACEFROMDRAWINGDATABASE OBJECTNAME X ASSOCATIONKEY ASSOCIATIONITEM BLOCKCOUNT BLOCKNAME BLOCKSFROMDRAWINGDATABASE CELLADDRESSRANGE CSVROW DATA_LIST DDBX DEFAULTEXCELFILEFORPRODUCTLAYOUTBLOCKSASSOCIATION DEFAULTEXCELFILEFORPRODUCTLAYOUTBLOCKSDATA DEFAULTEXCELFILEFORPRODUCTLAYOUTBLOCKSKEY DRAWINGEXTRACTIONFOLDER DRAWINGFULLNAME DRAWINGNAME DXF0 ENTDXF ENTITYNAME EXCELFILEPATH EXCELSHEETNUMBER FILEPATH HANDLE ISTHISAVALIDPRODUCTLAYOUTBLOCKNAME isThisADrawingToProcess LAYOUTFLAG QUANTITY RETURNLIST STRINGLOCATIONASSOCATIONLIST VALIDPRODUCTLAYOUTBLOCKNAMESASSOCIATION XREFFLAG YEARVERSIONASINT YEARVERSIONASSTRING
		)




    
;;; Standard *error* function for Legrand														
;;; View the file below for a working example and more in depth notes on how to implement and use it							
;;; C:\WS_Blocks\Default\LISP\Lisp Functions\Subfunction Library\DEFAULT-ERROR-HANDLER.LSP								
	(defun *error* ( msg / THECALLINGFUNCTIONSNAME)

		(setq theCallingFunctionsName "LMCS-43-GET-LAYOUT-BLOCK-COUNT-FROM-CURRENT-DRAWING")
		(DEFAULT-ERROR-HANDLER theCallingFunctionsName msg)
	)

;;; function body																	

  	(setq errorMessageList "")
  
	(setq validProductLayoutBlockNamesAssociation (GET-VALID-PRODUCT-BLOCK-NAME-LIST-FROM-DEFAULT-EXCEL))


	;;; create *files* variable from the preferences of the current instance of AutoCAD
	(setq acadApp (vlax-get-acad-object))
  	(setq drawing (vla-get-activedocument acadApp))
  
  
  	;;; save information about the drawing file name			
   	(setq drawingFullName (vla-get-name drawing))
  	(setq drawingName (vl-filename-base drawingFullName))
  	(setq drawingExtractionFolder (vl-filename-directory drawingFullName))


  

	;;; store blocks from the database					
	(setq modelSpaceFromDrawingDatabase (vla-get-modelspace drawing))

	
	;;; loop through all objects in modelspace				
	(vlax-for obj modelSpaceFromDrawingDatabase
	  
	  	(setq objectName (vla-get-objectname obj))

	  	;;; convert vla-object to entity data				
	  	(setq handle (vla-get-handle obj))
		(setq entityName (vlax-vla-object->ename obj))
	  	(setq EntDxf (entget entityName))
	  	(setq Dxf0 (cdr (assoc 0 EntDxf)))
	  


	  	(if
		  	(AND
			(= Dxf0 "INSERT")
			)
		  	(progn
			(setq blockName (ENTITY-TO-BLOCK-TRUENAME entityName))
		  	;;; check association list from the product layout block excel file
		  	(setq isThisAValidProductLayoutBlockName (assoc blockName validProductLayoutBlockNamesAssociation))
			)
		)
	  
	  	(if
		  	(AND
			(/= isThisAValidProductLayoutBlockName nil)
			)
		  	(progn
			(setq blockList (cons blockName blockList))
			;;; process the block
		  	(setq attributeNamesList (list "ROOMID"))																				
		  	(setq entity entityName)													
			(setq returnList (GET-BLOCK-ATTRIBUTES-FROM-LIST attributeNamesList entity))									
			(setq assocationList returnList)

		  	
			(if
			  	(/= returnLis nil)
			  	(progn
				(setq ROOMID (cdr (assoc "ROOMID" assocationList)))
				)
			  	(progn
				(setq ROOMID "")
				)
			)
			  
			(setq quantity "1")
		  	(setq newItem (list ROOMID blockName))
		  	(setq newList (cons newItem newList))
			
			(setq billOfMaterialsFromCurrentDrawing (append newList billOfMaterialsFromCurrentDrawing))
			(setq blockQuantityList nil)
			(setq blockList nil)
			(setq newList nil)				
			)


		)
	  	
	)
	;;; end block loop							

  
  
	;;; <Return>															
	(setq billOfMaterialsFromCurrentDrawing (reverse billOfMaterialsFromCurrentDrawing));;; 2D list containing the bill of materials
	;;; </Return>															
  		
)


