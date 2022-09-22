Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8575E23D9
	for <iommu@lists.linux.dev>; Thu, 22 Sep 2022 08:12:12 +0000 (UTC)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MY7DT3x7mzMnDv;
	Thu, 22 Sep 2022 16:07:21 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 22 Sep
 2022 16:12:03 +0800
From: Yuan Can <yuancan@huawei.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<iommu@lists.linux.dev>
CC: <yuancan@huawei.com>
Subject: [PATCH v2 2/3] iommu: fix resource leak in iommu_group_alloc
Date: Thu, 22 Sep 2022 08:09:34 +0000
Message-ID: <20220922080935.21454-3-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220922080935.21454-1-yuancan@huawei.com>
References: <20220922080935.21454-1-yuancan@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected

When it fails to create file for reserved_regions and type of an iommu_group,
the iommu_group_alloc returns ERR_PTR without releasing the iommu_group.
Add error handling to cleanup leaking resources.

Signed-off-by: Yuan Can <yuancan@huawei.com>
---
 drivers/iommu/iommu.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 34c16f6f44b2..698512580c6a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -734,15 +734,22 @@ struct iommu_group *iommu_group_alloc(void)
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

