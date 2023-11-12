Received: from mail.tkos.co.il (guitar.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326105397
	for <iommu@lists.linux.dev>; Sun, 12 Nov 2023 07:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="bhw7d3xB"
Received: from tarshish (unknown [10.0.8.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id C606C440394;
	Sun, 12 Nov 2023 09:38:08 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1699774688;
	bh=CT+4CTFw3TWups965GYXi3kRzFYumSfG7ykeet06X+Q=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:From;
	b=bhw7d3xBy9NQ3TQC6P+MHKyj3rncKvZmIZJRmPXI1e2PnhZS5rHhlBEISOjJnW0No
	 9dXTtjiK6ht5C8HYmYy+jYhT0QjiTAAv/xgSHMOFq+EuCnUzuXjL4BAe2Svc6XFo59
	 wYLO+VutkrA9bW3WqDVKBD7Yu8xvTg046vN0UrRxGCUgTmRcjdZ2pSOBfaJiJEtB8C
	 BLAaHRQktThnRbvl7qQ5fKjJMRpTT33b4b1ewOM9p1bIpo16SA3N7IidxT3VYsHx0T
	 wWKAc1SCXEoSLqtVD+2A2NlKhkOvdWi4sDkHZeBf6EYSYmu+v+8rga54/xea+WW1YK
	 cYqoI4cRaOffA==
References: <9af8a19c3398e7dc09cfc1fbafed98d795d9f83e.1699464622.git.baruch@tkos.co.il>
 <ZU0QEL9ByWNYVki1@arm.com>
User-agent: mu4e 1.9.21; emacs 29.1
From: Baruch Siach <baruch@tkos.co.il>
To: Catalin Marinas <catalin.marinas@arm.com>, Petr =?utf-8?B?VGVzYcWZw61r?=
 <petr@tesarici.cz>
Cc: Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>, Marek
 Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
 <robin.murphy@arm.com>, Ramon Fried <ramon@neureality.ai>,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] arm64: DMA zone above 4GB
Date: Sun, 12 Nov 2023 09:25:46 +0200
In-reply-to: <ZU0QEL9ByWNYVki1@arm.com>
Message-ID: <877cmn7750.fsf@tarshish>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Hi Catalin, Petr,

Thanks for your detailed response.

See below a few comments and questions.

On Thu, Nov 09 2023, Catalin Marinas wrote:
> On Wed, Nov 08, 2023 at 07:30:22PM +0200, Baruch Siach wrote:
>> Consider a bus with this 'dma-ranges' property:
>> 
>>   #address-cells = <2>;
>>   #size-cells = <2>;
>>   dma-ranges = <0x00000000 0xc0000000 0x00000008 0x00000000 0x0 0x40000000>;
>> 
>> Devices under this bus can see 1GB of DMA range between 3GB-4GB. This
>> range is mapped to CPU memory at 32GB-33GB.
>
> Is this on real hardware or just theoretical for now (the rest of your
> email implies it's real)? Normally I'd expected the first GB (or first
> two) of RAM from 32G to be aliased to the lower 32-bit range for the CPU
> view as well, not just for devices. You'd then get a ZONE_DMA without
> having to play with DMA offsets.

This hardware is currently in fabrication past tapeout. Software tests
are running on FPGA models and software simulators.

CPU view of the 3GB-4GB range is not linear with DMA addresses. That is,
for offset N where 0 <= N <= 1GB, the CPU address 3GB+N does not map to
the same physical location of DMA address 3GB+N. Hardware engineers are
not sure this is fixable. So as is often the case we look at software to
save us. After all, from hardware perspective this design "works".

>> Current zone_sizes_init() code considers 'dma-ranges' only when it maps
>> to RAM under 4GB, because zone_dma_bits is limited to 32. In this case
>> 'dma-ranges' is ignored in practice, since DMA/DMA32 zones are both
>> assumed to be located under 4GB. The result is that the stmmac driver
>> DMA buffers allocation GFP_DMA32 flag has no effect. As a result DMA
>> buffer allocations fail.
>> 
>> The patch below is a crude workaround hack. It makes the  DMA zone
>> cover the 1GB memory area that is visible to stmmac DMA as follows:
>> 
>> [    0.000000] Zone ranges:
>> [    0.000000]   DMA      [mem 0x0000000800000000-0x000000083fffffff]
>> [    0.000000]   DMA32    empty
>> [    0.000000]   Normal   [mem 0x0000000840000000-0x0000000bffffffff]
>> ...
>> [    0.000000] software IO TLB: mapped [mem 0x000000083bfff000-0x000000083ffff000] (64MB)
>> 
>> With this hack the stmmac driver works on my platform with no
>> modification.
>> 
>> Clearly this can't be the right solutions. zone_dma_bits is now wrong for
>> one. It probably breaks other code as well.
>
> zone_dma_bits ends up as 36 if I counted correctly. So DMA_BIT_MASK(36)
> is 0xf_ffff_ffff and the phys_limit for your device is below this mask,
> so dma_direct_optimal_gfp_mask() does end up setting GFP_DMA. However,
> looking at how it sets GFP_DMA32, it is obvious that the code is not set
> up for such configurations. I'm also not a big fan of zone_dma_bits
> describing a mask that goes well above what the device can access.
>
> A workaround would be for zone_dma_bits to become a *_limit and sort out
> all places where we compare masks with masks derived from zone_dma_bits
> (e.g. cma_in_zone(), dma_direct_supported()).

I was also thinking along these lines. I wasn't sure I see the entire
picture, so I hesitated to suggest a patch. Specifically, the assumption
that DMA range limits are power of 2 looks deeply ingrained in the
code. Another assumption is that DMA32 zone is in low 4GB range.

I can work on an RFC implementation of this approach.

Petr suggested a more radical solution of per bus DMA constraints to
replace DMA/DMA32 zones. As Petr acknowledged, this does not look like a
near future solution.

> Alternatively, take the DMA offset into account when comparing the
> physical address corresponding to zone_dma_bits and keep zone_dma_bits
> small (phys offset subtracted, so in your case it would be 30 rather
> than 36).

I am not following here. Care to elaborate?

Thanks,
baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
