Return-Path: <SRS0=hrQw=A6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D17C433DF
	for <iommu@archiver.kernel.org>; Sun, 19 Jul 2020 07:39:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 496562073A
	for <iommu@archiver.kernel.org>; Sun, 19 Jul 2020 07:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ghtU5skA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496562073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 01F7A8601E;
	Sun, 19 Jul 2020 07:39:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vDAqyPiG1F91; Sun, 19 Jul 2020 07:39:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2DB2286044;
	Sun, 19 Jul 2020 07:39:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A1ECC0890;
	Sun, 19 Jul 2020 07:39:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 682B9C016F
 for <iommu@lists.linux-foundation.org>; Sun, 19 Jul 2020 07:39:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5002887B3E
 for <iommu@lists.linux-foundation.org>; Sun, 19 Jul 2020 07:39:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9mC4cW+rF1W7 for <iommu@lists.linux-foundation.org>;
 Sun, 19 Jul 2020 07:39:32 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 857E987635
 for <iommu@lists.linux-foundation.org>; Sun, 19 Jul 2020 07:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=cNsbswgmt5UoWdjIXqDw0mZBByTg/kfR0BZVwY68014=; b=ghtU5skADnySWERfccuHaUPDLU
 xw5ZNDLYS8qTNezw5W/6s6oEP0HWgA1JUGbQPw67eJ1PJhSBJXv5VOjjvMmQ1ZgAzDpRYYV6Ri9OK
 uIubRA4ivmUEKXzNFttfrPbrn03mPshlB7XAYf+amj8tfUf6dQmjwFjRNgB6vEH2imqVBJx2T5MAn
 WCNSIQSI5YYkxxdPz1fzt84g/5gMFF3PI+skmmQNxpJO/UclCJYSmBm+iQTU01ZExKMIvDGC22k1W
 0DkksMIwpiaXDNwT8r7I6QWwpWA9QIS1Bd3vrxoRYfXHrNP1Rws8IbFxNZCUn3wcfm8sh8O+N0K36
 XYcWTenA==;
Received: from [2001:4bb8:105:4a81:4ef5:9f24:cda4:103f] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jx3uy-0001IV-2o; Sun, 19 Jul 2020 07:39:28 +0000
Date: Sun, 19 Jul 2020 09:39:27 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] dma-mapping fixes for 5.8
Message-ID: <20200719073927.GA114439@infradead.org>
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

The following changes since commit 0dc589da873b58b70f4caf4b070fb0cf70fdd1dc:

  Merge tag 'iommu-fixes-v5.8-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu (2020-07-13 12:34:05 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.8-6

for you to fetch changes up to d9765e41d8e9ea2251bf73735a2895c8bad546fc:

  dma-pool: do not allocate pool memory from CMA (2020-07-14 15:46:32 +0200)

----------------------------------------------------------------
dma-mapping fixes for 5.8:

 - ensure we always have fully addressable memory in the dma coherent
   pool (Nicolas Saenz Julienne)

----------------------------------------------------------------
Nicolas Saenz Julienne (5):
      dma-direct: provide function to check physical memory area validity
      dma-pool: get rid of dma_in_atomic_pool()
      dma-pool: introduce dma_guess_pool()
      dma-pool: make sure atomic pool suits device
      dma-pool: do not allocate pool memory from CMA

 include/linux/dma-direct.h |  1 +
 kernel/dma/direct.c        |  2 +-
 kernel/dma/pool.c          | 91 ++++++++++++++++++++++++++++------------------
 3 files changed, 58 insertions(+), 36 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
