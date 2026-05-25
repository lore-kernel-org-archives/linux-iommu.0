Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBBD1B85F8
	for <iommu@lists.linux.dev>; Mon, 25 May 2026 01:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779673883; cv=none; b=elqkUCDRLGWxyO+T3M05U80IP3Go20zIL+1QHYCOuJ4ea72Z+/f/8jxw2dRYAVBblr9gWVq5qNV85k3dWNt5+SimdohJ0WtbbCvw6X1JZf/yCi43vV7EZ66N+o/t1iWZcKGxmApaYwK5fiiWidVfKwztyJK8Nb4P47r1xNwXx+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779673883; c=relaxed/simple;
	bh=msBV5e9i7EKNMmoiaDCrRv996kS++Hm2c+xTNwxxBp4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rSgisQxYfg0FOKmOtWVGC6nDp9afA8c5DGgu9odZYwcOL6aZOonllixEuDUI1RSY3KZwDOO2k6DqVxoxfvcSGU+BEZ+xIS88a0MI8mJRvH5tsz7v76v1MuqWwJQXlFEfKgvZcA2WH9TK4o27ywthBZfUVgVxdr8fne8WJpphBYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JmMg5yQZ; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JmMg5yQZ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779673873; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=nTIIfWGOFiq0ssQY7gsg1jND00lIwPAIKb281eO8r2g=;
	b=JmMg5yQZJhRGnS//+maF7hdeDPaTeCV/g/kIesxpSBa5ExtDkDd/YH6qvJ6QwOi5er+HOogyBlAhSCoK8BE3u1Xl2HA6AKeIX7V8XYgjM3VAZ9JZnMysiHDHXh3I7i0jf9cNi4mos+KsjHodWn0xHlB1pA1VUTEQUVNa3fouctE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=feng.tang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X3ToWQy_1779673872;
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0X3ToWQy_1779673872 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 25 May 2026 09:51:12 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Feng Tang <feng.tang@linux.alibaba.com>
Subject: [PATCH] dma-contiguous: simplify numa cma area handling
Date: Mon, 25 May 2026 09:51:11 +0800
Message-Id: <20260525015111.6267-1-feng.tang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, there are 2 kernel cmdline ways to setup numa cma area:
"cma_pernuma=" and "numa_cma=", and there are 2 cma arrays as well,
while they have no difference technically. Robin suggested to cleanup
the code and only use one array [1], as "the apparent intent that
users only want one _or_ the other".

Simplify the code by only using one array to save the numa cma area.
And in rare case that a user really setup the 2 cmdline parameters
at the same time,  let the per-node specific size setting 'numa_cma='
take priority over the global numa cma setting.

Link[1]: https://lore.kernel.org/lkml/43c5301c-fe6a-41e4-9482-ccfc7b62f2a7@arm.com/

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
---
 .../admin-guide/kernel-parameters.txt         |  4 ++
 kernel/dma/Kconfig                            |  4 +-
 kernel/dma/contiguous.c                       | 46 +++++--------------
 3 files changed, 19 insertions(+), 35 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 4d0f545fb3ec..8e717a587870 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -895,6 +895,10 @@ Kernel parameters
 			contiguous memory allocations. It will reserve CMA
 			area for the specified node.
 
+			If it is setup together with upper 'cmd_pernuma='
+			(unlikely), its size setting takes priority for the
+			specified numa nodes.
+
 			With numa CMA enabled, DMA users on node nid will
 			first try to allocate buffer from the numa area
 			which is located in node nid, if the allocation fails,
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index c9fa0a922cba..0a4ba21a57a7 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -179,7 +179,9 @@ config DMA_NUMA_CMA
 
 	  You can set the size of pernuma CMA by specifying "cma_pernuma=size"
 	  or set the node id and its size of CMA by specifying "numa_cma=
-	  <node>:size[,<node>:size]" on the kernel's command line.
+	  <node>:size[,<node>:size]" on the kernel's command line. And in
+	  rare case that the above 2 are both setup, then the "numa_cma="
+	  takes priority for the specified numa nodes.
 
 config CMA_SIZE_PERNUMA
 	bool "Default CMA area per NUMA node"
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 799f6e9c88bd..f754079a287d 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -134,7 +134,6 @@ EXPORT_SYMBOL_GPL(dev_get_cma_area);
 
 static struct cma *dma_contiguous_numa_area[MAX_NUMNODES];
 static phys_addr_t numa_cma_size[MAX_NUMNODES] __initdata;
-static struct cma *dma_contiguous_pernuma_area[MAX_NUMNODES];
 static phys_addr_t pernuma_size_bytes __initdata;
 static bool numa_cma_configured __initdata;
 
@@ -208,7 +207,7 @@ static void __init dma_numa_cma_reserve(void)
 		pernuma_size_bytes = cma_get_size(dma_contiguous_default_area);
 
 	for_each_node(nid) {
-		int ret;
+		int size, ret;
 		char name[CMA_MAX_NAME];
 		struct cma **cma;
 
@@ -218,27 +217,17 @@ static void __init dma_numa_cma_reserve(void)
 			continue;
 		}
 
-		if (pernuma_size_bytes) {
-
-			cma = &dma_contiguous_pernuma_area[nid];
-			snprintf(name, sizeof(name), "pernuma%d", nid);
-			ret = cma_declare_contiguous_nid(0, pernuma_size_bytes, 0, 0,
-							 0, false, name, cma, nid);
-			if (ret)
-				pr_warn("%s: reservation failed: err %d, node %d", __func__,
-					ret, nid);
-		}
-
-		if (numa_cma_size[nid]) {
+		/* per-node numa setting has the priority */
+		size = numa_cma_size[nid] ?: pernuma_size_bytes;
+		if (!size)
+			continue;
 
-			cma = &dma_contiguous_numa_area[nid];
-			snprintf(name, sizeof(name), "numa%d", nid);
-			ret = cma_declare_contiguous_nid(0, numa_cma_size[nid], 0, 0, 0, false,
-							 name, cma, nid);
-			if (ret)
-				pr_warn("%s: reservation failed: err %d, node %d", __func__,
-					ret, nid);
-		}
+		cma = &dma_contiguous_numa_area[nid];
+		snprintf(name, sizeof(name), "numa%d", nid);
+		ret = cma_declare_contiguous_nid(0, size, 0, 0, 0, false, name, cma, nid);
+		if (ret)
+			pr_warn("%s: reservation failed: err %d, node %d", __func__,
+				ret, nid);
 	}
 }
 #else
@@ -437,16 +426,8 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
 
 #ifdef CONFIG_DMA_NUMA_CMA
 	if (nid != NUMA_NO_NODE && !(gfp & (GFP_DMA | GFP_DMA32))) {
-		struct cma *cma = dma_contiguous_pernuma_area[nid];
+		struct cma *cma = dma_contiguous_numa_area[nid];
 		struct page *page;
-
-		if (cma) {
-			page = cma_alloc_aligned(cma, size, gfp);
-			if (page)
-				return page;
-		}
-
-		cma = dma_contiguous_numa_area[nid];
 		if (cma) {
 			page = cma_alloc_aligned(cma, size, gfp);
 			if (page)
@@ -484,9 +465,6 @@ void dma_free_contiguous(struct device *dev, struct page *page, size_t size)
 		 * otherwise, page is from either per-numa cma or default cma
 		 */
 #ifdef CONFIG_DMA_NUMA_CMA
-		if (cma_release(dma_contiguous_pernuma_area[page_to_nid(page)],
-					page, count))
-			return;
 		if (cma_release(dma_contiguous_numa_area[page_to_nid(page)],
 					page, count))
 			return;

base-commit: 7e6ace2535d032c908e4d8747d9a7952617c001a
-- 
2.43.5

