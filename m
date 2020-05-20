Return-Path: <SRS0=jIn/=7C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F91C433E1
	for <iommu@archiver.kernel.org>; Wed, 20 May 2020 12:30:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61D9220756
	for <iommu@archiver.kernel.org>; Wed, 20 May 2020 12:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CS7PL+Rv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D9220756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 854E023BE7;
	Wed, 20 May 2020 12:29:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id psi+C7a1Gofy; Wed, 20 May 2020 12:29:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 4110520409;
	Wed, 20 May 2020 12:29:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 253C3C088A;
	Wed, 20 May 2020 12:29:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51F07C0176
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 12:29:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 46DE986D3C
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 12:29:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7PZft77Bg8oT for <iommu@lists.linux-foundation.org>;
 Wed, 20 May 2020 12:29:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2C83A86D38
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 12:29:55 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0ED9220756;
 Wed, 20 May 2020 12:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589977794;
 bh=VGu6dnFTVCKwpzDnxKnQRdLF/W/wyJaAlcUliCdCrVI=;
 h=Date:From:To:Subject:References:In-Reply-To:From;
 b=CS7PL+Rv9R79fZvV9gVfqHsdFTW+yiv6vBsmUCaPQwLsKoCYHz1X0yfF/9Kr3meYs
 XZE7O/O1PL8P7RYyCqt3nWMznsAp679ACj9891L9JLhyVUBlLdmdQ5zeRG3Aw7QEDm
 UaZMBvb7sEpwGADI/np+Sj49wPgdwWhHqDDEcTNA=
Date: Wed, 20 May 2020 13:29:49 +0100
From: Will Deacon <will@kernel.org>
To: iommu@lists.linux-foundation.org, linux-arm-msm@vger.kernel.org,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
 Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/5] iommu/arm-smmu: Add support for TTBR1
Message-ID: <20200520122949.GC25815@willie-the-truck>
References: <20200409233350.6343-1-jcrouse@codeaurora.org>
 <20200409233350.6343-3-jcrouse@codeaurora.org>
 <20200518145959.GK32394@willie-the-truck>
 <20200520015326.GA31730@jcrouse1-lnx.qualcomm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200520015326.GA31730@jcrouse1-lnx.qualcomm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

On Tue, May 19, 2020 at 07:53:26PM -0600, Jordan Crouse wrote:
> On Mon, May 18, 2020 at 03:59:59PM +0100, Will Deacon wrote:
> > On Thu, Apr 09, 2020 at 05:33:47PM -0600, Jordan Crouse wrote:
> > > Add support to enable TTBR1 if the domain requests it via the
> > > DOMAIN_ATTR_SPLIT_TABLES attribute. If enabled by the hardware
> > > and pagetable configuration the driver will configure the TTBR1 region
> > > and program the domain pagetable on TTBR1. TTBR0 will be disabled.
> > > 
> > > After attaching the device the value of he domain attribute can
> > > be queried to see if the split pagetables were successfully programmed.
> > > The domain geometry will be updated as well so that the caller can
> > > determine the active region for the pagetable that was programmed.
> > > 
> > > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > > ---
> > > 
> > >  drivers/iommu/arm-smmu.c | 48 ++++++++++++++++++++++++++++++++++------
> > >  drivers/iommu/arm-smmu.h | 24 +++++++++++++++-----
> > >  2 files changed, 59 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > > index a6a5796e9c41..db6d503c1673 100644
> > > --- a/drivers/iommu/arm-smmu.c
> > > +++ b/drivers/iommu/arm-smmu.c
> > > @@ -555,11 +555,16 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
> > >  			cb->ttbr[0] = pgtbl_cfg->arm_v7s_cfg.ttbr;
> > >  			cb->ttbr[1] = 0;
> > >  		} else {
> > > -			cb->ttbr[0] = pgtbl_cfg->arm_lpae_s1_cfg.ttbr;
> > > -			cb->ttbr[0] |= FIELD_PREP(ARM_SMMU_TTBRn_ASID,
> > > -						  cfg->asid);
> > > -			cb->ttbr[1] = FIELD_PREP(ARM_SMMU_TTBRn_ASID,
> > > -						 cfg->asid);
> > > +			cb->ttbr[0] = FIELD_PREP(ARM_SMMU_TTBRn_ASID,
> > > +				cfg->asid);
> > > +
> > > +			if (pgtbl_cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1) {
> > > +				cb->ttbr[1] = pgtbl_cfg->arm_lpae_s1_cfg.ttbr;
> > > +			} else {
> > > +				cb->ttbr[0] |= pgtbl_cfg->arm_lpae_s1_cfg.ttbr;
> > > +				cb->ttbr[1] = FIELD_PREP(ARM_SMMU_TTBRn_ASID,
> > > +							 cfg->asid);
> > > +			}
> > 
> > This looks odd to me. As I mentioned before, the SMMU driver absolutely has
> > to manage the ASID space, so we should be setting it in both TTBRs here.
> 
> Somebody had suggested a while back to only do TTBR0 but I agree that it makes
> more sense for it to be on both.

Sorry if it was me, I've been having a hard time piecing together how this
works with the GPU.

> > > diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
> > > index 8d1cd54d82a6..5f6d0af7c8c8 100644
> > > --- a/drivers/iommu/arm-smmu.h
> > > +++ b/drivers/iommu/arm-smmu.h
> > > @@ -172,6 +172,7 @@ enum arm_smmu_cbar_type {
> > >  #define ARM_SMMU_TCR_SH0		GENMASK(13, 12)
> > >  #define ARM_SMMU_TCR_ORGN0		GENMASK(11, 10)
> > >  #define ARM_SMMU_TCR_IRGN0		GENMASK(9, 8)
> > > +#define ARM_SMMU_TCR_EPD0		BIT(7)
> > >  #define ARM_SMMU_TCR_T0SZ		GENMASK(5, 0)
> > >  
> > >  #define ARM_SMMU_VTCR_RES1		BIT(31)
> > > @@ -343,16 +344,27 @@ struct arm_smmu_domain {
> > >  	struct mutex			init_mutex; /* Protects smmu pointer */
> > >  	spinlock_t			cb_lock; /* Serialises ATS1* ops and TLB syncs */
> > >  	struct iommu_domain		domain;
> > > +	bool				split_pagetables;
> > >  };
> > >  
> > >  static inline u32 arm_smmu_lpae_tcr(struct io_pgtable_cfg *cfg)
> > >  {
> > > -	return ARM_SMMU_TCR_EPD1 |
> > > -	       FIELD_PREP(ARM_SMMU_TCR_TG0, cfg->arm_lpae_s1_cfg.tcr.tg) |
> > > -	       FIELD_PREP(ARM_SMMU_TCR_SH0, cfg->arm_lpae_s1_cfg.tcr.sh) |
> > > -	       FIELD_PREP(ARM_SMMU_TCR_ORGN0, cfg->arm_lpae_s1_cfg.tcr.orgn) |
> > > -	       FIELD_PREP(ARM_SMMU_TCR_IRGN0, cfg->arm_lpae_s1_cfg.tcr.irgn) |
> > > -	       FIELD_PREP(ARM_SMMU_TCR_T0SZ, cfg->arm_lpae_s1_cfg.tcr.tsz);
> > > +	u32 tcr = FIELD_PREP(ARM_SMMU_TCR_TG0, cfg->arm_lpae_s1_cfg.tcr.tg) |
> > > +		FIELD_PREP(ARM_SMMU_TCR_SH0, cfg->arm_lpae_s1_cfg.tcr.sh) |
> > > +		FIELD_PREP(ARM_SMMU_TCR_ORGN0, cfg->arm_lpae_s1_cfg.tcr.orgn) |
> > > +		FIELD_PREP(ARM_SMMU_TCR_IRGN0, cfg->arm_lpae_s1_cfg.tcr.irgn) |
> > > +		FIELD_PREP(ARM_SMMU_TCR_T0SZ, cfg->arm_lpae_s1_cfg.tcr.tsz);
> > > +
> > > +       /*
> > > +	* When TTBR1 is selected shift the TCR fields by 16 bits and disable
> > > +	* translation in TTBR0
> > > +	*/
> > > +	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1)
> > > +		tcr = (tcr << 16) | ARM_SMMU_TCR_EPD0;
> > 
> > This looks reasonably dodgy to me, as you copy a RESERVED bit into the A1
> > field. Furthermore, for 32-bit context banks you've got the EAE bit to
> > contend with as well.
> 
> I can swizzle it more if we need to. I think Robin's main objection was that we
> didn't want to construct the whole half of the TCR twice and have a bunch of
> field definitions for the T1 space that are only used in this special case. 
> 
> > Perhaps we shouldn't expose DOMAIN_ATTR_SPLIT_TABLES for anything other than
> > the 64-bit page table format.
> 
> We kind of enforce that in arm_smmu_init_domain_context [1] by only allowing the
> quirk to be set when cfg->fmt == ARM_SMMU_CTX_FMT_AARCH64 and stage 1. I'm not
> sure if that is formal enough or if we should bake something in to
> io-pgtable-arm to warn against it too.

Sorry again, I missed that this was predicated on

	'cfg->fmt == ARM_SMMU_CTX_FMT_AARCH64'

Please can you add that to the comment above the code shifting the TCR
around? I think you should also say that this clears A1.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
