Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83586CDBA
	for <iommu@lists.linux.dev>; Tue, 28 May 2024 07:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716880795; cv=none; b=U1MJVyEBsC12ddH+Dq+sAk+mp+qdNwE361PJSCiuPyWSHy92qBwQuXUla+nPBqzZkDInwRr5XD0MWrbTDKznyPEWO2axPOcI6ERQ6PP5LByMJ6GX53hzghxYOFSohqAoGmz7MtaQJZHFJgLlxat2S+VTnqWpYBdwRFxzirO7HUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716880795; c=relaxed/simple;
	bh=wdWR/vg+vnh3Vgw8i3ElkmEryMROe7As9Gf8gNk9fzo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=se16rxiLL97PdVsA/CYAVESNAd2utCwi2oK7boF1s7Gj+sKNMy8EAwolzmpETen5jf+LcJHqQKoNJ4iehVs6d96vH5JmlMbos0PpvBdEu7eRYwAxh5h7+FW/4mIsWXg5id+oMd29iuIOBQBTZ1jwkDXDqM85PxRd8TxGhG+qZ98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VpP5849ZWz6K9BQ;
	Tue, 28 May 2024 15:18:52 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 726E1140A78;
	Tue, 28 May 2024 15:19:51 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.126.170.13) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 28 May 2024 08:19:41 +0100
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>
CC: <robin.murphy@arm.com>, <will@kernel.org>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <ryan.roberts@arm.com>, <kevin.tian@intel.com>,
	<nicolinc@nvidia.com>, <mshavit@google.com>, <eric.auger@redhat.com>,
	<joao.m.martins@oracle.com>, <jiangkunkun@huawei.com>,
	<zhukeqian1@huawei.com>, <linuxarm@huawei.com>
Subject: [PATCH v4 2/7] iommu/arm-smmu-v3: Factor out a common arm_smmu_domain_alloc()
Date: Tue, 28 May 2024 08:18:26 +0100
Message-ID: <20240528071831.17560-3-shameerali.kolothum.thodi@huawei.com>
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

And use that for arm_smmu_domain_alloc_paging() and
arm_smmu_sva_domain_alloc()

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 19 +++++++------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 27 +++++++++++++------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  2 ++
 3 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 28f8bf4327f6..70c95887757f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -648,7 +648,7 @@ static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
 
 static void arm_smmu_sva_domain_free(struct iommu_domain *domain)
 {
-	kfree(domain);
+	kfree(to_smmu_domain(domain));
 }
 
 static const struct iommu_domain_ops arm_smmu_sva_domain_ops = {
@@ -659,13 +659,16 @@ static const struct iommu_domain_ops arm_smmu_sva_domain_ops = {
 struct iommu_domain *arm_smmu_sva_domain_alloc(struct device *dev,
 					       struct mm_struct *mm)
 {
-	struct iommu_domain *domain;
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct arm_smmu_device *smmu = master->smmu;
+	struct arm_smmu_domain *smmu_domain;
 
-	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
-	if (!domain)
-		return ERR_PTR(-ENOMEM);
-	domain->type = IOMMU_DOMAIN_SVA;
-	domain->ops = &arm_smmu_sva_domain_ops;
+	smmu_domain = arm_smmu_domain_alloc();
+	if (IS_ERR(smmu_domain))
+		return ERR_CAST(smmu_domain);
+	smmu_domain->domain.type = IOMMU_DOMAIN_SVA;
+	smmu_domain->domain.ops = &arm_smmu_sva_domain_ops;
+	smmu_domain->smmu = smmu;
 
-	return domain;
+	return &smmu_domain->domain;
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index bd79422f7b6f..b574a36a7b95 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2237,15 +2237,10 @@ static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
 	}
 }
 
-static struct iommu_domain *arm_smmu_domain_alloc_paging(struct device *dev)
+struct arm_smmu_domain *arm_smmu_domain_alloc(void)
 {
 	struct arm_smmu_domain *smmu_domain;
 
-	/*
-	 * Allocate the domain and initialise some of its data structures.
-	 * We can't really do anything meaningful until we've added a
-	 * master.
-	 */
 	smmu_domain = kzalloc(sizeof(*smmu_domain), GFP_KERNEL);
 	if (!smmu_domain)
 		return ERR_PTR(-ENOMEM);
@@ -2255,6 +2250,22 @@ static struct iommu_domain *arm_smmu_domain_alloc_paging(struct device *dev)
 	spin_lock_init(&smmu_domain->devices_lock);
 	INIT_LIST_HEAD(&smmu_domain->mmu_notifiers);
 
+	return smmu_domain;
+}
+
+static struct iommu_domain *arm_smmu_domain_alloc_paging(struct device *dev)
+{
+	struct arm_smmu_domain *smmu_domain;
+
+	/*
+	 * Allocate the domain and initialise some of its data structures.
+	 * We can't really do anything meaningful until we've added a
+	 * master.
+	 */
+	smmu_domain = arm_smmu_domain_alloc();
+	if (IS_ERR(smmu_domain))
+		return ERR_CAST(smmu_domain);
+
 	if (dev) {
 		struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 		int ret;
@@ -2268,7 +2279,7 @@ static struct iommu_domain *arm_smmu_domain_alloc_paging(struct device *dev)
 	return &smmu_domain->domain;
 }
 
-static void arm_smmu_domain_free(struct iommu_domain *domain)
+static void arm_smmu_domain_free_paging(struct iommu_domain *domain)
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
@@ -3111,7 +3122,7 @@ static struct iommu_ops arm_smmu_ops = {
 		.iotlb_sync		= arm_smmu_iotlb_sync,
 		.iova_to_phys		= arm_smmu_iova_to_phys,
 		.enable_nesting		= arm_smmu_enable_nesting,
-		.free			= arm_smmu_domain_free,
+		.free			= arm_smmu_domain_free_paging,
 	}
 };
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 4c6c843669aa..e67ce0f8867f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -774,6 +774,8 @@ static inline struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
 extern struct xarray arm_smmu_asid_xa;
 extern struct mutex arm_smmu_asid_lock;
 
+struct arm_smmu_domain *arm_smmu_domain_alloc(void);
+
 void arm_smmu_clear_cd(struct arm_smmu_master *master, ioasid_t ssid);
 struct arm_smmu_cd *arm_smmu_get_cd_ptr(struct arm_smmu_master *master,
 					u32 ssid);
-- 
2.34.1

