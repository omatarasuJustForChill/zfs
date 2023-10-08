# part 1
# create zpool
zpool create my_pool mirror /dev/vdb /dev/vdc mirror /dev/vdd /dev/vde mirror /dev/vdf /dev/vdg mirror /dev/vdh /dev/vdi
# create zfs
zfs create my_pool/live_ar_test01
zfs create my_pool/live_ar_test02
zfs create my_pool/live_ar_test03
zfs create my_pool/live_ar_test04
for i in {1..4}; do wget -P /my_pool/live_ar_test0$i https://gutenberg.org/cache/epub/2600/pg2600.converter.log; done
zfs get compressratio
# output (gzip-9 - best)
# NAME                    PROPERTY       VALUE  SOURCE
# my_pool                 compressratio  1.78x  -
# my_pool/live_ar_test01  compressratio  1.91x  -
# my_pool/live_ar_test02  compressratio  2.22x  -
# my_pool/live_ar_test03  compressratio  3.65x  -
# my_pool/live_ar_test04  compressratio  1.00x  -

# part 2
# download
wget -O archive.tar.gz --no-check-certificate 'https://drive.google.com/u/0/uc?id=1KRBNW33QWqbvbVHa3hLJivOAt60yukkg&export=download' 
# unarchive
tar -xzvf archive.tar.gz
# import
zpool import -d zpoolexport/ otus import_pool
# get size
zfs get all import_pool | grep -E -i 'available'
# get type
zfs get all import_pool | grep -E -i '\btype\b'
# get recordsize 
zfs get all import_pool | grep -E -i 'recorsize'
# get compression
zfs get all import_pool | grep -E -i 'compression'
# get checksum 
zfs get all import_pool | grep -E -i 'checksum'

# part 3
wget -O otus_task2.file --no-check-certificate "https://drive.google.com/u/0/uc?id=1gH8gCL9y7Nd5Ti3IRmplZPF1XjzxeRAG&export=download"
zfs receive import_pool/test@today < otus_task2.file
cd /import_pool/test/
cat task1/file_mess/secret_message 
# https://github.com/sindresorhus/awesome 