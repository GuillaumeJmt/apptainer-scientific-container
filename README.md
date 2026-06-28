# Apptainer Scientific Containers

HPC-ready container definitions for scientific Python workflows.
Built with Apptainer (formerly Singularity) - no root daemon required.

## Why Apptainer and not Docker

Docker requires a root daemon running permanently on the host.
On shared HPC clusters this is a security problem - 500 researchers
cannot all have root access.

Apptainer runs containers as the current user, no daemon, no root.
One container = one portable .sif file that works on any Linux cluster.

## Containers

| File | Base | Packages |
|------|------|---------|
| containers/scientific-python.def | python:3.11-slim | numpy, scipy, pandas, matplotlib |

## Usage

Build the container (requires Apptainer on Linux):

    apptainer build scientific-python.sif containers/scientific-python.def

Run a script inside the container:

    apptainer exec scientific-python.sif python3 script.py

Run interactively:

    apptainer shell scientific-python.sif

Use with Slurm (see examples/):

    sbatch examples/apptainer-job.sh

## Key Apptainer commands

    apptainer build img.sif def.def        # build from definition file
    apptainer exec img.sif command         # run a command in container
    apptainer shell img.sif                # interactive shell
    apptainer inspect img.sif             # show labels and metadata
    apptainer run img.sif script.py        # run via %runscript

## Environment

- Apptainer installed on Ubuntu 24.04 ARM64 (Lima VM on Apple M1)
- Container tested with numpy 2.4.6, scipy 1.17.1, pandas 3.0.3

**Note on MPI:** mpi4py is intentionally not bundled. Installing it inside a slim image
fails (no MPI library/compiler). The correct HPC pattern is to bind-mount the host MPI
(hybrid model) for interconnect ABI compatibility.
