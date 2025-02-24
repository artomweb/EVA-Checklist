#let s = state("Crew Member", "P")
#let t = state("With Time?", false)

#let sequence(title: "", withTime: false, body) = context {
  let step-num = counter("step").get().at(0)
  if step-num > 0 {
    v(3mm)
  }
  counter("step").update(0)
  counter("crewSection").update(0)
  counter("localTimeBadge").update(0)
  t.update(withTime)
  if title != "" {
    upper[#underline()[#title:]]
  }
  v(1mm)
  body
}

#let step-component(atTime: "00:00", body, inset: 0pt) = {
  context {
    counter("step").step()
    let step-num = counter("step").get().at(0)
    let section-num = counter("crewSection").get().at(0)
    let globalTimeBadge = counter("globalTimeBadge").get().at(0)
    let time-width = 2.8em // Fixed width for time column

    if step-num == 1 and section-num != 1 {
      v(2mm)
    }

    let content = grid(
      inset: inset,
      columns: if t.get() { (2em, 1fr, time-width) } else { (2em, 1fr, 0em) }, // Fixed time column width
      column-gutter: 0.5em, // Consistent spacing between columns
      if step-num == 1 {
        let crew-member = s.get()
        crew-member
      },
      par(hanging-indent: 1.2em, upper[#body]),
      if t.get() and (step-num == 1 and section-num == 1 or atTime != "00:00") {
        counter("globalTimeBadge").step()
        counter("localTimeBadge").step()
        align(right)[
          // Right-align time for consistency
          #box(width: time-width)[#underline()[#atTime] #label(("timeBadge" + str(globalTimeBadge + 1)))]
        ]
      },
    )

    block(width: 100%, content) // Always full width
  }

  context {
    if t.get() {
      let localTimeBadge = counter("localTimeBadge").get().at(0)
      let globalTimeBadge = counter("globalTimeBadge").get().at(0)
      if localTimeBadge > 1 and atTime != "00:00" {
        let pos = locate(label("timeBadge" + str(globalTimeBadge - 1))).position()
        let currPos = locate(label("timeBadge" + str(globalTimeBadge))).position()

        if currPos.page == pos.page {
          place(top)[
            #line(start: (pos.x + 10.8pt, pos.y + 7pt), end: (currPos.x + 10.8pt, currPos.y - 10pt))
          ]
          place(top, dx: currPos.x + 8.8pt, dy: currPos.y - 11pt)[
            #curve(
              stroke: black,
              fill: black,
              curve.move((0.5pt, 0pt)),
              curve.line((2pt, 3.5pt)),
              curve.line((3.5pt, 0pt)),
              curve.close(),
            )
          ]
        }
      }
    }
  }
}

#let step(atTime: "00:00", body) = {
  step-component(atTime: atTime, body)
}

#let subStep(atTime: "00:00", body) = {
  step-component(atTime: atTime, inset: (left: 1.2em), body)
}

#let atTime(thisTime) = {
  thisTime
}

#let withCrew(crewMember, body) = {
  counter("step").update(1)
  counter("crewSection").step()
  s.update(crewMember)
  body
}

#let checklist(title: none, body) = {
  set page(
    width: 83mm,
    height: 203mm,
    margin: 2mm,
  )
  set text(size: 11pt)
  set text(font: ("Liberation Mono", "Cascadia Mono"))
  set sub(size: 1em, typographic: false, baseline: .4em)
  set underline(offset: 1mm, stroke: 0.08em)
  set par(spacing: 0.7em)
  counter("globalTimeBadge").update(0)
  body
}
