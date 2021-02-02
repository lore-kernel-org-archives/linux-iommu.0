Return-Path: <SRS0=s4mY=HE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C679C433DB
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 09:51:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E39A964DDE
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 09:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E39A964DDE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A6A828672C;
	Tue,  2 Feb 2021 09:51:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Iq2aYF8ce9c6; Tue,  2 Feb 2021 09:51:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0E0FD866C3;
	Tue,  2 Feb 2021 09:51:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07261C0174;
	Tue,  2 Feb 2021 09:51:35 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51185C013A
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 09:51:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 49CA0214EC
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 09:51:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UcNzrjhep+Dn for <iommu@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 09:51:32 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by silver.osuosl.org (Postfix) with ESMTPS id 122532042C
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 09:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=wktlSKmgQbwwiYv5D/Zo0pNnWDNYO3mB3BRFoRHQVPA=; b=D5EUYpPnPco6p0ayBhZ3pYAuHz
 OuIgzSI+/OZkEnlL1svJxf1/VsNHiNRlfx47TqLezZRKB0GOgS6Jsp3mZEc8F1+RaPI+sCjqp+jC2
 sYwWZphpF6IvHkwyotBy38DRpDL9msuNQr+CsY7YvycLHjBhv0kEc0hZ+e6zBWy9NktjTmleQf7fC
 cZeXV2BMF7qflg3trCHYQy7j+uDPdF3UnWfB5Foh1BQYhI+JoMaI5Twtro+FWBAShJujR0nEL8BDH
 bSFeYR50AWdL4Qr78WpLBjTreNk57RxUDRO3BQWOHlxKHW0wHorKyWpGNxneFPD1UYEAa2/K6vPCi
 oAfgsQtQ==;
Received: from [2001:4bb8:198:6bf4:7f38:755e:a6e0:73e9] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1l6sLC-00F0wZ-UQ; Tue, 02 Feb 2021 09:51:23 +0000
From: Christoph Hellwig <hch@lst.de>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Tomasz Figa <tfiga@chromium.org>, Ricardo Ribalda <ribalda@chromium.org>,
 Sergey Senozhatsky <senozhatsky@google.com>,
 iommu@lists.linux-foundation.org
Subject: [PATCH 3/7] dma-mapping: refactor dma_{alloc,free}_pages
Date: Tue,  2 Feb 2021 10:51:06 +0100
Message-Id: <20210202095110.1215346-4-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210202095110.1215346-1-hch@lst.de>
References: <20210202095110.1215346-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-media@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
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

Factour out internal versions without the dma_debug calls in preparation
for callers that will need different dma_debug calls.

Note that this changes the dma_debug calls to get the not page aligned
size values, but as long as alloc and free agree on one variant we are
fine.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/mapping.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index c1e515496c067b..5e87dac6cc6d9a 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -475,11 +475,10 @@ void dma_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 }
 EXPORT_SYMBOL(dma_free_attrs);
 
-struct page *dma_alloc_pages(struct device *dev, size_t size,
+static struct page *__dma_alloc_pages(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
-	struct page *page;
 
 	if (WARN_ON_ONCE(!dev->coherent_dma_mask))
 		return NULL;
@@ -488,31 +487,41 @@ struct page *dma_alloc_pages(struct device *dev, size_t size,
 
 	size = PAGE_ALIGN(size);
 	if (dma_alloc_direct(dev, ops))
-		page = dma_direct_alloc_pages(dev, size, dma_handle, dir, gfp);
-	else if (ops->alloc_pages)
-		page = ops->alloc_pages(dev, size, dma_handle, dir, gfp);
-	else
+		return dma_direct_alloc_pages(dev, size, dma_handle, dir, gfp);
+	if (!ops->alloc_pages)
 		return NULL;
+	return ops->alloc_pages(dev, size, dma_handle, dir, gfp);
+}
 
-	debug_dma_map_page(dev, page, 0, size, dir, *dma_handle);
+struct page *dma_alloc_pages(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp)
+{
+	struct page *page = __dma_alloc_pages(dev, size, dma_handle, dir, gfp);
 
+	if (page)
+		debug_dma_map_page(dev, page, 0, size, dir, *dma_handle);
 	return page;
 }
 EXPORT_SYMBOL_GPL(dma_alloc_pages);
 
-void dma_free_pages(struct device *dev, size_t size, struct page *page,
+static void __dma_free_pages(struct device *dev, size_t size, struct page *page,
 		dma_addr_t dma_handle, enum dma_data_direction dir)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
 	size = PAGE_ALIGN(size);
-	debug_dma_unmap_page(dev, dma_handle, size, dir);
-
 	if (dma_alloc_direct(dev, ops))
 		dma_direct_free_pages(dev, size, page, dma_handle, dir);
 	else if (ops->free_pages)
 		ops->free_pages(dev, size, page, dma_handle, dir);
 }
+
+void dma_free_pages(struct device *dev, size_t size, struct page *page,
+		dma_addr_t dma_handle, enum dma_data_direction dir)
+{
+	debug_dma_unmap_page(dev, dma_handle, size, dir);
+	__dma_free_pages(dev, size, page, dma_handle, dir);
+}
 EXPORT_SYMBOL_GPL(dma_free_pages);
 
 int dma_mmap_pages(struct device *dev, struct vm_area_struct *vma,
-- 
2.29.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
