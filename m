Return-Path: <SRS0=6oxg=MB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182C0C07E99
	for <iommu@archiver.kernel.org>; Fri,  9 Jul 2021 03:35:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA52961447
	for <iommu@archiver.kernel.org>; Fri,  9 Jul 2021 03:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA52961447
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C7FC83CC5;
	Fri,  9 Jul 2021 03:35:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9oYs_zjN8LTV; Fri,  9 Jul 2021 03:35:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AA01683CC2;
	Fri,  9 Jul 2021 03:35:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85803C0010;
	Fri,  9 Jul 2021 03:35:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B324C000E
 for <iommu@lists.linux-foundation.org>; Fri,  9 Jul 2021 03:35:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0A145401EF
 for <iommu@lists.linux-foundation.org>; Fri,  9 Jul 2021 03:35:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SxNPn0kkO6-2 for <iommu@lists.linux-foundation.org>;
 Fri,  9 Jul 2021 03:35:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 782B8402AA
 for <iommu@lists.linux-foundation.org>; Fri,  9 Jul 2021 03:35:28 +0000 (UTC)
Received: by mail-pg1-x52c.google.com with SMTP id y17so8560137pgf.12
 for <iommu@lists.linux-foundation.org>; Thu, 08 Jul 2021 20:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2VUfXQzWtFRM7U68C/zyfMuk93kjPlYa9PR0xxD2xic=;
 b=B3jOGSNdch75Pk9zvvAHQWxHiYcXwurhghja4Glu3ELo0CQiPIkJpTVx4MhlAVQzHK
 PsqQZHnJ+jdpSGgw30X1l+4YvHL9SsT5H+Oi9sWXRR1gz2SJC13mAu38I8tejIWNArHB
 Ax+pBWP9zMHVtxVBgDkaoEw9myXHEF1xMrvv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2VUfXQzWtFRM7U68C/zyfMuk93kjPlYa9PR0xxD2xic=;
 b=iR1AwmUUlI3gwHHg1FXqFMSQ8IuXZ3T23OpkSsZdNTYEDCJ3RY90D59EkZhEAxMD42
 IaukOFzwj2I4cJSV+YGJZlofOFPE0Q/SLfPgT8+VSB8pqYL1h7ZbOfAE+uKZswU3lKPV
 7b07RxOyCwfdRSMHakVn5kCbMu71T4iBQ5Q2BbxQWUrp0cOokGqtZEfaByE90CdukAiV
 xIcGt0awxP5BzZVALl9KzmNncVKkL9pyjSSNAuWg0PoVrs0d7K9xothX+4iR17Iz+gbb
 AZoezDFRFmFlKfNJId8pkoeSvwvq295ndk5b6c+rjVgJ8saMZ64Xhxdp7muzkAQcAGqK
 GBLQ==
X-Gm-Message-State: AOAM5305+c40AVe5fHJ0iJuyQqbE/FQN1cnvsP6zBga9TGDUgfM/w7IJ
 mIK5ZXhD3XCWcnJBJhSsFVeDVQ==
X-Google-Smtp-Source: ABdhPJw3/4Aeqw6xIS1A2FgwKChh7mQPgc7V2haArsEw5MbJC4ev9VjMc/Ol2MIfkJ86tzswkqEJyA==
X-Received: by 2002:a63:2009:: with SMTP id g9mr35199752pgg.105.1625801728043; 
 Thu, 08 Jul 2021 20:35:28 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:d47a:af0a:d5b9:e774])
 by smtp.gmail.com with UTF8SMTPSA id u37sm4194501pfg.140.2021.07.08.20.35.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jul 2021 20:35:27 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 3/4] dma-iommu: pass SKIP_CPU_SYNC to swiotlb unmap
Date: Fri,  9 Jul 2021 12:35:01 +0900
Message-Id: <20210709033502.3545820-4-stevensd@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210709033502.3545820-1-stevensd@google.com>
References: <20210709033502.3545820-1-stevensd@google.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>,
 iommu@lists.linux-foundation.org, David Stevens <stevensd@chromium.org>,
 Will Deacon <will@kernel.org>
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

If SKIP_CPU_SYNC isn't already set, then iommu_dma_unmap_(page|sg) has
already called iommu_dma_sync_(single|sg)_for_cpu, so there is no need
to copy from the bounce buffer again.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/iommu/dma-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index e79e274d2dc5..0a9a9a343e64 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -505,7 +505,8 @@ static void __iommu_dma_unmap_swiotlb(struct device *dev, dma_addr_t dma_addr,
 	__iommu_dma_unmap(dev, dma_addr, size);
 
 	if (unlikely(is_swiotlb_buffer(phys)))
-		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
+		swiotlb_tbl_unmap_single(dev, phys, size, dir,
+					 attrs | DMA_ATTR_SKIP_CPU_SYNC);
 }
 
 static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
-- 
2.32.0.93.g670b81a890-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
