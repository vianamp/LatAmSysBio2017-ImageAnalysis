//
// Detect each particle and Add to ROI Manager
//
run("Analyze Particles...", "add");

//
// Specify the measurements
//

run("Set Measurements...", "area fit shape redirect=None decimal=3");

roiManager("Measure");
