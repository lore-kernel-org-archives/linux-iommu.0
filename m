Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C017288B1
	for <iommu@lists.linux.dev>; Sat,  9 May 2026 07:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778311554; cv=none; b=UGzz87OcFoRcqrnUNKYDhzvLL8jl2hGVSJbuLwglR/14u2MeNbaj0+DbgXu/LcSM6NJpbNYK9SkfRWCaIhbvb4bkgawBsiMtx22QV2aPOH0nIouDiC+Cra1h5e4k0tkh6rH7HVMFXRN2JnrYJ9PUUf2QzSE8es5CID/30zIzjqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778311554; c=relaxed/simple;
	bh=QrzAK8UOcwBG9zeJTwqNExwRRFXT0F7MYTwbcz20D44=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HYruoYdSbczRdi1DHrcJzWrf5J2L9/E3MTlvX7FaaTKHphW31DEuustF7G5AL7jXsI1YD/IUgSu3hJGs3zvRR1MjMA5CPaNmndqrNVbD8t7Uhs1k+JRXD9llxjaOuLb74o/5K9eWzppc7/RYL6S5XSh2/BRotwANWYebFtG6hJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UDVBYgGh; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UDVBYgGh"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778311546; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Zz9dljwMnRAVIrIM8dQvn0hpqZlwAvACimR9yDAo7Rs=;
	b=UDVBYgGhK0fnsD4MS1xNbZCqISKs7qYxUpLcM0I6pQ2yHKY5R1VO3+SClrFhwisFzefn6xQuMDPFirOVFRsYGb1cfrzK8JpTosEza/ylkBjkOrdbycNtYlr3vOK1BtUkk4IVk5HZfaXIJxmN8C5fXrCLdfaGT8bvTQ5B432L4OA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=feng.tang@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0X2ZrJg._1778311544;
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0X2ZrJg._1778311544 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 09 May 2026 15:25:45 +0800
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
Subject: [PATCH] dma-contiguous: add kconfig option to setup numa cma area if not configured explicitly
Date: Sat,  9 May 2026 15:25:43 +0800
Message-Id: <20260509072543.69650-1-feng.tang@linux.alibaba.com>
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
or 'cma pernuma' method) is not explicitly configured, set it up
according to size of default 'dma_contiguous_default_area', while
skipping the numa node where the 'dma_contiguous_default_area' lies
in, this way the default behavior of platform with one NUMA node is
kept unchanged (say embedded/small devices don't need to allocate
extra memory).

Add a new bool kernel config CONFIG_CMA_SIZE_PERNUMA to control whether
to enable it. Even when the config is enabled, user can still disable
it by kernel-cmdline setting like "numa_cma=0:0" or "cma_pernuma=0".

To get the node info of cma area, add some helper function and setup
in cma code.

Reported-by: Changrong Chen <chenchangrong.ccr@alibaba-inc.com>
Suggested-by: Ying Huang <ying.huang@linux.alibaba.com>
Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
---

In v4, the cma_get_nid() code is still kept, and if people really
think it's not necessary, we can use the "nr_online_nodes() > 1" 
instead as mentioned by Robin.

Changelog:

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

   v3: https://lore.kernel.org/lkml/20260428060550.7167-1-feng.tang@linux.alibaba.com/ 
   v2: https://lore.kernel.org/lkml/20260423095243.14239-1-feng.tang@linux.alibaba.com/
   v1: https://lore.kernel.org/lkml/20260414090310.92055-1-feng.tang@linux.alibaba.com/


 include/linux/cma.h     |  1 +
 kernel/dma/Kconfig      | 10 ++++++++++
 kernel/dma/contiguous.c | 16 ++++++++++++++--
 mm/cma.c                | 11 ++++++++++-
 4 files changed, 35 insertions(+), 3 deletions(-)

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
index 03f52bd17120..6388ebbbfebd 100644
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
@@ -221,6 +224,15 @@ static void __init dma_numa_cma_reserve(void)
 					ret, nid);
 		}
 
+#ifdef CONFIG_CMA_SIZE_PERNUMA
+		if (!numa_cma_configured && dma_contiguous_default_area) {
+			if (nid != cma_get_nid(dma_contiguous_default_area))
+				numa_cma_size[nid] = cma_get_size(dma_contiguous_default_area);
+			else
+				dma_contiguous_numa_area[nid] = dma_contiguous_default_area;
+		}
+#endif
+
 		if (numa_cma_size[nid]) {
 
 			cma = &dma_contiguous_numa_area[nid];
@@ -255,8 +267,6 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
 	phys_addr_t selected_limit = limit;
 	bool fixed = false;
 
-	dma_numa_cma_reserve();
-
 	pr_debug("%s(limit %08lx)\n", __func__, (unsigned long)limit);
 
 	if (size_cmdline != -1) {
@@ -312,6 +322,8 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
 		if (ret)
 			pr_warn("Couldn't queue default CMA region for heap creation.");
 	}
+
+	dma_numa_cma_reserve();
 }
 
 void __weak
diff --git a/mm/cma.c b/mm/cma.c
index c7ca567f4c5c..fba5fc9c004f 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -54,6 +54,11 @@ const char *cma_get_name(const struct cma *cma)
 }
 EXPORT_SYMBOL_GPL(cma_get_name);
 
+int cma_get_nid(const struct cma *cma)
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

base-commit: 70390501d1944d4e5b8f7352be180fceb3a44132
-- 
2.39.5 (Apple Git-154)

