Return-Path: <SRS0=5HPr=TQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4511C04E84
	for <iommu@archiver.kernel.org>; Thu, 16 May 2019 17:23:33 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B07522082E
	for <iommu@archiver.kernel.org>; Thu, 16 May 2019 17:23:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B07522082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 7B0B6C11;
	Thu, 16 May 2019 17:23:33 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5B02AC03
	for <iommu@lists.linux-foundation.org>;
	Thu, 16 May 2019 17:23:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id B3DF92C3
	for <iommu@lists.linux-foundation.org>;
	Thu, 16 May 2019 17:23:31 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58FBC1715;
	Thu, 16 May 2019 10:23:31 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94F513F5AF;
	Thu, 16 May 2019 10:23:28 -0700 (PDT)
Subject: Re: [PATCH v3 6/7] iommu: Introduce IOMMU_RESV_DIRECT_RELAXABLE
	reserved memory regions
To: Alex Williamson <alex.williamson@redhat.com>,
	Auger Eric <eric.auger@redhat.com>
References: <20190516100817.12076-1-eric.auger@redhat.com>
	<20190516100817.12076-7-eric.auger@redhat.com>
	<3e21e370-135e-2eab-dd99-50e19cd53b86@arm.com>
	<403897e7-2af9-3fa9-2264-f66dfeda6fd7@redhat.com>
	<214a20d2-9cb5-c23d-ad38-8a0dea729e00@arm.com>
	<342a4aad-3abd-f9a8-05fd-e8e260bbb69d@redhat.com>
	<20190516110621.1359c650@x1.home>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <4a0842de-b622-b8f4-630d-7b72bcb2799c@arm.com>
Date: Thu, 16 May 2019 18:23:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516110621.1359c650@x1.home>
Content-Language: en-GB
Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, will.deacon@arm.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	sudeep.holla@arm.com, dwmw2@infradead.org, eric.auger.pro@gmail.com
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

On 16/05/2019 18:06, Alex Williamson wrote:
> On Thu, 16 May 2019 14:58:08 +0200
> Auger Eric <eric.auger@redhat.com> wrote:
> 
>> Hi Jean-Philippe,
>>
>> On 5/16/19 2:43 PM, Jean-Philippe Brucker wrote:
>>> On 16/05/2019 12:45, Auger Eric wrote:
>>>> Hi Jean-Philippe,
>>>>
>>>> On 5/16/19 1:16 PM, Jean-Philippe Brucker wrote:
>>>>> On 16/05/2019 11:08, Eric Auger wrote:
>>>>>> Note: At the moment the sysfs ABI is not changed. However I wonder
>>>>>> whether it wouldn't be preferable to report the direct region as
>>>>>> "direct_relaxed" there. At the moment, in case the same direct
>>>>>> region is used by 2 devices, one USB/GFX and another not belonging
>>>>>> to the previous categories, the direct region will be output twice
>>>>>> with "direct" type.
>>>>>>
>>>>>> This would unblock Shameer's series:
>>>>>> [PATCH v6 0/7] vfio/type1: Add support for valid iova list management
>>>>>> https://patchwork.kernel.org/patch/10425309/
>>>>>
>>>>> Thanks for doing this!
>>>>>   
>>>>>> which failed to get pulled for 4.18 merge window due to IGD
>>>>>> device assignment regression.
>>>>>>
>>>>>> v2 -> v3:
>>>>>> - fix direct type check
>>>>>> ---
>>>>>>   drivers/iommu/iommu.c | 12 +++++++-----
>>>>>>   include/linux/iommu.h |  6 ++++++
>>>>>>   2 files changed, 13 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>>>>> index ae4ea5c0e6f9..28c3d6351832 100644
>>>>>> --- a/drivers/iommu/iommu.c
>>>>>> +++ b/drivers/iommu/iommu.c
>>>>>> @@ -73,10 +73,11 @@ struct iommu_group_attribute {
>>>>>>   };
>>>>>>   
>>>>>>   static const char * const iommu_group_resv_type_string[] = {
>>>>>> -	[IOMMU_RESV_DIRECT]	= "direct",
>>>>>> -	[IOMMU_RESV_RESERVED]	= "reserved",
>>>>>> -	[IOMMU_RESV_MSI]	= "msi",
>>>>>> -	[IOMMU_RESV_SW_MSI]	= "msi",
>>>>>> +	[IOMMU_RESV_DIRECT]			= "direct",
>>>>>> +	[IOMMU_RESV_DIRECT_RELAXABLE]		= "direct",
>>>>>> +	[IOMMU_RESV_RESERVED]			= "reserved",
>>>>>> +	[IOMMU_RESV_MSI]			= "msi",
>>>>>> +	[IOMMU_RESV_SW_MSI]			= "msi",
>>>>>>   };
>>>>>>   
>>>>>>   #define IOMMU_GROUP_ATTR(_name, _mode, _show, _store)		\
>>>>>> @@ -573,7 +574,8 @@ static int iommu_group_create_direct_mappings(struct iommu_group *group,
>>>>>>   		start = ALIGN(entry->start, pg_size);
>>>>>>   		end   = ALIGN(entry->start + entry->length, pg_size);
>>>>>>   
>>>>>> -		if (entry->type != IOMMU_RESV_DIRECT)
>>>>>> +		if (entry->type != IOMMU_RESV_DIRECT &&
>>>>>> +		    entry->type != IOMMU_RESV_DIRECT_RELAXABLE)
>>>>>
>>>>> I'm trying to understand why you need to create direct mappings at all
>>>>> for these relaxable regions. In the host the region is needed for legacy
>>>>> device features, which are disabled (and cannot be re-enabled) when
>>>>> assigning the device to a guest?
>>>> This follows Kevin's comment in the thread below:
>>>> https://patchwork.kernel.org/patch/10449103/#21957279
>>>>
>>>> In normal DMA API host path, those regions need to be 1-1 mapped. They
>>>> are likely to be accessed by the driver or FW at early boot phase or
>>>> even during execution, depending on features being used.
>>>>
>>>> That's the reason, according to Kevin we couldn't hide them.
>>>>
>>>> We just know that, in general, they are not used anymore when assigning
>>>> the device or if accesses are attempted this generally does not block
>>>> the assignment use case. For example, it is said in
>>>> https://github.com/qemu/qemu/blob/master/docs/igd-assign.txt that in
>>>> legacy IGD assignment use case, there may be "a small numbers of DMAR
>>>> faults when initially assigned".
>>>
>>> Hmm, fair enough. That doesn't sound too good, if the device might
>>> perform arbitrary writes into guest memory once new IOMMU mappings are
>>> in place. I was wondering if we could report some IOVA ranges as
>>> "available but avoid if possible".
>> In Shameer's series we currently reject any vfio dma_map that would fall
>> into an RMRR (hence the regression on existing USB/GFX use case). With
>> the relaxable RMRR info we could imagine to let the userspace choose
>> whether we want to proceed with the dma_map despite the risk or
>> introduce a vfio_iommu_type1 module option (turned off by default for
>> not regressing existing USB/GFX passthrough) that would forbid dma_map
>> on relaxable RMRR regions.
> 
> Yep, the risk that Jean-Philippe mentions is real, the IGD device has
> the stolen memory addresses latched into the hardware and we're unable
> to change that.  What we try to do now is trap page table writes to the
> device and translate them to a VM allocated stolen memory range, which
> is sufficient for getting a BIOS splash screen, but we really want to
> assume that the OS level driver just doesn't use the stolen memory
> range.  There was a time when it seemed like we could assume the Intel
> drivers were heading in that direction, but it seems that's no longer
> an actual goal.  To fully support IGD assignment in a way that isn't as
> fragile as it is today, we'd want to re-export the RMRR out to
> userspace so that QEMU could identity map it into the VM address
> space.  That's not trivial, it's only one of several issues around
> IGD assignment, and we've got GVT-g (Intel vGPUs) now that don't impose
> these requirements, so motivation to tackle the issue is somewhat
> reduced.
> 
> With the changes here, we might want vfio to issue a warning when one
> of these relaxed reserved regions is ignored and we'd probably want a
> module option to opt-in to strict enforcement, where downstreams that
> don't claim to support IGD assignment might enforce this by default.

OK, I guess that resolves my thoughts about "boot" reservations .vs 
"relaxable" ones - clearly they are distinct things, we will ultimately 
want both, and only the former can be hidden from userspace (and ignored 
by VFIO). I'm happy with that; we can come back to boot regions at a 
later date :)

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
