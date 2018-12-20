Bash script emulating coverage depth report generation of the Coverage tool I made in Python.

Usage:

Once executable permission is given to the file, run it as follows:

	./Coverage_reports -options

Options

-i: Input BAM file
-a: Input BED file
-l: Upper limit of coverage depth to include in report
-s: Use samtools depth to measure coverage depth
-b: Use bedtoools coverage to measure coverage depth
-h: Help message
