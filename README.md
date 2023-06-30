# Custom Arch Repository

This GitHub Actions workflow creates a custom local repository for Arch Linux using the gh-pages branch. It automates the process of cloning AUR packages, building them, and creating the repository structure.

## Usage

To use this action, follow these steps:

1. Create a new workflow file (e.g., `.github/workflows/create-repo.yml`) in your repository.

2. Add the following content to the workflow file:

```yaml
name: Create Custom Arch Repository

on:
  push: workflow_dispatch

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout repository
      uses: actions/checkout@v3

    - name: Build and create repository
      uses: taonga07/CustomArchRepo@v1
```

3. Create a new text file at `packages.txt` in your repository
4. Add packages from the AUR (1 per line) you may use a `#` for notes

## Accessing the Custom Repository

After the workflow completes successfully, you can add the custom repository to your Arch Linux system by modifying the `/etc/pacman.conf` file:

```ini
[<repository-name>]
SigLevel = Optional TrustedOnly
Server = https://<username>.github.io/<repository-name>/$arch
```

Replace `<repository-name>` with the name of your repository and `<username>` and `<repository-name>` with your GitHub username and the name of your repository, respectively.

Now you can install packages from your custom repository using `pacman -S <package-name>`.