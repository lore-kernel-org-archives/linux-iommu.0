Return-Path: <SRS0=lnwu=5U=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7586EC2BA1A
	for <iommu@archiver.kernel.org>; Sat,  4 Apr 2020 06:59:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C8E920709
	for <iommu@archiver.kernel.org>; Sat,  4 Apr 2020 06:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RCtDQvXi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C8E920709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 02DD588AEE;
	Sat,  4 Apr 2020 06:59:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Amuc0rNVOqgW; Sat,  4 Apr 2020 06:59:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 86EA388AD3;
	Sat,  4 Apr 2020 06:59:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B585C1D7C;
	Sat,  4 Apr 2020 06:59:00 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C935C07FF
 for <iommu@lists.linux-foundation.org>; Sat,  4 Apr 2020 06:58:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 154E486742
 for <iommu@lists.linux-foundation.org>; Sat,  4 Apr 2020 06:58:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uHS8j7RokKpS for <iommu@lists.linux-foundation.org>;
 Sat,  4 Apr 2020 06:58:58 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 6AD0686739
 for <iommu@lists.linux-foundation.org>; Sat,  4 Apr 2020 06:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=voGzMYCK0K8jfDayfIjKm5/csDG3aXXIjPWCZbs5YWs=; b=RCtDQvXi9hRS4RWqTM+DKzulYV
 DND9DzIW019ujjihMOutp26GgiewAis1IyZ2zxPRJay+I53hlVpxv2yvPkSv/ZpSQ4pi1nIxuYRFV
 SU4U/RKCDj0HZktj9u0AXC8qxWCAqn/jOWRX7RbRPnrxV/a8i8hA7/EAmRDDVwdLJjjV29rhLFXbf
 TuA+3G3WQ2MUSaAyRTx+Ow6LL/ugb15Y749wX3ekRywPmrHF/Kw3Aqm3LxXax56Xw2NSnb9nmmziH
 0dwHXnHcVh6fnhh5gYE+pg3GJWCPniRHS/buwLeBVEzFlopADFuD5bUR/P/ATt+1vVDDyB+C86gTa
 ohZohUcA==;
Received: from [2001:4bb8:180:7914:2ca6:9476:bbfa:a4d0] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jKclc-0001Yy-Tu; Sat, 04 Apr 2020 06:58:57 +0000
Date: Sat, 4 Apr 2020 08:58:55 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] dma-mapping updates for 5.7
Message-ID: <20200404065855.GA656254@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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

The following changes since commit 11a48a5a18c63fd7621bb050228cebf13566e4d8:

  Linux 5.6-rc2 (2020-02-16 13:16:59 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.7

for you to fetch changes up to fd27a526bb381f43dded6db30b3b016468ab0e6c:

  ARM/dma-mapping: merge __dma_supported into arm_dma_supported (2020-03-20 11:43:21 +0100)

----------------------------------------------------------------
dma-mapping updates for 5.7

 - fix an integer overflow in the coherent pool (Kevin Grandemange)
 - provide support for in-place uncached remapping and use that
   for openrisc
 - fix the arm coherent allocator to take the bus limit into account

----------------------------------------------------------------
Christoph Hellwig (8):
      dma-direct: remove the cached_kernel_address hook
      dma-direct: consolidate the error handling in dma_direct_alloc_pages
      dma-direct: make uncached_kernel_address more general
      dma-direct: provide a arch_dma_clear_uncached hook
      openrisc: use the generic in-place uncached DMA allocator
      ARM/dma-mapping: remove get_coherent_dma_mask
      ARM/dma-mapping: take the bus limit into account in __dma_alloc
      ARM/dma-mapping: merge __dma_supported into arm_dma_supported

Kevin Grandemange (1):
      dma-coherent: fix integer overflow in the reserved-memory dma allocation

 arch/Kconfig                     | 15 +++++---
 arch/arm/include/asm/dma-iommu.h |  2 --
 arch/arm/mm/dma-mapping.c        | 76 ++++++++++------------------------------
 arch/microblaze/Kconfig          |  2 +-
 arch/microblaze/mm/consistent.c  |  9 +----
 arch/mips/Kconfig                |  3 +-
 arch/mips/mm/dma-noncoherent.c   |  7 +---
 arch/nios2/Kconfig               |  3 +-
 arch/nios2/mm/dma-mapping.c      | 12 +------
 arch/openrisc/Kconfig            |  2 ++
 arch/openrisc/kernel/dma.c       | 55 ++++++-----------------------
 arch/xtensa/Kconfig              |  2 +-
 arch/xtensa/kernel/pci-dma.c     | 12 ++-----
 include/linux/dma-noncoherent.h  |  4 +--
 kernel/dma/coherent.c            | 13 +++----
 kernel/dma/direct.c              | 25 +++++++------
 16 files changed, 76 insertions(+), 166 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
