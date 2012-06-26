From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Request VFIO inclusion in linux-next
Date: Mon, 25 Jun 2012 22:55:52 -0600
Message-ID: <1340686552.1207.128.camel@bling.home>
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
To: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: kvm <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alexey Kardashevskiy <aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org>, linux-pci <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, qemu-devel <qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org>, chrisw <chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

VFIO has been kicking around for well over a year now and has been
posted numerous times for review.  The pre-requirements are finally
available in linux-next (or will be in the 20120626 build) so I'd like
to request a new branch be included in linux-next with a goal of being
accepted into v3.6.

VFIO is a userspace driver interface designed to support assignment of
devices into virtual machines using IOMMU level access control.  This
IOMMU requirement, secure resource access, and flexible interrupt
support make VFIO unique from existing drivers, like UIO.  VFIO supports
modular backends for both IOMMU and device access.  Initial backends are
included for PCI device assignment using the IOMMU API in a manner
compatible with x86 device assignment.  POWER support is also under
development, making use of the same PCI device backend, but adding new
IOMMU support for their platforms.

As with previous versions of VFIO, Qemu is targeted as a primary user
and a working development tree including vfio-pci support can be found
here:

git://github.com/awilliam/qemu-vfio.git iommu-group-vfio

Eventually we hope VFIO can deprecate the x86, PCI-specific device
assignment currently used by KVM.

The info for linux-next:

Tree: git://github.com/awilliam/linux-vfio.git
Branch: next
Contact: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

This branch should be applied after both Bjorn's PCI next branch and
Joerg's IOMMU next branch and contains the following changes:

 Documentation/ioctl/ioctl-number.txt |    1 
 Documentation/vfio.txt               |  315 +++++++
 MAINTAINERS                          |    8 
 drivers/Kconfig                      |    2 
 drivers/Makefile                     |    1 
 drivers/vfio/Kconfig                 |   16 
 drivers/vfio/Makefile                |    3 
 drivers/vfio/pci/Kconfig             |    8 
 drivers/vfio/pci/Makefile            |    4 
 drivers/vfio/pci/vfio_pci.c          |  565 ++++++++++++
 drivers/vfio/pci/vfio_pci_config.c   | 1528 +++++++++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_intrs.c    |  727 ++++++++++++++++
 drivers/vfio/pci/vfio_pci_private.h  |   91 ++
 drivers/vfio/pci/vfio_pci_rdwr.c     |  269 ++++++
 drivers/vfio/vfio.c                  | 1420 ++++++++++++++++++++++++++++++++
 drivers/vfio/vfio_iommu_type1.c      |  754 +++++++++++++++++
 include/linux/vfio.h                 |  445 ++++++++++
 17 files changed, 6157 insertions(+)

If there are any objections to including this, please speak now.  If
anything looks amiss in the branch, let me know.  I've never hosted a
next branch.  Review comments welcome and I'll be glad to post the
series in email again if requested.  Thanks,

Alex
