Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3CF182A2
	for <iommu@lists.linux.dev>; Mon, 31 Jul 2023 11:28:36 +0000 (UTC)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RDwrj0NWQztRjH;
	Mon, 31 Jul 2023 19:25:09 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.202) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 19:28:28 +0800
From: Zhu Wang <wangzhu9@huawei.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<iommu@lists.linux.dev>
CC: <wangzhu9@huawei.com>
Subject: [PATCH -next] iommu: remove kernel-doc warnings
Date: Mon, 31 Jul 2023 19:27:58 +0800
Message-ID: <20230731112758.214775-1-wangzhu9@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.202]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected

Remove kernel-doc warnings:

drivers/iommu/iommu.c:3261: warning: Function parameter or member 'group'
not described in 'iommu_group_release_dma_owner'
drivers/iommu/iommu.c:3261: warning: Excess function parameter 'dev'
description in 'iommu_group_release_dma_owner'
drivers/iommu/iommu.c:3275: warning: Function parameter or member 'dev'
not described in 'iommu_device_release_dma_owner'
drivers/iommu/iommu.c:3275: warning: Excess function parameter 'group'
description in 'iommu_device_release_dma_owner'

Signed-off-by: Zhu Wang <wangzhu9@huawei.com>
---
 drivers/iommu/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 89195abc1444..145dbc8051ec 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3253,7 +3253,7 @@ static void __iommu_release_dma_ownership(struct iommu_group *group)
 
 /**
  * iommu_group_release_dma_owner() - Release DMA ownership of a group
- * @dev: The device
+ * @group: The group
  *
  * Release the DMA ownership claimed by iommu_group_claim_dma_owner().
  */
@@ -3267,7 +3267,7 @@ EXPORT_SYMBOL_GPL(iommu_group_release_dma_owner);
 
 /**
  * iommu_device_release_dma_owner() - Release DMA ownership of a device
- * @group: The device.
+ * @dev: The device.
  *
  * Release the DMA ownership claimed by iommu_device_claim_dma_owner().
  */
-- 
2.17.1

