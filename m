Return-Path: <SRS0=48ym=4V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D2CC3F2D7
	for <iommu@archiver.kernel.org>; Wed,  4 Mar 2020 10:53:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D1102166E
	for <iommu@archiver.kernel.org>; Wed,  4 Mar 2020 10:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="GWRHlGeo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D1102166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DCF9285692;
	Wed,  4 Mar 2020 10:53:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TG34sQjeFUAy; Wed,  4 Mar 2020 10:53:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1EE12853C5;
	Wed,  4 Mar 2020 10:53:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01546C089F;
	Wed,  4 Mar 2020 10:53:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51BBEC013E
 for <iommu@lists.linux-foundation.org>; Wed,  4 Mar 2020 10:53:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 45CB087941
 for <iommu@lists.linux-foundation.org>; Wed,  4 Mar 2020 10:53:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jiywK0nKQkyc for <iommu@lists.linux-foundation.org>;
 Wed,  4 Mar 2020 10:53:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 729A2878B8
 for <iommu@lists.linux-foundation.org>; Wed,  4 Mar 2020 10:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xEopWrJaAgu0JDkc58cCosIzSOKrHogLF7ad77AdnJc=; b=GWRHlGeoxsIWyFL+g+EkenNZ/
 SQm6Ef9SdBnTQoXn0OO2JsuSkH4Sarn9B+Sx9DBJpxUPvt5bw9L2JdVnDPbX2uu2Z5GUx61YWzdJu
 5bDF8bwX2y5ZhYvU3uv9AwdkmKvFnzeF+YUnDWuRwKa8cs6yJfPqVCdc5m/BceHt6w8uGBUocdvtb
 wFOwi4dw34Zui3bxe5gy9K7gvmSgDVXMUzQenYqdzZ052/7CNvQoBhikhhTegCgPLzCZlebnvCpuX
 TBmX2HTx3Zs40LeENge+v6MHMwh/B9QGyuLdBw7y3oZhEuEOi5lGAhpVg6zum2dv7D5bG9eAuGQdC
 XckxknNGQ==;
Received: from shell.armlinux.org.uk
 ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:48598)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1j9Re2-0005wd-PI; Wed, 04 Mar 2020 10:52:54 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1j9Rdx-0006rG-5p; Wed, 04 Mar 2020 10:52:49 +0000
Date: Wed, 4 Mar 2020 10:52:49 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: Re: [PATCH] iommu: silence iommu group prints
Message-ID: <20200304105249.GA25745@shell.armlinux.org.uk>
References: <20200303154959.GR25745@shell.armlinux.org.uk>
 <ac9dc4b1-e3a4-2b69-7c61-d94e082cef30@nxp.com>
 <20200303221745.GV25745@shell.armlinux.org.uk>
 <62b3d48a-af5f-b44b-07cd-83aa7663c45f@nxp.com>
 <20200304093330.GX25745@shell.armlinux.org.uk>
 <78f175be-0701-b6cd-8feb-1343f9982d4c@nxp.com>
 <20200304095112.GY25745@shell.armlinux.org.uk>
 <b9f4e9ad-033f-b5cf-9578-38f8367ef8cd@nxp.com>
 <20200304100713.GZ25745@shell.armlinux.org.uk>
 <6dd33f8d-0eee-83ad-a257-878e9ef83721@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6dd33f8d-0eee-83ad-a257-878e9ef83721@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Diana Madalina Craciun <diana.craciun@nxp.com>,
 iommu@lists.linux-foundation.org, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Robin Murphy <robin.murphy@arm.com>
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

On Wed, Mar 04, 2020 at 12:33:14PM +0200, Laurentiu Tudor wrote:
> 
> 
> On 04.03.2020 12:07, Russell King - ARM Linux admin wrote:
> > On Wed, Mar 04, 2020 at 11:56:53AM +0200, Laurentiu Tudor wrote:
> > >  From 44ae46501b5379bd0890df87fd3827248626ed03 Mon Sep 17 00:00:00 2001
> > > From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > > Date: Tue, 1 Oct 2019 16:22:48 +0300
> > > Subject: [PATCH 1/6] bus: fsl-mc: make mc work with smmu disable bypass on
> > > Content-Type: text/plain; charset="us-ascii"
> > > 
> > > Since this commit [1] booting kernel on MC based chips started to
> > > fail because this firmware starts before the kernel and as soon as
> > > SMMU is probed it starts to trigger contiguous faults.
> > 
> > I think you mean "continuous" here.
> 
> Yes, thanks.
> 
> > > This is a workaround that allows MC firmware to run with SMMU
> > > in disable bypass mode. It consists of the following steps:
> > >   1. pause the firmware at early boot to get a chance to setup SMMU
> > >   2. request direct mapping for MC device
> > >   3. resume the firmware
> > > The workaround relies on the fact that no state is lost when
> > > pausing / resuming firmware, as per the docs.
> > > With this patch, platforms with MC firmware can now boot without
> > > having to change the default config to set:
> > >    CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT=n
> > 
> > This alone is a definite improvement, and has been needed for a while.
> > Please submit this patch with an appropriate Fixes: tag so stable trees
> > can pick it up.
> 
> The thing is that probably this workaround will never make it in the kernel
> because it questionable to say the least, e.g. see [1]. My plan is to give
> this approach [2] a try sometime soon.
> 
> [1] https://patchwork.kernel.org/comment/23149049/
> [2] https://patchwork.kernel.org/cover/11279577/

So, if we want to reduce the iommu noise, we need to completely break
the ability to use a mainline kernel on the LX2160A.  This doesn't
seem practical nor sensible.  Someone has to give.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
