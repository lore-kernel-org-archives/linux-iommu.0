Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022857E
	for <iommu@lists.linux.dev>; Tue,  1 Aug 2023 01:18:59 +0000 (UTC)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.57])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RFHKX32Hwz1GDQB;
	Tue,  1 Aug 2023 09:17:52 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.202) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 09:18:52 +0800
From: Zhu Wang <wangzhu9@huawei.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<kevin.tian@intel.com>, <eric.auger@redhat.com>, <baolu.lu@linux.intel.com>,
	<jgg@ziepe.ca>, <iommu@lists.linux.dev>
CC: <wangzhu9@huawei.com>
Subject: [PATCH -next v2] iommu: fix kernel-doc warnings
Date: Tue, 1 Aug 2023 09:18:22 +0800
Message-ID: <20230801011822.246158-1-wangzhu9@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.202]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected

Fix kernel-doc warnings:

drivers/iommu/iommu.c:3261: warning: Function parameter or member 'group'
not described in 'iommu_group_release_dma_owner'
drivers/iommu/iommu.c:3261: warning: Excess function parameter 'dev'
description in 'iommu_group_release_dma_owner'
drivers/iommu/iommu.c:3275: warning: Function parameter or member 'dev'
not described in 'iommu_device_release_dma_owner'
drivers/iommu/iommu.c:3275: warning: Excess function parameter 'group'
description in 'iommu_device_release_dma_owner'

Fixes: 89395ccedbc1 ("iommu: Add device-centric DMA ownership interfaces")
Signed-off-by: Zhu Wang <wangzhu9@huawei.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

---
Changes in v2
- Add fix tag.
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

