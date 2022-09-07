Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C5653BA
	for <iommu@lists.linux.dev>; Wed,  7 Sep 2022 13:09:26 +0000 (UTC)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.201])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MN2d45H9fz6H72S;
	Wed,  7 Sep 2022 21:08:40 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Wed, 7 Sep 2022 15:09:24 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 14:09:22 +0100
From: John Garry <john.garry@huawei.com>
To: <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jsnitsel@redhat.com>, <haifeng.zhao@linux.intel.com>,
	John Garry <john.garry@huawei.com>
Subject: [PATCH v3 3/3] iova: Remove iovad->rcaches check in iova_rcache_get()
Date: Wed, 7 Sep 2022 21:02:34 +0800
Message-ID: <1662555754-142760-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1662555754-142760-1-git-send-email-john.garry@huawei.com>
References: <1662555754-142760-1-git-send-email-john.garry@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected

The iovad->rcaches check in iova_rcache_get() is pretty much useless
without the same check in iova_rcache_insert().

Instead of adding this symmetric check to fathpath iova_rcache_insert(),
drop the check in iova_rcache_get() in favour of making the IOVA domain
rcache init more robust to failure in future.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/iova.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 8aece052ce72..a44ad92fc5eb 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -875,7 +875,7 @@ static unsigned long iova_rcache_get(struct iova_domain *iovad,
 {
 	unsigned int log_size = order_base_2(size);
 
-	if (log_size >= IOVA_RANGE_CACHE_MAX_SIZE || !iovad->rcaches)
+	if (log_size >= IOVA_RANGE_CACHE_MAX_SIZE)
 		return 0;
 
 	return __iova_rcache_get(&iovad->rcaches[log_size], limit_pfn - size);
-- 
2.25.1

