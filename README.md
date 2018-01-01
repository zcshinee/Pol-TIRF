# Pol-TIRF
This demo code is based on the paper "3D super-resolved multi-angle TIRF via polarization modulation". It is used in Pol-TIRF method described in the paper for recovering 3D super-resolved cell organell structure. 

### Running the code
Pol_demo.m is used for polarization demodulation. To use this code, point spread function (PSF) and recordings under different polarization saved as '.mat' files are necessary.

ADMM_demo.m is used for MA-TIRF three dimensional reconstruction. To use this code, TIRF recordings under different illumination angles saved as '.mat' file is needed.


### Included example data
To allow users to experiment with the code without building their own Pol-TIRF system, we've provided an example raw data for both codes. The raw data is for a Tubulin sample in Vero cells.
