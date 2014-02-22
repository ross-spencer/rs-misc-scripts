rs-misc-scripts
===============

Miscellaneous scripts for reuse or re-purposing. 

###img-exploder.sh 

Works its way through a directory of disk images (*.img) creating a loop device, mounting the disk,
taking the contents off it, identifying them using File and unmounting the disk. As much a reference implementation
as anything. Will probably need reworking in time. 

###jhove-xml-transformation.xslt

XSLT transormation for JHOVE 1.0. Focusing on pulling the status from an XML file output by JHOVE for easy
human readability, outside of any format validation workflows. 

###recurse-dir.bat

DOS batch script to recurse a directory of files and perform a single command on them, in this case run TIKA. 
This script outputs a path and then appends the tika extract data. 

###dp-testing-folder-recurse.sh

Bash shell script testing three methods of recursion. For OPF blog on Nailgun.
Three methods are, Find, Globstar and then using a manifest. 
