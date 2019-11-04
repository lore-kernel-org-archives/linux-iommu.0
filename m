Return-Path: <SRS0=uwQI=Y4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711A9CA9ECF
	for <iommu@archiver.kernel.org>; Mon,  4 Nov 2019 18:37:03 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D5782084D
	for <iommu@archiver.kernel.org>; Mon,  4 Nov 2019 18:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRIiJb4H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D5782084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 17749EEC;
	Mon,  4 Nov 2019 18:37:02 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E91D9EC6
	for <iommu@lists.linux-foundation.org>;
	Mon,  4 Nov 2019 18:37:00 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 99646A9
	for <iommu@lists.linux-foundation.org>;
	Mon,  4 Nov 2019 18:37:00 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 982402084D;
	Mon,  4 Nov 2019 18:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572892620;
	bh=rI9UdgOktprMFD0/dk/zkRwmYAt4WKteXodRLuUYe3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iRIiJb4HSMW81NtrCy2YeZDd7heklVx9fWbj/p5yijsTcRuRNChpwHsmixfH32DXy
	6Q0vgAbPOQB300DZVgLFEEeKloViv3Yve8PbvfJQrZB4yHkNKHhgoET4uYEk8ZVhrI
	ethMrdUnoMXe2II1IvQZG9bduv2G3tKVRaVQ/IXU=
Date: Mon, 4 Nov 2019 18:36:56 +0000
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 08/10] iommu/io-pgtable-arm: Rationalise TTBRn handling
Message-ID: <20191104183655.GH24909@willie-the-truck>
References: <cover.1572024119.git.robin.murphy@arm.com>
	<74ada0e6c488a2310206a553eb108cc28fd52457.1572024120.git.robin.murphy@arm.com>
	<5324d888-857a-b07c-439c-4ae4ea3a9784@arm.com>
	<a74dcecd-7061-ce4b-85e1-deaadd0f71a4@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a74dcecd-7061-ce4b-85e1-deaadd0f71a4@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
	Steven Price <steven.price@arm.com>
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

On Mon, Oct 28, 2019 at 06:51:55PM +0000, Robin Murphy wrote:
> On 28/10/2019 15:09, Steven Price wrote:
> [...]
> > > --- a/drivers/iommu/io-pgtable-arm-v7s.c
> > > +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> > > @@ -822,15 +822,13 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
> > >   	/* Ensure the empty pgd is visible before any actual TTBR write */
> > >   	wmb();
> > > -	/* TTBRs */
> > > -	cfg->arm_v7s_cfg.ttbr[0] = virt_to_phys(data->pgd) |
> > > -				   ARM_V7S_TTBR_S | ARM_V7S_TTBR_NOS |
> > > -				   (cfg->coherent_walk ?
> > > -				   (ARM_V7S_TTBR_IRGN_ATTR(ARM_V7S_RGN_WBWA) |
> > > -				    ARM_V7S_TTBR_ORGN_ATTR(ARM_V7S_RGN_WBWA)) :
> > > -				   (ARM_V7S_TTBR_IRGN_ATTR(ARM_V7S_RGN_NC) |
> > > -				    ARM_V7S_TTBR_ORGN_ATTR(ARM_V7S_RGN_NC)));
> > > -	cfg->arm_v7s_cfg.ttbr[1] = 0;
> > > +	/* TTBR */
> > > +	cfg->arm_v7s_cfg.ttbr = virt_to_phys(data->pgd) | ARM_V7S_TTBR_S |
> > > +				(cfg->coherent_walk ? (ARM_V7S_TTBR_NOS |
> > > +				  ARM_V7S_TTBR_IRGN_ATTR(ARM_V7S_RGN_WBWA) |
> > > +				  ARM_V7S_TTBR_ORGN_ATTR(ARM_V7S_RGN_WBWA)) :
> > > +				 (ARM_V7S_TTBR_IRGN_ATTR(ARM_V7S_RGN_NC) |
> > > +				  ARM_V7S_TTBR_ORGN_ATTR(ARM_V7S_RGN_NC)));
> > 
> > ARM_V7S_TTBR_NOS seems to have sneaked into the cfg->coherent_walk
> > condition here - which you haven't mentioned in the commit log, so it
> > doesn't look like it should be in this commit.
> 
> Ah, yes, it's taken a while to remember whether this was something important
> that got muddled up in rebasing, but it's actually just trivial cleanup. For
> !coherent_walk, the non-cacheable output attribute makes shareable accesses
> implicitly outer-shareable, so setting TTBR.NOS for that case actually does
> nothing except look misleading. Thus this is essentially just a cosmetic
> change included in the reformatting for clarity and consistency with the
> LPAE version. I'll call that out in the commit message, thanks for spotting!

I vaguely remember a case where you had to mark non-cacheable accesses as
outer-shareable explicitly to avoid unpredictable behaviour. Hmm.

/me looks at the Arm ARM

Ok, it looks like this changed between ARMv7 and ARMv8. The ARMv7 ARM
states:

  | A memory region with a resultant memory type attribute of Normal, and a
  | resultant cacheability attribute of Inner Non-cacheable, Outer
  | Non-cacheable, must have a resultant shareability attribute of Outer
  | Shareable, otherwise shareability is UNPREDICTABLE.

Although this only seems to be the case for LPAE! The short descriptor docs are
less clear, but I think it might be wise to ensure that non-cacheable mappings
are always outer-shareable for consistency.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
