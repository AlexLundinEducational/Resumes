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
		ATTREF ATTRIBUTECOUNTAFTERDELETE ATTRIBUTECOUNTAFTERREDEFINE ATTRIBUTECOUNTBEFOREDELETE ATTRIBUTES BLOCKNAME CNT COUNTERMAX
		DEFAULTPALETTESSOURCEBLOCKSFOLDERASSOCIATION DEFAULTPALETTESSOURCEBLOCKSFOLDERDATA DEFAULTPALETTESSOURCEBLOCKSFOLDERKEY
		INSERTIONPOINT MODELSPACEORPAPER OBJECT PATH RETURNVALUE ROTATION STRINGLOCATIONASSOCATIONLIST VARIANTOBJECT XSCALE YSCALE ZSCALE
		)       																
 	;;; standard *error* function for Legrand													
 	;;; View the file below for a working example and more in depth notes on how to implement and use it						
 	;;; C:\WS_Blocks\Default\LISP\Lisp Functions\Subfunction Library\DEFAULT-ERROR-HANDLER.LSP							
	(defun *error* ( msg / THECALLINGFUNCTIONSNAME)													
		(setq theCallingFunctionsName "c:ZZ")													
		(DEFAULT-ERROR-HANDLER theCallingFunctionsName msg)											
	)																		
  	;;; c:ZZ function body																
																			
	(setq subFunctionName "BLOCKS-REDEFINE-FROM-SOURCE-FOLDER")														
																			
	;;; <- here is where you can perform whatever actions are neccessary for your test								

  	;;; get string locations for the support path from the string constant function									
	;;; GET-IMPORTANT-SOURCE-FOLDERS-AND-FILES													
	(setq returnList ( GET-IMPORTANT-SOURCE-FOLDERS-AND-FILES nil))													
	(setq stringLocationAssocationList returnList)
  
  	(setq defaultPalettesSourceBlocksFolderAssociation (assoc "DEFAULT-TOOL-PALETTES-SOURCE-BLOCKS" stringLocationAssocationList))		
  	(setq defaultPalettesSourceBlocksFolderKey (car defaultPalettesSourceBlocksFolderAssociation))					
  	(setq defaultPalettesSourceBlocksFolderData (cdr defaultPalettesSourceBlocksFolderAssociation))


  	;;;; insert a block to modify then redefine													
  	(setq blockName "LMDM-101")
  	(setq insertionPoint nil)
	(setq modelSpaceOrPaper nil)
	(setq rotation 80)
	(setq xscale nil)
	(setq yscale nil)
	(setq zscale nil)		 
  	(setq returnValue (INSERT-LAYOUT-BLOCK blockName insertionPoint modelSpaceOrPaper rotation xscale yscale zscale))

	(setq object returnValue)
        (setq variantObject (vlax-invoke-method object 'getattributes))
        (setq attributes (vlax-safearray->list (vlax-variant-value variantObject)))
        (setq cnt 0)
	(setq counterMax (- (length attributes) 1))
  
  	(setq attributeCountBeforeDelete (length attributes))
  
  	;;; delete all attributes															
        (while
	  	(< cnt counterMax)
          	(setq attref (nth (setq cnt (1+ cnt)) attributes))
          	(vlax-invoke-method attref 'Delete)
	)
  
        
  
	;;; redefine																	
  	(setq path defaultPalettesSourceBlocksFolderData)						
	(BLOCKS-REDEFINE-FROM-SOURCE-FOLDER path)													


	(setq object returnValue)
        (setq variantObject (vlax-invoke-method object 'getattributes))
        (setq attributes (vlax-safearray->list (vlax-variant-value variantObject)))
        (setq attributeCountAfterRedefine (length attributes))

  	;;; delete block before ending function														
  	(vla-delete returnValue)
  
    	;;; each test output data list must start with either a pass or fail flag									
	(setq passFlag "T")
	(setq failFlag "F")
	;;; test 1																	
  	;;; document why this test exists														
	;;; include valid reasons in your output data so the test is useful for regression tests							
	(if
	  	(> attributeCountAfterDelete attributeCountBeforeDelete)
	  	(progn
		(setq testFlag passFlag)
	  	(setq line1 "\nTest 1 Passed")															
	  	(setq line2 (strcat "\n\tReason 1 is: \n\tThere were "(itoa attributeCountBeforeDelete)" attibutes deleted from the block.\n\tThere were "(itoa attributeCountAfterRedefine)" attributes after redefining block."))				
		)
	  	(progn
		(setq testFlag failFlag)
	  	(setq line1 "\nTest 1 Failed")															
	  	(setq line2 (strcat "\n\tReason 1 is: \n\tThere were "(itoa attributeCountBeforeDelete)" attibutes deleted from the block.\n\tThere were "(itoa attributeCountAfterRedefine)" attributes after redefining block."))
		)
	)
  	(setq dataLines1 (list line1 line2))
  	(setq test1OutputData (list testFlag dataLines1))
	
  	;;; store as many lines to outputdata as you need to make it clear what your tests did								
	(setq OUTPUTDATA (list test1OutputData))	
										
																	
	;;; Return																	
	(setq returnList OUTPUTDATA)	;;; list of data containing test output information, ready for writing to log file				
																			
)																			
;;; </ZZ-example>																	
;;;-----------------------------------------------------------------------------------------------------------------------------------------------------
;;; <Subfunction Name> 																	
;;; BLOCKS-REDEFINE-FROM-SOURCE-FOLDER 															
;;; </Subfunction Name>																	
;;; <Developer Notes>																	
;;; Function to insert and delete new block defintion on drawing origin, then use this defintion to update all matching blocks				
;;; Alex Lundin																		
;;; 01-29-2018																		
;;; </Developer Notes>																	
(defun BLOCKS-REDEFINE-FROM-SOURCE-FOLDER
       		(
		;;; <Arguments>												
		dir	;;; - valid folder location of source blocks or nil to search support paths instead		
		;;; </Arguments>											
		/
		;;; local variables	
		*ERROR*
		BLN DOC DWG LST NUMBEROFREDEFINES OBJ OLDBLIP OLDECHO OLDOSM ORG RETURNLIST SPC
		)


;;; Standard *error* function for Legrand														
;;; View the file below for a working example and more in depth notes on how to implement and use it							
;;; C:\WS_Blocks\Default\LISP\Lisp Functions\Subfunction Library\DEFAULT-ERROR-HANDLER.LSP								
	(defun *error* ( msg / THECALLINGFUNCTIONSNAME)

		(setq theCallingFunctionsName "BLOCKS-REDEFINE-FROM-SOURCE-FOLDER")
		(DEFAULT-ERROR-HANDLER theCallingFunctionsName msg)
	)

;;; function body																	

 	;;; save and toggle system variables
	(setq oldecho (getvar "CMDECHO"))
	(setq oldblip (getvar "BLIPMODE"))
	(setq oldosm (getvar "OSMODE"))
	(setvar "CMDECHO" 0)
	(setvar "BLIPMODE" 0)
	(setvar "OSMODE" 0) 
	(setq numberOfRedefines 0)
  
	(if
	  	dir
		(setq dir (strcat (vl-string-right-trim "\\" (vl-string-translate "/" "\\" dir)) "\\"))
		(setq dir "")
	)
  
	(cond
		( (= 4 (logand 4 (cdr (assoc 70 (tblsearch "layer" (getvar 'clayer))))))
		(princ "\nCurrent layer locked.")
		)
		( (setq doc (vla-get-activedocument (vlax-get-acad-object))
		spc (vla-get-modelspace doc)
		org (vlax-3D-point 0 0)
		)
		(terpri)
		(vlax-for blk (vla-get-blocks doc)
			(if
			(and
			(= :vlax-false (vla-get-isxref blk))
			(= :vlax-false (vla-get-islayout blk))
			(not (wcmatch (setq bln (vla-get-name blk)) "`**,*|*"))
			)
			(progn
				(if
				  	;;; if block exists as drawing file in support path
				  	(setq dwg (findfile (strcat dir bln ".dwg")))
					(progn
					(setq obj (vla-insertblock spc org dwg 1.0 1.0 1.0 0.0))
					(if (= :vlax-true (vla-get-hasattributes obj))
					(setq lst (vl-list* "," bln lst))
					)
					(vla-delete obj)
					(setq numberOfRedefines (+ numberOfRedefines 1))
					)
				)
			)
			)
		)

		(textscr)
		(vla-regen doc acallviewports)
		)
	)
  
  
	(ATTRIBUTE-GLOBAL-SYNC)
	(setvar "CMDECHO" oldecho)
	(setvar "BLIPMODE" oldblip)
	(setvar "OSMODE" oldosm)  
	(princ)
	
	(princ (strcat "Redefined "(itoa numberOfRedefines)" blocks in current drawing, from folder:\n" dir))

  	;;; <Return>																	
	(setq returnList numberOfRedefines)	;;; number of redefined blocks, or nil									
	;;; </Return>																	
																	
																
	
)
