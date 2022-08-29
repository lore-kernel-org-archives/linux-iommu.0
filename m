Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F2E23CE
	for <iommu@lists.linux.dev>; Mon, 29 Aug 2022 07:13:34 +0000 (UTC)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MGM5S26bMzlWZh;
	Mon, 29 Aug 2022 15:10:04 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 29 Aug
 2022 15:13:25 +0800
From: Yuan Can <yuancan@huawei.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<iommu@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <yuancan@huawei.com>
Subject: [PATCH] iommu: fix resource leak in iommu_group_alloc
Date: Mon, 29 Aug 2022 07:11:25 +0000
Message-ID: <20220829071125.104173-1-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected

When it fails to create file for reserved_regions and type
of an iommu_group, the iommu_group_alloc returns ERR_PTR
without releasing the iommu_group.
Add error handling to cleanup leaking resources.

Signed-off-by: Yuan Can <yuancan@huawei.com>
---
 drivers/iommu/iommu.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 1ca59afc8472..fff23231b5fc 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -675,15 +675,22 @@ struct iommu_group *iommu_group_alloc(void)
 	ret = iommu_group_create_file(group,
 				      &iommu_group_attr_reserved_regions);
 	if (ret)
-		return ERR_PTR(ret);
+		goto out_put_group;
 
 	ret = iommu_group_create_file(group, &iommu_group_attr_type);
 	if (ret)
-		return ERR_PTR(ret);
+		goto out_remove_file;
 
 	pr_debug("Allocated group %d\n", group->id);
 
 	return group;
+
+out_remove_file:
+	iommu_group_remove_file(group, &iommu_group_attr_reserved_regions);
+out_put_group:
+	iommu_group_put(group);
+
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(iommu_group_alloc);
 
-- 
2.17.1

