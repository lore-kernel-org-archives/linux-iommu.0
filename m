Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A801B38A702
	for <iommu@lists.linux.dev>; Tue, 12 May 2026 08:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778576122; cv=none; b=I7LrBsAXphUGpT8yCumrz8Hbv9iG85ZP+xPH7XvDY2ZY3/ye9+m9njOZ6mZ2GDZZioJw8QGR6syYlDAwvDgneYiv5ykZb7V5HGXFkEAgkdumqWq/i811tjAmuUT7e66DipZpgiLrebW69VCOgn5ZdKM30dFMapso8hPmBcfDzAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778576122; c=relaxed/simple;
	bh=LEURsAHvv29a86TUuYuZCyuHe9jsYve+RMDnyCUuzuo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gkoOz3zRIezlxe8uf3iewgX+KJ4scd4ac/qZJq0y5Zw2NTOLgeKJEGz27wx/HglW8OnwkZAljJ38GqSjyHfNykIreGSxizoVLxhl91nvXiNLzYUhgiCBM6hCrffckIufse4G9ArX7tZaKEgsI3tduB89v+5UL+J5FY7+yRVIJtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SgM/LpFO; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SgM/LpFO"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778576113; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=zk3RFEUB36HedEJNqnsLDwa9WLsP3/7x2x9nYChWeww=;
	b=SgM/LpFOZZmL8aIjJD0lu5qwyYTk73aGGmGelqAljYa1v8Zy+0T35VIAcV3JsWWtvgxWZ3mPCPv7Rlp7o0bwZC/p1LaGFWg1GKEem/CHZ9eB/VzjJsl1Su6M0LYlMcj/G2NhQSgSiN1aaq+wfGSABsFdlGTi4AOAbpBif+34Ync=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=feng.tang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X2q2TIQ_1778576111;
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0X2q2TIQ_1778576111 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 May 2026 16:55:12 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>,
	linux-mm@kvack.org,
	Christoph Hellwig <hch@lst.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Changrong Chen <chenchangrong.ccr@alibaba-inc.com>
Subject: [PATCH v5] dma-contiguous: add kconfig option to setup numa cma area if not configured explicitly
Date: Tue, 12 May 2026 16:55:09 +0800
Message-Id: <20260512085509.83002-1-feng.tang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was a report on a multi-numa-nodes arm64 server that when IOMMU
is disabled, the dma_alloc_coherent() function always returns memory
from node 0 even for devices attaching to other nodes, while they can
get local dma memory when IOMMU is on with the same API.

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
or 'cma pernuma' method) is not explicitly configured, and the platform
really has multiple NUMA nodes, set it up according to size of default
'dma_contiguous_default_area'. This way, the default behavior of
platform with one NUMA node is kept unchanged (say embedded/small
devices don't need to allocate extra memory), while the general dma
locality is improved.

Add a new bool kernel config CONFIG_CMA_SIZE_PERNUMA to control whether
to enable it. Even when the config is enabled, user can still disable
it by kernel-cmdline setting like "numa_cma=0:0" or "cma_pernuma=0".

Reported-by: Changrong Chen <chenchangrong.ccr@alibaba-inc.com>
Suggested-by: Ying Huang <ying.huang@linux.alibaba.com>
Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
---
Changelog:

  since v4:
	* remove the cma_get_nid() helper and use 'nr_online_nodes > 1'
      check instead (David, Robin)

  since v3:
	* Add kernel config to control this pernuma cma setup (David, Robin)
	* Fix a compile waring (LKP 0day robot)

  since v2:
	* setup the numa cma are following default cma, while
	  skipping the node holds the default cma (Robin Murphy)
	* add cma_get_node() help and related code
	* add reporter info 

  since v1:
	* don't use the original way of adding alloc_pages_node()
	  before trying default cma node (Robin Murphy)
	* setup default numa cma area if not configured (Ying Huang)

   v4: https://lore.kernel.org/lkml/20260509072543.69650-1-feng.tang@linux.alibaba.com/ 
   v3: https://lore.kernel.org/lkml/20260428060550.7167-1-feng.tang@linux.alibaba.com/ 
   v2: https://lore.kernel.org/lkml/20260423095243.14239-1-feng.tang@linux.alibaba.com/
   v1: https://lore.kernel.org/lkml/20260414090310.92055-1-feng.tang@linux.alibaba.com/


 kernel/dma/Kconfig      | 10 ++++++++++
 kernel/dma/contiguous.c | 13 +++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index bfef21b4a9ae..c9fa0a922cba 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -181,6 +181,16 @@ config DMA_NUMA_CMA
 	  or set the node id and its size of CMA by specifying "numa_cma=
 	  <node>:size[,<node>:size]" on the kernel's command line.
 
+config CMA_SIZE_PERNUMA
+	bool "Default CMA area per NUMA node"
+	depends on DMA_NUMA_CMA
+	default y
+	help
+	  On systems with more than one NUMA node, the selected CMA
+	  area size will be also allocated on each additional node,
+	  so that most devices may have benefit from better DMA
+	  locality without an explicit command-line opt-in.
+
 comment "Default contiguous memory area size:"
 
 config CMA_SIZE_MBYTES
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 03f52bd17120..42227c823893 100644
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
@@ -199,6 +202,12 @@ static void __init dma_numa_cma_reserve(void)
 {
 	int nid;
 
+#ifdef CONFIG_CMA_SIZE_PERNUMA
+	if (!numa_cma_configured && dma_contiguous_default_area
+	    && nr_online_nodes > 1)
+		pernuma_size_bytes = cma_get_size(dma_contiguous_default_area);
+#endif
+
 	for_each_node(nid) {
 		int ret;
 		char name[CMA_MAX_NAME];
@@ -255,8 +264,6 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
 	phys_addr_t selected_limit = limit;
 	bool fixed = false;
 
-	dma_numa_cma_reserve();
-
 	pr_debug("%s(limit %08lx)\n", __func__, (unsigned long)limit);
 
 	if (size_cmdline != -1) {
@@ -312,6 +319,8 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
 		if (ret)
 			pr_warn("Couldn't queue default CMA region for heap creation.");
 	}
+
+	dma_numa_cma_reserve();
 }
 
 void __weak
-- 
2.39.5 (Apple Git-154)

