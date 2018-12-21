
#!/bin/bash
usage() {
        echo "Usage: $0 [-h] [-i BAM FILE] [-a BED FILE] [-l LIMIT] [-g] [-s] [-b]"
        echo "	  -h      Displays this help message."
	echo "	-i	Sets the input bam file."
	echo "	-a	Sets the input bed file."
	echo "	-l	Sets the coverage depth limit under which positions are added to the report"
	echo "	-g	Gene stuff for samtools"
	echo "	-s	Creates the coverage report using samtools depth for coverage"
	echo "	-b	Creates the coverage report using bedtools coverage for coverage"
        echo "This is a help message."
        exit
}

add_genes() {
	awk '{$2=++i FS $2;}1' $name"_ST.txt" > "test.txt"
	echo "Chrom	Gene" > "genes.txt"
	for f in $(awk '!/^Chrom/ {print $2} ' $name"_ST.txt")
	do
		awk -v pos="$f" '{ if ($2 <= pos && $3 >= pos) print $1 "\t" $4}' $bed >> "genes.txt"
	done
	join -1 1 -2 1 "genes.txt" "test.txt" > "test2.txt"
}

while getopts "hi:a:l:gsb" optchar;
do
        case $optchar in
                h)
                        usage
                        ;;
                i)
                        bam="$OPTARG"
			name=${bam:0:(-4)}
                        ;;
                a)
                        bed="$OPTARG"
                        ;;
		l)
			limit="$OPTARG"
			;;
		g)
			g_flag="True"
			;;
                s)
			echo "Chrom	Pos	Cov_depth" > $name"_ST.txt"
			samtools depth -b $bed $bam | awk -v lim="$limit" '{ if ($3 <= lim) print $0 }' >> $name"_ST.txt"
			if test $g_flag = "True"
			then
				add_genes
			fi
                        ;;
		b)
			echo "Chrom	Region_Start	Region_End	Gene	Pos	Cov_depth" > $name"_BT.txt"
			bedtools coverage -a $bed -b $bam -d | awk -v lim="$limit" '$6 <= lim' >> $name"_BT.txt"
			;;
                \?)
                        echo "Invalid option: -$OPTARG"
                        exit 1
                        ;;
                :)
                        echo "Option -$OPTARG requires an argument"
                        exit 1
                        ;;
        esac
done
