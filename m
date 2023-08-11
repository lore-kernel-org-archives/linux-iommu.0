Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774D7A46
	for <iommu@lists.linux.dev>; Fri, 11 Aug 2023 13:11:10 +0000 (UTC)
Received: from kwepemi500019.china.huawei.com (unknown [172.30.72.54])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RMkcb0k0TzqSg0;
	Fri, 11 Aug 2023 21:08:15 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500019.china.huawei.com
 (7.221.188.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 21:11:06 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<baolu.lu@linux.intel.com>, <robh@kernel.org>, <nicolinc@nvidia.com>,
	<john.g.garry@oracle.com>, <kevin.tian@intel.com>
Subject: [RESEND PATCH 1/2] iommu/iova: Add check for cpu_rcache in free_iova_rcaches
Date: Fri, 11 Aug 2023 21:02:45 +0800
Message-ID: <20230811130246.42719-2-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230811130246.42719-1-zhangzekun11@huawei.com>
References: <20230811130246.42719-1-zhangzekun11@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500019.china.huawei.com (7.221.188.117)
X-CFilter-Loop: Reflected

free_iova_rcaches() needs to check if cpu_rcache->loaded and
cpu_rcache->prev is NULL before freeing them. Because
iova_domain_init_rcaches() may fail to alloc magazine for
cpu_rcache->loaded and cpu_rcache->prev, but they will be freed
for all cpus.

Fixes: 32e92d9f6f87 ("iommu/iova: Separate out rcache init")
Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
 drivers/iommu/iova.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 10b964600948..3c784a28e9ed 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -746,8 +746,12 @@ int iova_domain_init_rcaches(struct iova_domain *iovad)
 
 			spin_lock_init(&cpu_rcache->lock);
 			cpu_rcache->loaded = iova_magazine_alloc(GFP_KERNEL);
+			if (!cpu_rcache->loaded) {
+				ret = -ENOMEM;
+				goto out_err;
+			}
 			cpu_rcache->prev = iova_magazine_alloc(GFP_KERNEL);
-			if (!cpu_rcache->loaded || !cpu_rcache->prev) {
+			if (!cpu_rcache->prev) {
 				ret = -ENOMEM;
 				goto out_err;
 			}
@@ -903,7 +907,11 @@ static void free_iova_rcaches(struct iova_domain *iovad)
 			break;
 		for_each_possible_cpu(cpu) {
 			cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
+			if (!cpu_rcache->loaded)
+				break;
 			iova_magazine_free(cpu_rcache->loaded);
+			if (!cpu_rcache->prev)
+				break;
 			iova_magazine_free(cpu_rcache->prev);
 		}
 		free_percpu(rcache->cpu_rcaches);
-- 
2.17.1

