#!/bin/bash

cat > ~/1_script_gotalent.sh <<EOF
#!/bin/bash

gh auth login

git clone https://github.com/jeffhuang4704/GoTalent.git
cd GoTalent/GPortal3/

docker build -t chihjenhuang/gotalent:v1 .

echo 'to run the image...'
echo 'docker run --rm -p 8080:80 -p 8025:8025 chihjenhuang/gotalent:v1'
EOF

chmod +x ~/1_script_gotalent.sh

# generate for gocheck
cat > ~/2_script_gocheck.sh <<EOF
#!/bin/bash

gh auth login

git clone https://github.com/jeffhuang4704/GPortal-Sign-Off.git
cd GPortal-Sign-Off

docker build -t chihjenhuang/gocheck:v1 .

echo 'to run the image...'
echo 'docker run --rm -p 8080:80 -p 8025:8025 chihjenhuang/gocheck:v1'

echo '# port-forward (on WSL); note I use 8026 here as I have a mailpit docker on my Windows which uses 8025 '
echo 'jeff@SUSE-387793:~ ()$ labctl port-forward 679dada48718ea94027cc2c7 -L 8080:8080 -L 8026:8025'

echo '# visit from Windows laptop, for web console'
echo 'http://localhost:8080'

echo '# visit from Windows laptop, for mailpit web console'
echo 'http://localhost:8026'
EOF

chmod +x ~/2_script_gocheck.sh
