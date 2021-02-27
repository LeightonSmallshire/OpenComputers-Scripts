-- designed for EEPROM; load a file from web and execute it
-- requires internet card. You need to do "eeprom.setData(<webUrl>)" yourself.
local code, inet, eeprom, conn = "",
component.proxy(component.list('internet')()),
component.proxy(component.list('eeprom')())

conn = inet.request(eeprom.getData())
repeat until conn.finishConnect()
assert(conn.response() == 200)
for m in conn.read do code = code .. m end
conn.close()

computer.beep(400, 0.1)
load(code, 'MAIN', 'tb', _G)()
