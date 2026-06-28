#!/bin/bash
#SBATCH --job-name=apptainer_test
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=4G
#SBATCH --time=00:10:00
#SBATCH --output=apptainer_%j.out

# Load container and run scientific calculation
apptainer exec ~/scientific-python.sif python3 - << 'PYEOF'
import numpy as np
import scipy.linalg as la

# Simple benchmark - matrix eigenvalues
A = np.random.rand(500, 500)
A = A + A.T  # symmetric matrix

eigenvalues = la.eigvalsh(A)

print(f"Matrix size: 500x500")
print(f"Min eigenvalue: {eigenvalues.min():.6f}")
print(f"Max eigenvalue: {eigenvalues.max():.6f}")
print(f"Calculation complete inside Apptainer container")
PYEOF
