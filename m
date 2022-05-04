Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F384EC433F5
	for <iommu@archiver.kernel.org>; Wed,  4 May 2022 14:42:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8807440128;
	Wed,  4 May 2022 14:42:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A60y9Khpu_b1; Wed,  4 May 2022 14:42:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3DDFE40143;
	Wed,  4 May 2022 14:42:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF9B2C0039;
	Wed,  4 May 2022 14:42:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8FC90C0032
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 14:42:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 68D32401C6
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 14:42:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TbbuNRwAm3hT for <iommu@lists.linux-foundation.org>;
 Wed,  4 May 2022 14:42:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3EAB3401BD
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 14:42:17 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 464D61042;
 Wed,  4 May 2022 07:42:17 -0700 (PDT)
Received: from [10.57.80.111] (unknown [10.57.80.111])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA93B3F85F;
 Wed,  4 May 2022 07:42:15 -0700 (PDT)
Message-ID: <0a8cdb2a-91a3-9953-b7a1-8517ffcadb75@arm.com>
Date: Wed, 4 May 2022 15:42:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] iommu: iommu_group_claim_dma_owner() must always assign a
 domain
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux-foundation.org,
 Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>
References: <0-v1-6e9d2d0a759d+11b-iommu_dma_block_jgg@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <0-v1-6e9d2d0a759d+11b-iommu_dma_block_jgg@nvidia.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Qian Cai <quic_qiancai@quicinc.com>
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

On 2022-05-04 01:11, Jason Gunthorpe wrote:
> Once the group enters 'owned' mode it can never be assigned back to the
> default_domain or to a NULL domain. It must always be actively assigned to
> a current domain. If the caller hasn't provided a domain then the core
> must provide an explicit DMA blocking domain that has no DMA map.
> 
> Lazily create a group-global blocking DMA domain when
> iommu_group_claim_dma_owner is first called and immediately assign the
> group to it. This ensures that DMA is immediately fully isolated on all
> IOMMU drivers.
> 
> If the user attaches/detaches while owned then detach will set the group
> back to the blocking domain.
> 
> Slightly reorganize the call chains so that
> __iommu_group_attach_core_domain() is the function that removes any caller
> configured domain and sets the domains back a core owned domain with an
> appropriate lifetime.
> 
> __iommu_group_attach_domain() is the worker function that can change the
> domain assigned to a group to any target domain, including NULL.
> 
> Add comments clarifying how the NULL vs detach_dev vs default_domain works
> based on Robin's remarks.
> 
> This fixes an oops with VFIO and SMMUv3 because VFIO will call
> iommu_detach_group() and then immediately iommu_domain_free(), but
> SMMUv3 has no way to know that the domain it is holding a pointer to
> has been freed. Now the iommu_detach_group() will assign the blocking
> domain and SMMUv3 will no longer hold a stale domain reference.

Thanks for taking this on! I do like the overall structure and naming 
much more than my initial sketch :)

> Fixes: 1ea2a07a532b ("iommu: Add DMA ownership management interfaces")
> Reported-by: Qian Cai <quic_qiancai@quicinc.com>

Co-developed-by: Robin Murphy <robin.murphy@arm.com>

(so the sign-off chain makes sense - you deserve overall authorship here)

> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
[...]
> @@ -2072,38 +2072,66 @@ static int iommu_group_do_detach_device(struct device *dev, void *data)
>   	return 0;
>   }
>   
> -static void __iommu_detach_group(struct iommu_domain *domain,
> -				 struct iommu_group *group)
> +static int __iommu_group_attach_domain(struct iommu_group *group,
> +				       struct iommu_domain *new_domain)
>   {
>   	int ret;
>   
> +	if (group->domain == new_domain)
> +		return 0;
> +
>   	/*
> -	 * If the group has been claimed already, do not re-attach the default
> -	 * domain.
> +	 * A NULL domain means to call the detach_dev() op. New drivers should
> +	 * use a IOMMU_DOMAIN_IDENTITY domain instead of a NULL default_domain

Nit: IOMMU_DOMAIN_DMA is the baseline of default domain support, 
passthrough is more of an optional extra.

> +	 * and detatch_dev().

Nit: detach_dev

Otherwise, modulo the other things already pointed out, this looks OK to me.

Cheers,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
