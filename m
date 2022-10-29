Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B5115AF
	for <iommu@lists.linux.dev>; Sat, 29 Oct 2022 10:36:56 +0000 (UTC)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MzwnX6mxJzHvMP;
	Sat, 29 Oct 2022 18:36:32 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 29 Oct 2022 18:36:48 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 29 Oct
 2022 18:36:47 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <iommu@lists.linux.dev>, <linux-mediatek@lists.infradead.org>
CC: <yong.wu@mediatek.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <matthias.bgg@gmail.com>, <yangyingliang@huawei.com>
Subject: [PATCH] iommu/mediatek: check return value after calling platform_get_resource()
Date: Sat, 29 Oct 2022 18:35:50 +0800
Message-ID: <20221029103550.3774365-1-yangyingliang@huawei.com>
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
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected

platform_get_resource() may return NULL pointer, we need check its
return value to avoid null-ptr-deref in resource_size().

Fixes: 42d57fc58aeb ("iommu/mediatek: Initialise/Remove for multi bank dev")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/iommu/mtk_iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 2ab2ecfe01f8..2d14dc846b83 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1173,6 +1173,8 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 
 	banks_num = data->plat_data->banks_num;
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
 	if (resource_size(res) < banks_num * MTK_IOMMU_BANK_SZ) {
 		dev_err(dev, "banknr %d. res %pR is not enough.\n", banks_num, res);
 		return -EINVAL;
-- 
2.25.1

