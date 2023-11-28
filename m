Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6FF101D1
	for <iommu@lists.linux.dev>; Tue, 28 Nov 2023 09:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Sfd4D2Y9jz6JB75;
	Tue, 28 Nov 2023 17:50:36 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id A77DD1400C9;
	Tue, 28 Nov 2023 17:50:52 +0800 (CST)
Received: from A2006125610.china.huawei.com (10.202.227.178) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 28 Nov 2023 09:50:45 +0000
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>
CC: <robin.murphy@arm.com>, <will@kernel.org>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<mshavit@google.com>, <eric.auger@redhat.com>, <joao.m.martins@oracle.com>,
	<jiangkunkun@huawei.com>, <zhukeqian1@huawei.com>, <linuxarm@huawei.com>
Subject: [PATCH 5/5] iommu/arm-smmu-v3: Enforce dirty tracking in domain attach/alloc
Date: Tue, 28 Nov 2023 09:49:40 +0000
Message-ID: <20231128094940.1344-6-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20231128094940.1344-1-shameerali.kolothum.thodi@huawei.com>
References: <20231128094940.1344-1-shameerali.kolothum.thodi@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

From: Joao Martins <joao.m.martins@oracle.com>

SMMUv3 implements all requirements of revoking device
attachment if smmu does not support dirty tracking.

Finally handle the IOMMU_CAP_DIRTY in iommu_capable for
IOMMUFD_DEVICE_GET_HW_INFO.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 22 ++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index c5eabdc29ba5..2c100f2136bc 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2244,6 +2244,8 @@ static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
 	case IOMMU_CAP_NOEXEC:
 	case IOMMU_CAP_DEFERRED_FLUSH:
 		return true;
+	case IOMMU_CAP_DIRTY_TRACKING:
+		return arm_smmu_dbm_capable(master->smmu);
 	default:
 		return false;
 	}
@@ -2701,6 +2703,9 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	master = dev_iommu_priv_get(dev);
 	smmu = master->smmu;
 
+	if (domain->dirty_ops && !arm_smmu_dbm_capable(smmu))
+		return -EINVAL;
+
 	mutex_lock(&smmu_domain->init_mutex);
 
 	if (!smmu_domain->smmu) {
@@ -3077,7 +3082,9 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
 			   const struct iommu_user_data *user_data)
 {
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
-	const u32 paging_flags = IOMMU_HWPT_ALLOC_NEST_PARENT;
+	const u32 paging_flags = IOMMU_HWPT_ALLOC_NEST_PARENT |
+				 IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
+	bool enforce_dirty = flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
 	struct arm_smmu_domain *smmu_domain;
 	int ret;
 
@@ -3090,6 +3097,10 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
 	if (user_data)
 		return ERR_PTR(-EINVAL);
 
+	if (enforce_dirty &&
+	    !device_iommu_capable(dev, IOMMU_CAP_DIRTY_TRACKING))
+		return ERR_PTR(-EOPNOTSUPP);
+
 	smmu_domain = arm_smmu_domain_alloc();
 	if (!smmu_domain)
 		return ERR_PTR(-ENOMEM);
@@ -3104,6 +3115,9 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
 
 	smmu_domain->domain.type = IOMMU_DOMAIN_UNMANAGED;
 	smmu_domain->domain.ops = arm_smmu_ops.default_domain_ops;
+	if (enforce_dirty)
+		smmu_domain->domain.dirty_ops = &arm_smmu_dirty_ops;
+
 	ret = arm_smmu_domain_finalise(smmu_domain, master->smmu);
 	if (ret)
 		goto err_free;
@@ -4152,11 +4166,13 @@ static void arm_smmu_get_httu(struct arm_smmu_device *smmu, u32 reg)
 
 	if (smmu->dev->of_node)
 		smmu->features |= features;
-	else if (features != fw_features)
+	else if (features != fw_features) {
 		/* ACPI IORT sets the HTTU bits */
 		dev_warn(smmu->dev,
-			 "IDR0.HTTU overridden by FW configuration (0x%x)\n",
+			 "IDR0.HTTU not overridden by FW configuration (0x%x)\n",
 			 fw_features);
+		smmu->features |= features;
+	}
 }
 
 static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
-- 
2.34.1

