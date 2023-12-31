# Trace a ray and create the LDE for that ray
TIMER
CLOSEWINDOW #Suppress output window
Debug = 1 #Set to zero to suppress diagnostic output, any other number for diagnostic data

GOSUB Setup
GOSUB GetData
GOSUB PrintData

IF (debug) THEN PRINT "Elapsed Time: ", ETIM()
PRINT "Program End"
END

SUB SETUP
	# Define all variables used
	# Initialization
	IF (debug) THEN PRINT "Setup Variables"
	
	int_surfaces = NSUR()
	max_field = MAXF()	
	infinity = 1e10
	
	#Raytrace data
	
	hx = 0
	hy = 1
	Px = 0
	Py = .5
	primary = PWAV()
	
	# Operands we will use. We will pass the operand_opName to the OPEV() function
	
	! Setup SCUR operand data
	operand_SCUR = OCOD("SCUR")
	Xdata = 4 # X-curvature
	Ydata = 5 # Y curvature
	
	! Set up RAID operand
	operand_RAID = OCOD("RAID")
	
	IF (debug) THEN PRINT "Variable setup finished: ", ETIM()
	
	# Now define an array variable to hold the data.
	# The array is lensdata(surface, dataStored)
	# The structure of dataStored is
	# 1 = local radius of curvature along Y axis
	# 2 = local radius of curvature along X axis
	# 3 = vertex radius of curvature
	# 4 = path length to next surface
	# 5 = ray x coordinate
	# 6 = ray y coordinate
	# 7 = ray z coordinate
	# 8 = aoi
	# 9 = curvature slope in X
	#10 = curvature slope in Y
	lastdata = 10 # This is the max dimension of the data stored
	
	# DECLARE name, type, num_dimensions, dimension1 [, dimension 2 [, dimension 3 [, dimension 4] etc...]]
	DECLARE lensdata, DOUBLE, 2, int_surfaces, lastdata
	# Initialize all memory to zero
	
	FOR surface = 1, int_surfaces, 1
		FOR dataStored = 1, lastdata, 1
			lensdata(surface, dataStored) = 0
		NEXT dataStored
	NEXT surface
	

RETURN

SUB GETDATA
	IF (debug) THEN PRINT "Ray Trace block started"
	# This routine traces a specified ray and then
	# gets the data the new LDE needs
	
	RAYTRACE hx, hy, px, py, primary
	IF (RAYE()) THEN PRINT "A Ray Trace error occurred, code = ", RAYE()
	
	# Now parse data by surface
	
	FOR surface = 1, int_surfaces, 1
	
		x = RAYX(surface)
		y = RAYY(surface)
		local_curv_y = OPEV(operand_SCUR, surface, 0, x, y, Ydata, 0)
		local_curv_x = OPEV(operand_SCUR, surface, 0, x, y, Xdata, 0)
		IF (ABSO(local_curv_y)<1e-6)
			local_radi_y = infinity
		ELSE
			local_radi_y = 1/local_curv_y
		ENDIF
		IF (ABSO(local_curv_x)<1e-6)
			local_radi_x = infinity
		ELSE
			local_radi_x = 1/local_curv_x
		ENDIF
		vertex_curv = CURV(surface)
		IF (ABSO(vertex_curv)<1e-6)
			vertex_radi = infinity
		ELSE
			vertex_radi = 1/vertex_curv
		ENDIF
		
		# Now fill the lensdata array with data
		lensdata(surface, 1) = local_radi_y
		lensdata(surface, 2) = local_radi_x
		lensdata(surface, 3) = vertex_radi
		lensdata(surface, 4) = RAYT(surface)
		lensdata(surface, 5) = x
		lensdata(surface, 6) = y
		lensdata(surface, 7) = RAYZ(surface)
		lensdata(surface, 8) = OPEV(operand_RAID, surface, primary, hx, hy, px, py)

	NEXT surface

	IF (debug) THEN PRINT "Ray trace and data extraction finished: ", ETIM()
RETURN

SUB PrintData
	IF (debug) THEN PRINT "Printing Started ", ETIM()
	
	# Print to a file
	! Get a temporary file name
	A$ = $TEMPFILENAME()
	OUTPUT A$
	
	# Print the file header
	PRINT "Listing of Extended Local Prescription"
	PRINT
	PRINT "File : ", $FILEPATH()
	PRINT "Title: ", $LENSNAME() 
	PRINT
	PRINT
	PRINT "Units are ", $UNITS()
	PRINT
	
	# Print the ray details
	FORMAT 5.3
	PRINT "Ray traced hx, hy (", hx,", ", hy, "), Px, Py (", Px,", ", Py,"), wavelength = ", WAVL(primary), " microns"
	PRINT
	PRINT

	# Do Column Headers
	# First Line
	
	PRINT "Surface"+$TAB(),
	PRINT "Type"+$TAB()+$TAB(),
	PRINT "Vertex", $TAB(),$TAB(),
	PRINT "__Ray Local Radii__"+$TAB(),+$TAB(),
	PRINT "Path"+$TAB(),$TAB(),
	PRINT "Material"+$TAB(),
	PRINT "x", $TAB(), $TAB(),$TAB(),
	PRINT "y",$TAB(),
	PRINT "z"+$TAB(),$TAB(),
	PRINT "AOI°"+$TAB(),
	PRINT "Comment",
	PRINT # <CR><LS>
	
	# Second Line
	PRINT $TAB() + $TAB() + $TAB(),+$TAB() +$TAB(),
	PRINT "Radius",+$TAB(),+$TAB(),
	PRINT "x", $TAB(), $TAB(),$TAB(),
	PRINT "y", $TAB(),$TAB(),$TAB(),
	PRINT "Length",+$TAB()+$TAB()+$TAB(),+$TAB(),
	PRINT # <CR><LS>
	
	# Now print out the data, by surface
	
	FOR surface = 1, int_surfaces, 1
		FORMAT 2 INT
		PRINT surface, $TAB(),$TAB(), # Surface number
		FORMAT 5.3
		
		dummy = SPRO(surface, 0) 
		PRINT $buffer(), $TAB(),  # Surface Type
		
		# Now print the vertex radius of curvature
		
		vertex_radi = lensdata(surface, 3)
		IF (vertex_radi == infinity)
			PRINT "Infinity",
		ELSE
			PRINT vertex_radi, $TAB(), # local radius
		ENDIF
		PRINT $TAB(),

		
		#Now print the two local radii of curvature)
		local_radi_x = lensdata(surface, 2)
		IF (local_radi_x == infinity)
			PRINT "Infinity",
		ELSE
			PRINT local_radi_x, $TAB(), # local radius
		ENDIF
		PRINT $TAB(),
		
		
		local_radi_y = lensdata(surface, 1)
		IF (local_radi_y == infinity)
			PRINT "Infinity",
		ELSE
			PRINT local_radi_y, $TAB(), # local radius
		ENDIF
		PRINT $TAB(),

		PRINT lensdata(surface, 4), $TAB(),$TAB(), # path length
		
		material$ = $GLASS(surface)
		IF (material$ $== "") THEN material$ = "     "
 		IF (SLEN(material$) >5)
			material$ = $LEFTSTRING(material$, 5) + ".."
		ENDIF
		# Check if model glass
		IF(SOLV(surface, 2 , 0)) THEN material$ = "<Model>"
		PRINT material$, $TAB(), $TAB(),    # material
		
		PRINT lensdata(surface, 5), $TAB(), # ray_x
		PRINT lensdata(surface, 6), $TAB(), # ray_y
		PRINT lensdata(surface, 7), $TAB(), # ray_z
		PRINT lensdata(surface, 8), $TAB(), # AOI
		
		dummy = SPRO(surface, 1) 
		PRINT $buffer(), $TAB(),  # Surface Comment
		PRINT # <CR><LS>
		
	NEXT surface 

	FORMAT 5.3
	
	# Return Output to Screen
	OUTPUT SCREEN
	SHOWFILE A$
	! Clean up by deleting the temporary file
	DELETEFILE A$
	
	IF (debug) THEN PRINT "Printing finished: ", ETIM()
RETURN 

