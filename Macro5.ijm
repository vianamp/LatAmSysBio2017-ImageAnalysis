//
// Close open images and clear previous results
//

close();
close();
roiManager("Reset");

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

//
// Detect each particle and Add to ROI Manager
//
run("Analyze Particles...", "add");

//
// Specify the measurements
//

run("Set Measurements...", "area fit shape redirect=None decimal=3");

roiManager("Measure");

//
// Varible corresponding to the number of detected cells
//

NumberOfCells = roiManager("Count");

print("Number of cells: "+NumberOfCells);

//
// Retrieve each value from the Results Table
//

Feature = newArray(NumberOfCells);

for (cell = 0; cell < NumberOfCells; cell++) {
	value = getResult("Circ.",cell); 
	Feature[cell] = value;
}

//
// Calculate statistics of the measurement
//

Array.getStatistics(Feature, min, max, mean, std);

print("Range: ["+min,","+max+"]");

//
// Clear the image
//

run("Select All");
run("Clear", "slice");

//
// Draw each cell with color corresponding to the feature value
//

for (cell = 0; cell < NumberOfCells; cell++) {
	color = 255*(Feature[cell]-min)/(max-min);
	setForegroundColor(color,color,color);
	roiManager("Select",cell);
	run("Fill");
}

//
// Select the color table
//

roiManager("Show None");
run("physics");
