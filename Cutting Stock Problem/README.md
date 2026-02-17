# Cutting Stock Problem (GAMS) — `CSP.gms`

This repository contains a single GAMS model, `CSP.gms`, that solves a **cutting stock problem** formulated as a **linear program (LP)**.

At a high level, the model chooses how much to use each _cutting pattern_ to meet item demand while respecting additional limits, minimizing total cost.

---

## What the model does

The file `CSP.gms` defines and solves an LP of the form:

$
\min \sum_{i \in I} c_i x_i
$

Subject to:

- **Demand constraints** (first 3 constraints):
  $
  \sum_{i \in I} a_{j,i} x_i \ge \text{rhs}_j \quad (j = c1, c2, c3)
  $
- **Capacity/limit constraints** (last 2 constraints):
  $
  \sum_{i \in I} a_{j,i} x_i \le \text{rhs}_j \quad (j = c4, c5)
  $
- Nonnegativity:
  $
  x_i \ge 0
  $

**Interpretation (typical cutting stock meaning):**

- `i` indexes _cutting patterns_ (or decision options).
- `x(i)` is how many times pattern `i` is used (continuous in this model).
- `a(j,i)` is how many units of item/requirement `j` are produced/consumed by pattern `i`.
- `rhs(j)` provides the required demand (for `c1–c3`) and upper limits (for `c4–c5`).
- `c(i)` is the per-pattern cost.

---

## Repository contents

- `CSP.gms` — GAMS model file (LP formulation + embedded data).

No external data files are required; all data is embedded in the `.gms` file.

---

## Prerequisites & system requirements

### Required

- **GAMS** installed (any recent version that supports LP solving).
  - GAMS includes at least one LP solver; available solvers depend on your license and installation.

### Recommended

- **GAMS Studio** (bundled with many GAMS installs) for easy editing/running.
- A licensed LP solver (e.g., CPLEX, GUROBI) if you want faster solves on larger instances (not necessary for this small model).

### OS

- Windows / macOS / Linux (wherever GAMS is supported).

---

## How to run

### Option A: GAMS command line

From the folder containing `CSP.gms`:

```bash
gams CSP.gms
```

Common useful flags:

```bash
gams CSP.gms lo=2
```

- `lo=2` increases log output verbosity in the console.

### Option B: GAMS Studio

1. Open **GAMS Studio**
2. Open `CSP.gms`
3. Click **Run** (▶)

---

## Inputs (embedded in `CSP.gms`)

All “inputs” are declared directly in the GAMS file.

### 1) Sets

```gams
Set
    i  'decision–variable index' /1*19/
    j  'constraint index'        /c1*c5/ ;
```

- There are **19 decision variables** (`x1 … x19`) and **5 constraints** (`c1 … c5`).

### 2) Objective coefficients `c(i)`

```gams
Parameter c(i) / ... / ;
```

- Defines cost per unit of `x(i)`.

⚠️ **Important GAMS behavior:** any `c(i)` not explicitly listed defaults to **0**.
With the current file, only some indices have costs; others are zero-cost unless you fill them in.

### 3) Constraint matrix `a(j,i)`

```gams
Table a(j,i)
   ...
;
```

- `a(j,i)` is the coefficient of variable `x(i)` in constraint `j`.
- Blank table entries are treated as **0**.

### 4) Right-hand sides `rhs(j)`

```gams
Parameter rhs(j) / c1 65, c2 80, c3 100, c4 150, c5 100 / ;
```

- `rhs(c1..c3)` are **minimum requirements** (because those constraints are `=g=`).
- `rhs(c4..c5)` are **upper limits** (because those constraints are `=l=`).

---

## Model logic & workflow (how the code is structured)

### Variables

```gams
Positive Variable x(i) ;
Variable          z   ;
```

- `x(i)` are **continuous** and **nonnegative**.
- If you need integer numbers of stock rolls/pattern uses, you’d typically switch to `Integer Variable x(i);` (not done here).

### Equations

```gams
obj..  z =e= sum(i, c(i)*x(i)) ;

gcon(j)$(ord(j) <= 3)..  sum(i, a(j,i)*x(i)) =g= rhs(j) ;
lcon(j)$(ord(j)  > 3)..  sum(i, a(j,i)*x(i)) =l= rhs(j) ;
```

- `ord(j)` is the position of `j` in its set ordering:
  - `c1` → 1, `c2` → 2, `c3` → 3, `c4` → 4, `c5` → 5

- The model uses this to split constraints:
  - `c1–c3` become **≥** constraints (`=g=`).
  - `c4–c5` become **≤** constraints (`=l=`).

### Solve and display

```gams
Solve lpModel using lp minimizing z ;
Display z.l, x.l ;
```

- Solves as an LP minimization.
- Prints:
  - `z.l` = objective value at the solution
  - `x.l` = levels (solution values) of each decision variable

---

## Outputs & where to find them

When you run the model, GAMS writes:

- A **listing file** (typically `CSP.lst`) containing the solve log and the `Display` results.
- Console output (amount depends on `lo` setting).

**Key outputs:**

- `z.l` — optimal objective value
- `x.l(i)` — how much each pattern `i` is used

---

## Example usage

### Run

```bash
gams CSP.gms lo=2
```

### Example output (what to look for)

In the `.lst` file (and sometimes in console), you’ll see something like:

```text
----     1 VARIABLE z.L                   =        <value>

----     1 VARIABLE x.L

i1   <value>
i2   <value>
...
i19  <value>
```

**Interpreting `x.l`:**

- If `x.l('7') = 12`, it means pattern 7 is used 12 times (again: continuous in this model).

**Note about the provided data:** because some `c(i)` values are not specified in the file, those costs default to **0**, which can lead to solutions with **zero objective value** if the constraints can be satisfied using only zero-cost variables. If you intend every pattern to have a positive cost, make sure `c(i)` is fully specified for all `i`.

---

## Customization guide

### Change demand/limits

Edit `rhs(j)`:

```gams
Parameter rhs(j) / c1 70, c2 80, c3 120, c4 150, c5 100 / ;
```

### Change pattern definitions

Edit the `Table a(j,i)` coefficients. Adding/removing patterns means you should also update the set `i /1*19/`.

### Add more constraints

If you expand `j` beyond `c1*c5`, **do not rely on** `ord(j) <= 3` unless your ordering still matches the intended split between demand (≥) and limits (≤). A clearer pattern is to define separate sets, e.g. `jdemand` and `jlimit`, and write constraints based on set membership.

### Make pattern usage integer (optional)

If you want integer pattern counts:

```gams
Integer Variable x(i);
```

(Keep in mind: that changes the problem to a MIP, not an LP.)

---

## Troubleshooting

- **“No solver available” / solver license issues:**
  Your GAMS installation may not include an LP solver you can use under your license. Check your GAMS distribution and license, or specify another available solver.

- **Objective value unexpectedly 0:**
  Check `c(i)` values. Unspecified `c(i)` defaults to 0 in GAMS.

- **Model infeasible:**
  Your demand (`c1–c3`) may be too high relative to what patterns can produce and/or what the limit constraints (`c4–c5`) allow.

---

## Assumptions (based on the code)

- This is a **pre-enumerated-pattern LP** (not column generation): all patterns/options are already encoded in `a(j,i)`.
- Decision variables are **continuous** (`Positive Variable`), so this is an LP relaxation unless you change variable types.
