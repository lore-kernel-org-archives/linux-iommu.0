Received: from njjs-sys-mailin01.njjs.baidu.com (mx311.baidu.com [180.101.52.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B861913A25D
	for <iommu@lists.linux.dev>; Fri, 26 Apr 2024 05:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.101.52.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714109051; cv=none; b=LwGVdNYJbA1MnriJIkHKgiFnqdyn8owo5VYmGUv+x/sIiGYo0zMXRFobpDL0LmqwFWgBitsL7JQfWob++d1lah+MtvQyQiOvBVbuU+fUBCicxbcblvwi+2foNzAUhe16i2JWO2KumWTjsUeYl3czMhTYlUyTwuIXgQ+zTe7bHtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714109051; c=relaxed/simple;
	bh=8muSPwFTFdr0aL4RyfHmHKzD4sOC94Pm3k4IODZF0gM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=iZUIdmg1Fi7+M2jfNChDFhILyir5+GMhWhkwXT6/JWWIMVkDJ9qsfcyQuxzU5q8uTctoXcmj9s36Vxf3wfmnSRyEI91D0SuBq4X4UDAmAdKYqSlCmDhgXz8Jxmr/tGSuy/XVOIOu7LBH7GmK61kPIqg91EZhr/2jflQIpiyBlP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=180.101.52.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Received: from localhost (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
	by njjs-sys-mailin01.njjs.baidu.com (Postfix) with ESMTP id AAA637F00058;
	Fri, 26 Apr 2024 13:16:21 +0800 (CST)
From: Li RongQing <lirongqing@baidu.com>
To: robin.murphy@arm.com,
	joro@8bytes.org,
	will@kernel.org,
	iommu@lists.linux.dev
Cc: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH][v2] iommu/iova: Consider NUMA affinity when allocating per-CPU iova_magazine
Date: Fri, 26 Apr 2024 13:16:19 +0800
Message-Id: <20240426051619.10323-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.9.4
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

per-CPU iova_magazine are dominantly accessed from their own local CPUs,
so allocate them node-local for performance reason.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
diff with v1: not consider num node in  __iova_rcache_insert 

 drivers/iommu/iova.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index d59d0ea..68697cc 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -597,17 +597,23 @@ unsigned long iova_rcache_range(void)
 	return PAGE_SIZE << (IOVA_RANGE_CACHE_MAX_SIZE - 1);
 }
 
-static struct iova_magazine *iova_magazine_alloc(gfp_t flags)
+static struct iova_magazine *iova_magazine_alloc_node(gfp_t flags, int node)
 {
 	struct iova_magazine *mag;
 
-	mag = kmem_cache_alloc(iova_magazine_cache, flags);
+	mag = kmem_cache_alloc_node(iova_magazine_cache, flags, node);
+
 	if (mag)
 		mag->size = 0;
 
 	return mag;
 }
 
+static inline struct iova_magazine *iova_magazine_alloc(gfp_t flags)
+{
+	return iova_magazine_alloc_node(flags, NUMA_NO_NODE);
+}
+
 static void iova_magazine_free(struct iova_magazine *mag)
 {
 	kmem_cache_free(iova_magazine_cache, mag);
@@ -707,7 +713,7 @@ static void iova_depot_work_func(struct work_struct *work)
 int iova_domain_init_rcaches(struct iova_domain *iovad)
 {
 	unsigned int cpu;
-	int i, ret;
+	int i, ret, nid;
 
 	iovad->rcaches = kcalloc(IOVA_RANGE_CACHE_MAX_SIZE,
 				 sizeof(struct iova_rcache),
@@ -731,10 +737,11 @@ int iova_domain_init_rcaches(struct iova_domain *iovad)
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
-- 
2.9.4

