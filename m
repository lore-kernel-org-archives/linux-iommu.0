Return-Path: <SRS0=iPMr=L7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77185C07E95
	for <iommu@archiver.kernel.org>; Wed,  7 Jul 2021 07:55:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CBA161CB0
	for <iommu@archiver.kernel.org>; Wed,  7 Jul 2021 07:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CBA161CB0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 058A38336D;
	Wed,  7 Jul 2021 07:55:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8bWj9MGAbni7; Wed,  7 Jul 2021 07:55:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F393A83323;
	Wed,  7 Jul 2021 07:55:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1140C0010;
	Wed,  7 Jul 2021 07:55:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8118FC000E
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 07:55:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7067B40583
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 07:55:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ccg7v4Be5l1q for <iommu@lists.linux-foundation.org>;
 Wed,  7 Jul 2021 07:55:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CCB9140613
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 07:55:33 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id
 g6-20020a17090adac6b029015d1a9a6f1aso3023146pjx.1
 for <iommu@lists.linux-foundation.org>; Wed, 07 Jul 2021 00:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cToOui4d+OiABBRcG8ci3JrCJ5BQZEaQcOXHYFcfixY=;
 b=Y577CLwATY/3F7YXuLJcuDjsBRjJ+1FtjazpSrT89WalorRG93N/J6qBhjLWCNYT7m
 aIxrlk1dkoZFedgFnVw226XxMNJ2H0IYuvwj95T3SelmL6HkW1rYWMe7LMo7DC8tl2oO
 iegPa741y9SwsFEwxOf4fMPTzEeKLrm3mWP7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cToOui4d+OiABBRcG8ci3JrCJ5BQZEaQcOXHYFcfixY=;
 b=gP0F3YYITlSKKiG9XPB1yLqTwRC8gI5MDuGN2VsyvW/Bck65XSEuinpIVT2019d1QQ
 PfsA780VpdtoCp4VsiofLqpCxZfj2KDF6wWhYRu3WxUpmJo3keSrPhDeW3yzYsaCJ/Tq
 9MrNhS7Dy61BJuLIGka5+48wM9JR4PsyLrrwmWE1WnjBofDjyQTUJC+W6Qqs4tL1XtHs
 rYxTgUOQSPoX/a7SMJP6qaWMUYhwqJCdtfOv7q4O1k0FTPzQ/c+AUp2zexj1N0DJ+UnV
 H7OZBCQh2ayVbFdr2XhpLORG+4QN/eW18JMBO9WdbZ6wZiA8q+pP37UUEaH8/y7wamBQ
 UObA==
X-Gm-Message-State: AOAM533pkDdQf9bNM7pC78TJUY1wJ+3tYQpjhBGirtpH31fQw6Q4w8nF
 5bRD0TwUycENPtyrAIX7qF0IOQ==
X-Google-Smtp-Source: ABdhPJytwgB4PyVy/jCTPPLKNdsrNeknF2nCwebdVINIzGapAzHQp2ce15AkhnT6tXL1YPoeVHUnKA==
X-Received: by 2002:a17:90a:a107:: with SMTP id s7mr4699704pjp.1.1625644533123; 
 Wed, 07 Jul 2021 00:55:33 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:355a:c470:1237:e5f4])
 by smtp.gmail.com with UTF8SMTPSA id q18sm19276962pfj.178.2021.07.07.00.55.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jul 2021 00:55:32 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 2/4] dma-iommu: replace device arguments
Date: Wed,  7 Jul 2021 16:55:03 +0900
Message-Id: <20210707075505.2896824-3-stevensd@google.com>
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

Replace the struct device argument with the device's nid in
__iommu_dma_alloc_pages, since it doesn't need the whole struct. This
allows it to be called from places which don't have access to the
device.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/iommu/dma-iommu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 00993b56c977..98a5c566a303 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -592,12 +592,12 @@ static void __iommu_dma_free_pages(struct page **pages, int count)
 	kvfree(pages);
 }
 
-static struct page **__iommu_dma_alloc_pages(struct device *dev,
+static struct page **__iommu_dma_alloc_pages(
 		unsigned int count, unsigned long order_mask,
-		gfp_t page_gfp, gfp_t kalloc_gfp)
+		unsigned int nid, gfp_t page_gfp, gfp_t kalloc_gfp)
 {
 	struct page **pages;
-	unsigned int i = 0, nid = dev_to_node(dev);
+	unsigned int i = 0;
 
 	order_mask &= (2U << MAX_ORDER) - 1;
 	if (!order_mask)
@@ -680,8 +680,8 @@ static struct page **__iommu_dma_alloc_noncontiguous(struct device *dev,
 		alloc_sizes = min_size;
 
 	count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	pages = __iommu_dma_alloc_pages(dev, count, alloc_sizes >> PAGE_SHIFT,
-					gfp, GFP_KERNEL);
+	pages = __iommu_dma_alloc_pages(count, alloc_sizes >> PAGE_SHIFT,
+					dev_to_node(dev), gfp, GFP_KERNEL);
 	if (!pages)
 		return NULL;
 
-- 
2.32.0.93.g670b81a890-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
