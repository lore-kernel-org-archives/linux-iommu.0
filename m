Return-Path: <SRS0=BMGV=BC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894B0C433EC
	for <iommu@archiver.kernel.org>; Thu, 23 Jul 2020 13:16:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67A9720737
	for <iommu@archiver.kernel.org>; Thu, 23 Jul 2020 13:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67A9720737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2C9B92C2B7;
	Thu, 23 Jul 2020 13:16:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8-dNeZ7thCxC; Thu, 23 Jul 2020 13:16:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3BD0D2C290;
	Thu, 23 Jul 2020 13:16:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28E62C016F;
	Thu, 23 Jul 2020 13:16:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7CF55C004C
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 13:16:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6C0118994A
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 13:16:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QxZxqZt+VO3E for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jul 2020 13:16:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BEE598994D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 13:16:24 +0000 (UTC)
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id F3D0C8D2195F79EE2944;
 Thu, 23 Jul 2020 21:16:19 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.202.55) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Thu, 23 Jul 2020 21:16:09 +0800
From: Barry Song <song.bao.hua@hisilicon.com>
To: <hch@lst.de>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
 <will@kernel.org>, <ganapatrao.kulkarni@cavium.com>,
 <catalin.marinas@arm.com>
Subject: [PATCH v4 1/2] dma-direct: provide the ability to reserve per-numa CMA
Date: Fri, 24 Jul 2020 01:13:43 +1200
Message-ID: <20200723131344.41472-2-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20200723131344.41472-1-song.bao.hua@hisilicon.com>
References: <20200723131344.41472-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
X-Originating-IP: [10.126.202.55]
X-CFilter-Loop: Reflected
Cc: Steve Capper <steve.capper@arm.com>, linux-kernel@vger.kernel.org,
 linuxarm@huawei.com, huangdaode@huawei.com, iommu@lists.linux-foundation.org,
 prime.zeng@hisilicon.com, Andrew Morton <akpm@linux-foundation.org>, Mike
 Rapoport <rppt@linux.ibm.com>, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Right now, drivers like ARM SMMU are using dma_alloc_coherent() to get
coherent DMA buffers to save their command queues and page tables. As
there is only one default CMA in the whole system, SMMUs on nodes other
than node0 will get remote memory. This leads to significant latency.

This patch provides per-numa CMA so that drivers like SMMU can get local
memory. Tests show localizing CMA can decrease dma_unmap latency much.
For instance, before this patch, SMMU on node2 has to wait for more than
560ns for the completion of CMD_SYNC in an empty command queue; with this
patch, it needs 240ns only.

A positive side effect of this patch would be improving performance even
further for those users who are worried about performance more than DMA
security and use iommu.passthrough=1 to skip IOMMU. With local CMA, all
drivers can get local coherent DMA buffers.

Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: Steve Capper <steve.capper@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
-v4:
 * rebase on top of Christoph Hellwig's patch:
 [PATCH v2] dma-contiguous: cleanup dma_alloc_contiguous
 https://lore.kernel.org/linux-iommu/20200723120133.94105-1-hch@lst.de/
 * cleanup according to Christoph's comment
 * reserve cma by checking N_MEMORY rather than N_ONLINE


 .../admin-guide/kernel-parameters.txt         |  9 ++
 include/linux/dma-contiguous.h                |  4 +
 kernel/dma/Kconfig                            | 10 ++
 kernel/dma/contiguous.c                       | 94 +++++++++++++++++--
 4 files changed, 107 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b8d6cde06463..6d963484bbdc 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -599,6 +599,15 @@
 			altogether. For more information, see
 			include/linux/dma-contiguous.h
 
+	pernuma_cma=nn[MG]@[start[MG][-end[MG]]]
+			[ARM,X86,KNL]
+			Sets the size of kernel per-numa memory area for
+			contiguous memory allocations. A value of 0 disables
+			per-numa CMA altogether. DMA users on node nid will
+			first try to allocate buffer from the pernuma area
+			which is located in node nid, if the allocation fails,
+			they will fallback to the global default memory area.
+
 	cmo_free_hint=	[PPC] Format: { yes | no }
 			Specify whether pages are marked as being inactive
 			when they are freed.  This is used in CMO environments
diff --git a/include/linux/dma-contiguous.h b/include/linux/dma-contiguous.h
index 03f8e98e3bcc..278a80a40456 100644
--- a/include/linux/dma-contiguous.h
+++ b/include/linux/dma-contiguous.h
@@ -79,6 +79,8 @@ static inline void dma_contiguous_set_default(struct cma *cma)
 
 void dma_contiguous_reserve(phys_addr_t addr_limit);
 
+void dma_pernuma_cma_reserve(void);
+
 int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
 				       phys_addr_t limit, struct cma **res_cma,
 				       bool fixed);
@@ -128,6 +130,8 @@ static inline void dma_contiguous_set_default(struct cma *cma) { }
 
 static inline void dma_contiguous_reserve(phys_addr_t limit) { }
 
+static inline void dma_pernuma_cma_reserve(void) { }
+
 static inline int dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
 				       phys_addr_t limit, struct cma **res_cma,
 				       bool fixed)
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 5d18456b5f01..37e0e3559624 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -120,6 +120,16 @@ config DMA_CMA
 if  DMA_CMA
 comment "Default contiguous memory area size:"
 
+config CMA_PERNUMA_SIZE_MBYTES
+	int "Size in Mega Bytes for per-numa CMA areas"
+	depends on NUMA
+	default 16 if ARM64
+	default 0
+	help
+	  Defines the size (in MiB) of the per-numa memory area for Contiguous
+	  Memory Allocator. Every numa node will get a separate CMA with this
+	  size. If the size of 0 is selected, per-numa CMA is disabled.
+
 config CMA_SIZE_MBYTES
 	int "Size in Mega Bytes"
 	depends on !CMA_SIZE_SEL_PERCENTAGE
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index cff7e60968b9..c0482231c0d7 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -30,7 +30,14 @@
 #define CMA_SIZE_MBYTES 0
 #endif
 
+#ifdef CONFIG_CMA_PERNUMA_SIZE_MBYTES
+#define CMA_SIZE_PERNUMA_MBYTES CONFIG_CMA_PERNUMA_SIZE_MBYTES
+#else
+#define CMA_SIZE_PERNUMA_MBYTES 0
+#endif
+
 struct cma *dma_contiguous_default_area;
+static struct cma *dma_contiguous_pernuma_area[MAX_NUMNODES];
 
 /*
  * Default global CMA area size can be defined in kernel's .config.
@@ -44,6 +51,8 @@ struct cma *dma_contiguous_default_area;
  */
 static const phys_addr_t size_bytes __initconst =
 	(phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;
+static phys_addr_t pernuma_size_bytes __initdata =
+	(phys_addr_t)CMA_SIZE_PERNUMA_MBYTES * SZ_1M;
 static phys_addr_t  size_cmdline __initdata = -1;
 static phys_addr_t base_cmdline __initdata;
 static phys_addr_t limit_cmdline __initdata;
@@ -69,6 +78,13 @@ static int __init early_cma(char *p)
 }
 early_param("cma", early_cma);
 
+static int __init early_pernuma_cma(char *p)
+{
+	pernuma_size_bytes = memparse(p, &p);
+	return 0;
+}
+early_param("pernuma_cma", early_pernuma_cma);
+
 #ifdef CONFIG_CMA_SIZE_PERCENTAGE
 
 static phys_addr_t __init __maybe_unused cma_early_percent_memory(void)
@@ -96,6 +112,33 @@ static inline __maybe_unused phys_addr_t cma_early_percent_memory(void)
 
 #endif
 
+void __init dma_pernuma_cma_reserve(void)
+{
+	int nid;
+
+	if (!pernuma_size_bytes)
+		return;
+
+	for_each_node_state(nid, N_MEMORY) {
+		int ret;
+		char name[20];
+
+		snprintf(name, sizeof(name), "pernuma%d", nid);
+		ret = cma_declare_contiguous_nid(0, pernuma_size_bytes, 0, 0,
+						 0, false, name,
+						 &dma_contiguous_pernuma_area[nid],
+						 nid);
+		if (ret) {
+			pr_warn("%s: reservation failed: err %d, node %d", __func__,
+				ret, nid);
+			continue;
+		}
+
+		pr_debug("%s: reserved %llu MiB on node %d\n", __func__,
+			(unsigned long long)pernuma_size_bytes / SZ_1M, nid);
+	}
+}
+
 /**
  * dma_contiguous_reserve() - reserve area(s) for contiguous memory handling
  * @limit: End address of the reserved memory (optional, 0 for any).
@@ -228,23 +271,38 @@ static struct page *cma_alloc_aligned(struct cma *cma, size_t size, gfp_t gfp)
  * @size:  Requested allocation size.
  * @gfp:   Allocation flags.
  *
- * This function allocates contiguous memory buffer for specified device. It
- * tries to use device specific contiguous memory area if available, or the
- * default global one.
+ * tries to use device specific contiguous memory area if available, or it
+ * tries to use per-numa cma, if the allocation fails, it will fallback to
+ * try default global one.
  *
- * Note that it byapss one-page size of allocations from the global area as
- * the addresses within one page are always contiguous, so there is no need
- * to waste CMA pages for that kind; it also helps reduce fragmentations.
+ * Note that it bypass one-page size of allocations from the per-numa and
+ * global area as the addresses within one page are always contiguous, so
+ * there is no need to waste CMA pages for that kind; it also helps reduce
+ * fragmentations.
  */
 struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
 {
+	int nid = dev_to_node(dev);
+
 	/* CMA can be used only in the context which permits sleeping */
 	if (!gfpflags_allow_blocking(gfp))
 		return NULL;
 	if (dev->cma_area)
 		return cma_alloc_aligned(dev->cma_area, size, gfp);
-	if (size <= PAGE_SIZE || !dma_contiguous_default_area)
+	if (size <= PAGE_SIZE)
 		return NULL;
+
+	if ((nid != NUMA_NO_NODE) && !(gfp & (GFP_DMA | GFP_DMA32))) {
+		struct cma *cma = dma_contiguous_pernuma_area[nid];
+		struct page *page;
+
+		if (cma) {
+			page = cma_alloc_aligned(cma, size, gfp);
+			if (page)
+				return page;
+		}
+	}
+
 	return cma_alloc_aligned(dma_contiguous_default_area, size, gfp);
 }
 
@@ -261,9 +319,25 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
  */
 void dma_free_contiguous(struct device *dev, struct page *page, size_t size)
 {
-	if (!cma_release(dev_get_cma_area(dev), page,
-			 PAGE_ALIGN(size) >> PAGE_SHIFT))
-		__free_pages(page, get_order(size));
+	/* if dev has its own cma, free page from there */
+	if (dev->cma_area) {
+		if (cma_release(dev->cma_area, page, PAGE_ALIGN(size) >> PAGE_SHIFT))
+			return;
+	} else {
+		/*
+		 * otherwise, page is from either per-numa cma or default cma
+		 */
+		if (cma_release(dma_contiguous_pernuma_area[page_to_nid(page)],
+					page, PAGE_ALIGN(size) >> PAGE_SHIFT))
+			return;
+
+		if (cma_release(dma_contiguous_default_area, page,
+					PAGE_ALIGN(size) >> PAGE_SHIFT))
+			return;
+	}
+
+	/* not in any cma, free from buddy */
+	__free_pages(page, get_order(size));
 }
 
 /*
-- 
2.27.0


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
