Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A13C433F5
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 20:07:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 50909409BA;
	Thu,  5 May 2022 20:07:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3yVHBt5Kv-P5; Thu,  5 May 2022 20:07:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D810C40924;
	Thu,  5 May 2022 20:07:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6B87C0039;
	Thu,  5 May 2022 20:07:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB682C002D
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 20:07:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B1B0A40931
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 20:07:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fu0WvfdZgMj3 for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 20:07:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 749BC40924
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 20:07:48 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93F4C106F;
 Thu,  5 May 2022 13:07:47 -0700 (PDT)
Received: from [10.57.80.111] (unknown [10.57.80.111])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA5093F85F;
 Thu,  5 May 2022 13:07:45 -0700 (PDT)
Message-ID: <91bf8d9c-edf2-5b86-eb3e-f38c1c4f0ec4@arm.com>
Date: Thu, 5 May 2022 21:07:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] iommu: iommu_group_claim_dma_owner() must always
 assign a domain
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>
References: <0-v2-f62259511ac0+6-iommu_dma_block_jgg@nvidia.com>
 <BN9PR11MB5276504B448C715527AD5F3F8CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220505153320.GS49344@nvidia.com>
 <1b8bf74a-cafa-822f-8843-0d1caf3f56ac@arm.com>
 <20220505192720.GW49344@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220505192720.GW49344@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Rodel, Jorg" <jroedel@suse.de>,
 Qian Cai <quic_qiancai@quicinc.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Will Deacon <will@kernel.org>
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

On 2022-05-05 20:27, Jason Gunthorpe wrote:
> On Thu, May 05, 2022 at 07:56:59PM +0100, Robin Murphy wrote:
> 
>> Ack to that, there are certainly further improvements to consider once we've
>> got known-working code into a released kernel, but let's not get ahead of
>> ourselves just now.
> 
> Yes please
>   
>> (I'm pretty sure we could get away with a single blocking domain per IOMMU
>> instance, rather than per group, but I deliberately saved that one for later
>> - right now one per group to match default domains is simpler to reason
>> about and less churny in the context of the current ownership patches)
> 
> I noticed this too..
> 
> But I thought the driver can do a better job of this. There is no
> reason it has to allocate memory to return a IOMMU_DOMAIN_BLOCKED
> domain - this struct could be a globally allocated singleton for the
> entire driver and that would be even better memory savings.

I was thinking about the domain pointers themselves as well, but on 
reflection, little systems are most likely to have the simpler IOMMUs 
with one fixed group per instance anyway, while the kind of systems 
which end up with a couple of hundred groups can probably bear the cost 
of a couple of hundred extra pointers. So yeah, probably not worth the 
code cost of chasing down a group->devices->dev->iommu->blocking_domain 
in practice.

> For instance, here is a sketch for the Intel driver based on Baolu's
> remark that intel_iommu_detach_device() establishes a blocking
> behavior already on detach_dev (Baolu if you like it can you make a
> proper patch?):
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index df5c62ecf942b8..317945f6134d42 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4324,6 +4324,8 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
>   		return domain;
>   	case IOMMU_DOMAIN_IDENTITY:
>   		return &si_domain->domain;
> +	case IOMMU_DOMAIN_BLOCKED;
> +		return &intel_blocking_domain;
>   	default:
>   		return NULL;
>   	}
> @@ -4404,12 +4406,25 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
>   	return domain_add_dev_info(to_dmar_domain(domain), dev);
>   }
>   
> -static void intel_iommu_detach_device(struct iommu_domain *domain,
> -				      struct device *dev)
> +static int intel_iommu_block_dev(struct iommu_domain *domain,
> +				 struct device *dev)
>   {
> +	if (!device_to_iommu(dev, NULL, NULL))
> +		return -EINVAL;
> +
>   	dmar_remove_one_dev_info(dev);
> +	return 0;
>   }
>   
> +static struct iommu_domain intel_blocking_domain {
> +	.type = IOMMU_DOMAIN_BLOCKED,
> +	.ops = &(const struct iommu_domain_ops){
> +		.attach_dev = intel_iommu_detach_device,
> +		// Fix core code so this works
> +		.free = NULL,

TBH unless and until it becomes commonplace, I'd just have drivers 
provide a no-op .free callback for least surprise, if their .alloc does 
something funky. But either way, with domain ops now we can so easily do 
whatever we need, yay!

Cheers,
Robin.

> +	},
> +};
> +
>   static int intel_iommu_map(struct iommu_domain *domain,
>   			   unsigned long iova, phys_addr_t hpa,
>   			   size_t size, int iommu_prot, gfp_t gfp)
> @@ -4890,7 +4905,6 @@ const struct iommu_ops intel_iommu_ops = {
>   #endif
>   	.default_domain_ops = &(const struct iommu_domain_ops) {
>   		.attach_dev		= intel_iommu_attach_device,
> -		.detach_dev		= intel_iommu_detach_device,
>   		.map_pages		= intel_iommu_map_pages,
>   		.unmap_pages		= intel_iommu_unmap_pages,
>   		.iotlb_sync_map		= intel_iommu_iotlb_sync_map,
> 
> Thanks,
> Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
