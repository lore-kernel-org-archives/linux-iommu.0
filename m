From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 9/9] iommu/io-pgtable: Remove flush_pgtable callback
Date: Wed, 29 Jul 2015 19:46:12 +0100
Message-ID: <7c5584d3efa61ee6b0b87efb72f24f32852aafb7.1438195011.git.robin.murphy@arm.com>
References: <6999933bfa9b3d50853fd023d455c837a0d7ff23.1438195011.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <6999933bfa9b3d50853fd023d455c837a0d7ff23.1438195011.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

With the users fully converted to DMA API operations, it's dead, Jim.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/io-pgtable-arm.c | 6 ------
 drivers/iommu/io-pgtable.h     | 2 --
 2 files changed, 8 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 0617687..e4bc2b2 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -884,16 +884,10 @@ static void dummy_tlb_sync(void *cookie)
 	WARN_ON(cookie != cfg_cookie);
 }
 
-static void dummy_flush_pgtable(void *ptr, size_t size, void *cookie)
-{
-	WARN_ON(cookie != cfg_cookie);
-}
-
 static struct iommu_gather_ops dummy_tlb_ops __initdata = {
 	.tlb_flush_all	= dummy_tlb_flush_all,
 	.tlb_add_flush	= dummy_tlb_add_flush,
 	.tlb_sync	= dummy_tlb_sync,
-	.flush_pgtable	= dummy_flush_pgtable,
 };
 
 static void __init arm_lpae_dump_ops(struct io_pgtable_ops *ops)
diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
index 8f61286..68c63d9 100644
--- a/drivers/iommu/io-pgtable.h
+++ b/drivers/iommu/io-pgtable.h
@@ -19,7 +19,6 @@ enum io_pgtable_fmt {
  * @tlb_add_flush: Queue up a TLB invalidation for a virtual address range.
  * @tlb_sync:      Ensure any queued TLB invalidation has taken effect, and
  *                 any corresponding page table updates are visible.
- * @flush_pgtable: Ensure page table updates are visible to the IOMMU.
  *
  * Note that these can all be called in atomic context and must therefore
  * not block.
@@ -29,7 +28,6 @@ struct iommu_gather_ops {
 	void (*tlb_add_flush)(unsigned long iova, size_t size, bool leaf,
 			      void *cookie);
 	void (*tlb_sync)(void *cookie);
-	void (*flush_pgtable)(void *ptr, size_t size, void *cookie);
 };
 
 /**
-- 
1.9.1
