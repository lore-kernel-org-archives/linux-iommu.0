From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH 1/2] iommu/io-pgtable-arm: Add support for non-coherent page
	tables
Date: Thu, 17 Jan 2019 14:57:17 +0530
Message-ID: <20190117092718.1396-2-vivek.gautam@codeaurora.org>
References: <20190117092718.1396-1-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190117092718.1396-1-vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

>From Robin's comment [1] about touching TCR configurations -

"TBH if we're going to touch the TCR attributes at all then we should
probably correct that sloppiness first - there's an occasional argument
for using non-cacheable pagetables even on a coherent SMMU if reducing
snoop traffic/latency on walks outweighs the cost of cache maintenance
on PTE updates, but anyone thinking they can get that by overriding
dma-coherent silently gets the worst of both worlds thanks to this
current TCR value."

We have IO_PGTABLE_QUIRK_NO_DMA quirk present, but we don't force
anybody _not_ using dma-coherent smmu to have non-cacheable page table
mappings.
Having another quirk flag can help in having non-cacheable memory for
page tables once and for all.

[1] https://lore.kernel.org/patchwork/patch/1020906/

Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/iommu/io-pgtable-arm.c | 17 ++++++++++++-----
 drivers/iommu/io-pgtable.h     |  6 ++++++
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 237cacd4a62b..c76919c30f1a 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -780,7 +780,8 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
 	struct arm_lpae_io_pgtable *data;
 
 	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS | IO_PGTABLE_QUIRK_NO_DMA |
-			    IO_PGTABLE_QUIRK_NON_STRICT))
+			    IO_PGTABLE_QUIRK_NON_STRICT |
+			    IO_PGTABLE_QUIRK_NON_COHERENT))
 		return NULL;
 
 	data = arm_lpae_alloc_pgtable(cfg);
@@ -788,9 +789,14 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
 		return NULL;
 
 	/* TCR */
-	reg = (ARM_LPAE_TCR_SH_IS << ARM_LPAE_TCR_SH0_SHIFT) |
-	      (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_IRGN0_SHIFT) |
-	      (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_ORGN0_SHIFT);
+	reg = ARM_LPAE_TCR_SH_IS << ARM_LPAE_TCR_SH0_SHIFT;
+
+	if (cfg->quirks & IO_PGTABLE_QUIRK_NON_COHERENT)
+		reg |= ARM_LPAE_TCR_RGN_NC << ARM_LPAE_TCR_IRGN0_SHIFT |
+		       ARM_LPAE_TCR_RGN_NC << ARM_LPAE_TCR_ORGN0_SHIFT;
+	else
+		reg |= ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_IRGN0_SHIFT |
+		       ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_ORGN0_SHIFT;
 
 	switch (ARM_LPAE_GRANULE(data)) {
 	case SZ_4K:
@@ -873,7 +879,8 @@ arm_64_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg, void *cookie)
 
 	/* The NS quirk doesn't apply at stage 2 */
 	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_NO_DMA |
-			    IO_PGTABLE_QUIRK_NON_STRICT))
+			    IO_PGTABLE_QUIRK_NON_STRICT |
+			    IO_PGTABLE_QUIRK_NON_COHERENT))
 		return NULL;
 
 	data = arm_lpae_alloc_pgtable(cfg);
diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
index 47d5ae559329..46604cf7b017 100644
--- a/drivers/iommu/io-pgtable.h
+++ b/drivers/iommu/io-pgtable.h
@@ -75,6 +75,11 @@ struct io_pgtable_cfg {
 	 * IO_PGTABLE_QUIRK_NON_STRICT: Skip issuing synchronous leaf TLBIs
 	 *	on unmap, for DMA domains using the flush queue mechanism for
 	 *	delayed invalidation.
+	 *
+	 * IO_PGTABLE_QUIRK_NON_COHERENT: Enforce non-cacheable mappings for
+	 *      pagetables even on a coherent SMMU for cases where reducing
+	 *      snoop traffic/latency on walks outweighs the cost of cache
+	 *      maintenance on PTE updates.
 	 */
 	#define IO_PGTABLE_QUIRK_ARM_NS		BIT(0)
 	#define IO_PGTABLE_QUIRK_NO_PERMS	BIT(1)
@@ -82,6 +87,7 @@ struct io_pgtable_cfg {
 	#define IO_PGTABLE_QUIRK_ARM_MTK_4GB	BIT(3)
 	#define IO_PGTABLE_QUIRK_NO_DMA		BIT(4)
 	#define IO_PGTABLE_QUIRK_NON_STRICT	BIT(5)
+	#define IO_PGTABLE_QUIRK_NON_COHERENT	BIT(6)
 	unsigned long			quirks;
 	unsigned long			pgsize_bitmap;
 	unsigned int			ias;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
