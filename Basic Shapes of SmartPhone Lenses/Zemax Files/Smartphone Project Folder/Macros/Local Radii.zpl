! This macro computes the local radius of curvature
! seen by a fan of rays on a given surface
!
! Mark Nicholson, May 2023

TIMER
PRINT "Executing..."
# OUTPUT local_radii.txt

GOSUB Setup   #Initialize all required variables

# FOR surface, 2, NSUR(), 1
FORMAT 3 INT
PRINT "Data on surface ", surface, ": ", $COMMENT(surface)
PRINT
PRINT 
PRINT " Hy       Field    Local Radius             Angle of Incidence " 
PRINT "          Angle    of Curvature " 
PRINT
FORMAT 5.3

FOR counter, 0, 100, counter_step

		hy = counter/100
		local_field = maxfield*hy
		GOSUB Get_local_radi # Get local_radi for specified ray on specified surface
		PRINT hy, "     ", local_field,"°        ", "Y coord", y,
		IF (local_radi == infinity)
			PRINT "Infinity              ",
		ELSE
			PRINT local_radi, "                   ",
		ENDIF
		
		PRINT ray_aoi, "°"
	NEXT counter
PRINT
# NEXT surface

PRINT
PRINT

OUTPUT SCREEN
PRINT "Elapsed Time: ", ETIM(), " seconds"
# SHOWFILE local_radii.txt
END
##############



SUB Get_local_radi

# This routine traces a specified ray and then
# gets the local radius of curvature of that ray
# on a specified surface

RAYTRACE hx, hy, px, py, primary
IF (RAYE()) THEN PRINT "A Ray Trace error occurred, code = ", RAYE()

x = RAYX(surface)
y = RAYY(surface)

local_curv = OPEV(operand_SCUR, surface, 0, x, y, data, 0)

IF (ABSO(local_curv)<1e-6)
	local_radi = infinity
ELSE
	local_radi = 1/local_curv
ENDIF

# Now get the ray angle of incidence

ray_aoi = OPEV(operand_RAID, surface, primary, hx, hy, px, py)

RETURN

###############
SUB Setup
! Setup Raytrace data
surface = 10 # Can be overwritten by For/Next loop

primary = PWAV()
hx = 0
hy= 0
Px = 0
Py = 0
maxfield = MAXF()
infinity = 1e10 #Used to prevent 1/0 errors for flat surfaces
counter_step = 10

PRINT
PRINT "Local Radius of Curvature as a function of field angle"
PRINT "======================================================"
PRINT
PRINT



! Setup SCUR operand data
operand_SCUR = OCOD("SCUR")
data = 5 # Get Y curvature

! Set up RAID operand
operand_RAID = OCOD("RAID")

RETURN
