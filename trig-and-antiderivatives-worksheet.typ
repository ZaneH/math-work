#let kernelblue = rgb(20, 60, 110)
#let kernelblue-dark = rgb(14, 44, 82)
#let boxgray = rgb(245, 246, 248)
#let rulegray = rgb(195, 199, 204)
#let worklines = rgb(210, 214, 219)
#let appgreen = rgb(40, 95, 70)
#let appgreenbg = rgb(240, 247, 243)

#set page(
  paper: "us-letter",
  margin: (x: 0.85in, top: 1in, bottom: 1in),
  header: [
    #set text(size: 9pt, style: "italic")
    #grid(
      columns: (1fr, 1fr),
      [Trig Identities \& Antiderivatives],
      align(right)[Derivation Worksheet],
    )
    #v(-6pt)
    #line(length: 100%, stroke: 0.4pt + black)
  ],
  footer: context [
    #set align(center)
    #set text(size: 9pt)
    #counter(page).display()
  ],
)

#set text(size: 11pt, font: "New Computer Modern")
#set par(justify: true)

#set heading(numbering: "1.1.")
#show heading.where(level: 1): it => {
  block(above: 18pt, below: 12pt)[
    #text(size: 14pt, weight: "bold", fill: kernelblue)[#counter(heading).display() #it.body]
  ]
}
#show heading.where(level: 2): it => {
  block(above: 16pt, below: 8pt)[
    #text(size: 11pt, weight: "bold")[#counter(heading).display() #it.body]
  ]
}
#show math.equation.where(block: true): set align(center)
#set math.equation(numbering: none)

// Custom references
#show ref: it => {
  let eq = math.equation
  let el = it.element
  if el == none or el.func() != eq { return it }
  link(el.location(), counter(eq).display(at: el.location()))
}

// ---- reusable components ----

#let kernelbox(body) = block(
  fill: boxgray,
  stroke: 0.8pt + kernelblue,
  radius: 2pt,
  inset: (left: 8pt, right: 8pt, top: 6pt, bottom: 6pt),
  width: 100%,
)[#body]

#let stepbox(title, body) = block(
  stroke: 0.6pt + kernelblue-dark,
  radius: 1pt,
  width: 100%,
  breakable: true,
)[
  #block(
    fill: kernelblue,
    inset: (x: 9pt, y: 6pt),
    width: 100%,
    radius: (top: 1pt),
  )[#text(fill: white, weight: "bold", size: 10pt)[#title]]
  #block(inset: (x: 9pt, y: 7pt))[#body]
]

#let appbox(title, body) = block(
  stroke: 0.6pt + appgreen,
  radius: 1pt,
  width: 100%,
  breakable: true,
  fill: appgreenbg
)[
  #block(
    fill: appgreen,
    inset: (x: 9pt, y: 6pt),
    width: 100%,
    radius: (top: 1pt),
  )[#text(fill: white, weight: "bold", size: 10pt)[#title]]
  #block(inset: (x: 9pt, y: 7pt))[#body]
]

// Space to work
#let workspace(lines: 5, title: "Try it yourself:") = {
  v(6pt)
  text(size: 10pt, style: "italic", fill: kernelblue-dark)[
    #title
  ]
  for i in range(1, lines) {
    v((lines) * 1pt)
  }
}

// ---- title ----

#align(center)[
  #text(size: 20pt, weight: "bold")[Trig Identities \& Antiderivatives] \
  #v(2pt)
  #text(size: 13pt, weight: "bold")[A Derive-It-Yourself Worksheet]
]

#v(4pt)

#emph[
  A word before you start: everything on a standard trig cheat sheet, and every antiderivative on a
  standard calculus reference sheet, is downstream of a small handful of facts. That means you're not
  memorizing forty formulas --- you're memorizing about eight. This worksheet is meant to be worked,
  not read. Follow each derivation more than once over the next few weeks; the goal is for the
  associations to become automatic. Generative AI was used to create this document.
]

#v(8pt)

= The Kernel: Three Facts Worth Memorizing <the-kernel>

#kernelbox[
  + *Unit circle definition.* For a point $(x, y)$ on the unit circle at angle $theta$:
    $ cos(theta) = x, wide sin(theta) = y $
    (This is a definition, not a derivation --- everything downstream starts here.)

  + *Pythagorean identity.*
    $ sin^2 (theta) + cos^2 (theta) = 1 $
    (Immediate from $x^2 + y^2 = 1$, the equation of the unit circle.)

  + *Angle sum formulas.*
    $ sin(alpha + beta) = sin(alpha)cos(beta) + cos(alpha)sin(beta) $
    $ cos(alpha + beta) = cos(alpha)cos(beta) - sin(alpha)sin(beta) $
]

#pagebreak()

#import "@preview/cetz:0.5.1": canvas, draw

= From the Kernel to the Rest

A reasonable question to ask before we dive in: why bother deriving these instead of just memorizing
the list? Because memorized facts decay but a fact that you can rebuild in
thirty seconds never really leaves you. Let's build each branch of the tree one at a time.

== tan, cot, sec, csc

No derivation needed here --- these four aren't new facts about angles, they're just *names* we've given
to ratios of the two functions we already have. It's worth noticing the naming pattern, because
it's what lets you reconstruct any of the four instantly instead of second-guessing yourself: every "co-"
function (cosine, cotangent, cosecant) pairs with the non-"co-" function that shares its letter.

$ tan(theta) = sin(theta)/cos(theta), quad cot(theta) = cos(theta)/sin(theta), quad
  sec(theta) = 1/cos(theta), quad csc(theta) = 1/sin(theta) $

== Pythagorean identities (the other two) <other-pyth-ids>

We already have $sin^2 (theta) + cos^2 (theta) = 1$ in the kernel. The question is how to turn that single
fact into the two cousins involving $tan, sec$ and $cot, csc$. The move is simple once you see it: divide
the *entire equation*, term by term, by whichever function you'd like to appear in the result. This is
exactly the same legal move as taking $a + b = c$ and dividing every term by $b$ to get $a/b + 1 = c/b$ ---
nothing fancier than that.

#stepbox([Divide every term of $sin^2 (theta) + cos^2 (theta) = 1$ by $cos^2 (theta)$])[
  #block(width: 100%)[
    $ (sin^2 (theta))/(cos^2 (theta)) + (cos^2 (theta))/(cos^2 (theta)) = 1/cos^2 (theta) $
    
    Each of these simplify using things you already know:
    $ (sin^2 (theta))/(cos^2 (theta)) = (sin(theta)/cos(theta))^2 &= tan^2 (theta) \
    (cos^2 (theta))/(cos^2 (theta)) &= 1 \
    1/cos^2 (theta) &= sec^2 (theta) $

    Substitute those simplified pieces back into the equation:
    $ tan^2 (theta) + 1 = sec^2 (theta) $
  ]
]

#pagebreak()

#appbox([Where this is useful: integrating $tan^2 x$])[
  Try to integrate $tan^2 x$ directly and you'll find there's no antiderivative rule that applies to it as
  written --- it's not on our kernel list of derivatives. But rearrange the identity we just derived:
  $tan^2 (theta) = sec^2 (theta) - 1$. Substitute that in:

  $ integral tan^2 x med d x = integral (sec^2 x - 1) med d x = tan(x) - x + C $

  That last step uses a formula we learn later (the antiderivative of $sec^2 x$). This is the whole
  point of trig identities in a calculus context: they don't teach you anything new about integration,
  they just rewrite an integral you _can't_ do yet into one you already can.
]

Now do the same but with $sin^2 theta$. (1) Divide $sin^2 (theta) + cos^2 (theta) = 1$
by $sin^2 (theta)$ instead of $cos^2 (theta)$ (2) simplify each of the three resulting pieces on its own, and
see what you land on.
#workspace(lines: 15)

It should come out to $1 + cot^2 (theta) = csc^2 (theta)$


#pagebreak()

== Even / odd formulas

Quick refresher on the vocabulary before we touch trig at all: a function $f$ is called *even* if
$f(-theta) = f(theta)$ for every $theta$ --- picture $x^2$, whose graph is a mirror image of itself across
the $y$-axis. A function is *odd* if $f(-theta) = -f(theta)$ --- picture $x^3$, whose graph has
$180 degree$ rotational symmetry about the origin. Every trig function is one or the other, and we can
figure out which without memorizing a single new formula, just by watching what a negative angle physically
does to a point on the unit circle.

#stepbox([What does the angle $-theta$ do to the point $(x, y)$?])[
  An angle of $theta$ sweeps counterclockwise from the positive $x$-axis out to the point
  $(x,y) = (cos(theta), sin(theta))$. An angle of $-theta$ sweeps the exact same _amount_, but in the
  opposite (clockwise) direction. Picture that for a second: sweeping the same distance but the other way
  around is precisely a mirror-flip of the point across the $x$-axis. A flip across the $x$-axis leaves the
  $x$-coordinate alone and negates the $y$-coordinate, so the new point is $(x, -y)$.

  But we also know, by definition, that the point sitting at angle $-theta$ is $(cos(-theta), sin(-theta))$.
  We now have two descriptions of the same point, so we can match them coordinate by coordinate:

  $ cos(-theta) = x = cos(theta) quad quad sin(-theta) = -y = -sin(theta) $

  In words: cosine is *even*, sine is *odd*. Let's use a concrete angle whose values we both know:
  at $theta = 30 degree$, $cos(30 degree) = sqrt(3)/2$ and $cos(-30 degree) = sqrt(3)/2$ as well ---
  unchanged, exactly as "even" promises. Meanwhile $sin(30 degree) = 1/2$ but $sin(-30 degree) = -1/2$
  --- flipped sign, exactly as "odd" promises.

  Everything else on this list requires no new geometry at all, just substitution into the ratio
  definitions from #link(<the-kernel>, "1.1"). For instance:

  $ tan(-theta) = sin(-theta)/cos(-theta) = (-sin(theta))/cos(theta) = -tan(theta) $

  so tangent is odd too.
]

#appbox([Where this is useful: solving a definite integral for free])[
  Here's a useful shortcut this identity buys you. Suppose you're asked to evaluate
  $integral_(-pi)^(pi) sin(x) med d x$. You could grind through the antiderivative and evaluate at both
  endpoints --- or you could notice that $sin x$ is odd, and the interval $[-pi, pi]$ is symmetric about
  zero. Whatever area sine sweeps out above the axis on $(0, pi)$, it sweeps out an identical amount
  _below_ the axis on $(-pi, 0)$, because the graph is rotationally symmetric about the origin. Those two
  areas cancel exactly, so the integral is $0$ --- no computation needed. This trick (odd function,
  symmetric interval, integral is automatically zero) shows up constantly once you get to Fourier series
  and symmetric-interval problems generally.
]

#pagebreak()

Using the same substitution approach as the $tan(-theta)$ example above, work out
whether $csc theta$, $sec theta$, and $cot theta$ are each even or odd. Write out the substitution for all
three.
#workspace(lines: 10)

== Cofunction formulas

"Cofunction" pairs --- sine/cosine, tangent/cotangent, secant/cosecant --- are related by swapping the
angle $theta$ for its _complement_, $pi/2 - theta$. That's literally what the "co-" prefix has meant this
whole time: cosine is the sine of the complementary angle. If you've done right-triangle trig, you've
already seen this in disguise: in any right triangle, the two non-right angles add up to $90 degree$, so
they're complements of each other, and the side that's "opposite" one of them is "adjacent" to the other ---
which is exactly why $sin$ of one angle equals $cos$ of the other.

#stepbox([What does swapping to angle $pi/2 - theta$ do to $(x, y)$?])[
  Reflecting a point across the line $y = x$ swaps its coordinates: $(x, y) arrow.r (y, x)$. This reflection
  is exactly the same move as rotating from angle $theta$ to angle $pi/2 - theta$. Check this with a concrete
  angle. If $theta = 30 degree$, then $pi/2 - theta = 60 degree$. Reflect the first point across the
  line $y = x$, and you land exactly on the $60 degree$ point. (Try sketching both points on the unit circle.)

  #align(center)[
    #canvas({
      import draw: *

      circle((0,0), radius: 2)

      line((-2.5, 0), (2.5, 0))
      content((), $ x $, anchor: "west")
      line((0, -2.5), (0, 2.5))
      content((), $ y $, anchor: "south")
    })
  ]

  Now knowing that the point sitting at angle $pi/2 - theta$ has coordinates $(y, x)$ --- the original
  coordinates, swapped. Match that against the definition $(cos(pi/2 - theta), sin(pi/2 - theta))$:

  $ cos(pi/2 - theta) = y = sin(theta) quad quad sin(pi/2 - theta) = x = cos(theta) $

  The remaining pairs, $sec arrow.l.r csc$ and $tan arrow.l.r cot$, follow immediately by plugging this
  result into the ratio definitions back in #link(<the-kernel>, "1.1") --- no new geometry, just booking.
]

Take a classic $30$-$60$-$90$ triangle. The two acute angles, $30 degree$ and $60 degree$, are complements
of each other. Sure enough: $sin(30 degree) = 1/2$ and $cos(60 degree) = 1/2$. This matches the cofunction
definition. Use what you know to show that complement angles have a counterpart in the cofunction.

#v(24pt)

#align(center)[
  #canvas({
    import draw: *
    scale(400%);
    line((0, 0), (1/2, 0), (0, 1), close: true);
  })
]

#v(48pt)

== Double angle formulas

These fall directly out of the angle sum formulas in the kernel --- a "double" angle is nothing more
exotic than a sum angle where the two pieces happen to be identical. If you can add $alpha + beta$, you can
handle $alpha + alpha$.

#stepbox([Set $beta = alpha$ in the angle sum formulas])[
  $ 2 alpha = alpha + beta = alpha + alpha $
  $ sin(2 alpha) = sin(alpha + alpha) = sin(alpha)cos(alpha) + cos(alpha)sin(alpha) = 2 sin(alpha)cos(alpha) $
  $ cos(2 alpha) = cos(alpha + alpha) = cos(alpha)cos(alpha) - sin(alpha)sin(alpha) = cos^2 (alpha) - sin^2 (alpha) $

  That second result is a little unsatisfying as written, since it mixes a $sin^2$ term with a $cos^2$
  term. We can clean it up using the Pythagorean identity to eliminate one of the two functions entirely.
  Substituting $sin^2 (alpha) = 1 - cos^2 (alpha)$ gives one alternate form, and substituting
  $cos^2 (alpha) = 1 - sin^2 (alpha)$ gives the other:

  $ cos(2 alpha) = cos^2 (alpha) - (1 - cos^2 (alpha)) = 2 cos^2 (alpha) - 1 $
  $ cos(2 alpha) = (1 - sin^2 (alpha)) - sin^2 (alpha) = 1 - 2 sin^2 (alpha) $

  So we actually get three equivalent expressions for $cos(2 alpha)$, and which one is most useful depends
  entirely on what you're trying to solve for --- keep an eye out for that in the half-angle derivation
  next, where this choice matters a lot.
]

#pagebreak()

#appbox([Where this is heading])[
  On its own, the double angle formula is handy for things like finding $sin(2x)$ given only $sin x$ and
  $cos x$. But its real payoff for integration shows up one section from now: solved the other way around,
  these same three equations become the "power-reducing" formulas that let you integrate $sin^2 x$ and
  $cos^2 x$ --- two integrals that show up constantly and that the power rule alone can't touch.
]

#workspace(lines: 11, title: [Try to derive the 4 double-angle identities for $cos(2 alpha)$ and $sin(2 alpha)$ yourself:])

== Half angle (power-reducing) formulas

Here's the idea in one sentence: everything we just derived for $cos(2 alpha)$ can be read _backward_ to
solve for $sin^2 (alpha)$ and $cos^2 (alpha)$ individually. We're just isolating a different variable in
an equation we already have.

#stepbox([Solve the double-angle forms for $sin^2 (alpha)$ and $cos^2 (alpha)$])[
  Using the double-angle identity $cos(2 alpha) = 1 - 2 sin^2 (alpha)$ from the previous page, we isolate $sin^2 (alpha)$.

  $ 2 sin^2 (alpha) = 1 - cos(2 alpha) quad arrow.r.double quad sin^2 (alpha) = (1 - cos(2 alpha))/2 $

  Do the identical thing to $cos(2 alpha) = 2 cos^2 (alpha) - 1$:

  $ 2 cos^2 (alpha) = 1 + cos(2 alpha) quad arrow.r.double quad cos^2 (alpha) = (1 + cos(2 alpha))/2 $

  These two results are already the "power-reducing" ($cos^2(theta) arrow.r cos(theta)$) formulas --- the
  ones you'll actually reach for during integration. If instead you want the classical half-angle formulas
  stated in terms of $theta/2$, relabel $theta = 2 alpha$ (so $alpha = theta/2$) and take a square root of
  both sides, choosing the sign based on which quadrant $theta/2$ falls in.

  By dividing the two equations, rather than taking square roots you're also given $tan^2 (theta/2)$
  directly --- worth noticing since it avoids a square root entirely.
]

#pagebreak()

#appbox([Where this is useful: integrating $sin^2 x$])[
  This is arguably the single most common use of any identity on this entire page. Try to integrate
  $sin^2 x$ directly and you're stuck --- there's no power rule for trig functions, and nothing in our
  kernel list of antiderivatives matches $sin^2 x$ as written. But substitute the power-reducing form we
  just derived, $sin^2 (x) = (1 - cos(2x))/2$:

  $ integral sin^2 x med d x = integral (1 - cos(2x))/2 med d x
    = 1/2 integral 1 med d x - 1/2 integral cos(2x) med d x
    = x/2 - sin(2x)/4 + C $

  (That last piece uses a simple substitution $u = 2x$ along with the antiderivative of cosine.) Every time
  you see $sin^2$ or $cos^2$ sitting inside an integral --- and you will see this often.
]

#workspace(lines: 10, title: [Try integrating $integral sin^2 x med d x$ with the half angle (power-reducing) formulas:])

== Product-to-sum formulas <product-to-sum>

This is the section that trips people up most often, so let's go slow. The angle sum and angle difference
formulas for sine share two ingredients:

$ sin(alpha + beta) = sin(alpha)cos(beta) + cos(alpha)sin(beta) $
$ sin(alpha - beta) = sin(alpha)cos(beta) - cos(alpha)sin(beta) $

Look carefully at the two right-hand sides for a moment. They're built from the exact same two pieces,
$sin(alpha)cos(beta)$ and $cos(alpha)sin(beta)$ --- the only thing that differs between the two equations
is the sign sitting in front of the second piece: plus in the first equation, minus in the second. Whenever
two equations differ only by a sign like that, adding or subtracting them is a reliable way to make one of
the two pieces disappear entirely. That's the whole strategy here.

#pagebreak()

#stepbox([Add the two equations together, side by side])[
  Add left side to left side, and right side to right side:

  $ sin(alpha + beta) + sin(alpha - beta) =
    [sin(alpha)cos(beta) + cos(alpha)sin(beta)] + [sin(alpha)cos(beta) - cos(alpha)sin(beta)] $

  After simplifying:

  $ sin(alpha + beta) + sin(alpha - beta) = 2 sin(alpha)cos(beta) $

  Divide both sides by $2$ and you've expressed the product $sin(alpha)cos(beta)$ as a sum of two sines ---
  hence "product-to-sum." Let's check with a concrete example, $alpha = 60 degree,
  beta = 30 degree$: the left side is $sin(90 degree) + sin(30 degree) = 1 + 0.5 = 1.5$, and the right side
  is $2 sin(60 degree)cos(30 degree) = 2 dot sqrt(3)/2 dot sqrt(3)/2 = 2 dot 3/4 = 1.5$. They match.
]

Now do the subtraction case yourself, following the same routine. Subtract the two equations
instead of adding them (first equation minus second), track which term cancels this time instead of the one
that cancelled above, and see what product you end up isolating.
#workspace(lines: 6)

#pagebreak()

#appbox([Where this is useful: integrating a product of two different frequencies])[
  Suppose you're asked to integrate $sin(3x)cos(x)$. There's no product rule for integration, and
  $u$-substitution doesn't obviously apply either, since neither factor is the derivative of the other. But
  rewrite the product using what we just derived (with $alpha = 3x, beta = x$):

  $ sin(3x)cos(x) = 1/2 [sin(4x) + sin(2x)] $

  and now it's just a sum of two things we already know how to integrate:

  $ integral sin(3x)cos(x) med d x = 1/2 integral sin(4x) med d x + 1/2 integral sin(2x) med d x
    = -1/8 cos(4x) - 1/4 cos(2x) + C $

  This exact move --- product of two trig functions with different arguments, rewritten as a sum --- comes
  up constantly once you get to Fourier series or signal-processing contexts, where "different frequencies"
  is literally what $3x$ and $x$ represent.
]

== Sum-to-product formulas

Unlike most of this page, sum-to-product formulas aren't something
you'll reach for during integration nearly as often. They're more useful for _solving equations_ and
recognizing hidden structure in a sum of trig terms. Still worth having, and it costs us nothing new ---
it's the product-to-sum result from the previous page, but relabeled.

#stepbox([Let $alpha = (x+y)/2$ and $beta = (x-y)/2$])[
  This substitution looks unmotivated until you check what it does to $alpha + beta$ and $alpha - beta$:

  $ alpha + beta = (x+y)/2 + (x-y)/2 = (2x)/2 = x quad quad
    alpha - beta = (x+y)/2 - (x-y)/2 = (2y)/2 = y $

  So this particular substitution was chosen specifically so that $alpha + beta$ and $alpha - beta$ come out
  to clean, simple values --- $x$ and $y$ themselves. Now take the product-to-sum result from @product-to-sum,
  $2 sin(alpha)cos(beta) = sin(alpha+beta) + sin(alpha-beta)$, and substitute:

  $ 2 sin((x+y)/2) cos((x-y)/2) = sin(x) + sin(y) $

  No new algebra happened here --- we just relabeled the same fact so that it directly answers the question
  "I have $sin x + sin y$, can I write it as a product?" rather than the reverse.
]

#pagebreak()

#appbox([Where this is useful: solving an equation, not integrating one])[
  Suppose you need to solve $sin(5x) + sin(x) = 0$. Written as a sum, it's not obvious how to proceed. But
  rewrite the left side as a product using what we just derived (with $x arrow.r 5x, med y arrow.r x$):

  $ sin(5x) + sin(x) = 2 sin(3x)cos(2x) = 0 $

  Now it's a product equal to zero, which means _either_ factor can be zero: $sin(3x) = 0$ or
  $cos(2x) = 0$. That splits one hard equation into two easy ones. This "turn a sum into a product so you
  can use the zero-product property" move is really the main reason this identity earns a place on the
  sheet.
]

#workspace(lines: 2)

#pagebreak()

= Antiderivatives: Same Idea, Different Kernel

Everything we just did with trig identities, we're about to repeat with antiderivatives --- and the
underlying philosophy is identical. A big scary-looking list of antiderivative formulas is mostly just a
short list of _derivatives_ you already know, read from right to left.

#kernelbox[
  The relevant kernel here is the six trig derivatives you should be familiar with:

  $ d/(d x) sin(x) = cos(x), quad d/(d x) cos(x) = -sin(x), quad d/(d x) tan(x) = sec^2 (x), $
  $ d/(d x) cot(x) = -csc^2 (x), quad d/(d x) sec(x) = sec(x)tan(x), quad d/(d x) csc(x) = -csc(x)cot(x) $
]

== Read backwards

An antiderivative is really just an answer to the question "what function has this as its derivative?" If
the six facts above are already second nature to you, the six antiderivatives below aren't new information.

#grid(
  columns: (1fr, 1fr),
  gutter: 8pt,
  grid.cell(
    stepbox([From $d/(d x) sin(x) = cos(x)$])[
      $ integral cos(x) med d x = sin(x) + C $
    ],
  ),
  grid.cell(
    stepbox([From $d/(d x) cos(x) = -sin(x)$])[
      $ integral sin(x) med d x = -cos(x) + C $
    ]
  ),
  grid.cell(
    stepbox([From $d/(d x) tan(x) = sec^2 (x)$])[
      $ integral sec^2 (x) med d x = tan(x) + C $
    ]
  ),
  grid.cell(
    stepbox([From $d/(d x) cot(x) = -csc^2 (x)$])[
      $ integral csc^2 (x) med d x = -cot(x) + C $
    ]
  ),
  grid.cell(
    stepbox([From $d/(d x) sec(x) = sec(x)tan(x)$])[
      $ integral sec(x)tan(x) med d x = sec(x) + C $
    ]
  ),
  grid.cell(
    stepbox([From $d/(d x) csc(x) = -csc(x)cot(x)$])[
      $ integral csc(x)cot(x) med d x = -csc(x) + C $
    ]
  )
)

Recognizing these patterns saves real time: the moment you see $sec(x)tan(x)$ sitting inside an
integral, you shouldn't need to work anything out --- it should trigger "$sec(x) + C$" immediately, the
same way seeing $2x$ next to $x^2$ triggers a power-rule reflex.

#pagebreak()

== Inverse trig antiderivatives

To find the antiderivative of an inverse trig function (e.g. $integral tan^-1(x)$) we can use implicit
differentiation.

#stepbox([Implicit differentiation of $y = tan^(-1) (x)$, i.e. $x = tan(y)$])[
  Start from the inverse $x = tan(y)$, and differentiate _both sides_ with respect to $x$,
  remembering that $y$ is secretly a function of $x$ (that's what makes this "implicit"):

  $ 1 = sec^2 (y) dot (d y)/(d x) $

  The right-hand side still has a $y$ hiding in it, and we'd much rather have everything in terms of $x$.
  This is where the Pythagorean identity from @other-pyth-ids is useful: $sec^2 (y) = 1 + tan^2 (y)$, and
  we already know $tan(y) = x$ from how we set the problem up, so we know that

  $ sec^2 (y) = 1 + x^2 $

  Substitute that back in for $sec^2(y)$ and solve for $(d y)/(d x)$:

  $ (d y)/(d x) = 1/(1+x^2) quad arrow.r.double quad integral 1/(1+x^2) med d x = tan^(-1) (x) + C $
]

#appbox([Where this is useful: partial fractions in Calc II])[
  Hang onto this one. When you eventually do partial fraction decomposition on rational functions, you'll
  regularly end up with a leftover piece that looks like $1/(x^2+4)$ or similar --- an irreducible
  quadratic in the denominator that no amount of algebra simplifies further. That's precisely the shape
  this antiderivative was built for (after a small substitution to absorb the constant), and $tan^(-1)$ is
  how those problems get finished off.
]

Your turn: run the identical argument on $y = sin^(-1) (x)$, i.e. $x = sin(y)$. You should land on $integral 1/sqrt(1-x^2) med d x = sin^(-1) (x) + C$

#workspace(lines: 7)

#pagebreak()

== The two honest exceptions: $integral sec(x) med d x$ and $integral csc(x) med d x$

These two really are a memorized trick rather than something most people would spontaneously reinvent.
The technique is multiplying by a disguised form of $1$.

#stepbox([Multiply by $(sec(x)+tan(x))/(sec(x)+tan(x))$])[
  $ integral sec(x) med d x = integral sec(x) dot (sec(x)+tan(x))/(sec(x)+tan(x)) med d x
    = integral (sec^2 (x) + sec(x)tan(x))/(sec(x)+tan(x)) med d x $

  Here's the payoff of that particular choice of "disguised $1$": look closely at the numerator. It's
  exactly $d/(d x) (sec(x) + tan(x))$ --- literally the derivative of the denominator, sitting right there.
  Whenever an integral has that shape, $integral (u') / u med d x$, it's a straightforward log:

  $ integral sec(x) med d x = ln|sec(x) + tan(x)| + C $

  The identical trick, multiplying instead by $(csc(x)+cot(x))/(csc(x)+cot(x))$, gives
  $integral csc(x) med d x = -ln|csc(x) + cot(x)| + C$.
]

#appbox([Where this resurfaces: trig substitution])[
  File this one away for later in your course. When you learn trig substitution for integrals containing
  $sqrt(x^2+a^2)$, you'll set $x = a tan(theta)$, and partway through nearly every one of those problems
  you'll find yourself needing exactly $integral sec(theta) med d theta$. It won't feel like a coincidence
  once you get there --- it's this same integral, wearing a different problem's clothes.
]
