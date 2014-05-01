From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 00/13] PCI/iommu: Fix DMA alias problems
Date: Thu, 01 May 2014 10:27:05 -0600
Message-ID: <20140501160128.17512.23609.stgit@bling.home>
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
To: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This series attempts to fix a couple issues we've had outstanding in
the PCI/IOMMU code for a while.  The first issue is with devices that
use the wrong requester ID for DMA transactions.  We already have a
sort of half-baked attempt to fix this for several Ricoh devices, but
the fix only helps them be useful through IOMMU groups, not the
general DMA case.  There are also several Marvell devices which use
use a different wrong requester ID and don't even fit into the DMA
source idea.  This series creates a DMA alias iterator that will
step through each possible alias of a device, allowing IOMMUs to
insert mappings for both the device and its aliases.

Hand-in-hand with this is our broken pci_find_upstream_pcie_bridge()
function, which is known to blowup when it finds itself suddenly at
a PCIe device without crossing a PCIe-to-PCI bridge (as identified by
the PCIe capability).  It also likes to make the invalid assumption
that a PCIe device never has its requester ID masked by any usptream
bus.  We can fix this using the above new DMA alias iterator, since
that's effectively what this function was meant to do.

Finally, with all these helpers, it makes sense to consolidate code
for determining IOMMU groups.  The first step in finding the root
of a group is finding the final upstream DMA alias for the device,
then applying additional ACS rules and incorporating device specific
aliases.  As this is all common to PCI, create a single implementation
and remove piles of code from the individual IOMMU drivers.

This series allows devices like the Marvell 88SE9123 to finally work
on Linux with either AMD-Vi or VT-d enabled on the box.  I've
collected device IDs from various bugs to support as many SKUs of
these devices as possible, but I'm sure there are others that I've
missed.

This should also enable motherboards with an onboard ASmedia
ASM1083/1085 PCIe-to-PCI bridge to work with VT-d enabled.  I've
acquired an adapter board with this chip, but it actually exposes
a PCIe capability, unlike most of the onboard controllers.  Therefore
I expect this series will fix the WARN_ON currently hit during boot,
but there's a 50/50 chance whether the device behaves like a PCI
bridge or a PCIe bridge with regard to the requester ID that it uses
to take ownership of the transaction.  If it turns out to use the
PCIe bridge model, I expect we can quirk it using a dev_flags bit
to identify a PCI bridge that takes ownership as if it was a PCIe
bridge.

Please test and provide feedback.  I expect IOMMU group topology
should not change from this series, but if a case is found where it
does, please share.  Also, if there are additional quirks we need
to add, please either file new or add to the existing bugs.  Thanks,

Alex

---

Alex Williamson (13):
      PCI: Add DMA alias iterator
      PCI: quirk pci_for_each_dma_alias()
      PCI: quirk dma_func_alias for Ricoh devices
      PCI: quirk dma_func_alias for Marvell devices
      PCI: Consolidate isolation domain code
      iommu/amd: Use pci_find_dma_isolation_root() for IOMMU groups
      iommu/amd: Update to use PCI DMA aliases
      iommu/intel: Use pci_find_dma_isolation_root() for IOMMU groups
      iommu/intel: Update to use PCI DMA aliases
      iommu/fsl: Use pci_find_dma_isolation_root() for IOMMU groups
      iommu: Remove pci.h
      PCI: Remove pci_find_upstream_pcie_bridge()
      PCI: Remove pci_get_dma_source()


 drivers/iommu/amd_iommu.c           |  185 ++++------------------
 drivers/iommu/amd_iommu_types.h     |    1 
 drivers/iommu/fsl_pamu_domain.c     |   67 --------
 drivers/iommu/intel-iommu.c         |  293 +++++++++++++----------------------
 drivers/iommu/intel_irq_remapping.c |   55 +++++--
 drivers/iommu/pci.h                 |   29 ---
 drivers/pci/quirks.c                |   73 ++++-----
 drivers/pci/search.c                |  234 +++++++++++++++++++++++++---
 include/linux/pci.h                 |   21 +--
 9 files changed, 430 insertions(+), 528 deletions(-)
 delete mode 100644 drivers/iommu/pci.h
