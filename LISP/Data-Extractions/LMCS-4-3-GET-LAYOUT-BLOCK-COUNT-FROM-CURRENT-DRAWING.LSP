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

  	;;; <- here is where you can perform whatever actions are neccessary for your test								
																			
  	;;; create lists to hold header and data for csv columns											
  	(setq csvHeaderRow (list "ROOMID" "Name"))													
  	(setq billOfMaterialsFromCurrentDrawing (cons csvHeaderRow billOfMaterialsFromCurrentDrawing))							
																			
																												
  																			
  	(setq billOfMaterialsFromCurrentDrawing (LMCS-4-3-GET-LAYOUT-BLOCK-COUNT-FROM-CURRENT-DRAWING billOfMaterialsFromCurrentDrawing))		
  																			
  	;;; make sure to include valid reasons in your output data so the test is useful for regression tests						
	(setq line1 "Tests for \n"subFunctionName"\n")													
  	(setq line2 "\nTest 1 Passed")															
  	(setq line3 "\n\tReason 1 All drawings from current folder extracted from.")									
  											
  
  	;;; store as many lines to outputdata as you need to make it clear what your tests did								
	(setq OUTPUTDATA (list line1 line2 line3))											
																	
	;;; Return																	
	(setq returnList OUTPUTDATA)	;;; list of data containing test output information, ready for writing to log file				
																			
)
;;; </ZZ-example>																	
;;;-----------------------------------------------------------------------------------------------------------------------------------------------------
;;; <Subfunction Name> 																	
;;; LMCS-4-3-GET-LAYOUT-BLOCK-COUNT-FROM-CURRENT-DRAWING 												
;;; </Subfunction Name>																	
;;; <Developer Notes>																	
;;; Alex Lundin																		
;;; 10-08-2018																		
;;; This function loops through all blocks in modelspace and stores relevant data into a list								
;;; </Developer Notes>																	
(defun LMCS-4-3-GET-LAYOUT-BLOCK-COUNT-FROM-CURRENT-DRAWING
       		(
		;;; <Arguments>	
		billOfMaterialsFromCurrentDrawing ;;; 2D list with the csv header already in the first slot	
		;;; </Arguments>
		/
		;local variables
		*ERROR*
		ACADAPP ASSOCATIONLIST ATTRIBUTENAMESLIST DRAWING ENTITY ROOMID BLOCKNAME DRAWINGNAME ITEM LISTBIT NEWITEM NEWLIST QUANTITY BLOCKNAME DRAWINGNAME ERRORHEADER ERRORMESSAGE ERRORMESSAGELIST ERRORMESSAGESTRINGLIST ISTHEREANERROR ITEM NEWITEM NEWLIST QUANTITY THECALLINGFUNCTIONSNAME BLOCKQUANTITYLIST DRAWINGNAME NEWITEM NEWLIST X BLOCKQUANTITYLIST DRAWINGNAME NEWITEM NEWLIST X blockList ACADVERSION ASSOCATIONDATA BLOCKQUANTITYLIST MODELSPACEFROMDRAWINGDATABASE OBJECTNAME X ASSOCATIONKEY ASSOCIATIONITEM BLOCKCOUNT BLOCKNAME BLOCKSFROMDRAWINGDATABASE CELLADDRESSRANGE CSVROW DATA_LIST DDBX DEFAULTEXCELFILEFORPRODUCTLAYOUTBLOCKSASSOCIATION DEFAULTEXCELFILEFORPRODUCTLAYOUTBLOCKSDATA DEFAULTEXCELFILEFORPRODUCTLAYOUTBLOCKSKEY DRAWINGEXTRACTIONFOLDER DRAWINGFULLNAME DRAWINGNAME DXF0 ENTDXF ENTITYNAME EXCELFILEPATH EXCELSHEETNUMBER FILEPATH HANDLE ISTHISAVALIDPRODUCTLAYOUTBLOCKNAME isThisADrawingToProcess LAYOUTFLAG QUANTITY RETURNLIST STRINGLOCATIONASSOCATIONLIST VALIDPRODUCTLAYOUTBLOCKNAMESASSOCIATION XREFFLAG YEARVERSIONASINT YEARVERSIONASSTRING
		)




    
;;; Standard *error* function for Legrand														
;;; View the file below for a working example and more in depth notes on how to implement and use it							
;;; C:\WS_Blocks\Default\LISP\Lisp Functions\Subfunction Library\DEFAULT-ERROR-HANDLER.LSP								
	(defun *error* ( msg / THECALLINGFUNCTIONSNAME)

		(setq theCallingFunctionsName "LMCS-4-3-GET-LAYOUT-BLOCK-COUNT-FROM-CURRENT-DRAWING")
		(DEFAULT-ERROR-HANDLER theCallingFunctionsName msg)
	)

;;; function body																	

  	(setq errorMessageList "")
  
  	(setq listBit 1)
	(setq validProductLayoutBlockNamesAssociation (GET-VALID-PRODUCT-BLOCK-NAME-LIST-FROM-DEFAULT-EXCEL listBit))


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
			  	(/= returnList nil)
			  	(progn
				(setq ROOMID (cdr (assoc "ROOMID" assocationList)))
				)
			  	(progn
				(setq ROOMID "Blank")
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


