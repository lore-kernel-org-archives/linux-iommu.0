Return-Path: <SRS0=vdHR=V5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89010C19759
	for <iommu@archiver.kernel.org>; Thu,  1 Aug 2019 16:47:43 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B1FF20838
	for <iommu@archiver.kernel.org>; Thu,  1 Aug 2019 16:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kcblAkhG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B1FF20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1D8CC1862;
	Thu,  1 Aug 2019 16:47:43 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9A49C1771
	for <iommu@lists.linux-foundation.org>;
	Thu,  1 Aug 2019 16:47:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 37D505F4
	for <iommu@lists.linux-foundation.org>;
	Thu,  1 Aug 2019 16:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209;
	h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jRDKLsjk8HUCz3+oK1y5lg3vRrF1WHpghzvIdr5Ml58=;
	b=kcblAkhG6mt3yoCMfrfug7uY2G
	v4QSh/1jdBTXFzZDTEaT8TMTNlorj84dGMHjHAUGg1+W99MsFL2rQLIufjOytL7JnIP1Zj9eXYer8
	SLSJH6PsRtzGEte27601VXpUk9F4ZELCl8fEUZKQoUTWN2Bh4xBvLggFZYD4I8yM2bRarnvXrUH/M
	CeGR+MgjY1VlygGooho0/aLmDRMEJr41ItyqCbq7tMrTmd5UOkE7NwCGi1lYRIDaz0LCufUqBzc9m
	O8ceJWszS1Ym1xjhtaGVbceHblO6Kh/T5W8iIC9aRfGxP50iznhSiypav1GVv8Q6wRV27LQC1Sbe4
	n6EFcfnw==;
Received: from [195.167.85.94] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
	id 1htEER-00007z-TL; Thu, 01 Aug 2019 16:47:12 +0000
Date: Thu, 1 Aug 2019 19:47:02 +0300
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Russell King <linux@armlinux.org.uk>
Subject: [GIT PULL] arm highmem block I/O regression fix for 5.3
Message-ID: <20190801164702.GA26365@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
	linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

And here is another somewhat unusual pull request, mostly because it
touches almost entirely arch/arm, but to fix a block regression.

I would have preferred to feed this through the arm tree, but after
the original thread in reply to the bug report I haven't heard anything
back from Russell.


The following changes since commit 06532750010e06dd4b6d69983773677df7fc5291:

  dma-mapping: use dma_get_mask in dma_addressing_limited (2019-07-23 17:43:58 +0200)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/arm-swiotlb-5.3

for you to fetch changes up to ad3c7b18c5b362be5dbd0f2c0bcf1fd5fd659315:

  arm: use swiotlb for bounce buffering on LPAE configs (2019-07-24 17:29:01 +0200)

----------------------------------------------------------------
add swiotlb support to arm

This fixes a cascade of regressions that originally started with
the addition of the ia64 port, but only got fatal once we removed
most uses of block layer bounce buffering in Linux 4.18.

The reason is that while the original i386/PAE code that was the first
architecture that supported > 4GB of memory without an iommu decided to
leave bounce buffering to the subsystems, which in those days just mean
block and networking as no one else consumer arbitrary userspace memory.

Later with ia64, x86_64 and other ports we assumed that either an iommu
or something that fakes it up ("software IOTLB" in beautiful Intel
speak) is present and that subsystems can rely on that for dealing with
addressing limitations in devices.   Except that the ARM LPAE scheme
that added larger physical address to 32-bit ARM did not follow that
scheme and thus only worked by chance and only for block and networking
I/O directly to highmem.

Long story, short fix - add swiotlb support to arm when build for LPAE
platforms, which actuallys turns out to be pretty trivial with the
modern dma-direct / swiotlb code to fix the Linux 4.18-ish regression.

----------------------------------------------------------------
Christoph Hellwig (2):
      dma-mapping: check pfn validity in dma_common_{mmap,get_sgtable}
      arm: use swiotlb for bounce buffering on LPAE configs

 arch/arm/include/asm/dma-mapping.h |  4 ++-
 arch/arm/mm/Kconfig                |  5 ++++
 arch/arm/mm/dma-mapping.c          | 61 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mm/init.c                 |  5 ++++
 kernel/dma/mapping.c               | 13 ++++++--
 5 files changed, 85 insertions(+), 3 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
