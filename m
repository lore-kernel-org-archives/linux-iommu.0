Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84266C43334
	for <iommu@archiver.kernel.org>; Mon,  6 Jun 2022 12:38:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 354C441A27;
	Mon,  6 Jun 2022 12:38:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6u7m6x1YDxSy; Mon,  6 Jun 2022 12:38:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9084141604;
	Mon,  6 Jun 2022 12:38:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6514AC0039;
	Mon,  6 Jun 2022 12:38:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4771BC002D
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jun 2022 12:38:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 30E5E828F2
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jun 2022 12:38:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8HNj_AzZJb9C for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jun 2022 12:38:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 04EB780024
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jun 2022 12:38:14 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4EE0F1042;
 Mon,  6 Jun 2022 05:38:14 -0700 (PDT)
Received: from [10.57.81.38] (unknown [10.57.81.38])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7101F3F73B;
 Mon,  6 Jun 2022 05:38:12 -0700 (PDT)
Message-ID: <1d617b42-55c7-fcf1-e569-052947364d94@arm.com>
Date: Mon, 6 Jun 2022 13:38:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V2 2/6] iommu: iova: properly handle 0 as a valid IOVA
 address
Content-Language: en-GB
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 Ajay Kumar <ajaykumar.rs@samsung.com>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org, joro@8bytes.org, will@kernel.org
References: <20220511121544.5998-1-ajaykumar.rs@samsung.com>
 <CGME20220511121433epcas5p3de77375a85edf1aa78c0976a7107fdfa@epcas5p3.samsung.com>
 <20220511121544.5998-3-ajaykumar.rs@samsung.com>
 <a21f3016-a9f1-dc86-8604-ae651a763fc8@arm.com>
 <00c1f1c7-e3e5-5f22-0a15-b57b329d6d56@samsung.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <00c1f1c7-e3e5-5f22-0a15-b57b329d6d56@samsung.com>
Cc: pankaj.dubey@samsung.com, alim.akhtar@samsung.com
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

On 2022-06-02 16:58, Marek Szyprowski wrote:
> Hi Robin,
> 
> On 23.05.2022 19:30, Robin Murphy wrote:
>> On 2022-05-11 13:15, Ajay Kumar wrote:
>>> From: Marek Szyprowski <m.szyprowski@samsung.com>
>>>
>>> Zero is a valid DMA and IOVA address on many architectures, so adjust
>>> the
>>> IOVA management code to properly handle it. A new value IOVA_BAD_ADDR
>>> (~0UL) is introduced as a generic value for the error case. Adjust all
>>> callers of the alloc_iova_fast() function for the new return value.
>>
>> And when does anything actually need this? In fact if you were to stop
>> iommu-dma from reserving IOVA 0 - which you don't - it would only show
>> how patch #3 is broken.
> 
> I don't get why you says that patch #3 is broken.

My mistake, in fact it's already just as broken either way - I forgot 
that that's done implicitly via iovad->start_pfn rather than an actual 
reserve_iova() entry. I see there is an initial calculation attempting 
to honour start_pfn in patch #3, but it's always immediately 
overwritten. More critically, the rb_first()/rb_next walk means the 
starting point can only creep inevitably upwards as older allocations 
are freed, so will end up pathologically stuck at or above limit_pfn and 
unable to recover. At best it's more "next-fit" than "first-fit", and 
TBH the fact that it could ever even allocate anything at all in an 
empty domain makes me want to change the definition of IOVA_ANCHOR ;)

> Them main issue with
> address 0 being reserved appears when one uses first fit allocation
> algorithm. In such case the first allocation will be at the 0 address,
> what causes some issues. This patch simply makes the whole iova related
> code capable of such case. This mimics the similar code already used on
> ARM 32bit. There are drivers that rely on the way the IOVAs are
> allocated. This is especially important for the drivers for devices with
> limited addressing capabilities. And there exists such and they can be
> even behind the IOMMU.
> 
> Lets focus on the s5p-mfc driver and the way one of the supported
> hardware does the DMA. The hardware has very limited DMA window (256M)
> and addresses all memory buffers as an offset from the firmware base.
> Currently it has been assumed that the first allocated buffer will be on
> the beginning of the IOVA space. This worked fine on ARM 32bit and
> supporting such case is a target of this patchset.

I still understand the use-case; I object to a solution where PFN 0 is 
always reserved yet sometimes allocated. Not to mention the slightly 
more fundamental thing of the whole lot not actually working the way 
it's supposed to.

I also remain opposed to baking in secret ABIs where allocators are 
expected to honour a particular undocumented behaviour. FWIW I've had 
plans for a while now to make the IOVA walk bidirectional to make the 
existing retry case more efficient, at which point it's then almost 
trivial to implement "bottom-up" allocation, which I'm thinking I might 
then force on by default for CONFIG_ARM to minimise any further 
surprises for v2 of the default domain conversion. However I'm 
increasingly less convinced that it's really sufficient for your case, 
and am leaning back towards the opinion that any driver with really 
specific constraints on how its DMA addresses are laid out should not be 
passively relying on a generic allocator to do exactly what it wants. A 
simple flag saying "try to allocate DMA addresses bottom-up" doesn't 
actually mean "allocate this thing on a 256MB-aligned address and 
everything subsequent within a 256MB window above it", so let's not 
build a fragile house of cards on top of pretending that it does.

>> Also note that it's really nothing to do with architecture either way;
>> iommu-dma simply chooses to reserve IOVA 0 for its own convenience,
>> mostly because it can. Much the same way that 0 is typically a valid
>> CPU VA, but mapping something meaningful there is just asking for a
>> world of pain debugging NULL-dereference bugs.
> 
> Right that it is not directly related to the architecture, but it is
> much more common case for some architectures where DMA (IOVA) address =
> physical address + some offset. The commit message can be rephrased,
> though.
> 
> I see no reason to forbid the 0 as a valid IOVA. The DMA-mapping also
> uses DMA_MAPPING_ERROR as ~0. It looks that when last fit allocation
> algorithm is used no one has ever need to consider such case so far.

Because it's the most convenient and efficient thing to do. Remember we 
tried to use 0 for DMA_MAPPING_ERROR too, but that turned out to be a 
usable physical RAM address on some systems. With a virtual address 
space, on the other hand, we're free to do whatever we want; that's kind 
of the point.

Thanks,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
