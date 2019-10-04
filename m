Return-Path: <SRS0=qml7=X5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E276CC47404
	for <iommu@archiver.kernel.org>; Fri,  4 Oct 2019 18:51:33 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90FFA2053B
	for <iommu@archiver.kernel.org>; Fri,  4 Oct 2019 18:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90FFA2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3B990E27;
	Fri,  4 Oct 2019 18:51:33 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2E218E25
	for <iommu@lists.linux-foundation.org>;
	Fri,  4 Oct 2019 18:50:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 6A960189
	for <iommu@lists.linux-foundation.org>;
	Fri,  4 Oct 2019 18:50:58 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBC5615AB;
	Fri,  4 Oct 2019 11:50:57 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B8003F534;
	Fri,  4 Oct 2019 11:50:55 -0700 (PDT)
Subject: Re: [PATCH] dma-mapping: Lift address space checks out of debug code
To: Kees Cook <keescook@chromium.org>
References: <201910021341.7819A660@keescook>
	<7a5dc7aa-66ec-0249-e73f-285b8807cb73@arm.com>
	<201910021643.75E856C@keescook>
	<fc9fffc8-3cff-4a6f-d426-4a4cc895ebb1@arm.com>
	<201910031438.A67C40B97C@keescook>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <91192af8-dc96-eeb9-42ab-01473cf2b7c0@arm.com>
Date: Fri, 4 Oct 2019 19:50:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <201910031438.A67C40B97C@keescook>
Content-Language: en-GB
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
	iommu@lists.linux-foundation.org,
	Semmle Security Reports <security-reports@semmle.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Jesper Dangaard Brouer <brouer@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, Laura Abbott <labbott@redhat.com>,
	Christoph Hellwig <hch@lst.de>, Allison Randal <allison@lohutok.net>
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

On 03/10/2019 22:38, Kees Cook wrote:
> On Thu, Oct 03, 2019 at 10:42:45AM +0100, Robin Murphy wrote:
>> On 03/10/2019 00:58, Kees Cook wrote:
>>> On Wed, Oct 02, 2019 at 10:15:43PM +0100, Robin Murphy wrote:
>>>> Hi Kees,
>>>>
>>>> On 2019-10-02 9:46 pm, Kees Cook wrote:
>>>>> As we've seen from USB and other areas, we need to always do runtime
>>>>> checks for DMA operating on memory regions that might be remapped. This
>>>>> consolidates the (existing!) checks and makes them on by default. A
>>>>> warning will be triggered for any drivers still using DMA on the stack
>>>>> (as has been seen in a few recent reports).
>>>>>
>>>>> Suggested-by: Laura Abbott <labbott@redhat.com>
>>>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>>>> ---
>>>>>     include/linux/dma-debug.h   |  8 --------
>>>>>     include/linux/dma-mapping.h |  8 +++++++-
>>>>>     kernel/dma/debug.c          | 16 ----------------
>>>>>     3 files changed, 7 insertions(+), 25 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/dma-debug.h b/include/linux/dma-debug.h
>>>>> index 4208f94d93f7..2af9765d9af7 100644
>>>>> --- a/include/linux/dma-debug.h
>>>>> +++ b/include/linux/dma-debug.h
>>>>> @@ -18,9 +18,6 @@ struct bus_type;
>>>>>     extern void dma_debug_add_bus(struct bus_type *bus);
>>>>> -extern void debug_dma_map_single(struct device *dev, const void *addr,
>>>>> -				 unsigned long len);
>>>>> -
>>>>>     extern void debug_dma_map_page(struct device *dev, struct page *page,
>>>>>     			       size_t offset, size_t size,
>>>>>     			       int direction, dma_addr_t dma_addr);
>>>>> @@ -75,11 +72,6 @@ static inline void dma_debug_add_bus(struct bus_type *bus)
>>>>>     {
>>>>>     }
>>>>> -static inline void debug_dma_map_single(struct device *dev, const void *addr,
>>>>> -					unsigned long len)
>>>>> -{
>>>>> -}
>>>>> -
>>>>>     static inline void debug_dma_map_page(struct device *dev, struct page *page,
>>>>>     				      size_t offset, size_t size,
>>>>>     				      int direction, dma_addr_t dma_addr)
>>>>> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
>>>>> index 4a1c4fca475a..2d6b8382eab1 100644
>>>>> --- a/include/linux/dma-mapping.h
>>>>> +++ b/include/linux/dma-mapping.h
>>>>> @@ -583,7 +583,13 @@ static inline unsigned long dma_get_merge_boundary(struct device *dev)
>>>>>     static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
>>>>>     		size_t size, enum dma_data_direction dir, unsigned long attrs)
>>>>>     {
>>>>> -	debug_dma_map_single(dev, ptr, size);
>>>>> +	/* DMA must never operate on stack or other remappable places. */
>>>>> +	WARN_ONCE(is_vmalloc_addr(ptr) || !virt_addr_valid(ptr),
>>>>
>>>> This stands to absolutely cripple I/O performance on arm64, because every
>>>> valid call will end up going off and scanning the memblock list, which is
>>>> not something we want on a fastpath in non-debug configurations. We'd need a
>>>> much better solution to the "pfn_valid() vs. EFI no-map" problem before this
>>>> might be viable.
>>>
>>> Ah! Interesting. I didn't realize this was fast-path (I don't know the
>>> DMA code at all). I thought it was more of a "one time setup" before
>>> actual DMA activity started.
>>
>> That's strictly true, it's just that many workloads can involve tens of
>> thousands of "one time"s per second ;)
>>
>> Overhead on the dma_map_* paths has shown to have a direct impact on
>> throughput in such situations, hence various optimisation effort in IOVA
>> allocation for IOMMU-based DMA ops, and the recent work to remove indirect
>> calls entirely for the common dma-direct/SWIOTLB cases.
>>
>>> Regardless, is_vmalloc_addr() is extremely light (a bounds check), and is the
>>> most important part of this as far as catching stack-based DMA attempts.
>>> I thought virt_addr_valid() was cheap too, but I see it's much heavier on
>>> arm64.
>>>
>>> I just went to compare what the existing USB check does, and it happens
>>> immediately before its call to dma_map_single(). Both checks are simple
>>> bounds checks, so it shouldn't be an issue:
>>>
>>> 			if (is_vmalloc_addr(urb->setup_packet)) {
>>> 				WARN_ONCE(1, "setup packet is not dma capable\n");
>>> 				return -EAGAIN;
>>> 			} else if (object_is_on_stack(urb->setup_packet)) {
>>> 				WARN_ONCE(1, "setup packet is on stack\n");
>>> 				return -EAGAIN;
>>> 			}
>>>
>>> 			urb->setup_dma = dma_map_single(
>>> 					hcd->self.sysdev,
>>> 					urb->setup_packet,
>>> 					sizeof(struct usb_ctrlrequest),
>>>
>>>
>>> In the USB case, it'll actually refuse to do the operation. Should
>>> dma_map_single() similarly fail? I could push these checks down into
>>> dma_map_single(), which would be a no-change on behavior for USB and
>>> gain the checks on all other callers...
>>
>> I think it would be reasonable to pull the is_vmalloc_addr() check inline,
>> as that probably covers 90+% of badness (especially given vmapped stacks),
>> and as you say should be reliably cheap everywhere. Callers are certainly
>> expected to use dma_mapping_error() and handle failure, so refusing to do a
>> bogus mapping operation should be OK API-wise - ultimately if a driver goes
>> ahead and uses DMA_MAPPING_ERROR as an address anyway, that's not likely to
>> be any *more* catastrophic than if it did the same with whatever nonsense
>> virt_to_phys() of a vmalloc address had returned.
> 
> What do you think about the object_is_on_stack() check? That does a
> dereference through "current" to find the stack bounds...

I guess it depends what the aim is - is it just to bail out of 
operations which have near-zero chance of working correctly and every 
chance of going catastrophically wrong, or to lay down strict argument 
checking for the API in general? (for cache-coherent devices, or if the 
caller is careful to ensure the appropriate alignment, DMA from a 
non-virtually-mapped stack can be *technically* fine, it's just banned 
in general because those necessary assumptions can be tricky to meet and 
aren't at all portable).

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
