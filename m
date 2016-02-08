From: Anup Patel <anup.patel@broadcom.com>
Subject: [PATCH v2 2/4] iommu/arm-smmu: Invoke DT probe from
 arm_smmu_of_setup()
Date: Mon,  8 Feb 2016 10:47:30 +0530
Message-ID: <1454908652-15317-3-git-send-email-anup.patel@broadcom.com>
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

The SMMUv1/SMMUv2 driver is initialized very early using the
IOMMU_OF_DECLARE() but the actual platform device is probed
via normal DT probing.

This patch uses of_platform_device_create() from arm_smmu_of_setup()
to ensure that SMMU platform device is probed immediately.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
---
 drivers/iommu/arm-smmu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 2c8f871..02cd67d 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -40,6 +40,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_iommu.h>
+#include <linux/of_platform.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -1956,10 +1957,15 @@ static int __init arm_smmu_init(void)
 
 static int __init arm_smmu_of_setup(struct device_node *np)
 {
+	struct platform_device *pdev;
 
 	if (!init_done)
 		arm_smmu_init();
 
+	pdev = of_platform_device_create(np, NULL, NULL);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
 	of_iommu_set_ops(np, &arm_smmu_ops);
 
 	return 0;
-- 
1.9.1
