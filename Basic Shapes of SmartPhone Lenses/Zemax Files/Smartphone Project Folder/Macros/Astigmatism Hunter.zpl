# Find the change in curvature
# Responsible for astigmatism

# Mark Nicholson, San Diego, June 2023

TIMER

GOSUB Initialize #Initialize all arrays and variables

Px = 0
Py = 1
GOSUB GETDATA
PRINT "=========================="
Px = 0
Py = -1
GOSUB GETDATA

PRINT "Program End"
PRINT "Elapsed time: ", ETIM(), " seconds"
END

SUB Initialize 	# Initialize all the variables required by the macro
debug = 1  		# Set to zero to suppress tracking print statements

#path$ = $PATHNAME() 	#Get the path the current file
#outfile$ = path$ + "\Astigmatism Hunter.txt"
# OUTPUT outfile$
IF (debug) THEN PRINT "Initializing Variables ", ETIM(), " Seconds"

	# Ray Tracing variables
	hx = 0
	hy= 1
	Px = 0
	Py = 1
	primary = PWAV()
	maxfield = MAXF()
	surface = 2 # Look on surface 2 only

	! Setup SCUR operand data
	operand_SCUR = OCOD("SCUR")
	SCUR_Ydata = 5 # Get Y curvature
	
	! Set up RAID operand
	operand_RAID = OCOD("RAID")
	
	unused = 0 #Used for operand list data items that are not used

IF (debug) THEN PRINT "Finished Initializing ", ETIM(), " seconds"
RETURN
#####################################################

SUB GetData #Trace rays 


	RAYTRACE hx, hy, px, py, primary
	IF (RAYE()) THEN PRINT "A Ray Trace error occurred, code = ", RAYE()	
	x = RAYX(surface) #Get ray data on specified surface 
	y = RAYY(surface)
	curv_tan = OPEV(operand_SCUR, surface, unused, x, y, 0, unused) 
	curv_sag = OPEV(operand_SCUR, surface, unused, x, y, 1, unused)
	curv_x = OPEV(operand_SCUR, surface, unused, x, y, 4, unused)
	curv_y = OPEV(operand_SCUR, surface, unused, x, y, 5, unused)
	
	FORMAT 3.1
	PRINT hx,$TAB(),hy,$TAB(),px,$TAB(),py,$TAB()
	FORMAT 8.7
	PRINT curv_tan, $TAB(),
	PRINT curv_sag, $TAB(),
	PRINT curv_x, $TAB(),
	PRINT curv_y, $TAB()
	
RETURN
######################################################


