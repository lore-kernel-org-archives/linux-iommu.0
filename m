From: <tchalamarla@caviumnetworks.com>
Subject: [PATCH] iommu/arm-smmu-v2: ThunderX(errata-23399) mis-extends 64bit
 registers
Date: Thu, 30 Jul 2015 10:55:06 -0700
Message-ID: <1438278906-29627-1-git-send-email-tchalamarla@caviumnetworks.com>
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
Cc: iommu@lists.linux-foundation.org, robert.richter@caviumnetworks.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>
List-Id: iommu@lists.linux-foundation.org

From: Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>

The SMMU architecture defines two different behaviors when 64-bit
registers are written with 32-bit writes.  The first behavior causes
zero extension into the upper 32-bits.  The second behavior splits a
64-bit register into "normal" 32-bit register pairs.

On some passes of ThunderX,
the following registers incorrectly zero extended when they should
instead behave as normal 32-bit register pairs:

  SMMU()_(S)GFAR
  SMMU()_NSGFAR
  SMMU()_CB()_TTBR0
  SMMU()_CB()_TTBR1
  SMMU()_CB()_FAR

Signed-off-by: Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>
---
 drivers/iommu/arm-smmu.c | 51 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 66a803b..7a3cf7f 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -290,6 +290,7 @@ struct arm_smmu_device {
 	u32				features;
 
 #define ARM_SMMU_OPT_SECURE_CFG_ACCESS (1 << 0)
+#define ARM_SMMU_OPT_64BIT_WRITES_ONLY (1 << 1)
 	u32				options;
 	enum arm_smmu_arch_version	version;
 
@@ -351,6 +352,8 @@ struct arm_smmu_option_prop {
 
 static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ ARM_SMMU_OPT_SECURE_CFG_ACCESS, "calxeda,smmu-secure-config-access" },
+	/* ThunderX errata 23399 */
+	{ ARM_SMMU_OPT_64BIT_WRITES_ONLY, "thunderx,smmu-64-bit-writes-only" },
 	{ 0, NULL},
 };
 
@@ -719,6 +722,7 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	u32 reg;
+	u64 reg64;
 	bool stage1;
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
@@ -762,22 +766,39 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
 
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
+		if (smmu->options & ARM_SMMU_OPT_64BIT_WRITES_ONLY) {
+			reg64 = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
+			reg64 |= ((u64) ARM_SMMU_CB_ASID(cfg)) <<
+						(TTBRn_HI_ASID_SHIFT + 32);
+			writeq_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_LO);
+
+			reg64 = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[1];
+			reg64 |= ((u64)ARM_SMMU_CB_ASID(cfg)) <<
+						(TTBRn_HI_ASID_SHIFT + 32);
+			writeq_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR1_LO);
+		} else {
+			reg = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
+			writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_LO);
+			reg = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0] >> 32;
+			reg |= ARM_SMMU_CB_ASID(cfg) << TTBRn_HI_ASID_SHIFT;
+			writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_HI);
+
+			reg = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[1];
+			writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR1_LO);
+			reg = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[1] >> 32;
+			reg |= ARM_SMMU_CB_ASID(cfg) << TTBRn_HI_ASID_SHIFT;
+			writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR1_HI);
+		}
 	} else {
-		reg = pgtbl_cfg->arm_lpae_s2_cfg.vttbr;
-		writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_LO);
-		reg = pgtbl_cfg->arm_lpae_s2_cfg.vttbr >> 32;
-		writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_HI);
+		if (smmu->options & ARM_SMMU_OPT_64BIT_WRITES_ONLY) {
+			reg64 = pgtbl_cfg->arm_lpae_s2_cfg.vttbr;
+			writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_LO);
+		} else {
+			reg = pgtbl_cfg->arm_lpae_s2_cfg.vttbr;
+			writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_LO);
+			reg = pgtbl_cfg->arm_lpae_s2_cfg.vttbr >> 32;
+			writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_HI);
+		}
 	}
 
 	/* TTBCR */
-- 
2.1.0
