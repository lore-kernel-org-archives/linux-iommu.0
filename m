From: Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>
Subject: [PATCH V2] iommu/arm-smmu-v2: ThunderX mis-extends 64bit registers
Date: Wed, 5 Aug 2015 09:54:28 -0700
Message-ID: <1438793668-15597-1-git-send-email-tchalamarla@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: will.deacon@arm.com
Cc: linux@arm.linux.org.uk, ddaney@caviumnetworks.com, iommu@lists.linux-foundation.org, robert.richter@caviumnetworks.com, Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

The SMMU architecture defines two different behaviors when 64-bit
registers are written with 32-bit writes.  The first behavior causes
zero extension into the upper 32-bits.  The second behavior splits a
64-bit register into "normal" 32-bit register pairs.

On some buggy implementations, registers incorrectly zero extended
when they should instead behave as normal 32-bit register pairs.

Signed-off-by: Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>
---

Changes from V1:
	- Introduced smmu_writeq

 drivers/iommu/arm-smmu.c | 45 +++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 66a803b..0912c78 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -69,6 +69,18 @@
 		((smmu->options & ARM_SMMU_OPT_SECURE_CFG_ACCESS)	\
 			? 0x400 : 0))
 
+#ifdef CONFIG_64BIT
+#define smmu_writeq(reg64, addr)	writeq_relaxed((reg64), (addr))
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
@@ -226,7 +238,7 @@
 #define TTBCR2_SEP_SHIFT		15
 #define TTBCR2_SEP_UPSTREAM		(0x7 << TTBCR2_SEP_SHIFT)
 
-#define TTBRn_HI_ASID_SHIFT            16
+#define TTBRn_ASID_SHIFT		48
 
 #define FSR_MULTI			(1 << 31)
 #define FSR_SS				(1 << 30)
@@ -762,22 +774,17 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
 
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
+		u64 reg64 = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
+
+		reg64 |= ((u64)ARM_SMMU_CB_ASID(cfg)) << TTBRn_ASID_SHIFT;
+		smmu_writeq(reg64, cb_base + ARM_SMMU_CB_TTBR0_LO);
+
+		reg64 = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[1];
+		reg64 |= ((u64)ARM_SMMU_CB_ASID(cfg)) << TTBRn_ASID_SHIFT;
+		smmu_writeq(reg64, cb_base + ARM_SMMU_CB_TTBR1_LO);
 	} else {
-		reg = pgtbl_cfg->arm_lpae_s2_cfg.vttbr;
-		writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_LO);
-		reg = pgtbl_cfg->arm_lpae_s2_cfg.vttbr >> 32;
-		writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_HI);
+		u64 reg64 = pgtbl_cfg->arm_lpae_s2_cfg.vttbr;
+		smmu_writeq(reg64, cb_base + ARM_SMMU_CB_TTBR0_LO);
 	}
 
 	/* TTBCR */
@@ -1236,10 +1243,8 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
 		u32 reg = iova & ~0xfff;
 		writel_relaxed(reg, cb_base + ARM_SMMU_CB_ATS1PR_LO);
 	} else {
-		u32 reg = iova & ~0xfff;
-		writel_relaxed(reg, cb_base + ARM_SMMU_CB_ATS1PR_LO);
-		reg = ((u64)iova & ~0xfff) >> 32;
-		writel_relaxed(reg, cb_base + ARM_SMMU_CB_ATS1PR_HI);
+		u64 reg64 = iova & ~0xfff;
+		smmu_writeq(reg64, cb_base + ARM_SMMU_CB_ATS1PR_LO);
 	}
 
 	if (readl_poll_timeout_atomic(cb_base + ARM_SMMU_CB_ATSR, tmp,
-- 
2.1.0
