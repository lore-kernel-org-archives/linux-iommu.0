From: Geetha sowjanya <gakula@caviumnetworks.com>
Subject: [PATCH v3 1/7] iommu/arm-smmu-v3: Introduce SMMU option PAGE0_REGS_ONLY for ThunderX2 errata #74
Date: Fri,  5 May 2017 17:38:05 +0530
Message-ID: <1493986091-30521-2-git-send-email-gakula@caviumnetworks.com>
References: <1493986091-30521-1-git-send-email-gakula@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1493986091-30521-1-git-send-email-gakula@caviumnetworks.com>
Sender: linux-acpi-owner@vger.kernel.org
To: will.deacon@arm.com, robin.murphy@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, iommu@lists.linux-foundation.org
Cc: jcm@redhat.com, linux-kernel@vger.kernel.org, robert.richter@cavium.com, catalin.marinas@arm.com, sgoutham@cavium.com, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, geethasowjanya.akula@gmail.com, linu.cherian@cavium.com, Charles.Garcia-Tobin@arm.com, Geetha Sowjanya <geethasowjanya.akula@cavium.com>
List-Id: iommu@lists.linux-foundation.org

From: Linu Cherian <linu.cherian@cavium.com>

Cavium ThunderX2 SMMU implementation doesn't support page 1 register space
and PAGE0_REGS_ONLY option will be enabled as an errata workaround.

This option when turned on, replaces all page 1 offsets used for
EVTQ_PROD/CONS, PRIQ_PROD/CONS register access with page 0 offsets.

Signed-off-by: Linu Cherian <linu.cherian@cavium.com>
Signed-off-by: Geetha Sowjanya <geethasowjanya.akula@cavium.com>
---
 .../devicetree/bindings/iommu/arm,smmu-v3.txt      |  6 +++
 drivers/iommu/arm-smmu-v3.c                        | 44 ++++++++++++++++------
 2 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
index be57550..e6da62b 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
@@ -49,6 +49,12 @@ the PCIe specification.
 - hisilicon,broken-prefetch-cmd
                     : Avoid sending CMD_PREFETCH_* commands to the SMMU.
 
+- cavium-cn99xx,broken-page1-regspace
+                    : Replaces all page 1 offsets used for EVTQ_PROD/CONS,
+						PRIQ_PROD/CONS register access with page 0 offsets.
+						Set for Caviun ThunderX2 silicon that doesn't support
+						SMMU page1 register space.
+
 ** Example
 
         smmu@2b400000 {
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 380969a..107b4a6 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -176,15 +176,15 @@
 #define ARM_SMMU_CMDQ_CONS		0x9c
 
 #define ARM_SMMU_EVTQ_BASE		0xa0
-#define ARM_SMMU_EVTQ_PROD		0x100a8
-#define ARM_SMMU_EVTQ_CONS		0x100ac
+#define ARM_SMMU_EVTQ_PROD(smmu)	(page1_offset_adjust(0x100a8, smmu))
+#define ARM_SMMU_EVTQ_CONS(smmu)	(page1_offset_adjust(0x100ac, smmu))
 #define ARM_SMMU_EVTQ_IRQ_CFG0		0xb0
 #define ARM_SMMU_EVTQ_IRQ_CFG1		0xb8
 #define ARM_SMMU_EVTQ_IRQ_CFG2		0xbc
 
 #define ARM_SMMU_PRIQ_BASE		0xc0
-#define ARM_SMMU_PRIQ_PROD		0x100c8
-#define ARM_SMMU_PRIQ_CONS		0x100cc
+#define ARM_SMMU_PRIQ_PROD(smmu)	(page1_offset_adjust(0x100c8, smmu))
+#define ARM_SMMU_PRIQ_CONS(smmu)	(page1_offset_adjust(0x100cc, smmu))
 #define ARM_SMMU_PRIQ_IRQ_CFG0		0xd0
 #define ARM_SMMU_PRIQ_IRQ_CFG1		0xd8
 #define ARM_SMMU_PRIQ_IRQ_CFG2		0xdc
@@ -412,6 +412,9 @@
 #define MSI_IOVA_BASE			0x8000000
 #define MSI_IOVA_LENGTH			0x100000
 
+#define ARM_SMMU_PAGE0_REGS_ONLY(smmu)		\
+	((smmu)->options & ARM_SMMU_OPT_PAGE0_REGS_ONLY)
+
 static bool disable_bypass;
 module_param_named(disable_bypass, disable_bypass, bool, S_IRUGO);
 MODULE_PARM_DESC(disable_bypass,
@@ -597,6 +600,7 @@ struct arm_smmu_device {
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
+#define ARM_SMMU_OPT_PAGE0_REGS_ONLY    (1 << 1)
 	u32				options;
 
 	struct arm_smmu_cmdq		cmdq;
@@ -663,9 +667,19 @@ struct arm_smmu_option_prop {
 
 static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-cmd" },
+	{ ARM_SMMU_OPT_PAGE0_REGS_ONLY, "cavium-cn99xx,broken-page1-regspace"},
 	{ 0, NULL},
 };
 
+static inline unsigned long page1_offset_adjust(
+	unsigned long off, struct arm_smmu_device *smmu)
+{
+	if (!ARM_SMMU_PAGE0_REGS_ONLY(smmu))
+		return off;
+	else
+		return (off - SZ_64K);
+}
+
 static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
 {
 	return container_of(dom, struct arm_smmu_domain, domain);
@@ -1986,8 +2000,10 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 		return ret;
 
 	/* evtq */
-	ret = arm_smmu_init_one_queue(smmu, &smmu->evtq.q, ARM_SMMU_EVTQ_PROD,
-				      ARM_SMMU_EVTQ_CONS, EVTQ_ENT_DWORDS);
+	ret = arm_smmu_init_one_queue(smmu, &smmu->evtq.q,
+				      ARM_SMMU_EVTQ_PROD(smmu),
+				      ARM_SMMU_EVTQ_CONS(smmu),
+				      EVTQ_ENT_DWORDS);
 	if (ret)
 		return ret;
 
@@ -1995,8 +2011,10 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 	if (!(smmu->features & ARM_SMMU_FEAT_PRI))
 		return 0;
 
-	return arm_smmu_init_one_queue(smmu, &smmu->priq.q, ARM_SMMU_PRIQ_PROD,
-				       ARM_SMMU_PRIQ_CONS, PRIQ_ENT_DWORDS);
+	return arm_smmu_init_one_queue(smmu, &smmu->priq.q,
+				       ARM_SMMU_PRIQ_PROD(smmu),
+				       ARM_SMMU_PRIQ_CONS(smmu),
+				       PRIQ_ENT_DWORDS);
 }
 
 static int arm_smmu_init_l1_strtab(struct arm_smmu_device *smmu)
@@ -2363,8 +2381,10 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 
 	/* Event queue */
 	writeq_relaxed(smmu->evtq.q.q_base, smmu->base + ARM_SMMU_EVTQ_BASE);
-	writel_relaxed(smmu->evtq.q.prod, smmu->base + ARM_SMMU_EVTQ_PROD);
-	writel_relaxed(smmu->evtq.q.cons, smmu->base + ARM_SMMU_EVTQ_CONS);
+	writel_relaxed(smmu->evtq.q.prod, smmu->base +
+		       ARM_SMMU_EVTQ_PROD(smmu));
+	writel_relaxed(smmu->evtq.q.cons, smmu->base +
+		       ARM_SMMU_EVTQ_CONS(smmu));
 
 	enables |= CR0_EVTQEN;
 	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
@@ -2379,9 +2399,9 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 		writeq_relaxed(smmu->priq.q.q_base,
 			       smmu->base + ARM_SMMU_PRIQ_BASE);
 		writel_relaxed(smmu->priq.q.prod,
-			       smmu->base + ARM_SMMU_PRIQ_PROD);
+			       smmu->base + ARM_SMMU_PRIQ_PROD(smmu));
 		writel_relaxed(smmu->priq.q.cons,
-			       smmu->base + ARM_SMMU_PRIQ_CONS);
+			       smmu->base + ARM_SMMU_PRIQ_CONS(smmu));
 
 		enables |= CR0_PRIQEN;
 		ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
-- 
1.8.3.1

