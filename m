Return-Path: <SRS0=6E3Y=B7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BFDC433DF
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 11:37:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4977F20732
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 11:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4977F20732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3B647885D3;
	Fri, 21 Aug 2020 11:37:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id os5OrqQV9X9T; Fri, 21 Aug 2020 11:37:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2C29688610;
	Fri, 21 Aug 2020 11:37:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18B0AC0889;
	Fri, 21 Aug 2020 11:37:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AAA99C0051
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 11:37:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A743D86D23
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 11:37:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lNtaPdbqai9a for <iommu@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 11:37:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9A61F86C2D
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 11:37:01 +0000 (UTC)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 912516290934BADF42B8;
 Fri, 21 Aug 2020 19:36:59 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.200.129) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Fri, 21 Aug 2020 19:36:50 +0800
From: Barry Song <song.bao.hua@hisilicon.com>
To: <hch@lst.de>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
 <will@kernel.org>, <ganapatrao.kulkarni@cavium.com>,
 <catalin.marinas@arm.com>, <akpm@linux-foundation.org>
Subject: [PATCH v7 1/3] dma-contiguous: provide the ability to reserve
 per-numa CMA
Date: Fri, 21 Aug 2020 23:33:53 +1200
Message-ID: <20200821113355.6140-2-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20200821113355.6140-1-song.bao.hua@hisilicon.com>
References: <20200821113355.6140-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
X-Originating-IP: [10.126.200.129]
X-CFilter-Loop: Reflected
Cc: Mike Rapoport <rppt@linux.ibm.com>, Steve Capper <steve.capper@arm.com>,
 linuxarm@huawei.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, prime.zeng@hisilicon.com,
 huangdaode@huawei.com, linux-arm-kernel@lists.infradead.org
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
For instance, before this patch, SMMU on node2  has to wait for more than
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
 -v7: with respect to Will's comments
 * move to use for_each_online_node
 * add description if users don't specify pernuma_cma
 * provide default value for CONFIG_DMA_PERNUMA_CMA

 .../admin-guide/kernel-parameters.txt         |  11 ++
 include/linux/dma-contiguous.h                |   6 ++
 kernel/dma/Kconfig                            |  11 ++
 kernel/dma/contiguous.c                       | 100 ++++++++++++++++--
 4 files changed, 118 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bdc1f33fd3d1..c609527fc35a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -599,6 +599,17 @@
 			altogether. For more information, see
 			include/linux/dma-contiguous.h
 
+	pernuma_cma=nn[MG]
+			[ARM64,KNL]
+			Sets the size of kernel per-numa memory area for
+			contiguous memory allocations. A value of 0 disables
+			per-numa CMA altogether. And If this option is not
+			specificed, the default value is 0.
+			With per-numa CMA enabled, DMA users on node nid will
+			first try to allocate buffer from the pernuma area
+			which is located in node nid, if the allocation fails,
+			they will fallback to the global default memory area.
+
 	cmo_free_hint=	[PPC] Format: { yes | no }
 			Specify whether pages are marked as being inactive
 			when they are freed.  This is used in CMO environments
diff --git a/include/linux/dma-contiguous.h b/include/linux/dma-contiguous.h
index 03f8e98e3bcc..fe55e004f1f4 100644
--- a/include/linux/dma-contiguous.h
+++ b/include/linux/dma-contiguous.h
@@ -171,6 +171,12 @@ static inline void dma_free_contiguous(struct device *dev, struct page *page,
 
 #endif
 
+#ifdef CONFIG_DMA_PERNUMA_CMA
+void dma_pernuma_cma_reserve(void);
+#else
+static inline void dma_pernuma_cma_reserve(void) { }
+#endif
+
 #endif
 
 #endif
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 847a9d1fa634..c38979d45b13 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -118,6 +118,17 @@ config DMA_CMA
 	  If unsure, say "n".
 
 if  DMA_CMA
+
+config DMA_PERNUMA_CMA
+	bool "Enable separate DMA Contiguous Memory Area for each NUMA Node"
+	default NUMA && ARM64
+	help
+	  Enable this option to get pernuma CMA areas so that devices like
+	  ARM64 SMMU can get local memory by DMA coherent APIs.
+
+	  You can set the size of pernuma CMA by specifying "pernuma_cma=size"
+	  on the kernel's command line.
+
 comment "Default contiguous memory area size:"
 
 config CMA_SIZE_MBYTES
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index cff7e60968b9..0383c9b86715 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -69,6 +69,19 @@ static int __init early_cma(char *p)
 }
 early_param("cma", early_cma);
 
+#ifdef CONFIG_DMA_PERNUMA_CMA
+
+static struct cma *dma_contiguous_pernuma_area[MAX_NUMNODES];
+static phys_addr_t pernuma_size_bytes __initdata;
+
+static int __init early_pernuma_cma(char *p)
+{
+	pernuma_size_bytes = memparse(p, &p);
+	return 0;
+}
+early_param("pernuma_cma", early_pernuma_cma);
+#endif
+
 #ifdef CONFIG_CMA_SIZE_PERCENTAGE
 
 static phys_addr_t __init __maybe_unused cma_early_percent_memory(void)
@@ -96,6 +109,34 @@ static inline __maybe_unused phys_addr_t cma_early_percent_memory(void)
 
 #endif
 
+#ifdef CONFIG_DMA_PERNUMA_CMA
+void __init dma_pernuma_cma_reserve(void)
+{
+	int nid;
+
+	if (!pernuma_size_bytes)
+		return;
+
+	for_each_online_node(nid) {
+		int ret;
+		char name[20];
+		struct cma **cma = &dma_contiguous_pernuma_area[nid];
+
+		snprintf(name, sizeof(name), "pernuma%d", nid);
+		ret = cma_declare_contiguous_nid(0, pernuma_size_bytes, 0, 0,
+						 0, false, name, cma, nid);
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
+#endif
+
 /**
  * dma_contiguous_reserve() - reserve area(s) for contiguous memory handling
  * @limit: End address of the reserved memory (optional, 0 for any).
@@ -228,23 +269,44 @@ static struct page *cma_alloc_aligned(struct cma *cma, size_t size, gfp_t gfp)
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
+#ifdef CONFIG_DMA_PERNUMA_CMA
+	int nid = dev_to_node(dev);
+#endif
+
 	/* CMA can be used only in the context which permits sleeping */
 	if (!gfpflags_allow_blocking(gfp))
 		return NULL;
 	if (dev->cma_area)
 		return cma_alloc_aligned(dev->cma_area, size, gfp);
-	if (size <= PAGE_SIZE || !dma_contiguous_default_area)
+	if (size <= PAGE_SIZE)
+		return NULL;
+
+#ifdef CONFIG_DMA_PERNUMA_CMA
+	if (nid != NUMA_NO_NODE && !(gfp & (GFP_DMA | GFP_DMA32))) {
+		struct cma *cma = dma_contiguous_pernuma_area[nid];
+		struct page *page;
+
+		if (cma) {
+			page = cma_alloc_aligned(cma, size, gfp);
+			if (page)
+				return page;
+		}
+	}
+#endif
+	if (!dma_contiguous_default_area)
 		return NULL;
+
 	return cma_alloc_aligned(dma_contiguous_default_area, size, gfp);
 }
 
@@ -261,9 +323,27 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
  */
 void dma_free_contiguous(struct device *dev, struct page *page, size_t size)
 {
-	if (!cma_release(dev_get_cma_area(dev), page,
-			 PAGE_ALIGN(size) >> PAGE_SHIFT))
-		__free_pages(page, get_order(size));
+	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+
+	/* if dev has its own cma, free page from there */
+	if (dev->cma_area) {
+		if (cma_release(dev->cma_area, page, count))
+			return;
+	} else {
+		/*
+		 * otherwise, page is from either per-numa cma or default cma
+		 */
+#ifdef CONFIG_DMA_PERNUMA_CMA
+		if (cma_release(dma_contiguous_pernuma_area[page_to_nid(page)],
+					page, count))
+			return;
+#endif
+		if (cma_release(dma_contiguous_default_area, page, count))
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
