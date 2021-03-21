Return-Path: <SRS0=mXGD=IT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (unknown [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2B0C433DB
	for <iommu@archiver.kernel.org>; Sun, 21 Mar 2021 03:37:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FB0D619A3
	for <iommu@archiver.kernel.org>; Sun, 21 Mar 2021 03:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FB0D619A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B0E1C835C8;
	Sun, 21 Mar 2021 03:37:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vBDl9q1g2JmF; Sun, 21 Mar 2021 03:37:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C0F9834C6;
	Sun, 21 Mar 2021 03:37:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04A4BC000B;
	Sun, 21 Mar 2021 03:37:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18E15C0001
 for <iommu@lists.linux-foundation.org>; Sun, 21 Mar 2021 03:37:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F1DF8834CB
 for <iommu@lists.linux-foundation.org>; Sun, 21 Mar 2021 03:37:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GlDDGdfk3oJY for <iommu@lists.linux-foundation.org>;
 Sun, 21 Mar 2021 03:37:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6CA50834C6
 for <iommu@lists.linux-foundation.org>; Sun, 21 Mar 2021 03:37:43 +0000 (UTC)
Received: by mail-pf1-x434.google.com with SMTP id c204so8640960pfc.4
 for <iommu@lists.linux-foundation.org>; Sat, 20 Mar 2021 20:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UO8rbq0+kqRaTjZw3G4nKUjHlHbuRA+XYvccxPC+8fc=;
 b=F/gnec5pQX2xPdlwo2ptR3vuUqplHpKTaIO68mwzbh1cLT9S5vyjyj08b0hRdo0fRA
 aPtC7T0rehITzUswqexVYYN0otPWzeAxny8FkEto7wxipNyEAKF4eswwy3I0CG8iolK0
 cVXzk0jVFN8xxuMZ8QEN11/XL7dOT2XR7ymXY44vQwdIxyeQlHTfGEuNn8Zm1s5Jx1A9
 iD5KEWqU8G3BUUH+/AkgeQQstXMCcHkYrgnDb7qJWjAelFPq+0eK9CtgYrtvGixyiJtv
 0/AV14nSrgUD6e2OmOwfpA8NlGIrIUHNRGx97eQe3s6Xy9/S8iXtWGVa/Q7ddfM3qNuu
 nCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UO8rbq0+kqRaTjZw3G4nKUjHlHbuRA+XYvccxPC+8fc=;
 b=crucujNL4Dw08nBHbkgvATDGol8604WFscM14jS9JHP8WQtjdnzynDCK9FHZLOBYW5
 ZfkIRSesJ8/wtSF7qOTy+IfONjX8G+Liq3FNibtFwWybeyE4tPztpEhnDhDVeUqYxVeO
 ACLKkTPIW9/xnQLraIhlQ5ukeS5EJxm2gI6sQnZVQfirKwIQG2ux7bejCY3JUg/vb1II
 mmnoDmZYkZgsrn2f3ShDy4kL77wou7X5hn6F6EqcZnQuyy2Z0c3jJKJwG1i9TprDvsCP
 CEZ0gLBdktfcpuJpjf19RcaojyZJ6jfUxqk955vbU/BcTgc9h6wmJco5D9/y3sEBz6aw
 zadA==
X-Gm-Message-State: AOAM531FmHbuyJG8EyFDj1ViMqIztUB+iab3u94RLDzYL38zXSSwhwl8
 e0Xz81j4dOl0RTGnEV7LAVU=
X-Google-Smtp-Source: ABdhPJymdtdqAVJYxOk6uVcvorM3cCBvr0inWwlQnN2ca5LzxTGnat1XqW/aqiGOwRQEEs76gkjl9A==
X-Received: by 2002:aa7:9394:0:b029:1f4:2b30:4cdb with SMTP id
 t20-20020aa793940000b02901f42b304cdbmr16213688pfe.50.1616297863405; 
 Sat, 20 Mar 2021 20:37:43 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id l190sm9708422pfl.73.2021.03.20.20.37.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Mar 2021 20:37:42 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2] swiotlb: Make SWIOTLB_NO_FORCE perform no allocation
Date: Sat, 20 Mar 2021 20:37:40 -0700
Message-Id: <20210321033740.312500-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210319040055.183433-1-f.fainelli@gmail.com>
References: <20210319040055.183433-1-f.fainelli@gmail.com>
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
Changes in v2:

- rebased against devel/for-linus-5.13
- updated commit message to reflect variable names

 kernel/dma/swiotlb.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 539c76beb52e..d20002a61546 100644
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
@@ -211,6 +209,9 @@ swiotlb_init(int verbose)
 	size_t bytes = PAGE_ALIGN(default_nslabs << IO_TLB_SHIFT);
 	void *tlb;
 
+	if (swiotlb_force == SWIOTLB_NO_FORCE)
+		return;
+
 	/* Get IO TLB memory from the low pages */
 	tlb = memblock_alloc_low(bytes, PAGE_SIZE);
 	if (!tlb)
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
