From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 3/6] iommu/arm-smmu: ThunderX mis-extends 64bit registers
Date: Thu, 15 Oct 2015 16:04:21 +0100
Message-ID: <1444921464-14895-4-git-send-email-will.deacon@arm.com>
References: <1444921464-14895-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1444921464-14895-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
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
Cc: fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Tirumalesh Chalamarla <tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>

The SMMU architecture defines two different behaviors when 64-bit
registers are written with 32-bit writes.  The first behavior causes
zero extension into the upper 32-bits.  The second behavior splits a
64-bit register into "normal" 32-bit register pairs.

On some buggy implementations, registers incorrectly zero extended
when they should instead behave as normal 32-bit register pairs.

Signed-off-by: Tirumalesh Chalamarla <tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
[will: removed redundant macro parameters]
Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 50 ++++++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 677fba9e6b11..9aadf36a0747 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -70,6 +70,18 @@
 		((smmu->options & ARM_SMMU_OPT_SECURE_CFG_ACCESS)	\
 			? 0x400 : 0))
 
+#ifdef CONFIG_64BIT
+#define smmu_writeq	writeq_relaxed
+#else
+#define smmu_writeq(reg64, addr)				\
+	do {							\
+		u64 __val = (reg64);				\
+		void __iomem *__addr = (addr);			\
+		writel_relaxed(__val >> 32, __addr + 4);	\
+		writel_relaxed(__val, __addr);			\
+	} while (0)
+#endif
+
 /* Configuration registers */
 #define ARM_SMMU_GR0_sCR0		0x0
 #define sCR0_CLIENTPD			(1 << 0)
@@ -185,10 +197,8 @@
 #define ARM_SMMU_CB_SCTLR		0x0
 #define ARM_SMMU_CB_RESUME		0x8
 #define ARM_SMMU_CB_TTBCR2		0x10
-#define ARM_SMMU_CB_TTBR0_LO		0x20
-#define ARM_SMMU_CB_TTBR0_HI		0x24
-#define ARM_SMMU_CB_TTBR1_LO		0x28
-#define ARM_SMMU_CB_TTBR1_HI		0x2c
+#define ARM_SMMU_CB_TTBR0		0x20
+#define ARM_SMMU_CB_TTBR1		0x28
 #define ARM_SMMU_CB_TTBCR		0x30
 #define ARM_SMMU_CB_S1_MAIR0		0x38
 #define ARM_SMMU_CB_S1_MAIR1		0x3c
@@ -226,7 +236,7 @@
 #define TTBCR2_SEP_SHIFT		15
 #define TTBCR2_SEP_UPSTREAM		(0x7 << TTBCR2_SEP_SHIFT)
 
-#define TTBRn_HI_ASID_SHIFT            16
+#define TTBRn_ASID_SHIFT		48
 
 #define FSR_MULTI			(1 << 31)
 #define FSR_SS				(1 << 30)
@@ -695,6 +705,7 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	u32 reg;
+	u64 reg64;
 	bool stage1;
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
@@ -738,22 +749,17 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
 
 	/* TTBRs */
 	if (stage1) {
-		reg = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
-		writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_LO);
-		reg = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0] >> 32;
-		reg |= ARM_SMMU_CB_ASID(cfg) << TTBRn_HI_ASID_SHIFT;
-		writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_HI);
-
-		reg = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[1];
-		writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR1_LO);
-		reg = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[1] >> 32;
-		reg |= ARM_SMMU_CB_ASID(cfg) << TTBRn_HI_ASID_SHIFT;
-		writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR1_HI);
+		reg64 = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
+
+		reg64 |= ((u64)ARM_SMMU_CB_ASID(cfg)) << TTBRn_ASID_SHIFT;
+		smmu_writeq(reg64, cb_base + ARM_SMMU_CB_TTBR0);
+
+		reg64 = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[1];
+		reg64 |= ((u64)ARM_SMMU_CB_ASID(cfg)) << TTBRn_ASID_SHIFT;
+		smmu_writeq(reg64, cb_base + ARM_SMMU_CB_TTBR1);
 	} else {
-		reg = pgtbl_cfg->arm_lpae_s2_cfg.vttbr;
-		writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_LO);
-		reg = pgtbl_cfg->arm_lpae_s2_cfg.vttbr >> 32;
-		writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_HI);
+		reg64 = pgtbl_cfg->arm_lpae_s2_cfg.vttbr;
+		smmu_writeq(reg64, cb_base + ARM_SMMU_CB_TTBR0);
 	}
 
 	/* TTBCR */
@@ -1212,11 +1218,9 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
 
 	/* ATS1 registers can only be written atomically */
 	va = iova & ~0xfffUL;
-#ifdef CONFIG_64BIT
 	if (smmu->version == ARM_SMMU_V2)
-		writeq_relaxed(va, cb_base + ARM_SMMU_CB_ATS1PR);
+		smmu_writeq(va, cb_base + ARM_SMMU_CB_ATS1PR);
 	else
-#endif
 		writel_relaxed(va, cb_base + ARM_SMMU_CB_ATS1PR);
 
 	if (readl_poll_timeout_atomic(cb_base + ARM_SMMU_CB_ATSR, tmp,
-- 
2.1.4
