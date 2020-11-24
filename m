Return-Path: <SRS0=f5WA=E6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A694C63798
	for <iommu@archiver.kernel.org>; Tue, 24 Nov 2020 15:38:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA70B20715
	for <iommu@archiver.kernel.org>; Tue, 24 Nov 2020 15:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n2RkEURO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA70B20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 331AC860A2;
	Tue, 24 Nov 2020 15:38:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7C9CJRkrcdsV; Tue, 24 Nov 2020 15:38:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D80B1860A3;
	Tue, 24 Nov 2020 15:38:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD7C7C163C;
	Tue, 24 Nov 2020 15:38:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E94B9C0052
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 15:38:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D5276204E1
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 15:38:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GdwvxujJ6Nsk for <iommu@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 15:38:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by silver.osuosl.org (Postfix) with ESMTPS id D0BC32039C
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 15:38:50 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id m6so22751011wrg.7
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 07:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=mn1wB4UIIJYCPFpu55sy3LOHzNh5rEWUlXSp9HWhrTs=;
 b=n2RkEUROrYeufAtCSKDWr3fmq/B5Dj/1/iujvWXNBpKVXM46G14POxuNtrvFGvG4xS
 65IlJ8mFMtlZ+DEw0CCukK4ngUegaZeo8SVlB1Gy+ncs+XC07IzM0JfpHRFMuhx4DL+q
 Rc6TA7y3GVyTSBWrC+0pOexy8rwtT88yGy6aM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mn1wB4UIIJYCPFpu55sy3LOHzNh5rEWUlXSp9HWhrTs=;
 b=VYDjyI5K+kgI5AAw6KB694qc2EUelJmgcWo6HbD66WQ8MkPcPD5OJ9IX5wWYHRUdul
 nC0uDOZuU2rGKSFlXgrS3jWpBlmhyMURI8Ja9AXDUj/cWYH6/ax5dMLWwlGDmHKW99K5
 OwgByyPhq7xmtqh3WUYLoP/o1SaGGDGGazaBLHmmrDkE0Gnk9o0bo36BvVdoSC1ZzRxm
 3a9SRvcNEgmCY2+9KH3QRVHIeixnl7ZZ0s7WNYjEf7J36ilgGGI4YpWYXH8JLa2C/2b9
 KD1WKl9c9jQMiwtWgCI9MUZgXOWHS+XKioP2SsMlJj6Q/UYvTo9RYYUQi3JUHC0MZwqh
 b3+Q==
X-Gm-Message-State: AOAM5304bUyv8QS0U3QJbzCJjO3vGLq8SLJXC/9sqi0yZQ3ZVskTO+nB
 5/0J4sgW5E3UJqU3fZ7R43YUYw==
X-Google-Smtp-Source: ABdhPJzJQS12dAtHSIto+AkUackkC3dZ1AW4aqhTl1qwf4siZheZKe0WXY06YOIImYJlDwLUTKFQtw==
X-Received: by 2002:adf:e80b:: with SMTP id o11mr5939427wrm.409.1606232329253; 
 Tue, 24 Nov 2020 07:38:49 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
 by smtp.gmail.com with ESMTPSA id 25sm5814752wmk.19.2020.11.24.07.38.48
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
Subject: [PATCH 3/6] dma-iommu: remove __iommu_dma_mmap
Date: Tue, 24 Nov 2020 16:38:42 +0100
Message-Id: <20201124153845.132207-3-ribalda@chromium.org>
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

The function has a single caller, so open code it there and take
advantage of the precalculated page count variable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 73249732afd3..a2fb92de7e3d 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -655,21 +655,6 @@ static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
 	return NULL;
 }
 
-/**
- * __iommu_dma_mmap - Map a buffer into provided user VMA
- * @pages: Array representing buffer from __iommu_dma_alloc()
- * @size: Size of buffer in bytes
- * @vma: VMA describing requested userspace mapping
- *
- * Maps the pages of the buffer in @pages into @vma. The caller is responsible
- * for verifying the correct size and protection of @vma beforehand.
- */
-static int __iommu_dma_mmap(struct page **pages, size_t size,
-		struct vm_area_struct *vma)
-{
-	return vm_map_pages(vma, pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
-}
-
 static void iommu_dma_sync_single_for_cpu(struct device *dev,
 		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
 {
@@ -1074,7 +1059,7 @@ static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 		struct page **pages = dma_common_find_pages(cpu_addr);
 
 		if (pages)
-			return __iommu_dma_mmap(pages, size, vma);
+			return vm_map_pages(vma, pages, nr_pages);
 		pfn = vmalloc_to_pfn(cpu_addr);
 	} else {
 		pfn = page_to_pfn(virt_to_page(cpu_addr));
-- 
2.29.2.454.gaff20da3a2-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
