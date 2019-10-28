Return-Path: <SRS0=Xx/3=YV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F69CA9EC2
	for <iommu@archiver.kernel.org>; Mon, 28 Oct 2019 15:44:28 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51ED321835
	for <iommu@archiver.kernel.org>; Mon, 28 Oct 2019 15:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jgf2bZN9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51ED321835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 160BD105F;
	Mon, 28 Oct 2019 15:44:28 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 55A02C91
	for <iommu@lists.linux-foundation.org>;
	Mon, 28 Oct 2019 15:44:26 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 05EE1876
	for <iommu@lists.linux-foundation.org>;
	Mon, 28 Oct 2019 15:44:26 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 18827208C0;
	Mon, 28 Oct 2019 15:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572277465;
	bh=7uPygpMoCp7ibwc8iu0sNHmd386wanQ+5eE51BmIVT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jgf2bZN99RGiypkeTddFnVu/BSMG2XvMFb/v31sAn0o+vxrkUuUxuNG2+FGzqvuXh
	yHEOGIpJWj+24KCiHiHzMXmhgL+vKM8GBouIwCWcc0pDEYB7wtZXVO9nC2FvvgBuMH
	WfsYZfif5KDu6YlK5I9LhcBqZFURc/QW5Dbvfx4s=
Date: Mon, 28 Oct 2019 15:44:20 +0000
From: Will Deacon <will@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] iommu/dma: Add support for DMA_ATTR_SYS_CACHE
Message-ID: <20191028154420.GD5576@willie-the-truck>
References: <1572050616-6143-1-git-send-email-isaacm@codeaurora.org>
	<20191026053026.GA14545@lst.de>
	<e5fe861d7d506eb41c23f3fc047efdfa@codeaurora.org>
	<20191028074156.GB20443@lst.de>
	<20191028112457.GB4122@willie-the-truck>
	<20191028113728.GA24055@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191028113728.GA24055@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: isaacm@codeaurora.org, pratikp@codeaurora.org, linux-kernel@vger.kernel.org,
	lmark@codeaurora.org, iommu@lists.linux-foundation.org,
	robin.murphy@arm.com
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

On Mon, Oct 28, 2019 at 12:37:28PM +0100, Christoph Hellwig wrote:
> On Mon, Oct 28, 2019 at 11:24:58AM +0000, Will Deacon wrote:
> > Agreed. The way I /think/ it works is that on many SoCs there is a
> > system/last-level cache (LLC) which effectively sits in front of memory for
> > all masters. Even if a device isn't coherent with the CPU caches, we still
> > want to be able to allocate into the LLC. Why this doesn't happen
> > automatically is beyond me, but it appears that on these Qualcomm designs
> > you actually have to set the memory attributes up in the page-table to
> > ensure that the resulting memory transactions are non-cacheable for the CPU
> > but cacheable for the LLC. Without any changes, the transactions are
> > non-cacheable in both of them which assumedly has a performance cost.
> > 
> > But you can see that I'm piecing things together myself here. Isaac?
> 
> If that is the case it sounds like we'd want to drive this through
> DT properties, not the driver API.  But again, without an actual consumer
> it pretty much is a moot point anyway.

I think there's certainly a DT aspect to it so that the driver knows that
the SoC is hooked up this way, but I agree that we need a consumer so that
we can figure out how dynamic this needs to be. If it's just a
fire-and-forget thing then it needn't escape the IOMMU layer, but I fear
that it's probably more flexible than that.

If nothing shows up for 5.6, I'll send a patch to remove it (since Jordan
said there was something coming soon [1])

Will

[1] http://lkml.kernel.org/r/20191024153832.GA7966@jcrouse1-lnx.qualcomm.com
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
