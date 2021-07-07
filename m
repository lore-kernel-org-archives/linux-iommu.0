Return-Path: <SRS0=iPMr=L7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3585C07E95
	for <iommu@archiver.kernel.org>; Wed,  7 Jul 2021 07:55:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81F0161C71
	for <iommu@archiver.kernel.org>; Wed,  7 Jul 2021 07:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F0161C71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5FB8660750;
	Wed,  7 Jul 2021 07:55:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iRi_4aWw6sLL; Wed,  7 Jul 2021 07:55:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2852060665;
	Wed,  7 Jul 2021 07:55:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05BF4C0010;
	Wed,  7 Jul 2021 07:55:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D673C000E
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 07:55:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 017D4607F6
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 07:55:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XUK1s7JHy_2h for <iommu@lists.linux-foundation.org>;
 Wed,  7 Jul 2021 07:55:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4523160750
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 07:55:37 +0000 (UTC)
Received: by mail-pf1-x42d.google.com with SMTP id j199so1382782pfd.7
 for <iommu@lists.linux-foundation.org>; Wed, 07 Jul 2021 00:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ryjYxQ0JHh52qusdGDD6YmKhsPnlyH0BzgDH8DG8KYA=;
 b=HCYvRR0u9uRITgyFKUecItQ1ExxSU2pwsas15379OwgRyMa1RB3Ngjh9SOu0pR/kZ5
 DGhsMSPsZ5LOLuewp7BK4HmEVhawxxQvhKL2ppFOWcYi9kpALDCGcLx09cyGRPHgDwiH
 UEgjadQbE0q5ni2p2jA3bOh4hJAN7tCUBaWRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ryjYxQ0JHh52qusdGDD6YmKhsPnlyH0BzgDH8DG8KYA=;
 b=cAzMKnx41tFjLgzE4OMgpOp1clhh62vuI0vY37NCgPFRheNCqkwxLXmuYq2sDwCA9S
 SH/6TkEu7iPr5HjXJnQaRGWuOzT/KqHXnsUUFaL+oW+m4ob9zE5PVUMsvhR/+/h3sRzM
 HUJ5kxyM22s0kj4SPtrxtqNfOassUSuAGDE9Svi/tdSge63l/ZWQjbEQ1Di91YO9caMJ
 REK/lBwB4HXLe2Ho9K5VRAf9FrzNFhaFP13vJ2QQpd0WauZAbwy6QvLzkGmY3dveupQn
 XSOZahONkWY5drMnwUGOgPnTTaTKT8ZDfHxYZchzzKC6/bB7QgmkFB+WCC5ktrYymJ8i
 CARA==
X-Gm-Message-State: AOAM530hoD5VMqK7Chl6MB/ylEpNEDiF5/40+kFRwOBx/ELz2mOMGyv7
 vWKx1pisTtH6RzwcL06SpgA2Ng==
X-Google-Smtp-Source: ABdhPJzPxmiwH8IIxQAEOI9pm5qxtU1muhDEl8mvQwN5aoarWWGwzFw18SkoHg95qnckFoEh/3hE3Q==
X-Received: by 2002:a65:6a45:: with SMTP id o5mr25186342pgu.409.1625644536743; 
 Wed, 07 Jul 2021 00:55:36 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:355a:c470:1237:e5f4])
 by smtp.gmail.com with UTF8SMTPSA id k8sm19181213pfa.142.2021.07.07.00.55.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jul 2021 00:55:36 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 3/4] dma-iommu: expose a few helper functions to module
Date: Wed,  7 Jul 2021 16:55:04 +0900
Message-Id: <20210707075505.2896824-4-stevensd@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210707075505.2896824-1-stevensd@google.com>
References: <20210707075505.2896824-1-stevensd@google.com>
MIME-Version: 1.0
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
 iommu@lists.linux-foundation.org, David Stevens <stevensd@chromium.org>,
 Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
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

From: David Stevens <stevensd@chromium.org>

Expose a few helper functions from dma-iommu to the rest of the module.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/iommu/dma-iommu.c | 27 ++++++++++++++-------------
 include/linux/dma-iommu.h | 12 ++++++++++++
 2 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 98a5c566a303..48267d9f5152 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -413,7 +413,7 @@ static int dma_info_to_prot(enum dma_data_direction dir, bool coherent,
 	}
 }
 
-static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
+dma_addr_t __iommu_dma_alloc_iova(struct iommu_domain *domain,
 		size_t size, u64 dma_limit, struct device *dev)
 {
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
@@ -453,7 +453,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
 	return (dma_addr_t)iova << shift;
 }
 
-static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
+void __iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
 		dma_addr_t iova, size_t size, struct page *freelist)
 {
 	struct iova_domain *iovad = &cookie->iovad;
@@ -489,7 +489,7 @@ static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
 
 	if (!cookie->fq_domain)
 		iommu_iotlb_sync(domain, &iotlb_gather);
-	iommu_dma_free_iova(cookie, dma_addr, size, iotlb_gather.freelist);
+	__iommu_dma_free_iova(cookie, dma_addr, size, iotlb_gather.freelist);
 }
 
 static void __iommu_dma_unmap_swiotlb(struct device *dev, dma_addr_t dma_addr,
@@ -525,12 +525,12 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 
 	size = iova_align(iovad, size + iova_off);
 
-	iova = iommu_dma_alloc_iova(domain, size, dma_mask, dev);
+	iova = __iommu_dma_alloc_iova(domain, size, dma_mask, dev);
 	if (!iova)
 		return DMA_MAPPING_ERROR;
 
 	if (iommu_map_atomic(domain, iova, phys - iova_off, size, prot)) {
-		iommu_dma_free_iova(cookie, iova, size, NULL);
+		__iommu_dma_free_iova(cookie, iova, size, NULL);
 		return DMA_MAPPING_ERROR;
 	}
 	return iova + iova_off;
@@ -585,14 +585,14 @@ static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
 	return iova;
 }
 
-static void __iommu_dma_free_pages(struct page **pages, int count)
+void __iommu_dma_free_pages(struct page **pages, int count)
 {
 	while (count--)
 		__free_page(pages[count]);
 	kvfree(pages);
 }
 
-static struct page **__iommu_dma_alloc_pages(
+struct page **__iommu_dma_alloc_pages(
 		unsigned int count, unsigned long order_mask,
 		unsigned int nid, gfp_t page_gfp, gfp_t kalloc_gfp)
 {
@@ -686,7 +686,8 @@ static struct page **__iommu_dma_alloc_noncontiguous(struct device *dev,
 		return NULL;
 
 	size = iova_align(iovad, size);
-	iova = iommu_dma_alloc_iova(domain, size, dev->coherent_dma_mask, dev);
+	iova = __iommu_dma_alloc_iova(domain, size,
+				      dev->coherent_dma_mask, dev);
 	if (!iova)
 		goto out_free_pages;
 
@@ -712,7 +713,7 @@ static struct page **__iommu_dma_alloc_noncontiguous(struct device *dev,
 out_free_sg:
 	sg_free_table(sgt);
 out_free_iova:
-	iommu_dma_free_iova(cookie, iova, size, NULL);
+	__iommu_dma_free_iova(cookie, iova, size, NULL);
 out_free_pages:
 	__iommu_dma_free_pages(pages, count);
 	return NULL;
@@ -1063,7 +1064,7 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 		prev = s;
 	}
 
-	iova = iommu_dma_alloc_iova(domain, iova_len, dma_get_mask(dev), dev);
+	iova = __iommu_dma_alloc_iova(domain, iova_len, dma_get_mask(dev), dev);
 	if (!iova)
 		goto out_restore_sg;
 
@@ -1077,7 +1078,7 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	return __finalise_sg(dev, sg, nents, iova);
 
 out_free_iova:
-	iommu_dma_free_iova(cookie, iova, iova_len, NULL);
+	__iommu_dma_free_iova(cookie, iova, iova_len, NULL);
 out_restore_sg:
 	__invalidate_sg(sg, nents);
 	return 0;
@@ -1370,7 +1371,7 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 	if (!msi_page)
 		return NULL;
 
-	iova = iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
+	iova = __iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
 	if (!iova)
 		goto out_free_page;
 
@@ -1384,7 +1385,7 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 	return msi_page;
 
 out_free_iova:
-	iommu_dma_free_iova(cookie, iova, size, NULL);
+	__iommu_dma_free_iova(cookie, iova, size, NULL);
 out_free_page:
 	kfree(msi_page);
 	return NULL;
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 6e75a2d689b4..fc9acc581db0 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -42,6 +42,18 @@ void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
 
 extern bool iommu_dma_forcedac;
 
+struct iommu_dma_cookie;
+
+struct page **__iommu_dma_alloc_pages(
+		unsigned int count, unsigned long order_mask,
+		unsigned int nid, gfp_t page_gfp, gfp_t kalloc_gfp);
+void __iommu_dma_free_pages(struct page **pages, int count);
+dma_addr_t __iommu_dma_alloc_iova(struct iommu_domain *domain,
+				  size_t size, dma_addr_t dma_limit,
+				  struct device *dev);
+void __iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
+		dma_addr_t iova, size_t size, struct page *freelist);
+
 #else /* CONFIG_IOMMU_DMA */
 
 struct iommu_domain;
-- 
2.32.0.93.g670b81a890-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
