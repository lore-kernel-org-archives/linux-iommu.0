Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0DA17F8
	for <iommu@lists.linux.dev>; Fri, 21 Apr 2023 07:27:15 +0000 (UTC)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Q2mJs40vYzsSv8;
	Fri, 21 Apr 2023 15:25:33 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 15:27:05 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Will
 Deacon <will@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2] iommu/iova: Optimize iova_magazine_alloc()
Date: Fri, 21 Apr 2023 15:24:21 +0800
Message-ID: <20230421072422.869-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected

Only the member 'size' needs to be initialized to 0. Clearing the array
pfns[], which is about 1 KiB in size, not only wastes time, but also
causes cache pollution.

Acked-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/iova.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

v1 --> v2:
Change sizeof(struct iova_magazine) to sizeof(*mag).

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index fe452ce466429a7..10b964600948c7f 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -647,7 +647,13 @@ struct iova_rcache {
 
 static struct iova_magazine *iova_magazine_alloc(gfp_t flags)
 {
-	return kzalloc(sizeof(struct iova_magazine), flags);
+	struct iova_magazine *mag;
+
+	mag = kmalloc(sizeof(*mag), flags);
+	if (mag)
+		mag->size = 0;
+
+	return mag;
 }
 
 static void iova_magazine_free(struct iova_magazine *mag)
-- 
2.25.1

