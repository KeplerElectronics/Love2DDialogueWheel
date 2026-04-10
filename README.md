What if you wanted to make a wheel game for wheel jam? using Love2D?

### Todo:
- Add function to reset wheel
- Change selection indicator to image instead of vector circle
- add alternate wheel draw images if selected (instead of just darkening existing slices
- Add slice labels

## Documentation

### Set Background
- sets background to an image: automatically updates width/height values based on image dimensions
`wheel.setBG("Path/To/Image.png")`

### Set Slice Image
- sets each slice to an image
- number 1-4 allows you to set each slice to a different image
- Slices should be designed such that the arc is from bottom left corner to top right, with point in top left (so it matches Love's image origin)
`wheel.setSliceImg(sliceNumber,"Path/To/Image.png")`

### Set Slice Result
- Set value that each slice will return when selected
`wheel.setSliceResult(sliceNumber,value)`

### Set Position
- Set Wheel x,y coordinates
`wheel.setPos(x,y)`

### Set Rotation Target
- move wheel to set angle
`wheel.setTarget(angle)`

### Set Selection Target
- set target selection (which one player is pointing to)
- to move clockwise one slice, pass 1
- to move counterclockwise, pass -1
`wheel.selectTarget(increment)`

### Get Selected Value
- Returns result of selected slice
- Darkens wheel slice to indicate that it has been selected
`wheel.getSelectedValue()`

### Shake Wheel
- Shakes wheel to provide negative feedback (for example, if selecting an invalid slice)
`wheel.shake()`

### Update Wheel
- Updates wheel position, moving towards target
- remember to pass in delta time!
`wheel.update(dt)`

### Draw Wheel
- Draws wheel, slices, and selection indicator
`wheel.draw()`
