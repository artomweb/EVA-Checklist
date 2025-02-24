#import "../lib.typ": *

#show: checklist.with()

#sequence[
  #withCrew("P")[
    #step[Pawls "L-L" (Locked), sawtooth - open]
  ]
  #withCrew("B")[
    #step[Feedout Umbilical]
  ]
]

#sequence(title: "Eva Sequence", withTime: true)[
  #withCrew("P")[
    #step[Take Agena pictures - Hasselblad]
    #step[Install 16mm Eva Camera Turn on]
    #step[Hand S-12 to CMD pilot]
    #step(atTime: "05:00")[Raise handrail]
    #step[Connect N#sub[2]]
    #step[Open N#sub[2] valve]
    #step[Check HHMU Operation]
    #step(atTime: "10:00")[Return to cockpit]
  ]

  #withCrew("C")[
    #step[Maneuver S/C to Agena]
  ]

  #withCrew("P")[
    #step[Translate to Agena]
    #step[Unfurl T-17]
    #step[Remove S-10]
    #step[Translate to S/C]
    #step(atTime: "30:00")[Hand S-10 to CMD Pilot]
    #step[HHMU Evaluation: 30" from]
    #subStep[S/C stabilize]
    #subStep[YAW 90#sym.degree L & R]
    #subStep(atTime: "40:00")[Pitch 45#sym.degree #sym.arrow.t&#sym.arrow.b]
    #subStep[Pilot Pickup]
    #v(2mm)
    #step(atTime: "45:00")[Tether dynamics]
    #step[Handrail Eval-Inverted]
    #step(atTime: "55:00")[Remove Sun Shade]
  ]
]

#sequence(title: "Ingress")[
  #withCrew("P")[
    #step[Turn N#sub[2] valve - off]
    #step[Bleed out N#sub[2] & unplug HHMU N#sub[2] fiting]
  ]
]
