Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7DB1459F8
	for <iommu@lists.linux.dev>; Thu, 13 Jun 2024 14:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718289760; cv=none; b=RHiH0x4u993uuOatH6C8frtgKjFsKNzf88v9tVDrn96KeARJStRkd54NGtyR7R4WWPVDu+ToAxJiXyv6of9in98OvmhuSR3F7JeP0BZqaSkUoPKh1L4FlKEQkED4lg4FNJsQHabHRSnYkvkcgCD2H2rdLB48a9X21hZpViTbLzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718289760; c=relaxed/simple;
	bh=zGsnFEg40VEFaUi0FJnEkhs5Lx3kKLnpuijO67l/dB4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tFS3O2Q+o3iII66eYzkI7jLl14o+T/30mourWn/RUmTUzhiBvS77KyLMK8HunsE8bneuM6TrcBrIyAq3wPMpa/bkTJI3bdEIdyYCeP29Y7T4e4H6tTmbCCqwA5XikCwLsvCv6ZriDwuqLA0KJZivE0aDcjBVJZhbb8Ju76fXGE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W0Q8936P2z6H7KY;
	Thu, 13 Jun 2024 22:41:13 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 5ACE71400CF;
	Thu, 13 Jun 2024 22:42:36 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.202.227.28) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 15:42:27 +0100
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>
CC: <robin.murphy@arm.com>, <will@kernel.org>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <ryan.roberts@arm.com>, <mark.rutland@arm.com>,
	<kevin.tian@intel.com>, <nicolinc@nvidia.com>, <mshavit@google.com>,
	<eric.auger@redhat.com>, <joao.m.martins@oracle.com>,
	<jiangkunkun@huawei.com>, <zhukeqian1@huawei.com>, <linuxarm@huawei.com>
Subject: [PATCH v6 1/6] iommu/arm-smmu-v3: Factor out a common domain alloc
Date: Thu, 13 Jun 2024 15:41:44 +0100
Message-ID: <20240613144149.38672-2-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20240613144149.38672-1-shameerali.kolothum.thodi@huawei.com>
References: <20240613144149.38672-1-shameerali.kolothum.thodi@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

And use that for arm_smmu_domain_alloc_paging(). This will be useful
in a subsequent patch as well where we introduce support for
domain_alloc_user().

While at it, rename arm_smmu_domain_free() to arm_smmu_domain_free_paging()
as it is only used for paging domain.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 31 ++++++++++++++-------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index ab415e107054..c296435896f7 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2237,6 +2237,22 @@ static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
 	}
 }
 
+static struct arm_smmu_domain *arm_smmu_domain_alloc_common(void)
+{
+	struct arm_smmu_domain *smmu_domain;
+
+	smmu_domain = kzalloc(sizeof(*smmu_domain), GFP_KERNEL);
+	if (!smmu_domain)
+		return ERR_PTR(-ENOMEM);
+
+	mutex_init(&smmu_domain->init_mutex);
+	INIT_LIST_HEAD(&smmu_domain->devices);
+	spin_lock_init(&smmu_domain->devices_lock);
+	INIT_LIST_HEAD(&smmu_domain->mmu_notifiers);
+
+	return smmu_domain;
+}
+
 static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 {
 
@@ -2254,14 +2270,9 @@ static struct iommu_domain *arm_smmu_domain_alloc_paging(struct device *dev)
 	 * We can't really do anything meaningful until we've added a
 	 * master.
 	 */
-	smmu_domain = kzalloc(sizeof(*smmu_domain), GFP_KERNEL);
-	if (!smmu_domain)
-		return ERR_PTR(-ENOMEM);
-
-	mutex_init(&smmu_domain->init_mutex);
-	INIT_LIST_HEAD(&smmu_domain->devices);
-	spin_lock_init(&smmu_domain->devices_lock);
-	INIT_LIST_HEAD(&smmu_domain->mmu_notifiers);
+	smmu_domain = arm_smmu_domain_alloc_common();
+	if (IS_ERR(smmu_domain))
+		return ERR_CAST(smmu_domain);
 
 	if (dev) {
 		struct arm_smmu_master *master = dev_iommu_priv_get(dev);
@@ -2276,7 +2287,7 @@ static struct iommu_domain *arm_smmu_domain_alloc_paging(struct device *dev)
 	return &smmu_domain->domain;
 }
 
-static void arm_smmu_domain_free(struct iommu_domain *domain)
+static void arm_smmu_domain_free_paging(struct iommu_domain *domain)
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
@@ -3119,7 +3130,7 @@ static struct iommu_ops arm_smmu_ops = {
 		.iotlb_sync		= arm_smmu_iotlb_sync,
 		.iova_to_phys		= arm_smmu_iova_to_phys,
 		.enable_nesting		= arm_smmu_enable_nesting,
-		.free			= arm_smmu_domain_free,
+		.free			= arm_smmu_domain_free_paging,
 	}
 };
 
-- 
2.34.1

