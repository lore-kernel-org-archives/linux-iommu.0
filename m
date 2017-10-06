From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: [RFCv2 PATCH 23/36] iommu/arm-smmu-v3: Share process page tables
Date: Fri,  6 Oct 2017 14:31:50 +0100
Message-ID: <20171006133203.22803-24-jean-philippe.brucker@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20171006133203.22803-1-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Copy the content of TCR, MAIR and TTBR of a given task into a context
descriptor.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index c86a1182c137..293f260782c2 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -43,6 +43,7 @@
 #include <linux/amba/bus.h>
 
 #include "io-pgtable.h"
+#include "io-pgtable-arm.h"
 
 /* MMIO registers */
 #define ARM_SMMU_IDR0			0x0
@@ -2170,13 +2171,46 @@ static int arm_smmu_process_init_pgtable(struct arm_smmu_process *smmu_process,
 					 struct mm_struct *mm)
 {
 	int asid;
+	unsigned long tcr;
+	unsigned long reg, par;
+	struct arm_smmu_ctx_desc *cfg = &smmu_process->ctx_desc;
 
 	asid = mm_context_get(mm);
 	if (!asid)
 		return -ENOSPC;
 
-	smmu_process->ctx_desc.asid = asid;
-	/* TODO: init the rest */
+	tcr = TCR_T0SZ(VA_BITS) | TCR_IRGN0_WBWA | TCR_ORGN0_WBWA |
+		TCR_SH0_INNER | ARM_LPAE_TCR_EPD1;
+
+	switch (PAGE_SIZE) {
+		case SZ_4K:
+			tcr |= TCR_TG0_4K;
+			break;
+		case SZ_16K:
+			tcr |= TCR_TG0_16K;
+			break;
+		case SZ_64K:
+			tcr |= TCR_TG0_64K;
+			break;
+		default:
+			WARN_ON(1);
+			return -EFAULT;
+	}
+
+	reg = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
+	par = cpuid_feature_extract_unsigned_field(reg, ID_AA64MMFR0_PARANGE_SHIFT);
+	tcr |= par << ARM_LPAE_TCR_IPS_SHIFT;
+
+	tcr |= TCR_TBI0;
+
+	cfg->asid       = asid;
+	cfg->ttbr       = virt_to_phys(mm->pgd);
+	/*
+	 * MAIR value is pretty much constant and global, so we can just get it
+	 * from the current CPU register
+	 */
+	cfg->mair       = read_sysreg(mair_el1);
+	cfg->tcr        = tcr;
 
 	return 0;
 }
-- 
2.13.3
