Return-Path: <SRS0=E2BV=SR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B95C10F0E
	for <iommu@archiver.kernel.org>; Mon, 15 Apr 2019 06:31:38 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB4EF20833
	for <iommu@archiver.kernel.org>; Mon, 15 Apr 2019 06:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T2woLxIN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB4EF20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id AE68CA95;
	Mon, 15 Apr 2019 06:31:37 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 384D7A7F
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Apr 2019 06:31:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id F31911C0
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Apr 2019 06:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209;
	h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Vnx/FDuyfGzMLVKxKI7cCwcEPLdbD7UnzGISx2MXjRo=;
	b=T2woLxINdDPMGVm6g5xO298us
	N/78FYtB7ExqP6ovwznjwj+S1NyADW0QOuLCg38CE62Jy06Rqy0MliwcinJOKGD0hfej37r7WH4P7
	oGm6nabX41XlPUuGs/8auqdw5VfcrGy6iTHXbg/juq7L4tB77sxeCokMSKR5UMGBA+pt2KYUQBOzC
	UOz4pvEY8LemZS2i1eFEHpTC755HIwnFJWSiHfsFXN53z2RINi49eDdhwj1YSJzpp4jXmw9vpk9jg
	yv+xzLTSRudN/FVGLEM7ucSalk0sck+8PjHRpbTKrybAUwUi/URsImgHymNaFh9rsmvfqK6ZqJL+z
	Gy2ulR78A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
	Hat Linux)) id 1hFv9S-0002HX-W3; Mon, 15 Apr 2019 06:31:34 +0000
Date: Sun, 14 Apr 2019 23:31:34 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Tom Murphy <tmurphy@arista.com>
Subject: Re: [PATCH 3/9] iommu/dma-iommu: Add iommu_dma_copy_reserved_iova,
	iommu_dma_apply_resv_region to the dma-iommu api
Message-ID: <20190415063134.GB1377@infradead.org>
References: <20190411184741.27540-1-tmurphy@arista.com>
	<20190411184741.27540-4-tmurphy@arista.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190411184741.27540-4-tmurphy@arista.com>
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
Message-ID: <20190415063134.tApk_wIyMJy_SC6DIipttYL5NKoc0EkZ9RD8RhOC8mc@z>

On Thu, Apr 11, 2019 at 07:47:32PM +0100, Tom Murphy via iommu wrote:
> +
> +	WARN_ON_ONCE(iommu_dma_reserve_iova(domain, region->start, end) == NULL);

Overly long line..
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
