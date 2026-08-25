# GAMS Optimization Portfolio

[![Repository hygiene](https://github.com/sina-04/GAMS-Optimization-Portfolio/actions/workflows/hygiene.yml/badge.svg)](https://github.com/sina-04/GAMS-Optimization-Portfolio/actions/workflows/hygiene.yml)
[![License: MIT](https://img.shields.io/badge/original%20code-MIT-yellow.svg)](LICENSE_SCOPE.md)

A curated collection of mathematical-optimization models written in GAMS for
operations research and industrial-engineering study.

## Portfolio index

| Area | Model | Type | Documentation | License status |
| --- | --- | --- | --- | --- |
| Cutting stock | [`CSP.gms`](Cutting%20Stock%20Problem/CSP.gms) | LP | [Guide](Cutting%20Stock%20Problem/README.md) | MIT |
| Facility location | [`OptimalLocationFinder.gms`](Facilities%20Design%20Modeling/OptimalLocationFinder.gms) | LP | [Guide](Facilities%20Design%20Modeling/README.md) | MIT |
| Bootcamp exercises | [Exercise index](GAMS%20Bootcamp%20Exercises/README.md) | LP, MILP, NLP, MINLP, multi-objective | Section index | Excluded |

## Run a model

Install a current version of
[GAMS](https://www.gams.com/download/) with a solver suitable for the model,
then run from the model's directory:

```bash
gams CSP.gms
```

GAMS Studio can also open and run each `.gms` file. Solver availability and
problem-size limits depend on the local GAMS installation and license.

Generated `.log`, `.lst`, `.lxi`, and restart files are intentionally
ignored. They include machine-specific paths and solver metadata and should be
regenerated locally rather than committed.

## Repository organization

- **Original models** have dedicated explanations of formulation, inputs,
  assumptions, execution, and interpretation.
- **Bootcamp exercises** are separated by model family and clearly excluded
  from the repository's MIT grant.
- Path names are kept Windows-compatible so the complete repository can be
  cloned across supported desktop platforms.

## Limitations

These models are educational examples. Validate units, data, solver status,
optimality gaps, and business constraints before using any result in an
operational decision.

## License

Original work is available under the [MIT License](LICENSE). Read
[`LICENSE_SCOPE.md`](LICENSE_SCOPE.md) for the exact boundary; course-derived
exercises and their data are excluded.
