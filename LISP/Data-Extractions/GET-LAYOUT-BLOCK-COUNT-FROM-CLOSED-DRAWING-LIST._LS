;;; ----------------------------------------------------------------------------------------------------------------------------------------------------
;;; <ZZ-example>																	
;;; Write an example call to the Subfunction here													
;;; This will allow other developers to verify how you intend your code to work										
;;; Example function c:ZZ with GET-LAYOUT-BLOCK-COUNT-FROM-CLOSED-DRAWING-LIST Subfunction Call								
;;;(defun c:ZZ ( / APPENDBIT BILLOFMATERIALSFROMALLDRAWINGS CLOSEDDRAWINGS CSVFILELOCATION CSVHEADERROW CURRENTFOLDER DEFAULTLISPTESTOUTPUTFOLDERASSOCIATION DEFAULTLISPTESTOUTPUTFOLDERDATA DEFAULTLISPTESTOUTPUTFOLDERKEY DEFAULTPALETTESSOURCEDRAWINGSFOLDERASSOCIATION DEFAULTPALETTESSOURCEDRAWINGSFOLDERDATA DEFAULTPALETTESSOURCEDRAWINGSFOLDERKEY DRAWINGEXTRACTIONFOLDER DRAWINGS EXTRACTIONNAME FILENAME FILEPATH LINE1 LINE2 LINE3 OPENDRAWINGS OUTPUTDATA RETURNEDLIST RETURNLIST STRINGFLAG STRINGLOCATIONASSOCATIONLIST TESTOUTPUTFILENAME)																	
;;; 	;;; standard *error* function for Legrand													
;;; 	;;; View the file below for a working example and more in depth notes on how to implement and use it						
;;; 	;;; C:\WS_Blocks\Default\LISP\Lisp Functions\Subfunction Library\DEFAULT-ERROR-HANDLER.LSP							
;;;	(defun *error* ( msg / THECALLINGFUNCTIONSNAME)													
;;;		(setq theCallingFunctionsName "c:ZZ")													
;;;		(DEFAULT-ERROR-HANDLER theCallingFunctionsName msg)											
;;;	)																		
;;;  	;;; c:ZZ function body																
;;;	(setq subFunctionName "GET-LAYOUT-BLOCK-COUNT-FROM-CLOSED-DRAWING-LIST")									
;;;																			
;;;  	;;; get string locations for the support path from the string constant function									
;;;	;;; GET-IMPORTANT-SOURCE-FOLDERS-AND-FILES													
;;;	(setq returnList ( GET-IMPORTANT-SOURCE-FOLDERS-AND-FILES nil))											
;;;  	(setq stringLocationAssocationList returnList)													
;;;																			
;;; 	(setq defaultPalettesSourceDrawingsFolderAssociation (assoc "DEFAULT-TOOL-PALETTES-SOURCE-DRAWINGS" stringLocationAssocationList))		
;;;  	(setq defaultPalettesSourceDrawingsFolderKey (car defaultPalettesSourceDrawingsFolderAssociation))						
;;;  	(setq defaultPalettesSourceDrawingsFolderData (cdr defaultPalettesSourceDrawingsFolderAssociation))						
;;;  																			
;;;  	(setq defaultLISPTestOutputFolderAssociation (assoc "DEFAULT-LISP-TEST-OUTPUT" stringLocationAssocationList))					
;;;  	(setq defaultLISPTestOutputFolderKey (car defaultLISPTestOutputFolderAssociation))								
;;;  	(setq defaultLISPTestOutputFolderData (cdr defaultLISPTestOutputFolderAssociation))								
;;;																			
;;;  	;;; this file name gets updated during the sub-function template save										
;;;	(setq FileName (strcat "TEST-" subFunctionName ".txt"))												
;;;  	;;; this is the full file path of your test output												
;;;  	(setq testOutputFileName (strcat defaultLISPTestOutputFolderData "\\" FileName))								
;;;																			
;;;  	;;; <- here is where you can perform whatever actions are neccessary for your test								
;;;	;;; get current drawing location														
;;;	(setq currentFolder (getvar 'DWGPREFIX))													
;;;																			
;;;  	(setq extractionName subFunctionName)														
;;;																			
;;;	;;; set csv file location															
;;;  	(setq csvFileLocation (strcat defaultLISPTestOutputFolderData "\\" extractionName ".csv"))							
;;;																			
;;;																			
;;;  	;;; create lists to hold header and data for csv columns											
;;;  	(setq csvHeaderRow (list "Excel Created" "" ""))												
;;;  	(setq billOfMaterialsFromAllDrawings (cons csvHeaderRow billOfMaterialsFromAllDrawings))							
;;;  																			
;;;  	;;; create lists to hold header and data for csv columns											
;;;  	(setq csvHeaderRow (list "File Name" "Name" "Count"))												
;;;  	(setq billOfMaterialsFromAllDrawings (cons csvHeaderRow billOfMaterialsFromAllDrawings))							
;;;																			
;;;																			
;;;	;;; get list of all drawings in folder that contain WS in the name										
;;;	(setq drawingExtractionFolder defaultPalettesSourceDrawingsFolderData)										
;;;  	(setq drawings (GET-ALL-FILES-IN-DIRECTORY currentFolder "*.dwg"))										
;;;  																			
;;;  	(setq returnedList (GET-LIST-OF-CLOSED-AND-OPEN-FILES drawings))										
;;;  	(setq closedDrawings (nth 0 returnedList))													
;;;  	(setq openDrawings (nth 1 returnedList))													
;;;  																			
;;;  	(setq stringFlag nil)																
;;;  	(setq billOfMaterialsFromAllDrawings (GET-LAYOUT-BLOCK-COUNT-FROM-CLOSED-DRAWING-LIST billOfMaterialsFromAllDrawings drawings stringFlag))	
;;;  																			
;;;  	(WRITE-TO-CSV csvFileLocation billOfMaterialsFromAllDrawings)											
;;;																			
;;;  																			
;;;  	;;; this is the write to text file function call after your tests are complete									
;;;  	;;; make sure to include valid reasons in your output file so the test is useful for regression tests						
;;;	(setq APPENDBIT 0)																
;;;	(setq FILEPATH testOutputFileName)														
;;;	(setq line1 "Tests for \n"subFunctionName"\n")													
;;;  	(setq line2 "\nTest 1 Passed")															
;;;  	(setq line3 "\n\tReason All drawings from current folder extracted from.")									
;;;	(setq OUTPUTDATA (list line1 line2 line3))													
;;;	(WRITE-TO-TEXT-FILE APPENDBIT FILEPATH OUTPUTDATA)												
;;;																			
;;;  																			
;;;	(princ "\nCounts extraction complete.")														
;;;  	(princ)																		
;;;)																			
;;; </ZZ-example>																	
;;;-----------------------------------------------------------------------------------------------------------------------------------------------------
;;; <Subfunction Name> 																	
;;; GET-LAYOUT-BLOCK-COUNT-FROM-CLOSED-DRAWING-LIST 													
;;; </Subfunction Name>																	
;;; <Developer Notes>																	
;;; Alex Lundin																		
;;; 10-08-2018																		
;;; Uncomment the c:ZZ function above for a working example of GET-LAYOUT-BLOCK-COUNT-FROM-CLOSED-DRAWING-LIST						
;;; This function loops through a set of drawings, and loads them into a database interface.								
;;; The loop accesses the blocks in modelspace of the database object and counts the valid layout block names						
;;; </Developer Notes>																	
(defun GET-LAYOUT-BLOCK-COUNT-FROM-CLOSED-DRAWING-LIST
       		(
		;;; <Arguments>	
		billOfMaterialsFromAllDrawings 	;;; 2D list with the csv header already in the first slot	
		drawings			;;; string list of drawing names to process			
		stringFlag			;;; string to search drawing name for before processing		
		;;; </Arguments>
		/
		;local variables
		*ERROR*
		ASSOCIATIONLISTBIT BLOCKNAME DRAWINGNAME ITEM NEWITEM NEWLIST QUANTITY BLOCKNAME DRAWINGNAME ERRORHEADER ERRORMESSAGE ERRORMESSAGELIST ERRORMESSAGESTRINGLIST ISTHEREANERROR ITEM NEWITEM NEWLIST QUANTITY THECALLINGFUNCTIONSNAME BLOCKQUANTITYLIST DRAWINGNAME NEWITEM NEWLIST X BLOCKQUANTITYLIST DRAWINGNAME NEWITEM NEWLIST X blockList ACADVERSION ASSOCATIONDATA BLOCKQUANTITYLIST MODELSPACEFROMDRAWINGDATABASE OBJECTNAME X ASSOCATIONKEY ASSOCIATIONITEM BLOCKCOUNT BLOCKNAME BLOCKSFROMDRAWINGDATABASE CELLADDRESSRANGE CSVROW DATA_LIST DDBX DEFAULTEXCELFILEFORPRODUCTLAYOUTBLOCKSASSOCIATION DEFAULTEXCELFILEFORPRODUCTLAYOUTBLOCKSDATA DEFAULTEXCELFILEFORPRODUCTLAYOUTBLOCKSKEY DRAWINGEXTRACTIONFOLDER DRAWINGFULLNAME DRAWINGNAME DXF0 ENTDXF ENTITYNAME EXCELFILEPATH EXCELSHEETNUMBER FILEPATH HANDLE ISTHISAVALIDPRODUCTLAYOUTBLOCKNAME isThisADrawingToProcess LAYOUTFLAG QUANTITY RETURNLIST STRINGLOCATIONASSOCATIONLIST VALIDPRODUCTLAYOUTBLOCKNAMESASSOCIATION XREFFLAG YEARVERSIONASINT YEARVERSIONASSTRING
		)




    
;;; Standard *error* function for Legrand														
;;; View the file below for a working example and more in depth notes on how to implement and use it							
;;; C:\WS_Blocks\Default\LISP\Lisp Functions\Subfunction Library\DEFAULT-ERROR-HANDLER.LSP								
	(defun *error* ( msg / THECALLINGFUNCTIONSNAME)

		(setq theCallingFunctionsName "GET-LAYOUT-BLOCK-COUNT-FROM-CLOSED-DRAWING-LIST")
		(DEFAULT-ERROR-HANDLER theCallingFunctionsName msg)
	)

;;; function body																	

  	(setq errorMessageList "")

  	(setq associationListBit 1)
	(setq validProductLayoutBlockNamesAssociation (GET-VALID-PRODUCT-BLOCK-NAME-LIST-FROM-DEFAULT-EXCEL associationListBit))

    	;;; get AutoCAD version information							
	(setq acadVersion (getvar "acadver"))
  	(setq yearVersionAsString (substr acadVersion 1 2))
	(setq yearVersionAsInt (atoi yearVersionAsString))
	;;; create database object, based on the number of the year version			
  	(if
	 	(< yearVersionAsInt 16)
	  	(progn
		(setq dDbx (vla-getinterfaceobject (vlax-get-acad-object) "ObjectDBX.AxDbDocument"))
		)
	  	;;; if older than 16, then add the string to the end of the document object	
		(progn
		(setq dDbx (vla-getinterfaceobject (vlax-get-acad-object) (strcat "ObjectDBX.AxDbDocument." yearVersionAsString)))
		)
	)

  	
  	;;; loop through each drawing, and processes the blocks					
  	(foreach drawing drawings

	  	(setq isThereAnError
			(vl-catch-all-apply
			  	;;; function name to wrap in catch all				
			  	'vlax-invoke-method
				;;; arguments as a single list, for the above function		
				(list dDBX 'Open drawing))
		)
	  
	  	(if
		  	(/= isThereAnError nil)
		  	(progn
			(setq errorMessage (vl-catch-all-error-message isThereAnError))
			(if
			  	(equal errorMessage "Automation Error. Description was not provided.")
			  	(progn
				(setq errorMessage (strcat errorMessage " --> Drawing probably open during processing."))
				)
			)
			;;; add the errorMessage to the list					
			(setq errorMessageList (strcat errorMessage errorMessageList))
			)
		  	;;; else there is no error, so parse information from drawing		
		  	(progn
			  

			
			)
		)




	  
	  	;;; if there is not an error		
	  	;;; parse the drawing information	
	  	(if
			(= isThereAnError nil)
			(progn
			  
		  	;;; save information about the drawing file name			
		   	(setq drawingFullName (vla-get-name dDBx))
		  	(setq drawingName (vl-filename-base drawingFullName))
		  	(setq drawingExtractionFolder (vl-filename-directory drawingFullName))


		  	;;; use stringFlag if it exists to search drawing name			
		  	(if
			  	(/= stringFlag nil)
			  	(progn
				(setq isThisADrawingToProcess (vl-string-search stringFlag drawingName))
				)
			  	;;; else set value to anything other than nil			
			  	(progn
				(setq isThisADrawingToProcess "Doesn't matter")
				)
			)

			)
		)

	  
	  	;;; if there is not an error		
	  	;;; and if this is a drawing to process	
		;;; loop through all obj in modelspace	
	  	(if
		  	(AND
			(= isThereAnError nil)
			(/= isThisADrawingToProcess nil)
			)
		  	;;; start WS drawing if statement					
		  	(progn

			;;; store blocks from the database					
			(setq modelSpaceFromDrawingDatabase (vla-get-modelspace dDBx))

			
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

					)


				)
			  	
			)
			;;; end block loop							
			(setq blockQuantityList (ITEMLIST-TO-QUANTITY-ASSOCIATION-LIST blockList))

			;;; inline function to add drawing name to each item in the quantity list
			(mapcar
				'(lambda (item )
				   
				  	(setq blockname (car item))
				  	(setq quantity (itoa (cdr item)))
				  	(setq newItem (list drawingName blockname quantity))
				  	(setq newList (cons newItem newList))
				   
				)
				;;; list to pass into lambda					
				blockQuantityList
			)
			
			(setq billOfMaterialsFromAllDrawings (append newList billOfMaterialsFromAllDrawings))
			(setq blockQuantityList nil)
			(setq blockList nil)
			(setq newList nil)	
			)
		  	;;; end WS drawing if statement						
			
		 )

	  	
	)
  	;;; end drawing loop									


  
  	;;; print stack trace of any errors that might have occured during database loads	
	(if
	  	(/= errorMessageList "")
	  	(progn			
  		(setq errorHeader "\nDatabase load caused atleast 1 error during drawing processing loop.\nThis is the complete error trace from the execution:\n")
		;;; add the errorMessage to the list						
		(setq errorMessageList (strcat errorHeader errorMessageList))
		(setq theCallingFunctionsName "GET-LAYOUT-BLOCK-COUNT-FROM-CLOSED-DRAWING-LIST")
		(princ errorMessageList)
		)
	)

  
	;;; <Return>															
	(setq billOfMaterialsFromAllDrawings (reverse billOfMaterialsFromAllDrawings))	;;; 2D list containing the bill of materials	
	;;; </Return>															
  		
)


