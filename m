From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: [RFC PATCH 28/30] iommu/arm-smmu-v3: Add support for Hardware
	Translation Table Update at stage 1
Date: Mon, 27 Feb 2017 19:54:39 +0000
Message-ID: <20170227195441.5170-29-jean-philippe.brucker@arm.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170227195441.5170-1-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Shanker Donthineni <shankerd-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Sinan Kaya <okaya-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Harv Abdulhamid <harba-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nate Watterson <nwatters-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

If the SMMU supports it and the kernel was built with HTTU support, enable
hardware update of access and dirty flags.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 1a5e72752e6d..5d202f164b95 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -68,6 +68,8 @@
 #define IDR0_ASID16			(1 << 12)
 #define IDR0_ATS			(1 << 10)
 #define IDR0_HYP			(1 << 9)
+#define IDR0_HD				(1 << 7)
+#define IDR0_HA				(1 << 6)
 #define IDR0_BTM			(1 << 5)
 #define IDR0_COHACC			(1 << 4)
 #define IDR0_TTF_SHIFT			2
@@ -346,7 +348,16 @@
 #define ARM64_TCR_TBI0_SHIFT		37
 #define ARM64_TCR_TBI0_MASK		0x1UL
 
+#define ARM64_TCR_HA_SHIFT		39
+#define ARM64_TCR_HA_MASK		0x1UL
+#define ARM64_TCR_HD_SHIFT		40
+#define ARM64_TCR_HD_MASK		0x1UL
+
 #define CTXDESC_CD_0_AA64		(1UL << 41)
+#define CTXDESC_CD_0_TCR_HD_SHIFT	42
+#define CTXDESC_CD_0_TCR_HA_SHIFT	43
+#define CTXDESC_CD_0_HD			(1UL << CTXDESC_CD_0_TCR_HD_SHIFT)
+#define CTXDESC_CD_0_HA			(1UL << CTXDESC_CD_0_TCR_HA_SHIFT)
 #define CTXDESC_CD_0_R			(1UL << 45)
 #define CTXDESC_CD_0_A			(1UL << 46)
 #define CTXDESC_CD_0_ASET_SHIFT		47
@@ -687,6 +698,8 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_E2H		(1 << 13)
 #define ARM_SMMU_FEAT_BTM		(1 << 14)
 #define ARM_SMMU_FEAT_SVM		(1 << 15)
+#define ARM_SMMU_FEAT_HA		(1 << 16)
+#define ARM_SMMU_FEAT_HD		(1 << 17)
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
@@ -1275,6 +1288,12 @@ static u64 arm_smmu_cpu_tcr_to_cd(struct arm_smmu_device *smmu, u64 tcr)
 	if (!(smmu->features & ARM_SMMU_FEAT_ATS))
 		val |= ARM_SMMU_TCR2CD(tcr, TBI0);
 
+	if (smmu->features & ARM_SMMU_FEAT_HA)
+		val |= ARM_SMMU_TCR2CD(tcr, HA);
+
+	if (smmu->features & ARM_SMMU_FEAT_HD)
+		val |= ARM_SMMU_TCR2CD(tcr, HD);
+
 	return val;
 }
 
@@ -2497,7 +2516,7 @@ static int arm_smmu_init_task_pgtable(struct arm_smmu_task *smmu_task)
 	tcr |= par << ARM_LPAE_TCR_IPS_SHIFT;
 
 	/* Enable this by default, it will be filtered when writing the CD */
-	tcr |= TCR_TBI0;
+	tcr |= TCR_TBI0 | TCR_HA | TCR_HD;
 
 	cfg->asid	= asid;
 	cfg->ttbr	= virt_to_phys(smmu_task->mm->pgd);
@@ -4734,6 +4753,12 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 			smmu->features |= ARM_SMMU_FEAT_E2H;
 	}
 
+	if (IS_ENABLED(CONFIG_ARM64_HW_AFDBM) && (reg & (IDR0_HA | IDR0_HD))) {
+		smmu->features |= ARM_SMMU_FEAT_HA;
+		if (reg & IDR0_HD)
+			smmu->features |= ARM_SMMU_FEAT_HD;
+	}
+
 	/*
 	 * If the CPU is using VHE, but the SMMU doesn't support it, the SMMU
 	 * will create TLB entries for NH-EL1 world and will miss the
-- 
2.11.0
