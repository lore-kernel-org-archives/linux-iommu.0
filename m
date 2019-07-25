Return-Path: <SRS0=la/L=VW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE346C76190
	for <iommu@archiver.kernel.org>; Thu, 25 Jul 2019 23:39:23 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6895216C8
	for <iommu@archiver.kernel.org>; Thu, 25 Jul 2019 23:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCSc5VKh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6895216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 81E6AD4F;
	Thu, 25 Jul 2019 23:39:20 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E7362C9B
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Jul 2019 23:39:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
	[209.85.215.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 73094224
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Jul 2019 23:39:19 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id i18so23796963pgl.11
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Jul 2019 16:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=Qb5GlbT5oRwfebW1ImXtM5bG47Oz77J5wvpz7YyCVFg=;
	b=nCSc5VKhxwyBBY+io5v2EU4LmfbPxG7yc7J4Ue6nivlL3+cyvkZNSC4dG5+/TvUGMX
	oZFQuIiY28/1mMSAcMnRwqM7tnjUjSN2RHqh0iM11R/1NY2K2xNBVxPLjNrw6vmXMKY1
	rFYeJfubS4E0qNQMd1TG6+jRJgEszqUiOgyQ0rV9uttMM/pVEvon4lqH7z/tsdsCmKun
	85L0t6DmsLcLnzeg6I+ENnUfPWS92s0xOVtWuTbMxb5rVM+M6LhqQ+RVKYOaA3pqnd7R
	Ju0+3K0rIWUwSe/uXK5+8uLaA88936YA1ss4A1sePUDOY6FEafuch7oY1W1xGd4qs1JQ
	3ARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=Qb5GlbT5oRwfebW1ImXtM5bG47Oz77J5wvpz7YyCVFg=;
	b=BUUs5uS7wESxPPdUd8RpS8lGQ0LdbTiTMpxdxBpPZW9SxqI8fAp+7ggyyNwcGmj8zp
	jUJ2sxP3YVMgv1QHJDX7SN0yLnyKmIEeEOHHe3SCj2HKasoen5XHvkIIjKvcESFrb2B0
	Uuy4FG0PShJ15zNYzCk0h5/Y71e8s+r9pN4ALlrxs3mlVhpczzLyaF+Btvd4l2aacm/X
	wzGkLki8SegshrCzm2fOi5wJBbz1RF0rmTmMndX9gHvt9Dhm9kuFDqBcIoxBFvr7vaZc
	b0SXpo1NdO8bSairV+1ENi4BKF3hBsPQdzAv2BUzZSB6EVBDXds2f9RIKKlzBTxgsYmk
	ODwg==
X-Gm-Message-State: APjAAAWxEPlN9c9Y1/2ZL6zotMfmAQUdXq7LBdOOD97Legde6d9tAH34
	l7sJbgf7Z9csBpotJ08/9h0=
X-Google-Smtp-Source: APXvYqy+eSwP6aQkglHfZe1RAu+qlAMmmADJww47C3BbP80k+lMGPeMUWAbC5133OBIS2D2WC5qmog==
X-Received: by 2002:a63:1908:: with SMTP id z8mr86257801pgl.433.1564097958917; 
	Thu, 25 Jul 2019 16:39:18 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
	[216.228.112.22]) by smtp.gmail.com with ESMTPSA id
	f72sm70888203pjg.10.2019.07.25.16.39.17
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 25 Jul 2019 16:39:18 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: dafna.hirschfeld@collabora.com, hch@lst.de, m.szyprowski@samsung.com,
	robin.murphy@arm.com
Subject: [PATCH 1/2] dma-contiguous: do not overwrite align in
	dma_alloc_contiguous()
Date: Thu, 25 Jul 2019 16:39:58 -0700
Message-Id: <20190725233959.15129-2-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190725233959.15129-1-nicoleotsuka@gmail.com>
References: <20190725233959.15129-1-nicoleotsuka@gmail.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

The dma_alloc_contiguous() limits align at CONFIG_CMA_ALIGNMENT for
cma_alloc() however it does not restore it for the fallback routine.
This will result in a size mismatch between the allocation and free
when running in the fallback routines, if the align is larger than
CONFIG_CMA_ALIGNMENT.

This patch adds a cma_align to take care of cma_alloc() and prevent
the align from being overwritten.

Fixes: fdaeec198ada ("dma-contiguous: add dma_{alloc,free}_contiguous() helpers")
Reported-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 kernel/dma/contiguous.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index bfc0c17f2a3d..fa8cd0f0512e 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -233,6 +233,7 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
 	int node = dev ? dev_to_node(dev) : NUMA_NO_NODE;
 	size_t count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	size_t align = get_order(PAGE_ALIGN(size));
+	size_t cma_align = CONFIG_CMA_ALIGNMENT;
 	struct page *page = NULL;
 	struct cma *cma = NULL;
 
@@ -241,11 +242,11 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
 	else if (count > 1)
 		cma = dma_contiguous_default_area;
 
+	cma_align = min_t(size_t, align, cma_align);
+
 	/* CMA can be used only in the context which permits sleeping */
-	if (cma && gfpflags_allow_blocking(gfp)) {
-		align = min_t(size_t, align, CONFIG_CMA_ALIGNMENT);
-		page = cma_alloc(cma, count, align, gfp & __GFP_NOWARN);
-	}
+	if (cma && gfpflags_allow_blocking(gfp))
+		page = cma_alloc(cma, count, cma_align, gfp & __GFP_NOWARN);
 
 	/* Fallback allocation of normal pages */
 	if (!page)
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
