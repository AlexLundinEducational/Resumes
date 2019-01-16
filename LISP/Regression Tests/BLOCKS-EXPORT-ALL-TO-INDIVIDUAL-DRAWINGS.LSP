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
		BLOCKNAME DEFAULTPALETTESSOURCEBLOCKSFILEASSOCIATION DEFAULTPALETTESSOURCEBLOCKSFILEDATA DEFAULTPALETTESSOURCEBLOCKSFILEKEY
		DEFAULTPALETTESSOURCEBLOCKSFOLDERASSOCIATION DEFAULTPALETTESSOURCEBLOCKSFOLDERDATA DEFAULTPALETTESSOURCEBLOCKSFOLDERKEY INSERTIONPOINT
		MODELSPACEORPAPER PATH RETURNVALUE ROTATION STRINGLOCATIONASSOCATIONLIST XSCALE YSCALE ZSCALE
		)       																
 	;;; standard *error* function for Legrand													
 	;;; View the file below for a working example and more in depth notes on how to implement and use it						
 	;;; C:\WS_Blocks\Default\LISP\Lisp Functions\Subfunction Library\DEFAULT-ERROR-HANDLER.LSP							
	(defun *error* ( msg / THECALLINGFUNCTIONSNAME)													
		(setq theCallingFunctionsName "c:ZZ")													
		(DEFAULT-ERROR-HANDLER theCallingFunctionsName msg)											
	)																		
  	;;; c:ZZ function body																
	(setq subFunctionName "BLOCKS-EXPORT-ALL-TO-INDIVIDUAL-DRAWINGS")
  
														
	;;; <- here is where you can perform whatever actions are neccessary for your test								

  	;;; get string locations for the support path from the string constant function									
	;;; GET-IMPORTANT-SOURCE-FOLDERS-AND-FILES													
	(setq returnList ( GET-IMPORTANT-SOURCE-FOLDERS-AND-FILES nil))													
	(setq stringLocationAssocationList returnList)
  
  	(setq defaultPalettesSourceBlocksFileAssociation (assoc "DEFAULT-TOOL-PALETTES-SOURCE-BLOCKS-FILE" stringLocationAssocationList))		
  	(setq defaultPalettesSourceBlocksFileKey (car defaultPalettesSourceBlocksFileAssociation))					
  	(setq defaultPalettesSourceBlocksFileData (cdr defaultPalettesSourceBlocksFileAssociation))

  	(setq defaultPalettesSourceBlocksFolderAssociation (assoc "DEFAULT-TOOL-PALETTES-SOURCE-BLOCKS" stringLocationAssocationList))		
  	(setq defaultPalettesSourceBlocksFolderKey (car defaultPalettesSourceBlocksFolderAssociation))					
  	(setq defaultPalettesSourceBlocksFolderData (cdr defaultPalettesSourceBlocksFolderAssociation))

  	;;;; insert a block to export															
  	(setq blockName "LMDM-101")
  	(setq insertionPoint nil)
	(setq modelSpaceOrPaper nil)
	(setq rotation 80)
	(setq xscale nil)
	(setq yscale nil)
	(setq zscale nil)		 
  	(setq returnValue (INSERT-LAYOUT-BLOCK blockName insertionPoint modelSpaceOrPaper rotation xscale yscale zscale))
  	(vla-delete returnValue)													

 	(setq path defaultPalettesSourceBlocksFolderData)																							
	(BLOCKS-EXPORT-ALL-TO-INDIVIDUAL-DRAWINGS path)
  
	;;; each test output data list must start with either a pass or fail flag									
	(setq passFlag "T")
	(setq failFlag "F")																			
  																			
 	;;; test 1																	
  	;;; document why this test exists														
	;;; include valid reasons in your output data so the test is useful for regression tests							
  	(setq line1 "\nTest 1 Passed")															
  	(setq line2 "\n\tReason 1 is, export worked")
  	(setq dataLines1 (list line1 line2))
  	(setq test1OutputData (list passFlag dataLines1))
	
  	;;; store as many lines to outputdata as you need to make it clear what your tests did								
	(setq OUTPUTDATA (list test1OutputData))
   																					
																	
	;;; Return																	
	(setq returnList OUTPUTDATA)	;;; list of data containing test output information, ready for writing to log file				
																			
)																			
;;; </ZZ-example>																	
;;;-----------------------------------------------------------------------------------------------------------------------------------------------------
;;; <Subfunction Name> 																	
;;; BLOCKS-EXPORT-ALL-TO-INDIVIDUAL-DRAWINGS 														
;;; </Subfunction Name>																	
;;; <Developer Notes>																	
;;; Export all blocks to seperate drawing files, these files will be the collect of indivual attributes and object that define the block		
;;; The resulting dwg files can be used to redefine objects that already exist in other drawings							
;;; Alex Lundin																		
;;; 01-29-2018																		
;;; </Developer Notes>																	
(defun BLOCKS-EXPORT-ALL-TO-INDIVIDUAL-DRAWINGS
       		(
		;;; <Arguments>			
		PATH ;;; - path directory path	
		;;; </Arguments>		
		/
		;;; local variables	
		*ERROR*
		CHK CMDECHO CTR FN ISDIRECTORY ITM LST MSG NAM NUMBEROFEXPORTS PASS RETURNLIST
		)


;;; Standard *error* function for Legrand														
;;; View the file below for a working example and more in depth notes on how to implement and use it							
;;; C:\WS_Blocks\Default\LISP\Lisp Functions\Subfunction Library\DEFAULT-ERROR-HANDLER.LSP								
	(defun *error* ( msg / THECALLINGFUNCTIONSNAME)

		(setq theCallingFunctionsName "BLOCKS-EXPORT-ALL-TO-INDIVIDUAL-DRAWINGS")
		(DEFAULT-ERROR-HANDLER theCallingFunctionsName msg)
	)

;;; function body																	

	(setq cmdecho (getvar "CMDECHO"))
  	(setvar "CMDECHO" 0)


  	(if
	  	(= PATH nil)
	  	(progn
		(setq msg "Supplied folder path is nil")
		(*error* msg)
		)
	)
  
	(setq isDirectory (findfile PATH))
  	(if
	  	(= isDirectory nil)
	  	(progn
		(setq msg "Directory for export does not exist")
		(*error* msg)
		)
	)

  	;;; remove ending \\ on a directory path if they exist
	(if
	  	(= (substr path (strlen path) 1) "\\")
	  	(progn
		(setq path (substr path 1 (1- (strlen path))))
		)
	)

  
		
	;;; building list of blocks from block table		
	(setq lst nil)
	(setq itm (tblnext "BLOCK" T))
		
	(while
	  	(/= itm nil)
		(setq nam (cdr (assoc 2 itm)))
		(setq pass T)
		(if
			(/= (cdr (assoc 1 itm)) nil)
			(setq pass nil)
			(progn
			(setq ctr 1)
			(repeat
			  	(strlen nam)
				(setq chk (substr nam ctr 1))
				(if
				  	(or (= chk "*")(= chk "|"))
					(setq pass nil)
				)
				(setq ctr (1+ ctr))
			)
			
			)
		)
	  
		(if
		  	(= pass T)
			(setq lst (cons nam lst))
		)
		(setq itm (tblnext "BLOCK"))
	);end while

 	;;; sort list						
	(setq lst (acad_strlsort lst))
  
	;;; export loop						
	(foreach blk lst
		(setq fn (strcat path (chr 92) blk))
		(if (findfile (strcat fn ".dwg"))
		(command "_.WBLOCK" fn "_Y" blk)
		(command "_.WBLOCK" fn blk)
		)
	)
  	;;; save number of exports				
  	(if
	  	(/= lst nil)
	  	(progn
	  	(setq numberOfExports (length lst))
	  	)
 	)

  	;;; restore command echo value and print results	
	(setvar "CMDECHO" cmdecho)
	(princ (strcat "Exported "(itoa numberOfExports)" blocks to folder:\n" path))

  	;;; <Return>																	
	(setq returnList numberOfExports)	;;; number of exported blocks, or nil									
	;;; </Return>																	
																
	
)