# make it possible to create shortcuts to specific terminal commands

robot -l NONE -o NONE -r NONE tasks/Delorean.robot
robot -d ./logs -v BROWSER:chromium -v HEADLESS:true -i smoke tests
