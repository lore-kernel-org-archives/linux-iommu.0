Return-Path: <SRS0=mUms=NC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C04DC4338F
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 02:44:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 020F560EE7
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 02:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 020F560EE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B745660857;
	Wed, 11 Aug 2021 02:44:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YgO8EZbA6oJt; Wed, 11 Aug 2021 02:44:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4BC946078A;
	Wed, 11 Aug 2021 02:44:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36B7EC0010;
	Wed, 11 Aug 2021 02:44:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B213C0022
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 02:44:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3DA4A402B4
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 02:44:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GdfbcgNtHMYI for <iommu@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 02:44:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7C63740273
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 02:44:18 +0000 (UTC)
Received: by mail-pl1-x636.google.com with SMTP id a5so744570plh.5
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 19:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FhJsQrtI0mlERMxw9DUQORRBKVECLUnsn0dwH6DWscI=;
 b=GaECZtBIkJz6AyK40abK6J/+xb1of30F2yKMSOfbnFJzZa+eIrW9GbunW+ibsd9In3
 7Kc5Pg0qEdwK3TJRv5MsTWa+CRah7ae+e1BOe+EFrRArcSSxhsolZ43znN4wQRc1PCPu
 nPEKIZszTZB/NEcILNd/AZkE7jqyO4WOqXV1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FhJsQrtI0mlERMxw9DUQORRBKVECLUnsn0dwH6DWscI=;
 b=eXsFYvr1QAGrdk9rPbxO6YoSpLG3gDak3SzZ1QtkajMaQskrcDoF3JU6YT1YAbcs1W
 jW97o330lBKGkv/1SvtUiuM0sLXtVIqsL72mqVONKBpdFUbbq+UH8YL2MeB2BbB1UcS5
 XfyByxUumahG4L5a0ikGxXIUEuTDiJ2YkrRvr4nRHvtbe+Vnv61H6dXq8mWZOrLDyxcY
 +fFkeWy4xiKI7NWc8KqW7X8qSQH6HYW9WB82nelqS69eZ8X9JxMJQA6nb2jyiSuRnrvE
 URWWy5SiD+ouQG6sLRegIP8RczMXgY0ikG3HASu6ht18Et8U5mfG8lQTEQz4YkKQ7mX5
 Js3A==
X-Gm-Message-State: AOAM533jxbIjfV8Ex0aivOrdzgPw4qWqu1gaZQR4H6hs/AKvvroRVMKG
 l1DBQjyLcsYl1H+oZ3jjfmearg==
X-Google-Smtp-Source: ABdhPJywf14WhUCr12O+J7cLL1Oy8A8X6l/SjDM/es4+ywB1SrthLhZtomuPe2Vx+un8ayRcrCU0eQ==
X-Received: by 2002:a63:5506:: with SMTP id j6mr853602pgb.19.1628649858038;
 Tue, 10 Aug 2021 19:44:18 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:1e5c:70cb:3289:1b5b])
 by smtp.gmail.com with UTF8SMTPSA id k6sm10298046pjj.52.2021.08.10.19.44.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Aug 2021 19:44:17 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH v3 3/5] dma-iommu: add SKIP_CPU_SYNC after syncing
Date: Wed, 11 Aug 2021 11:42:45 +0900
Message-Id: <20210811024247.1144246-4-stevensd@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
In-Reply-To: <20210811024247.1144246-1-stevensd@google.com>
References: <20210811024247.1144246-1-stevensd@google.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>,
 iommu@lists.linux-foundation.org, David Stevens <stevensd@chromium.org>
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

After syncing in map/unmap, add the DMA_ATTR_SKIP_CPU_SYNC flag so
anything that uses attrs later on will skip any sync work that has
already been completed. In particular, this skips copying from the
swiotlb twice during unmap.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/iommu/dma-iommu.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 4f0cc4a0a61f..be0214b1455c 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -859,8 +859,11 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
 		iommu_dma_sync_single_for_cpu(dev, dma_handle, size, dir);
+		attrs |= DMA_ATTR_SKIP_CPU_SYNC;
+	}
+
 	__iommu_dma_unmap_swiotlb(dev, dma_handle, size, dir, attrs);
 }
 
@@ -999,8 +1002,10 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	if (dev_is_untrusted(dev))
 		return iommu_dma_map_sg_swiotlb(dev, sg, nents, dir, attrs);
 
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
 		iommu_dma_sync_sg_for_device(dev, sg, nents, dir);
+		attrs |= DMA_ATTR_SKIP_CPU_SYNC;
+	}
 
 	/*
 	 * Work out how much IOVA space we need, and align the segments to
@@ -1068,8 +1073,10 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 	struct scatterlist *tmp;
 	int i;
 
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
 		iommu_dma_sync_sg_for_cpu(dev, sg, nents, dir);
+		attrs |= DMA_ATTR_SKIP_CPU_SYNC;
+	}
 
 	if (dev_is_untrusted(dev)) {
 		iommu_dma_unmap_sg_swiotlb(dev, sg, nents, dir, attrs);
-- 
2.32.0.605.g8dce9f2422-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
