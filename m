Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E74C433F5
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 12:58:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 65F0441900;
	Wed, 11 May 2022 12:58:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4nxGzsqU9Jr9; Wed, 11 May 2022 12:58:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EAF0041615;
	Wed, 11 May 2022 12:58:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C35AFC0039;
	Wed, 11 May 2022 12:58:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 576F3C002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 12:58:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5581A418F3
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 12:58:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rzoXPaq-S_fp for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 12:58:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 704EB418FB
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 12:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=PuV44d9nkyau+qsF4HjXIzIFX/Iz+fNa7YzgjXIuJ3M=; b=KQeqn6zw5+tBwQhIwYbD033l7U
 Bmwb6MGWYXuK/LkzlngzGC5Qubu/BMK8ESaRHloaJRhzEWk2cFZ1/V/l4O8B2vq2MzumWvrZwnZyr
 43YpFbXIsyoZJQy96aaO4hEVBhMn/WC+lJu9Jachezx9QLwtVxUwduoKFfDF9UeSfgMQ0fx1hRZPt
 0LdWe9KjdTrTGyLfYx27s5kfHuPEf7J0GvFg765OJZ9W+F+cSaDYoHAsubZYbwp7D1ACiauoX1v40
 kA0XO3cMZuMkKnKm1x7RM+oVv6dCiF4gS3wqNXal5uhZKXl0X7LATlX/cCqQQx1QPxg0OGZS0cmVF
 GL+aA81w==;
Received: from [2001:4bb8:184:7881:740a:25f7:2c13:ef7a] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1noluw-006reJ-8R; Wed, 11 May 2022 12:58:14 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 2/3] swiotlb: use the right nslabs value in swiotlb_init_remap
Date: Wed, 11 May 2022 14:58:04 +0200
Message-Id: <20220511125805.1377025-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220511125805.1377025-1-hch@lst.de>
References: <20220511125805.1377025-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: xen-devel@lists.xenproject.org,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Conor.Dooley@microchip.com
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

default_nslabs should only be used to initialize nslabs, after that we
need to use the local variable that can shrink when allocations or the
remap don't succeed.

Fixes: 6424e31b1c05 ("swiotlb: remove swiotlb_init_with_tbl and swiotlb_init_late_with_tbl")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/swiotlb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 3e992a308c8a1..113e1e8aaca37 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -234,7 +234,7 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 {
 	struct io_tlb_mem *mem = &io_tlb_default_mem;
 	unsigned long nslabs = default_nslabs;
-	size_t alloc_size = PAGE_ALIGN(array_size(sizeof(*mem->slots), nslabs));
+	size_t alloc_size;
 	size_t bytes;
 	void *tlb;
 
@@ -249,7 +249,7 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 	 * memory encryption.
 	 */
 retry:
-	bytes = PAGE_ALIGN(default_nslabs << IO_TLB_SHIFT);
+	bytes = PAGE_ALIGN(nslabs << IO_TLB_SHIFT);
 	if (flags & SWIOTLB_ANY)
 		tlb = memblock_alloc(bytes, PAGE_SIZE);
 	else
@@ -269,12 +269,13 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 		goto retry;
 	}
 
+	alloc_size = PAGE_ALIGN(array_size(sizeof(*mem->slots), nslabs));
 	mem->slots = memblock_alloc(alloc_size, PAGE_SIZE);
 	if (!mem->slots)
 		panic("%s: Failed to allocate %zu bytes align=0x%lx\n",
 		      __func__, alloc_size, PAGE_SIZE);
 
-	swiotlb_init_io_tlb_mem(mem, __pa(tlb), default_nslabs, false);
+	swiotlb_init_io_tlb_mem(mem, __pa(tlb), nslabs, false);
 	mem->force_bounce = flags & SWIOTLB_FORCE;
 
 	if (flags & SWIOTLB_VERBOSE)
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
