Return-Path: <SRS0=JEM9=V3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13333C0650F
	for <iommu@archiver.kernel.org>; Tue, 30 Jul 2019 06:33:02 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA0ED2054F
	for <iommu@archiver.kernel.org>; Tue, 30 Jul 2019 06:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d6nmUpah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA0ED2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9CC3B246E;
	Tue, 30 Jul 2019 06:33:01 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 15E392434
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Jul 2019 06:28:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 71D0CA8
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Jul 2019 06:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209;
	h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kdf9VzAcKlRao+cQi/gI52MGpBhS1qPDKJ44BshrQsQ=;
	b=d6nmUpaheyhCkGmbrEDaP1DXk
	ybqawQrZn8362H11uU4Y5WdRMlwoq5qg3O3becjLLIJ0Cf8Elp4wGoayiNXW9Jf/O8QD8NxhNRUcf
	oQu3gh2KsUWtgGTexCr6A5I5Iq7qTwOF2VyckQmJVydEMdUa1hwWeb0rAf7eWDEMf7pS9d8VZWIoq
	uXf3ncvi22lht1vcBctFk9AJMJu8G99R2msuf4uDH0eGFZRQlk2sWZR7yzN+sSttEYGyv6bZTS99Q
	bAEflp+QX2NxpZN3ECsWTk6334ANe28vDiRl2GL1ex/ycdP5YAvFtjvYzxZYSGO/4v/XZ0NCaxUZI
	t2clGakFg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat
	Linux)) id 1hsLcp-0002L2-Fk; Tue, 30 Jul 2019 06:28:43 +0000
Date: Mon, 29 Jul 2019 23:28:43 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/dma: Handle MSI mappings separately
Message-ID: <20190730062843.GA1400@infradead.org>
References: <2b2595de703c60a772ebcffe248d0cf036143e6a.1564414114.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2b2595de703c60a772ebcffe248d0cf036143e6a.1564414114.git.robin.murphy@arm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: maz@kernel.org, iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org,
	Andre Przywara <andre.przywara@arm.com>
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

On Mon, Jul 29, 2019 at 04:32:38PM +0100, Robin Murphy wrote:
> MSI pages must always be mapped into a device's *current* domain, which
> *might* be the default DMA domain, but might instead be a VFIO domain
> with its own MSI cookie. This subtlety got accidentally lost in the
> streamlining of __iommu_dma_map(), but rather than reintroduce more
> complexity and/or special-casing, it turns out neater to just split this
> path out entirely.
> 
> Since iommu_dma_get_msi_page() already duplicates much of what
> __iommu_dma_map() does, it can easily just make the allocation and
> mapping calls directly as well. That way we can further streamline the
> helper back to exclusively operating on DMA domains.
> 
> Fixes: b61d271e59d7 ("iommu/dma: Move domain lookup into __iommu_dma_{map,unmap}")
> Reported-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Reported-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Hmm.  I remember proposing this patch and you didn't like it because
we could also have msis for a !IOMMU_DMA_IOVA_COOKIE cookie type.
Or did we talk past each other?

Note that if this change turns out to be valid we should also
clean up the iommu_dma_free_iova() side.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
