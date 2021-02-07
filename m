Return-Path: <SRS0=bugC=HJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D7DC433E0
	for <iommu@archiver.kernel.org>; Sun,  7 Feb 2021 16:26:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A35A760202
	for <iommu@archiver.kernel.org>; Sun,  7 Feb 2021 16:26:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A35A760202
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6906D86FF1;
	Sun,  7 Feb 2021 16:26:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t+uhCqBb8UYw; Sun,  7 Feb 2021 16:26:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id DC8EE86FEC;
	Sun,  7 Feb 2021 16:26:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BFE3CC0174;
	Sun,  7 Feb 2021 16:26:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2DE86C013A
 for <iommu@lists.linux-foundation.org>; Sun,  7 Feb 2021 16:26:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 11CAD20133
 for <iommu@lists.linux-foundation.org>; Sun,  7 Feb 2021 16:26:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yThJ1i20fOUE for <iommu@lists.linux-foundation.org>;
 Sun,  7 Feb 2021 16:26:12 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by silver.osuosl.org (Postfix) with ESMTPS id EFA7220131
 for <iommu@lists.linux-foundation.org>; Sun,  7 Feb 2021 16:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=oyOjEuJbaUrZDVi6UGKFq49upkI+s55d99FAd7+Mq7w=; b=qbvGukdAbhx4ukLix1XzXe3ubg
 VZs6q8VrGPboR1IsRvsJhE07wh0WeYDjgMv17EquwBMJp6IVN0FNUNB11NuEB4ls9mLcxu9eVAjnm
 Pw3W2PXghA3x1puBVaK0iLdR+8UFZ3RUev9OqWmi1TXkXhad9SiK3LVw4U5voPL1ez4hdYAN0GyV6
 JzvrsojyPybHB5ygNgFzez3pu0fadojegg6K/jzoHQSc38uOQpBCQAHJx5YuvwaGg/dzjWFDerHHu
 wblBBeZ/vE3IFq7S7ASLokdKRaBJfwGqaP8p6sMo/q3mAqaN+kB73qdXQ+FfX/OryvCcTg6BDvrqG
 ljrxeMdQ==;
Received: from [2001:4bb8:184:7d04:4590:5583:6cb7:77c7] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1l8msw-004uha-Gz; Sun, 07 Feb 2021 16:26:08 +0000
Date: Sun, 7 Feb 2021 17:26:05 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] dma-mapping fix for 5.11
Message-ID: <YCAUnVvH3rA24ZCa@infradead.org>
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

The following changes since commit dd86e7fa07a3ec33c92c957ea7b642c4702516a0:

  Merge tag 'pci-v5.11-fixes-2' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci (2021-02-04 16:05:40 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.11-2

for you to fetch changes up to 9f5f8ec50165630cfc49897410b30997d4d677b5:

  dma-mapping: benchmark: use u8 for reserved field in uAPI structure (2021-02-05 12:48:46 +0100)

----------------------------------------------------------------
dma-mapping fixes for 5.11:

 - fix a 32 vs 64-bit padding issue in the new benchmark code
   (Barry Song)

----------------------------------------------------------------
Barry Song (1):
      dma-mapping: benchmark: use u8 for reserved field in uAPI structure

 kernel/dma/map_benchmark.c                      | 2 +-
 tools/testing/selftests/dma/dma_map_benchmark.c | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
