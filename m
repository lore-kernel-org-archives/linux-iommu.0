From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2] iommu/amd: Cache pdev pointer to root-bridge
Date: Fri, 1 Jun 2012 16:05:00 +0200
Message-ID: <1338559501-15478-1-git-send-email-joerg.roedel@amd.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

At some point pci_get_bus_and_slot started to enable
interrupts. Since this function is used in the
amd_iommu_resume path it will enable interrupts on resume
which causes a warning. The fix will use a cached pointer
to the root-bridge to re-enable the IOMMU in case the BIOS
is broken.

Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu_init.c  |   13 +++++--------
 drivers/iommu/amd_iommu_types.h |    3 +++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index c567903..542024b 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1029,6 +1029,9 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 	if (!iommu->dev)
 		return 1;
 
+	iommu->root_pdev = pci_get_bus_and_slot(iommu->dev->bus->number,
+						PCI_DEVFN(0, 0));
+
 	iommu->cap_ptr = h->cap_ptr;
 	iommu->pci_seg = h->pci_seg;
 	iommu->mmio_phys = h->mmio_phys;
@@ -1323,20 +1326,16 @@ static void iommu_apply_resume_quirks(struct amd_iommu *iommu)
 {
 	int i, j;
 	u32 ioc_feature_control;
-	struct pci_dev *pdev = NULL;
+	struct pci_dev *pdev = iommu->root_pdev;
 
 	/* RD890 BIOSes may not have completely reconfigured the iommu */
-	if (!is_rd890_iommu(iommu->dev))
+	if (!is_rd890_iommu(iommu->dev) || !pdev)
 		return;
 
 	/*
 	 * First, we need to ensure that the iommu is enabled. This is
 	 * controlled by a register in the northbridge
 	 */
-	pdev = pci_get_bus_and_slot(iommu->dev->bus->number, PCI_DEVFN(0, 0));
-
-	if (!pdev)
-		return;
 
 	/* Select Northbridge indirect register 0x75 and enable writing */
 	pci_write_config_dword(pdev, 0x60, 0x75 | (1 << 7));
@@ -1346,8 +1345,6 @@ static void iommu_apply_resume_quirks(struct amd_iommu *iommu)
 	if (!(ioc_feature_control & 0x1))
 		pci_write_config_dword(pdev, 0x64, ioc_feature_control | 1);
 
-	pci_dev_put(pdev);
-
 	/* Restore the iommu BAR */
 	pci_write_config_dword(iommu->dev, iommu->cap_ptr + 4,
 			       iommu->stored_addr_lo);
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 2452f3b..2435555 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -481,6 +481,9 @@ struct amd_iommu {
 	/* Pointer to PCI device of this IOMMU */
 	struct pci_dev *dev;
 
+	/* Cache pdev to root device for resume quirks */
+	struct pci_dev *root_pdev;
+
 	/* physical address of MMIO space */
 	u64 mmio_phys;
 	/* virtual address of MMIO space */
-- 
1.7.9.5
