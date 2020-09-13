local awful = require("awful")
local naughty = require("naughty")

confdir = awful.util.getdir("config")
local rc, err = loadfile(confdir .. "/awesome.lua");
if rc then
    rc, err = pcall(rc);
    if rc then
        return;
    end
end

-- Save output to /tmp for config troubleshooting
-- output = io.open("/tmp/awesome_output", 'wb')
-- output:write(err)
-- output:flush()
-- output:close()

-- dofile("/etc/xdg/awesome/rc.lua");
-- TODO: Properly read XDG env vars & do something sensible.
dofile("/run/current-system/sw/etc/xdg/awesome/rc.lua");

for s = 1,screen.count() do
    mypromptbox[s].text = awful.util.escape(err:match("[^\n]*"));
end

naughty.notify{text="Awesome crashed during startup on "
.. err .. "\n", timeout = 0}
