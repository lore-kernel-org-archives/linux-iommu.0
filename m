Return-Path: <SRS0=ZOt4=IV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E0FC433C1
	for <iommu@archiver.kernel.org>; Tue, 23 Mar 2021 01:53:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62228619A8
	for <iommu@archiver.kernel.org>; Tue, 23 Mar 2021 01:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62228619A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1543D40378;
	Tue, 23 Mar 2021 01:53:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f1EUd0wpF7rJ; Tue, 23 Mar 2021 01:53:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id B916E401F3;
	Tue, 23 Mar 2021 01:53:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7CDFEC000B;
	Tue, 23 Mar 2021 01:53:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 303EEC0001
 for <iommu@lists.linux-foundation.org>; Tue, 23 Mar 2021 01:53:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 17A4240348
 for <iommu@lists.linux-foundation.org>; Tue, 23 Mar 2021 01:53:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kYzP7W1exsN7 for <iommu@lists.linux-foundation.org>;
 Tue, 23 Mar 2021 01:53:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 82D28402FE
 for <iommu@lists.linux-foundation.org>; Tue, 23 Mar 2021 01:53:53 +0000 (UTC)
Received: by mail-pg1-x530.google.com with SMTP id k24so10135968pgl.6
 for <iommu@lists.linux-foundation.org>; Mon, 22 Mar 2021 18:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UN25kkS2KebRuu15wRF3YovKapnV4LybmIZMwea2YYo=;
 b=X4Hl65Vht8ypMH0BrR0aS/wzxgY9EdKWM8THL1iBDBWDVa03DGOeOvbQqxUp2Qlfr0
 LCivPy5VLWfs8Gz9CxuhYn5VzH6AB9vifmRKFmoakKCvnDTDv9e9ri6mU87ekvCqn8vB
 waPxprwZ3hVctrMPlk2o4AgKEm/KOVAqxZ4PIJ2h6645pCiMNEGzhqvc04g59k5Rzw2r
 LYh+Apd6aQNlfwW5KUMCm8wLJUMZhXgDcGL+VG9iyvBbYKiSJyPmSVUNe1dOc7UJY1ZB
 tXu/y/Hnyfa7DY5P1e3aO123voc/qDI6fNDlvCdzPn76uA0Y2NNejeoNZHSequ1NIn87
 jIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UN25kkS2KebRuu15wRF3YovKapnV4LybmIZMwea2YYo=;
 b=ejUKlrsqWDxv4xQbSn6C9OcJ6JvxAVLPoP5nu0n1KESJfnWiChgQvRo95phqkUiGFv
 TBYAq1XUlEMbGybbD3/rAk/4SeUaHMptSlBpBL4zpWnWw/FHfG2CA0ySkj5E6xRezE0L
 3ofJ48PnUKYYmYjp7T6+uEVaJT2w7u54XkVFtdBcjko9iKPAAxraw+Iz/tRFzKuVQXWR
 4Z1TvpS3O0BHwmGXbPhWO3h3+croZU4itcXwUh+7UR0aleV1OUiRG6f0kqTG1Vgy1Kzi
 ZnKPajqPuezLq++kp0kxdF2Ulev/Os4p/aasA5cDF8cE/oR9Z1ThUTuyqHBGOX1f/11Z
 cLZQ==
X-Gm-Message-State: AOAM533wIwcw3bc9EhzE/guDQVMbT4irQeEBTJogiFF8wou+YdFB1c8F
 H2JpIHoWEyNCrbymnOhE28A=
X-Google-Smtp-Source: ABdhPJyqE1ohS2TSgebv7K5iabFQEl7wcTcGFvBsF7yvXcxIbElsqBcsJY3s4Q6L/Rom+/w3AzJBdg==
X-Received: by 2002:a62:f248:0:b029:20a:f9d5:dac3 with SMTP id
 y8-20020a62f2480000b029020af9d5dac3mr2159803pfl.13.1616464432788; 
 Mon, 22 Mar 2021 18:53:52 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id 14sm3721376pfl.1.2021.03.22.18.53.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Mar 2021 18:53:52 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3] swiotlb: Make SWIOTLB_NO_FORCE perform no allocation
Date: Mon, 22 Mar 2021 18:53:49 -0700
Message-Id: <20210323015350.399493-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210321033740.312500-1-f.fainelli@gmail.com>
References: <20210321033740.312500-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Cc: Florian Fainelli <f.fainelli@gmail.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 "open list:SWIOTLB SUBSYSTEM" <iommu@lists.linux-foundation.org>,
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

When SWIOTLB_NO_FORCE is used, there should really be no allocations of
default_nslabs to occur since we are not going to use those slabs. If a
platform was somehow setting swiotlb_no_force and a later call to
swiotlb_init() was to be made we would still be proceeding with
allocating the default SWIOTLB size (64MB), whereas if swiotlb=noforce
was set on the kernel command line we would have only allocated 2KB.

This would be inconsistent and the point of initializing default_nslabs
to 1, was intended to allocate the minimum amount of memory possible, so
simply remove that minimal allocation period.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v3:
- patch all call sites that can allocate SWIOTLB memory

Changes in v2:

- rebased against devel/for-linus-5.13
- updated commit message to reflect variable names

 kernel/dma/swiotlb.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 539c76beb52e..0a5b6f7e75bc 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -83,12 +83,10 @@ setup_io_tlb_npages(char *str)
 	}
 	if (*str == ',')
 		++str;
-	if (!strcmp(str, "force")) {
+	if (!strcmp(str, "force"))
 		swiotlb_force = SWIOTLB_FORCE;
-	} else if (!strcmp(str, "noforce")) {
+	else if (!strcmp(str, "noforce"))
 		swiotlb_force = SWIOTLB_NO_FORCE;
-		default_nslabs = 1;
-	}
 
 	return 0;
 }
@@ -174,6 +172,9 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
 	struct io_tlb_mem *mem;
 	size_t alloc_size;
 
+	if (swiotlb_force == SWIOTLB_NO_FORCE)
+		return 0;
+
 	/* protect against double initialization */
 	if (WARN_ON_ONCE(io_tlb_default_mem))
 		return -ENOMEM;
@@ -211,6 +212,9 @@ swiotlb_init(int verbose)
 	size_t bytes = PAGE_ALIGN(default_nslabs << IO_TLB_SHIFT);
 	void *tlb;
 
+	if (swiotlb_force == SWIOTLB_NO_FORCE)
+		return;
+
 	/* Get IO TLB memory from the low pages */
 	tlb = memblock_alloc_low(bytes, PAGE_SIZE);
 	if (!tlb)
@@ -240,6 +244,9 @@ swiotlb_late_init_with_default_size(size_t default_size)
 	unsigned int order;
 	int rc = 0;
 
+	if (swiotlb_force == SWIOTLB_NO_FORCE)
+		return 0;
+
 	/*
 	 * Get IO TLB memory from the low pages
 	 */
@@ -276,6 +283,9 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 	unsigned long bytes = nslabs << IO_TLB_SHIFT, i;
 	struct io_tlb_mem *mem;
 
+	if (swiotlb_force == SWIOTLB_NO_FORCE)
+		return 0;
+
 	/* protect against double initialization */
 	if (WARN_ON_ONCE(io_tlb_default_mem))
 		return -ENOMEM;
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
