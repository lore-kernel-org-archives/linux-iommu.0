From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 1/4] iommu/iova: Avoid over-allocating when size-aligned
Date: Thu, 11 Jun 2015 16:54:21 +0100
Message-ID: <0c0dd852b83cb7ae8104884b117f9c17cf6d440e.1434036796.git.robin.murphy@arm.com>
References: <cover.1434036796.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1434036796.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Currently, allocating a size-aligned IOVA region quietly adjusts the
actual allocation size in the process, returning a rounded-up
power-of-two-sized allocation. This results in mismatched behaviour in
the IOMMU driver if the original size was not a power of two, where the
original size is mapped, but the rounded-up IOVA size is unmapped.

Whilst some IOMMUs will happily unmap already-unmapped pages, others
consider this an error, so fix it by computing the necessary alignment
padding without altering the actual allocation size. Also clean up by
making pad_size unsigned, since negative padding makes no sense.

CC: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/intel-iommu.c |  2 ++
 drivers/iommu/iova.c        | 23 ++++++-----------------
 2 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 68d43be..ada1fb9 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2910,6 +2910,8 @@ static struct iova *intel_alloc_iova(struct device *dev,
 
 	/* Restrict dma_mask to the width that the iommu can handle */
 	dma_mask = min_t(uint64_t, DOMAIN_MAX_ADDR(domain->gaw), dma_mask);
+	/* Ensure we reserve the whole size-aligned region */
+	nrpages = __roundup_pow_of_two(nrpages);
 
 	if (!dmar_forcedac && dma_mask > DMA_BIT_MASK(32)) {
 		/*
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 9dd8208..2c4a51b 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -120,19 +120,14 @@ __cached_rbnode_delete_update(struct iova_domain *iovad, struct iova *free)
 	}
 }
 
-/* Computes the padding size required, to make the
- * the start address naturally aligned on its size
+/*
+ * Computes the padding size required, to make the start address
+ * naturally aligned on the power-of-two order of its size
  */
-static int
-iova_get_pad_size(int size, unsigned int limit_pfn)
+static unsigned int
+iova_get_pad_size(unsigned int size, unsigned int limit_pfn)
 {
-	unsigned int pad_size = 0;
-	unsigned int order = ilog2(size);
-
-	if (order)
-		pad_size = (limit_pfn + 1) % (1 << order);
-
-	return pad_size;
+	return (limit_pfn + 1 - size) & (__roundup_pow_of_two(size) - 1);
 }
 
 static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
@@ -264,12 +259,6 @@ alloc_iova(struct iova_domain *iovad, unsigned long size,
 	if (!new_iova)
 		return NULL;
 
-	/* If size aligned is set then round the size to
-	 * to next power of two.
-	 */
-	if (size_aligned)
-		size = __roundup_pow_of_two(size);
-
 	ret = __alloc_and_insert_iova_range(iovad, size, limit_pfn,
 			new_iova, size_aligned);
 
-- 
1.9.1
