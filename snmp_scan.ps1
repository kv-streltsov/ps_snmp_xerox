#scan and write in file snmp data for xerox 3550/b405/7545/7855/C8045 

$xerox_3550 = ('ip_range') #and b405
$xerox_7545 = ('ip_range') #and 7855/C8045

cd C:\install\Printer_SNMP_Harvester\scryp_ssh_snmp

#ecoding printer location
function ConvertTo-Encoding ([string]$From, [string]$To){
	Begin{
		$encFrom = [System.Text.Encoding]::GetEncoding($from)
		$encTo = [System.Text.Encoding]::GetEncoding($to)
	}
	Process{
		$bytes = $encTo.GetBytes($_)
		$bytes = [System.Text.Encoding]::Convert($encFrom, $encTo, $bytes)
		$encTo.GetString($bytes)
	}
}

$counter = 0
foreach($i in $xerox_3550){ 
    $SNMP = New-Object -ComObject olePrn.OleSNMP
    $SNMP.open($i,'public',2,1000)
    
    $ip = $i
    $printer_model    = $SNMP.get('.1.3.6.1.2.1.25.3.2.1.3.1')
    $printer_location = $SNMP.get('.1.3.6.1.2.1.1.6.0')


    $serial_number    = $SNMP.get('.1.3.6.1.2.1.43.5.1.1.17.1')
    $current_toner    = $SNMP.get('.1.3.6.1.2.1.43.11.1.1.9.1.1')
    $max_toner        = $SNMP.get('.1.3.6.1.2.1.43.11.1.1.8.1.1')    
    $printer_location = ($printer_location | ConvertTo-Encoding utf-8 Windows-1251)

    $toner_level      = ($current_toner * 100)/$max_toner
    $SNMP.Close()

    $obj = "" | select ip,printer_model,printer_location,serial_number,toner_level
    $obj.ip = $ip
    $obj.printer_location = $printer_location
    $obj.printer_model    = $printer_model
    $obj.serial_number    = $serial_number
    $obj.toner_level      = $toner_level


    $xerox_3550[$counter] = $obj
    $counter = $counter + 1}



$counter = 0
foreach($i in $xerox_7545){ 
    $SNMP = New-Object -ComObject olePrn.OleSNMP
    $SNMP.open($i,'public',2,5000)

    $printer_location                      = $SNMP.get('.1.3.6.1.2.1.1.6.0')
    $printer_model                         = $SNMP.get('.1.3.6.1.2.1.25.3.2.1.3.1')    
    $serial_number                         = $SNMP.get('.1.3.6.1.2.1.43.5.1.1.17.1')

    $Current_cartridge_toner_level_black   = $SNMP.get('.1.3.6.1.2.1.43.11.1.1.9.1.1')
    $Current_cartridge_toner_level_cyan    = $SNMP.get('.1.3.6.1.2.1.43.11.1.1.9.1.2')
    $Current_cartridge_toner_level_magenta = $SNMP.get('.1.3.6.1.2.1.43.11.1.1.9.1.3')
    $Current_cartridge_toner_level_yellow  = $SNMP.get('.1.3.6.1.2.1.43.11.1.1.9.1.4')

    $Max_cartridge_toner_level_black       = $SNMP.get('.1.3.6.1.2.1.43.11.1.1.8.1.1')
    $Max_cartridge_toner_level_cyan        = $SNMP.get('.1.3.6.1.2.1.43.11.1.1.8.1.2')
    $Max_cartridge_toner_level_magenta     = $SNMP.get('.1.3.6.1.2.1.43.11.1.1.8.1.3')
    $Max_cartridge_toner_level_yellow      = $SNMP.get('.1.3.6.1.2.1.43.11.1.1.8.1.4')

    $Current_drum_toner_level_black        = $SNMP.get('.1.3.6.1.2.1.43.11.1.1.9.1.5')
    $Current_drum_toner_level_cyan         = $SNMP.get('.1.3.6.1.2.1.43.11.1.1.9.1.6')
    $Current_drum_toner_level_magenta      = $SNMP.get('.1.3.6.1.2.1.43.11.1.1.9.1.7')
    $Current_drum_toner_level_yellow       = $SNMP.get('.1.3.6.1.2.1.43.11.1.1.9.1.8')


    $Second_Bias_Transfer_Roller           = $SNMP.get('.1.3.6.1.2.1.43.11.1.1.9.1.12')
    $Transfer_Belt_Cleaner                 = $SNMP.get('.1.3.6.1.2.1.43.11.1.1.9.1.11')
    $Current_Waste_toner_Container         = $SNMP.get('.1.3.6.1.2.1.43.11.1.1.9.1.10')
    $Max_Waste_toner_Container             = $SNMP.get('.1.3.6.1.2.1.43.11.1.1.8.1.10')
    $SNMP.Close()

    $toner_waste_container = ($Current_Waste_toner_Container * 100)/$Max_Waste_toner_Container

    $toner_level_black = ($Current_cartridge_toner_level_black * 100)/$Max_cartridge_toner_level_black
    $toner_level_cyan = ($Current_cartridge_toner_level_cyan * 100)/$Max_cartridge_toner_level_cyan
    $toner_level_magenta = ($Current_cartridge_toner_level_magenta * 100)/$Max_cartridge_toner_level_magenta
    $toner_level_yellow = ($Current_cartridge_toner_level_yellow * 100)/$Max_cartridge_toner_level_yellow

    $toner_level_yellow = [int]$toner_level_yellow


    $printer_location = ($printer_location | ConvertTo-Encoding utf-8 Windows-1251)

    $toner_level      = ($current_toner * 100)/$max_toner    

    $obj1 = "" | select ip, printer_model, printer_location, serial_number,
    toner_level_black, toner_level_cyan, toner_level_magenta, toner_level_yellow,
    Current_drum_toner_level_black, Current_drum_toner_level_cyan, Current_drum_toner_level_magenta, Current_drum_toner_level_yellow,
    toner_waste_container, transfer_belt_cleaner, second_bias_transfer_roller

    $obj1.ip = $i
    $obj1.printer_location    = $printer_location
    $obj1.printer_model       = $printer_model
    $obj1.serial_number       = $serial_number

    $obj1.toner_level_black   = $toner_level_black
    $obj1.toner_level_cyan    = $toner_level_cyan
    $obj1.toner_level_magenta = $toner_level_magenta
    $obj1.toner_level_yellow  = $toner_level_yellow

    $obj1.second_bias_transfer_roller      = $Second_Bias_Transfer_Roller
    $obj1.toner_waste_container            = $toner_waste_container
    $obj1.transfer_belt_cleaner            = $Transfer_Belt_Cleaner

    $obj1.Current_drum_toner_level_black   = $Current_drum_toner_level_black
    $obj1.Current_drum_toner_level_cyan    = $Current_drum_toner_level_cyan
    $obj1.Current_drum_toner_level_magenta = $Current_drum_toner_level_magenta
    $obj1.Current_drum_toner_level_yellow  = $Current_drum_toner_level_yellow
   



    $xerox_7545[$counter] = $obj1
    $counter = $counter + 1}


$xerox_3550 > .\snmp3550
$xerox_7545 > .\snmp7545
