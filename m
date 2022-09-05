Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AC73C35
	for <iommu@lists.linux.dev>; Mon,  5 Sep 2022 09:18:02 +0000 (UTC)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.201])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MLjW76yYLz689NN;
	Mon,  5 Sep 2022 17:13:55 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Sep 2022 11:17:54 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Sep 2022 10:17:51 +0100
From: John Garry <john.garry@huawei.com>
To: <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH v2 2/2] iova: Remove magazine BUG_ON() checks
Date: Mon, 5 Sep 2022 17:11:23 +0800
Message-ID: <1662369083-238529-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1662369083-238529-1-git-send-email-john.garry@huawei.com>
References: <1662369083-238529-1-git-send-email-john.garry@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected

Two of the magazine helpers have BUG_ON() checks, as follows:
- iova_magazine_pop() - here we ensure that the mag is not empty. However we
  already ensure that in the only caller, __iova_rcache_get().
- iova_magazine_push() - here we ensure that the mag is not full. However
  we already ensure that in the only caller, __iova_rcache_insert().

As described, the two bug checks are pointless so drop them.

Signed-off-by: John Garry <john.garry@huawei.com>
Acked-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iova.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 580fdf669922..8aece052ce72 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -694,8 +694,6 @@ static unsigned long iova_magazine_pop(struct iova_magazine *mag,
 	int i;
 	unsigned long pfn;
 
-	BUG_ON(iova_magazine_empty(mag));
-
 	/* Only fall back to the rbtree if we have no suitable pfns at all */
 	for (i = mag->size - 1; mag->pfns[i] > limit_pfn; i--)
 		if (i == 0)
@@ -710,8 +708,6 @@ static unsigned long iova_magazine_pop(struct iova_magazine *mag,
 
 static void iova_magazine_push(struct iova_magazine *mag, unsigned long pfn)
 {
-	BUG_ON(iova_magazine_full(mag));
-
 	mag->pfns[mag->size++] = pfn;
 }
 
-- 
2.35.3

