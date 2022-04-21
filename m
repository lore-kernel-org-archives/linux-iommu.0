Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9481C433F5
	for <iommu@archiver.kernel.org>; Thu, 21 Apr 2022 14:12:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4DFB341A4E;
	Thu, 21 Apr 2022 14:12:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rYUBCr3r45jh; Thu, 21 Apr 2022 14:12:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 11E8D4189B;
	Thu, 21 Apr 2022 14:12:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3C13C0033;
	Thu, 21 Apr 2022 14:12:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E779FC002C
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 14:12:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D616984120
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 14:12:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9f90B0Vvr21y for <iommu@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 14:12:33 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3F10D83183
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 14:12:33 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9CD7068C4E; Thu, 21 Apr 2022 16:12:29 +0200 (CEST)
Date: Thu, 21 Apr 2022 16:12:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH 6/7] ARM: use the common dma_to_phys/phys_to_dma
 implementation where possible
Message-ID: <20220421141229.GB20492@lst.de>
References: <20220421074204.1284072-1-hch@lst.de>
 <20220421074204.1284072-7-hch@lst.de>
 <CAK8P3a3BD5zLiXf=Wr0kcJp-k3+vmhBkEP5DNRw_-H=OX9CoGA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8P3a3BD5zLiXf=Wr0kcJp-k3+vmhBkEP5DNRw_-H=OX9CoGA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>, USB list <linux-usb@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, Apr 21, 2022 at 10:05:11AM +0200, Arnd Bergmann wrote:
> > -unsigned long __pfn_to_bus(unsigned long pfn)
> > +#else
> > +static inline unsigned long fb_bus_sdram_offset(void)
> >  {
> > -       return __pfn_to_phys(pfn) + (fb_bus_sdram_offset() - PHYS_OFFSET);
> > +       return BUS_OFFSET;
> >  }
> > -EXPORT_SYMBOL(__pfn_to_bus);
> > +#endif /* CONFIG_FOOTBRIDGE_ADDIN */
> 
> I have an older patch to remove CONFIG_FOOTBRIDGE_ADDIN
> completely, as it does a couple of other nasty things and there are
> apparently no users. Would that help here?

For this series it doesn't really make much of a difference.  The addin
case actually is simpler than the host mode for DMA,  But overall
CONFIG_FOOTBRIDGE_ADDIN seems to be a collection of special cases, so
if it is unused and can be remove that would probably be a good thing.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
