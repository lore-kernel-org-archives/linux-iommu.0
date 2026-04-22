Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909FD2BEC55;
	Wed, 22 Apr 2026 05:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776837035; cv=none; b=I4Ys907DY3B4FBhQ039UgR8H8Mgn/AAQxC9Qicxs6au/D9lmauaalH4KQjtVLfP9q0C73lwrgEUf8hL7OXk20xa70/zaxsHWB9+a7m8fVaA9PN6T1yc3DxpxLzwLz3icMBm7xx3N2W38cvHVK4z4XYApXgmPfheuxAwPLFcQ3jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776837035; c=relaxed/simple;
	bh=9G2hh9Uof2dUVKFnd6uvXoI4j0yPeySOhLTI5bmV91A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tg0tvgvE581d8GoEKgAGCF594R5ZpPB5V8rSlqq8PfQhqnvxoHm8igQXitInnY7mcOWkA9uySfIi/9TiLlslfe7zyeQ8DLJVgp5fkWQ/UPZXAZZwvALyxZcJMbUIsHmxD5je03r0jwospzG6zEaG72sjm1oBd2i6ZJ3lPpTwoFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=moca9Eld; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="moca9Eld"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D28C19425;
	Wed, 22 Apr 2026 05:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776837035;
	bh=9G2hh9Uof2dUVKFnd6uvXoI4j0yPeySOhLTI5bmV91A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=moca9Eldi4xx6PpPgoxHAXzboDoaDwcGgRMVsouSd4PTVra9mScNpzRWWMzKNkp5V
	 MSoepPt9GQmISmnOvFX3jZlkzJ4WfNXJ/GLUpSy13h58rm1qvROotFD6lhahYDoAGZ
	 IeHR7w7oDd6y3eBStpCNcw95y1Y4NQ54B+fPdPQ46knfFA+IolFthX7t5Fh/LuoTYR
	 07BRvumoDzmYXBxk3zWlsNIuWTGVJM49C/mHUQvcNup1YkNWveQuA1IN0dovD1Daka
	 3MocKv3WoGyOX9kPRqJaTHibVAjIVABVggZpGVyFLdfu6MU/LSZmOvMUhJCGcR8RqW
	 7Yqm398eXNpjg==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us, Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH v2 6/8] dma-direct: make dma_direct_map_phys() honor
 DMA_ATTR_CC_SHARED
In-Reply-To: <20260421122924.GB3611611@ziepe.ca>
References: <20260420061415.3650870-1-aneesh.kumar@kernel.org>
 <20260420061415.3650870-7-aneesh.kumar@kernel.org>
 <20260421122924.GB3611611@ziepe.ca>
Date: Wed, 22 Apr 2026 11:20:28 +0530
Message-ID: <yq5apl3rczmj.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Mon, Apr 20, 2026 at 11:44:13AM +0530, Aneesh Kumar K.V (Arm) wrote:
>> Teach dma_direct_map_phys() to select the DMA address encoding based on
>> DMA_ATTR_CC_SHARED.
>> 
>> Use phys_to_dma_unencrypted() for decrypted mappings and
>> phys_to_dma_encrypted() otherwise. If a device requires unencrypted DMA
>> but the source physical address is still encrypted, force the mapping
>> through swiotlb so the DMA address and backing memory attributes remain
>> consistent.
>> 
>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>> ---
>>  kernel/dma/direct.h | 25 ++++++++++++++-----------
>>  1 file changed, 14 insertions(+), 11 deletions(-)
>> 
>> diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
>> index 7140c208c123..928671ef01e9 100644
>> --- a/kernel/dma/direct.h
>> +++ b/kernel/dma/direct.h
>> @@ -86,9 +86,14 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
>>  		phys_addr_t phys, size_t size, enum dma_data_direction dir,
>>  		unsigned long attrs, bool flush)
>>  {
>> +	bool force_swiotlb_map = false;
>>  	dma_addr_t dma_addr;
>>  
>> -	if (is_swiotlb_force_bounce(dev)) {
>> +	/* if phys addr attribute is encrypted but the device is forcing an encrypted dma addr */
>> +	if (!(attrs & DMA_ATTR_CC_SHARED) && force_dma_unencrypted(dev))
>> +		force_swiotlb_map = true;
>
> continuing my prior email.. This is really in the wrong spot, it
> should be in dma_capable()
>
>> +	if (is_swiotlb_force_bounce(dev) || force_swiotlb_map) {
>>  		if (!(attrs & DMA_ATTR_CC_SHARED)) {
>>  			if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
>>  				return DMA_MAPPING_ERROR;
>> @@ -105,18 +110,16 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
>>  			goto err_overflow;
>>  	} else if (attrs & DMA_ATTR_CC_SHARED) {
>>  		dma_addr = phys_to_dma_unencrypted(dev, phys);
>> -		if (unlikely(!dma_capable(dev, dma_addr, size, false)))
>> -			goto err_overflow;
>>  	} else {
>> -		dma_addr = phys_to_dma(dev, phys);
>> -		if (unlikely(!dma_capable(dev, dma_addr, size, true)) ||
>> -		    dma_kmalloc_needs_bounce(dev, size, dir)) {
>
> here.
>
> swiotlb because the device can't reach a high address and swiotlb
> because the device doesn't have T=1 are really the same thing and
> should have the same code flow.
>
> Add attrs to dma_capable() and check force_dma_unencrypted(dev)
> inside.
>

will update in the next revision

>
>> -			if (is_swiotlb_active(dev) &&
>> -			    !(attrs & DMA_ATTR_REQUIRE_COHERENT))
>> -				return swiotlb_map(dev, phys, size, dir, attrs);
>> +		dma_addr = phys_to_dma_encrypted(dev, phys);
>> +	}
>>  
>> -			goto err_overflow;
>> -		}
>> +	if (unlikely(!dma_capable(dev, dma_addr, size, true)) ||
>> +	    dma_kmalloc_needs_bounce(dev, size, dir)) {
>> +		if (is_swiotlb_active(dev) &&
>> +		    !(attrs & DMA_ATTR_REQUIRE_COHERENT))
>> +			return swiotlb_map(dev, phys, size, dir, attrs);
>> +		goto err_overflow;
>>  	}
>
> Then this movement shouldn't be needed?

I am still not clear about the use of DMA_ATTR_CC_SHARED here. If the
resulting DMA address is not dma_capable, I was expecting that we should
fall back to swiotlb_map(). That was the intention behind this change.
However, the other email thread suggests that DMA_ATTR_CC_SHARED is
always used with swiotlb_force_bounce(). I think we should address that.
If we do, the goal here would be to check dma_capable for both shared
and private addresses.

For private/protected addresses, swiotlb_map() will currently fail with
DMA_MAPPING_ERROR because the default io_tlb_mem (dev->dma_io_tlb_mem)
is decrypted by default

-aneesh
