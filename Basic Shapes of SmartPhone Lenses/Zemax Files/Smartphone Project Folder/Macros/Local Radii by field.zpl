# Compute an array of local radii and angles of incidence
# Broken down by field and surface

# Mark Nicholson, San Diego, May 2023

TIMER

GOSUB Initialize #Initialize all arrays and variables

FOR i_field, 1, num_fields + 1, 1 #Loop over field. i_field is an integer counter for each field step
	FOR surface, 1, NSUR(), 1	  #Loop over surfaces, which is already an integer
		GOSUB GetData
	NEXT surface
NEXT i_field

GOSUB PrintData 		# Print the data

OUTPUT SCREEN
SHOWFILE outfile$, 1 #save the file after displaying it
PRINT "Program End"
PRINT "Elapsed time: ", ETIM(), " seconds"
END

SUB Initialize 	# Initialize all the variables required by the macro
debug = 0  		# Set to zero to suppress tracking print statements

path$ = $PATHNAME() 	#Get the path the current file
outfile$ = path$ + "\Local Radii by Field Angle.txt"
OUTPUT outfile$
IF (debug) THEN PRINT "Initializing Variables ", ETIM(), " Seconds"

	# Ray Tracing variables
	hx = 0
	hy= 0
	Px = 0
	Py = 0
	primary = PWAV()
	maxfield = MAXF()
	infinity = 1e10 	# Used to prevent 1/0 errors for flat surfaces
	space$ = "     " 	# Used for formatting printing

	# Data Array
	num_fields = 10 	# Integer number of desired fractional field datapoints               
	DECLARE LOCALDATA, DOUBLE, 3, num_fields + 1, NSUR(), 2
	# Array indices are integer field points and surface number
	# Stored data are local_radi and angle of incidence
	# local_radi are LOCALDATA(field, surface, 1)
	# local_aoi are LOCALDATA(field, surface, 2)
	# increase third dimension when more data is needed
	
	FOR i_field, 1, num_fields, 1
		FOR surface, 1, NSUR(), 1
			LOCALDATA(i_field, surface, 1) = infinity	#set all radii to infinity
			LOCALDATA(i_field, surface, 2) = 0 			#set all aoi to zero
		NEXT surface
	NEXT i_field

	! Setup SCUR operand data
	operand_SCUR = OCOD("SCUR")
	SCUR_Ydata = 5 # Get Y curvature
	
	! Set up RAID operand
	operand_RAID = OCOD("RAID")
	
	unused = 0 #Used for operand list data items that are not used

IF (debug) THEN PRINT "Finished Initializing ", ETIM(), " seconds"
RETURN
#####################################################

SUB GetData #Trace rays and fill the LOCALDATA array

	hy = (i_field - 1)/num_fields
	RAYTRACE hx, hy, px, py, primary
	IF (RAYE()) THEN PRINT "A Ray Trace error occurred, code = ", RAYE()	
	x = RAYX(surface) #Get ray data on specified surface 
	y = RAYY(surface)
	local_curv = OPEV(operand_SCUR, surface, unused, x, y, SCUR_Ydata, unused)
	
	IF (ABSO(local_curv)<1e-6)
		LOCALDATA(i_field, surface, 1) = infinity
	ELSE
		LOCALDATA(i_field, surface, 1) = 1/local_curv
	ENDIF

	# Now get the ray angle of incidence in degrees	
	LOCALDATA(i_field, surface, 2) = OPEV(operand_RAID, surface, primary, hx, hy, px, py)
	
RETURN
######################################################

SUB PrintData
IF (debug) THEN PRINT "Entered Printing Block ", ETIM(), " seconds"

# Print table header
PRINT "Local Surface Radius of Curvature by chief ray from fractional field"
PRINT
PRINT
FORMAT 3 INT
PRINT "Surface ",space$,
FORMAT 5.3
FOR i = 1, num_fields + 1, 1
	hy = (i - 1)/num_fields
	PRINT hy, space$, "   ",
NEXT i
PRINT "Surface ",space$,"Surface Comment"
PRINT "------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"

FOR surface = 1, NSUR(), 1
	FORMAT 3 INT
	PRINT Surface, space$,space$,
	FORMAT 5.3
	# LOCALDATA(field, surface, data)
	# data = 1 local_roc
	# data = 2 aoi
	FOR i=1, num_fields + 1, 1
	
		local_roc = LOCALDATA(i, surface, 1)
		
		IF (local_roc == infinity)
			PRINT "Infinity", space$,
		ELSE
			IF(local_roc > 0) THEN PRINT " ",
			PRINT local_roc, space$,"  ",
		ENDIF	

	NEXT i
	FORMAT 3 INT
	PRINT Surface, space$, $COMMENT(Surface)
	FORMAT 5.3
NEXT Surface

IF (debug) THEN PRINT "Finished Printing ", ETIM(), " seconds"
RETURN
#########################################################
