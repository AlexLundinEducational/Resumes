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
																			
	(setq subFunctionName "BLOCK-REPLACE-KEEP-DYNAMIC-PROPERTY-VALUES")														
																			
	;;; <- here is where you can perform whatever actions are neccessary for your test								

  	;;; switch to model and insert a LMDM-101 switch												
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


	(setq blockWindowLowerLeft (list -60 -60))
  	(setq blockWindowUpperRight (list 60 60))
	(command "_.zoom" "_w" blockWindowLowerLeft blockWindowUpperRight)

	(setq clayer (getvar "clayer"))
  	(setq currentTab (getvar "ctab"))
  	(setvar "ctab" "Model")
  
  	(setq blockName "LMDM-101")
  	(setq insertionPoint nil)
	(setq modelSpaceOrPaper nil)
	(setq rotation 80)
	(setq xscale nil)
	(setq yscale nil)
	(setq zscale nil)
		 
  	(setq returnValue (INSERT-LAYOUT-BLOCK blockName insertionPoint modelSpaceOrPaper rotation xscale yscale zscale))
  
  
  	;;; create selection set from all objects that are inserted blocks										
	(setq ss (ssget "x" (list (cons 0 "INSERT")(cons 8 clayer))))											
	(setq cntr 0)																	
	;set cmax to length of blocks selection set													
	(setq cmax (sslength ss))															
																			
																		
																			
  	;;; replace any LMDM-101 with LMSW-101 while keeping all matching rotation attributes the same							
	(setq newBlockName "LMSW-101")															
  	(setq originalBlockName "LMDM-101")
  
  	(setq autoCADYear (atof (getvar 'AcadVer)))

  	;;; if autocad 2019
  	(if
	  	(>= autoCADYear 23.0)
	  	(progn
		(C:WIPEOUTREMOVEALL)
		)
	)
  
  	(setq string (getstring (strcat "\nShowing block ["originalBlockName"] at "(itoa rotation)" degrees rotation before replace (Press enter to continue)")))
  
	(while																		
		;set loop to continue while the counter varaible cntr is less that the number of objects in the selection set blocks			
	  	(< cntr cmax)																
		;set variable ent to the name of the block that matches the current counter value							
	  	(setq ent(ssname ss cntr))														
		(setq EntDxf (entget ent))														
		(setq Dxf0 (cdr (assoc 0 EntDxf)))													
																			
		(if																	
			(=  Dxf0 "INSERT")														
			(progn																
			(setq blockTrueName (ENTITY-TO-BLOCK-TRUENAME ent))										
																			
			(if																
				(= blockTrueName originalBlockName)											
				(progn															
				(setq newDxf2 (cons 2 newBlockName))											
				(setq originalDxf2 (assoc 2 EntDxf))											
				(BLOCK-REPLACE-KEEP-DYNAMIC-PROPERTY-VALUES ent newBlockName)								
				)															
			)																
																			
			)																
		)																	
																			
		;once while loop reaches this point, increment counter varaible by one									
		(setq cntr(+ cntr 1))															
	)

  	(setq autoCADYear (atof (getvar 'AcadVer)))

  	;;; if autocad 2019
  	(if
	  	(>= autoCADYear 23.0)
	  	(progn
		(C:WIPEOUTREMOVEALL)
		)
	)
  
  	(setq string (getstring (strcat "\nShowing block ["newBlockName"] maintained "(itoa rotation)" degrees rotation after replace (Press enter to continue)")))
  
	(princ)

  	;;; each test output data list must start with either a pass or fail flag									
	(setq passFlag "T")
	(setq failFlag "F")
  
 	;;; test 1																	
  	;;; document why this test exists														
	;;; include valid reasons in your output data so the test is useful for regression tests							
  	(setq line1 "\nTest 1 Passed")															
  	(setq line2 "\n\tReason 1 is, insert on rotation then replace worked and kept original rotation")
	(setq dataLines (list line1 line2))
  	(setq test1OutputData (list passFlag dataLines))
	
  	;;; store as many lines to outputdata as you need to make it clear what your tests did								
	(setq OUTPUTDATA (list test1OutputData))
  

  	(setvar "ctab" currentTab)
  
  	(command "_.zoom" "_w" lowerLeft upperRight)
  
	;;; Return																	
	(setq returnList OUTPUTDATA)	;;; list of data containing test output information, ready for writing to log file				
																			
)																			
;;; </ZZ-example>																	
;;;-----------------------------------------------------------------------------------------------------------------------------------------------------
;;; <Subfunction Name> 																	
;;; BLOCK-REPLACE-KEEP-DYNAMIC-PROPERTY-VALUES 														
;;; </Subfunction Name>																	
;;; <Developer Notes>																	
;;; Used to replace the second dxf code (block name) with a new block name, supplied by caller								
;;; After replacement, keep any matching dynamic properties, besides the origin point, the same								
;;; Alex Lundin																		
;;; 01-16-2017																		
;;; </Developer Notes>																	
(defun BLOCK-REPLACE-KEEP-DYNAMIC-PROPERTY-VALUES
       		(
		;;; <Arguments>								
		ENT		;;; - any valid entity from AutoCAD selection set	
		NEWBLOCKNAME	;;; - string of new block name				
		;;; </Arguments>							
		/
		;;; local variables	
		*ERROR*
		
		)


;;; Standard *error* function for Legrand														
;;; View the file below for a working example and more in depth notes on how to implement and use it							
;;; C:\WS_Blocks\Default\LISP\Lisp Functions\Subfunction Library\DEFAULT-ERROR-HANDLER.LSP								
	(defun *error* ( msg / THECALLINGFUNCTIONSNAME)

		(setq theCallingFunctionsName "BLOCK-REPLACE-KEEP-DYNAMIC-PROPERTY-VALUES")
		(DEFAULT-ERROR-HANDLER theCallingFunctionsName msg)
	)

;;; function body																	

  	(vl-load-com)
  
  	;;; turn attribute required off
	(setvar "ATTREQ" 0)
  
  	;;; get string locations for the support path from the string constant function
	;;; GET-IMPORTANT-SOURCE-FOLDERS-AND-FILES				
	(setq returnList ( GET-IMPORTANT-SOURCE-FOLDERS-AND-FILES nil))													
  	(setq stringLocationAssocationList returnList)
  
  	(setq defaultPalettesSourceBlocksFolderAssociation (assoc "DEFAULT-TOOL-PALETTES-SOURCE-BLOCKS" stringLocationAssocationList))		
  	(setq defaultPalettesSourceBlocksFolderKey (car defaultPalettesSourceBlocksFolderAssociation))					
  	(setq defaultPalettesSourceBlocksFolderData (cdr defaultPalettesSourceBlocksFolderAssociation))


	(setq fullBlockDrawingName (strcat defaultPalettesSourceBlocksFolderData "\\" newBlockName ".dwg"))							;create entire string from pieces of info

	(setq sourceBlockExists (findfile fullBlockDrawingName))


  	;;; if source block does not exit	
	;;; check current drawing for new block	
	(if
	  	(= sourceBlockExists nil)
	  	(progn
		(setq drawingBlockExists (tblsearch "BLOCK" NEWBLOCKNAME))
		(setq fullBlockDrawingName NEWBLOCKNAME)
		(princ)
		)
	)

  

  	;;; if still nil, error and exit
	(if
	  	(and
	  	(= sourceBlockExists nil)
		(= drawingBlockExists nil)
		)
	  	(progn
		(setq msg (strcat "The source block for " NEWBLOCKNAME " is not found in the current drawing or the source folder:\n" defaultPalettesSourceBlocksFolderData))
		(*error* msg)
		)
	)
	(setq customLayer "LISP-CUSTOM-INSERT-LAYER")
	;;; save current layer, then toggle to layer 0									
	(setq currentLayer (getvar "clayer"))
	(command "_.Layer" "_Make" customLayer "_Color" "30" "" "LType" "Continuous" "" "")					
  	(setvar "clayer" customLayer)
	;;; insert source block												
	(setq block (command-s "insert" fullBlockDrawingName "0,0" "1" "1" "0"))

	(setvar "clayer" currentLayer)
  
  	(setq EntDxf (entget ent))
 	(setq oldDxf2 (assoc 2 EntDxf))
	(setq newDxf2 (cons 2 newBlockName))
	(setq oldDxf50 (assoc 50 EntDxf))
	(setq oldAngle (cdr oldDxf50))
  	;;; obj reference will remain the same after entmod replace
	(setq Obj (vlax-ename->vla-object ent))

  	;;; loop to store dynamic properties of old block
	(if
	  	(equal (vla-get-isdynamicblock Obj) :vlax-true)
		(progn
		  
			(foreach property (vlax-invoke Obj 'GetDynamicBlockProperties)
				(setq propertyName (vla-get-propertyname property))
				(setq DynamicPropertyValue (vlax-get property 'Value))
				(setq propertyNameAssociation (cons propertyName DynamicPropertyValue))
			  
				(setq dynamicPropertyAssociationListOld (cons propertyNameAssociation dynamicPropertyAssociationListOld))


			)
		  


		)
	)

  	;;; replace the block with entmod
	(entmod (subst newDxf2 oldDxf2 EntDxf))

	
  
  	;;; loop to store starting values of properties of new block
	(if
	  	(equal (vla-get-isdynamicblock Obj) :vlax-true)
		(progn
		  
			(foreach property (vlax-invoke Obj 'GetDynamicBlockProperties)
				(setq propertyName (vla-get-propertyname property))
				(setq DynamicPropertyValue (vlax-get property 'Value))

			  	(setq propertyNameAssociation (cons propertyName DynamicPropertyValue))
			  

				(setq dynamicPropertyAssociationListNew (cons propertyNameAssociation dynamicPropertyAssociationListNew))
			)
		  


		)
	)

  	;;; loop to make the final list					
  	;;; if new property also exists in old list, use old value	
  	;;; then use the old list value					
	;;; else use new value						
	(foreach
		propertyNameAssociation dynamicPropertyAssociationListNew

		(setq propertyNameNew (nth 0 propertyNameAssociation))
	  	(setq DynamicPropertyValueNew (nth 0 propertyNameAssociation))

	  	(setq isNewPropertyInOldList (assoc propertyNameNew dynamicPropertyAssociationListOld))
	  
	  	(if
		  	;;; use value in new list		
		  	(/= isNewPropertyInOldList nil)
		  	(progn
			(setq dynamicPropertyAssociationList (cons isNewPropertyInOldList dynamicPropertyAssociationList))
			)
		  	;;; value in new list doesn't exits	
		  	;;; so use old value			
		  	(progn
			(setq dynamicPropertyAssociationList (cons propertyNameAssociation dynamicPropertyAssociationList))
			)
		)
	)
														

  	;;; update any matching properties on the new block, from values in dynamicPropertyAssociationList					
  	;;; the dynamicPropertyAssociationList is a combination of new values, and old values for all attributes on the NEW block only		
  	;;; if any properties are shared between the old and new block, then dynamicPropertyAssociationList has the value from the old block	
  	;;; as long as the property name is not Origin												
	(foreach property (vlax-invoke Obj 'GetDynamicBlockProperties)
		(setq propertyName (vla-get-propertyname property))
		(setq DynamicPropertyValue (vlax-get property 'Value))

	  	
	  
		(cond
		  	((= propertyName "Origin")
			(setq SKIPBIT 1)
			)
			(t
			(setq oldPropertyValue (cdr (assoc propertyName dynamicPropertyAssociationList)))
			(vla-put-value property (vlax-make-variant oldPropertyValue (vlax-variant-type (vla-get-value property))))
			)
		)

	
	)

  	;;; remove anything on the customLayer		
	(setq blocks (ssget "x" (list(cons 8 customLayer))))						;create selection set from all blocks in layout
	(setq cntr 0)											;initialize counter to 0 for while loop
	(setq cmax (sslength blocks))									;set cmax to length of blocks selection set
	(while 	(< cntr cmax)										;--while loop to continue while the counter varaible cntr is less that the number of objects in the selection set blocks
		(setq ent(ssname blocks cntr))								;set variable ent to the name of the block that matches the current counter value

		(entdel ent)
	  	(setq cntr(+ cntr 1))									;once while loop reaches this point, increment counter varaible by one			
	)												;--end while loop  
	(princ)
  
	
	;;; <Return>																	
	(setq returnList (list "returnValue1" "returnValue2" "returnValue3"))	;;; list containing 3 strings						
	;;; </Return>																	
	
)