#!/bin/bash

# by Piotr Draczkowski 2019-11-29


echo ' '
echo 'This script will reconstruct full volumes of the complex using the result of focused 3D classification.'
echo 'IMPORTANT: This script should be executed from the Relion project directory (i.e. from which you execute the relion command)'

# ask user for the folder with 3D classification results
echo ' '
echo 'specify the number of the 3D classification job you are aiming to reconstruct ./Class3D/job…? (example 084)' 
read jobno

#reads the most recent data. star in the specified Class3D folder
datafile=$(ls -t Class3D/job$jobno/*data* | head -n1)

#ask user which classes to reconstruct
echo ' '
echo 'specify which classes to reconstruct (example 1 2 3 4, space-separated! up to 10 accepted)'
read clA clB clC clD clE clF clG clH clI clJ
echo 'selected classes:'
echo $clA 
echo $clB 
echo $clC 
echo $clD 
echo $clE 
echo $clF 
echo $clG 
echo $clH
echo $clI
echo $clJ
echo ' '
echo 'apgix?'
read angpix

echo ' '
echo 'expected resolution?'
read maxres

echo ' '
echo 'symmetry?'
read sym

echo ' '
echo 'how many MPIs to use (3 or 5 accepted)'?
read mpi 

if [ -z "$clA"] 
then 
	echo "class $clA not specified"
else
echo ' '
echo "NOTE: selects and reconstructs prtcls from class $clA"
	
	minvalA=$((clA - 1))'.9'
	maxvalA=$clA'.1'
 
	relion_star_handler --i $datafile --select rlnClassNumber --minval $minvalA --maxval $maxvalA --o class$clA'_job'$jobno.star 

	noprtclsA=$(grep '@' class$clA'_job'$jobno.star | wc -l) 
	echo NOTE: Number of particles in class $clA = $noprtclsA 
 
	mpirun -n $mpi relion_reconstruct_mpi --i class$clA'_job'$jobno.star --ctf --maxres $maxres --angpix $angpix --sym $sym --o class$clA'_job'$jobno.mrc  
fi

if [ -z "$clB"]
then
        echo "class $clB not specified"
else
echo ' '
echo NOTE: selects and reconstructs prtcls from class $clB

        minvalB=$((clB - 1))'.9'
        maxvalB=$((clB))'.1'

        relion_star_handler --i $datafile --select rlnClassNumber --minval $minvalB --maxval $maxvalB --o class$clB'_job'$jobno.star

	noprtclsB=$(grep '@' class$clB'_job'$jobno.star | wc -l)
	echo NOTE: Number of particles in class $clB = $noprtclsB

        mpirun -n $mpi relion_reconstruct_mpi --i class$clB'_job'$jobno.star --ctf --maxres $maxres --angpix $angpix --sym $sym --o class$clB'_job'$jobno.mrc
fi

if [ -z "$clC"]
then
        echo "class $clC not specified"
else
echo ' '
echo NOTE: selects and reconstructs prtcls from class $clC

        minvalC=$((clC - 1))'.9'
        maxvalC=$clC'.1'

        relion_star_handler --i $datafile --select rlnClassNumber --minval $minvalC --maxval $maxvalC --o class$clC'_job'$jobno.star

	noprtclsC=$(grep '@' class$clC'_job'$jobno.star | wc -l)
	echo NOTE: Number of particles in class $clC = $noprtclsC

        mpirun -n $mpi relion_reconstruct_mpi --i class$clC'_job'$jobno.star --ctf --maxres $maxres --angpix $angpix --sym $sym --o class$clC'_job'$jobno.mrc
fi

if [ -z "$clD"]
then
        echo "class $clD not specified"
else
echo ' '
echo NOTE: selects and reconstructs prtcls from class $clD

        minvalD=$((clD - 1))'.9'
        maxvalD=$clD'.1'

        relion_star_handler --i $datafile --select rlnClassNumber --minval $minvalD --maxval $maxvalD --o class$clD'_job'$jobno.star

	noprtclsD=$(grep '@' class$clD'_job'$jobno.star | wc -l)
	echo NOTE: Number of particles in class $clD = $noprtclsD

        mpirun -n $mpi relion_reconstruct_mpi --i class$clD'_job'$jobno.star --ctf --maxres $maxres --angpix $angpix --sym $sym --o class$clD'_job'$jobno.mrc
fi

if [ -z "$clE"]
then
        echo "class $clE not specified"
else
echo ' '
echo NOTE: selects and reconstructs prtcls from class $clE

        minvalE=$((clE - 1))'.9'
        maxvalE=$clE'.1'

        relion_star_handler --i $datafile --select rlnClassNumber --minval $minvalE --maxval $maxvalE --o class$clE'_job'$jobno.star

        noprtclsE=$(grep '@' class$clE'_job'$jobno.star | wc -l)
        echo NOTE: Number of particles in class $clE = $noprtclsE

        mpirun -n $mpi relion_reconstruct_mpi --i class$clE'_job'$jobno.star --ctf --maxres $maxres --angpix $angpix --sym $sym --o class$clE'_job'$jobno.mrc
fi 

if [ -z "$clF"]
then
        echo "class $clF not specified"
else
echo ' '
echo NOTE: selects and reconstructs prtcls from class $clF

        minvalF=$((clF - 1))'.9'
        maxvalF=$clF'.1'

        relion_star_handler --i $datafile --select rlnClassNumber --minval $minvalF --maxval $maxvalF --o class$clF'_job'$jobno.star

        noprtclsF=$(grep '@' class$clF'_job'$jobno.star | wc -l)
        echo NOTE: Number of particles in class $clF = $noprtclsF

        mpirun -n $mpi relion_reconstruct_mpi --i class$clF'_job'$jobno.star --ctf --maxres $maxres --angpix $angpix --sym $sym --o class$clF'_job'$jobno.mrc
fi

if [ -z "$clG"]
then
        echo "class $clG not specified"
else
echo ' '
echo NOTE: selects and reconstructs prtcls from class $clG

        minvalG=$((clG - 1))'.9'
        maxvalG=$clG'.1'

        relion_star_handler --i $datafile --select rlnClassNumber --minval $minvalG --maxval $maxvalG --o class$clG'_job'$jobno.star

        noprtclsG=$(grep '@' class$clG'_job'$jobno.star | wc -l)
        echo NOTE: Number of particles in class $clG = $noprtclsG

        mpirun -n $mpi relion_reconstruct_mpi --i class$clG'_job'$jobno.star --ctf --maxres $maxres --angpix $angpix --sym $sym --o class$clG'_job'$jobno.mrc
fi

if [ -z "$clH"]
then
        echo "class $clH not specified"
else
echo ' '
echo NOTE: selects and reconstructs prtcls from class $clH

        minvalH=$((clH - 1))'.9'
        maxvalH=$clH'.1'

        relion_star_handler --i $datafile --select rlnClassNumber --minval $minvalH --maxval $maxvalH --o class$clH'_job'$jobno.star

        noprtclsH=$(grep '@' class$clH'_job'$jobno.star | wc -l)
        echo NOTE: Number of particles in class $clH = $noprtclsH

        mpirun -n $mpi relion_reconstruct_mpi --i class$clH'_job'$jobno.star --ctf --maxres $maxres --angpix $angpix --sym $sym --o class$clH'_job'$jobno.mrc
fi

if [ -z "$clI"]
then
        echo "class $clI not specified"
else
echo ' '
echo NOTE: selects and reconstructs prtcls from class $clI

        minvalI=$((clI - 1))'.9'
        maxvalI=$clH'.1'

        relion_star_handler --i $datafile --select rlnClassNumber --minval $minvalI --maxval $maxvalI --o class$clI'_job'$jobno.star

        noprtclsI=$(grep '@' class$clI'_job'$jobno.star | wc -l)
        echo NOTE: Number of particles in class $clI = $noprtclsI

        mpirun -n $mpi relion_reconstruct_mpi --i class$clI'_job'$jobno.star --ctf --maxres $maxres --angpix $angpix --sym $sym --o class$clI'_job'$jobno.mrc
fi

if [ -z "$clJ"]
then
        echo "class $clJ not specified"
else
echo ' '
echo NOTE: selects and reconstructs prtcls from class $clJ

        minvalJ=$((clH - 1))'.9'
        maxvalJ=$clJ'.1'

        relion_star_handler --i $datafile --select rlnClassNumber --minval $minvalJ --maxval $maxvalJ --o class$clJ'_job'$jobno.star

        noprtclsJ=$(grep '@' class$clJ'_job'$jobno.star | wc -l)
        echo NOTE: Number of particles in class $clJ = $noprtclsJ

        mpirun -n $mpi relion_reconstruct_mpi --i class$clJ'_job'$jobno.star --ctf --maxres $maxres --angpix $angpix --sym $sym --o class$clJ'_job'$jobno.mrc
fi
#
#
#
#
#
#
#
#  v.1 of the command
	#selects & reconstructs prtcls from class 1 if selected by the user for reconstruction
	#if [ $clA -eq 1 ] || [ $clB -eq 1 ] || [ $clC -eq 1 ] || [ $clD -eq 1 ] || [ $clE -eq 1 ] || [ $clF -eq 1 ] || [ $clG -eq 1 ] || [ $clH -eq 1 ]
	#then

		#relion_star_handler --i $datafile --select rlnClassNumber --minval 0.9 --maxval 1.1 --o cl1_$jobno.star \
		#&& mpirun -n $mpi relion_reconstruct_mpi --i cl1_$jobno.star --ctf --maxres $maxres --angpix $angpix --sym $sym --o cl1_$jobno.mrc \

	#fi

 
#end message 
echo 'SELECT & RECONSTRUCT COMMAND FINISHED!'
