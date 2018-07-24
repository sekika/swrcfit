#!/bin/sh
# This script depends on octave and wget

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
  mkdir -p $dest
  if [ -d $dest ]; then
     echo "=== Directory $dest created"
  else
     echo "Directory $dest cannot be created."; exit -1
  fi
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

swrcfit=swrcfit
octave2=`echo $octave | sed -e "s/\//SLASH/g"`
if [ -f $swrcfit ]; then
  echo "=== Installing "$installfilename
  cat $swrcfit | sed -e "s/\/usr\/bin\/octave/$octave2/" | sed -e 's/SLASH/\//g' > $installfilename
  chmod +x $installfilename
else
  echo "$swrcfit was not found."; exit -1
fi

# Check if it works
echo "=== Checking swrcfit"
if [ "$($installfilename swrc.txt | grep -c qs)" -ge 3 ] ; then
  echo "$installfilename was installed successfully."
  exit 0
else
  echo "Not yet installed properly. Trying to install Octave forge packages."
fi

# Install octave forge packages

echo "=== Installing packages (pkg install -forge struct optim nan)"
$octave -q --eval "pkg install -forge struct optim nan"
if [ "$($installfilename swrc.txt | grep -c qs)" -ge 3 ] ; then
  echo "$installfilename was installed successfully."
  exit 0
else
  echo "Octave forge was not installed successfully."
  echo "Not yet installed properly. Trying to get necessary files from sourceforge.net."
fi

# Check if wget is installed
wget=`which wget`

if [ -z "$wget" ]; then
  echo "Install wget and try again."; exit -1
fi

# Download necessary files from sourceforge.net

loadpath=`$octave -q --eval "path" | grep "/" | head -n 1`
if [ -d $loadpath ]; then
  true
else
  echo "Loadpath not found."; exit 1
fi

package="http://sourceforge.net/p/octave/optim/ci/default/tree/inst/"
echo "Downloading \c"

for i in leasqr.m dfdp.m cpiv_bard.m; do
  echo $i"... \c"
  $wget -q -O $loadpath/$i "$package""$i""?format=raw"
done
for i in __dfdp__.m __lm_svd__.m __plot_cmds__.m __do_user_interaction__.m; do
  echo $i"... \c"
  $wget -q -O $loadpath/$i "$package"private/"$i""?format=raw"
done
echo "finished."

if [ "$($installfilename swrc.txt | grep -c qs)" -ge 3 ] ; then
  echo "$installfilename was installed successfully."
  exit 0
else
  echo "Octave forge was not installed successfully."
  echo "Not yet installed properly. Give up."
fi
