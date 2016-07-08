From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 03/20] iommu/amd: Allocate iova_domain for dma_ops_domain
Date: Fri,  8 Jul 2016 13:44:54 +0200
Message-ID: <1467978311-28322-4-git-send-email-joro@8bytes.org>
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

Use it later for allocating the IO virtual addresses.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 634f636..71af367 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -38,6 +38,7 @@
 #include <linux/dma-contiguous.h>
 #include <linux/irqdomain.h>
 #include <linux/percpu.h>
+#include <linux/iova.h>
 #include <asm/irq_remapping.h>
 #include <asm/io_apic.h>
 #include <asm/apic.h>
@@ -56,6 +57,11 @@
 
 #define LOOP_TIMEOUT	100000
 
+/* IO virtual address start page frame number */
+#define IOVA_START_PFN		(1)
+#define IOVA_PFN(addr)		((addr) >> PAGE_SHIFT)
+#define DMA_32BIT_PFN		IOVA_PFN(DMA_BIT_MASK(32))
+
 /*
  * This bitmap is used to advertise the page sizes our hardware support
  * to the IOMMU core, which will then use this information to split
@@ -157,6 +163,9 @@ struct dma_ops_domain {
 
 	/* address space relevant data */
 	struct aperture_range *aperture[APERTURE_MAX_RANGES];
+
+	/* IOVA RB-Tree */
+	struct iova_domain iovad;
 };
 
 /****************************************************************************
@@ -1966,6 +1975,8 @@ static void dma_ops_domain_free(struct dma_ops_domain *dom)
 	if (!dom)
 		return;
 
+	put_iova_domain(&dom->iovad);
+
 	free_percpu(dom->next_index);
 
 	del_domain_from_list(&dom->domain);
@@ -2041,6 +2052,9 @@ static struct dma_ops_domain *dma_ops_domain_alloc(void)
 	for_each_possible_cpu(cpu)
 		*per_cpu_ptr(dma_dom->next_index, cpu) = 0;
 
+	init_iova_domain(&dma_dom->iovad, PAGE_SIZE,
+			 IOVA_START_PFN, DMA_32BIT_PFN);
+
 	return dma_dom;
 
 free_dma_dom:
@@ -2948,7 +2962,11 @@ static struct dma_map_ops amd_iommu_dma_ops = {
 
 int __init amd_iommu_init_api(void)
 {
-	int err = 0;
+	int ret, err = 0;
+
+	ret = iova_cache_get();
+	if (ret)
+		return ret;
 
 	err = bus_set_iommu(&pci_bus_type, &amd_iommu_ops);
 	if (err)
-- 
1.9.1
