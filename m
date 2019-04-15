Return-Path: <SRS0=E2BV=SR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69102C10F0E
	for <iommu@archiver.kernel.org>; Mon, 15 Apr 2019 06:33:21 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3495620825
	for <iommu@archiver.kernel.org>; Mon, 15 Apr 2019 06:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LYAEYuMh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3495620825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1A3B9AC7;
	Mon, 15 Apr 2019 06:33:21 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6FD2A9F0
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Apr 2019 06:33:19 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 273E41C0
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Apr 2019 06:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209;
	h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fTpJKUXbuUL7KBfPF6XhuEv9pXvxMlQmz20aOroByok=;
	b=LYAEYuMhBvvLtAlfrkcl2v1Hv
	J/diuhxsyq4qMmmKNKu4xKSxq5I3IO5ZDmyYJTP3+mWn0X/NJlnxpPV9iIcPt/jxaiuU6sRlC5AOc
	AKjUHt6v2z2n+4VpqTNOYY8c9vuCqcVPoeEOla5pCEJliS1j99N3glVSRx+R593PXpCgxi651UYZE
	F8UQBLASAE4bXbt4+VWHcjatc7WGerYL3LRZgIFsBRtNVesV5OABDs+Fbq52qUzC+9Zu82HzHN+/r
	vI8fPO5j8s1ydWtxojfIB6+dyJi2Pj27AfZ2UnVZu1/9tRJP82e1ynIdIjewgJnR5SYSrv6/hIrio
	Iy7KtgJ1A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
	Hat Linux)) id 1hFvB8-0002dH-0g; Mon, 15 Apr 2019 06:33:18 +0000
Date: Sun, 14 Apr 2019 23:33:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Tom Murphy <tmurphy@arista.com>
Subject: Re: [PATCH 4/9] iommu/dma-iommu: Add iommu_dma_map_page_coherent
Message-ID: <20190415063317.GC1377@infradead.org>
References: <20190411184741.27540-1-tmurphy@arista.com>
	<20190411184741.27540-5-tmurphy@arista.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190411184741.27540-5-tmurphy@arista.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-samsung-soc@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
	dima@arista.com, Marc Zyngier <marc.zyngier@arm.com>,
	linux-arm-msm@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
	linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
	David Brown <david.brown@linaro.org>,
	iommu@lists.linux-foundation.org, Kukjin Kim <kgene@kernel.org>,
	linux-mediatek@lists.infradead.org, murphyt7@tcd.ie,
	Andy Gross <andy.gross@linaro.org>, linux-rockchip@lists.infradead.org,
	Thomas Gleixner <tglx@linutronix.de>, Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190415063317.vGab2CrJJai7hrTivSN69VeFOSNIIo_KgTqkt_30o7Y@z>

> @@ -693,7 +694,19 @@ dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
>  		unsigned long offset, size_t size, int prot)
>  {
>  	return __iommu_dma_map(dev, page_to_phys(page) + offset, size, prot,
> -			iommu_get_dma_domain(dev));
> +			iommu_get_dma_domain(dev), dma_get_mask(dev));
> +}
> +
> +dma_addr_t iommu_dma_map_page_coherent(struct device *dev, struct page *page,
> +		unsigned long offset, size_t size, int prot)
> +{

Note that my tree pointed to above removes the iommu_dma_map_page
wrapper.  I think for the coherent mappign we should also just
call __iommu_dma_map directly and not introduce another wrapper.

> +	dma_addr_t dma_mask = dev->coherent_dma_mask;
> +
> +	if (!dma_mask)
> +		dma_mask = dma_get_mask(dev);
> +
> +	return __iommu_dma_map(dev, page_to_phys(page) + offset, size, prot,
> +			iommu_get_dma_domain(dev), dma_mask);
>  }

In the DMA API there is no fallback when the coherent_dma_mask is not
set.  While various bits of legacy code do that we should not copy it
to new code.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
