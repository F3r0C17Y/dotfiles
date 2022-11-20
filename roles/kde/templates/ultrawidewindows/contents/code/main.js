function newSlotPosition(workspace, client, numberXslots, numberYslots, x, y, xSlotToFill, ySlotToFill) {
    var maxArea = workspace.clientArea(KWin.MaximizeArea, client);
    var width;
    if (x == numberXslots) {
        width = Math.floor(maxArea.width / numberXslots);
    } else {
        width = Math.ceil(maxArea.width / numberXslots);
    }

    var height;
    if (y == numberYslots) {
        height = Math.floor(maxArea.height / numberYslots);
    } else {
        height = Math.ceil(maxArea.height / numberYslots);
    }

    var newX = maxArea.x + width * x;
    var newY = maxArea.y + height * y;
    return [newX, newY, width * xSlotToFill, height * ySlotToFill]
}
function reposition(client, newX, newY, w, h) {
    client.geometry = {
        x: newX,
        y: newY,
        width: w,
        height: h
    };
}

function move(workspace, numberXslots, numberYslots, x, y, xSlotToFill, ySlotToFill) {
    var client = workspace.activeClient;
    if (client.moveable) {
        arr = newSlotPosition(workspace, client, numberXslots, numberYslots, x, y, xSlotToFill, ySlotToFill);
        var newX = arr[0],
            newY = arr[1],
            w = arr[2],
            h = arr[3];
        reposition(client, newX, newY, w, h)
    }
}

function center(workspace) {
    var client = workspace.activeClient;
    if (client.moveable) {
        var maxArea = workspace.clientArea(KWin.MaximizeArea, client);
        var newX = maxArea.x + ((maxArea.width - client.width) / 2);
        var newY = maxArea.y + ((maxArea.height - client.height) / 2);
        reposition(client, newX, newY, client.width, client.height)
    }
}

registerShortcut("MoveWindowToLeftHeight23_center_biased", "UltrawideWindows: Move Window to fit left-height 2/3 width (center biased)", "meta+1", function () {
    move(workspace, 8, 1, 0, 0, 2, 1)
});

registerShortcut("MoveWindowToCenterHeight23_center_biased", "UltrawideWindows: Move Window to fit center-height 2/3 width (center biased)", "meta+2", function () {
    move(workspace, 8, 1, 2, 0, 4, 1)
});

registerShortcut("MoveWindowToRightHeight23_center_biased", "UltrawideWindows: Move Window to fit right-height 2/3 width (center biased)", "meta+3", function () {
    move(workspace, 8, 1, 6, 0, 2, 1)
});

// General
registerShortcut("MoveWindowToMaximize", "UltrawideWindows: Maximize Window", "Meta+Num+0", function () {
    move(workspace, 1, 1, 0, 0, 1, 1)
});

registerShortcut("MoveWindowToCenter", "UltrawideWindows: Center Window", "ctrl+Num+5", function () {
    center(workspace)
});

