Return-Path: <SRS0=jPbF=ND=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9CBC4338F
	for <iommu@archiver.kernel.org>; Thu, 12 Aug 2021 12:44:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 959BF6109D
	for <iommu@archiver.kernel.org>; Thu, 12 Aug 2021 12:44:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 959BF6109D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C62F606C6;
	Thu, 12 Aug 2021 12:44:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l8yc8hVnGrUN; Thu, 12 Aug 2021 12:44:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D367660766;
	Thu, 12 Aug 2021 12:44:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B233EC0010;
	Thu, 12 Aug 2021 12:44:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88E66C000E
 for <iommu@lists.linux-foundation.org>; Thu, 12 Aug 2021 12:44:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 67DF680D3F
 for <iommu@lists.linux-foundation.org>; Thu, 12 Aug 2021 12:44:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7ko--nBeRKjK for <iommu@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 12:44:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 647B380D3D
 for <iommu@lists.linux-foundation.org>; Thu, 12 Aug 2021 12:44:02 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D6211042;
 Thu, 12 Aug 2021 05:44:01 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 379203F718;
 Thu, 12 Aug 2021 05:44:00 -0700 (PDT)
Subject: Re: [RFC PATCH 2/3] iommu/dma-iommu: Support iovad->granule >
 PAGE_SIZE
To: Sven Peter <sven@svenpeter.dev>, iommu@lists.linux-foundation.org
References: <20210806155523.50429-1-sven@svenpeter.dev>
 <20210806155523.50429-3-sven@svenpeter.dev>
 <d289a555-9e3b-b948-1883-2ee4c915da4c@arm.com>
 <dadbd8b0-171a-4008-8a2e-f68abfed9285@www.fastmail.com>
 <5002ed91-416c-d7ee-b1ab-a50c590749c2@arm.com>
 <cf78f795-1e75-45c9-a759-018f17cfaed9@www.fastmail.com>
 <a721f8e3-4c1d-afb2-3ae2-eb1360e1eaca@arm.com>
 <7b6cf00c-86ea-43c4-861f-f1cc32d5852d@www.fastmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <26874474-82d5-9807-f666-ff2291fb3b14@arm.com>
Date: Thu, 12 Aug 2021 13:43:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <7b6cf00c-86ea-43c4-861f-f1cc32d5852d@www.fastmail.com>
Content-Language: en-GB
Cc: Arnd Bergmann <arnd@kernel.org>, Hector Martin <marcan@marcan.st>,
 linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
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

On 2021-08-11 21:18, Sven Peter wrote:
> 
> 
> On Tue, Aug 10, 2021, at 11:51, Robin Murphy wrote:
>> On 2021-08-09 21:45, Sven Peter wrote:
>>>
>>>
>>> On Mon, Aug 9, 2021, at 19:41, Robin Murphy wrote:
>>>> On 2021-08-07 12:47, Sven Peter via iommu wrote:
>>>>>
>>>>>
>>>>> On Fri, Aug 6, 2021, at 20:04, Robin Murphy wrote:
>>>>>> On 2021-08-06 16:55, Sven Peter via iommu wrote:
>>>>>>> @@ -1006,6 +1019,31 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>>>>>>>      	if (dev_is_untrusted(dev))
>>>>>>>      		return iommu_dma_map_sg_swiotlb(dev, sg, nents, dir, attrs);
>>>>>>>      
>>>>>>> +	/*
>>>>>>> +	 * If the IOMMU pagesize is larger than the CPU pagesize we will
>>>>>>> +	 * very likely run into sgs with a physical address that is not aligned
>>>>>>> +	 * to an IOMMU page boundary. Fall back to just mapping every entry
>>>>>>> +	 * independently with __iommu_dma_map then.
>>>>>>
>>>>>> Scatterlist segments often don't have nicely aligned ends, which is why
>>>>>> we already align things to IOVA granules in main loop here. I think in
>>>>>> principle we'd just need to move the non-IOVA-aligned part of the
>>>>>> address from sg->page to sg->offset in the temporary transformation for
>>>>>> the rest of the assumptions to hold. I don't blame you for being timid
>>>>>> about touching that, though - it took me 3 tries to get right when I
>>>>>> first wrote it...
>>>>>>
>>>>>
>>>>>
>>>>> I've spent some time with that code now and I think we cannot use it
>>>>> but have to fall back to iommu_dma_map_sg_swiotlb (even though that swiotlb
>>>>> part is a lie then):
>>>>>
>>>>> When we have sg_phys(s) = 0x802e65000 with s->offset = 0 the paddr
>>>>> is aligned to PAGE_SIZE but has an offset of 0x1000 from something
>>>>> the IOMMU can map.
>>>>> Now this would result in s->offset = -0x1000 which is already weird
>>>>> enough.
>>>>> Offset is unsigned (and 32bit) so this will actually look like
>>>>> s->offset = 0xfffff000 then, which isn't much better.
>>>>> And then sg_phys(s) = 0x902e64000 (instead of 0x802e64000) and
>>>>> we'll map some random memory in iommu_map_sg_atomic and a little bit later
>>>>> everything explodes.
>>>>>
>>>>> Now I could probably adjust the phys addr backwards and make sure offset is
>>>>> always positive (and possibly larger than PAGE_SIZE) and later restore it
>>>>> in __finalise_sg then but I feel like that's pushing this a little bit too far.
>>>>
>>>> Yes, that's what I meant. At a quick guess, something like the
>>>> completely untested diff below.
>>>
>>> That unfortunately results in unaligned mappings
>>
>> You mean it even compiles!? :D
> 
> I was more impressed that it already almost worked correctly :)
> 
>>
>>> [    9.630334] iommu: unaligned: iova 0xbff40000 pa 0x0000000801a3b000 size 0x4000 min_pagesz 0x4000
>>>
>>> I'll take a closer look later this week and see if I can fix it.
>>
>> On reflection, "s->offset ^ s_iova_off" is definitely wrong, that more
>> likely wants to be "s->offset & ~s_iova_off".
>>
>> Robin.
>>
> 
> 
> If I change
> 
> 		sg_set_page(s, phys_to_page(sg_phys(s)), s_length,
> 			    s_iova_off & ~PAGE_MASK);
> 
> in __finalise_sg (and the same thing in __invalidate_sg) to
> 
> 		sg_set_page(s, phys_to_page(sg_phys(s) + s_iova_off), s_length,
> 			    s_iova_off & ~PAGE_MASK);
> 
> then it also restores the original fields correctly.

Ah, good point, once again this proves to be right on the limit of how 
many moving parts I can hold in my head without working it through on 
paper (or in a debugger). FWIW my thought there was that sg_phys(s) 
would be enough to "re-normalise" things from a state where s->page_link 
was rounded down and s->offset held the PAGE_SIZE multiple (which is 
what the XOR did do), but of course that wasn't right to begin with. In 
fact, s->offset must always be negligible when restoring so you could 
arguably open-code page_to_phys(sg_page(s)), but that might be a bit too 
much of a mouthful for a theoretical micro-optimisation (note that 
trying to avoid the phys_addr_t round-trip by offsetting the page 
pointer itself might appear to work for SPARSEMEM_VMEMMAP, but I'm 
pretty sure it's not valid in general).

> What is the proper way to credit you for coming up with this?
> Do you create the commit and I apply it to my local tree and
> include it in my submission once I have fixed the other
> issues? Or do I create the commit and put a Suggested-by
> in the message?

Suggested-by is fine by me, but if you feel there's enough of my diff 
left that you haven't had to put right then you're also welcome to have 
these instead:

Co-developed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Cheers,
Robin.

> 
> 
> Either way, here's the patch that I have right now:
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 7ce74476699d..ba31dc59566d 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -907,8 +907,8 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
>   		unsigned int s_length = sg_dma_len(s);
>   		unsigned int s_iova_len = s->length;
> 
> -		s->offset += s_iova_off;
> -		s->length = s_length;
> +		sg_set_page(s, phys_to_page(sg_phys(s) + s_iova_off), s_length,
> +			    s_iova_off & ~PAGE_MASK);
>   		sg_dma_address(s) = DMA_MAPPING_ERROR;
>   		sg_dma_len(s) = 0;
> 
> @@ -952,10 +952,11 @@ static void __invalidate_sg(struct scatterlist *sg, int nents)
>   	int i;
> 
>   	for_each_sg(sg, s, nents, i) {
> -		if (sg_dma_address(s) != DMA_MAPPING_ERROR)
> -			s->offset += sg_dma_address(s);
>   		if (sg_dma_len(s))
> -			s->length = sg_dma_len(s);
> +			sg_set_page(s,
> +				    phys_to_page(sg_phys(s) + sg_dma_address(s)),
> +				    sg_dma_len(s),
> +				    sg_dma_address(s) & ~PAGE_MASK);
>   		sg_dma_address(s) = DMA_MAPPING_ERROR;
>   		sg_dma_len(s) = 0;
>   	}
> @@ -1031,15 +1032,16 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>   	 * stashing the unaligned parts in the as-yet-unused DMA fields.
>   	 */
>   	for_each_sg(sg, s, nents, i) {
> -		size_t s_iova_off = iova_offset(iovad, s->offset);
> +		phys_addr_t s_phys = sg_phys(s);
> +		size_t s_iova_off = iova_offset(iovad, s_phys);
>   		size_t s_length = s->length;
>   		size_t pad_len = (mask - iova_len + 1) & mask;
> 
>   		sg_dma_address(s) = s_iova_off;
>   		sg_dma_len(s) = s_length;
> -		s->offset -= s_iova_off;
>   		s_length = iova_align(iovad, s_length + s_iova_off);
> -		s->length = s_length;
> +		sg_set_page(s, phys_to_page(s_phys - s_iova_off),
> +			    s_length, s->offset & ~s_iova_off);
> 
>   		/*
>   		 * Due to the alignment of our single IOVA allocation, we can
> 
> 
> 
> 
> 
> Sven
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
