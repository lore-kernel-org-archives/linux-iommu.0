Return-Path: <SRS0=p6pp=3K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3636DC2D0CE
	for <iommu@archiver.kernel.org>; Tue, 21 Jan 2020 14:36:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0DFA21569
	for <iommu@archiver.kernel.org>; Tue, 21 Jan 2020 14:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0DFA21569
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BEDCE203AE;
	Tue, 21 Jan 2020 14:36:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IwUdZ43Qghvc; Tue, 21 Jan 2020 14:36:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 902EA203A5;
	Tue, 21 Jan 2020 14:36:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64D02C0176;
	Tue, 21 Jan 2020 14:36:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84317C0174
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jan 2020 14:36:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7093385C57
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jan 2020 14:36:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PaCWp0Kv67Tq for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jan 2020 14:36:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 202F385CE2
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jan 2020 14:36:24 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 817BA30E;
 Tue, 21 Jan 2020 06:36:23 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBD9E3F52E;
 Tue, 21 Jan 2020 06:36:20 -0800 (PST)
Subject: Re: [PATCH v3 2/5] iommu/arm-smmu: Add support for split pagetables
To: Jordan Crouse <jcrouse@codeaurora.org>, iommu@lists.linux-foundation.org
References: <1576514271-15687-1-git-send-email-jcrouse@codeaurora.org>
 <1576514271-15687-3-git-send-email-jcrouse@codeaurora.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <a38fe02a-4f84-f032-8c9d-4ecf72a87a55@arm.com>
Date: Tue, 21 Jan 2020 14:36:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1576514271-15687-3-git-send-email-jcrouse@codeaurora.org>
Content-Language: en-GB
Cc: linux-arm-msm@vger.kernel.org, will@kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 16/12/2019 4:37 pm, Jordan Crouse wrote:
> Add support to enable split pagetables (TTBR1) if the supporting driver
> requests it via the DOMAIN_ATTR_SPLIT_TABLES flag. When enabled, the driver
> will set up the TTBR0 and TTBR1 regions and program the default domain
> pagetable on TTBR1.
> 
> After attaching the device, the value of he domain attribute can
> be queried to see if the split pagetables were successfully programmed.
> Furthermore the domain geometry will be updated so that the caller can
> determine the active region for the pagetable that was programmed.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
> 
>   drivers/iommu/arm-smmu.c | 40 +++++++++++++++++++++++++++++++++++-----
>   drivers/iommu/arm-smmu.h | 45 +++++++++++++++++++++++++++++++++++++++------
>   2 files changed, 74 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index c106406..7b59116 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -538,9 +538,17 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
>   			cb->ttbr[0] = pgtbl_cfg->arm_v7s_cfg.ttbr;
>   			cb->ttbr[1] = 0;
>   		} else {
> -			cb->ttbr[0] = pgtbl_cfg->arm_lpae_s1_cfg.ttbr;
> -			cb->ttbr[0] |= FIELD_PREP(TTBRn_ASID, cfg->asid);
> -			cb->ttbr[1] = FIELD_PREP(TTBRn_ASID, cfg->asid);
> +			if (pgtbl_cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1) {
> +				cb->ttbr[0] = FIELD_PREP(TTBRn_ASID, cfg->asid);
> +				cb->ttbr[1] = pgtbl_cfg->arm_lpae_s1_cfg.ttbr;
> +				cb->ttbr[1] |=
> +					FIELD_PREP(TTBRn_ASID, cfg->asid);
> +			} else {
> +				cb->ttbr[0] = pgtbl_cfg->arm_lpae_s1_cfg.ttbr;
> +				cb->ttbr[0] |=
> +					FIELD_PREP(TTBRn_ASID, cfg->asid);
> +				cb->ttbr[1] = FIELD_PREP(TTBRn_ASID, cfg->asid);
> +			}
>   		}
>   	} else {
>   		cb->ttbr[0] = pgtbl_cfg->arm_lpae_s2_cfg.vttbr;
> @@ -651,6 +659,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>   	enum io_pgtable_fmt fmt;
>   	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>   	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
> +	u32 quirks = 0;
>   
>   	mutex_lock(&smmu_domain->init_mutex);
>   	if (smmu_domain->smmu)
> @@ -719,6 +728,8 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>   		oas = smmu->ipa_size;
>   		if (cfg->fmt == ARM_SMMU_CTX_FMT_AARCH64) {
>   			fmt = ARM_64_LPAE_S1;
> +			if (smmu_domain->split_pagetables)
> +				quirks |= IO_PGTABLE_QUIRK_ARM_TTBR1;
>   		} else if (cfg->fmt == ARM_SMMU_CTX_FMT_AARCH32_L) {
>   			fmt = ARM_32_LPAE_S1;
>   			ias = min(ias, 32UL);
> @@ -788,6 +799,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>   		.coherent_walk	= smmu->features & ARM_SMMU_FEAT_COHERENT_WALK,
>   		.tlb		= smmu_domain->flush_ops,
>   		.iommu_dev	= smmu->dev,
> +		.quirks		= quirks,
>   	};
>   
>   	if (smmu_domain->non_strict)
> @@ -801,8 +813,15 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>   
>   	/* Update the domain's page sizes to reflect the page table format */
>   	domain->pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
> -	domain->geometry.aperture_end = (1UL << ias) - 1;
> -	domain->geometry.force_aperture = true;
> +
> +	if (pgtbl_cfg.quirks & IO_PGTABLE_QUIRK_ARM_TTBR1) {
> +		domain->geometry.aperture_start = ~((1ULL << ias) - 1);

AKA "~0UL << ias", if I'm not mistaken ;)

> +		domain->geometry.aperture_end = ~0UL;
> +	} else {
> +		domain->geometry.aperture_end = (1UL << ias) - 1;
> +		domain->geometry.force_aperture = true;
> +		smmu_domain->split_pagetables = false;
> +	}
>   
>   	/* Initialise the context bank with our page table cfg */
>   	arm_smmu_init_context_bank(smmu_domain, &pgtbl_cfg);
> @@ -1484,6 +1503,9 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
>   		case DOMAIN_ATTR_NESTING:
>   			*(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
>   			return 0;
> +		case DOMAIN_ATTR_SPLIT_TABLES:
> +			*(int *)data = smmu_domain->split_pagetables;
> +			return 0;
>   		default:
>   			return -ENODEV;
>   		}
> @@ -1524,6 +1546,14 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
>   			else
>   				smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
>   			break;
> +		case DOMAIN_ATTR_SPLIT_TABLES:
> +			if (smmu_domain->smmu) {
> +				ret = -EPERM;
> +				goto out_unlock;
> +			}
> +			if (*(int *)data)
> +				smmu_domain->split_pagetables = true;

I still like the idea of passing the actual split point here, but as it 
is I think this sets the scene perfectly for coming back and doing that 
later.

> +			break;
>   		default:
>   			ret = -ENODEV;
>   		}
> diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
> index afab9de..68526cc 100644
> --- a/drivers/iommu/arm-smmu.h
> +++ b/drivers/iommu/arm-smmu.h
> @@ -177,6 +177,16 @@ enum arm_smmu_cbar_type {
>   #define TCR_IRGN0			GENMASK(9, 8)
>   #define TCR_T0SZ			GENMASK(5, 0)
>   
> +#define TCR_TG1				GENMASK(31, 30)
> +
> +#define TG0_4K				0
> +#define TG0_64K				1
> +#define TG0_16K				2
> +
> +#define TG1_16K				1
> +#define TG1_4K				2
> +#define TG1_64K				3
> +
>   #define ARM_SMMU_CB_CONTEXTIDR		0x34
>   #define ARM_SMMU_CB_S1_MAIR0		0x38
>   #define ARM_SMMU_CB_S1_MAIR1		0x3c
> @@ -329,16 +339,39 @@ struct arm_smmu_domain {
>   	struct mutex			init_mutex; /* Protects smmu pointer */
>   	spinlock_t			cb_lock; /* Serialises ATS1* ops and TLB syncs */
>   	struct iommu_domain		domain;
> +	bool				split_pagetables;
>   };
>   
> +static inline u32 arm_smmu_lpae_tcr_tg(struct io_pgtable_cfg *cfg)
> +{
> +	u32 val;
> +
> +	if (!(cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1))
> +		return FIELD_PREP(TCR_TG0, cfg->arm_lpae_s1_cfg.tcr.tg);
> +
> +	val = FIELD_PREP(TCR_TG1, cfg->arm_lpae_s1_cfg.tcr.tg);
> +
> +	if (cfg->arm_lpae_s1_cfg.tcr.tg == TG1_4K)
> +		val |= FIELD_PREP(TCR_TG0, TG0_4K);
> +	else if (cfg->arm_lpae_s1_cfg.tcr.tg == TG1_16K)
> +		val |= FIELD_PREP(TCR_TG0, TG0_16K);
> +	else
> +		val |= FIELD_PREP(TCR_TG0, TG0_64K);
> +
> +	return val;
> +}

This is all a bit ugly - I'd really like to rely on the real values from 
both io_pgtable instances if at all possible...

> +
>   static inline u32 arm_smmu_lpae_tcr(struct io_pgtable_cfg *cfg)
>   {
> -	return TCR_EPD1 |
> -	       FIELD_PREP(TCR_TG0, cfg->arm_lpae_s1_cfg.tcr.tg) |
> -	       FIELD_PREP(TCR_SH0, cfg->arm_lpae_s1_cfg.tcr.sh) |
> -	       FIELD_PREP(TCR_ORGN0, cfg->arm_lpae_s1_cfg.tcr.orgn) |
> -	       FIELD_PREP(TCR_IRGN0, cfg->arm_lpae_s1_cfg.tcr.irgn) |
> -	       FIELD_PREP(TCR_T0SZ, cfg->arm_lpae_s1_cfg.tcr.tsz);
> +	u32 tcr = FIELD_PREP(TCR_SH0, cfg->arm_lpae_s1_cfg.tcr.sh) |
> +		FIELD_PREP(TCR_ORGN0, cfg->arm_lpae_s1_cfg.tcr.orgn) |
> +		FIELD_PREP(TCR_IRGN0, cfg->arm_lpae_s1_cfg.tcr.irgn) |
> +		FIELD_PREP(TCR_T0SZ, cfg->arm_lpae_s1_cfg.tcr.tsz);
> +
> +	if (!(cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1))
> +		return tcr | TCR_EPD1 | arm_smmu_lpae_tcr_tg(cfg);
> +
> +	return tcr | (tcr << 16) | arm_smmu_lpae_tcr_tg(cfg);

...especially here - leaving TTBR0 enabled but pointing to 
who-knows-what until someone fills it in at some arbitrary point in the 
future seems rather scary.

I'm looking at iommu_aux_attach_device() and friends, and it appears 
pretty achievable to hook that up in a workable manner, even if it's 
just routed straight through to the impl to only work within 
qcom-specific parameters to begin with. I figure the first 
aux_attach_dev sanity-checks that the main domain is using TTBR1 with a 
compatible split, sets TTBR0 and updates the merged TCR value at that 
point. For subsequent calls it shouldn't need to do much more than 
sanity-check that a new aux domain has the same parameters as the 
existing one(s) (and again, such checks could potentially even start out 
as just "this is OK by construction" comments). I guess we'd probably 
want a count of the number of 'live' aux domains so we can simply 
disable TTBR0 on the final aux_detach_dev without having to keep 
detailed track of whatever the GPU has actually context switched in the 
hardware. Can you see any holes in that idea?

I haven't thought it through in detail, but it also feels like between 
aux_attach_dev and/or the TTBR1 quirk in attach_dev there ought to be 
enough information to influence the context bank allocation or shuffle 
any existing domains such that you can ensure that the right thing ends 
up in magic context 0 when it needs to be. That could be a pretty neat 
and robust way to finally put that to bed.

Robin.

>   }
>   
>   static inline u32 arm_smmu_lpae_tcr2(struct io_pgtable_cfg *cfg)
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
