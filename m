Return-Path: <SRS0=f5WA=E6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D867C2D0E4
	for <iommu@archiver.kernel.org>; Tue, 24 Nov 2020 15:38:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D476C208B8
	for <iommu@archiver.kernel.org>; Tue, 24 Nov 2020 15:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R4iABjEv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D476C208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 59152872E0;
	Tue, 24 Nov 2020 15:38:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ItdtYs4bC3bj; Tue, 24 Nov 2020 15:38:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A9FCB872E2;
	Tue, 24 Nov 2020 15:38:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95887C163C;
	Tue, 24 Nov 2020 15:38:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08C4CC0052
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 15:38:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E46F7872E3
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 15:38:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0hmWToGswRP5 for <iommu@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 15:38:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0F90C872DF
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 15:38:50 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id 64so9353258wra.11
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 07:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=nhjzpN/I0YbMNWZ/cuMZ/ssTNlecoXIrDpTSY4gcP5k=;
 b=R4iABjEvQuBHvnc+z9r2hhUutog05+6ThoWbUMykt7He8q7/Lm2MAV0kmbeONcOsxN
 U2G4j4uIxzcbx66W51sw80c9eTxt/OKrFsuZ2UvdrOfTO25Ud9jfdkZp/nNgFi5xd4uI
 Q/97qiFwUbs+YE8Pkx8HCm4VLRpdrdwGyTIe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nhjzpN/I0YbMNWZ/cuMZ/ssTNlecoXIrDpTSY4gcP5k=;
 b=WKDw+43/o6Q0lRUq8rHJu2Rh4nHjh3E8yKDMSXm+tVHDU8ysiD3h10gX1r6xuZOHhG
 AcjjnBcAk4GvNA0HxvArvVZz1EYjSRnO3pMPuc7oJFEfGVn+Kh3Z77cIxNkJsfNLVRxm
 U4yfPG4QVqZrjpZZ94mkZN0LnKuQ1Zoa8TIS/EiZ/Clgb+xxNg3+ZN1uSOCUbYX6asFF
 VvKdY1ZG4OEA8+D21VsRXtHkY4jqfhSuu7vtxBpapVd/wkpzEIUDBGxXGZdnPMYz2ikN
 Al7yoVNL3ASEMhGGmGpfwVXaLjScwjugX3bRH2gWOrKkR7c6Eoo/OwfP/cD95RXyD+14
 BkKw==
X-Gm-Message-State: AOAM533sLJkr5nHPVdxqruGcVMclTfu5ZO1HesJ6B118KN5BxxUAVqAS
 92mhL7l8xZbiZBth2Q5TIB0Xsw==
X-Google-Smtp-Source: ABdhPJyV94IkqLC3tQEI4e07+BimW/uaxT27Q28R/rp8nTUS06m6LEQw8+T51Xjpu9YZ6o8rFd6DgQ==
X-Received: by 2002:adf:f944:: with SMTP id q4mr5883724wrr.120.1606232328515; 
 Tue, 24 Nov 2020 07:38:48 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
 by smtp.gmail.com with ESMTPSA id 25sm5814752wmk.19.2020.11.24.07.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2020 07:38:48 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
To: Christoph Hellwig <hch@lst.de>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Tomasz Figa <tfiga@chromium.org>,
 Sergey Senozhatsky <senozhatsky@google.com>
Subject: [PATCH 2/6] dma-direct: use __GFP_ZERO in dma_direct_alloc_pages
Date: Tue, 24 Nov 2020 16:38:41 +0100
Message-Id: <20201124153845.132207-2-ribalda@chromium.org>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201124153845.132207-1-ribalda@chromium.org>
References: <20201124153845.132207-1-ribalda@chromium.org>
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

Prepare for supporting the DMA_ATTR_NO_KERNEL_MAPPING flag in
dma_alloc_pages.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/direct.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 06c111544f61..76c741e610fc 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -280,13 +280,12 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp)
 {
 	struct page *page;
-	void *ret;
 
 	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
 	    force_dma_unencrypted(dev) && !gfpflags_allow_blocking(gfp))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
 
-	page = __dma_direct_alloc_pages(dev, size, gfp);
+	page = __dma_direct_alloc_pages(dev, size, gfp | __GFP_ZERO);
 	if (!page)
 		return NULL;
 	if (PageHighMem(page)) {
@@ -300,13 +299,11 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 		goto out_free_pages;
 	}
 
-	ret = page_address(page);
 	if (force_dma_unencrypted(dev)) {
-		if (set_memory_decrypted((unsigned long)ret,
+		if (set_memory_decrypted((unsigned long) page_address(page),
 				1 << get_order(size)))
 			goto out_free_pages;
 	}
-	memset(ret, 0, size);
 	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
 	return page;
 out_free_pages:
-- 
2.29.2.454.gaff20da3a2-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
