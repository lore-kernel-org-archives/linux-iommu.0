Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94CBC43334
	for <iommu@archiver.kernel.org>; Mon,  6 Jun 2022 06:38:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5882E60E2E;
	Mon,  6 Jun 2022 06:38:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L7LovLqYOMa4; Mon,  6 Jun 2022 06:38:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 066BD60DA0;
	Mon,  6 Jun 2022 06:38:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D078DC0032;
	Mon,  6 Jun 2022 06:38:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3350C002D
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jun 2022 06:38:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BD38B60E2B
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jun 2022 06:38:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IYkpJrMESTig for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jun 2022 06:38:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E34D160DA0
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jun 2022 06:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=tRr/IyS5yVw2e8JXaU35If9uX4O7GfKp3j39oOo0Cpg=; b=KwBLUPq8vs8E5AnLx9C1kXW11g
 I5uotKYbP5mYvDDy/zMETQGhpAL5lw8NWf/NxpBCQDzxaXwzyOtB72L6e4HIdz/uZ82ed/WWQEFmr
 yPVstNZaBdUVxHzhjoegJrUQ+lQKQxEZcbmGDzuA0kHpWUNVxiCA55ypz/OONkllawTJAOPMQKogo
 riKZBKs+P7yhWPfTkn0LZ4q1T3bqwpiwd3pn4VBX9/lJ8JWfgpm8izHb9itU777L1Nc0iZWZKDlCq
 tBSfEZxUpT4XhBstKCS07KJUD98xs2CZh6zG0Bkz5jRpO6MFduPlfArbqQjWlUnwhWMXftMjkj+el
 F6vso72A==;
Received: from [2001:4bb8:190:726c:bbd1:d45d:a235:6422] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ny6O0-00HKGt-0F; Mon, 06 Jun 2022 06:38:48 +0000
Date: Mon, 6 Jun 2022 08:38:45 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] dma-mapping fixes for 5.19
Message-ID: <Yp2g9SGrXn0eSvnA@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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

[I really wanted to send these before -rc1, but the fact that today is
 a public holiday here really confused me and messed up my schedule]

The following changes since commit 4a37f3dd9a83186cb88d44808ab35b78375082c9:

  dma-direct: don't over-decrypt memory (2022-05-23 15:25:40 +0200)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.19-2022-06-06

for you to fetch changes up to e15db62bc5648ab459a570862f654e787c498faf:

  swiotlb: fix setting ->force_bounce (2022-06-02 07:17:59 +0200)

----------------------------------------------------------------
dma-mapping fixes for Linux 5.19

 - fix a regressin in setting swiotlb ->force_bounce (me)
 - make dma-debug less chatty (Rob Clark)

----------------------------------------------------------------
Christoph Hellwig (1):
      swiotlb: fix setting ->force_bounce

Rob Clark (1):
      dma-debug: make things less spammy under memory pressure

 kernel/dma/debug.c   |  2 +-
 kernel/dma/swiotlb.c | 14 ++++++--------
 2 files changed, 7 insertions(+), 9 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
