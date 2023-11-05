# The Basic Shape of Smartphone Lenses

[Untitled Database](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%20Database%20f3acd1d10d934f438cac0e81079b35fc.csv)

# Introduction

Hello, I’m Mark and welcome back to Design Optics Fast, where we provide a 21st century approach to designing optical systems.

Today we’re going to look at smartphone and other mobile lenses. These lenses are small, highly aspheric and made from polymers rather than glass. They’re a very important part of 21st century optical design, and they need modern software to design and understand.

I’ve chosen a patent from 2015 to do a deep dive on how these lenses work. It’s important to realize that patents can be misleading, can miss out important steps and can emphasize things that aren’t really important. The goal of a patent is, after all, to claim as much IP as possible while giving away as little as possible. There’s no guarantee that the design as published works satisfactorily in real life, or was ever put into production.

That said, they are a useful starting point. In a separate video I’ll go through how to optimize these lenses from scratch. I’ll hold those lenses to a higher standard. For now, we’ll take the patent as published and treat it like it is the finished design, even though it may not be.

Let’s also talk about asphericity. Asphericity was first introduced to spherical optical design as a way of providing aberration correction. A design dominated by spherical can be improved by adding a $\rho^4$ asphere. This modifies the design slightly, and gives a ‘chef’s kiss’ to the performance, but we can still discuss the lens performance in terms of traditional aberration theory. Smartphone optics, however, include such wild aspheres that it may not be possible to even use the term ‘focal length’. This means we need a whole new approach to understanding these systems.

So come on, and join me, as we do a deep dive into how smartphone lenses actually work!
[Cue jingle]

## Classic Lens Designs and Smartphones

The key thing to understanding smartphone and other small mobile cameras is that they are highly aspheric. This means that paraxial optics, and even the Lens Data Editor interface itself, are not as useful as they are in classical spherical optical design.

This shows the design of a standard Cooke triplet lens, in both the Lens Data Editor and 2D layout:

[Cooke 40 degree field.zmx](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Cooke_40_degree_field.zmx)

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled.png)

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%201.png)

Everything we need to understand this design is encapsulated in that small screenshot of the LDE. With just five parameters per surface, we have defined the system in an easy to understand format.

Here is a lens taken from the patent literature. It is the sixth embodiment of US Patent 08988789, awarded to Largan in 2015. Let’s look at the layout and LDE first.

[US08988789-6 Tidied up.zmx](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/US08988789-6_Tidied_up.zmx)

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%202.png)

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%203.png)

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%204.png)

See how hard it is to interpret the lens prescription? As well as radii of curvature, we have the conic constant and 7 aspheric coefficients per surface. It’s probably impossible only to look at the Lens Data Editor and have an intuitive grasp of what this lens system is doing. So, lets look a little deeper at what is happening here. 

## Sag, Curvature and Optical Power

In the Cooke triplet, all the surfaces of the lenses are defined using the Standard surface. The sag, or z-coordinate, of the Standard surface used is given by:

$$
z(r, k) = \frac{cr^2}{1 + \sqrt{((1+k)c^2r^2)}}
$$

where the surface curvature *c* is the reciprocal of the radius of curvature entered in the LDE, *r* is the radial coordinate in lens units $r^2 = x^2 + y^2$ and *k* is the conic constant. The conic constant is less than -1 for hyperbolas, -1 for parabolas, between -1 and 0 for ellipses, 0 for spheres, and greater than 0 for oblate ellipsoids.

The Standard surface, with k=0 to give a spherical surface, is so synonymous with optical design that we tend to think of the curvature of the surface as “just” the reciprocal of the radius of curvature cell.

$$
z(r, k=0) = \frac{cr^2}{1+|c|r}
$$

As a result, we can write the surface power and focal length as

$$
\phi = \frac{1}{f} = (n_2-n_1)c = \frac{n_2-n_1}{R}
$$

where $(n_2-n_1)$ is the refractive index difference across the surface. This leads to the identity that curvature is simply 1/(radius of curvature). This is, however, **only true of the special case of a sphere**. A sphere is that surface whose curvature is a single value at all points, and the center of curvature is the center of the sphere. Curvature itself is a wider topic.

The general curvature *c* of an optical surface is the **second derivative of the sag as measured at the surface normal to the point where the ray hits**.  For spherical surfaces, this is a constant, just 1/(the radius of curvature cell in the LDE) for all rays as we saw earlier. For aspheric surfaces (including the Standard surface with non-zero conic constant) the curvature is not a constant, and it becomes a function of multiple variables.

<aside>
🟠 In smartphone optics we are usually dealing with rotationally symmetric aspheres, so at the center x=0, y=0 the derivatives across x and y are identical. However, at any non-zero (x, y) point we can expect the second derivative of sag to be different in x and y, and so curvature will depend not only on the (x,y) coordinate but also on whether the derivative is across x, y, or some compound direction.

</aside>

The power of an aspheric optical surface is then given by the more general expression

$$
\phi(x,y) = \frac{1}{f(x,y)} = (n_2-n_1)c(x,y) = \frac{n_2-n_1}{R(x,y)}
$$

So power, focal length, curvature and radius of curvature all become functions of (x, y). As a surface becomes aspheric, concepts such as power and focal length become dependent on where on the surface the ray lands, and the angle the ray makes to the surface, as this defines the direction the curvature is measured along. This makes aspheric surfaces much more difficult to characterize than spherical surfaces, where the curvature is everywhere constant.

<aside>
🟠 Working with aspheres makes you realize that concepts you think are fixed are in fact functions of position and angle.

</aside>

You can see for example that this lens has no meaningful single ‘focal length’:

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%205.png)

What may not be so obvious is that you do not need to have this degree of wibbly-wobbly asphericity for this to be true. All the lenses in this smartphone design show variation of focal length across their apertures. 

OpticStudio has useful plots of surface curvature. Here for example is the x-curvature of surface 1 of the Cooke triplet:

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%206.png)

The curvature is everywhere the same, and is equal to 1/22.01, this being the radius of curvature given in the LDE. If I now set the conic constant of this surface to -1, we get a parabolic surface and the curvature is now:

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%207.png)

Note the curvature at the center of the surface (the surface vertex) is unaltered, but the curvature everywhere else is different. Curvature is a much more sensitive tool than just sag itself: here is the sag of surface 1 with the conic = 0 (sphere, blue line) and -1 (parabola, red line):

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%208.png)

It is very hard to tell a sphere apart from a parabola on the layout plot, but the curvature plot shows it easily.

<aside>
🟠 Curvature is a much more sensitive tool than sag!

</aside>

The optical surfaces used in the example smartphone lens are defined using the Even Asphere surface, common in these designs. The surface sag is given by 

$$
z(r, k) = \frac{cr^2}{1 + \sqrt{((1+k)c^2r^2}} + 
\alpha_1r^2 + \alpha_2r^4+ \alpha_3r^6+ \alpha_4r^8 + \alpha_{5}r^{10}+ \alpha_{6}r^{12}+ \alpha_{7}r^{14}+ \alpha_{8}r^{16}
$$

The first term is the conic asphere term used by the Standard surface, and all the conic terms for the smartphone lens we are looking at are non-zero. Since the $\alpha_1r^2$ term has the same dependence on $r^2$ as the conic asphere term, every surface in this design has $\alpha_1$ set to 0.  The remaining power series terms gives a sag contribution that goes in even powers of the radial coordinate r. The sag and curvature of surface 2 are

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%209.png)

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2010.png)

At the vertex, the curvature = 0.6439, = 1/1.553, which is the value of the radius of curvature cell. This value is fairly constant over the central half of the surface, and then slopes rapidly towards the edge of the surface where its value is ~-3.  This is not a subtle effect, even though it is fairly slowly varying across the first half of the surface aperture. The curvature changes from +0.64 to - 3 /mm, equivalent to the radius of curvature varying from +1.55 to -0.3 mm.

If we look at the next surface, we see a clearly aspheric sag profile, with a faster moving curvature:

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2011.png)

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2012.png)

You can see that the curvature changes sign around halfway across the surface, so the power and focal length of the surface go from positive to negative across the surface. It’s therefore impossible to characterize either of these surfaces as having positive or negative power or focal length, let alone give it a value.

Surface 1 is a surface that you can characterize by a single curvature over about half to three-quarters of its aperture, followed by a fast deviation at the edges. Surface 2 really cannot be characterized by any single value. The reciprocal of the radius of curvature cell will give you one datapoint, but you cannot predict the curvature at any other point from this value.

Now we can look at individual surfaces all day long, but I want to move onto what rays see as we trace them.

## The Local Radius of Curvature

Radius of curvature is intuitively easier to interpret than curvature, since radius has units of mm, and curvature has units of inverse mm. Most optical engineers are not comfortable with working in terms of curvature. Sometimes it helps to think of power, as power increases linearly with curvature. But I find that most people are happiest with the concept of a local radius of curvature.

Think of a small patch of aspheric surface. For a sufficiently small patch, the local curvature can be considered constant, and we can fit a circle, known as the osculating or ‘kissing’ circle to that patch. 

In ray-tracing, we treat rays as infinitely thin arrows that interact with the surfaces. Since the rays have zero width, when it hits a surface at some (x, y) point we can calculate the curvature at that point, along the direction the ray makes with the surface normal, take its inverse, and call this the **local radius of curvature**.

To simplify the analysis I wrote a macro that traces the chief ray at a range of field angles, finds where on each surface the ray lands, and computes the local radius of the curvature at that point:

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2013.png)

So I trace a ray, and get its x and y coordinates on a surface. I then use the operand SCUR to get the y-component of the surface curvature at that point. The local radius is just one over this curvature. Note I need to trap the case where the curvature is close to zero. This corresponds to a flat surface, and so the radius of curvature is infinite at that point. 

<aside>
💡 This is one reason why in the theory we work with curvature, which is continuous everywhere, rather than local radius which has a singularity anywhere c approaches 0.

</aside>

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2014.png)

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2015.png)

Starting with the on-axis chief ray, this interacts with local radii that are exactly as per the radius of curvature column in the Lens Data Editor, but by the time we get to the chief ray at the edge of the image, this ray sees an entirely different lens prescription:

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2016.png)

And this of course is just what the chief rays at each field position see. Rays close to the stop see similar local radii, but as we move away from the stop the rays see very different radii. I wrote another macro to trace a fan of rays across the pupils in x and y from each field point, and to return the local radius of curvature seen by these fans. On axis, we see

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2017.png)

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2018.png)

If we look at the central column, which is highlighted, we can see that this ray sees the same radius of curvatures as the LDE shows and our previous macro shows. You can also see that, on-axis in a rotationally symmetric system, we get the same radius of curvature for both x and y pupil scans. But notice how much the local lens prescription varies as a function of the aperture of the ray bundle. Compare, for example, the lens prescription as seen by rays at the edge (-1), near the center (-.6) and center of the on-axis pupil: 

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2019.png)

It’s clear that rays see **a different lens prescription as a function of the pupil coordinate**, and it is just not easy to say what ‘the’ lens prescription of the system is. Let’s now move to the most off-axis field point:

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2020.png)

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2021.png)

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2022.png)

Again, this field point sees different local radii than the on-axis field. Note also that the radii seen by the x-scan is symmetric across the pupil, which that on the y-scan is not, which is to be expected as we move across the y-field in a rotationally symmetric system. However, note also that at some off-axis point (x,y) the local radius of curvature in x will in general be different from that in y. That is an important extra degree of freedom in controlling astigmatism, as we will see later.

Just for comparison, here is the same report for the Cooke triplet we looked at earlier:

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2023.png)

You can see clearly that in the spherical system each ray sees the same radius of curvature on each surface, regardless of field, pupil aperture or orientation. The consequences are clear:

<aside>
🟠 In smartphone cameras, lenses are so aspheric that traditional concepts, like ‘the lens prescription’ depend on the ray being traced. The Lens Data Editor provides the information on how to construct the system, but not directly what any individual ray sees. Paraxial data, which is based only on vertex curvature, will only be useful for a very small pencil of rays near the axis. We need a different approach to understanding smartphone lenses.

</aside>

# Understanding the Smartphone Lens

I find it helpful to break the smartphone optical system into three groups:

1. The first group I call the **Imaging Group** as it is most analogous to a classic imaging system. In this case, the first three components resemble a Cooke Triplet
2. The next group is called the **Corrector Group** and it provides the most strongly varying field varying components. This group controls field curvature, astigmatism and distortion, as well as providing some focusing power
3. The final group is the Sensor **Group**. This is purchased as a separate item, and is separately mounted inside the phone. The optical designer has no real design control over this group. Groups 1&2 are packaged separately, and some kind of actuator is used to modify the separation between the final surface of the Corrector group and the first surface of the Sensor group. This adjustable distance is used to provide auto focus, temperature stabilization and sometimes color balance as well

Let’s now look at these three groups individually, and then as a complete system.

## The Imaging Group

The first three lenses are recognizable from our Basic Shapes of Imaging Systems series as a Cooke Triplet. 

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2024.png)

This group of lenses provides the prime focusing of the lens, and is formed of a *roughly* positive lens, stop, negative lens and positive lens. If you are not familiar with Cooke triplets, see my Basic Shapes of Imaging lenses series. The outer lenses are made using a Model glass with $n_d$  = 1.544 and Abbe number $V_d$ = 55.9. No partial dispersion term is given. The negative lens is made of AL-6263-(OKP4HT), a moldable polymer resin with full dispersion data and benchmark $n_d$  = 1.6319 and Abbe number $V_d$ = 23.328. This index and dispersion difference provides part of the color correction for the lens group.

However, the similarity ends there. If we create a new system with just these three lenses in it, and bring it to best focus, the performance is spectacularly bad:

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2025.png)

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2026.png)

The design is dominated by coma, astigmatism and field curvature, with just a little spherical. How is it that we can make a design with $16^{th}$ order aspheres where $r^4$ is the highest order aberration visible? The answer is that these aspheres are not providing aberration control in the classic sense, but are instead providing a field-dependent lens prescription. 

Let’s look briefly at the Seidel plot of this system:

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2027.png)

This tells an entirely different story: here aberrations from the various surfaces are balancing to provide a well-corrected system. This shows precisely why paraxial optics and aberration theory cannot be used with smartphone lenses, or at the very least must be treated with great care. These analyses use only the vertex radii of curvature of the surfaces, and a small pencil of rays near the axis to compute values that simply cannot be linearly scaled to correspond to what the other rays are seeing.

Let’s also look at how rays from different field points illuminate the various surfaces of the Imaging Group. Drawing only the on-axis and most extreme off-axis fields we see that both field points illuminate most of the surfaces:

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2028.png)

The stop surface is of course the only surface that is uniformly illuminated by all field points, and as rays move away from the stop we expect to see partial illumination of the surfaces. Note points 1, 2 and 3 show regions that are only illuminated by the off-axis field and are not seen by the on-axis point. Conversely point 4 shows a region that only the on-axis rays see. Remember that there are many other field points in real life: we are just looking at the extreme off-axis and on-axis to illustrate a point. Since these surfaces are highly aspheric, the different regions of each surface that see partial illumination by different field points will adjust themselves during optimization for the parts of the field that illuminate them.

### The Corrector Group

The Corrector Group in this design is a two-element group

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2029.png)

Both are so aspheric that we cannot talk about a single radius of curvature to describe them, or to even describe them as having ‘positive’ or ‘negative’ focal lengths, particularly the second lens. The first lens is made of OKP4HT, as was the central lens of the Cooke triplet-based Imaging Group. The second lens is made of the same model material as the two outer lenses of the Imaging Group. This contributes to the color balance of the lens, which we’ll discuss in more detail soon.

If you watched my Auxiliary Optics video, you may recall the field-flattening lens we discussed. We used a simple Petzval lens to introduce field curvature, and then compensated the field curvature by adding a negative lens near to the image plane:

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2030.png)

This negative lens provided a small field-dependent focal length shift which compensated field curvature but could not fix astigmatism. 

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2031.png)

In the cell phone lens, this variation of focal length is not subtle! It is very pronounced and is not a small correction to the vertex focal length. As we’ll see, this group corrects field curvature, astigmatism and distortion: hence I call it the Mother Of All Field Flatteners, or MOAFF.

Let’s step through this lens group, starting at the end of the Imaging Group and look at the effect of each lens in the Corrector Group.

If we look at the Imaging Group alone we see spectacularly bad imaging, with obvious caustics:

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2032.png)

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2033.png)

Using the vertex focal length as a reference, we can see that this group has a focal length around 1mm less than the required system focal length. The focal length gets even shorter as field increases, and then diverges at the edge of field to a longer focal length.

If we then add the first lens from the corrector group, we can see that the system focal length lengthens and is now greater than the required focal length:

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2034.png)

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2035.png)

We can see from the layout that the ray fans are less aberrated, and the caustics are greatly reduced. 

The focal length is 4.8 mm as a reference, but shortens by a full millimeter by around 75% percent of the field. This lens looks like an aspheric equivalent of a Schmidt plate, which adds spherical to compensate the spherical aberration of the primary mirror in a Schmidt-Cassegrain telescope. When we then add the final lens we get sharp imaging:

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2036.png)

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2037.png)

The vertex focal length is now only very slightly longer than the target 4 mm, so the MOAFF also provides bulk power for image quality control. The high order variation in field-dependent focal length gives this lens its field curvature and astigmatism control as we saw earlier. In addition, because the MOAFF is somewhat set back from the image plane (field flatteners are traditionally placed right in front of the image plane) it can also direct the ray bundle at each field to land at the specified height on the image plane, controlling distortion too.

Let’s offset the Power Field Map by the paraxial effective focal length, which is measured based on a small pencil of rays close to the vertex:

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2038.png)

Note that this is a multi-order polynomial function. Let’s take the first half of the pupil in this graphic, rotate it through 90 degrees, and compare it to the Field Curvature plot:

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2039.png)

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2040.png)

<aside>
🟠 Now we can see that the variation in focal length with field is what is giving us a flat image surface. It’s very tempting to call this field curvature control, and we often do refer to it as such. But it’s important to realize that aberrations are caused by the non-linearity of Snell’s law with angle, compared to a vertex-referenced ray trace. In aspheres, the power of the surfaces is not constant and this correction is caused by the lens prescription changing on a ray-by-ray basis, and not on a Taylor’s series expansion of sin$\theta$

</aside>

<aside>
🟠 The corrector group flattens the field response so that spot size or other metric is well focused on the image plane, and controls distortion. The first lens allows power to be distributed over more surfaces, and works similar to a Schmidt corrector. The second lens of the corrector group can be thought of as The Mother of All Field-Flattening Lenses.

</aside>

Let’s also look at how the different field points illuminate the surfaces of the Corrector Group:

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2041.png)

With the exception of one very small region of overlap, these two field points are effectively decoupled from each other: the surface area illuminated by the extreme edge of the field of view is entirely separate from the patch of surface illuminated by the on-axis beam. This explains why these surfaces are so obviously and visually aspheric: the optical prescription needed by the extreme off-axis field has nothing to do with the on-axis field point.

This also explains the high-order correction of both field curvature and distortion. By manipulating the slope at the center of a ray-bundle, the spot can be positioned wherever it is needed. By varying the curvature, power can be added to maintain focus at this position.

Adding many field points shows that a patch of the various surfaces is illuminated only by some range of fields. 

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2042.png)

For example, the patch of surface .25 mm across at the edge of the final surface is illuminated only by rays from about 35.8 degrees to 28 degrees. The other field points do not influence the surface sag in that region, other than that the sag must be continuous across the whole surface.

### The Sensor Group

The sensor is a separate unit to the optics. It consists of a glass window and a photosensor array with a color filter array based on a [Bayer Filter](https://en.wikipedia.org/wiki/Bayer_filter). The distance between the sensor and the final surface of the Corrector group is maintained by an actuator so that autofocus and other actions can be implemented.

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2043.png)

In this design, the glass window is made of D4532, a flowable glass with moderate thermal softening point, around 176 C. Although the window is flat and therefore has no power (power is proportional to curvature, and the curvature of a flat surface is zero by definition), the flat window can still add aberrations. Most importantly, when a flat window is inserted into the converging cone of light between the last lens and the image plane, it is a source of coma, astigmatism and even spherical aberrations, as well as chromatic aberrations. 

<aside>
🟠 Flat windows near the focus of a system **can not be ignored** and must be explicitly included in the optical system design. In most smartphones, the distance from window to sensor is a significant fraction of the total system length, around 20-25%.

</aside>

In this example, I have replaced the optics with a paraxial lens to make an approximation of the smartphone lens. Only the window is left. The layout shows the beam aberrating with field:

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2044.png)

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2045.png)

You can view the window as a source of aberration, or equivalently as a source of **aberration correction**. The designer has little to no control over the aberrations provided by the window, beyond the initial choice of sensor. It is vital that the window be included in the lens design, with full index and dispersion information, and the preceding optics must pre-aberrate the rays such that they are compensated by the window and provide good final focal performance.

The sensor itself includes a Bayer filter or similar, so that three color planes may be separately read out. 

![[Bayer filter - Wikipedia](https://en.wikipedia.org/wiki/Bayer_filter)](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2046.png)

[Bayer filter - Wikipedia](https://en.wikipedia.org/wiki/Bayer_filter)

![[Bayer filter - Wikipedia](https://en.wikipedia.org/wiki/Bayer_filter)](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2047.png)

[Bayer filter - Wikipedia](https://en.wikipedia.org/wiki/Bayer_filter)

This arrangement of color filters on top of the sensor array allows the sensor to separate the image into three color planes

Note that there are twice as many green pixels as red or blue, to mimic the physiology of the human eye. When optimizing, the green wavelength is typically given twice the weight of the red and blue wavelengths to represent this. The raw output of the photosensor is often called a Bayer pattern image. D[emoisacing](https://en.wikipedia.org/wiki/Demosaicing) and [super-resolution](https://en.wikipedia.org/wiki/Super-resolution_imaging) algorithms are used by the phone itself to stitch the three color planes together into a full color image.

This is a fundamental difference between digital imaging devices and their earlier photographic equivalents. As the three color planes are separately available, many computational techniques can be used to enhance the final image beyond the optical resolution of the lens. This is a whole area of further study to the lens design itself. In this example we see an original (optical) image on the left, and on the right the final image improved by multiple image processing operations.

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2048.png)

In addition, relative illumination performance and distortion can be mitigated in post processing, particularly if the optical design is known. 

The major impact on the lens design is that **near-diffraction-limited** performance in the green is usually all that is required. This significantly eases tolerancing, as best-possible imaging is not usually required. That is a huge get-out-of-jail-free card for both the optical designer and manufacturer.

The final consequence of the Bayer filter is that its an angular response causes crosstalk between pixels if they are illuminated at more than say 30 degrees. This is usually added as a specification to the lens design. Don’t confuse this with the field of view: we are talking here specifically about the angles the rays make to the detector, not the field of view. It’s usual to see a ‘chief ray angle less than 30 degrees’ or similar line in the specification.

## Overall Imaging Performance

Here are some important performance metrics for this design:

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2049.png)

We can see from the RMS spot versus field plot that overall performance with both field and wavelength is good but not diffraction limited, as expected. The spot size improves from 29 degrees to about 33 degrees, and then spot performance worsens quickly. I don’t know if the lens is genuinely used to that field, or if vignetting is later used to improve edge performance, or if that performance is acceptable. My suspicion is that vignetting is used to improve the extreme edge of the field of view. This is one of the things that patents often don’t make clear.

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2050.png)

On the MTF plot we see MTF being reasonable, but improving in the region from 29 to 33 degrees before collapsing quickly after that. This bump in contrast at high fields is almost certainly used by  computational optics to provide further sharpening, although that is my guess and not stated in the patent description (nothing useful is). Again, note the polynomial structure to the MTF plot. This is not the simple monotonic drop-off we associate with spherical lenses.

The on-axis ray fan is very important:

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2051.png)

We think we can see focus, spherical, higher order spherical, higher-order spherical, higher-order-higher order spherical and so on balancing across the pupil. But in fact, this is due to the polynomial structure of the lens radii across the pupil. Remember: the surface curvature at the vertex is not a good proxy for the rest of the surface when we are dealing with such strong aspheres. 

<aside>
🟠 This is not aberration deriving from a Taylor series expansion of the sine function. Rather, it comes from the polynomial structure of the Even Aspheric surface used.

</aside>

Because of this high order balance, chromatic effects are not huge. If we look at system performance as a function of field:

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2052.png)

0°

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2053.png)

5°

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2054.png)

10°

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2055.png)

15°

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2056.png)

20°

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2057.png)

25°

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2058.png)

30°

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2059.png)

35°

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2060.png)

35.8° (max field)

You can see that the variation of performance with field is very slow, right up until the edge of field. This is because the lens prescription is varying as a function of field, so each field point can be optimized specifically for its requirements. This field variation is smooth, as the lens must work at any field point. 

This is also why the chromatic performance is so good, despite the small range of materials available. Since the MOAFF compensates field curvature so well, each field point is closer to its on-axis performance than we are used to with all-spherical designs. As a result of the field dependence of the lens prescription, chromatic effects are also small as the prescription adapts to the chromatic range at each field point.

This lens has very slowly varying performance up until about 33°, and I suspect that in real life the lens would not be used out to 35.8°. Since the performance of the MOAFF at any field is influenced by the next largest field, when we get to the edge of the field there is no next-largest field to help control the surface shape.

<aside>
🟠 Therefore, the Corrector Group lenses should be designed to work at slightly larger fields than they will actually be used at. Vignetting can be used to improve edge performance at the expense of image brightness, which can be compensated in post-processing software.

</aside>

Let’s finally look at the overall focal length of this lens system. The nominal, or on-axis, focal length is 4.06 mm, and this varies to 4.12 mm at about 95% of the field, and just under 4.2 mm at the extreme edge of the field of view. You could probably call this a ‘4mm’ focal length lens and get away with it.

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2061.png)

But note the high degree of polynomial correction. Although at each field point the focal length ends up being close to 4 mm, the actual radii of curvature, and even the description of components being positive or negative, varies across the field of view. 

For comparison, here is the same data for the all-spherical Cooke triplet. It has a focal length of exactly 50 on axis, and this varies by +0.006 mm to -0.6 mm.

![Untitled](The%20Basic%20Shape%20of%20Smartphone%20Lenses%20aed2d9798c01419eaccb050365fb444e/Untitled%2062.png)

The variation of focal length here is due to aberrations, which can be thought of as variations of focal length and magnification with field and pupil orientation. That’s why focal length varies so slowly over the field of view of the Cooke. It can be seen that the smartphone delivers excellent focal length uniformity because of its high order field dependent lens prescription.

## Summary