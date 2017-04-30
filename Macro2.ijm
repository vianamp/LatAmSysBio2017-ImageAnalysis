//
// Loading the image
//

open("Sample.tif");

//
// Filtering for noise reduction
//

run("Median...", "radius=2");

//
// Find maxima for cell segmentation
//

run("Find Maxima...", "noise=200 output=[Segmented Particles] light");
