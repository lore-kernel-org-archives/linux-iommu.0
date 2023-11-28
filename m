Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915DD4AF76
	for <iommu@lists.linux.dev>; Tue, 28 Nov 2023 09:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Sfcz708twz67bpd;
	Tue, 28 Nov 2023 17:46:11 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 8975C140135;
	Tue, 28 Nov 2023 17:50:42 +0800 (CST)
Received: from A2006125610.china.huawei.com (10.202.227.178) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 28 Nov 2023 09:50:35 +0000
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>
CC: <robin.murphy@arm.com>, <will@kernel.org>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<mshavit@google.com>, <eric.auger@redhat.com>, <joao.m.martins@oracle.com>,
	<jiangkunkun@huawei.com>, <zhukeqian1@huawei.com>, <linuxarm@huawei.com>
Subject: [PATCH 4/5] iommu/arm-smmu-v3: Add set_dirty_tracking() support
Date: Tue, 28 Nov 2023 09:49:39 +0000
Message-ID: <20231128094940.1344-5-shameerali.kolothum.thodi@huawei.com>
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

Dirty tracking will always be enabled with DBM=1 modifier enabled
by default when HD is supported.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 22 +++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 8331a2c70a0c..c5eabdc29ba5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3402,6 +3402,27 @@ static int arm_smmu_read_and_clear_dirty(struct iommu_domain *domain,
 	return ret;
 }
 
+static int arm_smmu_set_dirty_tracking(struct iommu_domain *domain,
+				       bool enabled)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
+
+	if (smmu_domain->stage != ARM_SMMU_DOMAIN_S1)
+		return -EINVAL;
+
+	if (!ops) {
+		pr_err_once("io-pgtable don't support dirty tracking\n");
+		return -ENODEV;
+	}
+
+	/*
+	 * Always enabled and the dirty bitmap is cleared prior to
+	 * set_dirty_tracking().
+	 */
+	return 0;
+}
+
 static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
 {
 	return iommu_fwspec_add_ids(dev, args->args, 1);
@@ -3529,6 +3550,7 @@ static struct iommu_ops arm_smmu_ops = {
 
 static struct iommu_dirty_ops arm_smmu_dirty_ops = {
 	.read_and_clear_dirty	= arm_smmu_read_and_clear_dirty,
+	.set_dirty_tracking     = arm_smmu_set_dirty_tracking,
 };
 
 /* Probing and initialisation functions */
-- 
2.34.1

