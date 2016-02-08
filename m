From: Anup Patel <anup.patel@broadcom.com>
Subject: [PATCH v2 1/4] iommu/arm-smmu: Init driver using IOMMU_OF_DECLARE
Date: Mon,  8 Feb 2016 10:47:29 +0530
Message-ID: <1454908652-15317-2-git-send-email-anup.patel@broadcom.com>
References: <1454908652-15317-1-git-send-email-anup.patel@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1454908652-15317-1-git-send-email-anup.patel@broadcom.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, Robin Murphy <Robin.Murphy@arm.com>, Sricharan R <sricharan@codeaurora.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Device Tree <devicetree@vger.kernel.org>, Scott Branden <sbranden@broadcom.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Ray Jui <rjui@broadcom.com>, Linux Kernel <linux-kernel@vger.kernel.org>, Vikram Prakash <vikramp@broadcom.com>, Rob Herring <robh+dt@kernel.org>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, Kumar Gala <galak@codeaurora.org>, Anup Patel <anup.patel@broadcom.com>
List-Id: iommu@lists.linux-foundation.org

From: Sricharan R <sricharan@codeaurora.org>

This patch uses IOMMU_OF_DECLARE to register the driver
and the iommu_ops. So when master devices of the iommu are
registered, of_xlate callback can be used to add the master
configurations to the smmu driver.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Tested-by: Anup Patel <anup.patel@broadcom.com>
---
 drivers/iommu/arm-smmu.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index bf1895c..2c8f871 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -39,6 +39,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_iommu.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -265,6 +266,8 @@
 #define FSYNR0_WNR			(1 << 4)
 
 static int force_stage;
+static bool init_done;
+
 module_param_named(force_stage, force_stage, int, S_IRUGO);
 MODULE_PARM_DESC(force_stage,
 	"Force SMMU mappings to be installed at a particular stage of translation. A value of '1' or '2' forces the corresponding stage. All other values are ignored (i.e. no stage is forced). Note that selecting a specific stage will disable support for nested translation.");
@@ -1926,20 +1929,8 @@ static struct platform_driver arm_smmu_driver = {
 
 static int __init arm_smmu_init(void)
 {
-	struct device_node *np;
 	int ret;
 
-	/*
-	 * Play nice with systems that don't have an ARM SMMU by checking that
-	 * an ARM SMMU exists in the system before proceeding with the driver
-	 * and IOMMU bus operation registration.
-	 */
-	np = of_find_matching_node(NULL, arm_smmu_of_match);
-	if (!np)
-		return 0;
-
-	of_node_put(np);
-
 	ret = platform_driver_register(&arm_smmu_driver);
 	if (ret)
 		return ret;
@@ -1958,15 +1949,33 @@ static int __init arm_smmu_init(void)
 		bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
 #endif
 
+	init_done = true;
+
 	return 0;
 }
 
+static int __init arm_smmu_of_setup(struct device_node *np)
+{
+
+	if (!init_done)
+		arm_smmu_init();
+
+	of_iommu_set_ops(np, &arm_smmu_ops);
+
+	return 0;
+}
+
+IOMMU_OF_DECLARE(arm_smmu_v1, "arm,smmu-v1", arm_smmu_of_setup);
+IOMMU_OF_DECLARE(arm_smmu_v2, "arm,smmu-v2", arm_smmu_of_setup);
+IOMMU_OF_DECLARE(arm_smmu_400, "arm,mmu-400", arm_smmu_of_setup);
+IOMMU_OF_DECLARE(arm_smmu_401, "arm,mmu-401", arm_smmu_of_setup);
+IOMMU_OF_DECLARE(arm_smmu_500, "arm,mmu-500", arm_smmu_of_setup);
+
 static void __exit arm_smmu_exit(void)
 {
 	return platform_driver_unregister(&arm_smmu_driver);
 }
 
-subsys_initcall(arm_smmu_init);
 module_exit(arm_smmu_exit);
 
 MODULE_DESCRIPTION("IOMMU API for ARM architected SMMU implementations");
-- 
1.9.1
