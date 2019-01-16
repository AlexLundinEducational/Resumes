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
																			
	(setq subFunctionName "BLOCK-INSERT-WITH-ATTRIBUTE-VALUES")														
																			
	;;; <- here is where you can perform whatever actions are neccessary for your test								

	(setq attributelist nil)
	(setq blockInsertionPoint (list 0 0))	
	(setq blockName "LMDC-100")
	(setq layername "0")
  	(BLOCK-INSERT-WITH-ATTRIBUTE-VALUES attributelist blockInsertionPoint blockName layername)																	
  																			

  
  	;;; each test output data list must start with either a pass or fail flag									
	(setq passFlag "T")
	(setq failFlag "F")
	
	;;; test 1																	
  	;;; document why this test exists														
	;;; include valid reasons in your output data so the test is useful for regression tests							
  	(setq line1 "\nTest 1 Passed")															
  	(setq line2 "\n\tReason 1 is, block inserted successfully and attributes exist in the block.")
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
;;; BLOCK-INSERT-WITH-ATTRIBUTE-VALUES 															
;;; </Subfunction Name>																	
;;; <Developer Notes>																	
;;; inserts block																	
;;; inserts any existing attributes from the block definition table											
;;; fills out attributes from list sent in from calling function											
;;; Alex Lundin																		
;;; 03-31-2017																		
;;; </Developer Notes>																	
(defun BLOCK-INSERT-WITH-ATTRIBUTE-VALUES
       		(
		;;; <Arguments>								
		attributelist		;;; - list of attributes			
		blockInsertionPoint	;;; - insertion point for filled out block	
		blockName		;;; - name of block from block table		
		layername		;;; - name of layer to insert block on		
		;;; </Arguments>							
		/
		;;; local variables	
		*ERROR*
		ATTRIBUTECOUNTER ATTRIBUTEDEFINITIONS ATTRIBUTEDXF10 ATTRIBUTEDXF11 ATTRIBUTEENTITYDEFINITION ATTRIBUTEFLAG ATTRIBUTEINSERTIONPOINT ATTRIBUTEVALUE ATTRIBUTEXCOORD ATTRIBUTEYCOORD BLOCKXCOORD BLOCKYCOORD DATA DXFCODE0 ENTITY ENTITYFROMTABLE NEWINSERTIONPOINTDXF10 NEWINSERTIONPOINTDXF11 NEWXCOORD NEWYCOORD NEXTENT RETURNLIST
		)


  
;;; Standard *error* function for Legrand														
;;; View the file below for a working example and more in depth notes on how to implement and use it							
;;; C:\WS_Blocks\Default\LISP\Lisp Functions\Subfunction Library\DEFAULT-ERROR-HANDLER.LSP								
	(defun *error* ( msg / THECALLINGFUNCTIONSNAME)

		(setq theCallingFunctionsName "BLOCK-INSERT-WITH-ATTRIBUTE-VALUES")
		(DEFAULT-ERROR-HANDLER theCallingFunctionsName msg)
	)

;;; function body																	

  	

  	(setq blockxcoord (car blockInsertionPoint))
	(setq blockycoord (cadr blockInsertionPoint))

  	;;; get entity name from the block table that matches 												
  	(setq entityFromTable (tblobjname "block" blockName))


  
	(cond	
		((/= entityFromTable nil)
		(setq NextEnt (entnext entityFromTable))

		;;; loop while nextEnt is not nil													
		;;; store all data from entities with type "ATTDEF"											
		(while
		  	(/= NextEnt nil)
		  
			(setq Data (entget NextEnt))
		  	(setq dxfCode0 (cdr (assoc 0 Data)))
		  
			(if
			  	(= "ATTDEF" dxfCode0)
			  	(progn
				(setq attributeDefinitions (cons Data attributeDefinitions))
				)
			)
		  
			(setq NextEnt (entnext NextEnt))
		  
		)
		 
		;;; set attributeFlag variable based on if attributeDefinitions or not									
		;;; this flag is for the dxf codes to determine if block definition has attributes							
		(if
		  	(= attributeDefinitions nil)
		  	(progn
			(setq attributeFlag 0)
			)
		  	(progn
			(setq attributeFlag 1)
			)
		)


		;;; CRITICAL DESIGN DECISION														
		;;; the entmake statments must be wrapped in AND, since the attributes might be present, or they might be nil				
		;;; AND wrap around entity definition statements											
		;;; the key items that are wrapped, involve using enmake	are AND statements 1,3,4						
		;;; 2 does not have to be wrapped for entmake to work, but it matches control flow							
		(AND

		;;; and statement 1, make block entity													
  		(setq entity
			(entmake
				(list
				'(0 . "INSERT")
				'(100 . "AcDbBlockReference")
				(cons  8 layername)
				(cons 66 attributeFlag)	
				(cons  2 blockName)
				(cons 10 blockInsertionPoint)
				(cons 41 1.0)
				(cons 42 1.0)
				(cons 43 1.0)
				)
			)
		)
		
		;;; AND statement 2, determine if attribute loop is entered										
		(if
		  	(/= attributelist nil)
		  	(progn
			(setq attributeCounter 0)
			(setq attributeDefinitions (reverse attributeDefinitions))
			(setq attributeValueLength (length attributelist))
			)
		)

		;;; AND statement 3, add attributes to entity												
		;;; foreach loop for every item in attributeDefinitions											
		(while
			(< attributeCounter attributeValueLength) 

			(setq x (nth attributeCounter attributeDefinitions))
		  	;;;; get first attribute value from the list of them										
			(setq attributevalue (nth attributeCounter attributelist))
	


		  	;;; get 11th dxf code from item x												
		  	;;; these next few lines calculate where the attribute is placed based on the block insertion point				
			(setq attributedxf11 (assoc 11 x))							
			(setq attributeinsertionpoint (cdr attributedxf11))
			(setq attributexcoord (car attributeinsertionpoint))
			(setq attributeycoord (cadr attributeinsertionpoint))
			(setq newxcoord (+ blockxcoord attributexcoord))
			(setq newycoord (+ blockycoord attributeycoord))
			(setq newinsertionpointdxf11 (list newxcoord newycoord))



			;;; get 10th dxf code from item x												
		  	;;; these next few lines calculate where the attribute is placed based on the block insertion point				
			(setq attributedxf10 (assoc 10 x))							
			(setq attributeinsertionpoint (cdr attributedxf10))
			(setq attributexcoord (car attributeinsertionpoint))
			(setq attributeycoord (cadr attributeinsertionpoint))


		 	;;; use the new insertion points to locate the attribute based on where the block is inserted					
			(setq newxcoord (+ blockxcoord attributexcoord))
			(setq newycoord (+ blockycoord attributeycoord))
			(setq newinsertionpointdxf10 (list newxcoord newycoord))


			;;; entmake the attribute with all the information associated with x  								
			(setq attributeEntityDefinition
			  	(entmake										
					(list
					'(0 . "ATTRIB")
					(assoc  8 x)
					(assoc 40 x)
					(cons  1 attributevalue)
					(assoc 50 x)
					(assoc 41 x)
					(assoc 51 x)
					(assoc  7 x)
					(assoc 71 x)
					(assoc 72 x)
					(cons 10 newinsertionpointdxf10)							
					(cons 11 newinsertionpointdxf11)
					(assoc  2 x)
					(assoc 70 x)
					(assoc 73 x)
					(assoc 74 x)
					)
				)
			)

		  	;;; increase counter for next loop												
			(setq attributeCounter (+ attributeCounter 1))
		  
		)
		
		;;; AND statement 4, end block entity													
		;;; end block definition with SEQEND marker												
		(entmake '((0 . "SEQEND")(8 . "0")))

		)
		 
		)
		;;; catch all t conditional														
		(t
			(setq entity nil)
		)

	)
	
	;;; <Return>																	
	(setq returnList entity)	;;; the block entity made with entmake, or nil									
	;;; </Return>																	
																
	
)
