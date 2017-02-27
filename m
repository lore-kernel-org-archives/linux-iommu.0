From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: [RFC PATCH 14/30] iommu/arm-smmu-v3: Share process page tables
Date: Mon, 27 Feb 2017 19:54:25 +0000
Message-ID: <20170227195441.5170-15-jean-philippe.brucker@arm.com>
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

Copy the content of TCR, MAIR and TTBR of a given task into a context
descriptor.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index ab49164bf09b..c3fa4616bd58 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -44,6 +44,7 @@
 #include <linux/amba/bus.h>
 
 #include "io-pgtable.h"
+#include "io-pgtable-arm.h"
 
 /* MMIO registers */
 #define ARM_SMMU_IDR0			0x0
@@ -2191,6 +2192,9 @@ static int arm_smmu_init_task_pgtable(struct arm_smmu_task *smmu_task)
 {
 	int ret;
 	int asid;
+	unsigned long tcr;
+	unsigned long reg, par;
+	struct arm_smmu_s1_cfg *cfg = &smmu_task->s1_cfg;
 
 	/* Pin ASID on the CPU side */
 	asid = mm_context_get(smmu_task->mm);
@@ -2203,8 +2207,39 @@ static int arm_smmu_init_task_pgtable(struct arm_smmu_task *smmu_task)
 		return ret;
 	}
 
-	/* TODO: Initialize the rest of s1_cfg */
-	smmu_task->s1_cfg.asid = asid;
+	tcr = TCR_T0SZ(VA_BITS) | TCR_IRGN0_WBWA | TCR_ORGN0_WBWA |
+		TCR_SH0_INNER | ARM_LPAE_TCR_EPD1;
+
+	switch (PAGE_SIZE) {
+	case SZ_4K:
+		tcr |= TCR_TG0_4K;
+		break;
+	case SZ_16K:
+		tcr |= TCR_TG0_16K;
+		break;
+	case SZ_64K:
+		tcr |= TCR_TG0_64K;
+		break;
+	default:
+		WARN_ON(1);
+		return -EFAULT;
+	}
+
+	reg = read_system_reg(SYS_ID_AA64MMFR0_EL1);
+	par = cpuid_feature_extract_unsigned_field(reg, ID_AA64MMFR0_PARANGE_SHIFT);
+	tcr |= par << ARM_LPAE_TCR_IPS_SHIFT;
+
+	/* Enable this by default, it will be filtered when writing the CD */
+	tcr |= TCR_TBI0;
+
+	cfg->asid	= asid;
+	cfg->ttbr	= virt_to_phys(smmu_task->mm->pgd);
+	/*
+	 * MAIR value is pretty much constant and global, so we can just get it
+	 * from the current CPU register
+	 */
+	cfg->mair	= read_sysreg(mair_el1);
+	cfg->tcr	= tcr;
 
 	return 0;
 }
-- 
2.11.0
