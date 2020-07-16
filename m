Return-Path: <SRS0=k4B3=A3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E64C433E2
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 15:01:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26BB4207CB
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 15:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R7qD2kJY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26BB4207CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0BB3089EC0;
	Thu, 16 Jul 2020 15:01:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nvblk+sVTe1N; Thu, 16 Jul 2020 15:01:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6C11E8A676;
	Thu, 16 Jul 2020 15:01:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 424D1C07FF;
	Thu, 16 Jul 2020 15:01:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80CFEC0733
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 15:01:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 694F288FD9
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 15:01:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lIdx5-Ivw7U8 for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jul 2020 15:01:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1663E88F81
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 15:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=RLyIJJQxRk37sQ/Z14NYKfHUx623deRH3rbHEaH2RJ8=; b=R7qD2kJYlqUxut3RUbtdrhnEJp
 PDZKWA4FhCSD+lMzCtO9rygYfwoNci+zjlvONm0wEYqpZjE+cTmNaLkOWio4DXbd18M9TwzNmFdqF
 TLZlCzGOAv++VD7/VXHDH/eG4a/kf//eSyGtXx0XS+u1HeGAOvRVvE5uOyI+G71PPQ15yC1q7eIu0
 eaEbvLHO0aRoS8yRRS+/GTIVA2qnuLm8i98uZN1KovfZxZJ1DRaQ992Y8k2OfYvxkGOm7QY1wJql9
 GwXNFZCQN4rDq4sgd4dJiY/697D0zPLUTJoMmYzRNB+e0gG95a3Bevw7yePJHE0itLacGpxRRW6Zj
 z5MBVCbA==;
Received: from [2001:4bb8:105:4a81:1bd9:4dba:216e:37b8] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jw5Np-00024L-EI
 for iommu@lists.linux-foundation.org; Thu, 16 Jul 2020 15:01:13 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH] dma-debug: use named initializers for dir2name
Date: Thu, 16 Jul 2020 17:01:12 +0200
Message-Id: <20200716150112.476896-1-hch@lst.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

Make dir2name a little more readable and maintainable by using
named initializers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/debug.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 36c962a86bf25d..41e720c3ab20c5 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -144,8 +144,12 @@ static const char *type2name[] = {
 	[dma_debug_resource] = "resource",
 };
 
-static const char *dir2name[4] = { "DMA_BIDIRECTIONAL", "DMA_TO_DEVICE",
-				   "DMA_FROM_DEVICE", "DMA_NONE" };
+static const char *dir2name[4] = {
+	[DMA_BIDIRECTIONAL]	= "DMA_BIDIRECTIONAL",
+	[DMA_TO_DEVICE]		= "DMA_TO_DEVICE",
+	[DMA_FROM_DEVICE]	= "DMA_FROM_DEVICE",
+	[DMA_NONE]		= "DMA_NONE",
+};
 
 /*
  * The access to some variables in this macro is racy. We can't use atomic_t
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
