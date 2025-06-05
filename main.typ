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
#let tensor = $lr(times.circle)$
#let CNOT = $lr(C N O T)$
#let CCNOT = $lr(C C N O T)$
#let SWAP = $lr(S W A P)$
#let CU = $lr(C-U)$
#let QFT = $lr(Q F T)$

= Bra-Ket Notation
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

==== Example: $ket(psi)=(1+2i)/sqrt(7)ket(0)+(1-i)/sqrt(7)ket(1)$
$
  P(0) & =abs((1+2i)/sqrt(7))^2=(1^2+2^2)/7=5/7   \
  P(1) & =abs((1-i)/sqrt(7))^2=(1^2+(-1)^2)/7=2/7
$
#tip[ Sum must be $1$. ]

= Single Qubit Unitary Transformations
Quantum gates are unitary matrices $U$.
- Unitary condition: $U U^dagger=U^dagger U=I$, where $U^dagger$ is the
  conjugate transpose.
- Action on state $ket(psi')=U ket(psi)$

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
#figure(quantum-circuit(..tq.build(tq.x(0))))
$
  X=mat(0, 1; 1, 0) distance
  cases(
    X ket(0)=ket(1),
    X ket(1)=ket(0)
  )
$

=== Y Gate
#figure(quantum-circuit(..tq.build(tq.y(0))))
$
  Y=mat(0, -i; i, 0) distance
  cases(
    Y ket(0)=-i ket(1),
    Y ket(1)=i ket(0)
  )
$

=== Z Gate
Phase flip
#figure(quantum-circuit(..tq.build(tq.z(0))))
$
  Z=mat(1, 0; 0, -1) distance
  cases(
    Z ket(0) = ket(0),
    Z ket(1) = -ket(1),
  )
$

== Hadamard Gate ($H$)
Creates superpositions
#figure(quantum-circuit(..tq.build(tq.h(0))))
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
#figure(quantum-circuit(..tq.build(tq.s(0))))
$ S= mat(1, 0; 0, i) distance S^2=Z $

=== $T$ Gate $(pi/8))$
#figure(quantum-circuit(..tq.build(tq.t(0))))
$ T= mat(1, 0; 0, e^(i pi/4)) distance T^2=S $

== Rotation Gates ($R_n (theta)$)
#figure(quantum-circuit(..tq.build(tq.rx($theta$, 0))))
$
  R_x (theta)=
  e^((-i theta X)/2)=
  mat(
    cos theta/2, -i sin theta/2;
    -i sin theta/2, cos theta/2
  )
$

#figure(quantum-circuit(..tq.build(tq.ry($theta$, 0))))
$
  R_y (theta)=
  e^((-i theta Y)/2)=
  mat(
    cos theta/2, -sin theta/2;
    sin theta/2, cos theta/2
  )
$

#figure(quantum-circuit(..tq.build(tq.rz($theta$, 0))))
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

= Multi-Qubit Systems
== Tensor product
Combines state space.

$
  (a ket(0)+b ket(1)) tensor (c ket(0) + d ket(1)) = \ =
  a c ket(00)+ a d ket(01) + b c ket(10) + b d ket(11)
$

For $k$ qubits, $2^k$ basis states.

=== Operators
$
  (A tensor B)
  (ket(psi_A) tensor ket(psi_B))=
  (A ket(psi_A)) tensor (B ket(psi_B))
$

== Product States vs. Entangled States

=== Product state
Can be written as $ket(psi_A)tensor ket(psi_B)$.

==== Example
$
  1/2(ket(00)+ket(01)+ket(10)+ket(11))= \ =
  (1/sqrt(2)(ket(0)+ket(1))) tensor (1/sqrt(2)(ket(0)+ket(1)))
$
=== Entangled States
Cannot be factored

==== Example
$
  1/sqrt(2)(ket(00)+ket(11)) ("Bell state" ket(Phi^+))
$

#figure(quantum-circuit(
  lstick($ket(0)$),
  gate($H$),
  ctrl(1),
  1,
  [\ ],
  lstick($ket(0)$),
  1,
  targ(),
  1,
))

== Multi-Qubit Measurement & Normalization
Measure one qubit from a multi-qubit system.
==== Example
===== State
$
  a ket(00)+b ket(01) + c ket(10) + d ket(11)
$
===== Measure 1st qubit
====== Prob of $0$
$
  P(q_1=0)=abs(a)^2+abs(b)^2
$
Post-measurement state:
$
  (a ket(00)+ b ket(01))/sqrt(abs(a)^2+abs(b)^2)=
  ket(0) tensor
  (a ket(0) + b ket(1))/(sqrt(abs(a)^2+abs(b)^2))
$

====== Prob of $1$
$
  P(q_1=1)=abs(c)^2+abs(d)^2
$
Post-measurement state:
$
  (c ket(10)+ d ket(11))/sqrt(abs(c)^2+abs(d)^2)=
  ket(1) tensor
  (c ket(0) + d ket(1))/(sqrt(abs(c)^2+abs(d)^2))
$
==== Example
===== State
$
  2/3 ket(00)+1/3 ket(01)+2/3 ket(10)
$
===== Measure 1st qubit
====== Prob of $0$
$
  P(0)=(2/3)^2+(1/3)^2=5/9
$
State of 2nd qubit:
$
  (2/3 ket(0) + 1/3 ket(1))/sqrt(5/9)=
  1/sqrt(5)(2 ket(0) + ket(1))
$

====== Prob of $1$
$
  P(1)=(2/3)^2=4/9
$
State of 2nd qubit:
$
  (2/3 ket(0))/sqrt(4/9)=
  ket(0)
$

= Quantum Logic Gates & Circuits
== Common Multi-Qubit Gates

=== $CNOT$ (Controlled-NOT)
$ CNOT ket(c) ket(t)=ket(c)ket(t tensor c) $
#figure(quantum-circuit(..tq.build(tq.cx(0, 1))))

=== $SWAP$ Gate
Swaps two qubits.
#figure([
  #quantum-circuit(..tq.build(tq.swap(0, 1)))
  or
  #quantum-circuit(..tq.build(tq.cx(0, 1), tq.cx(1, 0), tq.cx(0, 1)))
])

=== Toffoli Gate ($CCNOT$)
$ CCNOT ket(c_1 c_2 t)=ket(c_1 c_2 t tensor (c_1 dot c_2)) $
#figure(quantum-circuit(..tq.build(tq.ccx(0, 1, 2))))

=== Universality (Universalitāte)

Jebkurai unitārai $U$: $U=U_m U_(m-1) ... U_1$, katra $U_i$ maina tikai 2 bāzes
stāvokļus
$
  U_i ket(x_1 ... x_n)=a ket(x_1 ... x_n) + b ket(y_1 ... y_n) \
  U_i ket(y_1 ... y_n)=c ket(x_1 ... x_n) + d ket(y_1 ... y_n) \
  U_i ket(z_1 ... z_n)=ket(z_1 ... z_n)
$
ja $z_1 ... z_n != x_1 ...x_n$, $z_1 ... z_n != y_1 .. y_n$.

= Key Quantum Protocols & Concepts
== No-Cloning Theorem
Impossible to create and identical copy of an arbitrary unknown quantum state.

== Quantum Teleprotation
Transmits $ket(psi)=a ket(0) + b ket(1)$ using an entangled pair
$ket(Phi^+)_(A B)=1/sqrt(2)(ket(00)+ket(11))$ and $2$ classical bits.

Initial state (Alice has $ket(psi)_C$ and qubit $A$, Bob has $B$):
$
  ket(psi)_C tensor ket(Phi^+)_(A B)= \ =
  (a ket(0)_C+b ket(1)_C)1/sqrt(2)(ket(0_A 0_B)+ket(1_A 1_B))= \ =
  a/sqrt(2)ket(000)+a/sqrt(2)ket(011)+b/sqrt(2)ket(100)+b/sqrt(2)
$
(qubits $C$, $A$, $B$)

Alice applied $CNOT$ ($C$ is control, $A$ is target):
$
  a/sqrt(2) ket(000)+a/sqrt(2)ket(011)+b/sqrt(2)ket(110)+b/sqrt(2)ket(101)
$

Alice applies $H$ to qubit $C$:
$
  1/2[
    a(ket(0)+ket(1))ket(11)+
    a(ket(0)+ket(1))ket(11)+ \ +
    b(ket(0)-ket(1))ket(10)+
    b(ket(0)-ket(1))ket(01)
  ]
$

Regroup by Alice's qubits $C A$:
$
  1/2[
    ket(00)_(C A) (a ket(0) + b ket(1))+
    ket(01)_(C A) (a ket(1) + b ket(0))+ \ +
    ket(10)_(C A) (a ket(0) - b ket(1))+
    ket(11)_(C A) (a ket(1) - b ket(0))
  ]
$

Alice measures $C A$, sends 2 classical bits to Bob. Bob applies correction to
his qubit $B$:
- Alice gets $00 ==>$ Bob has $a ket(0)+b ket(1)$ (Needs $I$).
- Alice gets $01 ==>$ Bob has $a ket(1)+b ket(0)$ (Needs $X$).
- Alice gets $10 ==>$ Bob has $a ket(0)-b ket(1)$ (Needs $Z$).
- Alice gets $11 ==>$ Bob has $a ket(1)-b ket(0)$ (Needs $Z X$).

== Dense Coding (Bļīvā kodēšana)
Sends 2 classical bits of information From Alice to Bob by sending only 1 qubit,
using pre-shared entangled pair.
=== Steps
+ Alice and Bob share $ket(Phi^+)_(A B)$
+ To send classical bits $x y$:
  - $00$: Alice does nothing (applies $I$) to her qubit.
  - $01$: Alice applies $X$ to her qubit.
  - $10$: Alice applies $Z$ to her qubit.
  - $11$: Alice applies $X$ then $Z$ (or $i Y$) to her qubit.
+ Alice sends her modified qubit to Bob.
+ Bob performs a Bell measurement on the two qubits he now possesses to recover
  $x y$.

= Quantum Algorithms
== Oracle ($U_f$)
Black box for $f(x)$.

$
  U_f ket(x)ket(y)=ket(x)ket(y tensor f(x))
$
=== Phase kickback
$
  "If " ket(y)=ket(-)=1/sqrt(2)(ket(0)-ket(1)), "then"\
  U_f ket(x)ket(-)=(-1)^(f(x))ket(x)ket(-)
$

== Deutsch's Algorithm
- Problem: $f:{0,1}->{0,1}$ Constant or balanced? One query.
- Task: Calculate $(f(0)+f(1))(mod 2)$.
- Circuit:
  $
    ket(0)ket(1) stretch(->)^(H tensor H)
    1/2 sum_x ket(x)(ket(0)-ket(1)) stretch(->)^(U_f) \ stretch(->)^(U_f)
    1/2 sum_x (-1)^(f(x)) ket(x)(ket(0)-ket(1)) stretch(->)^(H tensor I) \
    stretch(->)^(H tensor I)_"Result on 1st qubit:"
    1/2 ((-1)^f(0)+(-1)^f(1))ket(0)+ \ +
    1/2 ((-1)^f(0)-(-1)^f(1))ket(1)
  $
- Measure 1st qubit:
  - If $f(0)=f(1)$ (constant), state is $plus.minus ket(0)$. \
    Measure $0$. $(f(0)+f(1))(mod 2)=0$.
  - If $f(0)!=f(1)$ (balanced), state is $plus.minus ket(1)$. \
    Measure $1$. $(f(0)+f(1))(mod 2)=1$.

== Grover's Search Algorithm
- Problem: Find $x_w$ s.t. $f(x_w)=1$ (marked item) in $N=2^n$ items.
- Oracle $O$: $O ket(x)=(-1)^f(x) ket(x)$.
- Grover Diffusion Operator $D$ (Inversion about the mean):
  $D = 2 ket(s)bra(s) - I$, where $ket(s) = H^(tensor n) ket(0)^(tensor n)$.
- Grover Iteration: $G= D O$.
- Algorithm:
  + Start $ket(s)$.
  + Repeat $G$ for $k$ iterations.
    - 1 marked item $(L=1)$: $k approx pi/4 sqrt(N)$
    - $L$ marked items: $k approx pi/4 sqrt(N/L)$
  + Measure. High probability of marked item.
- Geometric Interpretation:
  Rotation in 2D plane spanned by $ket(s)$ and $ket(w)$ (superposition of marked
  items). \
  More precisely, plane spanned by $ket(Psi_1)=1/sqrt(L) sum_(x:f(x)=1) ket(x)$
  and $ket(Psi_0)=1/sqrt(N-L) sum_(x:f(x)-0)ket(x)$. \
  Initial state $ket(s)=sin alpha ket(Psi_1)+cos alpha ket(Psi_0)$, where
  $sin alpha = sqrt(L/N)$. \
  Oracle $O$ reflects about $ket(Psi_0)$. Diffusion $D$ reflects about $ket(s)$.
  Each Iteration $G = D O$ rotates by $2alpha$. \
  After $k$ iterations, angle with $ket(Psi_0)$ is $(2k+1)alpha$. \
  Prob. of measuring a marked item: $sin^2((2k+1)alpha)$.
- Unknown $L$: Iterative deepening: try iterations
  $t=1,3,3^2,..., "up to" approx sqrt(N)$

== Quantum Fourier Transform (QFT)
- Definition: $ QFT_N ket(j)=1/sqrt(N) sum_(k=0)^(N-1) e^((2pi i j k)/N) ket(k) $
  Let $omega_N=e^((2 pi i)/N)$.
- Circuit: Uses $H$ and controlled-$R_m$ gates
  ($ R_m = mat(
    1, 0; 0,
    e^((2pi
    i)/2^m)
  ) $), then $SWAP$s.
- Property (Periodicity):
  If input is periodic sum $ ket(psi)=1/sqrt(q) sum_(l=0)^(q-1) ket(a+l p) $
  (where $N=p q$, period $p$), then
  $ QFT_N ket(psi)=1/sqrt(p) sum_(k=0)^(p-1) c_k ket(k dot N/p) $ (Output is
  superposition of multiples of $N/p$).


#figure(quantum-circuit(..tq.qft(3)))

== Period Finding (Kvantu algoritms perioda atrašanai)
- Problem: Given $f(x) = f(x+r)$, find period $r$. $N$ is size of domain.
- Algorithm:
  + $
      1/sqrt(N) sum_(x=0)^(N-1) ket(x)ket(0)->^U_f
      1/sqrt(N) sum_(x=0)^(N-1) ket(x) ket(f(x))
    $
  + Measure 2nd register (gets some $y_0$).
    1st register becomes
    $
      1/sqrt(M) sum_(k:f(k)=y_0) ket(k) approx
      1/sqrt(N/r) sum_(j=0)^(N/r-1) ket(x_0 + j r)
    $
  + Apply $QFT_N$ to 1st register. Result is superposition of states $k dot N/r$.
  + Measure 1st register. Get some value $m_j approx j dot N/r$.
- Classical Post-processing:
  If $N$ is a multiple of $r$: $m_j = j dot N/r$.
  Find $r$ using $gcd(m_j, N)$ and continued fractions / Euclidean algorithm to
  find $j/r$ from $m_j/N$.

== Shor's Algorithm (Skaitļa sadalīšanai reizinātājos)
- Reduces factoring $N$ to finding order $r$ of $a^x (mod N)$.
  Uses Period Finding for $f(x)=a^x (mod N)$.
- Order $r$ of $a^x (mod N)$: Smallest $r>0$ s.t. $a^r eq.triple 1 (mod N)$.

== Simon's Algorithm

- Problem: Given $f: {0,1}^n -> {0,1}^n$ such that
  $f(x) = f(y)$ if $x plus.circle y = s$ for some secret string $s in {0,1}^n$ (or $x=y$, i.e., $s=0^n$). Find $s$.
- Algorithm:
  + Prepare $H^(tensor n) ket(0)^(tensor n)ket(0)^(tensor n)$.
  + Apply: $U_f: 1/sqrt(2^n) sum_x ket(x) ket(f(x))$.
  + Measure second register. First register collapses to
    $1/sqrt(2)(ket(x_0)+ket(x_0 plus.circle s))$ for some $x_0$.
  + Apply $H^(tensor n)$ to the first register.
  + Measure first register to get string $y$ such that\ $y dot s = 0 (mod 2)$.
  + Repeat $n-1$ times to get $n-1$ linearly independent equations for $s$.
    Solve the system to find $s$.

= Advanced Topics
== Density Matrices (Blīvuma matricas $rho$)
- Describes quantum states, including mixed states (statistical ensemble of pure states).
- Pure state $ket(psi): rho=ket(psi)bra(psi)$.
- Mixed state: $rho = sum_i p_i ket(psi_i)bra(psi_i)$, where $p_i$ are probabilities, $sum p_i = 1$.
- Properties:
  - $T r (rho)=1$.
  - $rho^dagger=rho$ (Hermitian).
  - $rho$ is positive semi-definite (eigenvalues $>=0$).
- Evolution: $rho'=U rho U^dagger$.
- Measurement: Probability of outcome $m: P(m) =T r(M_m^dagger M_m rho)$.
  Post-measurement state: $(M_m rho M_m^dagger)/(T r (M_m rho M_m^dagger))$
- Purity: $T r(rho)^2<=1$. $T r(rho)^2=1$ if $rho$ is a pure state.
- Partial Trace ($T r_B$): If $rho_(A B)$ describes system $A B$,
  $rho_A=T r_B(rho_(A B))$ describes system $A$.

== Quantum Cryptography
=== BB84 Protocol
+ Alice chooses random bits and random bases (rectilinear $+$ or diagonal
  $times$) for each bit.
  - $0 -->^+ ket(0), 1 -->^+ ket(1)$
  - $0 -->^times ket(+), 1 -->^times ket(-)$
+ Alice sends qubits to Bob.
+ Bob chooses random bases to measure each qubit.
+ Alice and Bob publicly announce their basis choices.
  They keep bits where bases matched (sifted key).
+ They sacrifice a portion of the sifted key to estimate error rate (detect
  eavesdropping). If error rate is low, remaining bits form the secret key.

=== Security
Eavesdropping (Eve) introduces errors because she doesn't know Alice's bases and
her measurements disturb the states.

== Quantum Error Correction
Protects quantum states from decoherence and errors.

=== 3-Qubit Bit Flip Code
- Encoding: $ket(0)->ket(0_L)=ket(000), ket(1)->ket(1_L)=ket(11)$.
- Error detection: Measure stabilizers $Z_1 Z_2$, $Z_2 Z_3$.
- Correction: If $Z_1 Z_2$ flips, error on $Q 1$ or $Q 2$.
  If $Z_2 Z_3$ flips, error on $Q 2$ or $Q 3$.
  (e.g., if $Z_1 Z_2 = -1$, $Z_2 Z_3 = +1 ==>$ error on $Q 1$, apply $X_1$).

=== 3-Qubit Phase Flip Code
- Encoding: $ket(0)->ket(+_L)=ket(+++)$,\ $ket(1)->ket(-_L)=ket(---)$.
  (Hadamard basis of bit flip code).
- Error detection: Measure stabilizers $X_1 X_2$, $X_2 X_3$.

=== Shor's 9-Qubit Code
Corrects arbitrary single-qubit errors (bit flips, phase flips, or both).
Concatenates bit-flip and phase-flip codes.
$
  ket(0)->1/(2sqrt(2))(ket(000)+ket(111))(ket(000)+ket(111))(ket(000)+ket(111)) \
  ket(1)->1/(2sqrt(2))(ket(000)-ket(111))(ket(000)-ket(111))(ket(000)-ket(111)) \
$

- Stabilizer Codes: A general framework for QEC. Code space is the simultaneous
  $+1$ eigenspace of a set of commuting Pauli operators (stabilizers).
