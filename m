Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A69C433F5
	for <iommu@archiver.kernel.org>; Mon,  9 May 2022 06:17:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 65C9F8174D;
	Mon,  9 May 2022 06:17:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id riMHqc4NRa7s; Mon,  9 May 2022 06:17:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 43C758174A;
	Mon,  9 May 2022 06:17:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1C07AC0032;
	Mon,  9 May 2022 06:17:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A4D1C002D
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 06:17:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 799B340600
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 06:17:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g7Hda9mm4MHA for <iommu@lists.linux-foundation.org>;
 Mon,  9 May 2022 06:17:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E4D2E4028D
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 06:17:01 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 69D2268AFE; Mon,  9 May 2022 08:16:57 +0200 (CEST)
Date: Mon, 9 May 2022 08:16:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: fully convert arm to use dma-direct
Message-ID: <20220509061657.GB17190@lst.de>
References: <20220421074204.1284072-1-hch@lst.de>
 <CACRpkdbdKBfmXGdyTm3T-MFAK30N-z4KH0k8eD8F7xaYUbDDhA@mail.gmail.com>
 <87pmkq7tmx.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87pmkq7tmx.wl-maz@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Arnd Bergmann <arnd@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Andre Przywara <andre.przywara@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>, linux-usb@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Alan Stern <stern@rowland.harvard.edu>,
 linux-arm-kernel@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Gregory Clement <gregory.clement@bootlin.com>,
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

On Fri, May 06, 2022 at 01:06:14PM +0100, Marc Zyngier wrote:
> > I think Marc Z has a Netwinder that he can test this on. Marc?
> > I have one too, just not much in my office because of parental leave.
> 
> Finally found some time to hook the machine up and throw a new kernel
> at it. Booted at its usual glacial speed, so FWIW:
> 
> Tested-by: Marc Zyngier <maz@kernel.org>

Thanks.  I've not heard anything from Russell and we're pretty late
in the merge window, so I'm tempted to wait until the next merge
window.  I'd like to pull in ASAP for that though as I have other
changes that are just waiting for it.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
