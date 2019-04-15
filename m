Return-Path: <SRS0=E2BV=SR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD82C10F0E
	for <iommu@archiver.kernel.org>; Mon, 15 Apr 2019 06:22:56 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BA652073F
	for <iommu@archiver.kernel.org>; Mon, 15 Apr 2019 06:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qt7GBO1K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BA652073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2D9FDAA5;
	Mon, 15 Apr 2019 06:22:56 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 039DA7F6
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Apr 2019 06:22:55 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id ABDF4828
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Apr 2019 06:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209;
	h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5mXYtPV9rkVyUnx+7uwSXff5EgnepnAvSePgRxpYrFI=;
	b=Qt7GBO1KTQPQLfq/x1srhCdSw
	mC1qHEmpPukjA3amd7lbWLRFdzTZ2yKnZIJaGQZbL2kz7VJwgSbazj/A/tXO7cyrG4M8ki5+XYr82
	QjDWlSMgVDe5Rc9sTVPTrVspDO5js0YreT607UAV+LaLSA/riMLIiPdMuhDH3UUYtkiw1FX/B1bUW
	8OMAIk585YmLYcMpPIrFmhLWAvHQcR2R6cQYD7pO8Rz3dVYP+R6FCmIzSlEtGTWuXGprwQIOwliiP
	O0VjNBDfNL8SPWER2AdBiseXP+GtVSISdbGw9G8DqnyzeWjOW5Td8pubQLnoexf7ItYr2AIhP6XcR
	xUf7egtQQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
	Hat Linux)) id 1hFv13-0006oW-KB; Mon, 15 Apr 2019 06:22:53 +0000
Date: Sun, 14 Apr 2019 23:22:53 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Tom Murphy <tmurphy@arista.com>
Subject: Re: [PATCH 8/9] iommu/amd: Clean up unused functions
Message-ID: <20190415062253.GB18154@infradead.org>
References: <20190411184741.27540-1-tmurphy@arista.com>
	<20190411184741.27540-9-tmurphy@arista.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190411184741.27540-9-tmurphy@arista.com>
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
Message-ID: <20190415062253.rnZqjWD9p505hYYFb1CAnGX_IMM9yV61wmvN4sITN-k@z>

On Thu, Apr 11, 2019 at 07:47:37PM +0100, Tom Murphy via iommu wrote:
> Now that we are using the dma-iommu api we have a lot of unused code.
> This patch removes all that unused code.

This should be merged into the previous patch.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
