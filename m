From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 06/13] iommu/arm-smmu: Clean up DMA API usage
Date: Mon,  3 Aug 2015 14:25:48 +0100
Message-ID: <1438608355-7335-7-git-send-email-will.deacon@arm.com>
References: <1438608355-7335-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1438608355-7335-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
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
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>

With the correct DMA API calls now integrated into the io-pgtable code,
let that handle the flushing of non-coherent page table updates.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 0583ed2f33c0..5770ab98fa38 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -611,24 +611,13 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 static void arm_smmu_flush_pgtable(void *addr, size_t size, void *cookie)
 {
 	struct arm_smmu_domain *smmu_domain = cookie;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	unsigned long offset = (unsigned long)addr & ~PAGE_MASK;
-
 
-	/* Ensure new page tables are visible to the hardware walker */
-	if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK) {
+	/*
+	 * Ensure new page tables are visible to a coherent hardware walker.
+	 * The page table code deals with flushing for the non-coherent case.
+	 */
+	if (smmu_domain->smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
 		dsb(ishst);
-	} else {
-		/*
-		 * If the SMMU can't walk tables in the CPU caches, treat them
-		 * like non-coherent DMA since we need to flush the new entries
-		 * all the way out to memory. There's no possibility of
-		 * recursion here as the SMMU table walker will not be wired
-		 * through another SMMU.
-		 */
-		dma_map_page(smmu->dev, virt_to_page(addr), offset, size,
-			     DMA_TO_DEVICE);
-	}
 }
 
 static struct iommu_gather_ops arm_smmu_gather_ops = {
@@ -899,6 +888,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 		.ias		= ias,
 		.oas		= oas,
 		.tlb		= &arm_smmu_gather_ops,
+		.iommu_dev	= smmu->dev,
 	};
 
 	smmu_domain->smmu = smmu;
-- 
2.1.4
