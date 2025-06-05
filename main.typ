#import "@preview/fletcher:0.5.7" as fletcher: diagram, edge, node
#import "@preview/gentle-clues:1.2.0": *
#import "@preview/physica:0.9.5": bra, braket, ket, ketbra
#import "@preview/quill:0.6.1": *
#import "@preview/quill:0.6.1" as quill: tequila as tq
#import "layout.typ": indent-par, project

#show: project.with(title: [Quantum Computation Cheatsheet], authors: (
  "Kristofers Solo",
))

#let distance = $space.quad space.quad$

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

= Single Qubit Unitary Transformations
Quantum gates are unitary matrices $U$.
$ U U^dagger=U^dagger U=I $
=== Properties

Linearity
$(U(alpha ket(psi_1)+beta ket(psi_2))=alpha U ket(psi_1)+beta U ket(psi_2))$
and preserves vector length.
=== Matix form
If $U ket(0)=a ket(0)+b ket(1))$ and $U ket(1)=c ket(0) + d ket(1)$, then
$ U=mat(a, c; b, d) $

Columns (and rows) must be orthonormal vectors: \
$arrow(v_1^*) dot arrow(v_2)=0$ and $abs(arrow(v_1))^2=1$.

== Pauli Gates
=== I (Identity)
$
  I=mat(1, 0; 0, 1) distance
  cases(
    I ket(0)=ket(0),
    I ket(1)=ket(1)
  )
$

=== X (NOT)
Bit flip
$
  X=mat(0, 1; 1, 0) distance
  cases(
    X ket(0)=ket(1),
    X ket(1)=ket(0)
  )
$

=== Y Gate
$
  Y=mat(0, -i; i, 0) distance
  cases(
    Y ket(0)=-i ket(1),
    Y ket(1)=i ket(0)
  )
$

=== Z Gate
Phase flip
$
  Z=mat(1, 0; 0, -1) distance
  cases(
    Z ket(0) = ket(0),
    Z ket(1) = -ket(1),
  )
$

== Hadamard Gate ($H$)
Creates superpositions
$
  H=1/sqrt(2) mat(1, 1; 1, -1) distance
  cases(
    H ket(0)=1/sqrt(2) ket(0) + 1/sqrt(2) ket(1),
    H ket(-1)=1/sqrt(2) ket(0) - 1/sqrt(2) ket(1)
  ) \
  cases(
    H ket(0)=ket(+),
    H ket(1)=ket(-)
  ) distance
  H H=H^2=I
$

== Phase Gates
=== $S$ Gate $(sqrt(Z))$
$ S= mat(1, 0; 0, i) distance S^2=Z $

=== $T$ Gate $(pi/8))$
$ T= mat(1, 0; 0, e^(i pi/4)) distance T^2=S $

== Rotation Gates ($R_n (theta)$)
$
  R_x (theta)=
  e^((-i theta X)/2)=
  mat(
    cos theta/2, -i sin theta/2;
    -i sin theta/2, cos theta/2
  )
$

$
  R_y (theta)=
  e^((-i theta Y)/2)=
  mat(
    cos theta/2, -sin theta/2;
    sin theta/2, cos theta/2
  )
$

$
  R_z (theta)=
  e^((-i theta Z)/2)=
  mat(
    e^((-i theta)/2), 0
    0, e^((i theta)/2)
  )
$

#tip[
  $R_alpha: cases(
    R_alpha ket(0):cos alpha ket(0)+sin alpha ket(1),
    R_alpha ket(1):-sin alpha ket(0)+cos alpha ket(1),
  )$. This is $R_y(-2 alpha)$.]

== Game Compositions
Applied right to left. $U V ket(psi)=U(V ket(psi))$.
- $H Z H=X$
- $H X H=Z$

== Inverse Tranformation
$ U^(-1)=U^dagger $

== Non-Unitary Operations
(Not physically realizable as closed system evolution)

=== Qubit Deletion
$
  cases(
    U ket(0) = ket(0),
    U ket(1) = ket(0)
  )
$
