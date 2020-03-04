Return-Path: <SRS0=48ym=4V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EDCC3F2D8
	for <iommu@archiver.kernel.org>; Wed,  4 Mar 2020 09:33:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD7F820870
	for <iommu@archiver.kernel.org>; Wed,  4 Mar 2020 09:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="kfVqKPkS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD7F820870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 81BCC8792F;
	Wed,  4 Mar 2020 09:33:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jb0bwzMX326h; Wed,  4 Mar 2020 09:33:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7A16F878AF;
	Wed,  4 Mar 2020 09:33:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 484ACC1AE2;
	Wed,  4 Mar 2020 09:33:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00BF4C013E
 for <iommu@lists.linux-foundation.org>; Wed,  4 Mar 2020 09:33:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DE30787872
 for <iommu@lists.linux-foundation.org>; Wed,  4 Mar 2020 09:33:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9OIf-oBbZbgR for <iommu@lists.linux-foundation.org>;
 Wed,  4 Mar 2020 09:33:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
 by hemlock.osuosl.org (Postfix) with ESMTPS id EF98287850
 for <iommu@lists.linux-foundation.org>; Wed,  4 Mar 2020 09:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0HkZ1kMF7wd60IqJcJvurkKMY19qwn8Dw1XM4W9MFpA=; b=kfVqKPkSZIk2IlvL72KM85wtR
 eUkJ26tQ43FzacwyuvwjDDePPl9NANOicPxu0wRiIN706ec8hIhkLeqn49JFu2NilssahS3IYRuRw
 ifexbSisZpXWVU5PZ472pJ3MsOOHUML8+6zLI7ESSLUjYBUoDdlrJQiX1NqBxYfvvQARMnMATnQzA
 1nFBt9aWPXxPRZ4Q2gwFukB5WoBNbJk9s8cb8kV8lOrVohs4RR91zlvyoAuCqhWKeLIRle9dPflWi
 br7IWjbWFmkEKbHWnrAbcRO8A/EzxiXs35JRlT4x+xYbPhPtonf4PTw3+ruIUwsS3+D1WIhckYpx8
 rw0kqETsQ==;
Received: from shell.armlinux.org.uk
 ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60222)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1j9QPI-0005a9-9O; Wed, 04 Mar 2020 09:33:36 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1j9QPC-0006nY-RU; Wed, 04 Mar 2020 09:33:30 +0000
Date: Wed, 4 Mar 2020 09:33:30 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: Re: [PATCH] iommu: silence iommu group prints
Message-ID: <20200304093330.GX25745@shell.armlinux.org.uk>
References: <E1j7Hnc-0004Bm-Kn@rmk-PC.armlinux.org.uk>
 <f0fc4c8c-4475-e77f-da6d-e068e7993568@linux.intel.com>
 <b4029a97-ac80-484f-9d01-d7f4eb174cdd@huawei.com>
 <20200228100644.GT25745@shell.armlinux.org.uk>
 <95af8fc3-d7b1-3b58-afc1-d203d7538b95@arm.com>
 <bcb9fbab-2943-3207-b69d-e7ce9e3e3a8e@nxp.com>
 <20200303154959.GR25745@shell.armlinux.org.uk>
 <ac9dc4b1-e3a4-2b69-7c61-d94e082cef30@nxp.com>
 <20200303221745.GV25745@shell.armlinux.org.uk>
 <62b3d48a-af5f-b44b-07cd-83aa7663c45f@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <62b3d48a-af5f-b44b-07cd-83aa7663c45f@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Diana Madalina Craciun <diana.craciun@nxp.com>,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>
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

On Wed, Mar 04, 2020 at 10:56:06AM +0200, Laurentiu Tudor wrote:
> 
> On 04.03.2020 00:17, Russell King - ARM Linux admin wrote:
> > On Tue, Mar 03, 2020 at 05:55:05PM +0200, Laurentiu Tudor wrote:
> > >  From c98dc05cdd45ae923654f2427985bd28bcde4bb2 Mon Sep 17 00:00:00 2001
> > > From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > > Date: Thu, 13 Feb 2020 11:59:12 +0200
> > > Subject: [PATCH 1/4] bus: fsl-mc: add custom .dma_configure implementation
> > > Content-Type: text/plain; charset="us-ascii"
> > > 
> > > The devices on this bus are not discovered by way of device tree
> > > but by queries to the firmware. It makes little sense to trick the
> > > generic of layer into thinking that these devices are of related so
> > > that we can get our dma configuration. Instead of doing that, add
> > > our custom dma configuration implementation.
> > 
> > Firstly, applying this to v5.5 results in a build failure, due to a
> > missing linux/iommu.h include.
> > 
> > Secondly, this on its own appears to make the DPAA2 network interfaces
> > completely disappear.  Looking in /sys/bus/fsl-mc/drivers/*, none of
> > the DPAA2 drivers are bound to anything, and looking in
> > /sys/bus/fsl-mc/devices/, there is:
> > 
> > lrwxrwxrwx 1 root root 0 Mar  3 22:06 dprc.1 -> ../../../devices/platform/soc/80c000000.fsl-mc/dprc.1
> > 
> > This is booting with u-boot, so using DT rather than ACPI.
> > 
> > > Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > > ---
> > >   drivers/bus/fsl-mc/fsl-mc-bus.c | 42 ++++++++++++++++++++++++++++++++-
> > >   1 file changed, 41 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> > > index 36eb25f82c8e..3df015eedae4 100644
> > > --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> > > +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> > > @@ -132,11 +132,51 @@ static int fsl_mc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
> > >   static int fsl_mc_dma_configure(struct device *dev)
> > >   {
> > >   	struct device *dma_dev = dev;
> > > +	struct iommu_fwspec *fwspec;
> > > +	const struct iommu_ops *iommu_ops;
> > > +	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
> > > +	int ret;
> > > +	u32 icid;
> > > +
> > > +	/* Skip DMA setup for devices that are not DMA masters */
> > > +	if (dev->type == &fsl_mc_bus_dpmcp_type ||
> > > +	    dev->type == &fsl_mc_bus_dpbp_type ||
> > > +	    dev->type == &fsl_mc_bus_dpcon_type ||
> > > +	    dev->type == &fsl_mc_bus_dpio_type)
> > > +		return 0;
> > >   	while (dev_is_fsl_mc(dma_dev))
> > >   		dma_dev = dma_dev->parent;
> > > -	return of_dma_configure(dev, dma_dev->of_node, 0);
> > > +	fwspec = dev_iommu_fwspec_get(dma_dev);
> > > +	if (!fwspec)
> > > +		return -ENODEV;
> > 
> > The problem appears to be here - fwspec is NULL for dprc.1.
> 
> Ok, that's because the iommu config is missing from the DT node that's
> exposing the MC firmware. I've attached a fresh set of patches that include
> on top the missing config and a workaround that makes MC work over SMMU.
> Also added the missing #include, thanks for pointing out.
> Let me know how it goes.

Shouldn't patch 6 should be first in the series, so that patch 1 does
not cause a regression and bisectability damage?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
