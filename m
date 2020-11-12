Return-Path: <SRS0=2i4G=ES=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB09C56201
	for <iommu@archiver.kernel.org>; Thu, 12 Nov 2020 09:44:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77374221FC
	for <iommu@archiver.kernel.org>; Thu, 12 Nov 2020 09:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJxlZKiQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77374221FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0DBE287698;
	Thu, 12 Nov 2020 09:44:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uRFfCc19oXBB; Thu, 12 Nov 2020 09:44:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7F0DF87695;
	Thu, 12 Nov 2020 09:44:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F96BC08A1;
	Thu, 12 Nov 2020 09:44:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7953C0889
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 09:44:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B55A386DD0
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 09:44:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VwTQptGSRvmc for <iommu@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 09:44:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E989686BE9
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 09:43:59 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 131DA221FC;
 Thu, 12 Nov 2020 09:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605174239;
 bh=PX0Rx6DcDiPgOuXIk7NQwtEU8lgYXlKPndWTh8AkZDM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NJxlZKiQ5RXRwLtdPQ973uyiOTFXEykVI1DX9HmOJRvYKPh3u0K8Cszg6f/NljKSF
 diotEEHr2Um5xjKVUnh/nL6p3VIaEvbDAD+193gZDC62PiTc8QjnvFILYIx2E6JRCJ
 4k4dUTiNPZZmeB5XqjVkNNvPYbl6OpWNP6NBWtzY=
Date: Thu, 12 Nov 2020 09:43:53 +0000
From: Will Deacon <will@kernel.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCHv7 1/7] iommu/io-pgtable-arm: Add support to use system
 cache
Message-ID: <20201112094353.GB19049@willie-the-truck>
References: <cover.1604048969.git.saiprakash.ranjan@codeaurora.org>
 <1d4979c0dcf649c5717605c598067b4b225ab9de.1604048969.git.saiprakash.ranjan@codeaurora.org>
 <20201110121855.GD16239@willie-the-truck>
 <329542c0c09054a46fa8d6d8f92ad739@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <329542c0c09054a46fa8d6d8f92ad739@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Akhil P Oommen <akhilpo@codeaurora.org>, dri-devel@lists.freedesktop.org,
 "Kristian H . Kristensen" <hoegsberg@google.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On Wed, Nov 11, 2020 at 11:32:42AM +0530, Sai Prakash Ranjan wrote:
> On 2020-11-10 17:48, Will Deacon wrote:
> > On Fri, Oct 30, 2020 at 02:53:08PM +0530, Sai Prakash Ranjan wrote:
> > > Add a quirk IO_PGTABLE_QUIRK_SYS_CACHE to override the
> > > attributes set in TCR for the page table walker when
> > > using system cache.
> > > 
> > > Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> > > ---
> > >  drivers/iommu/io-pgtable-arm.c | 7 ++++++-
> > >  include/linux/io-pgtable.h     | 4 ++++
> > >  2 files changed, 10 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iommu/io-pgtable-arm.c
> > > b/drivers/iommu/io-pgtable-arm.c
> > > index a7a9bc08dcd1..a356caf1683a 100644
> > > --- a/drivers/iommu/io-pgtable-arm.c
> > > +++ b/drivers/iommu/io-pgtable-arm.c
> > > @@ -761,7 +761,8 @@ arm_64_lpae_alloc_pgtable_s1(struct
> > > io_pgtable_cfg *cfg, void *cookie)
> > > 
> > >  	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS |
> > >  			    IO_PGTABLE_QUIRK_NON_STRICT |
> > > -			    IO_PGTABLE_QUIRK_ARM_TTBR1))
> > > +			    IO_PGTABLE_QUIRK_ARM_TTBR1 |
> > > +			    IO_PGTABLE_QUIRK_SYS_CACHE))
> > >  		return NULL;
> > > 
> > >  	data = arm_lpae_alloc_pgtable(cfg);
> > > @@ -773,6 +774,10 @@ arm_64_lpae_alloc_pgtable_s1(struct
> > > io_pgtable_cfg *cfg, void *cookie)
> > >  		tcr->sh = ARM_LPAE_TCR_SH_IS;
> > >  		tcr->irgn = ARM_LPAE_TCR_RGN_WBWA;
> > >  		tcr->orgn = ARM_LPAE_TCR_RGN_WBWA;
> > > +	} else if (cfg->quirks & IO_PGTABLE_QUIRK_SYS_CACHE) {
> > > +		tcr->sh = ARM_LPAE_TCR_SH_OS;
> > > +		tcr->irgn = ARM_LPAE_TCR_RGN_NC;
> > > +		tcr->orgn = ARM_LPAE_TCR_RGN_WBWA;
> > 
> > Given that this only applies in the case where then page-table walker is
> > non-coherent, I think we'd be better off renaming the quirk to something
> > like IO_PGTABLE_QUIRK_ARM_OUTER_WBWA and then rejecting it in the
> > non-coherent case.
> > 
> 
> Do you mean like below?
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index a7a9bc08dcd1..94de1f71db42 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -776,7 +776,10 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg
> *cfg, void *cookie)
>         } else {
>                 tcr->sh = ARM_LPAE_TCR_SH_OS;
>                 tcr->irgn = ARM_LPAE_TCR_RGN_NC;
> -               tcr->orgn = ARM_LPAE_TCR_RGN_NC;
> +               if (!(cfg->quirks & IO_PGTABLE_QUIRK_ARM_OUTER_WBWA))
> +                       tcr->orgn = ARM_LPAE_TCR_RGN_NC;
> +               else
> +                       tcr->orgn = ARM_LPAE_TCR_RGN_WBWA;

Yes, but rejecting the quirk if the walker is coherent (I accidentally said
"non-coherent" earlier on).

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
