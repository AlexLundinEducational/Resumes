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
																			
	(setq subFunctionName "ATTSYNC-KEEP-ATTRIBUTES-IN-PLACE")														
																			
	;;; <- here is where you can perform whatever actions are neccessary for your test								
	(ATTSYNC-KEEP-ATTRIBUTES-IN-PLACE)																	

  
  	;;; each test output data list must start with either a pass or fail flag									
	(setq passFlag "T")
	(setq failFlag "F")
	
	;;; test 1																	
  	;;; document why this test exists														
	;;; include valid reasons in your output data so the test is useful for regression tests							
  	(setq line1 "\nTest 1 Passed")															
  	(setq line2 "\n\tReason 1 is, blocks contain attributes after deleting and resynching")
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
;;; ATTSYNC-KEEP-ATTRIBUTES-IN-PLACE 															
;;; </Subfunction Name>																	
;;; <Developer Notes>																	
;;; Alex Lundin																		
;;; 03-13-2018																		
;;; Uncomment the c:ZZ function above for a working example of ATTSYNC-KEEP-ATTRIBUTES-IN-PLACE								
;;; https://forums.autodesk.com/t5/net/attribute-to-move-to-block-without-the-old-att/td-p/3612736/page/2						
;;; This function saves all attribute locations to a data structure, then uses attsync to update the blocks from a source location			
;;; Finally this function moves any attributes that existed before attsync, back to their original location						
;;; Alex Lundin																		
;;; 05-31-2018																		
;;; moved delete line during block insert, now delete block happens even if block DOES NOT have attributes						
;;; </Developer Notes>																	
(defun ATTSYNC-KEEP-ATTRIBUTES-IN-PLACE
       		(
		;;; <Arguments>		
		;;; none		
		;;; </Arguments>	
		/
		;;; local variables	
		*ERROR*
		ACADOBJ ALIGNMENTPOINT ALLLAYOUTS ATTRIBUTEOBJECT BLOCKATTRIBUTELIST BLOCKATTRIBUTELISTS DEFAULTPALETTESSOURCEBLOCKSFOLDERASSOCIATION DEFAULTPALETTESSOURCEBLOCKSFOLDERDATA DEFAULTPALETTESSOURCEBLOCKSFOLDERKEY RETURNLIST STRINGLOCATIONASSOCATIONLIST BLOCKNAMESTRING BLOCKOBJECT BLOCKREFOBJ BLOCKSOURCELOCATION CENTERX CENTERY COUNTER COUNTER2 COUNTER3 COUNTERMAX COUNTERMAX2 COUNTERMAX3 CTAB DOC DXFCODE410 ENAMEBLOCK ENAMEHANDLE ENTITY ENTITYDXFCODES FILEEXISTS HANDLENAME HASATTRIBUTES INSERTIONPNT INSERTIONPOINT ITEM LOWERLEFT MAXPOINT1 MAXPOINT2 MINPOINT1 MINPOINT2 MODELSPACE NAME PAPERSPACETABNAMES SS SS2 SSTRUE STARTINGTAB THISBLOCKSATTRIBUTEPOSITIONS UNIQUETRUENAMELIST UPPERRIGHT VIEWCENTER VIEWHEIGHT VIEWRESOLUTION VIEWRESOLUTION0 VIEWRESOLUTION1 VIEWWIDTH VLASPACETOINSERTBLOCK
		)


;;; Standard *error* function for Legrand														
;;; View the file below for a working example and more in depth notes on how to implement and use it							
;;; C:\WS_Blocks\Default\LISP\Lisp Functions\Subfunction Library\DEFAULT-ERROR-HANDLER.LSP								
	(defun *error* ( msg / THECALLINGFUNCTIONSNAME)

		(setq theCallingFunctionsName "ATTSYNC-KEEP-ATTRIBUTES-IN-PLACE")
		(DEFAULT-ERROR-HANDLER theCallingFunctionsName msg)
	)

;;; function body																	

  	(vl-load-com)

  	;;; get string locations for the support path from the string constant function									
	;;; GET-IMPORTANT-SOURCE-FOLDERS-AND-FILES													
	(setq returnList ( GET-IMPORTANT-SOURCE-FOLDERS-AND-FILES nil))													
	(setq stringLocationAssocationList returnList)
  
  	(setq defaultPalettesSourceBlocksFolderAssociation (assoc "DEFAULT-TOOL-PALETTES-SOURCE-BLOCKS" stringLocationAssocationList))		
  	(setq defaultPalettesSourceBlocksFolderKey (car defaultPalettesSourceBlocksFolderAssociation))					
  	(setq defaultPalettesSourceBlocksFolderData (cdr defaultPalettesSourceBlocksFolderAssociation))
  
  	(setq blockSourceLocation defaultPalettesSourceBlocksFolderData)
  
	(setq acadObj (vlax-get-acad-object))
	(setq doc (vla-get-ActiveDocument acadObj))
  	(setq modelSpace (vla-get-ModelSpace doc))
  	(setq startingTab (getvar "ctab"))

  	(setq paperSpaceTabNames (layoutlist))
  	(setq allLayouts (cons "MODEL" paperSpaceTabNames))
  
  	(foreach
		 layout allLayouts
	  	(setvar "ctab" layout)
		(setq ctab layout)

	  	(if
		  	(= ctab "MODEL")
		  	(progn
			(setq vlaSpaceToInsertBlock modelSpace)
			)
		  	(progn
			(setq vlaSpaceToInsertBlock (vla-get-PaperSpace doc))
			)
		)
	  	
	  
		(setq viewCenter (getvar "VIEWCTR"))
	  	(setq centerX (nth 0 viewCenter))
	  	(setq centerY (nth 1 viewCenter))
		(setq viewResolution (getvar "SCREENSIZE"))  
		(setq viewResolution0 (nth 0 viewResolution))
		(setq viewResolution1 (nth 1 viewResolution))
		(setq viewHeight (getvar "VIEWSIZE"))
		(setq viewWidth (* viewHeight ( / viewResolution0 viewResolution1)))
	  
	  	(setq minPoint1 (- centerX (/ viewWidth 2)))
		(setq minPoint2 (- centerY (/ viewHeight 2)))
	  	(setq maxPoint1 (+ centerX (/ viewWidth 2)))
		(setq maxPoint2 (+ centerY (/ viewHeight 2)))
		(setq lowerLeft (list minPoint1 minPoint2))
		(setq upperRight (list maxPoint1 maxPoint2))
	  	
	  
		(command "_.zoom" "extents")
	  


	  
	  	(setq ss (ssget "_x" (list (cons 0 "insert")(cons 8 "WATTSTOPPER")(cons 410 ctab))))

	  															;initialize counter to 0 for while loop
	  	(if														;if
		  	(/= ss nil)												;set is not nil
			(progn													;progn wrap
			(setq uniqueTrueNameList (SELECTION-SET-TO-UNIQUE-TRUENAME-LIST ss))
	  		(setq counterMax (length uniqueTrueNameList))								;set counterMax to length of items in list
			
			)													;progn wrap end
		)														;if end


		(setq ss2 (ssadd))
	  	(setq counter 0)

	  	;;; loop to select every block with attributes to save on next loop
		(while 	(< counter counterMax)											;set loop to continue while the counter varaible counter is less than counterMax
			(setq item(nth counter uniqueTrueNameList))								;set variable item to the item from the list that matches the current counter value

			(setq name item)

			(setq ssTrue (SELECTION-WITH-TRUENAME-FILTER ss (list name)))
			(setq ss2 (acet-ss-union (list ssTrue ss2)))

			
			(setq counter(+ counter 1))										;once while loop reaches this point, increment counter varaible by one
		)
		

	  	(if														;if
		  	(/= ss2 nil)												;set is not nil
			(progn													;progn wrap
	  		(setq counterMax2 (sslength ss2))									;set counterMax to length of items in list
			)													;progn wrap end
		  	(progn
			(setq counter2 0)
			(setq counterMax2 0)
			)
		)

		

	  	;;; loop to save attribute locations				
	  	;;; go through entire selection set				
	  	;;; if entity is in current tab					
	  	;;; save attributes into a list for modification after attsync	
	  	(setq counter2 0)
		(while 	(< counter2 counterMax2)										;set loop to continue while the counter2 varaible counter2 is less than counterMax
			(setq entity(ssname ss2 counter2))									;set variable item to the item from the list that matches the current counter2 value
			(setq blockObject (vlax-ename->vla-object entity))
		  	(setq entityDxfCodes (entget entity))
			(setq dxfCode410 (cdr (assoc 410 entityDxfCodes )))							;set dxfCode66 to the second element of the item that has 66 as it's first element, this is the attribute flag

		  	
		  	(if
			  	(= dxfCode410 ctab)
			  	(progn

				
				(setq thisBlocksAttributePositions (_attpositions blockObject))
				(setq blockAttributeLists (cons  thisBlocksAttributePositions blockAttributeLists))
				)
			)

			(setq counter2(+ counter2 1))										;once while loop reaches this point, increment counter2 varaible by one
		)




		;;; loop to sync attributes

	  	(setq counter 0)
		(while 	(< counter counterMax)											;set loop to continue while the counter varaible counter is less than counterMax
			(setq item (nth counter uniqueTrueNameList))								;set variable item to the item from the list that matches the current counter value

			(setq name item)


		  	(setq blockNameString (strcat blockSourceLocation "\\" name ".dwg"))
		  	
		  	(setq fileExists (findfile blockNameString))

		  	;;; if file exits										
		  	;;; insert new block										
		  	;;; check if block has attributes								
		  	;;; sync the newly inserted block, updates all attributes on every block with the same name	
		  	;;; put attributes back in the place they used to be, before attsync				

		  	(if
			  	(/= fileExists nil)
			  	(progn
				(setq insertionPnt (vlax-3d-point 0 0 0))
				(setq blockRefObj (vla-InsertBlock vlaSpaceToInsertBlock insertionPnt blockNameString 1 1 1 0))
		
			  	(setq enameBlock (vlax-vla-object->ename blockRefObj))

				(setq hasAttributes (vlax-get-property blockRefObj 'HasAttributes))

				(if
				  	(= hasAttributes :vlax-true)
				  	(progn

					;;; sync based on new insert
					(command "._attsync" "_s" enameBlock "_yes")
					



					)

				)

				;;; delete inserted block before continueing
				
				(vla-Delete blockRefObj)

				)
			)
		  
			(setq counter(+ counter 1))										;once while loop reaches this point, increment counter varaible by one
		)
		






		;;; loop to sync attributes

	  	(setq counter3 0)
	  	(setq counterMax3 (length blockAttributeLists))
	  
		(while 	(< counter3 counterMax3)										;set loop to continue while the counter varaible counter is less than counterMax
			(setq blockAttributeList(nth counter3 blockAttributeLists))						;set variable item to the item from the list that matches the current counter value

			;;; loop through the attributes
			(foreach att blockAttributeList
			  	(setq handleName (nth 0 att))
			  	(setq insertionPoint (nth 1 att))
			  	(setq alignmentPoint (nth 2 att))
				(if
					(and
					(setq eNameHandle (handent handleName)) 
					(setq attributeObject (vlax-ename->vla-object eNameHandle))
					)
				  	;;; put the attributes back in original locations, with handles saved from helper function
					(progn
					(vl-catch-all-apply 'vlax-put (list attributeObject 'insertionpoint insertionPoint))
					(vl-catch-all-apply 'vlax-put (list attributeObject 'textalignmentpoint alignmentPoint))
					)
				)

			)
		  
			(setq counter3 (+ counter3 1))										;once while loop reaches this point, increment counter varaible by one
		)
		



		(command "_.zoom" "_w" lowerLeft upperRight)
	  	(princ)	  

	)
  	

  	


	(setvar "ctab" startingTab)
	(princ)
	
	;;; <Return>	
	;;; none 	
	;;; </Return>	
	
)