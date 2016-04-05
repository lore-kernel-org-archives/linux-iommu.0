From: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH 2/2] iommu/arm-smmu: Implement .get_pgsize_bitmap for domain
Date: Tue,  5 Apr 2016 14:01:30 -0700
Message-ID: <1459890090-16040-2-git-send-email-mitchelh@codeaurora.org>
References: <1459890090-16040-1-git-send-email-mitchelh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1459890090-16040-1-git-send-email-mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Pratik Patel <pratikp-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Currently we restrict the pgsize_bitmap for the entire SMMU every time
we allocate some new page tables.  However, certain io-pgtable
implementations might wish to restrict the formats beyond the
restrictions of the SMMU itself, which forces all domains on that SMMU
to the same pgsize_bitmap, even if the other domains would prefer to use
a more permissive page table format.  Besides that, some SMMUs in the
system might have different supported page sizes at the hardware level,
so applying those to everyone else is wrong.

Fix these issues by implementing the new .get_pgsize_bitmap IOMMU op.

Signed-off-by: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 2409e3bd3df2..a1b0f542d5ca 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -908,9 +908,6 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 		goto out_clear_smmu;
 	}
 
-	/* Update our support page sizes to reflect the page table format */
-	arm_smmu_ops.pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
-
 	/* Initialise the context bank with our page table cfg */
 	arm_smmu_init_context_bank(smmu_domain, &pgtbl_cfg);
 
@@ -1462,6 +1459,23 @@ out_unlock:
 	return ret;
 }
 
+static unsigned long arm_smmu_get_pgsize_bitmap(struct iommu_domain *domain)
+{
+	struct arm_smmu_domain *smmu_domain = domain->priv;
+
+	/*
+	 * if someone is calling map before attach just return the
+	 * supported page sizes for the hardware itself.
+	 */
+	if (!smmu_domain->pgtbl_cfg.pgsize_bitmap)
+		return arm_smmu_ops.pgsize_bitmap;
+	/*
+	 * otherwise return the page sizes supported by this specific page
+	 * table configuration
+	 */
+	return smmu_domain->pgtbl_cfg.pgsize_bitmap;
+}
+
 static struct iommu_ops arm_smmu_ops = {
 	.capable		= arm_smmu_capable,
 	.domain_alloc		= arm_smmu_domain_alloc,
@@ -1477,6 +1491,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.domain_get_attr	= arm_smmu_domain_get_attr,
 	.domain_set_attr	= arm_smmu_domain_set_attr,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
+	.get_pgsize_bitmap	= arm_smmu_get_pgsize_bitmap,
 };
 
 static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
