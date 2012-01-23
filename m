From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 0/5] VFIO core framework
Date: Mon, 23 Jan 2012 10:20:05 -0700
Message-ID: <20120123165620.26865.51875.stgit@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org, aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org, joerg.roedel-5C7GfCeVMHo@public.gmane.org, agraf-l3A5Bk7waGM@public.gmane.org, benve-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org, aafabbri-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org, B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org, B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org, avi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This series includes the core framework for the VFIO driver.
VFIO is a userspace driver interface meant to replace both the
KVM device assignment code as well as interfaces like UIO.  Please
see patch 1/5 for a complete description of VFIO, what it can do,
and how it's designed.

This series can also be found here:

git://github.com/awilliam/linux-vfio.git vfio-next

This plus the PCI VFIO bus driver for exposing PCI devices to
userspace can be found here:

git://github.com/awilliam/linux-vfio.git vfio-next-staging

or here for a linux-2.6.git based tree:

git://github.com/awilliam/linux-vfio.git vfio-linux-staging

A fully functional qemu driver for doing non-KVM based PCI
device assignment can be found here:

git://github.com/awilliam/qemu-vfio.git vfio-ng

I'd like to propose VFIO for inclusion in Linux 3.4, starting with
this core framework series.  Once we have agreement on these, I'll
split up and post the VFIO PCI bus driver for inclusion as well.
I can also host the above vfio-next branch for inclusion in
linux-next.  Please review and comment.  Thanks,

Alex

v2: Interrupt setup ioctl rework based on comments by Konrad.
    The interrupt ioctls are no longer exclusively targeted
    at eventfds, allowing for more flexibility of other vfio
    bus drivers making use of alternate mechanisms.  Also
    updated vfio_iommu_info to report common IOMMU geometry
    fields that we know we're going to need for Freescale
    PAMU.  Additional ioctls and fields to be added via flags
    as they're implemented in the IOMMU API.

---

Alex Williamson (5):
      vfio: VFIO core Kconfig and Makefile
      vfio: VFIO core IOMMU mapping support
      vfio: VFIO core group interface
      vfio: VFIO core header
      vfio: Introduce documentation for VFIO driver


 Documentation/ioctl/ioctl-number.txt |    1 
 Documentation/vfio.txt               |  359 ++++++++++
 MAINTAINERS                          |    8 
 drivers/Kconfig                      |    2 
 drivers/Makefile                     |    1 
 drivers/vfio/Kconfig                 |    8 
 drivers/vfio/Makefile                |    3 
 drivers/vfio/vfio_iommu.c            |  611 +++++++++++++++++
 drivers/vfio/vfio_main.c             | 1248 ++++++++++++++++++++++++++++++++++
 drivers/vfio/vfio_private.h          |   36 +
 include/linux/vfio.h                 |  395 +++++++++++
 11 files changed, 2672 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/vfio.txt
 create mode 100644 drivers/vfio/Kconfig
 create mode 100644 drivers/vfio/Makefile
 create mode 100644 drivers/vfio/vfio_iommu.c
 create mode 100644 drivers/vfio/vfio_main.c
 create mode 100644 drivers/vfio/vfio_private.h
 create mode 100644 include/linux/vfio.h
