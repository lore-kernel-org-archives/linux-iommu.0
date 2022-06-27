Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED97B2100
	for <iommu@lists.linux.dev>; Mon, 27 Jun 2022 09:03:19 +0000 (UTC)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LWh9H1MqMzkWnN;
	Mon, 27 Jun 2022 16:44:19 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 27 Jun 2022 16:45:36 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 27 Jun
 2022 16:45:36 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<iommu@lists.linux-foundation.org>
CC: <joro@8bytes.org>, <will@kernel.org>, <yf.wang@mediatek.com>
Subject: [PATCH -next] iommu/dma: Fix missing mutex_init() in iommu_get_msi_cookie()
Date: Mon, 27 Jun 2022 16:55:33 +0800
Message-ID: <20220627085533.1469141-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Message-ID: <20220627085533.DNKE9VbllCSfxEIYU-45xJgeMd5AS2QZkHuhBy7v3p4@z>

cookie_alloc() is called by iommu_get_dma_cookie() and iommu_get_msi_cookie(),
but the mutex is only initialized in iommu_get_dma_cookie(), move mutex_init()
into cookie_alloc() to make sure the mutex will be initialized.

Fixes: ac9a5d522bb8 ("iommu/dma: Fix race condition during iova_domain initialization")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/iommu/dma-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 1910f4f1612b..e29157380c48 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -294,6 +294,7 @@ static struct iommu_dma_cookie *cookie_alloc(enum iommu_dma_cookie_type type)
 	if (cookie) {
 		INIT_LIST_HEAD(&cookie->msi_page_list);
 		cookie->type = type;
+		mutex_init(&cookie->mutex);
 	}
 	return cookie;
 }
@@ -311,7 +312,6 @@ int iommu_get_dma_cookie(struct iommu_domain *domain)
 	if (!domain->iova_cookie)
 		return -ENOMEM;
 
-	mutex_init(&domain->iova_cookie->mutex);
 	return 0;
 }
 
-- 
2.25.1

