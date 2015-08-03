From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 11/13] iommu/arm-smmu: Remove arm_smmu_flush_pgtable()
Date: Mon,  3 Aug 2015 14:25:53 +0100
Message-ID: <1438608355-7335-12-git-send-email-will.deacon@arm.com>
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

With the io-pgtable code now enforcing its own appropriate sync points,
the vestigial flush_pgtable callback becomes entirely redundant, so
remove it altogether.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 38a891e28e13..15fb669282b4 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1331,20 +1331,10 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 	arm_smmu_cmdq_issue_cmd(smmu, &cmd);
 }
 
-static void arm_smmu_flush_pgtable(void *addr, size_t size, void *cookie)
-{
-	struct arm_smmu_domain *smmu_domain = cookie;
-
-	/* The page table code handles flushing in the non-coherent case */
-	if (smmu_domain->smmu->features & ARM_SMMU_FEAT_COHERENCY)
-		dsb(ishst);
-}
-
 static struct iommu_gather_ops arm_smmu_gather_ops = {
 	.tlb_flush_all	= arm_smmu_tlb_inv_context,
 	.tlb_add_flush	= arm_smmu_tlb_inv_range_nosync,
 	.tlb_sync	= arm_smmu_tlb_sync,
-	.flush_pgtable	= arm_smmu_flush_pgtable,
 };
 
 /* IOMMU API */
-- 
2.1.4
