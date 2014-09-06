#!/bin/sh
octave=`which octave`

if [ $# -gt 0 ]; then
  dest=$1
else
  dest="/usr/local/bin"
fi

if [ -f $dest ]; then
  echo "Destination $dest is not a directory."; exit -1
elif [ -d $dest ]; then
  if [ -w $dest ]; then
    dest=`echo $dest | sed -e 's/\/$//'`
  else
    echo "You have no permission to write to $dest directory."; exit -1
  fi
else
  echo "Destination directory $dest doen't exist."; exit -1
fi

installfilename="$dest"/swrcfit

# Check if octave is installed

if [ -z "$octave" ]; then
  echo "Install Octave first."; exit -1
fi
ans=`$octave -q --eval 1+1`
if [ -z "$ans" ]; then
  echo "Install Octave first."; exit -1
fi

# Install swrcfit

swrcfit=swrcfit.m
octave2=`echo $octave | sed -e "s/\//SLASH/g"`
if [ -f $swrcfit ]; then
  echo "=== Installing "$installfilename
  cat $swrcfit | sed -e "s/\/usr\/bin\/octave/$octave2/" | sed -e 's/SLASH/\//g' > $installfilename
  chmod +x $installfilename
else
  echo "$swrcfit was not found."; exit -1
fi

# Check if it works
echo "=== Cheking swrcfit"
$installfilename swrc.txt > test.txt
if [ `diff result.txt test.txt` ]; then
  echo "Result of swcfit swrc.txt is different from result.txt."
  echo "Not yet installed properly. Trying to install Octave forge packages."
  rm -f test.txt
else
  echo "$installfilename was installed successfully.";
  rm -f test.txt; exit 0
fi

# Install octave forge packages

echo "=== Installing packages (pkg install -forge struct optim)"
$octave -q --eval "pkg install -forge struct optim"
$installfilename swrc.txt > test.txt
if [ `diff result.txt test.txt` ]; then
  echo "Octave forge was not installed successfully."
  echo "Please manually install leasqr.m, dfdp.m and other necessary files."
  echo "See https://github.com/sekika/swrcfit/blob/master/README.md"
else
  echo ""$installfilename was installed successfully."
fi
rm -f test.txt
