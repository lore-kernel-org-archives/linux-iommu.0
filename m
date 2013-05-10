From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 0/3] pci/iommu: Quirk non-compliant PCIe-to-PCI bridges
Date: Fri, 10 May 2013 15:18:39 -0600
Message-ID: <20130510210937.32592.21950.stgit@bling.home>
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
To: bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, stephen-OTpzqLSitTUnbdJkjeBofR2eb7JE58TQ@public.gmane.org
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This series tries to address:

https://bugzilla.kernel.org/show_bug.cgi?id=44881

Where pci_find_upstream_pcie_bridge() gets lost trying to find the
upstream PCIe-to-PCI bridge for a device because the bridge doesn't
expose a PCIe capability.  To do this, we add a pci_is_pcie_bridge
function which includes a quirk to look to the next upstream device
as a sanity check.  We can then replace pci_find_upstream_pcie_bridge
with a function that's a bit more generic and less tied to intel-iommu
eccentricities.

This works on my VT-d system, but I don't have any of the offending
bridges.  Appreciate testing from those who do.  I'll link this series
to the bz above for more testing.  Thanks,

Alex

---

Alex Williamson (3):
      pci: Add PCI walk function and PCIe bridge test
      intel-iommu: Convert to pci_walk_up_to_first_match
      pci: Remove pci_find_pcie_upstream_bridge


 drivers/iommu/intel-iommu.c         |   77 ++++++++++++++++++++++-------------
 drivers/iommu/intel_irq_remapping.c |   13 ++++--
 drivers/pci/search.c                |   74 ++++++++++++++++++++++------------
 include/linux/pci.h                 |   26 +++++++++---
 4 files changed, 124 insertions(+), 66 deletions(-)
