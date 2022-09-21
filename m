Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F4A33D4
	for <iommu@lists.linux.dev>; Wed, 21 Sep 2022 13:28:35 +0000 (UTC)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MXfJ76bfQzMnvr;
	Wed, 21 Sep 2022 21:23:51 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 21 Sep
 2022 21:28:33 +0800
From: Yuan Can <yuancan@huawei.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<iommu@lists.linux.dev>
CC: <yuancan@huawei.com>
Subject: [PATCH RESEND 1/3] iommu: return early when devices in a group require different domain type
Date: Wed, 21 Sep 2022 13:26:05 +0000
Message-ID: <20220921132607.43820-1-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected

When alloc default domain for an iommu_group in
probe_alloc_default_domain, the expected domain type
of each device in the iommu_group is checked in a loop,
if two devices require different types, the loop can
be broken since the default domain will be set to
iommu_def_domain_type.
Return 1 when this happened to break the loop in
__iommu_group_for_each_dev.

Signed-off-by: Yuan Can <yuancan@huawei.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4893c2429ca5..34c16f6f44b2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1706,6 +1706,7 @@ static int probe_get_default_domain_type(struct device *dev, void *data)
 				 dev_name(gtype->dev),
 				 iommu_domain_type_str(gtype->type));
 			gtype->type = 0;
+			return 1; /* end the outer loop */
 		}
 
 		if (!gtype->dev) {
-- 
2.17.1

