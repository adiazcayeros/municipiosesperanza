
use "/Users/diazmagaloni/Box/COVID19/Databases Mexico/covidmexico9.dta", clear
tab habla_lengua_indig
tab covid19
tab habla_lengua_indig covid19
tab habla_lengua_indig covid19, cell
table st_mun_id covid19
collapse (count) cases=sexo (sum) death covid19 coviddeath male indigenous usmer hospital (mean) edad state, by(st_mun_id)
drop if st_mun_id==.
gen class=1
replace class=2 if death>0
replace class=3 if coviddeath>0
export delimited using "/Users/diazmagaloni/Box/COVID19/Mun2CovidMay14.csv", replace
export excel using "/Users/diazmagaloni/Box/COVID19/Mun2CovidMay14.xlsx", replace

