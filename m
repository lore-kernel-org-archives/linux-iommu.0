Return-Path: <SRS0=mJb0=T7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FA9C04AB6
	for <iommu@archiver.kernel.org>; Fri, 31 May 2019 16:40:22 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D34C26C4E
	for <iommu@archiver.kernel.org>; Fri, 31 May 2019 16:40:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D34C26C4E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 25A7B1767;
	Fri, 31 May 2019 16:40:22 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E72A81761
	for <iommu@lists.linux-foundation.org>;
	Fri, 31 May 2019 16:39:34 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6732C823
	for <iommu@lists.linux-foundation.org>;
	Fri, 31 May 2019 16:39:34 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id 9B79C68AA6; Fri, 31 May 2019 18:39:07 +0200 (CEST)
Date: Fri, 31 May 2019 18:39:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] dma-contiguous: Fix !CONFIG_DMA_CMA version of
	dma_{alloc,free}_contiguous()
Message-ID: <20190531163907.GA27525@lst.de>
References: <20190530005425.7184-1-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190530005425.7184-1-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: tony@atomide.com, catalin.marinas@arm.com, will.deacon@arm.com,
	jcmvbkbc@gmail.com, hch@lst.de, sfr@canb.auug.org.au,
	dann.frazier@canonical.com, linux@armlinux.org.uk,
	treding@nvidia.com, linux-xtensa@linux-xtensa.org,
	keescook@chromium.org, natechancellor@gmail.com,
	iamjoonsoo.kim@lge.com, linux-arm-kernel@lists.infradead.org,
	chris@zankel.net, wsa+renesas@sang-engineering.com,
	robin.murphy@arm.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, akpm@linux-foundation.org,
	dwmw2@infradead.org
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

Thanks,

applied to the dma-mapping tree.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
