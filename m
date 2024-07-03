Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E14013D617
	for <iommu@lists.linux.dev>; Wed,  3 Jul 2024 10:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720001916; cv=none; b=eAqY3GAz/LQgpcHtKkGE7ZXYfZeZMfAWuKFNIdOBPT0tRyjXor7Oo5o4vzuTQ8nX42HbhQAzdaixvmIig3ZKzNS+//LpcIzExbLDo/4u2VQyjEryamWEUZWJBCtqJnc1ycJZbM61lmmz49bxiksBDaXM26v0CfStWR8uKAoO4M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720001916; c=relaxed/simple;
	bh=PhLEsluAiGa280gvo3DttFpXdq8PjpH4LPY0nLpeg1I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AWaeJSb63GMhTnRnJQDA3gLigYhljjXgyAfekgcHw6ZYgULsVe+L1B10wG5Um8TOBARq8E6rOWoYilg5SjWVzUMcflFPLgUDp5Vtd1hRuxUsVCiNglOhmvxRbhc7hgqtS//1UugTFEK6IrNQcCzPYX4rNMw9hrcJVLIk14i9xsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WDbKg1BWMz6K7JS;
	Wed,  3 Jul 2024 18:16:39 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B0EB1140A46;
	Wed,  3 Jul 2024 18:18:31 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.203.177.241) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 11:18:22 +0100
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<ryan.roberts@arm.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<mshavit@google.com>, <eric.auger@redhat.com>, <joao.m.martins@oracle.com>,
	<jiangkunkun@huawei.com>, <zhukeqian1@huawei.com>, <linuxarm@huawei.com>
Subject: [PATCH v7 2/5] iommu/arm-smmu-v3: Add feature detection for HTTU
Date: Wed, 3 Jul 2024 11:16:01 +0100
Message-ID: <20240703101604.2576-3-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20240703101604.2576-1-shameerali.kolothum.thodi@huawei.com>
References: <20240703101604.2576-1-shameerali.kolothum.thodi@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

If the SMMU supports it and the kernel was built with HTTU support,
Probe support for Hardware Translation Table Update (HTTU) which is
essentially to enable hardware update of access and dirty flags.

Probe and set the smmu::features for Hardware Dirty and Hardware Access
bits. This is in preparation, to enable it on the context descriptors of
stage 1 format.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 32 +++++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  5 ++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index c616a38ecf28..6b35954940b8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4014,6 +4014,28 @@ static void arm_smmu_device_iidr_probe(struct arm_smmu_device *smmu)
 	}
 }
 
+static void arm_smmu_get_httu(struct arm_smmu_device *smmu, u32 reg)
+{
+	u32 fw_features = smmu->features & (ARM_SMMU_FEAT_HA | ARM_SMMU_FEAT_HD);
+	u32 hw_features = 0;
+
+	switch (FIELD_GET(IDR0_HTTU, reg)) {
+	case IDR0_HTTU_ACCESS_DIRTY:
+		hw_features |= ARM_SMMU_FEAT_HD;
+		fallthrough;
+	case IDR0_HTTU_ACCESS:
+		hw_features |= ARM_SMMU_FEAT_HA;
+	}
+
+	if (smmu->dev->of_node)
+		smmu->features |= hw_features;
+	else if (hw_features != fw_features)
+		/* ACPI IORT sets the HTTU bits */
+		dev_warn(smmu->dev,
+			 "IDR0.HTTU features(0x%x) overridden by FW configuration (0x%x)\n",
+			  hw_features, fw_features);
+}
+
 static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 {
 	u32 reg;
@@ -4074,6 +4096,8 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 			smmu->features |= ARM_SMMU_FEAT_E2H;
 	}
 
+	arm_smmu_get_httu(smmu, reg);
+
 	/*
 	 * The coherency feature as set by FW is used in preference to the ID
 	 * register, but warn on mismatch.
@@ -4269,6 +4293,14 @@ static int arm_smmu_device_acpi_probe(struct platform_device *pdev,
 	if (iort_smmu->flags & ACPI_IORT_SMMU_V3_COHACC_OVERRIDE)
 		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
 
+	switch (FIELD_GET(ACPI_IORT_SMMU_V3_HTTU_OVERRIDE, iort_smmu->flags)) {
+	case IDR0_HTTU_ACCESS_DIRTY:
+		smmu->features |= ARM_SMMU_FEAT_HD;
+		fallthrough;
+	case IDR0_HTTU_ACCESS:
+		smmu->features |= ARM_SMMU_FEAT_HA;
+	}
+
 	return 0;
 }
 #else
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index a05e02d6afd1..af74b59032b5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -33,6 +33,9 @@
 #define IDR0_ASID16			(1 << 12)
 #define IDR0_ATS			(1 << 10)
 #define IDR0_HYP			(1 << 9)
+#define IDR0_HTTU			GENMASK(7, 6)
+#define IDR0_HTTU_ACCESS		1
+#define IDR0_HTTU_ACCESS_DIRTY		2
 #define IDR0_COHACC			(1 << 4)
 #define IDR0_TTF			GENMASK(3, 2)
 #define IDR0_TTF_AARCH64		2
@@ -650,6 +653,8 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_E2H		(1 << 18)
 #define ARM_SMMU_FEAT_NESTING		(1 << 19)
 #define ARM_SMMU_FEAT_ATTR_TYPES_OVR	(1 << 20)
+#define ARM_SMMU_FEAT_HA		(1 << 21)
+#define ARM_SMMU_FEAT_HD		(1 << 22)
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
-- 
2.34.1

