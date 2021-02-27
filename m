Return-Path: <SRS0=v/hM=H5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FECC433DB
	for <iommu@archiver.kernel.org>; Sat, 27 Feb 2021 18:34:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A02664E76
	for <iommu@archiver.kernel.org>; Sat, 27 Feb 2021 18:34:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A02664E76
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E182A8428A;
	Sat, 27 Feb 2021 18:34:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jVwr80fNDBcA; Sat, 27 Feb 2021 18:34:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7CC0A84248;
	Sat, 27 Feb 2021 18:34:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64758C000A;
	Sat, 27 Feb 2021 18:34:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82A94C0001
 for <iommu@lists.linux-foundation.org>; Sat, 27 Feb 2021 18:34:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 635886F506
 for <iommu@lists.linux-foundation.org>; Sat, 27 Feb 2021 18:34:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TqTKLbPmuvID for <iommu@lists.linux-foundation.org>;
 Sat, 27 Feb 2021 18:34:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from angie.orcam.me.uk (angie.orcam.me.uk [157.25.102.26])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5B2446F4B8
 for <iommu@lists.linux-foundation.org>; Sat, 27 Feb 2021 18:34:02 +0000 (UTC)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
 id BB9BE92009C; Sat, 27 Feb 2021 19:33:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by angie.orcam.me.uk (Postfix) with ESMTP id AE2C292009B;
 Sat, 27 Feb 2021 19:33:57 +0100 (CET)
Date: Sat, 27 Feb 2021 19:33:57 +0100 (CET)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 5/6] driver core: lift dma_default_coherent into common
 code
In-Reply-To: <alpine.DEB.2.21.2102221140180.1900@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2102271927430.44210@angie.orcam.me.uk>
References: <20210208145024.3320420-1-hch@lst.de>
 <20210208145024.3320420-6-hch@lst.de>
 <alpine.DEB.2.21.2102081654060.35623@angie.orcam.me.uk>
 <20210208161043.GA14083@lst.de>
 <alpine.DEB.2.21.2102091213070.35623@angie.orcam.me.uk>
 <alpine.DEB.2.21.2102151342050.1521@angie.orcam.me.uk>
 <alpine.DEB.2.21.2102210407090.2021@angie.orcam.me.uk>
 <20210222075937.GA21946@lst.de>
 <alpine.DEB.2.21.2102221140180.1900@angie.orcam.me.uk>
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

On Mon, 22 Feb 2021, Maciej W. Rozycki wrote:

> > > I haven't booted Linux on my Malta for a while now, but it turns out to 
> > > work just fine, and your patch set does not regress it booting multi-user 
> > > NFS-rooted over FDDI.
> > > 
> > >  I note however that the system does not reboot properly:
> > > 
> > > sd 0:0:0:0: [sda] Synchronizing SCSI cache
> > > reboot: Restarting system
> > > Reboot failed -- System halted
> > > 
> > > which is a regression, and also the MMIO-mapped discrete CBUS UART (ttyS2) 
> > > does not sign in anymore either:
> > 
> > Do you mean a regression with this series, or just compared to when you
> > last tested?
> 
>  When last tested.  Years ago, so nothing for you to be concerned.  I'll 
> look into it sometime unless someone beats me to.  Don't hold your breath 
> though.  Sorry to be unclear.

 For the record, Malta reboot requires:

CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_SYSCON=y

to work these days, which wasn't picked automatically on an older config 
regeneration for me.  Sorry for the noise then, although ISTM that these 
would better be picked up automatically by reverse dependencies.  What's 
the point of omitting reboot support?

 Still looking into the CBUS UART issue.

  Maciej
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
