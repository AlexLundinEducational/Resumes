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
		ATTRIBUTEPROPERTYALIGNMENTVALUE ATTRIBUTEPROPERTYAPPLICATIONVALUE ATTRIBUTEPROPERTYBACKWARDVALUE ATTRIBUTEPROPERTYCONSTANTVALUE
		ATTRIBUTEPROPERTYDOCUMENTVALUE ATTRIBUTEPROPERTYENTITYTRANSPARENCYVALUE ATTRIBUTEPROPERTYFIELDLENGTHVALUE ATTRIBUTEPROPERTYHANDLEVALUE
		ATTRIBUTEPROPERTYHASEXTENSIONDICTIONARYVALUE ATTRIBUTEPROPERTYHEIGHTVALUE ATTRIBUTEPROPERTYHYPERLINKSVALUE
		ATTRIBUTEPROPERTYINSERTIONPOINTVALUE ATTRIBUTEPROPERTYINVISIBLEVALUE ATTRIBUTEPROPERTYLAYERVALUE ATTRIBUTEPROPERTYLINETYPESCALEVALUE
		ATTRIBUTEPROPERTYLINETYPEVALUE ATTRIBUTEPROPERTYLINEWEIGHTVALUE ATTRIBUTEPROPERTYLOCKPOSITIONVALUE ATTRIBUTEPROPERTYMATERIALVALUE
		ATTRIBUTEPROPERTYMODEVALUE ATTRIBUTEPROPERTYMTEXTATTRIBUTECONTENTVALUE ATTRIBUTEPROPERTYMTEXTATTRIBUTEVALUE
		ATTRIBUTEPROPERTYMTEXTBOUNDARYWIDTHVALUE ATTRIBUTEPROPERTYMTEXTDRAWINGDIRECTIONVALUE
		ATTRIBUTEPROPERTYNORMALVALUE ATTRIBUTEPROPERTYOBJECTIDVALUE ATTRIBUTEPROPERTYOBJECTNAMEVALUE
		ATTRIBUTEPROPERTYOBLIQUEANGLEVALUE ATTRIBUTEPROPERTYOWNERIDVALUE ATTRIBUTEPROPERTYPLOTSTYLENAMEVALUE ATTRIBUTEPROPERTYPRESETVALUE
		ATTRIBUTEPROPERTYPROMPTSTRINGVALUE ATTRIBUTEPROPERTYROTATIONVALUE ATTRIBUTEPROPERTYSCALEFACTORVALUE ATTRIBUTEPROPERTYSTYLENAMEVALUE
		ATTRIBUTEPROPERTYTAGSTRINGVALUE ATTRIBUTEPROPERTYTEXTALIGNMENTPOINTVALUE ATTRIBUTEPROPERTYTEXTGENERATIONFLAGVALUE
		ATTRIBUTEPROPERTYTEXTSTRINGVALUE ATTRIBUTEPROPERTYTHICKNESSVALUE ATTRIBUTEPROPERTYTRUECOLORVALUE ATTRIBUTEPROPERTYUPSIDEDOWNVALUE
		ATTRIBUTEPROPERTYVERIFYVALUE ATTRIBUTEPROPERTYVISIBLEVALUE ATTRIBUTETOMODIFY BLOCKNAME BLOCKSTODELETE INSERTIONPOINT LINE6 LINE7
		MODELSPACEORPAPER RETURNVALUE ROTATION SELECTIONSET SELECTIONSETCOUNT TRUENAMELIST VLAXFALSE VLAXTRUE XSCALE YSCALE ZSCALE
		CLAYER CTAB STRING
		)       																
 	;;; standard *error* function for Legrand													
 	;;; View the file below for a working example and more in depth notes on how to implement and use it						
 	;;; C:\WS_Blocks\Default\LISP\Lisp Functions\Subfunction Library\DEFAULT-ERROR-HANDLER.LSP							
	(defun *error* ( msg / THECALLINGFUNCTIONSNAME)													
		(setq theCallingFunctionsName "c:ZZ")													
		(DEFAULT-ERROR-HANDLER theCallingFunctionsName msg)											
	)																		
  	;;; c:ZZ function body																

  	(setq clayer (getvar "clayer"))
  	(setq ctab (getvar "ctab"))
  
  	(setvar "ctab" "Model")
  
  	(setq blockName "LMBC-650")
  	(setq insertionPoint nil)
	(setq modelSpaceOrPaper nil)
	(setq rotation nil)
	(setq xscale nil)
	(setq yscale nil)
	(setq zscale nil)
		 
  	(setq returnValue (INSERT-LAYOUT-BLOCK blockName insertionPoint modelSpaceOrPaper rotation xscale yscale zscale))
  	(setq blocksToDelete (cons returnValue blocksToDelete))
  
  	(setq blockName "LMBC-600")
    	(setq returnValue (INSERT-LAYOUT-BLOCK blockName insertionPoint modelSpaceOrPaper rotation xscale yscale zscale))
  	(setq blocksToDelete (cons returnValue blocksToDelete))
  
   	(setq blockName "LMBR-650")
    	(setq returnValue (INSERT-LAYOUT-BLOCK blockName insertionPoint modelSpaceOrPaper rotation xscale yscale zscale))
  	(setq blocksToDelete (cons returnValue blocksToDelete))
  
	(setq subFunctionName "BLOCK-ATTRIBUTE-PROPERTY-MODIFIER")														
																			
	;;; <- here is where you can perform whatever actions are neccessary for your test								
  	(setq SELECTIONSET (ssget "X" (list (cons 0 "INSERT")(cons 8 clayer )(cons 66 1 ))))									
  																			
	;;; selection wireless bridges and routers													
	(setq trueNameList (list "LMBC-650" "LMBC-600" "LMBR-650" "LMBR-600"))										
	(setq SELECTIONSET (SELECTION-WITH-TRUENAME-FILTER SELECTIONSET trueNameList))									
	(setq SELECTIONSETCount (sslength SELECTIONSET))
  


  	(setq autoCADYear (atof (getvar 'AcadVer)))

  	;;; if autocad 2019
  	(if
	  	(>= autoCADYear 23.0)
	  	(progn
		(C:WIPEOUTREMOVEALL)
		)
	)
  	(setq string (getstring "\nShowing PANID text visibile on SEGMENT ATTRIBUTE of LMBC-600 series blocks. (Press enter)"))
  
	;;; attributeTag to be Searched															
  	(setq ATTRIBUTETOMODIFY "SEGMENT") 														
  	(setq vlaxFalse :vlax-false)															
	(setq vlaxTrue :vlax-true)																														
																			
	;;; these variables will be used as VALUES in the symbol type variables later									
	(setq attributePropertyAlignmentValue nil)													
  	(setq attributePropertyApplicationValue nil)													
  	(setq attributePropertyBackwardValue nil)													
  	(setq attributePropertyConstantValue nil)													
  	(setq attributePropertyDocumentValue nil)													
  	(setq attributePropertyEntityTransparencyValue nil)												
  	(setq attributePropertyFieldLengthValue nil)													
  	(setq attributePropertyHandleValue nil)														
  	(setq attributePropertyHasExtensionDictionaryValue nil)												
  	(setq attributePropertyHeightValue nil)														
  	(setq attributePropertyHyperlinksValue nil)													
  	(setq attributePropertyInsertionPointValue nil)													
	(setq attributePropertyInvisibleValue vlaxTrue)													
	(setq attributePropertyLayerValue nil)														
	(setq attributePropertyLinetypeValue nil)													
	(setq attributePropertyLinetypeValue nil)													
	(setq attributePropertyLinetypeScaleValue nil)													
	(setq attributePropertyLineweightValue nil)													
	(setq attributePropertyLockPositionValue nil)													
	(setq attributePropertyMaterialValue nil)													
	(setq attributePropertyModeValue nil)														
	(setq attributePropertyMTextAttributeValue nil)													
	(setq attributePropertyMTextAttributeContentValue nil)												
	(setq attributePropertyMTextBoundaryWidthValue nil)												
	(setq attributePropertyMTextDrawingDirectionValue nil)												
	(setq attributePropertyNormalValue nil)														
	(setq attributePropertyObjectIDValue nil)													
	(setq attributePropertyObjectNameValue nil)													
	(setq attributePropertyObliqueAngleValue nil)													
	(setq attributePropertyOwnerIDValue nil)													
	(setq attributePropertyPlotStyleNameValue nil)													
	(setq attributePropertyPresetValue nil)														
	(setq attributePropertyPromptStringValue nil)													
	(setq attributePropertyRotationValue nil)													
	(setq attributePropertyScaleFactorValue nil)													
	(setq attributePropertyStyleNameValue nil)													
	(setq attributePropertyTagStringValue nil)													
	(setq attributePropertyTextAlignmentPointValue nil)												
	(setq attributePropertyTextGenerationFlagValue nil)												
	(setq attributePropertyTextStringValue nil)													
	(setq attributePropertyThicknessValue nil)													
	(setq attributePropertyTrueColorValue nil)													
	(setq attributePropertyUpsideDownValue nil)													
	(setq attributePropertyVerifyValue nil)														
	(setq attributePropertyVisibleValue vlaxFalse)													

  
	(BLOCK-ATTRIBUTE-PROPERTY-MODIFIER ATTRIBUTEPROPERTYALIGNMENTVALUE ATTRIBUTEPROPERTYAPPLICATIONVALUE ATTRIBUTEPROPERTYBACKWARDVALUE ATTRIBUTEPROPERTYCONSTANTVALUE ATTRIBUTEPROPERTYDOCUMENTVALUE ATTRIBUTEPROPERTYENTITYTRANSPARENCYVALUE ATTRIBUTEPROPERTYFIELDLENGTHVALUE ATTRIBUTEPROPERTYHANDLEVALUE ATTRIBUTEPROPERTYHASEXTENSIONDICTIONARYVALUE ATTRIBUTEPROPERTYHEIGHTVALUE ATTRIBUTEPROPERTYHYPERLINKSVALUE ATTRIBUTEPROPERTYINSERTIONPOINTVALUE ATTRIBUTEPROPERTYINVISIBLEVALUE ATTRIBUTEPROPERTYLAYERVALUE ATTRIBUTEPROPERTYLINETYPESCALEVALUE ATTRIBUTEPROPERTYLINETYPEVALUE ATTRIBUTEPROPERTYLINEWEIGHTVALUE ATTRIBUTEPROPERTYLOCKPOSITIONVALUE ATTRIBUTEPROPERTYMATERIALVALUE ATTRIBUTEPROPERTYMODEVALUE ATTRIBUTEPROPERTYMTEXTATTRIBUTECONTENTVALUE ATTRIBUTEPROPERTYMTEXTATTRIBUTEVALUE ATTRIBUTEPROPERTYMTEXTBOUNDARYWIDTHVALUE ATTRIBUTEPROPERTYMTEXTDRAWINGDIRECTIONVALUE ATTRIBUTEPROPERTYNORMALVALUE ATTRIBUTEPROPERTYOBJECTIDVALUE ATTRIBUTEPROPERTYOBJECTNAMEVALUE ATTRIBUTEPROPERTYOBLIQUEANGLEVALUE ATTRIBUTEPROPERTYOWNERIDVALUE ATTRIBUTEPROPERTYPLOTSTYLENAMEVALUE ATTRIBUTEPROPERTYPRESETVALUE ATTRIBUTEPROPERTYPROMPTSTRINGVALUE ATTRIBUTEPROPERTYROTATIONVALUE ATTRIBUTEPROPERTYSCALEFACTORVALUE ATTRIBUTEPROPERTYSTYLENAMEVALUE ATTRIBUTEPROPERTYTAGSTRINGVALUE ATTRIBUTEPROPERTYTEXTALIGNMENTPOINTVALUE ATTRIBUTEPROPERTYTEXTGENERATIONFLAGVALUE ATTRIBUTEPROPERTYTEXTSTRINGVALUE ATTRIBUTEPROPERTYTHICKNESSVALUE ATTRIBUTEPROPERTYTRUECOLORVALUE ATTRIBUTEPROPERTYUPSIDEDOWNVALUE ATTRIBUTEPROPERTYVERIFYVALUE ATTRIBUTEPROPERTYVISIBLEVALUE ATTRIBUTETOMODIFY SELECTIONSET)																		
	
	
	;;; each test output data list must start with either a pass or fail flag
	(setq passFlag "T")
	(setq failFlag "F")
	
	;;; test 1																	
  	;;; document why this test exists														
	;;; include valid reasons in your output data so the test is useful for regression tests							
  	(setq line1 "\nTest 1 Passed")															
  	(setq line2 "\n\tReason is validate selection passed")
  	(setq dataLines1 (list line1 line2))
  	(setq test1OutputData (list passFlag dataLines1))		
																																						
	

  	(setq SELECTIONSET nil)
  	(BLOCK-ATTRIBUTE-PROPERTY-MODIFIER ATTRIBUTEPROPERTYALIGNMENTVALUE ATTRIBUTEPROPERTYAPPLICATIONVALUE ATTRIBUTEPROPERTYBACKWARDVALUE ATTRIBUTEPROPERTYCONSTANTVALUE ATTRIBUTEPROPERTYDOCUMENTVALUE ATTRIBUTEPROPERTYENTITYTRANSPARENCYVALUE ATTRIBUTEPROPERTYFIELDLENGTHVALUE ATTRIBUTEPROPERTYHANDLEVALUE ATTRIBUTEPROPERTYHASEXTENSIONDICTIONARYVALUE ATTRIBUTEPROPERTYHEIGHTVALUE ATTRIBUTEPROPERTYHYPERLINKSVALUE ATTRIBUTEPROPERTYINSERTIONPOINTVALUE ATTRIBUTEPROPERTYINVISIBLEVALUE ATTRIBUTEPROPERTYLAYERVALUE ATTRIBUTEPROPERTYLINETYPESCALEVALUE ATTRIBUTEPROPERTYLINETYPEVALUE ATTRIBUTEPROPERTYLINEWEIGHTVALUE ATTRIBUTEPROPERTYLOCKPOSITIONVALUE ATTRIBUTEPROPERTYMATERIALVALUE ATTRIBUTEPROPERTYMODEVALUE ATTRIBUTEPROPERTYMTEXTATTRIBUTECONTENTVALUE ATTRIBUTEPROPERTYMTEXTATTRIBUTEVALUE ATTRIBUTEPROPERTYMTEXTBOUNDARYWIDTHVALUE ATTRIBUTEPROPERTYMTEXTDRAWINGDIRECTIONVALUE ATTRIBUTEPROPERTYNORMALVALUE ATTRIBUTEPROPERTYOBJECTIDVALUE ATTRIBUTEPROPERTYOBJECTNAMEVALUE ATTRIBUTEPROPERTYOBLIQUEANGLEVALUE ATTRIBUTEPROPERTYOWNERIDVALUE ATTRIBUTEPROPERTYPLOTSTYLENAMEVALUE ATTRIBUTEPROPERTYPRESETVALUE ATTRIBUTEPROPERTYPROMPTSTRINGVALUE ATTRIBUTEPROPERTYROTATIONVALUE ATTRIBUTEPROPERTYSCALEFACTORVALUE ATTRIBUTEPROPERTYSTYLENAMEVALUE ATTRIBUTEPROPERTYTAGSTRINGVALUE ATTRIBUTEPROPERTYTEXTALIGNMENTPOINTVALUE ATTRIBUTEPROPERTYTEXTGENERATIONFLAGVALUE ATTRIBUTEPROPERTYTEXTSTRINGVALUE ATTRIBUTEPROPERTYTHICKNESSVALUE ATTRIBUTEPROPERTYTRUECOLORVALUE ATTRIBUTEPROPERTYUPSIDEDOWNVALUE ATTRIBUTEPROPERTYVERIFYVALUE ATTRIBUTEPROPERTYVISIBLEVALUE ATTRIBUTETOMODIFY SELECTIONSET)

  	;;; test 2																	
  	;;; document why this test exists														
	;;; include valid reasons in your output data so the test is useful for regression tests							
	(setq line3 "\nTest 2 Passed")															
  	(setq line4 "\n\tReason is invalid selection set passed")
  	(setq dataLines2 (list line1 line2))
	(setq test2OutputData (list passFlag dataLines2))


  	(setq ATTRIBUTETOMODIFY "INVALID-ATTRIBUTE") 
  	(BLOCK-ATTRIBUTE-PROPERTY-MODIFIER ATTRIBUTEPROPERTYALIGNMENTVALUE ATTRIBUTEPROPERTYAPPLICATIONVALUE ATTRIBUTEPROPERTYBACKWARDVALUE ATTRIBUTEPROPERTYCONSTANTVALUE ATTRIBUTEPROPERTYDOCUMENTVALUE ATTRIBUTEPROPERTYENTITYTRANSPARENCYVALUE ATTRIBUTEPROPERTYFIELDLENGTHVALUE ATTRIBUTEPROPERTYHANDLEVALUE ATTRIBUTEPROPERTYHASEXTENSIONDICTIONARYVALUE ATTRIBUTEPROPERTYHEIGHTVALUE ATTRIBUTEPROPERTYHYPERLINKSVALUE ATTRIBUTEPROPERTYINSERTIONPOINTVALUE ATTRIBUTEPROPERTYINVISIBLEVALUE ATTRIBUTEPROPERTYLAYERVALUE ATTRIBUTEPROPERTYLINETYPESCALEVALUE ATTRIBUTEPROPERTYLINETYPEVALUE ATTRIBUTEPROPERTYLINEWEIGHTVALUE ATTRIBUTEPROPERTYLOCKPOSITIONVALUE ATTRIBUTEPROPERTYMATERIALVALUE ATTRIBUTEPROPERTYMODEVALUE ATTRIBUTEPROPERTYMTEXTATTRIBUTECONTENTVALUE ATTRIBUTEPROPERTYMTEXTATTRIBUTEVALUE ATTRIBUTEPROPERTYMTEXTBOUNDARYWIDTHVALUE ATTRIBUTEPROPERTYMTEXTDRAWINGDIRECTIONVALUE ATTRIBUTEPROPERTYNORMALVALUE ATTRIBUTEPROPERTYOBJECTIDVALUE ATTRIBUTEPROPERTYOBJECTNAMEVALUE ATTRIBUTEPROPERTYOBLIQUEANGLEVALUE ATTRIBUTEPROPERTYOWNERIDVALUE ATTRIBUTEPROPERTYPLOTSTYLENAMEVALUE ATTRIBUTEPROPERTYPRESETVALUE ATTRIBUTEPROPERTYPROMPTSTRINGVALUE ATTRIBUTEPROPERTYROTATIONVALUE ATTRIBUTEPROPERTYSCALEFACTORVALUE ATTRIBUTEPROPERTYSTYLENAMEVALUE ATTRIBUTEPROPERTYTAGSTRINGVALUE ATTRIBUTEPROPERTYTEXTALIGNMENTPOINTVALUE ATTRIBUTEPROPERTYTEXTGENERATIONFLAGVALUE ATTRIBUTEPROPERTYTEXTSTRINGVALUE ATTRIBUTEPROPERTYTHICKNESSVALUE ATTRIBUTEPROPERTYTRUECOLORVALUE ATTRIBUTEPROPERTYUPSIDEDOWNVALUE ATTRIBUTEPROPERTYVERIFYVALUE ATTRIBUTEPROPERTYVISIBLEVALUE ATTRIBUTETOMODIFY SELECTIONSET)
  
  	;;; test 3																	
  	;;; document why this test exists														
	;;; include valid reasons in your output data so the test is useful for regression tests							
  	(setq line5 "\nTest 3 Passed")															
  	(setq line6 "\n\tReason is invalid attribute passed")
  	(setq dataLines3 (list line5 line6))
  	(setq test3OutputData (list passFlag dataLines3))

  	;;; cleanup and show user test results														
	(setq string (getstring "\nIs PANID text visibile on LMBC-600 series blocks? (Type enter if no, because test passed)"))
  
	(foreach
		block blocksToDelete
	  	(vla-delete block)
	)
  
  	(setvar "ctab" ctab)
  
    	;;; store as many lines to outputdata as you need to make it clear what your tests did								
	(setq OUTPUTDATA (list test1OutputData test2OutputData test3OutputData))

  
	;;; Return																	
	(setq returnList OUTPUTDATA)	;;; list of data containing test output information, ready for writing to log file				
																			
)																			
;;; </ZZ-example>																	
;;;-----------------------------------------------------------------------------------------------------------------------------------------------------
;;; <Subfunction Name> 																	
;;; BLOCK-ATTRIBUTE-PROPERTY-MODIFIER 															
;;; </Subfunction Name>																	
;;; <Developer Notes>																	
;;; Alex Lundin																		
;;; 09-12-2018																		
;;; </Developer Notes>																	
(defun BLOCK-ATTRIBUTE-PROPERTY-MODIFIER
       		(
		;;; <Arguments>		
		ATTRIBUTEPROPERTYALIGNMENTVALUE 		;;; - beginning of values, can be nil or value		
		ATTRIBUTEPROPERTYAPPLICATIONVALUE 		;;; - ...						
		ATTRIBUTEPROPERTYBACKWARDVALUE 			;;; - ...						
		ATTRIBUTEPROPERTYCONSTANTVALUE 			;;; - ...						
		ATTRIBUTEPROPERTYDOCUMENTVALUE 			;;; - ...						
		ATTRIBUTEPROPERTYENTITYTRANSPARENCYVALUE 	;;; - ...						
		ATTRIBUTEPROPERTYFIELDLENGTHVALUE 		;;; - ...						
		ATTRIBUTEPROPERTYHANDLEVALUE 			;;; - ...						
		ATTRIBUTEPROPERTYHASEXTENSIONDICTIONARYVALUE 	;;; - ...						
		ATTRIBUTEPROPERTYHEIGHTVALUE 			;;; - ...						
		ATTRIBUTEPROPERTYHYPERLINKSVALUE 		;;; - ...						
		ATTRIBUTEPROPERTYINSERTIONPOINTVALUE 		;;; - ...						
		ATTRIBUTEPROPERTYINVISIBLEVALUE 		;;; - ...						
		ATTRIBUTEPROPERTYLAYERVALUE 			;;; - ...						
		ATTRIBUTEPROPERTYLINETYPESCALEVALUE 		;;; - ...						
		ATTRIBUTEPROPERTYLINETYPEVALUE 			;;; - ...						
		ATTRIBUTEPROPERTYLINEWEIGHTVALUE 		;;; - ...						
		ATTRIBUTEPROPERTYLOCKPOSITIONVALUE 		;;; - ...						
		ATTRIBUTEPROPERTYMATERIALVALUE 			;;; - ...						
		ATTRIBUTEPROPERTYMODEVALUE 			;;; - ...						
		ATTRIBUTEPROPERTYMTEXTATTRIBUTECONTENTVALUE 	;;; - ...						
		ATTRIBUTEPROPERTYMTEXTATTRIBUTEVALUE 		;;; - ...						
		ATTRIBUTEPROPERTYMTEXTBOUNDARYWIDTHVALUE 	;;; - ...						
		ATTRIBUTEPROPERTYMTEXTDRAWINGDIRECTIONVALUE 	;;; - ...						
		ATTRIBUTEPROPERTYNORMALVALUE 			;;; - ...						
		ATTRIBUTEPROPERTYOBJECTIDVALUE 			;;; - ...						
		ATTRIBUTEPROPERTYOBJECTNAMEVALUE 		;;; - ...						
		ATTRIBUTEPROPERTYOBLIQUEANGLEVALUE 		;;; - ...						
		ATTRIBUTEPROPERTYOWNERIDVALUE 			;;; - ...						
		ATTRIBUTEPROPERTYPLOTSTYLENAMEVALUE 		;;; - ...						
		ATTRIBUTEPROPERTYPRESETVALUE 			;;; - ...						
		ATTRIBUTEPROPERTYPROMPTSTRINGVALUE 		;;; - ...						
		ATTRIBUTEPROPERTYROTATIONVALUE 			;;; - ...						
		ATTRIBUTEPROPERTYSCALEFACTORVALUE 		;;; - ...						
		ATTRIBUTEPROPERTYSTYLENAMEVALUE 		;;; - ...						
		ATTRIBUTEPROPERTYTAGSTRINGVALUE 		;;; - ...						
		ATTRIBUTEPROPERTYTEXTALIGNMENTPOINTVALUE 	;;; - ...						
		ATTRIBUTEPROPERTYTEXTGENERATIONFLAGVALUE 	;;; - ...						
		ATTRIBUTEPROPERTYTEXTSTRINGVALUE 		;;; - ...						
		ATTRIBUTEPROPERTYTHICKNESSVALUE 		;;; - ...						
		ATTRIBUTEPROPERTYTRUECOLORVALUE 		;;; - ...						
		ATTRIBUTEPROPERTYUPSIDEDOWNVALUE 		;;; - ...						
		ATTRIBUTEPROPERTYVERIFYVALUE 			;;; - ...						
		ATTRIBUTEPROPERTYVISIBLEVALUE 			;;; - end of values, can be nil or value		
		ATTRIBUTETOMODIFY				;;; - name of attribute					
		SELECTIONSET					;;; - valid selection set				
		;;; </Arguments>											
		/
		;;; local variables	
		*ERROR*
		*ACTIVE-DOCUMENT* ATTRIBUTEPROPERTYALIGNMENTSYMBOL ATTRIBUTEPROPERTYAPPLICATIONSYMBOL ATTRIBUTEPROPERTYBACKWARDSYMBOL ATTRIBUTEPROPERTYCONSTANTSYMBOL ATTRIBUTEPROPERTYDOCUMENTSYMBOL ATTRIBUTEPROPERTYENTITYTRANSPARENCYSYMBOL ATTRIBUTEPROPERTYFIELDLENGTHSYMBOL ATTRIBUTEPROPERTYHANDLESYMBOL ATTRIBUTEPROPERTYHASEXTENSIONDICTIONARYSYMBOL ATTRIBUTEPROPERTYHEIGHTSYMBOL ATTRIBUTEPROPERTYHYPERLINKSSYMBOL ATTRIBUTEPROPERTYINSERTIONPOINTSYMBOL ATTRIBUTEPROPERTYINVISIBLESYMBOL ATTRIBUTEPROPERTYLAYERSYMBOL ATTRIBUTEPROPERTYLINETYPESCALESYMBOL ATTRIBUTEPROPERTYLINETYPESYMBOL ATTRIBUTEPROPERTYLINEWEIGHTSYMBOL ATTRIBUTEPROPERTYLOCKPOSITIONSYMBOL ATTRIBUTEPROPERTYMATERIALSYMBOL ATTRIBUTEPROPERTYMODESYMBOL ATTRIBUTEPROPERTYMTEXTATTRIBUTECONTENTSYMBOL ATTRIBUTEPROPERTYMTEXTATTRIBUTESYMBOL ATTRIBUTEPROPERTYMTEXTBOUNDARYWIDTHSYMBOL ATTRIBUTEPROPERTYMTEXTDRAWINGDIRECTIONSYMBOL ATTRIBUTEPROPERTYNORMALSYMBOL ATTRIBUTEPROPERTYOBJECTIDSYMBOL ATTRIBUTEPROPERTYOBJECTNAMESYMBOL ATTRIBUTEPROPERTYOBLIQUEANGLESYMBOL ATTRIBUTEPROPERTYOWNERIDSYMBOL ATTRIBUTEPROPERTYPLOTSTYLENAMESYMBOL ATTRIBUTEPROPERTYPRESETSYMBOL ATTRIBUTEPROPERTYPROMPTSTRINGSYMBOL ATTRIBUTEPROPERTYROTATIONSYMBOL ATTRIBUTEPROPERTYSCALEFACTORSYMBOL ATTRIBUTEPROPERTYSTYLENAMESYMBOL ATTRIBUTEPROPERTYTAGSTRINGSYMBOL ATTRIBUTEPROPERTYTEXTALIGNMENTPOINTSYMBOL ATTRIBUTEPROPERTYTEXTGENERATIONFLAGSYMBOL ATTRIBUTEPROPERTYTEXTSTRINGSYMBOL ATTRIBUTEPROPERTYTHICKNESSSYMBOL ATTRIBUTEPROPERTYTRUECOLORSYMBOL ATTRIBUTEPROPERTYUPSIDEDOWNSYMBOL ATTRIBUTEPROPERTYVERIFYSYMBOL ATTRIBUTEPROPERTYVISIBLESYMBOL PROPERTYOBJECTFROMBLOCK PROPERTYSYMBOLNAME PROPERTYSYMBOLVALUE SEL SS SYMBOLLIST VLASELECTIONSET
		)


;;; Standard *error* function for Legrand														
;;; View the file below for a working example and more in depth notes on how to implement and use it							
;;; C:\WS_Blocks\Default\LISP\Lisp Functions\Subfunction Library\DEFAULT-ERROR-HANDLER.LSP								
	(defun *error* ( msg / THECALLINGFUNCTIONSNAME)

		(setq theCallingFunctionsName "BLOCK-ATTRIBUTE-PROPERTY-MODIFIER")
		(DEFAULT-ERROR-HANDLER theCallingFunctionsName msg)
	)

;;; function body																	

	;;; keep only one return block listed below
	

	(if
	  	(/= SELECTIONSET nil)
	  	(progn
	  	(setq *active-document* (vla-get-activedocument (vlax-get-acad-object)))
		(setq vlaSelectionSet (vla-get-activeselectionset *active-document*))
		)
	)
  
  	;;; create all symbols for every possible attribute property with the values passed in as arguments						
	(setq attributePropertyAlignmentSymbol 'Alignment)
	(set attributePropertyAlignmentSymbol attributePropertyAlignmentValue)
	(setq attributePropertyApplicationSymbol 'Application)
	(set attributePropertyApplicationSymbol attributePropertyApplicationValue)
	(setq attributePropertyBackwardSymbol 'Backward)
	(set attributePropertyBackwardSymbol attributePropertyBackwardValue)
	(setq attributePropertyConstantSymbol 'Constant)
	(set attributePropertyConstantSymbol attributePropertyConstantValue)
	(setq attributePropertyDocumentSymbol 'Document)
	(set attributePropertyDocumentSymbol attributePropertyDocumentValue)
	(setq attributePropertyEntityTransparencySymbol 'EntityTransparency)
	(set attributePropertyEntityTransparencySymbol attributePropertyEntityTransparencyValue)
	(setq attributePropertyFieldLengthSymbol 'FieldLength)
	(set attributePropertyFieldLengthSymbol attributePropertyFieldLengthValue)
	(setq attributePropertyHandleSymbol 'Handle)
	(set attributePropertyHandleSymbol attributePropertyHandleValue)
	(setq attributePropertyHasExtensionDictionarySymbol 'HasExtensionDictionary)
	(set attributePropertyHasExtensionDictionarySymbol attributePropertyHasExtensionDictionaryValue)
	(setq attributePropertyHeightSymbol 'Height)
	(set attributePropertyHeightSymbol attributePropertyHeightValue)
	(setq attributePropertyHyperlinksSymbol 'Hyperlinks)
	(set attributePropertyHyperlinksSymbol attributePropertyHyperlinksValue)
	(setq attributePropertyInsertionPointSymbol 'InsertionPoint)
	
	(set attributePropertyInsertionPointSymbol attributePropertyInsertionPointValue)
	(setq attributePropertyInvisibleSymbol 'Invisible)
	
	(set attributePropertyInvisibleSymbol attributePropertyInvisibleValue)
	(setq attributePropertyLayerSymbol 'Layer)
	
	(set attributePropertyLayerSymbol attributePropertyLayerValue)
	(setq attributePropertyLinetypeSymbol 'Linetype)
	
	(set attributePropertyLinetypeSymbol attributePropertyLinetypeValue)
	(setq attributePropertyLinetypeScaleSymbol 'LinetypeScale)
	
	(set attributePropertyLinetypeScaleSymbol attributePropertyLinetypeScaleValue)
	(setq attributePropertyLineweightSymbol 'Lineweight)
	
	(set attributePropertyLineweightSymbol attributePropertyLineweightValue)
	(setq attributePropertyLockPositionSymbol 'LockPosition)
	
	(set attributePropertyLockPositionSymbol attributePropertyLockPositionValue)
	(setq attributePropertyMaterialSymbol 'Material)
	
	(set attributePropertyMaterialSymbol attributePropertyMaterialValue)
	(setq attributePropertyModeSymbol 'Mode)
	
	(set attributePropertyModeSymbol attributePropertyModeValue)
	(setq attributePropertyMTextAttributeSymbol 'MTextAttribute)
	
	(set attributePropertyMTextAttributeSymbol attributePropertyMTextAttributeValue)
	(setq attributePropertyMTextAttributeContentSymbol 'MTextAttributeContent)
	
	(set attributePropertyMTextAttributeContentSymbol attributePropertyMTextAttributeContentValue)
	(setq attributePropertyMTextBoundaryWidthSymbol 'MTextBoundaryWidth)
	
	(set attributePropertyMTextBoundaryWidthSymbol attributePropertyMTextBoundaryWidthValue)
	(setq attributePropertyMTextDrawingDirectionSymbol 'MTextDrawingDirection)
	
	(set attributePropertyMTextDrawingDirectionSymbol attributePropertyMTextDrawingDirectionValue)
	(setq attributePropertyNormalSymbol 'Normal)
	
	(set attributePropertyNormalSymbol attributePropertyNormalValue)
	(setq attributePropertyObjectIDSymbol 'ObjectID)
	
	(set attributePropertyObjectIDSymbol attributePropertyObjectIDValue)
	(setq attributePropertyObjectNameSymbol 'ObjectName)
	
	(set attributePropertyObjectNameSymbol attributePropertyObjectNameValue)
	(setq attributePropertyObliqueAngleSymbol 'ObliqueAngle)
	
	(set attributePropertyObliqueAngleSymbol attributePropertyObliqueAngleValue)
	(setq attributePropertyOwnerIDSymbol 'OwnerID)
	
	(set attributePropertyOwnerIDSymbol attributePropertyOwnerIDValue)
	(setq attributePropertyPlotStyleNameSymbol 'PlotStyleName)
	
	(set attributePropertyPlotStyleNameSymbol attributePropertyPlotStyleNameValue)
	(setq attributePropertyPresetSymbol 'Preset)
	
	(set attributePropertyPresetSymbol attributePropertyPresetValue)
	(setq attributePropertyPromptStringSymbol 'PromptString)
	
	(set attributePropertyPromptStringSymbol attributePropertyPromptStringValue)
	(setq attributePropertyRotationSymbol 'Rotation)
	
	(set attributePropertyRotationSymbol attributePropertyRotationValue)
	(setq attributePropertyScaleFactorSymbol 'ScaleFactor)
	
	(set attributePropertyScaleFactorSymbol attributePropertyScaleFactorValue)
	(setq attributePropertyStyleNameSymbol 'StyleName)
	
	(set attributePropertyStyleNameSymbol attributePropertyStyleNameValue)
	(setq attributePropertyTagStringSymbol 'TagString)
	
	(set attributePropertyTagStringSymbol attributePropertyTagStringValue)
	(setq attributePropertyTextAlignmentPointSymbol 'TextAlignmentPoint)
	
	(set attributePropertyTextAlignmentPointSymbol attributePropertyTextAlignmentPointValue)
	(setq attributePropertyTextGenerationFlagSymbol 'TextGenerationFlag)
	
	(set attributePropertyTextGenerationFlagSymbol attributePropertyTextGenerationFlagValue)
	(setq attributePropertyTextStringSymbol 'TextString)
	
	(set attributePropertyTextStringSymbol attributePropertyTextStringValue)
	(setq attributePropertyThicknessSymbol 'Thickness)
	
	(set attributePropertyThicknessSymbol attributePropertyThicknessValue)
	(setq attributePropertyTrueColorSymbol 'TrueColor)
	
	(set attributePropertyTrueColorSymbol attributePropertyTrueColorValue)
	(setq attributePropertyUpsideDownSymbol 'UpsideDown)
	
	(set attributePropertyUpsideDownSymbol attributePropertyUpsideDownValue)
	(setq attributePropertyVerifySymbol 'Verify)
	
	(set attributePropertyVerifySymbol attributePropertyVerifyValue)
	(setq attributePropertyVisibleSymbol 'Visible)
	
	(set attributePropertyVisibleSymbol attributePropertyVisibleValue)
	(setq SymbolList (list attributePropertyAlignmentSymbol attributePropertyApplicationSymbol attributePropertyBackwardSymbol attributePropertyConstantSymbol attributePropertyDocumentSymbol attributePropertyEntityTransparencySymbol attributePropertyFieldLengthSymbol attributePropertyHandleSymbol attributePropertyHasExtensionDictionarySymbol attributePropertyHeightSymbol attributePropertyHyperlinksSymbol attributePropertyInsertionPointSymbol attributePropertyInvisibleSymbol attributePropertyLayerSymbol attributePropertyLinetypeSymbol attributePropertyLinetypeScaleSymbol attributePropertyLineweightSymbol attributePropertyLockPositionSymbol attributePropertyMaterialSymbol attributePropertyMTextAttributeSymbol attributePropertyMTextAttributeContentSymbol attributePropertyMTextBoundaryWidthSymbol attributePropertyMTextDrawingDirectionSymbol attributePropertyNormalSymbol attributePropertyObjectIDSymbol attributePropertyObjectNameSymbol attributePropertyObliqueAngleSymbol attributePropertyOwnerIDSymbol attributePropertyPlotStyleNameSymbol attributePropertyRotationSymbol attributePropertyScaleFactorSymbol attributePropertyStyleNameSymbol attributePropertyTagStringSymbol attributePropertyTextAlignmentPointSymbol attributePropertyTextGenerationFlagSymbol attributePropertyTextStringSymbol attributePropertyThicknessSymbol attributePropertyTrueColorSymbol attributePropertyUpsideDownSymbol attributePropertyVisibleSymbol))
  
	(setq ss (ssget "_X" '((0 . "INSERT") (66 . 1))))
  
 	;;; compound AND conditional with 3 conditions					
  	;;; 1 selection set argument must be valid					
	;;; 2 there must be attribute blocks in the drawing				
	;;; 3 there must be objects in the drawing document 				
  	(if
	  	(AND
		(/= SELECTIONSET nil)
	  	(/= ss nil)
		(/= vlaSelectionSet nil)
		)
	  	(progn

		;;; loop over vlaSelectionSet storing each item in obj			
		(vlax-for Obj vlaSelectionSet
			;;; loop over all attributes in obj				
			(foreach attributeObject (append (vlax-invoke Obj 'GetAttributes) (vlax-invoke Obj 'GetConstantAttributes))

			   ;;; check if the attribute matches the argument sent in	
			   (if 
					(eq attributeToModify (strcase (vla-get-TagString attributeObject)))
					(progn
					;;; on a match					
					;;; loop through each symbol in the symbolList	
					(foreach propertySymbol symbolList
						(setq propertySymbolValue (vl-symbol-value propertySymbol))
						(setq propertySymbolName (vl-symbol-name propertySymbol))
					  	;;; if the symbolvalue is not nil	
						;;; set it to the new value		
					  	(if
						  	(/= propertySymbolValue nil)
						  	(progn
							(setq propertyObjectFromBlock (vlax-get-property attributeObject (vl-symbol-name propertySymbol)))
							(vlax-put-property attributeObject propertySymbolName propertySymbolValue)
							)
						)
					  	
					)
					
					)

				)
			)
		)


		)
	)

	(princ)

  	;;; <Return>	
	;;; none 	
	;;; </Return>	
)