Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18956399
	for <iommu@lists.linux.dev>; Thu, 13 Jun 2024 14:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718289772; cv=none; b=l2yvnCvMqhi6U55LNj8DGXyYbe3L94DvwjK3HxdQE9frW8D+KIJGPOvMVi+0e31RAWelzwfSgJoKS0vhg4L55IZgouFrV+f/X3Cu/txn4V0xAfN5hZf0Tt3QQYQv7QKxdZasLVSP95UlRdfJgvsZ8zNZpPJP9e/+14NdDDUVFs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718289772; c=relaxed/simple;
	bh=SFYduKNPCe6WdG4YxgKSthr3iAvb8KIs/mLGSJvx0pU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W1XpD6k5Bz+pCv+w8FxDtQ46TUaN6b37CUjG4WaHZjHXQxEiNbyIC2Lj7l/ZG1q6rQy1S/5zzb4sj22rvK9KCVC2rCnoILIVsHTVBqxd/bKM1EMgATqJYlw/hx+mWjtOkJwZaBkLnSqTm9yRUefzisGvaQ29vneCweTtMKd/lJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W0Q9x3k56z6K5x0;
	Thu, 13 Jun 2024 22:42:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 283BC140B55;
	Thu, 13 Jun 2024 22:42:47 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.202.227.28) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 15:42:38 +0100
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>
CC: <robin.murphy@arm.com>, <will@kernel.org>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <ryan.roberts@arm.com>, <mark.rutland@arm.com>,
	<kevin.tian@intel.com>, <nicolinc@nvidia.com>, <mshavit@google.com>,
	<eric.auger@redhat.com>, <joao.m.martins@oracle.com>,
	<jiangkunkun@huawei.com>, <zhukeqian1@huawei.com>, <linuxarm@huawei.com>
Subject: [PATCH v6 2/6] iommu/arm-smmu-v3: Add support for domain_alloc_user fn
Date: Thu, 13 Jun 2024 15:41:45 +0100
Message-ID: <20240613144149.38672-3-shameerali.kolothum.thodi@huawei.com>
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

This will be used by iommufd for allocating usr managed domains and is
also required when we add support for iommufd based dirty tracking
support.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 33 +++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index c296435896f7..e30ce55ed1af 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -36,6 +36,8 @@ module_param(disable_msipolling, bool, 0444);
 MODULE_PARM_DESC(disable_msipolling,
 	"Disable MSI-based polling for CMD_SYNC completion.");
 
+static struct iommu_ops arm_smmu_ops;
+
 enum arm_smmu_msi_index {
 	EVTQ_MSI_INDEX,
 	GERROR_MSI_INDEX,
@@ -2723,6 +2725,34 @@ static struct iommu_domain arm_smmu_blocked_domain = {
 	.ops = &arm_smmu_blocked_ops,
 };
 
+static struct iommu_domain *
+arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
+			   struct iommu_domain *parent,
+			   const struct iommu_user_data *user_data)
+{
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct arm_smmu_domain *smmu_domain;
+	int ret;
+
+	if (flags || parent || user_data)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	smmu_domain = arm_smmu_domain_alloc_common();
+	if (!smmu_domain)
+		return ERR_PTR(-ENOMEM);
+
+	smmu_domain->domain.type = IOMMU_DOMAIN_UNMANAGED;
+	smmu_domain->domain.ops = arm_smmu_ops.default_domain_ops;
+	ret = arm_smmu_domain_finalise(smmu_domain, master->smmu);
+	if (ret)
+		goto err_free;
+	return &smmu_domain->domain;
+
+err_free:
+	kfree(smmu_domain);
+	return ERR_PTR(ret);
+}
+
 static int arm_smmu_map_pages(struct iommu_domain *domain, unsigned long iova,
 			      phys_addr_t paddr, size_t pgsize, size_t pgcount,
 			      int prot, gfp_t gfp, size_t *mapped)
@@ -2893,8 +2923,6 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
 	kfree(master->streams);
 }
 
-static struct iommu_ops arm_smmu_ops;
-
 static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 {
 	int ret;
@@ -3108,6 +3136,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.identity_domain	= &arm_smmu_identity_domain,
 	.blocked_domain		= &arm_smmu_blocked_domain,
 	.capable		= arm_smmu_capable,
+	.domain_alloc_user	= arm_smmu_domain_alloc_user,
 	.domain_alloc		= arm_smmu_domain_alloc,
 	.domain_alloc_paging    = arm_smmu_domain_alloc_paging,
 	.probe_device		= arm_smmu_probe_device,
-- 
2.34.1

