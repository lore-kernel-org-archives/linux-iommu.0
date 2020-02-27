Return-Path: <SRS0=1PsK=4P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62499C11D3D
	for <iommu@archiver.kernel.org>; Thu, 27 Feb 2020 19:00:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E25A246AF
	for <iommu@archiver.kernel.org>; Thu, 27 Feb 2020 19:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="TXsyDZdY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E25A246AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D2811204C3;
	Thu, 27 Feb 2020 19:00:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RbhYEVZ0uXUv; Thu, 27 Feb 2020 19:00:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C10CD203D0;
	Thu, 27 Feb 2020 19:00:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B20B7C08A0;
	Thu, 27 Feb 2020 19:00:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00A6CC0177
 for <iommu@lists.linux-foundation.org>; Thu, 27 Feb 2020 19:00:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E19A2864F2
 for <iommu@lists.linux-foundation.org>; Thu, 27 Feb 2020 19:00:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 90LuWVylze5f for <iommu@lists.linux-foundation.org>;
 Thu, 27 Feb 2020 19:00:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6778E864C3
 for <iommu@lists.linux-foundation.org>; Thu, 27 Feb 2020 19:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PsjnWkgjUw1GQ9Llh06ZeuwXuCFG98Hbk//l5xzUXsM=; b=TXsyDZdYQr7u7ejnG9kNwdGWO
 bpM/aBLVr9sz8xzDiQEeK/gWXWH6ye0+guF0DdM2I0gIT2OHLXgahm7qlq35+cteaS52XB0wrI9xl
 1OQPTKBe3RoNdjp4Ps8OSqh70OEY6+dP/kfLVbOM24hIheYEXPRuO5YAQ52iqVI56RpxmO2bLVt/B
 rM7j7O0PIU8jKDOFdLebj8ltE4gFrsOW4hdNh4jEfDZ6gX6RMjM1iUm1xKArbb46Xc4udrDCLggAc
 h1C8w4sAW23YKvRyF/oJjoJh+oGi7ah2law3+ruWlldXwL1WUWDgEFYlZRtmlGdi7btiqNzXTTbBd
 FhJqs59SA==;
Received: from shell.armlinux.org.uk
 ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57732)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1j7OOL-0007Uj-5k; Thu, 27 Feb 2020 19:00:13 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1j7OOI-0001Cq-CJ; Thu, 27 Feb 2020 19:00:10 +0000
Date: Thu, 27 Feb 2020 19:00:10 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu: silence iommu group prints
Message-ID: <20200227190010.GR25745@shell.armlinux.org.uk>
References: <E1j7Hnc-0004Bm-Kn@rmk-PC.armlinux.org.uk>
 <2b86add2-03aa-21f1-c58a-120a8394e6eb@arm.com>
 <20200227134839.GL25745@shell.armlinux.org.uk>
 <a76d0425-c25c-60e9-3f5d-a33f49fd2989@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a76d0425-c25c-60e9-3f5d-a33f49fd2989@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org
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

On Thu, Feb 27, 2020 at 06:19:10PM +0000, Robin Murphy wrote:
> On 27/02/2020 1:48 pm, Russell King - ARM Linux admin wrote:
> > On Thu, Feb 27, 2020 at 01:44:56PM +0000, Robin Murphy wrote:
> > > On 27/02/2020 11:57 am, Russell King wrote:
> > > > On the LX2160A, there are lots (about 160) of IOMMU messages produced
> > > > during boot; this is excessive.  Reduce the severity of these messages
> > > > to debug level.
> > > 
> > > That's... a lot. Does the system really have that many devices, or is some
> > > driver being stupid and repeatedly populating and destroying an entire bus
> > > in a probe-deferral dance?
> > 
> > It's all the devices created by for the mc-bus for the DPAA2
> > networking support.  I don't know the technicalities, just that
> > the boot is spammed with these messages.
> 
> Well, the "technicalities" are really just whether the thing before the
> colon on each message is unique or not. If you're seeing multiple add and
> remove calls pertaining to the same device (or frankly any remove calls at
> all during boot) then it smacks of something somewhere wasting time and
> resources with unnecessary busywork, which is indicative of either poor
> design or an actual bug, either of which would deserve fixing.

It's not the same device.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
