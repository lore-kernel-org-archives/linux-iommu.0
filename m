Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E7310EA
	for <iommu@lists.linux.dev>; Mon, 15 Aug 2022 03:34:01 +0000 (UTC)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.57])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4M5fYK5t3QzGpVy;
	Mon, 15 Aug 2022 11:15:33 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 15 Aug
 2022 11:17:03 +0800
From: Yuan Can <yuancan@huawei.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<iommu@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <yuancan@huawei.com>
Subject: [PATCH -next] iommu: Remove duplicate ida_free in iommu_group_alloc
Date: Mon, 15 Aug 2022 03:14:23 +0000
Message-ID: <20220815031423.94548-1-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected

In the iommu_group_alloc, when the kobject_init_and_add
failed, the group->kobj is associate with iommu_group_ktype,
thus its release function iommu_group_release will be called
by the following kobject_put. The iommu_group_release calls
ida_free with the group->id, so we do not need to do it before
kobject_put.

Signed-off-by: Yuan Can <yuancan@huawei.com>
---
 drivers/iommu/iommu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 780fb7071577..74bc9111c7be 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -654,7 +654,6 @@ struct iommu_group *iommu_group_alloc(void)
 	ret = kobject_init_and_add(&group->kobj, &iommu_group_ktype,
 				   NULL, "%d", group->id);
 	if (ret) {
-		ida_free(&iommu_group_ida, group->id);
 		kobject_put(&group->kobj);
 		return ERR_PTR(ret);
 	}
-- 
2.17.1

