Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670AD71742
	for <iommu@lists.linux.dev>; Tue, 28 May 2024 07:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716880784; cv=none; b=gmvEWV4ka3W65N+YGiUju1L3P4NbYkvgbjft0+RskTgwISJvsAzE5XzogmRUI5kfxPsb4+VZScGWxM2wutPVkQo+H+R/YdspQ08UdkcsRejgkMn8C4iMfdf+huQED9RjeEmQFTOZNalPiK/AcOJXrdnSba3V6Wwnw/05cRoJEjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716880784; c=relaxed/simple;
	bh=qinq5zT5j/gyUpNq+ao4RKhebcY/Iu0gkuz4Vz3GhIE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hwxBwGwE653nVNfCf1x5c7vCb6/cUHsfkWoqvylhgW2GtN+hKv2vR2Jzh7rwQoS10onrelpMLrdUYGbgqeC3BCoxvdJuzUf9j7kwH7ZBjKfuF7hFTLfBw+8YPhdizDb+/1wxQ0Z05O0oZkhzREa1qughRUDoC7PQAlO3YbAvA4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VpP4x2sfGz6K99r;
	Tue, 28 May 2024 15:18:41 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 44A3B1400C9;
	Tue, 28 May 2024 15:19:40 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.126.170.13) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 28 May 2024 08:19:30 +0100
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>
CC: <robin.murphy@arm.com>, <will@kernel.org>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <ryan.roberts@arm.com>, <kevin.tian@intel.com>,
	<nicolinc@nvidia.com>, <mshavit@google.com>, <eric.auger@redhat.com>,
	<joao.m.martins@oracle.com>, <jiangkunkun@huawei.com>,
	<zhukeqian1@huawei.com>, <linuxarm@huawei.com>
Subject: [PATCH v4 1/7] iommu/arm-smmu-v3: Convert to domain_alloc_sva()
Date: Tue, 28 May 2024 08:18:25 +0100
Message-ID: <20240528071831.17560-2-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20240528071831.17560-1-shameerali.kolothum.thodi@huawei.com>
References: <20240528071831.17560-1-shameerali.kolothum.thodi@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

From: Jason Gunthorpe <jgg@nvidia.com>

This allows the driver the receive the mm and a always a device during
allocation. Later patches need this to properly setup the notifier when
the domain is first allocated.

Remove ops->domain_alloc() as SVA was the only remaining purpose.

Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Michael Shavit <mshavit@google.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c |  6 ++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 10 +---------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     |  6 +++++-
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index e490ffb38015..28f8bf4327f6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -656,13 +656,15 @@ static const struct iommu_domain_ops arm_smmu_sva_domain_ops = {
 	.free			= arm_smmu_sva_domain_free
 };
 
-struct iommu_domain *arm_smmu_sva_domain_alloc(void)
+struct iommu_domain *arm_smmu_sva_domain_alloc(struct device *dev,
+					       struct mm_struct *mm)
 {
 	struct iommu_domain *domain;
 
 	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
 	if (!domain)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
+	domain->type = IOMMU_DOMAIN_SVA;
 	domain->ops = &arm_smmu_sva_domain_ops;
 
 	return domain;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index ab415e107054..bd79422f7b6f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2237,14 +2237,6 @@ static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
 	}
 }
 
-static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
-{
-
-	if (type == IOMMU_DOMAIN_SVA)
-		return arm_smmu_sva_domain_alloc();
-	return ERR_PTR(-EOPNOTSUPP);
-}
-
 static struct iommu_domain *arm_smmu_domain_alloc_paging(struct device *dev)
 {
 	struct arm_smmu_domain *smmu_domain;
@@ -3097,8 +3089,8 @@ static struct iommu_ops arm_smmu_ops = {
 	.identity_domain	= &arm_smmu_identity_domain,
 	.blocked_domain		= &arm_smmu_blocked_domain,
 	.capable		= arm_smmu_capable,
-	.domain_alloc		= arm_smmu_domain_alloc,
 	.domain_alloc_paging    = arm_smmu_domain_alloc_paging,
+	.domain_alloc_sva       = arm_smmu_sva_domain_alloc,
 	.probe_device		= arm_smmu_probe_device,
 	.release_device		= arm_smmu_release_device,
 	.device_group		= arm_smmu_device_group,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 1242a086c9f9..4c6c843669aa 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -802,7 +802,8 @@ int arm_smmu_master_enable_sva(struct arm_smmu_master *master);
 int arm_smmu_master_disable_sva(struct arm_smmu_master *master);
 bool arm_smmu_master_iopf_supported(struct arm_smmu_master *master);
 void arm_smmu_sva_notifier_synchronize(void);
-struct iommu_domain *arm_smmu_sva_domain_alloc(void);
+struct iommu_domain *arm_smmu_sva_domain_alloc(struct device *dev,
+					       struct mm_struct *mm);
 void arm_smmu_sva_remove_dev_pasid(struct iommu_domain *domain,
 				   struct device *dev, ioasid_t id);
 #else /* CONFIG_ARM_SMMU_V3_SVA */
@@ -848,5 +849,8 @@ static inline void arm_smmu_sva_remove_dev_pasid(struct iommu_domain *domain,
 						 ioasid_t id)
 {
 }
+
+#define arm_smmu_sva_domain_alloc NULL
+
 #endif /* CONFIG_ARM_SMMU_V3_SVA */
 #endif /* _ARM_SMMU_V3_H */
-- 
2.34.1

