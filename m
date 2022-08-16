Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5641851
	for <iommu@lists.linux.dev>; Tue, 16 Aug 2022 02:28:25 +0000 (UTC)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M6F0P6wV1zmVlt;
	Tue, 16 Aug 2022 10:07:33 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 16 Aug
 2022 10:09:43 +0800
From: Yuan Can <yuancan@huawei.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<iommu@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <yuancan@huawei.com>
Subject: [PATCH -next] iommu: return early when devices in a group require different domain type
Date: Tue, 16 Aug 2022 02:07:01 +0000
Message-ID: <20220816020701.90533-1-yuancan@huawei.com>
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

When alloc default domain for an iommu_group in
probe_alloc_default_domain, the expected domain
type of each device in the iommu_group is checked
in a loop, if two devices require different types,
the loop can be breaked since the default domain
will be set to iommu_def_domain_type.
Return 1 when this happened to break the loop in
__iommu_group_for_each_dev.

Signed-off-by: Yuan Can <yuancan@huawei.com>
---
 drivers/iommu/iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 74bc9111c7be..0d4d78946d31 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1653,6 +1653,7 @@ static int probe_get_default_domain_type(struct device *dev, void *data)
 				 dev_name(gtype->dev),
 				 iommu_domain_type_str(gtype->type));
 			gtype->type = 0;
+			return 1; /* end the outer loop */
 		}
 
 		if (!gtype->dev) {
-- 
2.17.1

