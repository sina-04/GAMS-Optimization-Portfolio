# Optimal Location Finder

A GAMS-based optimization model that finds the **best (x, y) location** for a new “device” (facility, hub, service point, etc.) by **minimizing the weighted sum of Manhattan (L1) distances** to a set of existing places.

In other words: given several places with coordinates and importance weights, it computes the location that minimizes

$
\sum_i w_i (|x - x_i| + |y - y_i|)
$

This is a classic **weighted 1-median / Weber problem** under **rectilinear (Manhattan) distance**, formulated as a **Linear Program (LP)** using standard absolute-value linearization.

---

## Features

- **Weighted optimal location** computation in 2D (x, y)
- Uses **Manhattan distance** (|Δx| + |Δy|), common for grid/city-block travel
- **Linear Programming (LP)** formulation (fast and scalable for many points)
- Simple, editable inputs:
  - Place set (e.g., `P1*P4`)
  - Weights `w(i)`
  - Coordinates `x_coord(i)`, `y_coord(i)`
- Clear outputs:
  - Optimal `x.l`, `y.l`
  - Objective value `OF.l` (weighted total distance)

---

## Prerequisites

- **GAMS** (any reasonably recent version that supports LP models)
- An **LP solver** available through your GAMS installation/license (commonly included options depend on your license and platform)
- OS: Windows / macOS / Linux (wherever GAMS is supported)

No external libraries are required—this is a standalone `.gms` model.

---

## Installation

1. **Install GAMS**
   - Download and install GAMS for your operating system.
   - Ensure your installation includes (or can access) an LP solver.

2. **Verify GAMS is available in your terminal (optional but recommended)**
   - Open a terminal and run:
     ```bash
     gams
     ```
   - If the command is not found, add the GAMS install directory to your `PATH`.

3. **Get the model file**
   - Place the provided file in your project folder:
     ```
     OptimalLocationFinder.gms
     ```

---

## Usage

### Run from the command line

From the folder containing `OptimalLocationFinder.gms`:

```bash
gams OptimalLocationFinder.gms
```

Optional: increase log output detail:

```bash
gams OptimalLocationFinder.gms lo=2
```

### Run in GAMS Studio (GUI)

1. Open **GAMS Studio**
2. Open `OptimalLocationFinder.gms`
3. Click **Run** (or press the run shortcut)

---

### Inputs (what you can edit)

All inputs are defined at the top of the file:

- **Places set**

  ```gams
  Set
      i Places /P1*P4/;
  ```

- **Weights and coordinates**

  ```gams
  Parameters
      w(i)       /P1 0.165, P2 0.330, P3 0.330, P4 0.165/
      x_coord(i) /P1 4,     P2 8,     P3 11,    P4 13/
      y_coord(i) /P1 2,     P2 5,     P3 8,     P4 2/;
  ```

To add more places, expand the set and provide values for each parameter (or switch to loading from a data file, if you extend the model).

---

### Model behavior (how it works)

The model introduces nonnegative variables:

- `p(i)` = |x − x_coord(i)| (absolute distance in x)
- `q(i)` = |y − y_coord(i)| (absolute distance in y)

Absolute values are linearized using inequalities:

```gams
x_abs1(i).. p(i) =g= x - x_coord(i);
x_abs2(i).. p(i) =g= x_coord(i) - x;

y_abs1(i).. q(i) =g= y - y_coord(i);
y_abs2(i).. q(i) =g= y_coord(i) - y;
```

Objective:

```gams
Obj .. OF =e= sum(i, w(i) * (p(i) + q(i)));
```

Solved as:

```gams
Solve OptimalLocationFinder using LP minimizing OF;
```

---

### Outputs (what you get)

The model displays:

```gams
Display x.l, y.l, OF.l;
```

- `x.l` = optimal x-coordinate
- `y.l` = optimal y-coordinate
- `OF.l` = minimized weighted total Manhattan distance

#### Example (using the included sample data)

With the provided four places, the optimal solution has:

- `y.l = 5`
- `x.l` may be **any value in the interval [8, 11]** (multiple optimal solutions can exist with L1 objectives and “tie” weights)
- `OF.l = 4.455` (for any x in [8, 11] when y = 5)

So you may see output resembling:

```
----     x.l  = 8
----     y.l  = 5
----    OF.l  = 4.455
```

> Note: If your solver returns `x.l = 9` or `x.l = 11`, that can still be optimal—this model can have a **flat optimum region**.

---

### For contributors (extending the model)

Common extensions you can implement:

- **More places**: increase the set size and parameter entries
- **Data-driven inputs**: load `w`, `x_coord`, `y_coord` from a `.gdx`/`.csv` workflow
- **Constraints on location**:
  - bounding box constraints: `x =g= xmin; x =l= xmax;` (same for `y`)
  - forbidden regions (typically requires additional modeling constructs)

- **Different distance metric**:
  - Euclidean distance usually becomes **NLP/QCP** (not LP)

---

## Error Handling

### `gams: command not found` (CLI)

**Cause:** GAMS isn’t on your `PATH`.
**Fix:** Add your GAMS installation directory to `PATH`, or run using the full path to the `gams` executable.

---

### License / solver errors (e.g., “license not found”, “solver not available”)

**Cause:** Your GAMS license may not enable a commercial solver, or GAMS cannot find a licensed solver.
**Fixes:**

- Confirm your GAMS license is installed and valid
- Configure an available LP solver in your environment
- If you have multiple solvers, you can specify one (if installed) in your GAMS options/workflow

---

### Compilation errors like “Unknown symbol” or “Set is empty”

**Cause:** A place is referenced in parameters but not included in the set (or vice versa).
**Fix:** Ensure the set `i` and parameter domains match:

- Every place in `w(i)`, `x_coord(i)`, `y_coord(i)` must exist in `i`

---

### “Infeasible” (unlikely in the base model)

**Cause:** Usually introduced after adding constraints (bounds, regions, etc.).
**Fix:** Check added constraints for contradictions, and verify bounds allow at least one feasible (x, y).

---

## License

**License:** _[PLACEHOLDER]_
Add your chosen license here (e.g., MIT, Apache-2.0, GPL-3.0) and include a `LICENSE` file in the repository.

---

## Contact

**Maintainer / Support:** _[PLACEHOLDER]_

- Name:
- Email:
- Project/issues URL:
