Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B84C1FCC
	for <iommu@lists.linux.dev>; Fri, 26 Aug 2022 02:59:20 +0000 (UTC)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.54])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MDPBv02WFzYcpM;
	Fri, 26 Aug 2022 10:37:59 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 26 Aug
 2022 10:42:17 +0800
From: Yuan Can <yuancan@huawei.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<iommu@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <yuancan@huawei.com>,
	<baolu.lu@linux.intel.com>, <haifeng.zhao@linux.intel.com>
Subject: [PATCH] iommu: use iommu_group_ref_get to hold group reference
Date: Fri, 26 Aug 2022 02:40:24 +0000
Message-ID: <20220826024024.101553-1-yuancan@huawei.com>
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

Replace kobject_get with iommu_group_ref_get for better
readability.

Signed-off-by: Yuan Can <yuancan@huawei.com>
---
 drivers/iommu/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 780fb7071577..8e7f30f7188c 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -903,7 +903,7 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 		goto err_free_name;
 	}
 
-	kobject_get(group->devices_kobj);
+	iommu_group_ref_get(group);
 
 	dev->iommu_group = group;
 
-- 
2.17.1

