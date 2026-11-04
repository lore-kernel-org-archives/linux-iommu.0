Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793777832;
	b=dz9U18vauzmqGDT4COmY6Y7alhWLjrbPQj/28Smx6V1wOujuUq+H1WLNMSgaVjKRvhz2
	 BuS4B9Rs8e5Gnu586GT1s5/x0m/pWxEVOiynXyJLvNb5cvoNVJOosxkLgrG0PI7LD/3at
	 m/TVX09vr21u9IWYV2eRB2bvTG5eeY8sTB13C+EboYX6Rrttjma0Pn/8RruUnKFJYY/cR
	 zKWLOa/6htQZC5uyFPkrpUsW79OZf2hM4zgCV8zOj0C8TY4ea0qHwsG9axqXdSKR+F+tE
	 Y2HDujJOVcYGO4twfIN7JNL6Qn84ksrX15gC4C1yA9b7a42LbalfoEOLDi0i8a3PsBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793777832;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 Content-Language:From:In-Reply-To:Content-Transfer-Encoding:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:
	 X-CMS-RootMailID:References;
	bh=Fin16iwd8zeVB2XbqHtY/b1SBp98Yl5BOCuh6PYlXus=;
	b=kT6Ynd562SUk1jErjqdJOyfXyRnLbkrdWzPc+spgH/NzTBCjG6OqSErEL0SzISuWrs9P
	 jwSMrsElBYP9xewj+WXJ7n+94kKtIMtsDK52WzaZnlvuVmN967PsAxPUmAbbLDboFzS/w
	 5WvCBZz7JAag0bnnVCIiJF4qpn1ZmkLvDc/7Chk7Kqltvciu4vJv5uXLpV/VZ5sGOZVF8
	 nsGrCqPVxO8V8+x34psLm2Ul29NKDpjWmhOMFHoUDl19C5gyGJ8Sgc8tKAjU7fIJpJ26L
	 ZXCm/GfhvPDUTPeD0PAvuxIAD6Y1Ad/4hC7KVvWVDoOpB+sa6O9NbqwjjOkGg9lhl2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=oRsgo2d1;
	arc=none smtp.remote-ip=210.118.77.12
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A82606A328
	for <iommu@lists.linux.dev>; Wed,  4 Nov 2026 07:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62A82606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=oRsgo2d1
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261104073708euoutp02a88192eaf18c39b3716970bc2f627aca~kx25ixp2i1255812558euoutp02C
	for <iommu@lists.linux.dev>; Wed,  4 Nov 2026 07:37:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261104073708euoutp02a88192eaf18c39b3716970bc2f627aca~kx25ixp2i1255812558euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793777828;
	bh=Fin16iwd8zeVB2XbqHtY/b1SBp98Yl5BOCuh6PYlXus=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=oRsgo2d10Xs5fjaGmy+g59SkBifdAXF8fkxLlnePByDdoW/aAWfyUWRP2EoMEdE9l
	 L8MvDVD51dJP2anrj89xr1OGy69mAlXFjo19MkmQ2LYVmBFrNwQwyAVs9ONLmEyHdT
	 D7O3O2ukNcvGMNrleLkax8SnrMZeGRblcHVcWqRE=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261104073707eucas1p26b354ea66e62c86c08bfcbf21fde04d2~kx25Dfbbl0248702487eucas1p2-;
	Wed,  4 Nov 2026 07:37:07 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261104073707eusmtip22cc96a6645008d9040cea9d940ec6d4a~kx24dAqup0090700907eusmtip2r;
	Wed,  4 Nov 2026 07:37:07 +0000 (GMT)
Message-ID: <8276a107-7115-48e3-a40a-2660fe1beaa5@samsung.com>
Date: Wed, 4 Nov 2026 08:37:06 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] dma: swiotlb: Round restricted DMA pool size down to
 IO_TLB_SEGSIZE
To: Michael Kelley <mhklinux@outlook.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Claire Chang
	<tientzu@chromium.org>, Konrad Rzeszutek Wilk <konrad@kernel.org>, Giorgi
	Kobakhia <gkobakhi@asu.edu>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <MN2PR02MB686381EADCEECF16B23214D0D4692@MN2PR02MB6863.namprd02.prod.outlook.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261104073707eucas1p26b354ea66e62c86c08bfcbf21fde04d2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261103155032eucas1p10934ce1bc0c0e2f1fa86891fb2626862
X-EPHeader: CA
X-CMS-RootMailID: 20261103155032eucas1p10934ce1bc0c0e2f1fa86891fb2626862
References: <CGME20261103155032eucas1p10934ce1bc0c0e2f1fa86891fb2626862@eucas1p1.samsung.com>
	<20261103155016.1107958-1-m.szyprowski@samsung.com>
	<MN2PR02MB686381EADCEECF16B23214D0D4692@MN2PR02MB6863.namprd02.prod.outlook.com>

On 03.11.2026 22:18, Michael Kelley wrote:
> From: Marek Szyprowski <m.szyprowski@samsung.com> Sent: Tuesday, November 3, 2026 7:50 AM
>> All other paths creating a swiotlb pool ensure that nslabs is a multiple
>> of IO_TLB_SEGSIZE, and the swiotlb code relies on that. Since commit
>> 0b84e4f8b793 ("swiotlb: Add restricted DMA pool initialization") a
>> restricted pool can have an arbitrary size taken from the device tree.
>>
>> If the pool size is not a multiple of IO_TLB_SEGSIZE, the last segment is
>> partial and swiotlb_release_slots() reads mem->slots[index + nslabs],
>> which is one past the end of the slots array when the freed buffer ends
>> at the end of the pool:
>>
>>  BUG: KASAN: slab-out-of-bounds in swiotlb_release_slots
>>  Read of size 2
>>
>> Round the pool size down to a multiple of IO_TLB_SEGSIZE, wasting a bit
>> of memory, and warn about it.
> I'm not familiar with the macro scenarios where a device has a
> restricted pool specified in DT. But I wonder if it would be better to
> round up instead of down. DT has specified that the device should
> have a restricted DMA pool of a certain size, and rounding down gives
> the device a smaller pool than was requested. Could DMA operations
> then fail because of not having a large enough pool? Rounding down
> also allows the pool to end up being size zero, which this patch
> detects and results in a definite failure at device initialization time.
>
> What's the tradeoff in rounding up instead?The device restricted
> pool at least as large as requested. Presumably, being larger than
> requested doesn't cause any problems for the device or its driver.
> The downside is using up to 256 KiB more system memory than
> expected. In an embedded system with only a few MiB of system
> memory, maybe that's a relatively big problem. I don't know the
> scenarios well enough to judge whether using a bit more system
> memory is better or worse than the device not having all the
> restricted pool space it said it needed for DMA.

The main problem with enlarging the restricted pool is that the memory
has been already allocated (reserved) by the generic of_reserved_mem
code before the rmem_swiotlb_device_init() is called. There might be
even another reserved region just after the one being processed by
rmem_swiotlb_device_init(). The reserved region might be specified in
the device tree exactly, by pointing its base address and size. In
such case the rmem_swiotlb_device_init() really cannot do anything
else than using the provided already allocated region partially.
The only thing that might be improved is freeing the 'wasted' part
of the region back to the memory allocator if You think that
printing a warning is not enough.



>
> Your commit message also mentions "wasting a bit of memory".
> What is wasted in the round down case? The rounding down is
> done before the pool memory is allocated. I would have thought
> the wasting would occur in the round up case, where the restricted
> pool is given more memory than the device said it needed.
>
> Michael
>
>> Reported-by: Giorgi Kobakhia <gkobakhi@asu.edu>
>> Closes: https://lore.kernel.org/all/20261026032007.1957949-1-gkobakhi@asu.edu/
>> Fixes: 0b84e4f8b793 ("swiotlb: Add restricted DMA pool initialization")
>> CC: stable@vger.kernel.org
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>  kernel/dma/swiotlb.c | 15 ++++++++++++++-
>>  1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
>> index 2c57b49ac7c0..a68f35192582 100644
>> --- a/kernel/dma/swiotlb.c
>> +++ b/kernel/dma/swiotlb.c
>> @@ -2007,6 +2007,19 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
>>  	 */
>>  	if (!mem) {
>>  		struct io_tlb_pool *pool;
>> +		unsigned long aligned_nslabs = ALIGN_DOWN(nslabs, IO_TLB_SEGSIZE);
>> +
>> +		if (aligned_nslabs != nslabs) {
>> +			dev_warn(dev, "Restricted DMA pool size %zu is not a multiple of %lu, rounding down to %lu bytes\n",
>> +				 (size_t)rmem->size,
>> +				 (unsigned long)IO_TLB_SEGSIZE << IO_TLB_SHIFT,
>> +				 aligned_nslabs << IO_TLB_SHIFT);
>> +			nslabs = aligned_nslabs;
>> +		}
>> +		if (!nslabs) {
>> +			dev_err(dev, "Restricted DMA pool is too small\n");
>> +			return -EINVAL;
>> +		}
>>
>>  		mem = kzalloc_obj(*mem);
>>  		if (!mem)
>> @@ -2034,7 +2047,7 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
>>
>>  			mem->cc_shared = true;
>>  			ret = set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
>> -						   rmem->size >> PAGE_SHIFT);
>> +						   (nslabs << IO_TLB_SHIFT) >> PAGE_SHIFT);
>>  			if (ret) {
>>  				dev_err(dev, "Failed to decrypt restricted DMA pool\n");
>>  				kfree(pool->areas);
>> --
>> 2.43.0
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

