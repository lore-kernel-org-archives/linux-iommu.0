Return-Path: <SRS0=4X9E=EG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABB9C388F9
	for <iommu@archiver.kernel.org>; Sat, 31 Oct 2020 09:40:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9CF52076D
	for <iommu@archiver.kernel.org>; Sat, 31 Oct 2020 09:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rydcv2zG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9CF52076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 592532034B;
	Sat, 31 Oct 2020 09:40:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5smIf2BZklY0; Sat, 31 Oct 2020 09:40:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 16F3D20130;
	Sat, 31 Oct 2020 09:40:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED237C088B;
	Sat, 31 Oct 2020 09:40:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A5DCC0051
 for <iommu@lists.linux-foundation.org>; Sat, 31 Oct 2020 09:40:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E394085888
 for <iommu@lists.linux-foundation.org>; Sat, 31 Oct 2020 09:40:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4QBr7DFZKRhl for <iommu@lists.linux-foundation.org>;
 Sat, 31 Oct 2020 09:40:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0E310871D0
 for <iommu@lists.linux-foundation.org>; Sat, 31 Oct 2020 09:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=l/8xBspK/egJQgWp9wEyakLNsvCi5RbuiwpHLDEpSY4=; b=rydcv2zGRMIzbXFsWs84kqi7WF
 9fiCgSfauC3vD2m3KmzfjUoMUS23MPxWccHnS7xE+tLDn2hax5YmWyzSuPkftRmLaCX8PO+90FrmD
 7TQWBAf8Ew/+ECIzADyZjuXNymKQmWnGMR0Ndj/eh0/U6sk4Q9RGB+P49LXKhloltmOZlk6vEw6G4
 cm4lqM+hDy5BYcEQpm3r4ZJ5DamMeSgLexfali5z7PAbqKQmLqiLMUAZj5qavBwMXXPjYOBv8K9Kv
 Jm4ieGeRDAMT+nBZufKCZIOnP7LSaGJUuUSYQwBkgfAcLa1L0QcqO6mCFvN3EGeuf5DXglscBJQeZ
 LEywkMfQ==;
Received: from 089144193201.atnat0002.highway.a1.net ([89.144.193.201]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kYnNC-0000zk-Fa; Sat, 31 Oct 2020 09:40:35 +0000
Date: Sat, 31 Oct 2020 10:38:23 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] dma-mapping fix for 5.10
Message-ID: <20201031093823.GA453843@infradead.org>
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

The following changes since commit ed8780e3f2ecc82645342d070c6b4e530532e680:

  Merge tag 'x86-urgent-2020-10-27' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2020-10-27 14:39:29 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.10-2

for you to fetch changes up to 48ab6d5d1f096d6fac5b59f94af0aa394115a001:

  dma-mapping: fix 32-bit overflow with CONFIG_ARM_LPAE=n (2020-10-29 16:59:34 +0100)

----------------------------------------------------------------
dma-mapping fix for 5.10:

 - fix an integer overflow on 32-bit platforms in the new DMA range code
   (Geert Uytterhoeven)

----------------------------------------------------------------
Geert Uytterhoeven (1):
      dma-mapping: fix 32-bit overflow with CONFIG_ARM_LPAE=n

 drivers/of/device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
