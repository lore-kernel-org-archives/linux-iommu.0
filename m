Return-Path: <SRS0=H3NW=7Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A6DC433E1
	for <iommu@archiver.kernel.org>; Thu, 11 Jun 2020 19:20:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1134B207ED
	for <iommu@archiver.kernel.org>; Thu, 11 Jun 2020 19:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="JdRQWIST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1134B207ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D0965879F9;
	Thu, 11 Jun 2020 19:20:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4v-jr4vts4Pg; Thu, 11 Jun 2020 19:20:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4E8FC879E7;
	Thu, 11 Jun 2020 19:20:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3BA58C0891;
	Thu, 11 Jun 2020 19:20:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7785C016F
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 19:20:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D4609880C2
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 19:20:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Kw+Cy9Oyrwcq for <iommu@lists.linux-foundation.org>;
 Thu, 11 Jun 2020 19:20:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com
 [209.85.216.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A786F878BE
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 19:20:29 +0000 (UTC)
Received: by mail-pj1-f68.google.com with SMTP id a45so3367761pje.1
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 12:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=0RWHH5fLF59Um6Y5l8fqB4Uo2eJszov0rE1UzYFPSzI=;
 b=JdRQWISTkKmhO8vUDE4vizFpUg804f1yUuzpg9VXBOYxGIyGbiL0XFdu0GZ+GvlSXT
 PrAd9RYV1ky0p+RrYgxGIxbun8jtjtOeLjr+umGxdeUqbsBPMNd5KjsGMbN+DB7VPvBy
 VqCLY10ISyV7J0igBjPB7QYIqKjqNHx+xK60voGz1sLBHrNIe+YkEo8Xdvq7WMAI7OnI
 yArx81zMkQGM8m7uR0qqEFh7j3Xe9OMF223woYvkRZlJQjzHWRWfbL7A3z7X0yYdWR57
 /D/Uwaqwn/YZLRdlwSH1/t110UayyKpuU/YmyxMlsuuMUeCE6Pw1Jblkh+Xil+j5Y4o2
 uMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=0RWHH5fLF59Um6Y5l8fqB4Uo2eJszov0rE1UzYFPSzI=;
 b=lr7zWCDfLxrqpuoapJ7LE8WVoqNUffD/Xb72HnGxj3sYBe6w4+LDAEALOoK+BaxSop
 0jIwzujj3Lf/K6FtC2Av6LaNYKZu4C0cYb5XVt9B+oVQcIvBvzaNiqEo85BMeW+yHvV6
 Ad/d1TLmAtQ8rUCJXDVLS5i9hPU65lYIYD2V7h7nIE0t7GzBKQyx9gwV/2AEVYMECY9f
 KcuQyZ9phHHzJjOfx7Bhg0h5HJZIplLwCPw9Lg+POiqQRBuAQM9FSsS4swEtTR2kVDkh
 LtxucUh4Ac9yiWPBWY+CS2muBhOl/EbFZcBSbeZ2uchc4qS1kei+FoC8q8CY3LNoTibG
 VMCg==
X-Gm-Message-State: AOAM533FW22ATlPj6JBtJ8uknCDcy5iJLXV3T1AqeGGFJJvnCy0Bvc+s
 dLvvQQKFTvCd/K8EPUbbe3mWng==
X-Google-Smtp-Source: ABdhPJzvCw22dYLwxKcxQJKZqi3ugu6ayMxQGnkNzW9CE2wSsE0O83786LzlNuvg9IOoKYMmSyFAnw==
X-Received: by 2002:a17:90b:3690:: with SMTP id
 mj16mr9472674pjb.104.1591903229097; 
 Thu, 11 Jun 2020 12:20:29 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598]
 ([2620:15c:17:3:3a5:23a7:5e32:4598])
 by smtp.gmail.com with ESMTPSA id bv16sm3380989pjb.46.2020.06.11.12.20.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 12:20:28 -0700 (PDT)
Date: Thu, 11 Jun 2020 12:20:28 -0700 (PDT)
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Christoph Hellwig <hch@lst.de>
Subject: [patch for-5.8 1/4] dma-direct: always align allocation size in
 dma_direct_alloc_pages()
In-Reply-To: <alpine.DEB.2.22.394.2006111218200.153880@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.22.394.2006111218570.153880@chino.kir.corp.google.com>
References: <alpine.DEB.2.22.394.2006111218200.153880@chino.kir.corp.google.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Cc: Thomas Lendacky <thomas.lendacky@amd.com>,
 Brijesh Singh <brijesh.singh@amd.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
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
From: David Rientjes via iommu <iommu@lists.linux-foundation.org>
Reply-To: David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

dma_alloc_contiguous() does size >> PAGE_SHIFT and set_memory_decrypted()
works at page granularity.  It's necessary to page align the allocation
size in dma_direct_alloc_pages() for consistent behavior.

This also fixes an issue when arch_dma_prep_coherent() is called on an
unaligned allocation size for dma_alloc_need_uncached() when
CONFIG_DMA_DIRECT_REMAP is disabled but CONFIG_ARCH_HAS_DMA_SET_UNCACHED
is enabled.

Cc: stable@vger.kernel.org
Signed-off-by: David Rientjes <rientjes@google.com>
---
 kernel/dma/direct.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -112,11 +112,12 @@ static inline bool dma_should_free_from_pool(struct device *dev,
 struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 		gfp_t gfp, unsigned long attrs)
 {
-	size_t alloc_size = PAGE_ALIGN(size);
 	int node = dev_to_node(dev);
 	struct page *page = NULL;
 	u64 phys_limit;
 
+	VM_BUG_ON(!PAGE_ALIGNED(size));
+
 	if (attrs & DMA_ATTR_NO_WARN)
 		gfp |= __GFP_NOWARN;
 
@@ -124,14 +125,14 @@ struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 	gfp &= ~__GFP_ZERO;
 	gfp |= dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
 					   &phys_limit);
-	page = dma_alloc_contiguous(dev, alloc_size, gfp);
+	page = dma_alloc_contiguous(dev, size, gfp);
 	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
-		dma_free_contiguous(dev, page, alloc_size);
+		dma_free_contiguous(dev, page, size);
 		page = NULL;
 	}
 again:
 	if (!page)
-		page = alloc_pages_node(node, gfp, get_order(alloc_size));
+		page = alloc_pages_node(node, gfp, get_order(size));
 	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
 		dma_free_contiguous(dev, page, size);
 		page = NULL;
@@ -158,8 +159,10 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 	struct page *page;
 	void *ret;
 
+	size = PAGE_ALIGN(size);
+
 	if (dma_should_alloc_from_pool(dev, gfp, attrs)) {
-		ret = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &page, gfp);
+		ret = dma_alloc_from_pool(dev, size, &page, gfp);
 		if (!ret)
 			return NULL;
 		goto done;
@@ -183,10 +186,10 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 	     dma_alloc_need_uncached(dev, attrs)) ||
 	    (IS_ENABLED(CONFIG_DMA_REMAP) && PageHighMem(page))) {
 		/* remove any dirty cache lines on the kernel alias */
-		arch_dma_prep_coherent(page, PAGE_ALIGN(size));
+		arch_dma_prep_coherent(page, size);
 
 		/* create a coherent mapping */
-		ret = dma_common_contiguous_remap(page, PAGE_ALIGN(size),
+		ret = dma_common_contiguous_remap(page, size,
 				dma_pgprot(dev, PAGE_KERNEL, attrs),
 				__builtin_return_address(0));
 		if (!ret)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
