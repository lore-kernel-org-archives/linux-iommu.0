From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 1/4] iommu: arm smmu: remove broken big-endian check
Date: Wed, 31 Jul 2013 19:21:25 +0100
Message-ID: <1375294888-10826-2-git-send-email-will.deacon@arm.com>
References: <1375294888-10826-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1375294888-10826-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
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
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The bottom word of the pgd should always be written to the low half of
the TTBR, so we don't need to swap anything for big-endian.

Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index ebd0a4c..da8af45 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -687,15 +687,9 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 
 	/* TTBR0 */
 	reg = __pa(root_cfg->pgd);
-#ifndef __BIG_ENDIAN
 	writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_LO);
 	reg = (phys_addr_t)__pa(root_cfg->pgd) >> 32;
 	writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_HI);
-#else
-	writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_HI);
-	reg = (phys_addr_t)__pa(root_cfg->pgd) >> 32;
-	writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_LO);
-#endif
 
 	/*
 	 * TTBCR
-- 
1.8.2.2
