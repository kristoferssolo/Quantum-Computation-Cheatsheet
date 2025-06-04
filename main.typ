#import "@preview/fletcher:0.5.7" as fletcher: diagram, edge, node
#import "@preview/physica:0.9.5": bra, braket, ket, ketbra
#import "@preview/quill:0.6.1": *
#import "@preview/quill:0.6.1" as quill: tequila as tq
#import "layout.typ": indent-par, project

#show: project.with(title: [Kvantu skaitļošana], authors: ("Kristofer Solo",))

= Fundamentals
== Qubit (Kvantu bits)
=== Basis states
$ ket(0)=vec(1, 0), ket(1)=vec(0, 1) $

=== Superposition
A qubit can be in a linear combination of basis states:
$ket(psi)=alpha ket(0)+ beta ket(1)$, where $alpha, beta in CC$ are probability amplitudes.

=== Normalization
$ abs(alpha)^2 + abs(beta)^2 = 1 $
$abs(alpha)^2$ is the probability of measuring $ket(0)$, $abs(beta)^2$ is the
probability of measuring $ket(1)$.

=== Bloch Sphere
Geometric representation of a single qubit state:
$ ket(psi)=cos theta/2 ket(0)+ e^(i phi) sin theta/2 ket(1) $

== Measurement (Mērījumi)
- Projective measurement in the computational basis ${ket(0), ket(1)}$.

- If state is $ket(psi)=alpha ket(0) + beta ket(1)$:
  - Outcome $0$: probability $P(0)=abs(braket(0, psi))^2=abs(alpha)^2$.
    Post-measurement state: $ket(0)$.
  - Outcome $1$: probability $P(1)=abs(braket(1, psi))^2=abs(beta)^2$.
    Post-measurement state: $ket(1)$.
- Measurement collapses the superposition.
- Measurement operators: $M_0=ket(0)bra(0)$, $M_1 = ket(1)bra(1)$.
  $sum_m M_m^dagger M_m=I$.
