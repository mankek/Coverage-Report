#!/bin/bash
usage() {
        echo "Usage: $0 [-h] [-i BAM FILE]"
        echo "  -h      Displays this help message."
        echo "This is a help message."
        exit
}

while getopts "hi:s" optchar;
do
        case $optchar in
                h)
                        usage
                        ;;
                i)
                        bam="$OPTARG"
                        ;;
                a)
                        bed="$OPTARG"
                        ;;
                s)
                        echo ${bam:(-4):4}
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