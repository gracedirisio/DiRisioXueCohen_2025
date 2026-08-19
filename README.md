## Neuronal signatures of successful one-shot memory in visual cortex

### Code and source data repository. 

DiRisio, G. F., Xue, C., & Cohen, M. R. (2025). Neuronal Signatures of Successful One-Shot Memory in Mid-Level Visual Cortex. https://doi.org/10.1101/2025.09.22.677855
***
This repository is organized to recreate all main figures from the paper. Each figure can be generated using scripts in the GenerateFigures directory.
### Directory information:
GenerateFigures: Start point to generate each figure from the paper. Each script corresponds to a figure panel that includes data (Figures 2-6). Running this will load the required data (found in SourceData) and call from helperFunctions/ to generate subpanels of each figure.

helperFunctions: Reusable functions used by GenerateFigures/ to create specific subfigures. Not intended to be run directly.

SourceData: All processed data required for figure reproduction. The associated raw neural and behavioral data can be made available upon request.

### Requirements:
MATLAB (tested on 2024b) \
Toolboxes: Statistics and Machine Learning Toolbox

### Contact:
For questions or issues, please reach out to gdirisio@uchicago.edu
