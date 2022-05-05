Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B999DC433EF
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 18:57:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 55CFF4015A;
	Thu,  5 May 2022 18:57:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fbRGa-APs4UZ; Thu,  5 May 2022 18:57:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2221A4011F;
	Thu,  5 May 2022 18:57:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9924C0039;
	Thu,  5 May 2022 18:57:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39A04C002D
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 18:57:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 12C7A4015A
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 18:57:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eyBGpSxCElG5 for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 18:57:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id E31464011F
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 18:57:08 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16C0D106F;
 Thu,  5 May 2022 11:57:08 -0700 (PDT)
Received: from [10.57.80.111] (unknown [10.57.80.111])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14E993FA31;
 Thu,  5 May 2022 11:57:05 -0700 (PDT)
Message-ID: <1b8bf74a-cafa-822f-8843-0d1caf3f56ac@arm.com>
Date: Thu, 5 May 2022 19:56:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] iommu: iommu_group_claim_dma_owner() must always
 assign a domain
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>
References: <0-v2-f62259511ac0+6-iommu_dma_block_jgg@nvidia.com>
 <BN9PR11MB5276504B448C715527AD5F3F8CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220505153320.GS49344@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220505153320.GS49344@nvidia.com>
Cc: "Rodel, Jorg" <jroedel@suse.de>, Qian Cai <quic_qiancai@quicinc.com>,
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

On 2022-05-05 16:33, Jason Gunthorpe wrote:
> On Thu, May 05, 2022 at 10:56:28AM +0000, Tian, Kevin wrote:
>>> From: Jason Gunthorpe <jgg@nvidia.com>
>>> Sent: Thursday, May 5, 2022 3:09 AM
>>>
>>> Once the group enters 'owned' mode it can never be assigned back to the
>>> default_domain or to a NULL domain. It must always be actively assigned to
>>
>> worth pointing out that a NULL domain is not always translated to DMA
>> blocked on all platforms. That was a wrong assumption before this patch.
> 
> This is described in a comment blow
> 
>>> @@ -2040,7 +2037,8 @@ static int __iommu_attach_group(struct
>>> iommu_domain *domain,
>>>   {
>>>   	int ret;
>>>
>>> -	if (group->domain && group->domain != group->default_domain)
>>> +	if (group->domain && group->domain != group->default_domain &&
>>> +	    group->domain != group->blocking_domain)
>>>   		return -EBUSY;
>>>
>>>   	ret = __iommu_group_for_each_dev(group, domain,
>>
>> Suppose this can be also replaced by __iommu_group_attach_domain()?
> 
> It can, but lets do this as a follow patching since it is a bit big
> 
>>> @@ -2072,38 +2070,68 @@ static int
>>> iommu_group_do_detach_device(struct device *dev, void *data)
>>>   	return 0;
>>>   }
>>>
>>> -static void __iommu_detach_group(struct iommu_domain *domain,
>>> -				 struct iommu_group *group)
>>> +static int __iommu_group_attach_domain(struct iommu_group *group,
>>> +				       struct iommu_domain *new_domain)
>>>   {
>>>   	int ret;
>>>
>>> +	if (group->domain == new_domain)
>>> +		return 0;
>>> +
>>>   	/*
>>> -	 * If the group has been claimed already, do not re-attach the default
>>> -	 * domain.
>>> +	 * New drivers should support default domains and so the
>>> detach_dev() op
>>> +	 * will never be called. Otherwise the NULL domain indicates the
>>> +	 * translation for the group should be set so it will work with the
>>
>> translation should be 'blocked'?
> 
> No, not blocked.
> 
>>> +	 * platform DMA ops.
>>
>> I didn't get the meaning of the last sentence.
> 
> It is as discussed with Robin, NULL means to return the group back to
> some platform defined translation, and in some cases this means
> returning back to work with the platform's DMA ops - presumably if it
> isn't using the dma api.
> 
>>> +	/*
>>> +	 * Changing the domain is done by calling attach on the new domain.
>>> +	 * Drivers should implement this so that DMA is always translated by
>>
>> what does 'this' mean?
> 
> The code below - attach_dev called in a loop for each dev in the group.
> 
>>> +	 * either the new, old, or a blocking domain. DMA should never
>>
>> isn't the blocking domain passed in as the new domain?
> 
> Soemtimes. This is a statement about the required
> atomicity. New/old/block are all valid translations during the
> operation. Identity is not.
>   
>>> +	 * untranslated.
>>> +	 *
>>> +	 * Note that this is called in error unwind paths, attaching to a
>>> +	 * domain that has already been attached cannot fail.
>>
>> this is called in the normal path. Where does error unwind happen?
> 
> Any place that checks the return and does WARN_ON
> 
> Also the loop over each dev doesn't error unwind so it assumes that if
> the first dev succeeds then all subsequent devs will succeed.
>>>   /**
>>>    * iommu_group_claim_dma_owner() - Set DMA ownership of a group
>>>    * @group: The group.
>>> @@ -3111,9 +3162,15 @@ int iommu_group_claim_dma_owner(struct
>>> iommu_group *group, void *owner)
>>>   			goto unlock_out;
>>>   		}
>>>
>>> +		ret = __iommu_group_alloc_blocking_domain(group);
>>> +		if (ret)
>>> +			goto unlock_out;
>>> +
>>> +		ret = __iommu_group_attach_domain(group,
>>> +						  group->blocking_domain);
>>> +		if (ret)
>>> +			goto unlock_out;
>>>   		group->owner = owner;
>>
>> Here can use __iommu_group_attach_core_domain() if calling it after
>> setting group->owner.
> 
> That is obfuscating. This function must always and only attach the
> blocking_domain.
> 
> So, I'm going to leave this patch as-is since it has been tested now
> and we need to get the series back into iommu-next ASAP.

Ack to that, there are certainly further improvements to consider once 
we've got known-working code into a released kernel, but let's not get 
ahead of ourselves just now.

(I'm pretty sure we could get away with a single blocking domain per 
IOMMU instance, rather than per group, but I deliberately saved that one 
for later - right now one per group to match default domains is simpler 
to reason about and less churny in the context of the current ownership 
patches)

Cheers,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
