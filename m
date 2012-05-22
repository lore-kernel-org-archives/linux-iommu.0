From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 00/13] IOMMU Groups + VFIO
Date: Mon, 21 May 2012 23:04:30 -0600
Message-ID: <20120522043607.5871.11340.stgit@bling.home>
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

Version 2 incorporating acks and feedback from v1.  The PCI DMA quirk
and ACS check are reworked, sysfs iommu groups ABI Documentation
added as well as numerous other fixes, including patches from Alexey
Kardashevskiy towards supporting POWER usage of VFIO and IOMMU groups.

This series can be found here on top of 3.4:

git://github.com/awilliam/linux-vfio.git iommu-group-vfio-20120521

The Qemu tree has also been updated to Qemu 1.1 and can be found here:

git://github.com/awilliam/qemu-vfio.git iommu-group-vfio

I'd really like to make a push to get this in for 3.5, so let's talk
about how to do that across iommu, pci, and new driver.  Joerg, are
you sufficiently happy with the IOMMU group concept and code?  We'll
also need David Woodhouse buyin on the intel-iommu changes in patches
3 & 6.  Who needs to approve VFIO as a new driver, GregKH?  Bjorn,
I'd be happy to send the PCI changes as a series for you, but I
wonder if it makes sense to collect acks for them if you approve and
bundle them in with the associated code that needs them so you're
not left with unused code.  Let me know which you prefer.  If there
are better ways to do it, please let me know.  Thanks,

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
      pci: Add ACS validation utility
      pci: Add PCI DMA source ID quirk
      iommu: IOMMU groups for VT-d and AMD-Vi
      iommu: IOMMU Groups
      driver core: Add iommu_group tracking to struct device


 .../ABI/testing/sysfs-kernel-iommu_groups          |   14 
 Documentation/ioctl/ioctl-number.txt               |    1 
 Documentation/vfio.txt                             |  315 ++++
 MAINTAINERS                                        |    8 
 drivers/Kconfig                                    |    2 
 drivers/Makefile                                   |    1 
 drivers/iommu/amd_iommu.c                          |   67 +
 drivers/iommu/intel-iommu.c                        |   87 +
 drivers/iommu/iommu.c                              |  578 +++++++-
 drivers/pci/access.c                               |    6 
 drivers/pci/pci.c                                  |   76 +
 drivers/pci/pci.h                                  |    7 
 drivers/pci/quirks.c                               |   69 +
 drivers/vfio/Kconfig                               |   16 
 drivers/vfio/Makefile                              |    3 
 drivers/vfio/pci/Kconfig                           |    8 
 drivers/vfio/pci/Makefile                          |    4 
 drivers/vfio/pci/vfio_pci.c                        |  557 +++++++
 drivers/vfio/pci/vfio_pci_config.c                 | 1522 ++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_intrs.c                  |  724 ++++++++++
 drivers/vfio/pci/vfio_pci_private.h                |   91 +
 drivers/vfio/pci/vfio_pci_rdwr.c                   |  269 ++++
 drivers/vfio/vfio.c                                | 1413 +++++++++++++++++++
 drivers/vfio/vfio_iommu_x86.c                      |  743 ++++++++++
 drivers/xen/xen-pciback/conf_space.c               |    6 
 include/linux/device.h                             |    2 
 include/linux/iommu.h                              |  104 +
 include/linux/pci.h                                |   49 +
 include/linux/pci_regs.h                           |  112 +
 include/linux/vfio.h                               |  444 ++++++
 30 files changed, 7182 insertions(+), 116 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-iommu_groups
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
