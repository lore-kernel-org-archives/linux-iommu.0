Return-Path: <SRS0=c+U5=L2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8A9C11F68
	for <iommu@archiver.kernel.org>; Fri,  2 Jul 2021 16:06:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AC5F6141D
	for <iommu@archiver.kernel.org>; Fri,  2 Jul 2021 16:06:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AC5F6141D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6891A83FC8;
	Fri,  2 Jul 2021 16:06:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8H3vQ3pRM67N; Fri,  2 Jul 2021 16:06:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2C117840DB;
	Fri,  2 Jul 2021 16:06:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F315AC001A;
	Fri,  2 Jul 2021 16:06:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B42AEC000E
 for <iommu@lists.linux-foundation.org>; Fri,  2 Jul 2021 16:06:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A1718423BC
 for <iommu@lists.linux-foundation.org>; Fri,  2 Jul 2021 16:06:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XPrIMOyZbY1y for <iommu@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 16:06:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7C794423B6
 for <iommu@lists.linux-foundation.org>; Fri,  2 Jul 2021 16:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=iC1QZXy9Cno3bICQJjkmHqM8p3uVRAtns8+PaSPO5+8=; b=wQz/0NOVk+4ejBAefuHHoMDhFo
 Cju+ikF+UTkF83UxB0g7Q0yOycGv8B/02IsEly3HlBSQRqmwzD1N1LNICcl7V6HSTi7X3zWSSfCg/
 66uWKjK3z4dBoWmtSvymJUuNvgYApDm7j5QNULwKpEhVmWVUovceE+puYsr9msn66TRZkrCdRdBBS
 h2Gq/uwWaajij7DgJpxJz9TO4If1LTwbpH20J79WuAzrPMoPnDXmekyXq7eAghJSjy6PZAGs864qO
 0pintKwMm7sUJJpN/jnRowqmyIi6sJ8G/R/QidmFEq9WENDD17Mm1Y9m0uIoRBziafiFrGsQ1fRu3
 rp+Pa9+g==;
Received: from [2001:4bb8:180:285:6928:4a94:34bd:6961] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lzLgJ-007qUJ-3Q; Fri, 02 Jul 2021 16:06:24 +0000
Date: Fri, 2 Jul 2021 18:06:17 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] dma-mapping updates for Linux 5.14
Message-ID: <YN85ebItWEBp98jL@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

The following changes since commit a7f3d3d3600c8ed119eb0d2483de0062ce2e3707:

  dma-mapping: add unlikely hint to error path in dma_mapping_error (2021-04-02 16:41:08 +0200)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.14

for you to fetch changes up to 2b4bbc6231d789f58676d2ccc42177df163e1c4a:

  dma-debug: report -EEXIST errors in add_dma_entry (2021-06-22 08:15:47 +0200)

----------------------------------------------------------------
dma-mapping updates for Linux 5.14

 - a trivivial whitespace fix (Zhen Lei)
 - report -EEXIST errors in add_dma_entry (Hamza Mahfooz)

----------------------------------------------------------------
Hamza Mahfooz (1):
      dma-debug: report -EEXIST errors in add_dma_entry

Zhen Lei (1):
      dma-mapping: remove a trailing space

 kernel/dma/coherent.c | 2 +-
 kernel/dma/debug.c    | 6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
