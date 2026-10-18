set TOP      [lindex $argv 0]
set PART     [lindex $argv 1]
set FILELIST [lindex $argv 2]

set fp [open $FILELIST r]

while {[gets $fp filename] >= 0} {
    set filename [string trim $filename]

    if {$filename eq "" || [string match "#*" $filename]} {
        continue
    }

    puts "Reading $filename"
    read_vhdl -vhdl2008 $filename
}

close $fp

synth_design -top $TOP -part $PART

report_utilization -file build/vivado_utilization.rpt
report_timing_summary -file build/vivado_timing.rpt

write_checkpoint -force build/jpeg_synth.dcp
