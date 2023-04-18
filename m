Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F3B10E5
	for <iommu@lists.linux.dev>; Tue, 18 Apr 2023 06:45:33 +0000 (UTC)
Received: from dggpemm500006.china.huawei.com (unknown [7.185.36.236])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Q0v3L71zVzSsW8;
	Tue, 18 Apr 2023 14:22:22 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 18 Apr 2023 14:26:27 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Will
 Deacon <will@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH] iommu/iova: Optimize iova_magazine_alloc()
Date: Tue, 18 Apr 2023 14:25:18 +0800
Message-ID: <20230418062518.852-1-thunder.leizhen@huawei.com>
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
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)

Only the member 'size' needs to be initialized to 0. Clearing the array
pfns[], which is about 1 KiB in size, not only wastes time, but also
causes cache pollution.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/iova.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index fe452ce466429a7..c970b9a2819d7bb 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -647,7 +647,13 @@ struct iova_rcache {
 
 static struct iova_magazine *iova_magazine_alloc(gfp_t flags)
 {
-	return kzalloc(sizeof(struct iova_magazine), flags);
+	struct iova_magazine *mag;
+
+	mag = kmalloc(sizeof(struct iova_magazine), flags);
+	if (mag)
+		mag->size = 0;
+
+	return mag;
 }
 
 static void iova_magazine_free(struct iova_magazine *mag)
-- 
2.25.1

