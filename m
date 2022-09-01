Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F747FA
	for <iommu@lists.linux.dev>; Thu,  1 Sep 2022 01:57:22 +0000 (UTC)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.55])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MJ3z82Kx2zHnbX;
	Thu,  1 Sep 2022 09:55:32 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 1 Sep
 2022 09:57:19 +0800
From: Yuan Can <yuancan@huawei.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<iommu@lists.linux.dev>, <jacob.jun.pan@linux.intel.com>,
	<jean-philippe@linaro.com>
CC: <linux-kernel@vger.kernel.org>, <yuancan@huawei.com>
Subject: [PATCH] iommu/ioasid: Add missing new line for info message
Date: Thu, 1 Sep 2022 01:55:30 +0000
Message-ID: <20220901015530.37706-1-yuancan@huawei.com>
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

A new line in the end of the log is expected, otherwise
it will be mixed with later logs.

Signed-off-by: Yuan Can <yuancan@huawei.com>
---
 drivers/iommu/ioasid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index a786c034907c..1af51ee10175 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -234,7 +234,7 @@ void ioasid_unregister_allocator(struct ioasid_allocator_ops *ops)
 				rcu_assign_pointer(active_allocator,
 						list_first_entry(&allocators_list,
 								struct ioasid_allocator_data, list));
-				pr_info("IOASID allocator changed");
+				pr_info("IOASID allocator changed.\n");
 			}
 			kfree_rcu(pallocator, rcu);
 			break;
-- 
2.17.1

