CON "\033[0;32mDeploying updates to GitHub...\033[0m\n"

Rem Build the project.
hugo -t smol

Rem Go To Public folder
cd public

Rem Add changes to git.
git add .

Rem Commit changes.
git commit -m "Update Hugo Site"

Rem Push source and build repos.
git push origin main