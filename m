Return-Path: <SRS0=B4OP=WL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD354C3A59C
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 14:05:20 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A133B2086C
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 14:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtMKB3MH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A133B2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6609CEEC;
	Thu, 15 Aug 2019 14:05:20 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 0A8F0EE5
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 14:05:19 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B5BCD89D
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 14:05:18 +0000 (UTC)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
	[83.86.89.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 171BD20644;
	Thu, 15 Aug 2019 14:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565877918;
	bh=lOyzTACCHACUENr3Alx4Ml7IiaPxhwyXrxfcBKWNBJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PtMKB3MHNCBeXVQklF3aBuT4nPDLyDVWODXEgp48SJZXXqW5ovAbc9FVn+3tX8FKE
	pR1oRIblVReZKrtntkhiaZUu9/e7AjwFuaI4yblInt8eTNK1NW/ZB7XjP4YTtW5VlW
	eNlY1nowm+mCe1y3E25iAZAab2798Rbm62UuKYmw=
Date: Thu, 15 Aug 2019 16:05:16 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 6/6] driver core: initialize a default DMA mask for
	platform device
Message-ID: <20190815140516.GB7174@kroah.com>
References: <20190811080520.21712-1-hch@lst.de>
	<20190811080520.21712-7-hch@lst.de>
	<20190815130325.GB17065@kroah.com> <20190815133812.GF12036@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190815133812.GF12036@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Cc: Gavin Li <git@thegavinli.com>, Fabio Estevam <festevam@gmail.com>,
	linux-arch@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Alan Stern <stern@rowland.harvard.edu>, NXP Linux Team <linux-imx@nxp.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Minas Harutyunyan <hminas@synopsys.com>,
	Olav Kongas <ok@artecdesign.ee>, Bin Liu <b-liu@ti.com>,
	linux-arm-kernel@lists.infradead.org, Geoff Levand <geoff@infradead.org>,
	Shawn Guo <shawnguo@kernel.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tony Prisk <linux@prisktech.co.nz>,
	iommu@lists.linux-foundation.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linuxppc-dev@lists.ozlabs.org
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

On Thu, Aug 15, 2019 at 03:38:12PM +0200, Christoph Hellwig wrote:
> On Thu, Aug 15, 2019 at 03:03:25PM +0200, Greg Kroah-Hartman wrote:
> > > --- a/include/linux/platform_device.h
> > > +++ b/include/linux/platform_device.h
> > > @@ -24,6 +24,7 @@ struct platform_device {
> > >  	int		id;
> > >  	bool		id_auto;
> > >  	struct device	dev;
> > > +	u64		dma_mask;
> > 
> > Why is the dma_mask in 'struct device' which is part of this structure,
> > not sufficient here?  Shouldn't the "platform" be setting that up
> > correctly already in the "archdata" type callback?
> 
> Becaus the dma_mask in struct device is a pointer that needs to point
> to something, and this is the best space we can allocate for 'something'.
> m68k and powerpc currently do something roughly equivalent at the moment,
> while everyone else just has horrible, horrible hacks.  As mentioned in
> the changelog the intent of this patch is that we treat platform devices
> like any other bus, where the bus allocates the space for the dma_mask.
> The long term plan is to eventually kill that weird pointer indirection
> that doesn't help anyone, but for that we need to sort out the basics
> first.

Ah, missed that, sorry.  Ok, no objection from me.  Might as well respin
this series and I can queue it up after 5.3-rc5 is out (which will have
your first 2 patches in it.)

thanks,

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
