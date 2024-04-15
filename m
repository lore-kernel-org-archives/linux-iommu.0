Received: from njjs-sys-mailin01.njjs.baidu.com (mx309.baidu.com [180.101.52.12])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D7C2C182
	for <iommu@lists.linux.dev>; Mon, 15 Apr 2024 07:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.101.52.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713165422; cv=none; b=eCxdce2T3JD2rHx4mpRAKBe4Ydi9l6HjnnfOYYAmWN+JD5VTuNdCrVzzGQgesD7j2PxMTB60tsXG4BjEZbXlc3JZdJKmaJJ7gllfrhSUpU8qmZxePE1Lg+rIrul2/RV8rQK6GFT7J3L+x8EAYzt7xUu28XuXOS+3LGDUVv6rhVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713165422; c=relaxed/simple;
	bh=2hFmfBqp6pUbn73WdzuXin7163COF/w9ovxlX+BGZDo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=enit//XwYaFjXt0BJlhjBZFTD0cRwyfHSOfj3cF2na4SyNvkoSsjHhzOhAOQyFfHTN3kCg/gXllJ2EWktjHPZxtG+0cQRxhPY8IWtW+7avgV/QsUWW+pG1wAm+W24fg38NHU0BejT/jrKePaqJr5r9wdLTRcMDo6gF8l6x6q348=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=180.101.52.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Received: from localhost (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
	by njjs-sys-mailin01.njjs.baidu.com (Postfix) with ESMTP id 308117F00045;
	Mon, 15 Apr 2024 14:56:55 +0800 (CST)
From: Li RongQing <lirongqing@baidu.com>
To: robin.murphy@arm.com,
	joro@8bytes.org,
	will@kernel.org,
	iommu@lists.linux.dev
Cc: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] iommu/iova: Consider NUMA affinity when allocating memory for per-CPU iova_magazine
Date: Mon, 15 Apr 2024 14:56:53 +0800
Message-Id: <20240415065653.33018-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.9.4
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

per-CPU iova_magazine are dominantly accessed from their own local CPUs,
so allocate them node-local to improve performance.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/iommu/iova.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index d59d0ea..70f89ea 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -597,11 +597,11 @@ unsigned long iova_rcache_range(void)
 	return PAGE_SIZE << (IOVA_RANGE_CACHE_MAX_SIZE - 1);
 }
 
-static struct iova_magazine *iova_magazine_alloc(gfp_t flags)
+static struct iova_magazine *iova_magazine_alloc_node(gfp_t flags, int node)
 {
 	struct iova_magazine *mag;
 
-	mag = kmem_cache_alloc(iova_magazine_cache, flags);
+	mag = kmem_cache_alloc_node(iova_magazine_cache, flags, node);
 	if (mag)
 		mag->size = 0;
 
@@ -707,7 +707,7 @@ static void iova_depot_work_func(struct work_struct *work)
 int iova_domain_init_rcaches(struct iova_domain *iovad)
 {
 	unsigned int cpu;
-	int i, ret;
+	int i, ret, nid;
 
 	iovad->rcaches = kcalloc(IOVA_RANGE_CACHE_MAX_SIZE,
 				 sizeof(struct iova_rcache),
@@ -731,10 +731,11 @@ int iova_domain_init_rcaches(struct iova_domain *iovad)
 		}
 		for_each_possible_cpu(cpu) {
 			cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
+			nid = cpu_to_node(cpu);
 
 			spin_lock_init(&cpu_rcache->lock);
-			cpu_rcache->loaded = iova_magazine_alloc(GFP_KERNEL);
-			cpu_rcache->prev = iova_magazine_alloc(GFP_KERNEL);
+			cpu_rcache->loaded = iova_magazine_alloc_node(GFP_KERNEL, nid);
+			cpu_rcache->prev = iova_magazine_alloc_node(GFP_KERNEL, nid);
 			if (!cpu_rcache->loaded || !cpu_rcache->prev) {
 				ret = -ENOMEM;
 				goto out_err;
@@ -777,7 +778,9 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
 		swap(cpu_rcache->prev, cpu_rcache->loaded);
 		can_insert = true;
 	} else {
-		struct iova_magazine *new_mag = iova_magazine_alloc(GFP_ATOMIC);
+		int nid = cpu_to_node(raw_smp_processor_id());
+		struct iova_magazine *new_mag =
+			iova_magazine_alloc_node(GFP_ATOMIC, nid);
 
 		if (new_mag) {
 			spin_lock(&rcache->lock);
-- 
2.9.4

