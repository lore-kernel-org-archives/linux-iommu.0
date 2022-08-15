Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463187E
	for <iommu@lists.linux.dev>; Mon, 15 Aug 2022 01:36:29 +0000 (UTC)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M5cHM38y9zlVwH;
	Mon, 15 Aug 2022 09:33:19 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 15 Aug
 2022 09:36:19 +0800
From: Yuan Can <yuancan@huawei.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<iommu@lists.linux.dev>, <baolu.lu@linux.intel.com>, <jroedel@suse.de>,
	<hch@lst.de>
Subject: [PATCH -next] iommu: remove comment of dev_has_feat in struct doc
Date: Mon, 15 Aug 2022 01:33:39 +0000
Message-ID: <20220815013339.2552-1-yuancan@huawei.com>
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

dev_has_feat has been removed from iommu_ops in commit
309c56e84602 ("iommu: remove the unused dev_has_feat method"),
remove its description in the struct doc.

Signed-off-by: Yuan Can <yuancan@huawei.com>
---
 include/linux/iommu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ea30f00dc145..a004e87e0e1d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -212,7 +212,7 @@ struct iommu_iotlb_gather {
  * @of_xlate: add OF master IDs to iommu grouping
  * @is_attach_deferred: Check if domain attach should be deferred from iommu
  *                      driver init to device driver init (default no)
- * @dev_has/enable/disable_feat: per device entries to check/enable/disable
+ * @dev_enable/disable_feat: per device entries to enable/disable
  *                               iommu specific features.
  * @sva_bind: Bind process address space to device
  * @sva_unbind: Unbind process address space from device
-- 
2.17.1

