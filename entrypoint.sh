for package_name in $(grep -o '^[^#]*' /home/dockeruser/$repo_name/packages.txt); do
    if [[! -d "/home/dockeruser/$repo_name/packages/$package_name"]]; then git clone https://aur.archlinux.org/$package_name.git /home/dockeruser/$repo_name/packages/$package_name >/dev/null 2>&1; fi
    if [[$(git -C /home/dockeruser/$repo_name/packages/$package_name status -uno --porcelain)]]; then (cd /home/dockeruser/$repo_name/packages/$package_name && git pull -q --all && makepkg -sf --noconfirm) >/dev/null 2>&1; fi
done (cd /home/dockeruser/$repo_name/x86_64 && repo-add $repo_name.db.tar.gz ../packages/*/*.pkg.tar.zst) >/dev/null 2>&1