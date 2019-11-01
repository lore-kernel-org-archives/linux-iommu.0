Return-Path: <SRS0=gESx=YZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D9ECA9ECF
	for <iommu@archiver.kernel.org>; Fri,  1 Nov 2019 22:02:36 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 986382085B
	for <iommu@archiver.kernel.org>; Fri,  1 Nov 2019 22:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FKjraYkL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 986382085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C9CE2F19;
	Fri,  1 Nov 2019 22:02:35 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 75D39F19
	for <iommu@lists.linux-foundation.org>;
	Fri,  1 Nov 2019 22:02:34 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2159214D
	for <iommu@lists.linux-foundation.org>;
	Fri,  1 Nov 2019 22:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OcydaYdG/19SHg3U9lUc3OmYnqfORICIYXP5hCdk/1w=;
	b=FKjraYkLyF+RI9ojFMHOJszkBq
	IQW/MVe72G4cw3thrCctMOpcOOMZQ6SYyc9eIwOWe+Cjar9R3q9qlAaQdskKFenuFQRAsQRu5yZU3
	Whjp6CT+cZkq/QphRgVcLQ4znj7BDjB0oj5fEZ73UQY7+lRkS1PlBAJNCDmzksbOnKXrexkkmbgEp
	PK7veikR2nCmF3mq8qlyJPxHzrxYjLAzNueFyF1R5jnuQ0fOq1NAFn205fAFy7cBT/FV/X0SGqmyQ
	LAfltyaoN1A9B0Itqg0a9eg2mYog+pfjqb3i7qzYIL4ixgK/Q1xJKxeblov2JNxnJ5pXya3DvLb3y
	Liyzm1Mw==;
Received: from [199.255.44.128] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iQf05-0004GG-EP; Fri, 01 Nov 2019 22:02:33 +0000
From: Christoph Hellwig <hch@lst.de>
To: Max Filippov <jcmvbkbc@gmail.com>, Chris Zankel <chris@zankel.net>,
	iommu@lists.linux-foundation.org
Subject: [PATCH 2/5] dma-direct: remove the dma_handle argument to
	__dma_direct_alloc_pages
Date: Fri,  1 Nov 2019 15:02:10 -0700
Message-Id: <20191101220213.28949-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191101220213.28949-1-hch@lst.de>
References: <20191101220213.28949-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-xtensa@linux-xtensa.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

The argument isn't used anywhere, so stop passing it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-direct.h | 2 +-
 kernel/dma/direct.c        | 4 ++--
 kernel/dma/remap.c         | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index dec3b3bb121d..ff3d5edc44b9 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -67,6 +67,6 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
 		dma_addr_t dma_addr, unsigned long attrs);
 struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs);
+		gfp_t gfp, unsigned long attrs);
 int dma_direct_supported(struct device *dev, u64 mask);
 #endif /* _LINUX_DMA_DIRECT_H */
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index a7a2739fb747..724c282dd943 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -83,7 +83,7 @@ static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 }
 
 struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
+		gfp_t gfp, unsigned long attrs)
 {
 	size_t alloc_size = PAGE_ALIGN(size);
 	int node = dev_to_node(dev);
@@ -131,7 +131,7 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 	struct page *page;
 	void *ret;
 
-	page = __dma_direct_alloc_pages(dev, size, dma_handle, gfp, attrs);
+	page = __dma_direct_alloc_pages(dev, size, gfp, attrs);
 	if (!page)
 		return NULL;
 
diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
index fb1e50c2d48a..90d5ce77c189 100644
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -226,7 +226,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		goto done;
 	}
 
-	page = __dma_direct_alloc_pages(dev, size, dma_handle, flags, attrs);
+	page = __dma_direct_alloc_pages(dev, size, flags, attrs);
 	if (!page)
 		return NULL;
 
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
