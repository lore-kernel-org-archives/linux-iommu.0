Return-Path: <SRS0=BRyA=YI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FC7ECE588
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 10:23:53 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE0ED217F9
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 10:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EdZyJ8Xg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE0ED217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6DCC5AF0;
	Tue, 15 Oct 2019 10:23:52 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5222BAC8
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 10:23:51 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 015FD8B3
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 10:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209;
	h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=g8Yf5bkK0qIaSk67mxtN2CAg12cwmtqwx0IrD4HqSA8=;
	b=EdZyJ8XgRi7NDvsRwaiKHjDwN
	Ss+k9RgPQXO/UicfhAEVevJjtPrsrxIwNCaJmatOW6cC/8dsNgm1lzeHLLfq3AId1rsH5VtQuhFiH
	o+XDUvS0TQZ9DM1AyYY8qQKqO4VP3m56zRljXK33/mKPAOJTj9cX2BSx354fHODXNG2JPlhnaBm3u
	C8JTi/PjWI3T+By2cocpOJp7tcjgKTesEtZFEyWcTCGB/KFhb8eeeFAoYr/VX2AX55veWzfRQyRbD
	jm0lh3yxFO5EHPpUwl/1crtPqlvFNX5LkbO3tjMRMADbqOf3DIu62ij/wT5hGBCOZVoR7/bN/0hgq
	nEKEJZY9w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
	Hat Linux)) id 1iKJzW-0002Q7-UI; Tue, 15 Oct 2019 10:23:46 +0000
Date: Tue, 15 Oct 2019 03:23:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH RFC 4/5] dma/direct: check for overflows in ARM's
	dma_capable()
Message-ID: <20191015102346.GA9071@infradead.org>
References: <20191014183108.24804-1-nsaenzjulienne@suse.de>
	<20191014183108.24804-5-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191014183108.24804-5-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: mbrugger@suse.com, linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	iommu@lists.linux-foundation.org, f.fainelli@gmail.com,
	bcm-kernel-feedback-list@broadcom.com,
	linux-rpi-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org, wahrenst@gmx.net
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

On Mon, Oct 14, 2019 at 08:31:06PM +0200, Nicolas Saenz Julienne wrote:
> The Raspberry Pi 4 has a 1GB ZONE_DMA area starting at address
> 0x00000000 and a mapping between physical and DMA memory offset by
> 0xc0000000.  It transpires that, on non LPAE systems, any attempt to
> translate physical addresses outside of ZONE_DMA will result in an
> overflow. The resulting DMA addresses will not be detected by arm's
> dma_capable() as they still fit in the device's DMA mask.
> 
> Fix this by failing to validate a DMA address smaller than the lowest
> possible DMA address.

I think the main problem here is that arm doesn't respect the
bus_dma_mask.  If you replace the arm version of dma_capable with
the generic one, does that fi the issue for you as well?

We need to untangle the various macros arm uses for the direct mapping
and eventually we should be able to use the linux/dma-direct.h helpers
directly.  Here is a branch with some simple preps I had.  Freshly
rebased, not actually tested:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/arm-generic-dma-preps
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
