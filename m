Return-Path: <SRS0=mUms=NC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7169EC4338F
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 10:30:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 177E460551
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 10:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 177E460551
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D99F94025E;
	Wed, 11 Aug 2021 10:30:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S9Ek87sZxon0; Wed, 11 Aug 2021 10:30:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AF12840522;
	Wed, 11 Aug 2021 10:30:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80F9EC001A;
	Wed, 11 Aug 2021 10:30:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9AE06C000E
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 10:30:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8014760867
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 10:30:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wLF-poLQ-GlA for <iommu@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 10:30:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DC00C607B8
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 10:30:17 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C4DF600CD;
 Wed, 11 Aug 2021 10:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628677817;
 bh=DPispVJ9qoY1JKmxxQTpbPzkjmY6Ar4brMVi71xV4kY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=f7I+tsCrb+71iG4L1M4bsFpPhDi0JuwrDajcHTyjqLk2LZEgPP2nXxPO7kVfIkbEP
 CsOdpXD74WoEgNYxbP/PW8HVl8GaV02dp+s7QjYJvy/oxV5/DqcqOIcagtKEeSD6gc
 Nu2tBnQXPNllAyOqBVMD8Ahi8PMEV8tBPS0m328acGXkuyLNF2XVkvEC63uOgp/r3F
 XI65fhpXCbQfW3bZQqon2OHYM/jX4e7lJLn4vezDY1QN72wqvK0lINdIXs071X0Iel
 lu7F/K1rsFAufE75dur2KWq8GURapU+O1Bvpe3OnQmxkCdPGGuybzMn/+0qWpsUGRA
 1p2axqEU2pscA==
Date: Wed, 11 Aug 2021 11:30:12 +0100
From: Will Deacon <will@kernel.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCHv4] iommu/arm-smmu: Optimize ->tlb_flush_walk() for qcom
 implementation
Message-ID: <20210811103011.GD4426@willie-the-truck>
References: <20210811060725.25221-1-saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210811060725.25221-1-saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Doug Anderson <dianders@chromium.org>, iommu@lists.linux-foundation.org,
 Thierry Reding <treding@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
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

On Wed, Aug 11, 2021 at 11:37:25AM +0530, Sai Prakash Ranjan wrote:
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index f7da8953afbe..3904b598e0f9 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -327,9 +327,16 @@ static void arm_smmu_tlb_inv_range_s2(unsigned long iova, size_t size,
>  static void arm_smmu_tlb_inv_walk_s1(unsigned long iova, size_t size,
>  				     size_t granule, void *cookie)
>  {
> -	arm_smmu_tlb_inv_range_s1(iova, size, granule, cookie,
> -				  ARM_SMMU_CB_S1_TLBIVA);
> -	arm_smmu_tlb_sync_context(cookie);
> +	struct arm_smmu_domain *smmu_domain = cookie;
> +	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
> +
> +	if (cfg->flush_walk_prefer_tlbiasid) {
> +		arm_smmu_tlb_inv_context_s1(cookie);

Hmm, this introduces an unconditional wmb() if tlbiasid is preferred. I
think that should be predicated on ARM_SMMU_FEAT_COHERENT_WALK like it is
for the by-VA ops. Worth doing as a separate patch.

> +	} else {
> +		arm_smmu_tlb_inv_range_s1(iova, size, granule, cookie,
> +					  ARM_SMMU_CB_S1_TLBIVA);
> +		arm_smmu_tlb_sync_context(cookie);
> +	}
>  }
>  
>  static void arm_smmu_tlb_add_page_s1(struct iommu_iotlb_gather *gather,
> @@ -765,8 +772,10 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>  		.iommu_dev	= smmu->dev,
>  	};
>  
> -	if (!iommu_get_dma_strict(domain))
> +	if (!iommu_get_dma_strict(domain)) {
>  		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
> +		cfg->flush_walk_prefer_tlbiasid = true;

This is going to interact badly with Robin's series to allow dynamic
transition to non-strict mode, as we don't have a mechanism to switch
over to the by-ASID behaviour. Yes, it should _work_, but it's ugly having
different TLBI behaviour just because of the how the domain became
non-strict.

Robin -- I think this originated from your idea at [1]. Any idea how to make
it work with your other series, or shall we drop this part for now and leave
the TLB invalidation behaviour the same for now?

Will

[1] https://lore.kernel.org/r/da62ff1c-9b49-34d3-69a1-1a674e4a30f7@arm.com
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
