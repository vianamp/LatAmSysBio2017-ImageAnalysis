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
	value = getResult("Area",cell); 
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
