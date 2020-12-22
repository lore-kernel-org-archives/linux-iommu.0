Return-Path: <SRS0=D+h4=F2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDAAC433E0
	for <iommu@archiver.kernel.org>; Tue, 22 Dec 2020 16:01:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDEC7221FA
	for <iommu@archiver.kernel.org>; Tue, 22 Dec 2020 16:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDEC7221FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 84892861F9;
	Tue, 22 Dec 2020 16:01:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aOKMoJNQVs8U; Tue, 22 Dec 2020 16:01:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 07906861F1;
	Tue, 22 Dec 2020 16:01:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB817C1787;
	Tue, 22 Dec 2020 16:01:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21CC3C0893
 for <iommu@lists.linux-foundation.org>; Tue, 22 Dec 2020 16:01:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0ACD68687D
 for <iommu@lists.linux-foundation.org>; Tue, 22 Dec 2020 16:01:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id el+LbsunFShJ for <iommu@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 16:01:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 224E8866F3
 for <iommu@lists.linux-foundation.org>; Tue, 22 Dec 2020 16:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=yykNsfBaPxMOZBrP4jnO9bz/8a3gTbpPD1bA3ocpIVA=; b=d6ucT97mlU3TE0F0TWJYB2Sjl4
 ZC7jUQkSD9K3LQ+9brv6d1cbAEm9RdhwPAbzgfye7f/f29lRXJ9yNJ51qjmaUM97nrgAJVEN/2Ysv
 o893hP1zABoA7j/uCfx7Vtu15jmau34pj2GuwX3zimXCjTkqgGGkp0FVe/uB7RuVgzaMtxMpOqZ00
 rIvAk4bRfQwOAtH1MKpNPR/TBgPC1wO7x0wIjCDVSALPhK7lqpUUKxWamI+fm02xGoY9IawjQxrxf
 i8dhPT+u7xmEyIayJWmdgf6JGdk/oElRqE/Jw8eoLefrFDMR0GHQdo0VXA+2qk2YzsK+U15k9SDiN
 9KVlJsaA==;
Received: from [2001:4bb8:180:8063:c70:4a89:bc61:2] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1krk65-0003Dg-9k; Tue, 22 Dec 2020 16:01:13 +0000
Date: Tue, 22 Dec 2020 17:01:12 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] dma-mapping updates for 5.11
Message-ID: <20201222160112.GA3019603@infradead.org>
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

The following changes since commit 418baf2c28f3473039f2f7377760bd8f6897ae18:

  Linux 5.10-rc5 (2020-11-22 15:36:08 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.11

for you to fetch changes up to 7679325702c90aecd393cd7cde685576c14489c0:

  selftests/dma: add test application for DMA_MAP_BENCHMARK (2020-11-27 10:33:42 +0100)

----------------------------------------------------------------
dma-mapping updates for 5.11:

 - support for a partial IOMMU bypass (Alexey Kardashevskiy)
 - add a DMA API benchmark (Barry Song)
 - misc fixes (Tiezhu Yang, tangjianqiang)

----------------------------------------------------------------
Alexey Kardashevskiy (2):
      dma-mapping: Allow mixing bypass and mapped DMA operation
      powerpc/dma: Fallback to dma_ops when persistent memory present

Barry Song (2):
      dma-mapping: add benchmark support for streaming DMA APIs
      selftests/dma: add test application for DMA_MAP_BENCHMARK

Tiezhu Yang (1):
      dma-pool: no need to check return value of debugfs_create functions

tangjianqiang (1):
      dma-contiguous: fix a typo error in a comment

 MAINTAINERS                                     |   6 +
 arch/powerpc/Kconfig                            |   1 +
 arch/powerpc/kernel/dma-iommu.c                 |  71 ++++-
 arch/powerpc/platforms/pseries/iommu.c          |  51 +++-
 include/linux/dma-map-ops.h                     |  14 +
 kernel/dma/Kconfig                              |  13 +
 kernel/dma/Makefile                             |   1 +
 kernel/dma/contiguous.c                         |   2 +-
 kernel/dma/map_benchmark.c                      | 361 ++++++++++++++++++++++++
 kernel/dma/mapping.c                            |  12 +-
 kernel/dma/pool.c                               |   3 -
 tools/testing/selftests/dma/Makefile            |   6 +
 tools/testing/selftests/dma/config              |   1 +
 tools/testing/selftests/dma/dma_map_benchmark.c | 123 ++++++++
 14 files changed, 645 insertions(+), 20 deletions(-)
 create mode 100644 kernel/dma/map_benchmark.c
 create mode 100644 tools/testing/selftests/dma/Makefile
 create mode 100644 tools/testing/selftests/dma/config
 create mode 100644 tools/testing/selftests/dma/dma_map_benchmark.c
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
