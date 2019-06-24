Return-Path: <SRS0=0Jvo=UX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BC8C43613
	for <iommu@archiver.kernel.org>; Mon, 24 Jun 2019 12:10:09 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 067F9204FD
	for <iommu@archiver.kernel.org>; Mon, 24 Jun 2019 12:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8wC7xM9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 067F9204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C69ABF3A;
	Mon, 24 Jun 2019 12:10:08 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E171AEEA
	for <iommu@lists.linux-foundation.org>;
	Mon, 24 Jun 2019 11:53:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9E1C182D
	for <iommu@lists.linux-foundation.org>;
	Mon, 24 Jun 2019 11:53:54 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id BD100212F5;
	Mon, 24 Jun 2019 11:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561377234;
	bh=DPkbnAX2UC8HCyA8iQCpieXXckaaIIzpSDhByDPzn7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G8wC7xM9KFMtvOYu/kOVa2McfZiycme1sJMB4laZoRfGXGAGxgIe7MIfXLQhc8m2m
	/hdHyPsY8pRnYQbF5ft5LW2dkkPKET0OwfkBg31pxiBy90cEVRNKtqVeRUmkH9RQLL
	uV2aZb1cM9c8ClPfyvJg5QO6FlwjOKMf0hSks0D4=
Date: Mon, 24 Jun 2019 12:53:49 +0100
From: Will Deacon <will@kernel.org>
To: Will Deacon <will.deacon@arm.com>, bjorn.andersson@linaro.org
Subject: Re: [PATCH] iommu: io-pgtable: Support non-coherent page tables
Message-ID: <20190624115349.f62uqypyt7l73skf@willie-the-truck>
References: <20190515233234.22990-1-bjorn.andersson@linaro.org>
	<20190618173929.GG4270@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190618173929.GG4270@fuggles.cambridge.arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Mailman-Approved-At: Mon, 24 Jun 2019 12:10:07 +0000
Cc: linux-arm-msm@vger.kernel.org, Vivek Gautam <vgautam@qti.qualcomm.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

Hi again, Bjorn,

On Tue, Jun 18, 2019 at 06:39:33PM +0100, Will Deacon wrote:
> On Wed, May 15, 2019 at 04:32:34PM -0700, Bjorn Andersson wrote:
> > Describe the memory related to page table walks as non-cachable for iommu
> > instances that are not DMA coherent.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  drivers/iommu/io-pgtable-arm.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> > index 4e21efbc4459..68ff22ffd2cb 100644
> > --- a/drivers/iommu/io-pgtable-arm.c
> > +++ b/drivers/iommu/io-pgtable-arm.c
> > @@ -803,9 +803,15 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
> >  		return NULL;
> >  
> >  	/* TCR */
> > -	reg = (ARM_LPAE_TCR_SH_IS << ARM_LPAE_TCR_SH0_SHIFT) |
> > -	      (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_IRGN0_SHIFT) |
> > -	      (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_ORGN0_SHIFT);
> > +	if (cfg->quirks & IO_PGTABLE_QUIRK_NO_DMA) {
> > +		reg = (ARM_LPAE_TCR_SH_IS << ARM_LPAE_TCR_SH0_SHIFT) |
> > +		      (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_IRGN0_SHIFT) |
> > +		      (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_ORGN0_SHIFT);
> > +	} else {
> > +		reg = (ARM_LPAE_TCR_SH_IS << ARM_LPAE_TCR_SH0_SHIFT) |
> 
> Nit: this should be outer-shareable (ARM_LPAE_TCR_SH_OS).
> 
> > +		      (ARM_LPAE_TCR_RGN_NC << ARM_LPAE_TCR_IRGN0_SHIFT) |
> > +		      (ARM_LPAE_TCR_RGN_NC << ARM_LPAE_TCR_ORGN0_SHIFT);
> > +	}
> 
> Should we also be doing something similar for the short-descriptor code
> in io-pgtable-arm-v7s.c? Looks like you just need to use ARM_V7S_RGN_NC
> instead of ARM_V7S_RGN_WBWA when initialising ttbr0 for non-coherent
> SMMUs.

Do you plan to respin this? I'll need it this week if you're shooting for
5.3.

Thanks,

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
