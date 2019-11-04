Return-Path: <SRS0=uwQI=Y4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213D4C47E49
	for <iommu@archiver.kernel.org>; Mon,  4 Nov 2019 19:14:52 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFED720869
	for <iommu@archiver.kernel.org>; Mon,  4 Nov 2019 19:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRKmkkrN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFED720869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A57B6E58;
	Mon,  4 Nov 2019 19:14:51 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4039DE57
	for <iommu@lists.linux-foundation.org>;
	Mon,  4 Nov 2019 19:14:50 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A8B4EA9
	for <iommu@lists.linux-foundation.org>;
	Mon,  4 Nov 2019 19:14:49 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id AA5D120848;
	Mon,  4 Nov 2019 19:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572894889;
	bh=J/FulSPhriezH+aQ6FT9wgZqMXgNHCVHt/PPuaqWTM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nRKmkkrNuSOOFLU3dBjKseriSoHJP6HBZZVLMJhR7XLIshlyNzZVe3mOl7sqRMoND
	656hRxFAxVKTGg90i3OkHMprOudEFvjbrKXqtBsOOETp3GtAJyKb/S3uZOGBWACRi+
	JIpqVIyS2y7ak0kulOA1hSPa4r6zbI7IYcEfEDcI=
Date: Mon, 4 Nov 2019 19:14:45 +0000
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 09/10] iommu/io-pgtable-arm: Rationalise TCR handling
Message-ID: <20191104191444.GI24909@willie-the-truck>
References: <cover.1572024119.git.robin.murphy@arm.com>
	<84e56eb993fff3660376ffad3e915b972d29b008.1572024120.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <84e56eb993fff3660376ffad3e915b972d29b008.1572024120.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

On Fri, Oct 25, 2019 at 07:08:38PM +0100, Robin Murphy wrote:
> Although it's conceptually nice for the io_pgtable_cfg to provide a
> standard VMSA TCR value, the reality is that no VMSA-compliant IOMMU
> looks exactly like an Arm CPU, and they all have various other TCR
> controls which io-pgtable can't be expected to understand. Thus since
> there is an expectation that drivers will have to add to the given TCR
> value anyway, let's strip it down to just the essentials that are
> directly relevant to io-pgatble's inner workings - namely the various

typo: "io-pgatble"

> sizes and the walk attributes.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm-smmu-v3.c        | 41 +++----------
>  drivers/iommu/arm-smmu.c           |  7 ++-
>  drivers/iommu/arm-smmu.h           | 27 ++++++++
>  drivers/iommu/io-pgtable-arm-v7s.c |  6 +-
>  drivers/iommu/io-pgtable-arm.c     | 98 ++++++++++++------------------
>  drivers/iommu/io-pgtable.c         |  2 +-
>  drivers/iommu/qcom_iommu.c         |  8 +--
>  include/linux/io-pgtable.h         |  9 ++-
>  8 files changed, 94 insertions(+), 104 deletions(-)

Generally, I *really* like this patch, but I do have a bunch of comments:

> @@ -2155,6 +2125,7 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
>  	int asid;
>  	struct arm_smmu_device *smmu = smmu_domain->smmu;
>  	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
> +	typeof(&pgtbl_cfg->arm_lpae_s1_cfg.tcr) tcr = &pgtbl_cfg->arm_lpae_s1_cfg.tcr;

I find this pretty grotty, but I couldn't think of something better and
exporting format-specific types out of the iopgtable layer also feels
nasty.

> diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
> index 409716410b0d..98db074281ac 100644
> --- a/drivers/iommu/arm-smmu.h
> +++ b/drivers/iommu/arm-smmu.h
> @@ -158,12 +158,24 @@ enum arm_smmu_cbar_type {
>  #define TCR2_SEP			GENMASK(17, 15)
>  #define TCR2_SEP_UPSTREAM		0x7
>  #define TCR2_AS				BIT(4)
> +#define TCR2_PASIZE			GENMASK(3, 0)
>  
>  #define ARM_SMMU_CB_TTBR0		0x20
>  #define ARM_SMMU_CB_TTBR1		0x28
>  #define TTBRn_ASID			GENMASK_ULL(63, 48)
>  
> +/* arm64 headers leak this somehow :( */
> +#undef TCR_T0SZ

Urgh. I suppose we should prefix these things with ARM_SMMU too :(
Obviously, that's a separate patch.

>  #define ARM_SMMU_CB_TCR			0x30
> +#define TCR_EAE				BIT(31)
> +#define TCR_EPD1			BIT(23)
> +#define TCR_TG0				GENMASK(15, 14)
> +#define TCR_SH0				GENMASK(13, 12)
> +#define TCR_ORGN0			GENMASK(11, 10)
> +#define TCR_IRGN0			GENMASK(9, 8)
> +#define TCR_T0SZ			GENMASK(5, 0)
> +
>  #define ARM_SMMU_CB_CONTEXTIDR		0x34
>  #define ARM_SMMU_CB_S1_MAIR0		0x38
>  #define ARM_SMMU_CB_S1_MAIR1		0x3c
> @@ -318,6 +330,21 @@ struct arm_smmu_domain {
>  	struct iommu_domain		domain;
>  };
>  
> +static inline u32 arm_smmu_lpae_tcr(struct io_pgtable_cfg *cfg)
> +{
> +	return TCR_EPD1 |
> +	       FIELD_PREP(TCR_TG0, cfg->arm_lpae_s1_cfg.tcr.tg) |
> +	       FIELD_PREP(TCR_SH0, cfg->arm_lpae_s1_cfg.tcr.sh) |
> +	       FIELD_PREP(TCR_ORGN0, cfg->arm_lpae_s1_cfg.tcr.orgn) |
> +	       FIELD_PREP(TCR_IRGN0, cfg->arm_lpae_s1_cfg.tcr.irgn) |
> +	       FIELD_PREP(TCR_T0SZ, cfg->arm_lpae_s1_cfg.tcr.tsz);
> +}
> +
> +static inline u32 arm_smmu_lpae_tcr2(struct io_pgtable_cfg *cfg)
> +{
> +	return FIELD_PREP(TCR2_PASIZE, cfg->arm_lpae_s1_cfg.tcr.ips) |
> +	       FIELD_PREP(TCR2_SEP, TCR2_SEP_UPSTREAM);
> +}
>  
>  /* Implementation details, yay! */
>  struct arm_smmu_impl {
> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> index 4d2c1e7f67c4..d8e4562ce478 100644
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -149,8 +149,6 @@
>  #define ARM_V7S_TTBR_IRGN_ATTR(attr)					\
>  	((((attr) & 0x1) << 6) | (((attr) & 0x2) >> 1))
>  
> -#define ARM_V7S_TCR_PD1			BIT(5)
> -
>  #ifdef CONFIG_ZONE_DMA32
>  #define ARM_V7S_TABLE_GFP_DMA GFP_DMA32
>  #define ARM_V7S_TABLE_SLAB_FLAGS SLAB_CACHE_DMA32
> @@ -798,8 +796,8 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
>  	 */
>  	cfg->pgsize_bitmap &= SZ_4K | SZ_64K | SZ_1M | SZ_16M;
>  
> -	/* TCR: T0SZ=0, disable TTBR1 */
> -	cfg->arm_v7s_cfg.tcr = ARM_V7S_TCR_PD1;
> +	/* TCR: T0SZ=0, EAE=0 (if applicable) */
> +	cfg->arm_v7s_cfg.tcr = 0;
>  
>  	/*
>  	 * TEX remap: the indices used map to the closest equivalent types
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index bc0841040ebe..9b1912ede000 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -100,40 +100,32 @@
>  #define ARM_LPAE_PTE_MEMATTR_DEV	(((arm_lpae_iopte)0x1) << 2)
>  
>  /* Register bits */
> -#define ARM_32_LPAE_TCR_EAE		(1 << 31)
> -#define ARM_64_LPAE_S2_TCR_RES1		(1 << 31)
> +#define ARM_64_LPAE_VTCR_RES1		(1 << 31)

I know you're just renaming things here, but this looks really dodgy to
me. Won't it be treated as signed...

> @@ -910,7 +899,7 @@ arm_64_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg, void *cookie)
>  	}
>  
>  	/* VTCR */
> -	reg = ARM_64_LPAE_S2_TCR_RES1 |
> +	reg = ARM_64_LPAE_VTCR_RES1 |
>  	     (ARM_LPAE_TCR_SH_IS << ARM_LPAE_TCR_SH0_SHIFT) |
>  	     (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_IRGN0_SHIFT) |
>  	     (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_ORGN0_SHIFT);

... and then sign-extended here?

> @@ -919,45 +908,45 @@ arm_64_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg, void *cookie)
>  
>  	switch (ARM_LPAE_GRANULE(data)) {
>  	case SZ_4K:
> -		reg |= ARM_LPAE_TCR_TG0_4K;
> +		reg |= (ARM_LPAE_TCR_TG0_4K << ARM_LPAE_VTCR_TG0_SHIFT);

Why don't we do the bitfield thing for vtcr as well? Yeah, there's only one,
but the nice thing about naming all of the fields in the structure is that
it makes it obvious what you get back from the io-pgtable code.

> diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
> index 9a57eb6c253c..059be7e21030 100644
> --- a/drivers/iommu/qcom_iommu.c
> +++ b/drivers/iommu/qcom_iommu.c
> @@ -271,15 +271,13 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
>  		iommu_writeq(ctx, ARM_SMMU_CB_TTBR0,
>  				pgtbl_cfg.arm_lpae_s1_cfg.ttbr |
>  				FIELD_PREP(TTBRn_ASID, ctx->asid));
> -		iommu_writeq(ctx, ARM_SMMU_CB_TTBR1,
> -				FIELD_PREP(TTBRn_ASID, ctx->asid));
> +		iommu_writeq(ctx, ARM_SMMU_CB_TTBR1, 0);

Are you sure it's safe to drop the ASID here? Just want to make sure there
wasn't some "quirk" this was helping with.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
