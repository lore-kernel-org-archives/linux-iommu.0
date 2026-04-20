Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690C138F947
	for <iommu@lists.linux.dev>; Mon, 20 Apr 2026 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776677367; cv=none; b=fTTgxr8CTqUXTbC72TY0vfx0vNsrEWzwUZiI+WLkAw0K1yNhaW8D3cLkphIVk6SDNtLdeAUQ1QjIK6wbiFiNaCeqXptFp1gCisnY5IiY70E6bjw+cmZrbPf5Y+52+2qtfHg1TVixihldfnVVHGkqRVzFuipbdAqYPmPBiuczbIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776677367; c=relaxed/simple;
	bh=t68PnAuUVdCxSz0hVbJNZkIzL4xxh55AMqx0Abl5XQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVwCwYU3VNtgPM86lfjp2Za+vkDfril4HeUBMZ5VDrW6q34MDkMKxy4MC5E2fqJsoibu8UWlsNDPzYX2efe70lWCiC56HZfZNMITRJwtGM/LbFaR4LIccZfii9dvj70MtenSRWJz8P2I19aNhNQGx4Hz9cOpTid5f8gxx+UdGBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=sHdA+Yfd; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="sHdA+Yfd"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so19077645e9.2
        for <iommu@lists.linux.dev>; Mon, 20 Apr 2026 02:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1776677362; x=1777282162; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IEZHN3EejXoq9qbRm7mjl8x1VVtWAaecGDOSe23Ifhk=;
        b=sHdA+YfdJGrLobqeI+Za0lOiuGdLYt+/r6DfZdZG8CNfAYNGWuA6fY9EU9po0fYRQC
         8drZ9z1ETQOYMb9ZrqYHbJLis/u+wgJELJyi6iF+Q8iZVcJti9jfmlZB+/ORZIVnmETg
         qXNhe6NSdo+yLyFXispW3eFKo+zufq2Kxxq+xcB1Jz9FRtQWhg62K0O0BTHZhFliDB6+
         qi0ra9iVQ24Ks/RCQXQSo1t0HZNaoQkt4ciXo8aEJ6VxKFr+BoIJZvXxtm2guePfTb1B
         544D+BH/5+3jzyPlpPB4Pl3z0olygz9Hg2vmA9ROOyIlHsadGNZfyPb7/zpdsjjPBs0n
         A8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776677362; x=1777282162;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IEZHN3EejXoq9qbRm7mjl8x1VVtWAaecGDOSe23Ifhk=;
        b=BT80PsPNxr/vmmf7mKgnThvXcqdvhqkSf6+jC0dy01CyfZywCwzcZE63BlRnHx5i02
         0EQNE1Meu0aHzJ5UrS3nQJ6heoWcD74fMymN8B2Nx5zcK0iIl4YJfBjcywk7H32Jb63i
         RlanyTRnzR3yXj1MGPyplT/BWZQd5+HAVKZ9gbur8ZMiFttTY0W3ctS3OvzFkrDw0ZD+
         7RG1+u5fmKMBR/j5iUBT3s38TSrzjV7Q0bt5X3dF155QdYRRiRhz8/lRXXYcWt73b6MR
         kTC5S47662E4hA6ZgfTzhrTaHwcGDJ5JCZMpYRo8VtOgPrbIbm7tlJp871dZDzN0A5uT
         3B1A==
X-Forwarded-Encrypted: i=1; AFNElJ+WcweG0ACoCjHNCYRDkKrh8UlDK7GHbazLT0le9WButn0qDhEdNKulmZnTR8rqK6PcSdaDBQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwpmiF+YMrfuHKGlXxo4606rLsoI4LEWod+iDQ7hTKaWyRxoOqg
	0ft4iN30a58glVex5Q+aepFVXby1ZVSwuwo8zClRZ9rNExWyXBBdt28M48ZAw2RG/mM=
X-Gm-Gg: AeBDieuiJGyKgUsqn5FV9zhk/SYEZrzkmSIidknoYEekx+MNHGoxgQyOkjAZcPWoBT3
	vbAjyhmZYK9E4Dq/HCbd8ZNrAuwjFEJgfBrEa/4euKfa5TPPh49jhQy/F86sqY61REJd5tFZlEQ
	1bmQPB3++B5o82+Mv8T1JYxmuGMc5P1Y6OQzUfmkST7qP+s8ooTMTSf4gvf/Klt5c0wBU1SsNYv
	Flp+CzfaP+1ocIQoSgYe7rUg7m3/5el7F1RlOCfkBIGh7SZFDlO9HDv9ZoYY6saBg1+aA0OmEXf
	ZxsNMpFfh/sBx/nqR+2+v7qGrtoiOr7QitJbf5RLXGBWsz7JG6OzC1Eos8+WMxG+aYllc5Xc2yO
	oH0leAUyLaRlHFsuXjKL4FtyJbs+M4WyZFN7zJZHFFkq4jyKeMso+7R5Wu76/6zTulQqruKf6yC
	rk6YYv5Bgvkd1CWQk5Vd7eJ0XzVUtIfxXtdGrthrc5eZJBOQ==
X-Received: by 2002:a05:600c:a102:b0:488:ba19:da25 with SMTP id 5b1f17b1804b1-488fb759f0fmr143513465e9.12.1776677361344;
        Mon, 20 Apr 2026 02:29:21 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb75af76sm85639205e9.13.2026.04.20.02.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 02:29:20 -0700 (PDT)
Date: Mon, 20 Apr 2026 11:29:17 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	iommu@lists.linux.dev, linux-media@vger.kernel.org, sumit.semwal@linaro.org, 
	benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, jstultz@google.com, tjmercier@google.com, 
	christian.koenig@amd.com, m.szyprowski@samsung.com, robin.murphy@arm.com, jgg@ziepe.ca, 
	leon@kernel.org, sean.anderson@linux.dev, ptesarik@suse.com, 
	catalin.marinas@arm.com, suzuki.poulose@arm.com, steven.price@arm.com, 
	thomas.lendacky@amd.com, john.allen@amd.com, ashish.kalra@amd.com, 
	suravee.suthikulpanit@amd.com, linux-coco@lists.linux.dev
Subject: Re: [PATCH v5 1/2] dma-mapping: introduce DMA_ATTR_CC_SHARED for
 shared memory
Message-ID: <4qdizkkoeke3cvkcf35upa7p7ick6s654eqlrizmi7ozkw5eze@tnpk2e34xgwl>
References: <20260325192352.437608-1-jiri@resnulli.us>
 <20260325192352.437608-2-jiri@resnulli.us>
 <yq5atst6ywbl.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq5atst6ywbl.fsf@kernel.org>

Mon, Apr 20, 2026 at 08:34:06AM +0200, aneesh.kumar@kernel.org wrote:
>Jiri Pirko <jiri@resnulli.us> writes:
>
>> From: Jiri Pirko <jiri@nvidia.com>
>>
>> Current CC designs don't place a vIOMMU in front of untrusted devices.
>> Instead, the DMA API forces all untrusted device DMA through swiotlb
>> bounce buffers (is_swiotlb_force_bounce()) which copies data into
>> shared memory on behalf of the device.
>>
>> When a caller has already arranged for the memory to be shared
>> via set_memory_decrypted(), the DMA API needs to know so it can map
>> directly using the unencrypted physical address rather than bounce
>> buffering. Following the pattern of DMA_ATTR_MMIO, add
>> DMA_ATTR_CC_SHARED for this purpose. Like the MMIO case, only the
>> caller knows what kind of memory it has and must inform the DMA API
>> for it to work correctly.
>>
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>> v4->v5:
>> - rebased on top od dma-mapping-for-next
>> - s/decrypted/shared/
>> v3->v4:
>> - added some sanity checks to dma_map_phys and dma_unmap_phys
>> - enhanced documentation of DMA_ATTR_CC_DECRYPTED attr
>> v1->v2:
>> - rebased on top of recent dma-mapping-fixes
>> ---
>>  include/linux/dma-mapping.h | 10 ++++++++++
>>  include/trace/events/dma.h  |  3 ++-
>>  kernel/dma/direct.h         | 14 +++++++++++---
>>  kernel/dma/mapping.c        | 13 +++++++++++--
>>  4 files changed, 34 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
>> index 677c51ab7510..db8ab24a54f4 100644
>> --- a/include/linux/dma-mapping.h
>> +++ b/include/linux/dma-mapping.h
>> @@ -92,6 +92,16 @@
>>   * flushing.
>>   */
>>  #define DMA_ATTR_REQUIRE_COHERENT	(1UL << 12)
>> +/*
>> + * DMA_ATTR_CC_SHARED: Indicates the DMA mapping is shared (decrypted) for
>> + * confidential computing guests. For normal system memory the caller must have
>> + * called set_memory_decrypted(), and pgprot_decrypted must be used when
>> + * creating CPU PTEs for the mapping. The same shared semantic may be passed
>> + * to the vIOMMU when it sets up the IOPTE. For MMIO use together with
>> + * DMA_ATTR_MMIO to indicate shared MMIO. Unless DMA_ATTR_MMIO is provided
>> + * a struct page is required.
>> + */
>> +#define DMA_ATTR_CC_SHARED	(1UL << 13)
>>  
>>  /*
>>   * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
>> diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
>> index 63597b004424..31c9ddf72c9d 100644
>> --- a/include/trace/events/dma.h
>> +++ b/include/trace/events/dma.h
>> @@ -34,7 +34,8 @@ TRACE_DEFINE_ENUM(DMA_NONE);
>>  		{ DMA_ATTR_PRIVILEGED, "PRIVILEGED" }, \
>>  		{ DMA_ATTR_MMIO, "MMIO" }, \
>>  		{ DMA_ATTR_DEBUGGING_IGNORE_CACHELINES, "CACHELINES_OVERLAP" }, \
>> -		{ DMA_ATTR_REQUIRE_COHERENT, "REQUIRE_COHERENT" })
>> +		{ DMA_ATTR_REQUIRE_COHERENT, "REQUIRE_COHERENT" }, \
>> +		{ DMA_ATTR_CC_SHARED, "CC_SHARED" })
>>  
>>  DECLARE_EVENT_CLASS(dma_map,
>>  	TP_PROTO(struct device *dev, phys_addr_t phys_addr, dma_addr_t dma_addr,
>> diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
>> index b86ff65496fc..7140c208c123 100644
>> --- a/kernel/dma/direct.h
>> +++ b/kernel/dma/direct.h
>> @@ -89,16 +89,24 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
>>  	dma_addr_t dma_addr;
>>  
>>  	if (is_swiotlb_force_bounce(dev)) {
>> -		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
>> -			return DMA_MAPPING_ERROR;
>> +		if (!(attrs & DMA_ATTR_CC_SHARED)) {
>> +			if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
>> +				return DMA_MAPPING_ERROR;
>>  
>> -		return swiotlb_map(dev, phys, size, dir, attrs);
>> +			return swiotlb_map(dev, phys, size, dir, attrs);
>> +		}
>> +	} else if (attrs & DMA_ATTR_CC_SHARED) {
>> +		return DMA_MAPPING_ERROR;
>>  	}
>>
>
>What is this check for? If we are requesting a DMA mapping with
>DMA_ATTR_CC_SHARED, shouldn’t it be allowed? If not, how would we reach

This is defensive. Only allows to map with DMA_ATTR_CC_SHARED set to
dev dev that does not support CC natively. This can be of course lifted,
if you have a case.


>the conditional below where we convert the physical address to a DMA
>address using phys_to_dma_unencrypted()?. Also, how is this supposed to
>interact with is_swiotlb_force_bounce()?”

You reach there when is_swiotlb_force_bounce(dev) is true and
DMA_ATTR_CC_SHARED is set. What am I missing?



>
>>  
>>  	if (attrs & DMA_ATTR_MMIO) {
>>  		dma_addr = phys;
>>  		if (unlikely(!dma_capable(dev, dma_addr, size, false)))
>>  			goto err_overflow;
>> +	} else if (attrs & DMA_ATTR_CC_SHARED) {
>> +		dma_addr = phys_to_dma_unencrypted(dev, phys);
>> +		if (unlikely(!dma_capable(dev, dma_addr, size, false)))
>> +			goto err_overflow;
>>  	} else {
>>  		dma_addr = phys_to_dma(dev, phys);
>>  		if (unlikely(!dma_capable(dev, dma_addr, size, true)) ||
>
>-aneesh
