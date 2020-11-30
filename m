Return-Path: <SRS0=awBX=FE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97107C64E90
	for <iommu@archiver.kernel.org>; Mon, 30 Nov 2020 10:47:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8C37207BC
	for <iommu@archiver.kernel.org>; Mon, 30 Nov 2020 10:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mxZ+YVsh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8C37207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3F4E52288E;
	Mon, 30 Nov 2020 10:47:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HRbaKE-EGEom; Mon, 30 Nov 2020 10:47:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 05AE522844;
	Mon, 30 Nov 2020 10:47:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5157C163C;
	Mon, 30 Nov 2020 10:47:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 326E9C0052
 for <iommu@lists.linux-foundation.org>; Mon, 30 Nov 2020 10:47:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0786022844
 for <iommu@lists.linux-foundation.org>; Mon, 30 Nov 2020 10:47:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hMm1Gc6PRD5B for <iommu@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 10:47:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 731B422843
 for <iommu@lists.linux-foundation.org>; Mon, 30 Nov 2020 10:47:38 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id g185so16318725wmf.3
 for <iommu@lists.linux-foundation.org>; Mon, 30 Nov 2020 02:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kEyLf8LFch+KdsSp/Rnz95CvSLqxxYSUroQ+WOd06N4=;
 b=mxZ+YVshPN8IDgC+Xd8VJSuhvuW+B1Vq1vEOVvhr69IYB6IWocC1WMBCPpZXbtWMu+
 c7toL4IxZDaEPMYXB6KuB1ZZHDPxgCxu/yMOhnV0L+cWMh1gK4hhLBZ3/rGsqxxIrR6y
 qFEqeGNKNm1kApxx2viLIZDmnm5XkEF2f7jxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kEyLf8LFch+KdsSp/Rnz95CvSLqxxYSUroQ+WOd06N4=;
 b=myXUb7Xw6mt3hQVdZp/SovazAx6L/z73hhGvWKHabtoFTsmmdFVsetSM5+xt/584dZ
 EnUP9CDdYZ1Hwp3D8U5i4Zcew9t0QLK6ta73FHB9MBSW4zNW72GP3LGR2mhjohwyFwsh
 6l0pYHE1F6zqQxBp54/Fo2+xzthrT7rrcs67ZGJ3yJjhhoTbQ55qfzZyT/fFJxKhaCji
 OcoctTD3zq4T+2pKvNLN5UEY47vBWwsPwfXExTi9o9J8JzngJnsNQrv2L/fEqRuJOHXn
 wJxwPpBQaO50X4UOnQylHCtArmHkj3sWzxP+pVXSDFpLqxfizDySTvy1TDLm4NORgK/t
 NkQw==
X-Gm-Message-State: AOAM532397GQvvfcYtMnX+QeeDWVuqRtl2xO5sMKuuaHCZY5RDGI4fQr
 80eyrSNE3+dpjUXwt0nM3DhIFw==
X-Google-Smtp-Source: ABdhPJyNfDQBtBUjLYivTubWHNNG5AjYFEAOzzMzgG9ljqqSdjJuJrr5gIZKubHTvUAbSLegBzpGUA==
X-Received: by 2002:a1c:2d84:: with SMTP id
 t126mr22263460wmt.132.1606733256754; 
 Mon, 30 Nov 2020 02:47:36 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
 by smtp.gmail.com with ESMTPSA id x9sm19719853wru.55.2020.11.30.02.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Nov 2020 02:47:36 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Tomasz Figa <tfiga@chromium.org>,
 Sergey Senozhatsky <senozhatsky@google.com>
Subject: [PATCH v4 1/4] dma-mapping: remove the {alloc,
 free}_noncoherent methods
Date: Mon, 30 Nov 2020 11:47:27 +0100
Message-Id: <20201130104730.27655-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
MIME-Version: 1.0
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

From: Christoph Hellwig <hch@lst.de>

It turns out allowing non-contigous allocations here was a rather bad
idea, as we'll now need to define ways to get the pages for mmaping
or dma_buf sharing.  Revert this change and stick to the original
concept.  A different API for the use case of non-contigous allocations
will be added back later.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c   | 30 ------------------------------
 include/linux/dma-map-ops.h |  5 -----
 kernel/dma/mapping.c        | 33 ++++++---------------------------
 3 files changed, 6 insertions(+), 62 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 0cbcd3fc3e7e..73249732afd3 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1054,34 +1054,6 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 	return cpu_addr;
 }
 
-#ifdef CONFIG_DMA_REMAP
-static void *iommu_dma_alloc_noncoherent(struct device *dev, size_t size,
-		dma_addr_t *handle, enum dma_data_direction dir, gfp_t gfp)
-{
-	if (!gfpflags_allow_blocking(gfp)) {
-		struct page *page;
-
-		page = dma_common_alloc_pages(dev, size, handle, dir, gfp);
-		if (!page)
-			return NULL;
-		return page_address(page);
-	}
-
-	return iommu_dma_alloc_remap(dev, size, handle, gfp | __GFP_ZERO,
-				     PAGE_KERNEL, 0);
-}
-
-static void iommu_dma_free_noncoherent(struct device *dev, size_t size,
-		void *cpu_addr, dma_addr_t handle, enum dma_data_direction dir)
-{
-	__iommu_dma_unmap(dev, handle, size);
-	__iommu_dma_free(dev, size, cpu_addr);
-}
-#else
-#define iommu_dma_alloc_noncoherent		NULL
-#define iommu_dma_free_noncoherent		NULL
-#endif /* CONFIG_DMA_REMAP */
-
 static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		unsigned long attrs)
@@ -1152,8 +1124,6 @@ static const struct dma_map_ops iommu_dma_ops = {
 	.free			= iommu_dma_free,
 	.alloc_pages		= dma_common_alloc_pages,
 	.free_pages		= dma_common_free_pages,
-	.alloc_noncoherent	= iommu_dma_alloc_noncoherent,
-	.free_noncoherent	= iommu_dma_free_noncoherent,
 	.mmap			= iommu_dma_mmap,
 	.get_sgtable		= iommu_dma_get_sgtable,
 	.map_page		= iommu_dma_map_page,
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index a5f89fc4d6df..3d1f91464bcf 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -22,11 +22,6 @@ struct dma_map_ops {
 			gfp_t gfp);
 	void (*free_pages)(struct device *dev, size_t size, struct page *vaddr,
 			dma_addr_t dma_handle, enum dma_data_direction dir);
-	void *(*alloc_noncoherent)(struct device *dev, size_t size,
-			dma_addr_t *dma_handle, enum dma_data_direction dir,
-			gfp_t gfp);
-	void (*free_noncoherent)(struct device *dev, size_t size, void *vaddr,
-			dma_addr_t dma_handle, enum dma_data_direction dir);
 	int (*mmap)(struct device *, struct vm_area_struct *,
 			void *, dma_addr_t, size_t, unsigned long attrs);
 
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 51bb8fa8eb89..d3032513c54b 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -514,40 +514,19 @@ EXPORT_SYMBOL_GPL(dma_free_pages);
 void *dma_alloc_noncoherent(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp)
 {
-	const struct dma_map_ops *ops = get_dma_ops(dev);
-	void *vaddr;
-
-	if (!ops || !ops->alloc_noncoherent) {
-		struct page *page;
-
-		page = dma_alloc_pages(dev, size, dma_handle, dir, gfp);
-		if (!page)
-			return NULL;
-		return page_address(page);
-	}
+	struct page *page;
 
-	size = PAGE_ALIGN(size);
-	vaddr = ops->alloc_noncoherent(dev, size, dma_handle, dir, gfp);
-	if (vaddr)
-		debug_dma_map_page(dev, virt_to_page(vaddr), 0, size, dir,
-				   *dma_handle);
-	return vaddr;
+	page = dma_alloc_pages(dev, size, dma_handle, dir, gfp);
+	if (!page)
+		return NULL;
+	return page_address(page);
 }
 EXPORT_SYMBOL_GPL(dma_alloc_noncoherent);
 
 void dma_free_noncoherent(struct device *dev, size_t size, void *vaddr,
 		dma_addr_t dma_handle, enum dma_data_direction dir)
 {
-	const struct dma_map_ops *ops = get_dma_ops(dev);
-
-	if (!ops || !ops->free_noncoherent) {
-		dma_free_pages(dev, size, virt_to_page(vaddr), dma_handle, dir);
-		return;
-	}
-
-	size = PAGE_ALIGN(size);
-	debug_dma_unmap_page(dev, dma_handle, size, dir);
-	ops->free_noncoherent(dev, size, vaddr, dma_handle, dir);
+	dma_free_pages(dev, size, virt_to_page(vaddr), dma_handle, dir);
 }
 EXPORT_SYMBOL_GPL(dma_free_noncoherent);
 
-- 
2.29.2.454.gaff20da3a2-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
