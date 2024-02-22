Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8674E1799E
	for <iommu@lists.linux.dev>; Thu, 22 Feb 2024 09:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708595468; cv=none; b=MYEbuodG7CRCkyDefuvNoGu+uWeIjSHS/ygq4r11gicI+ZAxOjuMX6PBG/LopVcd8g71bfIhlM8oDR8Pz94H03omKPviJGfp5xr6WhoirqaXsjXzUdiFGTjdHDYFqffNK0iYT8w3IbaTDR/c2K8riqrd83w3kqJCzv5jLYWnXqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708595468; c=relaxed/simple;
	bh=wWXh2g7jnKiIk/S4Lvx3iG9E8Naw88z+RYIIf37PVWE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=careHlz3V7/gKoP+ib0O40xd7zDtCjBnxOhpMojHxQWh9OMxI38g/E1qXopAIsZcrbjArWgnbH3F5MAmyzUmxKTaP926VH+FeMBWP3/BdQoqruNnLbCijuUU3GDQkaCWvFLgXIt+fS82Xhqpo+/fDTcv597BZaC52U8hfoVOLIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TgSw16TTWz6HJg4;
	Thu, 22 Feb 2024 17:46:41 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 250D61404F5;
	Thu, 22 Feb 2024 17:51:04 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.202.227.28) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 09:50:57 +0000
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <kevin.tian@intel.com>,
	<nicolinc@nvidia.com>, <mshavit@google.com>, <robin.murphy@arm.com>,
	<will@kernel.org>, <joao.m.martins@oracle.com>, <jiangkunkun@huawei.com>,
	<zhukeqian1@huawei.com>, <linuxarm@huawei.com>
Subject: [PATCH v2 4/4] iommu/arm-smmu-v3: Enable HTTU for stage1 with io-pgtable mapping
Date: Thu, 22 Feb 2024 09:49:23 +0000
Message-ID: <20240222094923.33104-5-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20240222094923.33104-1-shameerali.kolothum.thodi@huawei.com>
References: <20240222094923.33104-1-shameerali.kolothum.thodi@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

From: Kunkun Jiang <jiangkunkun@huawei.com>

If io-pgtable quirk flag indicates support for hardware update of
dirty state, enable HA/HD bits in the SMMU CD and also set the DBM
bit in the page descriptor.

And now report the dirty page tracking capability of SMMUv3.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 15 +++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  3 +++
 drivers/iommu/io-pgtable-arm.c              |  5 ++++-
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 058bbb0dbe2e..4423cc7e48cf 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1271,6 +1271,12 @@ void arm_smmu_make_s1_cd(struct arm_smmu_cd *target,
 		CTXDESC_CD_0_ASET |
 		FIELD_PREP(CTXDESC_CD_0_ASID, smmu_domain->asid)
 		);
+
+	/* To enable dirty flag update, set both Access flag and dirty state update */
+	if (pgtbl_cfg->quirks & IO_PGTABLE_QUIRK_ARM_HD)
+		target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_HA |
+					       CTXDESC_CD_0_TCR_HD);
+
 	target->data[1] = cpu_to_le64(pgtbl_cfg->arm_lpae_s1_cfg.ttbr &
 				      CTXDESC_CD_1_TTB0_MASK);
 	target->data[3] = cpu_to_le64(pgtbl_cfg->arm_lpae_s1_cfg.mair);
@@ -2307,6 +2313,13 @@ static const struct iommu_flush_ops arm_smmu_flush_ops = {
 	.tlb_add_page	= arm_smmu_tlb_inv_page_nosync,
 };
 
+static bool arm_smmu_dbm_capable(struct arm_smmu_device *smmu)
+{
+	u32 features = (ARM_SMMU_FEAT_HD | ARM_SMMU_FEAT_COHERENCY);
+
+	return (smmu->features & features) == features;
+}
+
 /* IOMMU API */
 static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
 {
@@ -2319,6 +2332,8 @@ static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
 	case IOMMU_CAP_NOEXEC:
 	case IOMMU_CAP_DEFERRED_FLUSH:
 		return true;
+	case IOMMU_CAP_DIRTY_TRACKING:
+		return arm_smmu_dbm_capable(master->smmu);
 	default:
 		return false;
 	}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 5e51a6c1d55f..a9cd805e5a1b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -313,6 +313,9 @@ struct arm_smmu_cd {
 #define CTXDESC_CD_0_TCR_IPS		GENMASK_ULL(34, 32)
 #define CTXDESC_CD_0_TCR_TBI0		(1ULL << 38)
 
+#define CTXDESC_CD_0_TCR_HA            (1UL << 43)
+#define CTXDESC_CD_0_TCR_HD            (1UL << 42)
+
 #define CTXDESC_CD_0_AA64		(1UL << 41)
 #define CTXDESC_CD_0_S			(1UL << 44)
 #define CTXDESC_CD_0_R			(1UL << 45)
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 1ce7b7a3c1e8..56e88e555fc7 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -429,6 +429,8 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
 		pte = ARM_LPAE_PTE_nG;
 		if (!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
 			pte |= ARM_LPAE_PTE_AP_RDONLY;
+		else if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_HD)
+			pte |= ARM_LPAE_PTE_AP_WRITABLE;
 		if (!(prot & IOMMU_PRIV))
 			pte |= ARM_LPAE_PTE_AP_UNPRIV;
 	} else {
@@ -948,7 +950,8 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
 
 	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS |
 			    IO_PGTABLE_QUIRK_ARM_TTBR1 |
-			    IO_PGTABLE_QUIRK_ARM_OUTER_WBWA))
+			    IO_PGTABLE_QUIRK_ARM_OUTER_WBWA |
+			    IO_PGTABLE_QUIRK_ARM_HD))
 		return NULL;
 
 	data = arm_lpae_alloc_pgtable(cfg);
-- 
2.34.1

