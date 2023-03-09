# make it possible to create shortcuts to specific terminal commands

robot -l NONE -o NONE -r NONE tasks/Delorean.robot
pabot -d ./logs -v BROWSER:chromium -v HEADLESS:true -i smoke tests

# delete the old browser file and create a brand new one
rm -rf ./logs/browser
mkdir ./logs/browser
mkdir ./logs/browser/screenshot

# list all type png files from pabot_results and copy it to the new screenshot file
cp $(find ./logs/pabot_results -type f -name "*.png") ./logs/browser/screenshot 