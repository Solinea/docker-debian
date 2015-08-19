solinea/debian
---

Minimal base image Debian stable.

`solinea/debian` is a Docker base image based on a stable release of Debian.

# Usage

Create a Dockerfile with the following content:

    FROM solinea/debian

# Minimal Images
Here are some tips for creating minimal images based on `solinea/debian`.

When installing a package, run `apt-get install` without considering
recommended packages as a dependency for installation. Also, clean up after
apt-get by removing temporary files.

    RUN apt-get update -y -q -q \
      && apt-get install -y --no-recommends $package \
      && apt-get clean \
      && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Operating System Distribution
Debian was chosen due to the minimal distribution size. In addition, we wanted
to mitigate any licensing concerns over building on and redistributing a larger
distribution like CentOS or Ubuntu.
