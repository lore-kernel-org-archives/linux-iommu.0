Return-Path: <SRS0=vdHR=V5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED4BC433FF
	for <iommu@archiver.kernel.org>; Thu,  1 Aug 2019 14:21:32 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2056320B7C
	for <iommu@archiver.kernel.org>; Thu,  1 Aug 2019 14:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gs6eJLcn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2056320B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E52691445;
	Thu,  1 Aug 2019 14:21:31 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3EFCEF58
	for <iommu@lists.linux-foundation.org>;
	Thu,  1 Aug 2019 14:21:31 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D1310E7
	for <iommu@lists.linux-foundation.org>;
	Thu,  1 Aug 2019 14:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=o3McWM/2bHyYOyL1mFZJ/4Q0USrtCE0kV4BVYCLDzEY=;
	b=Gs6eJLcnWsNhmKTj7X+mSbYPe
	sWN22x7cdspZVuBOb/sWdUdPLhLBDtpvcboWjDhtNcMhLNRBsMfY6by3qN+lcy3LRZiUTk0N+2HWP
	kOMZJFvxoPcRRNE0uvjE3622yufdZBOfEmuk+pAqJ8990LoLVBjJVTweC5ML2/fcSI/I5yQk9xkzC
	DXo9lzPx4qs2+vDYwixYfvb2WsV3i/so3GWZx5jh//NyzYZwmzw2WyL3kD9ImGZ15MoGVv0+nXyc2
	pqAha+cjJpUedSiG3zLHHfWNCMILWDl3fGMNdumhlKXZRRXsvXSn/qs7h+oJomhUXmSe+q3FHmFnl
	YsYxtSn1Q==;
Received: from [195.167.85.94] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
	id 1htBxQ-0006JC-Ow; Thu, 01 Aug 2019 14:21:29 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: fix default dma_mmap_* pgprot
Date: Thu,  1 Aug 2019 17:21:17 +0300
Message-Id: <20190801142118.21225-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Shawn Anastasio <shawn@anastas.io>, Will Deacon <will@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
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

As Shawn pointed out we've had issues with the dma mmap pgprots ever
since the dma_common_mmap helper was added beyong the initial
architectures - we default to uncached mappings, but for devices that
are DMA coherent, or if the DMA_ATTR_NON_CONSISTENT is set (and
supported) this can lead to aliasing of cache attributes.  This patch
fixes that.  My explanation of why this hasn't been much of an issue
is that the dma_mmap_ helpers aren't used widely and mostly just in
architecture specific drivers.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
