#!/bin/bash

# Sean Szumlanski
# COP 3503, Fall 2017

# =======================
# GenericBST: test-all.sh
# =======================
# You can run this script at the command line like so:
#
#   bash test-all.sh
#
# For more details, see the assignment PDF.


################################################################################
# Compile and run test cases.
################################################################################


echo ""
echo "================================================================"
echo "Running Test Cases"
echo "================================================================"
echo ""

PASS_CNT=0
NUM_TEST_CASES=1

for i in `seq -f "%02g" 1 $NUM_TEST_CASES`;
do
	echo -n "  [Test Case] Checking TestCase$i... "

	# Attempt to compile.
	javac GenericBST.java TestCase$i.java 2> /dev/null
	compile_val=$?
	if [[ $compile_val != 0 ]]; then
		echo "** fail ** (failed to compile)"
		continue
	fi

	# Run program. Capture return value to check whether it crashes.
	java TestCase$i > myoutput$i.txt 2> /dev/null
	execution_val=$?
	if [[ $execution_val != 0 ]]; then
		echo "** fail ** (program crashed)"
		continue
	fi

	# Run diff and capture its return value.
	diff myoutput$i.txt sample_output/TestCase$i-output.txt > /dev/null
	diff_val=$?
	
	# Output results based on diff's return value.
	if  [[ $diff_val != 0 ]]; then
		echo "** fail ** (output does not match)"
	else
		echo "PASS!"
		PASS_CNT=`expr $PASS_CNT + 1`
	fi
done

################################################################################
# Special check for compile-time warnings and warning suppression annotations.
################################################################################

echo ""
echo "================================================================"
echo "Running Additional Tests and Safety Checks"
echo "================================================================"
echo ""

javac GenericBST.java 2> GenericBST__warning.err

grep unchecked GenericBST__warning.err > /dev/null 2> /dev/null
warn_val=$?

grep "@Suppress" GenericBST.java > /dev/null 2> /dev/null
supp_val=$?

warn_note=0
supp_note=0

if [[ $warn_val == 0 ]]; then
	echo "  [Additional Check] Compiles without warnings: ** fail **"
	warn_note=1
else
	echo "  [Additional Check] Compiles without warnings: PASS"
	PASS_CNT=`expr $PASS_CNT + 1`
fi

if [[ $supp_val == 0 ]]; then
	echo "  [Additional Check] No suppression annotations: ** fail **"
	supp_note=1
else
	echo "  [Additional Check] No suppression annotations: PASS"
	PASS_CNT=`expr $PASS_CNT + 1`
fi

################################################################################
# Cleanup an lingering .class or output files generated by this script.
################################################################################

rm -f *.class
rm -f GenericBST__warning.err

for i in `seq -f "%02g" 1 $NUM_TEST_CASES`;
do
	rm -f myoutput$i.txt
done

################################################################################
# Final thoughts.
################################################################################

echo ""
echo "================================================================"
echo "Final Report"
echo "================================================================"

if [ $PASS_CNT -eq 3 ]; then
	echo ""
	echo "  CONGRATULATIONS! You appear to be passing all the test cases"
	echo "  and safety checks performed by this script!!"
	echo ""
	echo "  Now, have you considered writing some additional test cases of"
	echo "  your own? Keep in mind, the test case I wrote for you was just"
	echo "  a sort of starter test, designed to show you how you can write"
	echo "  test cases for your program, which you can do even before"
	echo "  you've completed the methods you're echo working on."
	echo ""
	echo "  You should always create additional test cases in order to"
	echo "  fully test the functionality and correctness of your program."
	echo ""
else
	echo "                           ."
	echo "                          \":\""
	echo "                        ___:____     |\"\\/\"|"
	echo "                      ,'        \`.    \\  /"
	echo "                      |  o        \\___/  |"
	echo "                    ~^~^~^~^~^~^~^~^~^~^~^~^~"
	echo ""
	echo "                           (fail whale)"

	if [[ $warn_note != 0 ]]; then
		echo ""
		echo "Note: You can type 'javac GenericBST.java -Xlint:unchecked' at the"
		echo "      command line in Eustis for additional details about why your"
		echo "      code is generating warnings. Note that compiler warnings will"
		echo "      result in point deductions for this assignment."
	fi

	if [[ $supp_note != 0 ]]; then
		echo ""
		echo "Note: You seem to be using a @Suppress annotation in your code. This"
		echo "      might result in a point deduction for this assignment."
		echo ""
		echo "      This message might appear even if you have commented out a"
		echo "      suppression annotation. Please be sure to remove any comments"
		echo "      that include @Suppress annotations of any kind so that your"
		echo "      code won't automatically be flagged for using suppressions."
	fi

	echo ""
	echo "Note: The fail whale is friendly and adorable! He is not here to"
	echo "      demoralize you, but rather, to bring you comfort and joy in"
	echo "      your time of need. \"Keep plugging away,\" he says! \"You"
	echo "      can do this!\""
	echo ""
fi