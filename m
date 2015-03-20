From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 1/4] iommu/arm-smmu: ensure CBA2R is initialised before CBAR
	on SMMUv2
Date: Fri, 20 Mar 2015 18:15:34 +0000
Message-ID: <1426875337-12808-2-git-send-email-will.deacon@arm.com>
References: <1426875337-12808-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1426875337-12808-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
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

The VMID16 (8.1) extension to SMMUv2 added a 16-bit VMID16 field to the
CBA2R registers. Unfortunately, if software writes this field as zero
after setting an 8-bit VMID in a stage-2 CBAR, then the VMID may also be
overwritten with zero on some early implementations (the architecture
was later updated to fix this issue).

This patch ensures that we initialise CBA2R before CBAR, therefore
ensuring that the VMID is set correctly.

Tested-by: Manish Jaggi <mjaggi-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index fc13dd56953e..4abb831e24f0 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -730,6 +730,20 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
 	stage1 = cfg->cbar != CBAR_TYPE_S2_TRANS;
 	cb_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, cfg->cbndx);
 
+	if (smmu->version > ARM_SMMU_V1) {
+		/*
+		 * CBA2R.
+		 * *Must* be initialised before CBAR thanks to VMID16
+		 * architectural oversight affected some implementations.
+		 */
+#ifdef CONFIG_64BIT
+		reg = CBA2R_RW64_64BIT;
+#else
+		reg = CBA2R_RW64_32BIT;
+#endif
+		writel_relaxed(reg, gr1_base + ARM_SMMU_GR1_CBA2R(cfg->cbndx));
+	}
+
 	/* CBAR */
 	reg = cfg->cbar;
 	if (smmu->version == ARM_SMMU_V1)
@@ -747,16 +761,6 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
 	}
 	writel_relaxed(reg, gr1_base + ARM_SMMU_GR1_CBAR(cfg->cbndx));
 
-	if (smmu->version > ARM_SMMU_V1) {
-		/* CBA2R */
-#ifdef CONFIG_64BIT
-		reg = CBA2R_RW64_64BIT;
-#else
-		reg = CBA2R_RW64_32BIT;
-#endif
-		writel_relaxed(reg, gr1_base + ARM_SMMU_GR1_CBA2R(cfg->cbndx));
-	}
-
 	/* TTBRs */
 	if (stage1) {
 		reg = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
-- 
2.1.4
