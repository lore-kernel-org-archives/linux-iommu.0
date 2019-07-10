Return-Path: <SRS0=bDbm=VH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5D2C74A2B
	for <iommu@archiver.kernel.org>; Wed, 10 Jul 2019 16:55:38 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE2E820665
	for <iommu@archiver.kernel.org>; Wed, 10 Jul 2019 16:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE2E820665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 208914724;
	Wed, 10 Jul 2019 16:55:34 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 55AA64563
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Jul 2019 16:45:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id E7E97886
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Jul 2019 16:45:46 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85F4C360;
	Wed, 10 Jul 2019 09:45:46 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12B3A3F246;
	Wed, 10 Jul 2019 09:45:44 -0700 (PDT)
Subject: Re: [RESEND PATCH v2 3/3] iommu/arm-smmu: Add support for
	DOMAIN_ATTR_SPLIT_TABLES
To: Jordan Crouse <jcrouse@codeaurora.org>, freedreno@lists.freedesktop.org
References: <1562612447-19856-1-git-send-email-jcrouse@codeaurora.org>
	<1562612447-19856-4-git-send-email-jcrouse@codeaurora.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <aeae2aa1-9473-d661-dcf3-f086fe36d02a@arm.com>
Date: Wed, 10 Jul 2019 17:45:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1562612447-19856-4-git-send-email-jcrouse@codeaurora.org>
Content-Language: en-GB
Cc: jean-philippe.brucker@arm.com, linux-arm-msm@vger.kernel.org,
	dianders@chromium.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, hoegsberg@google.com,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 08/07/2019 20:00, Jordan Crouse wrote:
> When DOMAIN_ATTR_SPLIT_TABLES is specified for pass ARM_64_LPAE_SPLIT_S1
> to io_pgtable_ops to allocate and initialize TTBR0 and TTBR1 pagetables.
> 
> v3: Moved all the pagetable specific work into io-pgtable-arm
> in a previous patch.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
> 
>   drivers/iommu/arm-smmu.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 653b6b3..7a6b4bb 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -257,6 +257,7 @@ struct arm_smmu_domain {
>   	bool				non_strict;
>   	struct mutex			init_mutex; /* Protects smmu pointer */
>   	spinlock_t			cb_lock; /* Serialises ATS1* ops and TLB syncs */
> +	u32 attributes;
>   	struct iommu_domain		domain;
>   };
>   
> @@ -832,7 +833,11 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>   		ias = smmu->va_size;
>   		oas = smmu->ipa_size;
>   		if (cfg->fmt == ARM_SMMU_CTX_FMT_AARCH64) {
> -			fmt = ARM_64_LPAE_S1;
> +			if (smmu_domain->attributes &
> +				(1 << DOMAIN_ATTR_SPLIT_TABLES))
> +				fmt = ARM_64_LPAE_SPLIT_S1;
> +			else
> +				fmt = ARM_64_LPAE_S1;
>   		} else if (cfg->fmt == ARM_SMMU_CTX_FMT_AARCH32_L) {
>   			fmt = ARM_32_LPAE_S1;
>   			ias = min(ias, 32UL);
> @@ -1582,6 +1587,10 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
>   		case DOMAIN_ATTR_NESTING:
>   			*(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
>   			return 0;
> +		case DOMAIN_ATTR_SPLIT_TABLES:
> +			*(int *)data = !!(smmu_domain->attributes &
> +				(1 << DOMAIN_ATTR_SPLIT_TABLES));

I'm not really a fan of always claiming to support this but silently 
ignoring it depending on hardware/kernel configuration - it seems 
somewhat tricky to make callers properly robust against making false 
assumptions (e.g. consider if the system is booted with 
"arm-smmu.force_stage=2").

Robin.

> +			return 0;
>   		default:
>   			return -ENODEV;
>   		}
> @@ -1622,6 +1631,11 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
>   			else
>   				smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
>   			break;
> +		case DOMAIN_ATTR_SPLIT_TABLES:
> +			if (*((int *)data))
> +				smmu_domain->attributes |=
> +					(1 << DOMAIN_ATTR_SPLIT_TABLES);
> +			break;
>   		default:
>   			ret = -ENODEV;
>   		}
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
