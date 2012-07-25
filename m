From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [GIT PULL (PATCH 0/4)] VFIO driver for v3.6
Date: Wed, 25 Jul 2012 08:53:06 -0600
Message-ID: <20120725142254.12800.61860.stgit@bling.home>
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
To: torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Cc: B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org, agraf-l3A5Bk7waGM@public.gmane.org, avi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org, B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, benve-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Linus,

This series includes the VFIO userspace driver interface for the
3.6 kernel merge window.  This driver is intended to provide a
secure interface for device access using IOMMU protection for
applications like assignment of physical devices to virtual
machines.  Qemu will be the first user of this interface, enabling
assignment of PCI devices to Qemu guests.  This interface is
intended to eventually replace the x86-specific assignment mechanism
currently available in KVM.  This interface has the advantage of
being more secure, by working with IOMMU groups to ensure device
isolation and providing it's own filtered resource access mechanism,
and also more flexible, in not being x86 or KVM specific (extensions
to enable POWER are already working).

As a new driver, I'm including both the individual patches in email,
as well as a branch to pull from:

git://github.com/awilliam/linux-vfio.git for-linus

This driver is originally the work of Tom Lyon, but has since been
handed over to me and gone through a complete overhaul thanks to the
input from David Gibson, Ben Herrenschmidt, Chris Wright, Joerg
Roedel, and others.  This driver has been available in linux-next for
the last month.  Thanks,

Alex

---

Alex Williamson (4):
      vfio: Add PCI device driver
      vfio: Type1 IOMMU implementation
      vfio: Add documentation
      vfio: VFIO core


 Documentation/ioctl/ioctl-number.txt |    1 
 Documentation/vfio.txt               |  314 +++++++
 MAINTAINERS                          |    8 
 drivers/Kconfig                      |    2 
 drivers/Makefile                     |    1 
 drivers/vfio/Kconfig                 |   16 
 drivers/vfio/Makefile                |    3 
 drivers/vfio/pci/Kconfig             |    8 
 drivers/vfio/pci/Makefile            |    4 
 drivers/vfio/pci/vfio_pci.c          |  579 +++++++++++++
 drivers/vfio/pci/vfio_pci_config.c   | 1540 ++++++++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_intrs.c    |  740 ++++++++++++++++
 drivers/vfio/pci/vfio_pci_private.h  |   91 ++
 drivers/vfio/pci/vfio_pci_rdwr.c     |  269 ++++++
 drivers/vfio/vfio.c                  | 1420 +++++++++++++++++++++++++++++++
 drivers/vfio/vfio_iommu_type1.c      |  753 +++++++++++++++++
 include/linux/vfio.h                 |  445 ++++++++++
 17 files changed, 6194 insertions(+)
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
 create mode 100644 drivers/vfio/vfio_iommu_type1.c
 create mode 100644 include/linux/vfio.h
