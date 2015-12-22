From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 21/23] iommu/amd: Make dma_ops_domain->next_index percpu
Date: Tue, 22 Dec 2015 23:21:26 +0100
Message-ID: <1450822888-22590-22-git-send-email-joro@8bytes.org>
References: <1450822888-22590-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1450822888-22590-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Make this pointer percpu so that we start searching for new
addresses in the range we last stopped and which is has a
higher probability of being still in the cache.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index e98a466..84c7da1 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -35,6 +35,7 @@
 #include <linux/msi.h>
 #include <linux/dma-contiguous.h>
 #include <linux/irqdomain.h>
+#include <linux/percpu.h>
 #include <asm/irq_remapping.h>
 #include <asm/io_apic.h>
 #include <asm/apic.h>
@@ -147,7 +148,7 @@ struct dma_ops_domain {
 	unsigned long aperture_size;
 
 	/* aperture index we start searching for free addresses */
-	unsigned long next_index;
+	u32 __percpu *next_index;
 
 	/* address space relevant data */
 	struct aperture_range *aperture[APERTURE_MAX_RANGES];
@@ -1583,18 +1584,30 @@ static unsigned long dma_ops_area_alloc(struct device *dev,
 {
 	unsigned long boundary_size, mask;
 	unsigned long address = -1;
-	int start = dom->next_index;
-	int i;
+	u32 start, i;
+
+	preempt_disable();
 
 	mask = dma_get_seg_boundary(dev);
 
+	start = this_cpu_read(*dom->next_index);
+
+	/* Sanity check - is it really necessary? */
+	if (unlikely(start > APERTURE_MAX_RANGES)) {
+		start = 0;
+		this_cpu_write(*dom->next_index, 0);
+	}
+
 	boundary_size = mask + 1 ? ALIGN(mask + 1, PAGE_SIZE) >> PAGE_SHIFT :
 				   1UL << (BITS_PER_LONG - PAGE_SHIFT);
 
 	for (i = 0; i < APERTURE_MAX_RANGES; ++i) {
 		struct aperture_range *range;
+		int index;
+
+		index = (start + i) % APERTURE_MAX_RANGES;
 
-		range = dom->aperture[(start + i) % APERTURE_MAX_RANGES];
+		range = dom->aperture[index];
 
 		if (!range || range->offset >= dma_mask)
 			continue;
@@ -1604,11 +1617,13 @@ static unsigned long dma_ops_area_alloc(struct device *dev,
 						 align_mask);
 		if (address != -1) {
 			address = range->offset + (address << PAGE_SHIFT);
-			dom->next_index = i;
+			this_cpu_write(*dom->next_index, index);
 			break;
 		}
 	}
 
+	preempt_enable();
+
 	return address;
 }
 
@@ -1620,10 +1635,6 @@ static unsigned long dma_ops_alloc_addresses(struct device *dev,
 {
 	unsigned long address = -1;
 
-#ifdef CONFIG_IOMMU_STRESS
-	dom->next_index = 0;
-#endif
-
 	while (address == -1) {
 		address = dma_ops_area_alloc(dev, dom, pages,
 					     align_mask, dma_mask);
@@ -1851,6 +1862,8 @@ static void dma_ops_domain_free(struct dma_ops_domain *dom)
 	if (!dom)
 		return;
 
+	free_percpu(dom->next_index);
+
 	del_domain_from_list(&dom->domain);
 
 	free_pagetable(&dom->domain);
@@ -1873,6 +1886,7 @@ static void dma_ops_domain_free(struct dma_ops_domain *dom)
 static struct dma_ops_domain *dma_ops_domain_alloc(void)
 {
 	struct dma_ops_domain *dma_dom;
+	int cpu;
 
 	dma_dom = kzalloc(sizeof(struct dma_ops_domain), GFP_KERNEL);
 	if (!dma_dom)
@@ -1881,6 +1895,10 @@ static struct dma_ops_domain *dma_ops_domain_alloc(void)
 	if (protection_domain_init(&dma_dom->domain))
 		goto free_dma_dom;
 
+	dma_dom->next_index = alloc_percpu(u32);
+	if (!dma_dom->next_index)
+		goto free_dma_dom;
+
 	dma_dom->domain.mode = PAGE_MODE_2_LEVEL;
 	dma_dom->domain.pt_root = (void *)get_zeroed_page(GFP_KERNEL);
 	dma_dom->domain.flags = PD_DMA_OPS_MASK;
@@ -1898,8 +1916,9 @@ static struct dma_ops_domain *dma_ops_domain_alloc(void)
 	 * a valid dma-address. So we can use 0 as error value
 	 */
 	dma_dom->aperture[0]->bitmap[0] = 1;
-	dma_dom->next_index = 0;
 
+	for_each_possible_cpu(cpu)
+		*per_cpu_ptr(dma_dom->next_index, cpu) = 0;
 
 	return dma_dom;
 
-- 
1.9.1
