Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 581C2C433FE
	for <iommu@archiver.kernel.org>; Tue, 31 May 2022 21:51:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E089441737;
	Tue, 31 May 2022 21:51:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vDWTbE7rJGpb; Tue, 31 May 2022 21:51:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 71A6F41731;
	Tue, 31 May 2022 21:51:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3783EC0032;
	Tue, 31 May 2022 21:51:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65522C002D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 21:51:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4512F41736
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 21:51:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YNxlVx1ko0fC for <iommu@lists.linux-foundation.org>;
 Tue, 31 May 2022 21:51:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0A74941731
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 21:51:09 +0000 (UTC)
Received: by mail-pf1-x42c.google.com with SMTP id 187so122818pfu.9
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 14:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=B9FwC67kdV1Qhd0VfAGvYEKiy1HjaP02OHwCopLdlrk=;
 b=UXkot/AAjsbfd2YxXonkpfjWoJWPHa9e2I3jq/G3iGrnZnG4gcDZrF9eCcyJrwi+Ad
 P8P60say7nteVz4Lu0KbuwtEHmo/B1bGiu2/yNBW+hwKK1Mrf0sth2PeBJDlfPO4hcEk
 kwWqmV2l+RPk30kJc1tI1HefHk1Mb3QPCw4ZkaEqZQ0pBbp6kDtkgDEAt+bcMv9did6b
 uVAYVi3DY1mzl4BNAJHqqvx2ZSRGRyBwQ31eiX3yxaNWrJkcZxYfhwILXw4gl+7zF8PF
 8Ml5qqbrxWltikDVQHCPf/+dNc6Zvb9PFJvKLQK4sI7alUJ7boSKgJHxzl2SdzIhRH5V
 HswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=B9FwC67kdV1Qhd0VfAGvYEKiy1HjaP02OHwCopLdlrk=;
 b=Srq4gAPjUFdqmYEPSwzQ9pL95EFN8vs9GXmXHy+9sONZukBrlcASxo4XWRuHPOC+aM
 Yyk30rzcdOTywNe1XCDhQwkj9PMy6OCx2uMl+ZoFPkDyC6/yk1naGyNSCIIlXxKdFbq8
 DIu73PbrHO/cxkaQAkeurpVx7l3W1wRCswEbbPqVdK2xsBndKnfjcRG8UMwyvSdy3GIt
 J5x8QdifQWyydxHdN67h7sJl7TwBCctmRo9Kr4dFcI5+rNRy97bIAKf8aA4v+iKvAWq7
 qmXo5sySpzZ1kTwXbbyNELnz85uokAYh9g1elkmuj7UD/zixL2vXT66vGVl1mlND9j+8
 /qWg==
X-Gm-Message-State: AOAM533AVFHFAhvktppU3W17skjnKxp2puOzzqPkWJtO2z7sgk8qdIbq
 NXp1mmeySzzgbe4ashmbLkg=
X-Google-Smtp-Source: ABdhPJyuMvsm/NRmorMJqRxBRNiHArx79tqFW/gO7U6IBR7sfrrK6kJgo4/ofqYcX4K4Iuzd3he0Lg==
X-Received: by 2002:a62:d45e:0:b0:51b:4d60:cda4 with SMTP id
 u30-20020a62d45e000000b0051b4d60cda4mr11758399pfl.17.1654033869377; 
 Tue, 31 May 2022 14:51:09 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
 by smtp.gmail.com with ESMTPSA id
 w8-20020a1709026f0800b001640a74624dsm36981plk.24.2022.05.31.14.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 May 2022 14:51:08 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] dma-debug: Make things less spammy under memory pressure
Date: Tue, 31 May 2022 14:51:06 -0700
Message-Id: <20220531215106.192271-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Cc: Rob Clark <robdclark@chromium.org>, linux-arm-msm@vger.kernel.org,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

From: Rob Clark <robdclark@chromium.org>

Ratelimit the error msg to avoid flooding the console.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 kernel/dma/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index f8ff598596b8..683966f0247b 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -564,7 +564,7 @@ static void add_dma_entry(struct dma_debug_entry *entry, unsigned long attrs)
 
 	rc = active_cacheline_insert(entry);
 	if (rc == -ENOMEM) {
-		pr_err("cacheline tracking ENOMEM, dma-debug disabled\n");
+		pr_err_ratelimited("cacheline tracking ENOMEM, dma-debug disabled\n");
 		global_disable = true;
 	} else if (rc == -EEXIST && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
 		err_printk(entry->dev, entry,
-- 
2.36.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
