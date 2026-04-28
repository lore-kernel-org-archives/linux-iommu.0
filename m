Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A3930B525
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 06:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777356360; cv=none; b=aZxzBn/3OezFBKQGDAC8qJ/OULSF0x/uKN9WGveZIH6aO0xe2ZWDWv906lVKYABQfA3Vaa1mDb7csh142edE+37eawtMP9SC5/Hxf3w/eF7OyMxjJKVfzb3blMG7WGZnNcilXppz0kTon+t/Bk7gbBYQH2xhlwOSC4cq3+4oZa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777356360; c=relaxed/simple;
	bh=AEpwVhwfzDFWhJ9zvyXBG2y1e4klr5Zg9iX1zK/WyAs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XPbaT5BFTwe+dZDvkCV1g1BZhuHvlitpZBi6s4j5S4p+GPas72PK+NPmmAOwAWbN+zWXcU4ltoIf4lmF5sccZCv2/KUpae8HKPdjHEfhAAiHRQn16cWj8vXihug6DOlHjbGkk/qnavgX+XAZ3AIRTuETzMg+w14vQDvjrmxBpNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BrJC1XKX; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BrJC1XKX"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1777356353; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=UENmXrqV0minNvWhiDn/Fu3Vfd0TFiYhyAFS9+hB2Pk=;
	b=BrJC1XKX1iKuBMrTSC8rulCkopYdLDhdz4FS6I0pDmSlgxeCfUf/L3tUxNtvPpvVyA9qLIvk6/GiebAWsVeqirAxPc85SoDaNiI1lConROlfclqtT9dkZpMOaUyOHNqBmgDl+3LyimeFs4H2T5OGYk4lNeP4yzqXOEMlX/Bufh8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=feng.tang@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0X1tYxNo_1777356350;
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0X1tYxNo_1777356350 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 28 Apr 2026 14:05:51 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
	Liam.Howlett@oracle.com,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-mm@kvack.org,
	Christoph Hellwig <hch@lst.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Changrong Chen <chenchangrong.ccr@alibaba-inc.com>
Subject: [PATCH v3] dma-contiguous: setup default numa cma area if not configured explicitly
Date: Tue, 28 Apr 2026 14:05:50 +0800
Message-Id: <20260428060550.7167-1-feng.tang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was a report on a multi-numa-nodes ARM server that when IOMMU is
disabled, the dma_alloc_coherent() function always returns memory from
node 0 even for devices attaching to other nodes, while they can get
local dma memory when IOMMU is on with the same API.

The reason is, when IOMMU is disabled, the dma_alloc_coherent() will
go the direct way and call dma_alloc_contiguous(). The system doesn't
have any explicit cma setting (like per-numa cma), and only has a
default 64MB cma reserved area (on node 0), where kernel will try
first to allocate memory from.

Robin Murphy suggested to setup pernuma cma or disable cma, which did
solve the issue. While there is still concern that for customers
which don't have much kernel knowledge, they could still suffer from
this silently as some architectures enable cma area by default (not
an issue for X86 though, which set CONFIG_CMA_SIZE_MBYTES to 0 by
default) for most Linux distributions.

One thought is to follow the current cma reserving policy for platform
with 'CONFIG_DMA_NUMA_CMA=y', that if the numa cma (either the 'numa cma'
or 'cma pernuma' method) is not explicitly configured, set it up
according to size of default 'dma_contiguous_default_area', while
skipping the numa node where the 'dma_contiguous_default_area' lies
in, this way the default behavior of platform with one NUMA node is
kept unchanged.

To get the node info of cma area, add some helpr funciton and setup
in cma code.

Reported-by: Changrong Chen <chenchangrong.ccr@alibaba-inc.com>
Suggested-by: Ying Huang <ying.huang@linux.alibaba.com>
Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
---
Changelog:

  since v2:
    * setup the numa cma are following default cma, while
	  skipping the node holds the default cma (Robin Murphy)
	* add cma_get_node() help and related code
	* add reporter info 

  since v1:
	* don't use the original way of adding alloc_pages_node()
	  before trying default cma node (Robin Murphy)
	* setup default numa cma area if not configured (Ying Huang)

   v2: https://lore.kernel.org/lkml/20260423095243.14239-1-feng.tang@linux.alibaba.com/
   v1: https://lore.kernel.org/lkml/20260414090310.92055-1-feng.tang@linux.alibaba.com/

 include/linux/cma.h     |  1 +
 kernel/dma/contiguous.c | 14 ++++++++++++--
 mm/cma.c                | 11 ++++++++++-
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/include/linux/cma.h b/include/linux/cma.h
index 8555d38a97b1..acc9ecdf28e1 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -26,6 +26,7 @@ extern unsigned long totalcma_pages;
 extern phys_addr_t cma_get_base(const struct cma *cma);
 extern unsigned long cma_get_size(const struct cma *cma);
 extern const char *cma_get_name(const struct cma *cma);
+extern int cma_get_nid(const struct cma *cma);
 
 extern int __init cma_declare_contiguous_nid(phys_addr_t base,
 			phys_addr_t size, phys_addr_t limit,
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 03f52bd17120..ae6d856c5559 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -136,6 +136,7 @@ static struct cma *dma_contiguous_numa_area[MAX_NUMNODES];
 static phys_addr_t numa_cma_size[MAX_NUMNODES] __initdata;
 static struct cma *dma_contiguous_pernuma_area[MAX_NUMNODES];
 static phys_addr_t pernuma_size_bytes __initdata;
+static bool numa_cma_configured;
 
 static int __init early_numa_cma(char *p)
 {
@@ -164,6 +165,7 @@ static int __init early_numa_cma(char *p)
 			break;
 	}
 
+	numa_cma_configured = true;
 	return 0;
 }
 early_param("numa_cma", early_numa_cma);
@@ -171,6 +173,7 @@ early_param("numa_cma", early_numa_cma);
 static int __init early_cma_pernuma(char *p)
 {
 	pernuma_size_bytes = memparse(p, &p);
+	numa_cma_configured = true;
 	return 0;
 }
 early_param("cma_pernuma", early_cma_pernuma);
@@ -221,6 +224,13 @@ static void __init dma_numa_cma_reserve(void)
 					ret, nid);
 		}
 
+		if (!numa_cma_configured && dma_contiguous_default_area) {
+			if (nid != cma_get_nid(dma_contiguous_default_area))
+				numa_cma_size[nid] = cma_get_size(dma_contiguous_default_area);
+			else
+				dma_contiguous_numa_area[nid] = dma_contiguous_default_area;
+		}
+
 		if (numa_cma_size[nid]) {
 
 			cma = &dma_contiguous_numa_area[nid];
@@ -255,8 +265,6 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
 	phys_addr_t selected_limit = limit;
 	bool fixed = false;
 
-	dma_numa_cma_reserve();
-
 	pr_debug("%s(limit %08lx)\n", __func__, (unsigned long)limit);
 
 	if (size_cmdline != -1) {
@@ -312,6 +320,8 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
 		if (ret)
 			pr_warn("Couldn't queue default CMA region for heap creation.");
 	}
+
+	dma_numa_cma_reserve();
 }
 
 void __weak
diff --git a/mm/cma.c b/mm/cma.c
index c7ca567f4c5c..3bbfafeaf6c1 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -54,6 +54,11 @@ const char *cma_get_name(const struct cma *cma)
 }
 EXPORT_SYMBOL_GPL(cma_get_name);
 
+extern int cma_get_nid(const struct cma *cma)
+{
+	return cma->nid;
+}
+
 static unsigned long cma_bitmap_aligned_mask(const struct cma *cma,
 					     unsigned int align_order)
 {
@@ -511,7 +516,11 @@ static int __init __cma_declare_contiguous_nid(phys_addr_t *basep,
 		return ret;
 	}
 
-	(*res_cma)->nid = nid;
+	if (IS_ENABLED(CONFIG_NUMA) && nid == NUMA_NO_NODE)
+		(*res_cma)->nid = early_pfn_to_nid((*res_cma)->ranges[0].base_pfn);
+	else
+		(*res_cma)->nid = nid;
+
 	*basep = base;
 
 	return 0;
-- 
2.39.5 (Apple Git-154)

