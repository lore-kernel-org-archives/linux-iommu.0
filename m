Return-Path: <SRS0=QSWf=I3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AB8C433F1
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 00:11:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 448816193D
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 00:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 448816193D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B525D83A0C;
	Mon, 29 Mar 2021 00:11:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rtFZUP2Qn27u; Mon, 29 Mar 2021 00:10:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 320AC83A44;
	Mon, 29 Mar 2021 00:10:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95A6AC0019;
	Mon, 29 Mar 2021 00:10:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38F05C000A
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:57:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2890C605BE
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:57:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L5o3_GTVvavZ for <iommu@lists.linux-foundation.org>;
 Sun, 28 Mar 2021 23:57:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 81257605A7
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:57:42 +0000 (UTC)
Received: by mail-qk1-x734.google.com with SMTP id c3so10931315qkc.5
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 16:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LY04BDMd0/4O0qv+wuAgYKhd3ly3Ph1K7x5mf2r/G+0=;
 b=a+EXa39bteLFKTrEHlbm1+MouCIyb9cV+yaNKyv8dIyxqTAhvd31XrjXWbvHHzVduL
 1m4DojoIjOfiyRN7xcr0QpSrR6ePbNm3KqRQY1gbCFcbd22bLf2BWnHwe8lfTEqTjY7R
 M98mtiq0Pq4n7XXjDGYxi4qsrFmCNnBlY+2L6xSLFCm2xU4u2hVKUVCMMgz+W48T3z+F
 Be8AcFVNT/rv2XLUJvW++tnlcFMq9Mx/WmUVOYgxFXIoTtuxIjemHAh4IiTbpweWxeP6
 Pt8RHzRZ4DYYvL/cvUU4JdOTyLGN/JBiDRnApwCKetCmX6P86BiK0xXGUEADFFqiSdgJ
 skQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LY04BDMd0/4O0qv+wuAgYKhd3ly3Ph1K7x5mf2r/G+0=;
 b=EmJjKuX/zEws+18t1ATsyWfd3BDAAjEKKZCkb7pCpEAFgLN00Vy1TrtO0S9yZZ9111
 oZYlDfEVYwWn7QY7srjUQ+hM8CikbAPn73X+gnEI/0gLR1A9fj8hdw73BMs3YRI58YpK
 +wCrM/Nr3YKEdQchM5LGF+Si2yBOtvUZK139yFlAidtzoSzEA1/TNzsIn7rHTqVUFPxj
 tHtvQzASYXpPuGpfYU3L/1RLM24H3sLxn0DUdvCYWIOEOM/m1Sa7zrtThyELVIEuDOZw
 brmtkT1898Cl603RdufkAOFkTnFhbiEyu98CC6lhyxgM/tqgmJ84zqgxMo0b+iF31YEg
 0QCQ==
X-Gm-Message-State: AOAM530n/59uEKl67v27Q7+tXKeHtqCKkzS0O+3Mc3RQdOlSDdXEGMEh
 701Yg+IKa1k+wocqd5OHgg4=
X-Google-Smtp-Source: ABdhPJz881qq4XaeZFjTiwc+P8rV7shOVJ9Q+7jnFQ8clBo7myE8qUn50lhxUxxhgg0PUTo5fJ3Apw==
X-Received: by 2002:a05:620a:110a:: with SMTP id
 o10mr23879687qkk.281.1616975861492; 
 Sun, 28 Mar 2021 16:57:41 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
 by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Mar 2021 16:57:40 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org, hch@lst.de,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 dave.jiang@intel.com, dan.j.williams@intel.com
Subject: [PATCH 21/30] owl-dma.c: Fix a typo
Date: Mon, 29 Mar 2021 05:23:17 +0530
Message-Id: <2e2a9f4d62fe36079229480bf6f65cea0f5be494.1616971780.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616971780.git.unixbhaskar@gmail.com>
References: <cover.1616971780.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 29 Mar 2021 00:10:51 +0000
Cc: rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>,
 linux-kernel@vger.kernel.org
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

s/Eventhough/"Even though"/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/owl-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
index 1f0bbaed4643..3c7283afa443 100644
--- a/drivers/dma/owl-dma.c
+++ b/drivers/dma/owl-dma.c
@@ -1155,7 +1155,7 @@ static int owl_dma_probe(struct platform_device *pdev)
 	}

 	/*
-	 * Eventhough the DMA controller is capable of generating 4
+	 * Even though the DMA controller is capable of generating 4
 	 * IRQ's for DMA priority feature, we only use 1 IRQ for
 	 * simplification.
 	 */
--
2.26.3

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
