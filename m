Return-Path: <SRS0=n9pq=UC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C185AC04AB5
	for <iommu@archiver.kernel.org>; Mon,  3 Jun 2019 22:53:25 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9421D25D83
	for <iommu@archiver.kernel.org>; Mon,  3 Jun 2019 22:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u9zxZmts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9421D25D83
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 51B85E97;
	Mon,  3 Jun 2019 22:53:25 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 24F83E89
	for <iommu@lists.linux-foundation.org>;
	Mon,  3 Jun 2019 22:53:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
	[209.85.210.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id CA2D983A
	for <iommu@lists.linux-foundation.org>;
	Mon,  3 Jun 2019 22:53:02 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id q17so11443186pfq.8
	for <iommu@lists.linux-foundation.org>;
	Mon, 03 Jun 2019 15:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=SImWzVCSt0RY7OufuPO1jNvGlcFHu0kGaxSEDGg7OcE=;
	b=u9zxZmtsdOAxlFYnpVTvm0JmTl0e4S4V86dFQ2UjsLi92P4669mjO2pSvX8fp0M/yE
	NLzfTEjFlhV1T40UVu6TG/BVf4Dgj7BZcHNKpboNcN5MNLeRa7yesEiiJut//VM8p6uU
	I6yhjLE3LT3guizrMcvZkmA/3R0hOophx4mXn2Tlu1s/UMI0h5lXgAcb+NAIBhYJEnsQ
	6VhMteKCmfPCED4sqNNVKitrvY9YYki5KK6e/sbEchY8WK7sK3F3dg38qZe1cCwDIbfP
	YX6V4DQEdXPRC5BZky+wVe39CNXCssN7HHkz05GnkUr99VPuQ4MGvkkp2hyOEGn8pv5G
	lSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=SImWzVCSt0RY7OufuPO1jNvGlcFHu0kGaxSEDGg7OcE=;
	b=U0/8sFKA4CpjIGsUo588GBlUwZ1OMWcvVdhJDQufKVtuq1+4I8FxiOzZDiGnWWfZlH
	oOJ3kEo0yj+qXETqJjFKZSE1Hrqdiqu/m/wAVQEL8kzeXzKAJr+XtjfDCAYqO+rOaqAt
	uvEriY9v1uzx10HpzOwSLX7UPFjnXMbovYi1/9MA7215I0lhqzZMmrWlbRRh5gS4YPK8
	IkCkfw86/4LycVLQy4zUG4K9nwHAhqmNnnoZzMQY1gUam6mBJo45cZPHnLzspPTwZe3O
	ishWnpXHvO2dB4PIXOk+OWBMwej4SHcVnwL2UUTPaGGAn+jIBq01FWDaQ3Ya1vLqBP6m
	iN/g==
X-Gm-Message-State: APjAAAV6wCgxnQBIoJ9ed3RWLKWDgXezaUWf/kjebV4gHZ+ZGlnVVriH
	THlrFAmBxVEgR4he4pwL79E=
X-Google-Smtp-Source: APXvYqy8vLrFqoVL7F3FzM+8IhTHjoTUjZBmrtxoEIRl8qi1kzL0djeX3jRrJKCsLT4K1CSdITr80g==
X-Received: by 2002:a63:5247:: with SMTP id s7mr21370699pgl.29.1559602382249; 
	Mon, 03 Jun 2019 15:53:02 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
	[216.228.112.22]) by smtp.gmail.com with ESMTPSA id
	j37sm7682759pgj.58.2019.06.03.15.53.01
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 15:53:01 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: joro@8bytes.org
Subject: [PATCH] iommu/dma: Apply dma_{alloc,free}_contiguous functions
Date: Mon,  3 Jun 2019 15:52:59 -0700
Message-Id: <20190603225259.21994-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Cc: iommu@lists.linux-foundation.org, hch@lst.de, linux-kernel@vger.kernel.org
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

This patch replaces dma_{alloc,release}_from_contiguous() with
dma_{alloc,free}_contiguous() to simplify those function calls.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/iommu/dma-iommu.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 0cd49c2d3770..cc3d39dbbe1a 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -951,8 +951,8 @@ static void __iommu_dma_free(struct device *dev, size_t size, void *cpu_addr)
 
 	if (pages)
 		__iommu_dma_free_pages(pages, count);
-	if (page && !dma_release_from_contiguous(dev, page, count))
-		__free_pages(page, get_order(alloc_size));
+	if (page)
+		dma_free_contiguous(dev, page, alloc_size);
 }
 
 static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
@@ -970,12 +970,7 @@ static void *iommu_dma_alloc_pages(struct device *dev, size_t size,
 	struct page *page = NULL;
 	void *cpu_addr;
 
-	if (gfpflags_allow_blocking(gfp))
-		page = dma_alloc_from_contiguous(dev, alloc_size >> PAGE_SHIFT,
-						 get_order(alloc_size),
-						 gfp & __GFP_NOWARN);
-	if (!page)
-		page = alloc_pages(gfp, get_order(alloc_size));
+	page = dma_alloc_contiguous(dev, alloc_size, gfp);
 	if (!page)
 		return NULL;
 
@@ -997,8 +992,7 @@ static void *iommu_dma_alloc_pages(struct device *dev, size_t size,
 	memset(cpu_addr, 0, alloc_size);
 	return cpu_addr;
 out_free_pages:
-	if (!dma_release_from_contiguous(dev, page, alloc_size >> PAGE_SHIFT))
-		__free_pages(page, get_order(alloc_size));
+	dma_free_contiguous(dev, page, alloc_size);
 	return NULL;
 }
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
