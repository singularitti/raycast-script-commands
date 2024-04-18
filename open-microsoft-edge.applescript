#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Microsoft Edge
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.packageName Microsoft Edge
# @raycast.argument1 { "type": "text", "placeholder": "url", "optional": true }

# Documentation:
# @raycast.description Open Microsoft Edge
# @raycast.author singularitti
# @raycast.authorURL https://singularitti.github.io/

on run argv
    -- Define a default URL for when no specific URL is provided
    set defaultURL to "edge://newtab" -- This opens the new tab page

    -- Check if a URL is provided and set the URL accordingly
    set theURL to defaultURL
    if (count of argv) ≥ 1 then
        set theURL to item 1 of argv
    end if

    -- Check if Microsoft Edge is running
    tell application "System Events"
        set edgeRunning to (name of processes) contains "Microsoft Edge"
    end tell

    -- Handle based on whether Edge is already running or not
    if edgeRunning then
        -- Edge is running, open the new URL in it
        tell application "Microsoft Edge"
            activate
            delay 0.1
            tell application "System Events"
                keystroke "t" using {command down}  -- Opens a new tab
                keystroke theURL
                keystroke return
            end tell
        end tell
    else
        -- Edge is not running, start it with the URL
        do shell script "open -b com.microsoft.edgemac --args --disable-features=msOmniboxFocusRingRoundEmphasize " & quoted form of theURL
    end if
end run
