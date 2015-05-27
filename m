From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 1/2] iommu/arm-smmu: Fix ATS1* register writes
Date: Wed, 27 May 2015 17:09:34 +0100
Message-ID: <1432742975-24801-1-git-send-email-will.deacon@arm.com>
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
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>

The ATS1* address translation registers only support being written
atomically - in SMMUv2 where they are 64 bits wide, 32-bit writes to
the lower half are automatically zero-extended, whilst 32-bit writes
to the upper half are ignored. Thus, the current logic of performing
64-bit writes as two 32-bit accesses is wrong.

Since we already limit IOVAs to 32 bits on 32-bit ARM, the lack of a
suitable writeq() implementation there is not an issue, and we only
need a little preprocessor ugliness to safely hide the 64-bit case.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 66a803b9dd3a..e2a788eea5ed 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -202,8 +202,7 @@
 #define ARM_SMMU_CB_S1_TLBIVAL		0x620
 #define ARM_SMMU_CB_S2_TLBIIPAS2	0x630
 #define ARM_SMMU_CB_S2_TLBIIPAS2L	0x638
-#define ARM_SMMU_CB_ATS1PR_LO		0x800
-#define ARM_SMMU_CB_ATS1PR_HI		0x804
+#define ARM_SMMU_CB_ATS1PR		0x800
 #define ARM_SMMU_CB_ATSR		0x8f0
 
 #define SCTLR_S1_ASIDPNE		(1 << 12)
@@ -1229,18 +1228,18 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
 	void __iomem *cb_base;
 	u32 tmp;
 	u64 phys;
+	unsigned long va;
 
 	cb_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, cfg->cbndx);
 
-	if (smmu->version == 1) {
-		u32 reg = iova & ~0xfff;
-		writel_relaxed(reg, cb_base + ARM_SMMU_CB_ATS1PR_LO);
-	} else {
-		u32 reg = iova & ~0xfff;
-		writel_relaxed(reg, cb_base + ARM_SMMU_CB_ATS1PR_LO);
-		reg = ((u64)iova & ~0xfff) >> 32;
-		writel_relaxed(reg, cb_base + ARM_SMMU_CB_ATS1PR_HI);
-	}
+	/* ATS1 registers can only be written atomically */
+	va = iova & ~0xfffUL;
+#ifdef CONFIG_64BIT
+	if (smmu->version == ARM_SMMU_V2)
+		writeq_relaxed(va, cb_base + ARM_SMMU_CB_ATS1PR);
+	else
+#endif
+		writel_relaxed(va, cb_base + ARM_SMMU_CB_ATS1PR);
 
 	if (readl_poll_timeout_atomic(cb_base + ARM_SMMU_CB_ATSR, tmp,
 				      !(tmp & ATSR_ACTIVE), 5, 50)) {
-- 
2.1.4
