Return-Path: <SRS0=0plo=HR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B68CC433E6
	for <iommu@archiver.kernel.org>; Mon, 15 Feb 2021 13:13:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2DB664E2B
	for <iommu@archiver.kernel.org>; Mon, 15 Feb 2021 13:13:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2DB664E2B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A25878710D;
	Mon, 15 Feb 2021 13:13:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QHodYQponfPk; Mon, 15 Feb 2021 13:13:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B95ED8710B;
	Mon, 15 Feb 2021 13:13:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D3D8C0174;
	Mon, 15 Feb 2021 13:13:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EBD2DC013A
 for <iommu@lists.linux-foundation.org>; Mon, 15 Feb 2021 13:13:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DAE25867AC
 for <iommu@lists.linux-foundation.org>; Mon, 15 Feb 2021 13:13:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mzBesqzAtsRa for <iommu@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 13:13:07 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from angie.orcam.me.uk (angie.orcam.me.uk [157.25.102.26])
 by whitealder.osuosl.org (Postfix) with ESMTP id DF1818682F
 for <iommu@lists.linux-foundation.org>; Mon, 15 Feb 2021 13:13:06 +0000 (UTC)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
 id 782F492009D; Mon, 15 Feb 2021 14:13:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by angie.orcam.me.uk (Postfix) with ESMTP id 7131192009C;
 Mon, 15 Feb 2021 14:13:03 +0100 (CET)
Date: Mon, 15 Feb 2021 14:13:03 +0100 (CET)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 5/6] driver core: lift dma_default_coherent into common
 code
In-Reply-To: <alpine.DEB.2.21.2102091213070.35623@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2102151342050.1521@angie.orcam.me.uk>
References: <20210208145024.3320420-1-hch@lst.de>
 <20210208145024.3320420-6-hch@lst.de>
 <alpine.DEB.2.21.2102081654060.35623@angie.orcam.me.uk>
 <20210208161043.GA14083@lst.de>
 <alpine.DEB.2.21.2102091213070.35623@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 iommu@lists.linux-foundation.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org
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

On Tue, 9 Feb 2021, Maciej W. Rozycki wrote:

> > >  Do you need to have this verified anyhow?  I only have a non-coherent 5Kc 
> > > Malta though.
> > 
> > If you get a chance to test this logic, that would be great.
> 
>  I'll try to give it a hit in the next few days then.  Installed in my 
> Malta I have a DEFPA, which is about as serious a DMA user as a piece of 
> classic PCI hardware could be.  I need to debug the issue of another DEFPA 
> not working with my POWER9 system, possibly due to an IOMMU handling bug 
> (hopefully not broken host hardware), so I'll take the opportunity and do 
> it all at once.

 FYI still working on it.  The POWER9 issue turned out to be a combination 
of a driver configuration issue with the distribution caused by a chain of 
historical events leading to the use of PCI I/O bus commands not supported 
by the PHB PCIe host bridge and a bad solder joint with the adapter's main 
PDQ IC on a 20+ years old brand new card.

 I hope to have the adapter properly fixed soon and I'll look at the Malta 
side now, possibly using the old server whose DEFPA has worked flawlessly 
for some 20 years now.  I have planned to use the interface to supply NFS 
root, which I think should be enough of a stress test.

 Patches will follow sometime too for the driver's configuration issue, a 
nonsense in 2021 I should have long addressed, and for resource handling 
which I think should explicitly fail port I/O claims on a system that does 
not support port I/O at all and should not allow this:

# cat /proc/ioports
00000000-ffffffffffffffff : 0031:02:04.0
# 

to happen.

  Maciej
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
