#!/bin/bash
read -p "Git commit message: " COMMIT
git add .
git commit -m "$COMMIT"
git push
read -p "Done! Press any key to exit"
