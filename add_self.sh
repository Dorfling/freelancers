#!/usr/bin/env sh

# Get new users details
read -p 'Name & Surname: ' name
read -p '/people/ filename (Excluding .md): ' filename
read -p 'Email: ' email
read -p 'Website: ' website
read -p 'Skill set: ' skillset
read -p 'Github Handle: ' github
read -p 'ZATech handle: ' zatech
read -p 'Twitter handle: ' twitter
read -p 'Linkedin handle (https://www.linkedin.com/in/[handle]/): ' linkedin
read -p 'Cellphone number: ' cell

# Add new user to the README before sorting
echo "[${name}](/people/${filename}.md) | ${website} | ${skillset} | [GitHub](https://github.com/${github})" >> README.md

sed -E \
  -e 's/# Jane Doe/# '"${name}"'/' \
  -e 's/best-dev-ever-zatech/'"${zatech}"'/' \
  -e 's/best-dev-ever-twitter/'"${twitter}"'/' \
  -e 's/no-recruiters-please@janedoe.com/'"${email}"'/' \
  -e 's/cell_number/'"${cell}"'/' \
  -e 's#website_link#'"${website}"'#' \
  -e 's#best-dev-ever-github#'"${github}"'#' \
  -e 's#best-dev-ever-linkedin#'"${linkedin}"'#' \
  people/janedoe.md > people/"${filename}".md

# Get the line number for the top of the table, and skip them
LNR=$(grep -n 'Name |' README.md | cut -f1 -d:)
LNR=$(($LNR+2))

# Sort the table lexographically by name
SORTED_TABLE=$(tail -n +"${LNR}" README.md | sort --field-separator=\| --key=1)

# Make a backup of the README before deleting the table and adding the sorted table
sed -i.backup ${LNR}',$d' README.md
printf "%s" "${SORTED_TABLE}" >> README.md
