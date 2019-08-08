Return-Path: <SRS0=VhCt=WE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3429C0650F
	for <iommu@archiver.kernel.org>; Thu,  8 Aug 2019 16:00:30 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DA45217F4
	for <iommu@archiver.kernel.org>; Thu,  8 Aug 2019 16:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="in1PtdbL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DA45217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 226061084;
	Thu,  8 Aug 2019 16:00:30 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A538E1080
	for <iommu@lists.linux-foundation.org>;
	Thu,  8 Aug 2019 16:00:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5CFEB89D
	for <iommu@lists.linux-foundation.org>;
	Thu,  8 Aug 2019 16:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8DQlBYhOmPMmqBG4Sr4H2tBPKNk8KBZCVUsrJBapL/Q=;
	b=in1PtdbL1m9Hp49FBJpHwcQpU
	wxiD3OW12EH5x6aOPrIHITqyImqiA20BI/DdbjT6S5BY1PtOcEFUXMZrfRtvhzR2ZzgssxPZRwwbk
	yPiPM2rtUAZ4Y5b9KKBLcC41g1FzN07gpydM/m/IP0DIzcVsmsmb2iYq81tJMBVzdLZQujP2zdLdf
	26akZjGcj22I3tbe6Fouj5vhpP7GRdx01QECa+JWoq9GPapWbdlUCBaYveF2/FGZvzAejY4GpHd5I
	nLh9XZtj+bOHriozy/rP2fBUJYFL64fUPjtFgdrqstxnVxopFbBkgoPuxZirBBq5hhyoq4xiNBdwo
	s2ZuFtQMg==;
Received: from [195.167.85.94] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
	id 1hvkpl-0006Bi-Ij; Thu, 08 Aug 2019 16:00:26 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: remove default fallbacks in dma_map_ops v3
Date: Thu,  8 Aug 2019 18:59:57 +0300
Message-Id: <20190808160005.10325-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>, linuxppc-dev@lists.ozlabs.org,
	Helge Deller <deller@gmx.de>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

Hi all,

we have a few places where the DMA mapping layer has non-trivial default
actions that are questionable and/or dangerous.

This series instead wires up the mmap, get_sgtable and get_required_mask
methods explicitly and cleans up some surrounding areas.  This also means
we could get rid of the ARCH_NO_COHERENT_DMA_MMAP kconfig option, as we
now require a mmap method wired up, or in case of non-coherent dma-direct
the presence of the arch_dma_coherent_to_pfn hook.  The only interesting
case is that the sound code also checked the ARCH_NO_COHERENT_DMA_MMAP
symbol in somewhat odd ways, so I'd like to see a review of the sound
situation before going forward with that patch.

Changes since v2:
 - fix use of dma_can_mmap in alsa
 - improve the CONFIG_* mess a little more

Changes since v1:
 - add a dma_can_mmap helper for alsa
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
