Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD9214B088
	for <iommu@lists.linux.dev>; Thu, 11 Apr 2024 13:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712841219; cv=none; b=Ptuks6gxoRF0ZpJXdMCd8Uxqp78yZfvhsVKhEZqUTu4xO121eBr8h53fgdUr7WH4HqbhFPe7sra/0FBI5vGQCZDZNmkV1pkUHipvcZ7uuWZzG4+GFX3yaGoEHHd5avpyHybEgaUJxOqDx335lDuTLMUiFeG9xbyAAeVbOw7BxGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712841219; c=relaxed/simple;
	bh=dOD0KsrLEjg9iH8ZN3UDQmx72Brw6XPTxx41Vx6TG8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YKyvR9++6bweakp1/R4x+kgx8u/YDYKP/LF0zaOdKMup2HmJR65oBqzxzORmM8a7rki7EOWsKRFJa2NLhI1GbPygCBIg+VN2R4Gj+bjGDlhcL2ZOWFleYikZn9J/+pX/QDOrrCH28JHaO0Y3tiO0ggRvIIBYySY+oGw2xFQTmqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48C2011FB;
	Thu, 11 Apr 2024 06:14:06 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C350E3F64C;
	Thu, 11 Apr 2024 06:13:35 -0700 (PDT)
Message-ID: <51055d13-4a72-4000-9a22-b403d8c5b2ff@arm.com>
Date: Thu, 11 Apr 2024 14:13:34 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Remove caching mode check before
 device TLB flush
To: Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev
Cc: Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
References: <20240410055823.264501-1-baolu.lu@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240410055823.264501-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/04/2024 6:58 am, Lu Baolu wrote:
> The Caching Mode (CM) of the Intel IOMMU indicates if the hardware
> implementation caches not-present or erroneous translation-structure
> entries except the first-stage translation. The caching mode is
> irrelevant to the device TLB , therefore there is no need to check
> it before a device TLB invalidation operation.
> 
> iommu_flush_iotlb_psi() is called in map and unmap paths. The caching
> mode check before device TLB invalidation will cause device TLB
> invalidation always issued if IOMMU is not running in caching mode.
> This is wrong and causes unnecessary performance overhead.
> 
> The removal of caching mode check in intel_flush_iotlb_all() doesn't
> impact anything no matter the IOMMU is working in caching mode or not.
> Commit <29b32839725f> ("iommu/vt-d: Do not use flush-queue when
> caching-mode is on") has already disabled flush-queue for caching mode,
> hence caching mode will never call intel_flush_iotlb_all().

Well, technically it might still, at domain creation via 
iommu_create_device_direct_mappings(), but domain->has_iotlb_device 
should definitely be false at that point :)

Cheers,
Robin.

> Fixes: bf92df30df90 ("intel-iommu: Only avoid flushing device IOTLB for domain ID 0 in caching mode")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
> 
> Change log:
> 
> v2:
>   - Squash two patches into a single one.
>   - No functionality changes.
> 
> v1: https://lore.kernel.org/linux-iommu/20240407144232.190355-1-baolu.lu@linux.intel.com/
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 50eb9aed47cc..681789b1258d 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1501,11 +1501,7 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
>   	else
>   		__iommu_flush_iotlb_psi(iommu, did, pfn, pages, ih);
>   
> -	/*
> -	 * In caching mode, changes of pages from non-present to present require
> -	 * flush. However, device IOTLB doesn't need to be flushed in this case.
> -	 */
> -	if (!cap_caching_mode(iommu->cap) || !map)
> +	if (!map)
>   		iommu_flush_dev_iotlb(domain, addr, mask);
>   }
>   
> @@ -1579,8 +1575,7 @@ static void intel_flush_iotlb_all(struct iommu_domain *domain)
>   			iommu->flush.flush_iotlb(iommu, did, 0, 0,
>   						 DMA_TLB_DSI_FLUSH);
>   
> -		if (!cap_caching_mode(iommu->cap))
> -			iommu_flush_dev_iotlb(dmar_domain, 0, MAX_AGAW_PFN_WIDTH);
> +		iommu_flush_dev_iotlb(dmar_domain, 0, MAX_AGAW_PFN_WIDTH);
>   	}
>   
>   	if (dmar_domain->nested_parent)
