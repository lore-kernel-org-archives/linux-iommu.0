Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524CDC433EF
	for <iommu@archiver.kernel.org>; Fri,  6 May 2022 09:33:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 05E0A83F15;
	Fri,  6 May 2022 09:33:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KQyvVevMGaDT; Fri,  6 May 2022 09:33:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BCED983EEF;
	Fri,  6 May 2022 09:33:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F44DC0039;
	Fri,  6 May 2022 09:33:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69761C002D
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 09:32:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 565FF41910
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 09:32:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qIESwXz8HuzL for <iommu@lists.linux-foundation.org>;
 Fri,  6 May 2022 09:32:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1DB524190C
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 09:32:57 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D638152B;
 Fri,  6 May 2022 02:32:57 -0700 (PDT)
Received: from [10.57.80.111] (unknown [10.57.80.111])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E52483FA31;
 Fri,  6 May 2022 02:32:55 -0700 (PDT)
Message-ID: <9f6680ed-77b6-8440-078c-623406c823aa@arm.com>
Date: Fri, 6 May 2022 10:32:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] iommu: iommu_group_claim_dma_owner() must always
 assign a domain
Content-Language: en-GB
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <0-v2-f62259511ac0+6-iommu_dma_block_jgg@nvidia.com>
 <BN9PR11MB5276504B448C715527AD5F3F8CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220505153320.GS49344@nvidia.com>
 <BN9PR11MB5276476BB203D8D61CA8849C8CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <BN9PR11MB5276476BB203D8D61CA8849C8CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: Will Deacon <will@kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Rodel,
 Jorg" <jroedel@suse.de>, Qian Cai <quic_qiancai@quicinc.com>
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

On 2022-05-06 00:28, Tian, Kevin wrote:
>> From: Jason Gunthorpe
>> Sent: Thursday, May 5, 2022 11:33 PM
>>>>   	/*
>>>> -	 * If the group has been claimed already, do not re-attach the default
>>>> -	 * domain.
>>>> +	 * New drivers should support default domains and so the
>>>> detach_dev() op
>>>> +	 * will never be called. Otherwise the NULL domain indicates the
>>>> +	 * translation for the group should be set so it will work with the
>>>
>>> translation should be 'blocked'?
>>
>> No, not blocked.
>>
>>>> +	 * platform DMA ops.
>>>
>>> I didn't get the meaning of the last sentence.
>>
>> It is as discussed with Robin, NULL means to return the group back to
>> some platform defined translation, and in some cases this means
>> returning back to work with the platform's DMA ops - presumably if it
>> isn't using the dma api.
> 
> This is clearer than the original text.

Perhaps we could just leave that sentence as "Otherwise the NULL domain 
represents platform-specific behaviour."

>>
>>>> +	/*
>>>> +	 * Changing the domain is done by calling attach on the new domain.
>>>> +	 * Drivers should implement this so that DMA is always translated by
>>>
>>> what does 'this' mean?
>>
>> The code below - attach_dev called in a loop for each dev in the group.
> 
> Yes.
> 
>>
>>>> +	 * either the new, old, or a blocking domain. DMA should never
>>>
>>> isn't the blocking domain passed in as the new domain?
>>
>> Soemtimes. This is a statement about the required
>> atomicity. New/old/block are all valid translations during the
>> operation. Identity is not.
> 
> but new/old/block are not the same type of classifications. A group
> has an old domain and a new domain at this transition point, and
> both old/new domains have a domain type (dma, unmanged, block,
> identity, etc.). Mixing them together only increases confusion here.

Good point - in particular I think the "DMA is always translated" part 
would be more accurately said as "DMA is always managed". When we're 
reattaching back to the default domain here, and it happens to be an 
identity domain, then DMA *may* be untranslated, but in a manner that 
we've knowingly chosen. The key point is that if the driver supports 
core domains, then it should never have any in-between state that allows 
access to anything *other* than the current domain or the new domain.

Thanks,
Robin.

> 
>>
>> So, I'm going to leave this patch as-is since it has been tested now
>> and we need to get the series back into iommu-next ASAP.
>>
> 
> Agree. Just hope some improvements on the code comment.
> 
> But either way given no more code change:
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
