Return-Path: <SRS0=3GNe=B6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B682CC433E1
	for <iommu@archiver.kernel.org>; Thu, 20 Aug 2020 16:42:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AA6F207DE
	for <iommu@archiver.kernel.org>; Thu, 20 Aug 2020 16:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ll4Mr1xy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AA6F207DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E5F3C88148;
	Thu, 20 Aug 2020 16:42:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oSEt8E-72Vpc; Thu, 20 Aug 2020 16:42:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4072B8810D;
	Thu, 20 Aug 2020 16:42:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 155DDC0889;
	Thu, 20 Aug 2020 16:42:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A05B2C0051
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 16:42:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 89CF58810D
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 16:42:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3sm34T9XteYM for <iommu@lists.linux-foundation.org>;
 Thu, 20 Aug 2020 16:42:05 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 93DFF88146
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 16:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=n6wthIhm7EoTN1b0pHSh96gJiJzqBpjUf1yHTv5MKlc=; b=ll4Mr1xyZg6BZuSzg+G/6nUfYF
 b7XD/oStlmttWxJuwjghyReYl0DDhNtBIPjHWbnXaJUhaNi53LJD9/otSFFvscA4kGP/SCOzMfjx4
 7N5nrx7XASX+ITWMMAHXEIMaQerIv1kkd4W444WAmFBrJeBVskIji+3tjpGM9F8O6C51uiY3rYHJj
 Dkhdf98EMBfM4iZZneMNSrvYJNf/q4EvHCUu1YM6h1sEHPOoYF5sK55ei+pGRRh/YCIiNj9zcLZPv
 0zXBFAQXf2jtF9RXlpRpmgNROx1coDPD7ZEn8+SFtIXRjP5kKeuLBmcJeB5s2sc8gEgizeSLlEI8A
 n2/kjsxg==;
Received: from [2001:4bb8:198:f3b2:8d02:73eb:b79f:5fd] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8ndY-0002Vf-Lv; Thu, 20 Aug 2020 16:42:01 +0000
Date: Thu, 20 Aug 2020 18:41:58 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] dma-mapping fixes for 5.9
Message-ID: <20200820164158.GA2186695@infradead.org>
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

The following changes since commit a1d21081a60dfb7fddf4a38b66d9cef603b317a9:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2020-08-13 20:03:11 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.9-1

for you to fetch changes up to d7e673ec2c8e0ea39c4c70fc490d67d7fbda869d:

  dma-pool: Only allocate from CMA when in same memory zone (2020-08-14 16:27:05 +0200)

----------------------------------------------------------------
dma-mapping fixes for 5.9

 - fix out more fallout from the dma-pool changes
   (Nicolas Saenz Julienne, me)

----------------------------------------------------------------
Christoph Hellwig (1):
      dma-pool: fix coherent pool allocations for IOMMU mappings

Nicolas Saenz Julienne (1):
      dma-pool: Only allocate from CMA when in same memory zone

 drivers/iommu/dma-iommu.c   |   4 +-
 include/linux/dma-direct.h  |   3 -
 include/linux/dma-mapping.h |   5 +-
 kernel/dma/direct.c         |  13 ++--
 kernel/dma/pool.c           | 145 ++++++++++++++++++++++++--------------------
 5 files changed, 92 insertions(+), 78 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
