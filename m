Return-Path: <SRS0=Ap1T=SN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3BEC10F13
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 13:16:39 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64F832077C
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 13:16:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64F832077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 24CD32703;
	Thu, 11 Apr 2019 13:16:39 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id F130B26FF
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 13:15:53 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7AEC7F4
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 13:15:53 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id B1A6E42D; Thu, 11 Apr 2019 15:15:51 +0200 (CEST)
Date: Thu, 11 Apr 2019 15:15:49 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 1/3] iommu: io-pgtable: Add ARM Mali midgard MMU page
	table format
Message-ID: <20190411131549.GB4518@8bytes.org>
References: <20190401074730.12241-1-robh@kernel.org>
	<20190401074730.12241-2-robh@kernel.org>
	<8d091874-11b0-e348-c4f1-dd1bcfa4bf97@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8d091874-11b0-e348-c4f1-dd1bcfa4bf97@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Rob Herring <robh@kernel.org>, Lyude Paul <lyude@redhat.com>,
	Eric Anholt <eric@anholt.net>, Maxime Ripard <maxime.ripard@bootlin.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Neil Armstrong <narmstrong@baylibre.com>,
	Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
	iommu@lists.linux-foundation.org, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Daniel Vetter <daniel@ffwll.ch>, Sean Paul <sean@poorly.run>,
	linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190411131549.Utn0vnSogxIHr5Biv2uqSHlQOQQQ2JCQYYFtv9_T_3c@z>

On Mon, Apr 01, 2019 at 08:11:00PM +0100, Robin Murphy wrote:
> With the diff below squashed in to address my outstanding style nits,
> 
> Acked-by: Robin Murphy <robin.murphy@arm.com>
> 
> I don't foresee any conflicting io-pgtable changes to prevent this going via
> DRM, but I'll leave the final say up to Joerg.

No objection from my side with merging this via DRM. With Robin's
concerns addressed:

	Acked-by: Joerg Roedel <jroedel@suse.de>

> 
> Thanks,
> Robin.
> 
> ----->8-----
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 98551d0cff59..55ed039da166 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -197,12 +197,13 @@ struct arm_lpae_io_pgtable {
> 
>  typedef u64 arm_lpae_iopte;
> 
> -static inline bool iopte_leaf(arm_lpae_iopte pte, int l, enum
> io_pgtable_fmt fmt)
> +static inline bool iopte_leaf(arm_lpae_iopte pte, int lvl,
> +			      enum io_pgtable_fmt fmt)
>  {
> -	if ((l == (ARM_LPAE_MAX_LEVELS - 1)) && (fmt != ARM_MALI_LPAE))
> -		return iopte_type(pte,l) == ARM_LPAE_PTE_TYPE_PAGE;
> +	if (lvl == (ARM_LPAE_MAX_LEVELS - 1) && fmt != ARM_MALI_LPAE)
> +		return iopte_type(pte, lvl) == ARM_LPAE_PTE_TYPE_PAGE;
> 
> -	return iopte_type(pte,l) == ARM_LPAE_PTE_TYPE_BLOCK;
> +	return iopte_type(pte, lvl) == ARM_LPAE_PTE_TYPE_BLOCK;
>  }
> 
>  static arm_lpae_iopte paddr_to_iopte(phys_addr_t paddr,
> @@ -310,13 +311,10 @@ static void __arm_lpae_init_pte(struct
> arm_lpae_io_pgtable *data,
>  	if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_NS)
>  		pte |= ARM_LPAE_PTE_NS;
> 
> -	if (lvl == ARM_LPAE_MAX_LEVELS - 1) {
> -		if (data->iop.fmt == ARM_MALI_LPAE)
> -			pte |= ARM_LPAE_PTE_TYPE_BLOCK;
> -		else
> -			pte |= ARM_LPAE_PTE_TYPE_PAGE;
> -	} else
> +	if (data->iop.fmt != ARM_MALI_LPAE && lvl != ARM_LPAE_MAX_LEVELS - 1)
>  		pte |= ARM_LPAE_PTE_TYPE_BLOCK;
> +	else
> +		pte |= ARM_LPAE_PTE_TYPE_PAGE;
> 
>  	if (data->iop.fmt != ARM_MALI_LPAE)
>  		pte |= ARM_LPAE_PTE_AF;
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
