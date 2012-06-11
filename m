From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v3 0/5] PCI: Prep for VFIO and IOMMU Groups
Date: Mon, 11 Jun 2012 09:26:42 -0600
Message-ID: <20120611152021.25959.71601.stgit@bling.home>
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
To: bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

v3:
 - Small change to device specific ACS check to allow quirk to
   support yes/no/pass type functionality. (no change to other
   patches and no trickle down through IOMMU series)

Bjorn, what's needed to get these in?  Thanks,

Alex

v2:
 - Test that we're not given func 0 before doing lookup
 - Fix duplicate ricoh quirk
 - Rename pci_dma_source() to pci_get_dma_source() and make sure
   we always take a reference for the returned pci_dev.  Add comment

These last two changes trickle down through the IOMMU series, so
will generate a v2 there as well.  Thanks,

Alex

v1:
These are the PCI related patches from the previously submitted
v2 IOMMU Groups + VFIO series.  I've updated them with Don's
comments and split them off on their own so that we can hopefully
make some progress getting these in.  Patches are against 20120529
linux-next tree.

Patches 1 & 2 provide DMA quirking and ACS checking which will be
used by IOMMU drivers supporting IOMMU groups.  Patch 3 enables the
set of pci user config access functions to be called from other
modules, which will be used by VFIO-pci.  Patch 4 enables a common
translation of pcibios errors into errno for returning to userspace,
also to be used by VFIO-pci.  Patch 5 adds additional PCI register
definitions so we can more easily parse config space for devices in
VFIO-pci.

These patches, as well as IOMMU group support and VFIO can be
found in git here:

git://github.com/awilliam/linux-vfio.git (iommu-group-vfio-next-20120529)

Please consider these for 3.5, but I'll settle for any kind of next
branch.  Thanks,

Alex

---

Alex Williamson (5):
      pci: Misc pci_reg additions
      pci: Create common pcibios_err_to_errno
      pci: export pci_user functions for use by other drivers
      pci: Add ACS validation utility
      pci: Add PCI DMA source ID quirk


 drivers/pci/access.c                 |    6 +-
 drivers/pci/pci.c                    |   69 +++++++++++++++++++++
 drivers/pci/pci.h                    |    7 --
 drivers/pci/quirks.c                 |   84 +++++++++++++++++++++++++
 drivers/xen/xen-pciback/conf_space.c |    6 +-
 include/linux/pci.h                  |   49 ++++++++++++++-
 include/linux/pci_regs.h             |  113 ++++++++++++++++++++++++++++++----
 7 files changed, 309 insertions(+), 25 deletions(-)
