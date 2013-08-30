From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 1/2] iommu/arm-smmu: use relaxed accessors where possible
Date: Fri, 30 Aug 2013 18:59:21 +0100
Message-ID: <1377885562-12536-1-git-send-email-will.deacon@arm.com>
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
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Apart from fault handling and page table manipulation, we don't care
about memory ordering between SMMU control registers and normal,
cacheable memory, so use the _relaxed I/O accessors wherever possible.

Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 4b9158a..c3642cc 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -778,7 +778,7 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 #ifdef __BIG_ENDIAN
 	reg |= SCTLR_E;
 #endif
-	writel(reg, cb_base + ARM_SMMU_CB_SCTLR);
+	writel_relaxed(reg, cb_base + ARM_SMMU_CB_SCTLR);
 }
 
 static int arm_smmu_init_domain_context(struct iommu_domain *domain,
@@ -1595,7 +1595,7 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 
 	/* Push the button */
 	arm_smmu_tlb_sync(smmu);
-	writel(scr0, gr0_base + ARM_SMMU_GR0_sCR0);
+	writel_relaxed(scr0, gr0_base + ARM_SMMU_GR0_sCR0);
 }
 
 static int arm_smmu_id_size_to_bits(int size)
@@ -1928,7 +1928,7 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 		free_irq(smmu->irqs[i], smmu);
 
 	/* Turn the thing off */
-	writel(sCR0_CLIENTPD, ARM_SMMU_GR0(smmu) + ARM_SMMU_GR0_sCR0);
+	writel_relaxed(sCR0_CLIENTPD, ARM_SMMU_GR0(smmu) + ARM_SMMU_GR0_sCR0);
 	return 0;
 }
 
-- 
1.8.2.2
