# Simple testbed macro

operand_SCUR = OCOD("SCUR")
SCUR_Ydata = 5 # Get Y curvature

i_surface = 5
x = 0
y = 0
unused = 0

local_curv = OPEV(operand_SCUR, i_surface, unused, x, y, SCUR_Ydata, unused)

PRINT local_curv