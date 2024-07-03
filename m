Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF3013D2BE
	for <iommu@lists.linux.dev>; Wed,  3 Jul 2024 10:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720001949; cv=none; b=HZxSHlgDjOy21bg6CNtHWTo4QFF84beNHJldJdD2/bPgCiKU3kV+9tMPQyqMQyQ9Xd235yvrcw63nqbau1x4+chVCKxJ41Szl+pNyn6Qa5ST9rmgpmnTP3WlVcjcdCl1qIzjrHErLliK4nfZXyKOGW4pyRtVXimUrPl2PM8oL74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720001949; c=relaxed/simple;
	bh=1p8zJ5w9s/K9dhPemKdxvK9F+W3g1akiTbSsMJuGzzM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sKgcQ5+Gzmng5knfjyRS6ToQrXfvIHroHahTNq0gwVBQB2NGp7SKTwgahG0Bk6j9RHdEDUu4MmcooRgAILr8dGnG1T/HVxiGRrRzMXy25N0UNHwsalYrj/B7gZ+wnbWMsYqo58VkmwsRyndQtUjExKYAPotrLoVrxD0LJB/rtqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WDbMl2y4Jz6JB0N;
	Wed,  3 Jul 2024 18:18:27 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id A2153140B2F;
	Wed,  3 Jul 2024 18:19:05 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.203.177.241) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 11:18:56 +0100
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<ryan.roberts@arm.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<mshavit@google.com>, <eric.auger@redhat.com>, <joao.m.martins@oracle.com>,
	<jiangkunkun@huawei.com>, <zhukeqian1@huawei.com>, <linuxarm@huawei.com>
Subject: [PATCH v7 5/5] iommu/arm-smmu-v3: Enable HTTU for stage1 with io-pgtable mapping
Date: Wed, 3 Jul 2024 11:16:04 +0100
Message-ID: <20240703101604.2576-6-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20240703101604.2576-1-shameerali.kolothum.thodi@huawei.com>
References: <20240703101604.2576-1-shameerali.kolothum.thodi@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

From: Kunkun Jiang <jiangkunkun@huawei.com>

If io-pgtable quirk flag indicates support for hardware update of
dirty state, enable HA/HD bits in the SMMU CD and also set the DBM
bit in the page descriptor.

Now report the dirty page tracking capability of SMMUv3 and
select IOMMUFD_DRIVER for ARM_SMMU_V3 if IOMMUFD is enabled.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/Kconfig                       |  1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 15 +++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  3 +++
 drivers/iommu/io-pgtable-arm.c              |  5 ++++-
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index c04584be3089..a82f10054aec 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -394,6 +394,7 @@ config ARM_SMMU_V3
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_LPAE
 	select GENERIC_MSI_IRQ
+	select IOMMUFD_DRIVER if IOMMUFD
 	help
 	  Support for implementations of the ARM System MMU architecture
 	  version 3 providing translation support to a PCIe root complex.
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index c1e32a2ea3f8..a31460f9f3d4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1352,6 +1352,12 @@ void arm_smmu_make_s1_cd(struct arm_smmu_cd *target,
 		CTXDESC_CD_0_ASET |
 		FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid)
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
@@ -2235,6 +2241,13 @@ static const struct iommu_flush_ops arm_smmu_flush_ops = {
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
@@ -2247,6 +2260,8 @@ static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
 	case IOMMU_CAP_NOEXEC:
 	case IOMMU_CAP_DEFERRED_FLUSH:
 		return true;
+	case IOMMU_CAP_DIRTY_TRACKING:
+		return arm_smmu_dbm_capable(master->smmu);
 	default:
 		return false;
 	}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index af74b59032b5..14bca41a981b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -304,6 +304,9 @@ struct arm_smmu_cd {
 #define CTXDESC_CD_0_TCR_IPS		GENMASK_ULL(34, 32)
 #define CTXDESC_CD_0_TCR_TBI0		(1ULL << 38)
 
+#define CTXDESC_CD_0_TCR_HA            (1UL << 43)
+#define CTXDESC_CD_0_TCR_HD            (1UL << 42)
+
 #define CTXDESC_CD_0_AA64		(1UL << 41)
 #define CTXDESC_CD_0_S			(1UL << 44)
 #define CTXDESC_CD_0_R			(1UL << 45)
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 2e57e8616387..f5d9fd1f45bf 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -440,6 +440,8 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
 		pte = ARM_LPAE_PTE_nG;
 		if (!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
 			pte |= ARM_LPAE_PTE_AP_RDONLY;
+		else if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_HD)
+			pte |= ARM_LPAE_PTE_DBM;
 		if (!(prot & IOMMU_PRIV))
 			pte |= ARM_LPAE_PTE_AP_UNPRIV;
 	} else {
@@ -929,7 +931,8 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
 
 	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS |
 			    IO_PGTABLE_QUIRK_ARM_TTBR1 |
-			    IO_PGTABLE_QUIRK_ARM_OUTER_WBWA))
+			    IO_PGTABLE_QUIRK_ARM_OUTER_WBWA |
+			    IO_PGTABLE_QUIRK_ARM_HD))
 		return NULL;
 
 	data = arm_lpae_alloc_pgtable(cfg);
-- 
2.34.1

