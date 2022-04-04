Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C76CC4167E
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 05:07:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D6532415BF;
	Mon,  4 Apr 2022 05:07:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XzZYqlJyYfB5; Mon,  4 Apr 2022 05:07:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3A9F441583;
	Mon,  4 Apr 2022 05:07:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 047CEC002C;
	Mon,  4 Apr 2022 05:07:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 583C4C0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 05:07:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5514482C33
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 05:07:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3ylY0ybNQXuN for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 05:07:07 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 95FFC82BC3
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 05:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=k2GXkvjY5MZ/f56SHxx5411JaZxKsGzZdPpduchxlxM=; b=SyDkm8mDvf+l0PvMChLDKGz+my
 cZtcRYXV9Hr2G9yPQ0LSgJkQ3zcbApXBDNKf18vvh9ZAvijelLU5NAursY6JK3GaQCBy6v+k3JvkN
 TL1F+dmc9RkeHdQMAE1/ibXmiYQ439Ex/5+OTvIQrM0odOarx9Qm64zowzpLUlEg7DVwxADtmAkdH
 /zPoPMsgOTR+RNnR2BfT+4JRRMrP3xk8DME1P+o0RQV1Wn78yYi6eylfhmI+5w7K1bpUeKqiLyuR5
 vbWxG/u24ODfUGo9BE8yI+4h9MoWDDg7DdRjqeIbJGrEQ7dUs9aEFnlLa/r2N6gwFuhyLxRo/Eu3c
 mgXzC/pw==;
Received: from 089144211060.atnat0020.highway.a1.net ([89.144.211.60]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbEvd-00D9SX-Gu; Mon, 04 Apr 2022 05:07:02 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 14/15] swiotlb: remove swiotlb_init_with_tbl and
 swiotlb_init_late_with_tbl
Date: Mon,  4 Apr 2022 07:05:58 +0200
Message-Id: <20220404050559.132378-15-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404050559.132378-1-hch@lst.de>
References: <20220404050559.132378-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 linux-s390@vger.kernel.org, Stefano Stabellini <sstabellini@kernel.org>,
 linux-ia64@vger.kernel.org, Anshuman Khandual <anshuman.khandual@arm.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Robin Murphy <robin.murphy@arm.com>, x86@kernel.org,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 tboot-devel@lists.sourceforge.net, linux-hyperv@vger.kernel.org,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
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

No users left.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/swiotlb.h |  2 --
 kernel/dma/swiotlb.c    | 77 +++++++++++------------------------------
 2 files changed, 20 insertions(+), 59 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 7b50c82f84ce9..7ed35dd3de6e7 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -34,13 +34,11 @@ struct scatterlist;
 /* default to 64MB */
 #define IO_TLB_DEFAULT_SIZE (64UL<<20)
 
-int swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, unsigned int flags);
 unsigned long swiotlb_size_or_default(void);
 void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 	int (*remap)(void *tlb, unsigned long nslabs));
 int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 	int (*remap)(void *tlb, unsigned long nslabs));
-extern int swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs);
 extern void __init swiotlb_update_mem_attributes(void);
 
 phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t phys,
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index d5fe8f5e08300..c54fc40ebb493 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -225,33 +225,6 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
 	return;
 }
 
-int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs,
-		unsigned int flags)
-{
-	struct io_tlb_mem *mem = &io_tlb_default_mem;
-	size_t alloc_size;
-
-	if (swiotlb_force_disable)
-		return 0;
-
-	/* protect against double initialization */
-	if (WARN_ON_ONCE(mem->nslabs))
-		return -ENOMEM;
-
-	alloc_size = PAGE_ALIGN(array_size(sizeof(*mem->slots), nslabs));
-	mem->slots = memblock_alloc(alloc_size, PAGE_SIZE);
-	if (!mem->slots)
-		panic("%s: Failed to allocate %zu bytes align=0x%lx\n",
-		      __func__, alloc_size, PAGE_SIZE);
-
-	swiotlb_init_io_tlb_mem(mem, __pa(tlb), nslabs, false);
-	mem->force_bounce = flags & SWIOTLB_FORCE;
-
-	if (flags & SWIOTLB_VERBOSE)
-		swiotlb_print_info();
-	return 0;
-}
-
 /*
  * Statically reserve bounce buffer space and initialize bounce buffer data
  * structures for the software IO TLB used to implement the DMA API.
@@ -259,7 +232,9 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs,
 void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 		int (*remap)(void *tlb, unsigned long nslabs))
 {
+	struct io_tlb_mem *mem = &io_tlb_default_mem;
 	unsigned long nslabs = default_nslabs;
+	size_t alloc_size = PAGE_ALIGN(array_size(sizeof(*mem->slots), nslabs));
 	size_t bytes;
 	void *tlb;
 
@@ -280,7 +255,8 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 	else
 		tlb = memblock_alloc_low(bytes, PAGE_SIZE);
 	if (!tlb)
-		goto fail;
+		panic("%s: failed to allocate tlb structure\n", __func__);
+
 	if (remap && remap(tlb, nslabs) < 0) {
 		memblock_free(tlb, PAGE_ALIGN(bytes));
 
@@ -290,14 +266,17 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 			      __func__, bytes);
 		goto retry;
 	}
-	if (swiotlb_init_with_tbl(tlb, default_nslabs, flags))
-		goto fail_free_mem;
-	return;
 
-fail_free_mem:
-	memblock_free(tlb, bytes);
-fail:
-	pr_warn("Cannot allocate buffer");
+	mem->slots = memblock_alloc(alloc_size, PAGE_SIZE);
+	if (!mem->slots)
+		panic("%s: Failed to allocate %zu bytes align=0x%lx\n",
+		      __func__, alloc_size, PAGE_SIZE);
+
+	swiotlb_init_io_tlb_mem(mem, __pa(tlb), default_nslabs, false);
+	mem->force_bounce = flags & SWIOTLB_FORCE;
+
+	if (flags & SWIOTLB_VERBOSE)
+		swiotlb_print_info();
 }
 
 void __init swiotlb_init(bool addressing_limit, unsigned int flags)
@@ -313,6 +292,7 @@ void __init swiotlb_init(bool addressing_limit, unsigned int flags)
 int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 		int (*remap)(void *tlb, unsigned long nslabs))
 {
+	struct io_tlb_mem *mem = &io_tlb_default_mem;
 	unsigned long nslabs = ALIGN(size >> IO_TLB_SHIFT, IO_TLB_SEGSIZE);
 	unsigned long bytes;
 	unsigned char *vstart = NULL;
@@ -353,33 +333,16 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 			return rc;
 		goto retry;
 	}
-	rc = swiotlb_late_init_with_tbl(vstart, nslabs);
-	if (rc)
-		free_pages((unsigned long)vstart, order);
-
-	return rc;
-}
-
-int
-swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
-{
-	struct io_tlb_mem *mem = &io_tlb_default_mem;
-	unsigned long bytes = nslabs << IO_TLB_SHIFT;
-
-	if (swiotlb_force_disable)
-		return 0;
-
-	/* protect against double initialization */
-	if (WARN_ON_ONCE(mem->nslabs))
-		return -ENOMEM;
 
 	mem->slots = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
 		get_order(array_size(sizeof(*mem->slots), nslabs)));
-	if (!mem->slots)
+	if (!mem->slots) {
+		free_pages((unsigned long)vstart, order);
 		return -ENOMEM;
+	}
 
-	set_memory_decrypted((unsigned long)tlb, bytes >> PAGE_SHIFT);
-	swiotlb_init_io_tlb_mem(mem, virt_to_phys(tlb), nslabs, true);
+	set_memory_decrypted((unsigned long)vstart, bytes >> PAGE_SHIFT);
+	swiotlb_init_io_tlb_mem(mem, virt_to_phys(vstart), nslabs, true);
 
 	swiotlb_print_info();
 	return 0;
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
