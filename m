From: shameer <shameerali.kolothum.thodi@huawei.com>
Subject: [RFC v1 5/7] iommu/arm-smmu-v3: Enable ACPI based HiSilicon erratum 161010701
Date: Sat, 13 May 2017 10:47:29 +0100
Message-ID: <20170513094731.3676-6-shameerali.kolothum.thodi@huawei.com>
References: <20170513094731.3676-1-shameerali.kolothum.thodi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170513094731.3676-1-shameerali.kolothum.thodi@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
To: will.deacon@arm.com, robin.murphy@arm.com, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org
Cc: gabriele.paoloni@huawei.com, john.garry@huawei.com, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, devel@acpica.org, linuxarm@huawei.com, wangzhou1@hisilicon.com, guohanjun@huawei.com, shameer <shameerali.kolothum.thodi@huawei.com>
List-Id: iommu@lists.linux-foundation.org

This uses the ACPI IORT model number to enable the erratum.

Signed-off-by: shameer <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 14538cb..770cc9e 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -652,6 +652,7 @@ struct arm_smmu_domain {
 
 enum smmu_erratum_match_type {
 	se_match_dt,
+	se_match_acpi_iort_model,
 };
 
 void erratum_skip_prefetch_cmd(struct arm_smmu_device *smmu, void *arg)
@@ -674,6 +675,13 @@ static const struct smmu_erratum_workaround smmu_workarounds[] = {
 		.desc_str = "HiSilicon erratum 161010701",
 		.enable = erratum_skip_prefetch_cmd,
 	},
+	{
+		.match_type = se_match_acpi_iort_model,
+		.id = (void *)ACPI_IORT_SMMU_HISILICON_HI161X,
+		.desc_str = "HiSilicon erratum 161010701",
+		.enable = erratum_skip_prefetch_cmd,
+	},
+
 #endif
 	{
 
@@ -691,6 +699,15 @@ bool smmu_check_dt_erratum(const struct smmu_erratum_workaround *wa,
 	return of_property_read_bool(np, wa->id);
 }
 
+static
+bool smmu_check_acpi_iort_erratum(const struct smmu_erratum_workaround *wa,
+				const void *arg)
+{
+	const struct acpi_iort_smmu_v3 *iort_smmu = arg;
+
+	return (iort_smmu->model == *(u32 *)(&wa->id)) ? true : false;
+}
+
 static void smmu_enable_errata(struct arm_smmu_device *smmu,
 				enum smmu_erratum_match_type type,
 				se_match_fn_t match_fn,
@@ -724,6 +741,9 @@ static void smmu_check_workarounds(struct arm_smmu_device *smmu,
 	case se_match_dt:
 		match_fn = smmu_check_dt_erratum;
 		break;
+	case se_match_acpi_iort_model:
+		match_fn = smmu_check_acpi_iort_erratum;
+		break;
 	}
 
 	smmu_enable_errata(smmu, type, match_fn, arg);
@@ -2654,6 +2674,8 @@ static int arm_smmu_device_acpi_probe(struct platform_device *pdev,
 	/* Retrieve SMMUv3 specific data */
 	iort_smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
 
+	smmu_check_workarounds(smmu, se_match_acpi_iort_model, iort_smmu);
+
 	if (iort_smmu->flags & ACPI_IORT_SMMU_V3_COHACC_OVERRIDE)
 		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
 
-- 
2.5.0


