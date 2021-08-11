Return-Path: <SRS0=mUms=NC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D6EC4338F
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 02:44:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5E1E60EE7
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 02:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D5E1E60EE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 913A440458;
	Wed, 11 Aug 2021 02:44:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nBphqM0-ZVLj; Wed, 11 Aug 2021 02:44:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 05E234018D;
	Wed, 11 Aug 2021 02:44:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5D45C0010;
	Wed, 11 Aug 2021 02:44:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0AC1AC000E
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 02:44:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EF22160855
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 02:44:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 53EcURHFJRZc for <iommu@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 02:44:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 14B996078A
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 02:44:10 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id w14so1097578pjh.5
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 19:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=STvZImlSg453zxS/WPOwXGrHy946aGM7gL5fircHQaY=;
 b=g0dnUO8gTU16GFKNQ5dbkY/g0YXcD9c2FT5bQMhIz1w4vbHr7Y0Fvh/GVEzJBkarx6
 mW68D65LMEPgcaq4NOh2lyk925jd+XdTARj08VOh/+BrdWwI1t1r8Q+XV/LCjqanXGny
 gLCYFbM4WEdFAkw2fhgKHA0dNM4rPz6OJEtc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=STvZImlSg453zxS/WPOwXGrHy946aGM7gL5fircHQaY=;
 b=WoF6k6MRtoHs9ijhme0XxPKl05X2oVKCqt1X4HlIzIoL7ZfvXnwyH6hzlbjiNa9IHM
 +7ZKe1AoDPwxKqadfAG5dy6kwcoX43DRqTlhxj91ZYOraD+hfor4EfzFCds21y0/LLkR
 LKSuCt7tuc0jjD9FBnZnoAOgKgIMO8/NdayQvax1+EoGGY1cLMZyxkyre5ojc2KGoVly
 EhHeUWEaAGqb6QDQ0DJLImGCNaqGgFgeY594wbpb/MenN/ctFUj50q/bnQS1CV1XsDD8
 6xr/6g5pLOjnpBawl3Xu4vEu/EHyxRaGFsUI24/vD297AX1UDr/kRtoKQcEg3W/TkVgj
 Lnlw==
X-Gm-Message-State: AOAM530Mexd/dWOUEKDyYoPemx3vDJ+hsz4O1PtqhzfOh83itmh7jZMr
 OJziitenWA7Ga/LwlXLAEABP0A==
X-Google-Smtp-Source: ABdhPJz+MiNNCQ88y5aE8tMHgImssnVqQZfCSaUyrQcTLh26+HYsTzqJXH3Vb4kkceHTlSB3xOeGfQ==
X-Received: by 2002:a17:902:7d88:b029:12d:3f9a:d34 with SMTP id
 a8-20020a1709027d88b029012d3f9a0d34mr5384873plm.13.1628649850589; 
 Tue, 10 Aug 2021 19:44:10 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:1e5c:70cb:3289:1b5b])
 by smtp.gmail.com with UTF8SMTPSA id v1sm30068736pgj.40.2021.08.10.19.44.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Aug 2021 19:44:10 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH v3 1/5] dma-iommu: fix sync_sg with swiotlb
Date: Wed, 11 Aug 2021 11:42:43 +0900
Message-Id: <20210811024247.1144246-2-stevensd@google.com>
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

The is_swiotlb_buffer function takes the physical address of the swiotlb
buffer, not the physical address of the original buffer. The sglist
contains the physical addresses of the original buffer, so for the
sync_sg functions to work properly when a bounce buffer might have been
used, we need to use iommu_iova_to_phys to look up the physical address.
This is what sync_single does, so call that function on each sglist
segment.

The previous code mostly worked because swiotlb does the transfer on map
and unmap. However, any callers which use DMA_ATTR_SKIP_CPU_SYNC with
sglists or which call sync_sg would not have had anything copied to the
bounce buffer.

Fixes: 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers")
Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/iommu/dma-iommu.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 98ba927aee1a..54e103b989d9 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -813,14 +813,13 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
 	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
 		return;
 
-	for_each_sg(sgl, sg, nelems, i) {
-		if (!dev_is_dma_coherent(dev))
+	if (dev_is_untrusted(dev))
+		for_each_sg(sgl, sg, nelems, i)
+			iommu_dma_sync_single_for_cpu(dev, sg_dma_address(sg),
+						      sg->length, dir);
+	else
+		for_each_sg(sgl, sg, nelems, i)
 			arch_sync_dma_for_cpu(sg_phys(sg), sg->length, dir);
-
-		if (is_swiotlb_buffer(sg_phys(sg)))
-			swiotlb_sync_single_for_cpu(dev, sg_phys(sg),
-						    sg->length, dir);
-	}
 }
 
 static void iommu_dma_sync_sg_for_device(struct device *dev,
@@ -833,14 +832,14 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
 	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
 		return;
 
-	for_each_sg(sgl, sg, nelems, i) {
-		if (is_swiotlb_buffer(sg_phys(sg)))
-			swiotlb_sync_single_for_device(dev, sg_phys(sg),
-						       sg->length, dir);
-
-		if (!dev_is_dma_coherent(dev))
+	if (dev_is_untrusted(dev))
+		for_each_sg(sgl, sg, nelems, i)
+			iommu_dma_sync_single_for_device(dev,
+							 sg_dma_address(sg),
+							 sg->length, dir);
+	else
+		for_each_sg(sgl, sg, nelems, i)
 			arch_sync_dma_for_device(sg_phys(sg), sg->length, dir);
-	}
 }
 
 static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
-- 
2.32.0.605.g8dce9f2422-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
