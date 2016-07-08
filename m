From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 04/20] iommu/amd: Create a list of reserved iova addresses
Date: Fri,  8 Jul 2016 13:44:55 +0200
Message-ID: <1467978311-28322-5-git-send-email-joro@8bytes.org>
References: <1467978311-28322-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1467978311-28322-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Vincent.Wan-5C7GfCeVMHo@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Put the MSI-range, the HT-range and the MMIO ranges of PCI
devices into that range, so that these addresses are not
allocated for DMA.

Copy this address list into every created dma_ops_domain.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 71af367..4b8b9ee 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -62,6 +62,12 @@
 #define IOVA_PFN(addr)		((addr) >> PAGE_SHIFT)
 #define DMA_32BIT_PFN		IOVA_PFN(DMA_BIT_MASK(32))
 
+/* Reserved IOVA ranges */
+#define MSI_RANGE_START		(0xfee00000)
+#define MSI_RANGE_END		(0xfeefffff)
+#define HT_RANGE_START		(0xfd00000000ULL)
+#define HT_RANGE_END		(0xffffffffffULL)
+
 /*
  * This bitmap is used to advertise the page sizes our hardware support
  * to the IOMMU core, which will then use this information to split
@@ -168,6 +174,9 @@ struct dma_ops_domain {
 	struct iova_domain iovad;
 };
 
+static struct iova_domain reserved_iova_ranges;
+static struct lock_class_key reserved_rbtree_key;
+
 /****************************************************************************
  *
  * Helper functions
@@ -2055,6 +2064,9 @@ static struct dma_ops_domain *dma_ops_domain_alloc(void)
 	init_iova_domain(&dma_dom->iovad, PAGE_SIZE,
 			 IOVA_START_PFN, DMA_32BIT_PFN);
 
+	/* Initialize reserved ranges */
+	copy_reserved_iova(&reserved_iova_ranges, &dma_dom->iovad);
+
 	return dma_dom;
 
 free_dma_dom:
@@ -2960,6 +2972,59 @@ static struct dma_map_ops amd_iommu_dma_ops = {
 	.set_dma_mask	= set_dma_mask,
 };
 
+static int init_reserved_iova_ranges(void)
+{
+	struct pci_dev *pdev = NULL;
+	struct iova *val;
+
+	init_iova_domain(&reserved_iova_ranges, PAGE_SIZE,
+			 IOVA_START_PFN, DMA_32BIT_PFN);
+
+	lockdep_set_class(&reserved_iova_ranges.iova_rbtree_lock,
+			  &reserved_rbtree_key);
+
+	/* MSI memory range */
+	val = reserve_iova(&reserved_iova_ranges,
+			   IOVA_PFN(MSI_RANGE_START), IOVA_PFN(MSI_RANGE_END));
+	if (!val) {
+		pr_err("Reserving MSI range failed\n");
+		return -ENOMEM;
+	}
+
+	/* HT memory range */
+	val = reserve_iova(&reserved_iova_ranges,
+			   IOVA_PFN(HT_RANGE_START), IOVA_PFN(HT_RANGE_END));
+	if (!val) {
+		pr_err("Reserving HT range failed\n");
+		return -ENOMEM;
+	}
+
+	/*
+	 * Memory used for PCI resources
+	 * FIXME: Check whether we can reserve the PCI-hole completly
+	 */
+	for_each_pci_dev(pdev) {
+		int i;
+
+		for (i = 0; i < PCI_NUM_RESOURCES; ++i) {
+			struct resource *r = &pdev->resource[i];
+
+			if (!(r->flags & IORESOURCE_MEM))
+				continue;
+
+			val = reserve_iova(&reserved_iova_ranges,
+					   IOVA_PFN(r->start),
+					   IOVA_PFN(r->end));
+			if (!val) {
+				pr_err("Reserve pci-resource range failed\n");
+				return -ENOMEM;
+			}
+		}
+	}
+
+	return 0;
+}
+
 int __init amd_iommu_init_api(void)
 {
 	int ret, err = 0;
@@ -2968,6 +3033,10 @@ int __init amd_iommu_init_api(void)
 	if (ret)
 		return ret;
 
+	ret = init_reserved_iova_ranges();
+	if (ret)
+		return ret;
+
 	err = bus_set_iommu(&pci_bus_type, &amd_iommu_ops);
 	if (err)
 		return err;
-- 
1.9.1
