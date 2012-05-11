From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 00/13] IOMMU Groups + VFIO
Date: Fri, 11 May 2012 16:55:25 -0600
Message-ID: <20120511222148.30496.68571.stgit@bling.home>
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
To: benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org, joerg.roedel-5C7GfCeVMHo@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, agraf-l3A5Bk7waGM@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org, chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org, B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, avi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, benve-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This is the latest incantation of IOMMU Groups and matching VFIO
code.  After some discussions with BenH and David Gibson I think
we have some agreement on moving forward with the IOMMU Group
approach, which covers the first 6 patches in this series.  The
basic idea of this is that IOMMU groups need to be a more
integrated part of the driver model.  The current iommu_device_group
interface requires the user to do all all the heavy lifting of
finding devices reporting the same ID and putting them together into
something useful.  If an esoteric driver like VFIO is the only user
of the groups, this works nicely, but if we want to use groups for
common DMA paths, it's too much overhead.  We therefore add an
iommu_group pointer off the device so we can easily get to the group
for fast paths like streaming DMA (GregKH, does this work for you?).

I include code to support IOMMU group on both amd_iommu and
intel-iommu.  These take into account device quirks, like the Ricoh
device that David Woodhouse has noted on a few occasions.  I'll
leave it to the iommu owners to make use of these.

For VFIO itself, the core has had nearly a complete rewrite to
support the IOMMU group interface and also to switch to a new model
for allowing IOMMU domains to share context (merge is gone).  To
allow the most flexibility (and also to avoid ratholing on the exposed
IOMMU interface), the VFIO IOMMU backend is completely modular,
allowing the user to probe and initiate a specific backend for a
group.  I've poorly chosen the name "x86" for the current IOMMU
backend, simply for lack of a good way to describe a non-window based,
page table driven IOMMU implementation.

These patches can be found in git here:

git://github.com/awilliam/linux-vfio.git (iommu-group-vfio-20120511)

The matching qemu tree supporting VFIO device assignment is here:

git://github.com/awilliam/qemu-vfio.git (iommu-group-vfio)

Sorry, this is based on Qemu-1.0.  Updating to 1.1 is next on my
todo list.

I'd really like to move forward with this, so please provide
comments and feedback.  This touches iommu, x86 iommu drivers, pci,
device, and adds a new driver, so I appreciate any kind of ack
(or nak I suppose) to know if we've got end-to-end support.  Thanks!

Alex
---

Alex Williamson (13):
      vfio: Add PCI device driver
      pci: Misc pci_reg additions
      pci: Create common pcibios_err_to_errno
      pci: export pci_user functions for use by other drivers
      vfio: x86 IOMMU implementation
      vfio: Add documentation
      vfio: VFIO core
      iommu: Make use of DMA quirking and ACS enabled check for groups
      pci: New pci_acs_enabled()
      pci: New pci_dma_quirk()
      iommu: IOMMU groups for VT-d and AMD-Vi
      iommu: IOMMU Groups
      driver core: Add iommu_group tracking to struct device


 Documentation/ioctl/ioctl-number.txt |    1 
 Documentation/vfio.txt               |  315 +++++++
 MAINTAINERS                          |    8 
 drivers/Kconfig                      |    2 
 drivers/Makefile                     |    1 
 drivers/iommu/amd_iommu.c            |   52 +
 drivers/iommu/intel-iommu.c          |   72 +-
 drivers/iommu/iommu.c                |  449 +++++++++-
 drivers/pci/access.c                 |    6 
 drivers/pci/pci.c                    |   43 +
 drivers/pci/pci.h                    |    8 
 drivers/pci/quirks.c                 |   22 
 drivers/vfio/Kconfig                 |   16 
 drivers/vfio/Makefile                |    3 
 drivers/vfio/pci/Kconfig             |    8 
 drivers/vfio/pci/Makefile            |    4 
 drivers/vfio/pci/vfio_pci.c          |  557 ++++++++++++
 drivers/vfio/pci/vfio_pci_config.c   | 1527 ++++++++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_intrs.c    |  724 ++++++++++++++++
 drivers/vfio/pci/vfio_pci_private.h  |   91 ++
 drivers/vfio/pci/vfio_pci_rdwr.c     |  267 ++++++
 drivers/vfio/vfio.c                  | 1406 +++++++++++++++++++++++++++++++
 drivers/vfio/vfio_iommu_x86.c        |  743 +++++++++++++++++
 drivers/xen/xen-pciback/conf_space.c |    6 
 include/linux/device.h               |    2 
 include/linux/iommu.h                |   84 ++
 include/linux/pci.h                  |   37 +
 include/linux/pci_regs.h             |  112 ++
 include/linux/vfio.h                 |  442 ++++++++++
 29 files changed, 6892 insertions(+), 116 deletions(-)
 create mode 100644 Documentation/vfio.txt
 create mode 100644 drivers/vfio/Kconfig
 create mode 100644 drivers/vfio/Makefile
 create mode 100644 drivers/vfio/pci/Kconfig
 create mode 100644 drivers/vfio/pci/Makefile
 create mode 100644 drivers/vfio/pci/vfio_pci.c
 create mode 100644 drivers/vfio/pci/vfio_pci_config.c
 create mode 100644 drivers/vfio/pci/vfio_pci_intrs.c
 create mode 100644 drivers/vfio/pci/vfio_pci_private.h
 create mode 100644 drivers/vfio/pci/vfio_pci_rdwr.c
 create mode 100644 drivers/vfio/vfio.c
 create mode 100644 drivers/vfio/vfio_iommu_x86.c
 create mode 100644 include/linux/vfio.h
