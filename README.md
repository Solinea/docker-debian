solinea/debian
---

Minimal base image Debian stable.

`solinea/debian` is a Docker base image based on a stable release of Debian.

The locales package is installed and sets the language to `C.UTF-8`.

# Usage

Create a Dockerfile with the following content:

    FROM solinea/debian

# Minimal Images
Here are some tips for creating minimal images based on `solinea/debian`.

When installing a package, run `apt-get install` without considering recommended packages as a dependency for installation.

    RUN apt-get update && apt-get install -y --no-recommends PACKAGE

# Operating System Distribution
Debian was chosen due to the minimal distribution size. In addition, we wanted
to mitigate any licensing concerns over building on and redistributing a larger
distribution like CentOS or Ubuntu.