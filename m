From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 5/7] iommu/arm-smmu: Tidy up 64-bit/atomic I/O accesses
Date: Wed, 13 Apr 2016 18:13:01 +0100
Message-ID: <b6e08204cb539be8dacab0a7fdb36f3d2b2a2bd8.1460391217.git.robin.murphy@arm.com>
References: <cover.1460391217.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1460391217.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, brian.starkey-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

With {read,write}q_relaxed now able to fall back to the common
nonatomic-hi-lo helper, make use of that so that we don't have to
open-code our own. In the process, also convert the other remaining
split accesses, and repurpose the custom accessor to smooth out the
couple of troublesome instances where we really want to avoid
nonatomic writes (and a 64-bit access is unnecessary in the 32-bit
context formats we would use on a 32-bit CPU).

This paves the way for getting rid of some of the assumptions currently
baked into the driver which make it really awkward to use 32-bit context
formats with SMMUv2 under a 64-bit kernel.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 48 +++++++++++++++++++-----------------------------
 1 file changed, 19 insertions(+), 29 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 085fc8d..acff332 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -34,6 +34,7 @@
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/io-64-nonatomic-hi-lo.h>
 #include <linux/iommu.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
@@ -71,16 +72,15 @@
 		((smmu->options & ARM_SMMU_OPT_SECURE_CFG_ACCESS)	\
 			? 0x400 : 0))
 
+/*
+ * Some 64-bit registers only make sense to write atomically, but in such
+ * cases all the data relevant to AArch32 formats lies within the lower word,
+ * therefore this actually makes more sense than it might first appear.
+ */
 #ifdef CONFIG_64BIT
-#define smmu_writeq	writeq_relaxed
+#define smmu_write_atomic_lq		writeq_relaxed
 #else
-#define smmu_writeq(reg64, addr)				\
-	do {							\
-		u64 __val = (reg64);				\
-		void __iomem *__addr = (addr);			\
-		writel_relaxed(__val >> 32, __addr + 4);	\
-		writel_relaxed(__val, __addr);			\
-	} while (0)
+#define smmu_write_atomic_lq		writel_relaxed
 #endif
 
 /* Configuration registers */
@@ -211,11 +211,9 @@
 #define ARM_SMMU_CB_TTBCR		0x30
 #define ARM_SMMU_CB_S1_MAIR0		0x38
 #define ARM_SMMU_CB_S1_MAIR1		0x3c
-#define ARM_SMMU_CB_PAR_LO		0x50
-#define ARM_SMMU_CB_PAR_HI		0x54
+#define ARM_SMMU_CB_PAR			0x50
 #define ARM_SMMU_CB_FSR			0x58
-#define ARM_SMMU_CB_FAR_LO		0x60
-#define ARM_SMMU_CB_FAR_HI		0x64
+#define ARM_SMMU_CB_FAR			0x60
 #define ARM_SMMU_CB_FSYNR0		0x68
 #define ARM_SMMU_CB_S1_TLBIVA		0x600
 #define ARM_SMMU_CB_S1_TLBIASID		0x610
@@ -645,7 +643,7 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 			      ARM_SMMU_CB_S2_TLBIIPAS2;
 		iova >>= 12;
 		do {
-			writeq_relaxed(iova, reg);
+			smmu_write_atomic_lq(iova, reg);
 			iova += granule >> 12;
 		} while (size -= granule);
 #endif
@@ -664,7 +662,7 @@ static struct iommu_gather_ops arm_smmu_gather_ops = {
 static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 {
 	int flags, ret;
-	u32 fsr, far, fsynr, resume;
+	u32 fsr, fsynr, resume;
 	unsigned long iova;
 	struct iommu_domain *domain = dev;
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
@@ -686,13 +684,7 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 	fsynr = readl_relaxed(cb_base + ARM_SMMU_CB_FSYNR0);
 	flags = fsynr & FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ;
 
-	far = readl_relaxed(cb_base + ARM_SMMU_CB_FAR_LO);
-	iova = far;
-#ifdef CONFIG_64BIT
-	far = readl_relaxed(cb_base + ARM_SMMU_CB_FAR_HI);
-	iova |= ((unsigned long)far << 32);
-#endif
-
+	iova = readq_relaxed(cb_base + ARM_SMMU_CB_FAR);
 	if (!report_iommu_fault(domain, smmu->dev, iova, flags)) {
 		ret = IRQ_HANDLED;
 		resume = RESUME_RETRY;
@@ -788,14 +780,14 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
 		reg64 = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
 
 		reg64 |= ((u64)ARM_SMMU_CB_ASID(smmu, cfg)) << TTBRn_ASID_SHIFT;
-		smmu_writeq(reg64, cb_base + ARM_SMMU_CB_TTBR0);
+		writeq_relaxed(reg64, cb_base + ARM_SMMU_CB_TTBR0);
 
 		reg64 = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[1];
 		reg64 |= ((u64)ARM_SMMU_CB_ASID(smmu, cfg)) << TTBRn_ASID_SHIFT;
-		smmu_writeq(reg64, cb_base + ARM_SMMU_CB_TTBR1);
+		writeq_relaxed(reg64, cb_base + ARM_SMMU_CB_TTBR1);
 	} else {
 		reg64 = pgtbl_cfg->arm_lpae_s2_cfg.vttbr;
-		smmu_writeq(reg64, cb_base + ARM_SMMU_CB_TTBR0);
+		writeq_relaxed(reg64, cb_base + ARM_SMMU_CB_TTBR0);
 	}
 
 	/* TTBCR */
@@ -1263,8 +1255,8 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
 	/* ATS1 registers can only be written atomically */
 	va = iova & ~0xfffUL;
 	if (smmu->version == ARM_SMMU_V2)
-		smmu_writeq(va, cb_base + ARM_SMMU_CB_ATS1PR);
-	else
+		smmu_write_atomic_lq(va, cb_base + ARM_SMMU_CB_ATS1PR);
+	else /* Register is only 32-bit in v1 */
 		writel_relaxed(va, cb_base + ARM_SMMU_CB_ATS1PR);
 
 	if (readl_poll_timeout_atomic(cb_base + ARM_SMMU_CB_ATSR, tmp,
@@ -1275,9 +1267,7 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
 		return ops->iova_to_phys(ops, iova);
 	}
 
-	phys = readl_relaxed(cb_base + ARM_SMMU_CB_PAR_LO);
-	phys |= ((u64)readl_relaxed(cb_base + ARM_SMMU_CB_PAR_HI)) << 32;
-
+	phys = readq_relaxed(cb_base + ARM_SMMU_CB_PAR);
 	if (phys & CB_PAR_F) {
 		dev_err(dev, "translation fault!\n");
 		dev_err(dev, "PAR = 0x%llx\n", phys);
-- 
2.7.3.dirty
