Bash tool that generates a coverage report given a BAM file, BED file, and coverage depth limit.

Usage:

Once executable permission is given to the file, run it as follows:

	./Coverage_reports -options

Options

-i: Input BAM file
-a: Input BED file
-l: Upper limit of coverage depth to include in report
-g: Adds a column for gene name to the samtools output
-s: Use samtools depth to measure coverage depth
-b: Use bedtoools coverage to measure coverage depth
-h: Help message
