Return-Path: <SRS0=iPMr=L7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BBCC07E95
	for <iommu@archiver.kernel.org>; Wed,  7 Jul 2021 11:47:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82A9B61CBA
	for <iommu@archiver.kernel.org>; Wed,  7 Jul 2021 11:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A9B61CBA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 46242403A9;
	Wed,  7 Jul 2021 11:47:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 38LOwvgG5UEU; Wed,  7 Jul 2021 11:47:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D182B40294;
	Wed,  7 Jul 2021 11:47:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A562BC001A;
	Wed,  7 Jul 2021 11:47:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E85ABC000E
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 11:47:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E42C0835D9
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 11:47:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nTs0Rxlkhe4v for <iommu@lists.linux-foundation.org>;
 Wed,  7 Jul 2021 11:47:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id DFF74834C6
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 11:47:13 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0300C1042;
 Wed,  7 Jul 2021 04:47:13 -0700 (PDT)
Received: from [10.57.35.192] (unknown [10.57.35.192])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EABE63F73B;
 Wed,  7 Jul 2021 04:47:11 -0700 (PDT)
Subject: Re: [RFC PATCH 1/1] dma-debug: fix check_for_illegal_area() in
 debug_dma_map_sg()
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
References: <20210705185252.4074653-1-gerald.schaefer@linux.ibm.com>
 <20210705185252.4074653-2-gerald.schaefer@linux.ibm.com>
 <3bb87b4c-f646-20fe-7cc5-c7449432811e@arm.com>
 <20210706211207.48f15496@thinkpad>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <ae61c67a-6735-ed72-adf3-56570c9b7251@arm.com>
Date: Wed, 7 Jul 2021 12:47:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210706211207.48f15496@thinkpad>
Content-Language: en-GB
Cc: linux-s390 <linux-s390@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Niklas Schnelle <schnelle@linux.ibm.com>, Christoph Hellwig <hch@lst.de>,
 LKML <linux-kernel@vger.kernel.org>
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

On 2021-07-06 20:12, Gerald Schaefer wrote:
> On Tue, 6 Jul 2021 10:22:40 +0100
> Robin Murphy <robin.murphy@arm.com> wrote:
> 
>> On 2021-07-05 19:52, Gerald Schaefer wrote:
>>> The following warning occurred sporadically on s390:
>>> DMA-API: nvme 0006:00:00.0: device driver maps memory from kernel text or rodata [addr=0000000048cc5e2f] [len=131072]
>>> WARNING: CPU: 4 PID: 825 at kernel/dma/debug.c:1083 check_for_illegal_area+0xa8/0x138
>>>
>>> It is a false-positive warning, due to a broken logic in debug_dma_map_sg().
>>> check_for_illegal_area() should check for overlay of sg elements with kernel
>>> text or rodata. It is called with sg_dma_len(s) instead of s->length as
>>> parameter. After the call to ->map_sg(), sg_dma_len() contains the length
>>> of possibly combined sg elements in the DMA address space, and not the
>>> individual sg element length, which would be s->length.
>>>
>>> The check will then use the kernel start address of an sg element, and add
>>> the DMA length for overlap check, which can result in the false-positive
>>> warning because the DMA length can be larger than the actual single sg
>>> element length in kernel address space.
>>>
>>> In addition, the call to check_for_illegal_area() happens in the iteration
>>> over mapped_ents, which will not include all individual sg elements if
>>> any of them were combined in ->map_sg().
>>>
>>> Fix this by using s->length instead of sg_dma_len(s). Also put the call to
>>> check_for_illegal_area() in a separate loop, iterating over all the
>>> individual sg elements ("nents" instead of "mapped_ents").
>>>
>>> Fixes: 884d05970bfb ("dma-debug: use sg_dma_len accessor")
>>> Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
>>> Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
>>> ---
>>>    kernel/dma/debug.c | 10 ++++++----
>>>    1 file changed, 6 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
>>> index 14de1271463f..d7d44b7fe7e2 100644
>>> --- a/kernel/dma/debug.c
>>> +++ b/kernel/dma/debug.c
>>> @@ -1299,6 +1299,12 @@ void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
>>>    	if (unlikely(dma_debug_disabled()))
>>>    		return;
>>>    
>>> +	for_each_sg(sg, s, nents, i) {
>>> +		if (!PageHighMem(sg_page(s))) {
>>> +			check_for_illegal_area(dev, sg_virt(s), s->length);
>>> +		}
>>> +	}
>>> +
>>>    	for_each_sg(sg, s, mapped_ents, i) {
>>>    		entry = dma_entry_alloc();
>>>    		if (!entry)
>>> @@ -1316,10 +1322,6 @@ void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
>>>    
>>>    		check_for_stack(dev, sg_page(s), s->offset);
>>
>> Strictly this should probably be moved to the new loop as well, as it is
>> similarly concerned with validating the source segments rather than the
>> DMA mappings - I think with virtually-mapped stacks it might technically
>> be possible for a stack page to be physically adjacent to a "valid" page
>> such that it could get merged and overlooked if it were near the end of
>> the list, although in fairness that would probably be indicative of
>> something having gone far more fundamentally wrong. Otherwise, the
>> overall reasoning looks sound to me.
> 
> I see, good point. I think I can add this to my patch, and a different
> subject like "dma-debug: fix sg checks in debug_dma_map_sg()".

TBH it's more of a conceptual cleanliness thing than a significant 
practical concern, but if we *are* breaking out a separate "validate the 
source elements" step then it does seem logical to capture everything 
relevant at once.

> However, I do not quite understand why check_for_stack() does not also
> consider s->length. It seems to check only the first page of an sg
> element.
> 
> So, shouldn't check_for_stack() behave similar to check_for_illegal_area(),
> i.e. check all source sg elements for overlap with the task stack area?

Realistically, creating a scatterlist segment pointing to the stack at 
all would already be quite an audacious feat of brokenness, but getting 
a random stack page in the middle of a segment would seem to imply 
something having gone so catastrophically wrong that it's destined to 
end very badly whether or not dma-debug squawks about it - not to 
mention getting lucky enough for said random stack page to actually 
belong to the current task stack in the first place :)

Robin.

> If yes, then this probably should be a separate patch, but I can try
> to come up with something and send a new RFC with two patches. Maybe
> check_for_stack() can also be integrated into check_for_illegal_area(),
> they are both called at the same places. And mapping memory from the
> stack also sounds rather illegal.
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
