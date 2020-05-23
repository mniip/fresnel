Fresnel Diffraction
===================

This program numerically evaluates the Fresnel diffraction integral to compute
the amplitude/phase distribution of the EM field in a plane that is a fixed
distance behind an aperture, whose transmission function is given.

The program makes use of the convolution theorem and fast Fourier transform to
compute more efficiently.

Image Format
============
The program operates with images in the Portable PixMap (PPM, netpbm) format.
An input image describes the transmission function of the aperture: brightness
determines the amplitude of the transmitted light, and hue determines the phase
shift.

The output image similarly uses brightness and hue to encode the distribution of
the diffracted wave. Phase shift is calculated relative to an undiffracted wave
that had travelled the same distance.

Compiling
=========

To compile you would need a C compiler and `libfftw3` (for fast Fourier
transforms). Then the program can be built with `make`.

Running
=======

The program expects a newline-separated sequence of inputs on stdin. An input
looks like:
```
<input.ppm> <output.ppm> <lambda> <distance> <flags>
```
Here `<input.ppm>` is the input image (see Image Format) describing the
transfer function of the aperture, `<output.ppm>` is the output image where the
distribution of the diffracted light would be written, `<lambda>` is light
wavelength in pixels, `<distance>` is the distance between the aperture and the
screen in pixels.

`<flags>` is zero or more letters:
 - `i` (intensity): instead of an amplitude-phase distribution, the resulting
   image will contain a black and white distribution of intensity (squared
   amplitude).
 - `s` (split view): render intensity in the top half of the image and
   amplitude-phase in the bottom half.
 - `x`: assume the input image to be periodic in the X direction. This causes
   light to "wrap around" the left/right sides of the screen. Otherwise the
   image is assumed to be of finite size, surrounded by an infinite plane that
   blocks all light.
 - `y`: assume the input image to be periodic in the Y direction.
 - `m` (measure): spend some time figuring out what's the best way to do the
   Fourier transform, so that multiple inputs of the same input size can be
   processed faster.
 - `p` (patient): spend even more time figuring out how to do the Fourier
   transform. This is rarely useful.

Integration
===========

We calculate the Fresnel diffraction integral with dx = dy = 1 pixel. Such
integration breaks down if distance to a point on the aperture varies too much
between adjacent screen pixels, in particular if
`sqrt(x^2+d^2)/(lambda x) < 1 pixel`, where `x` is the characteristic size of
the screen.
