#import "@preview/fletcher:0.5.7" as fletcher: diagram, edge, node
#import "@preview/gentle-clues:1.2.0": *
#import "@preview/physica:0.9.5": bra, braket, ket, ketbra
#import "@preview/quill:0.6.1": *
#import "@preview/quill:0.6.1" as quill: tequila as tq
#import "layout.typ": indent-par, project

#show: project.with(title: [Quantum Computation Cheatsheet], authors: (
  "Kristofers Solo",
))

= Bre-Ket Notation
== Ket $ket(psi)$
Represents a column vector for a quantum state.
$ ket(psi)=alpha ket(0)+beta ket(1) <==> vec(alpha, beta) $

=== Basis states
$ ket(0)=vec(1, 0), ket(1)=vec(0, 1) $

== Bra $bra(psi)$
Represents a *conjugate transpose vector (kompleksi saistīts)* (row vector) of
$ket(psi)$.
$ "If " ket(psi) = vec(alpha, beta) ", then" ket(psi)=(a^* space.quad b^*) $

== Scalar Product $braket(phi, psi)$
Inner product of two states.
$
  "If " ket(phi) = gamma ket(0)+ delta ket(1) ", then"
  braket(phi, psi)= gamma^* alpha + delta^* beta
$

=== Orthogonal states
$ braket(phi, psi)=0 $

== Projection $braket(i, psi)$
Amplitude of the basis state $ket(i)$ in $ket(psi)$.

For $ket(psi)=alpha ket(0) + beta ket(1) :
braket(0, psi)=alpha,
psi braket(1, psi)=beta$.

Probability of measuring state $ket(i): P(i)=abs(braket(i, psi))^2$

= Fundamentals
== Qubit (Kvantu bits)
=== Basis states
$ ket(0)=vec(1, 0), ket(1)=vec(0, 1) $

=== Superposition
A qubit can be in a linear combination of basis states:
$ ket(psi)=alpha ket(0)+ beta ket(1) ", where "alpha, beta in CC $
are probability amplitudes.

=== Normalization
$ abs(alpha)^2 + abs(beta)^2 = 1 $
$abs(alpha)^2$ is the probability of measuring $ket(0)$, $abs(beta)^2$ is the
probability of measuring $ket(1)$.

=== Bloch Sphere
Geometric representation of a single qubit state:
$ ket(psi)=cos theta/2 ket(0)+ e^(i phi) sin theta/2 ket(1) $

== Measurement (Mērījumi)
- Projective measurement in the basis (e.g. computational ${ket(0), ket(1)}$ or
  Hadamard ${ket(+), ket(-)}$).

- If state is $ket(psi)=alpha ket(0) + beta ket(1)$:
  - Outcome $0$: probability $P(0)=abs(braket(0, psi))^2=abs(alpha)^2$.
    Post-measurement state: $ket(0)$.
  - Outcome $1$: probability $P(1)=abs(braket(1, psi))^2=abs(beta)^2$.
    Post-measurement state: $ket(1)$.
- Measurement collapses the superposition (mērījums maina kvantu bitu (observer effect)).

=== Measurement operators
$
  M_0=ket(0)bra(0) ,
  M_1 = ket(1)bra(1) \
  sum_m M_m^dagger M_m=I
$

=== Measuring in $ket(+), ket(-)$ basis
$
  ket(+)=1/sqrt(2)(ket(0)+ket(1)),
  ket(-)=1/sqrt(2)(ket(0)-ket(1))
$

To measure $ket(0)$ in this basis: $ket(0)=1/sqrt(+)+1/sqrt(2)ket(-)$.
$
  P(+)=abs(braket(+, 0))^2=1/2,
  P(-)=abs(braket(-, 1))^2=1/2
$

=== Example: $ket(psi)=(1+2i)/sqrt(7)ket(0)+(1-i)/sqrt(7)ket(1)$
$
  P(0) & =abs((1+2i)/sqrt(7))^2=(1^2+2^2)/7=5/7   \
  P(1) & =abs((1-i)/sqrt(7))^2=(1^2+(-1)^2)/7=2/7
$
#tip[ Sum must be $1$. ]
