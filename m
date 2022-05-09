Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 001C3C433F5
	for <iommu@archiver.kernel.org>; Mon,  9 May 2022 15:49:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A91E981C21;
	Mon,  9 May 2022 15:49:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rOt79jEKrhjh; Mon,  9 May 2022 15:49:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 892E981A15;
	Mon,  9 May 2022 15:49:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 664F5C0032;
	Mon,  9 May 2022 15:49:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73BBFC002D
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 15:49:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5BFE640253
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 15:49:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=armlinux.org.uk
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YigFTM7eSpHa for <iommu@lists.linux-foundation.org>;
 Mon,  9 May 2022 15:49:52 +0000 (UTC)
X-Greylist: delayed 00:05:31 by SQLgrey-1.8.0
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk
 [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CC55D40104
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 15:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=K4Ghe47wyHzJC/f9L6n0o6zagAWPzwTkrtr6pV97IUk=; b=WzlKZ7fSN/dBH8RKYd6m3bkXdD
 mv2quNMAOlbc7iJjqcQ8baqyyMWKBY7SGPOtekFffiAu/2nom/2/VhHi6WR1TOrtcF2cyWwfR3T7h
 2lFwN2xNQGxftqfKORZ4q5kFKqRc+ocL4CGJQn2wAbdHnJ56keASELf+ImYa6LzLvDn5OEmKZtbYU
 gS056gWixGDz+4cpZGEb6b5k0jTil/YgEIZKfmaMh8FsRtefyv8VqierKsOEZ9OspPyoDZyBbHqVQ
 vT3TLVn+TGbtwDV1mNqEgatoGHJHYUovpgac9W2DHkw0W6W78rmgXulI1bF6ph5lpq2gZ3s0KhMM1
 oiqoA+8Q==;
Received: from shell.armlinux.org.uk
 ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60642)
 by pandora.armlinux.org.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <linux@armlinux.org.uk>)
 id 1no5YO-0003Gf-Lj; Mon, 09 May 2022 16:44:09 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1no5YI-0005Dn-Jw; Mon, 09 May 2022 16:44:02 +0100
Date: Mon, 9 May 2022 16:44:02 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: fully convert arm to use dma-direct
Message-ID: <Ynk2wjRyH05uEJiO@shell.armlinux.org.uk>
References: <20220421074204.1284072-1-hch@lst.de>
 <CACRpkdbdKBfmXGdyTm3T-MFAK30N-z4KH0k8eD8F7xaYUbDDhA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACRpkdbdKBfmXGdyTm3T-MFAK30N-z4KH0k8eD8F7xaYUbDDhA@mail.gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Gregory Clement <gregory.clement@bootlin.com>,
 linux-usb@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Alan Stern <stern@rowland.harvard.edu>,
 Andre Przywara <andre.przywara@arm.com>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org,
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

On Fri, Apr 22, 2022 at 11:17:20PM +0200, Linus Walleij wrote:
> On Thu, Apr 21, 2022 at 9:42 AM Christoph Hellwig <hch@lst.de> wrote:
> 
> > arm is the last platform not using the dma-direct code for directly
> > mapped DMA.  With the dmaboune removal from Arnd we can easily switch
> > arm to always use dma-direct now (it already does for LPAE configs
> > and nommu).  I'd love to merge this series through the dma-mapping tree
> > as it gives us the opportunity for additional core dma-mapping
> > improvements.
> (...)
> 
> >  b/arch/arm/mach-footbridge/Kconfig                   |    1
> >  b/arch/arm/mach-footbridge/common.c                  |   19
> >  b/arch/arm/mach-footbridge/include/mach/dma-direct.h |    8
> >  b/arch/arm/mach-footbridge/include/mach/memory.h     |    4
> 
> I think Marc Z has a Netwinder that he can test this on. Marc?
> I have one too, just not much in my office because of parental leave.

Netwinder is just more of a PC-but-with-ARM - it doesn't make use of any
of the dmabounce code.

Assabet is what needs testing for that, or one of the SA1110 machines.
I'm away from home on my boat (and have been for the last two and a bit
weeks) so can't test. Sorry.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
