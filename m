From: Eric Auger <eric.auger@redhat.com>
Subject: [RFC v2 3/4] iommu/arm-smmu-v3: Add hypothetical caching mode model
Date: Fri, 11 Aug 2017 15:45:29 +0200
Message-ID: <1502459130-6234-4-git-send-email-eric.auger@redhat.com>
References: <1502459130-6234-1-git-send-email-eric.auger@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502459130-6234-1-git-send-email-eric.auger@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Will.Deacon@arm.com, robin.murphy@arm.com, Jean-Philippe.Brucker@arm.com
Cc: christoffer.dall@linaro.org, Marc.Zyngier@arm.com, alex.williamson@redhat.com, peterx@redhat.com, mst@redhat.com, tn@semihalf.com, bharat.bhushan@nxp.com
List-Id: iommu@lists.linux-foundation.org

Let's add an hypothetical "caching mode" smmuv3 model (not yet
discussed for IORT spec) and enable the TLBI_ON_MAP option for
this latter.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/iommu/arm-smmu-v3.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 690247b..a1c10af 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -422,6 +422,10 @@
 #define ACPI_IORT_SMMU_V3_CAVIUM_CN99XX		0x2
 #endif
 
+#ifndef ACPI_IORT_SMMU_V3_CACHING_MODE
+#define ACPI_IORT_SMMU_V3_CACHING_MODE		0x3
+#endif
+
 static bool disable_bypass;
 module_param_named(disable_bypass, disable_bypass, bool, S_IRUGO);
 MODULE_PARM_DESC(disable_bypass,
@@ -2673,6 +2677,9 @@ static void acpi_smmu_get_options(u32 model, struct arm_smmu_device *smmu)
 	case ACPI_IORT_SMMU_HISILICON_HI161X:
 		smmu->options |= ARM_SMMU_OPT_SKIP_PREFETCH;
 		break;
+	case ACPI_IORT_SMMU_V3_CACHING_MODE:
+		smmu->options |= ARM_SMMU_OPT_TLBI_ON_MAP;
+		break;
 	}
 
 	dev_notice(smmu->dev, "option mask 0x%x\n", smmu->options);
-- 
2.5.5
