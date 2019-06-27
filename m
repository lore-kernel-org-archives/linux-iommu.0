Return-Path: <SRS0=izKu=U2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8848C48BD7
	for <iommu@archiver.kernel.org>; Thu, 27 Jun 2019 09:08:15 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F40F2082F
	for <iommu@archiver.kernel.org>; Thu, 27 Jun 2019 09:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DjCAxcB+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F40F2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 60382BA9;
	Thu, 27 Jun 2019 09:08:15 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 212F78E2
	for <iommu@lists.linux-foundation.org>;
	Thu, 27 Jun 2019 09:08:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 1D4DA710
	for <iommu@lists.linux-foundation.org>;
	Thu, 27 Jun 2019 09:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uzmtbQiP/E97xcrmWaFV5+3QZltHTvJjVI9b3LB5D8I=;
	b=DjCAxcB+VswqaopA6VxTIMIZ9
	qSanT0W4LNOdqoeCAZKQUSQc++vRTWh/+KDCE+wS+MUmcCHm2U7uziaOfuJ4PkyGoDqXnkPOZl2FO
	+QJhTNUAtOKMhZol//VV351igMHoTtWfYiEDDBDCXsUuGE7+oDvtfGRuRontP4NdJvft8e5E66lkO
	My5iCENlCjoOj28Gy7ol1MY/UpAej7M8DY8TBZtL4ktV7vebZJpi/+8vnLuIFAsHopCJEPKaVyRnk
	TuYXKPuXa4ZCt1IvxfZffYi0ZSrq7Fa7navC9bT3S9n//Q1tmRsljkVLS8atS9y9rkb2tFC2dQLLE
	O026nmgvQ==;
Received: from shell.armlinux.org.uk
	([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60044)
	by pandora.armlinux.org.uk with esmtpsa
	(TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
	(envelope-from <linux@armlinux.org.uk>)
	id 1hgQNq-0001v4-IT; Thu, 27 Jun 2019 10:08:02 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1hgQNl-0000Qa-GQ; Thu, 27 Jun 2019 10:07:53 +0100
Date: Thu, 27 Jun 2019 10:07:53 +0100
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: SATA broken with LPAE
Message-ID: <20190627090753.b5xfpnsicynnqj5c@shell.armlinux.org.uk>
References: <16f065ef-f4ac-46b4-de2a-6b5420ae873a@ti.com>
	<20190626125325.GA4744@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190626125325.GA4744@lst.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: axboe@kernel.dk, Vignesh Raghavendra <vigneshr@ti.com>,
	martin.petersen@oracle.com, linux-ide@vger.kernel.org,
	Tony Lindgren <tony@atomide.com>, jejb@linux.ibm.com, "Nori,
	Sekhar" <nsekhar@ti.com>, "hdegoede@redhat.com" <hdegoede@redhat.com>,
	iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org,
	Roger Quadros <rogerq@ti.com>
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

On Wed, Jun 26, 2019 at 02:53:25PM +0200, Christoph Hellwig wrote:
> Hi Roger,
> 
> it seems the arm dma direct mapping code isn't doing the right thing
> here.  On other platforms that have > 4G memory we always use swiotlb
> for bounce buffering in case a device that can't DMA to all the memory.
> 
> Arm is the odd one out and uses its own dmabounce framework instead,
> but it seems like it doesn't get used in this case.  We need to make
> sure dmabounce (or swiotlb for that matter) is set up if > 32-bit
> addressing is supported.  I'm not really an arm platform expert,
> but some of those on the Cc list are and might chime in on how to
> do that.

dmabounce has only ever been used with specific devices that have weird
setups.  Otherwise, we've never expected what you describe on ARM.  I
also don't recognise your assertion about the way the DMA API should
behave as ever having been documented as a requirement for architectures
to implement.

dmabounce comes with it some serious issues that have been known to
cause OOMs with old kernels (which have never been solved), so that
really isn't the answer.

This kind of breakage that is now being reported is exactly the problem
that I thought would happen with your patches.

32-bit ARM is in maintenance only now, there is no longer any appetite
nor funding for development work on core code.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
