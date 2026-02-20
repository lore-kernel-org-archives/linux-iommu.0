Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4777320CA9
	for <iommu@lists.linux.dev>; Fri, 20 Feb 2026 10:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771583672; cv=none; b=uhzMINXPAv1KVP0WPCs2dz1+aiV4Mz/4y+D+ZXcvds/LYe0hEbqg+il+jxj/SvciA2ry1NwW1E4wFrc+tdsr/hDF1zpUkjMfDIKUdsNstHGAk4VaH6S6yf7Hodix4S5sdz+PdA1z6y7hIrAOh+uYYtw3TDeZXUo0ndGGz5Ghi4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771583672; c=relaxed/simple;
	bh=e5mOC5kRmE4+CirNn2OSeEpsuTHS7QzHY5b2INi7QLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MmuOwnnPzOkE8OvWDDSn1NaW9lI8/3tv4yiaTq4LZdpeR1il7l5T0EfEus8qP7XBtAcyVMGEtgCyLmrqvD11D6+emg27sV6gfcUA8OnxyMl+nQgBOxACaJhxwcVHJuSQ8oo34OCq7F4SMqr7jV+pd6UGFs7G8pNKYJ9Lqx442OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE8F5339;
	Fri, 20 Feb 2026 02:34:24 -0800 (PST)
Received: from [10.57.58.244] (unknown [10.57.58.244])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F37093F62B;
	Fri, 20 Feb 2026 02:34:28 -0800 (PST)
Message-ID: <555e100a-b995-47c1-b616-275d2e3b0946@arm.com>
Date: Fri, 20 Feb 2026 10:34:11 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iommu/vt-d: Avoid superfluous IOTLB tracking in lazy
 mode
To: Ferdinand Schober <ferdinand.schober@fau.de>, linux-kernel@vger.kernel.org
Cc: ashok.raj@intel.com, baolu.lu@linux.intel.com, dwmw2@infradead.org,
 iommu@lists.linux.dev, joro@8bytes.org, kevin.tian@intel.com,
 sanjay.k.kumar@intel.com, stable@vger.kernel.org, will@kernel.org,
 yi.l.liu@intel.com
References: <20230209175330.1783556-1-jacob.jun.pan@linux.intel.com>
 <20260220015239.375598-1-ferdinand.schober@fau.de>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260220015239.375598-1-ferdinand.schober@fau.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-02-20 1:52 am, Ferdinand Schober wrote:
> 
> Hi,
> 
> I've stumbled upon this patch trying to figure out how lazy invalidation is implemented in intel IOMMUs.
> The patch suggests that lazy invalidation is active whenever iotlb_gather.queued is set.
> 
> However, the only place in which gather.queued is written seems to be in dma-iommu.c:
> 
> -- drivers/iommu/dma-iommu.c
>   820:	iotlb_gather.queued = READ_ONCE(cookie->fq_domain);
> 2038:	iotlb_gather.queued = free_iova && READ_ONCE(cookie->fq_domain);
> 
> 
> Both of these depend on fq_domain but fq_domain is always NULL for intel iommus,
> since iommu/intel/iommu.c reports IOMMU_CAP_DEFERRED_FLUSH:
> 
> -- drivers/iommu/dma-iommu.c:708
> 	if (domain->type == IOMMU_DOMAIN_DMA_FQ &&
> 	    (!device_iommu_capable(dev, IOMMU_CAP_DEFERRED_FLUSH) || iommu_dma_init_fq(domain)))
> 		domain->type = IOMMU_DOMAIN_DMA;
> 
> 
> (Above line numbers are from Kernel 6.17).
> 
> So I'm not sure, this commit does what it should?
> Please let me know what I'm missing here.

IOMMU_CAP_DEFERRED_FLUSH *is* the "I can usefully support flush queues" 
capability; if that is reported then iommu_dma_init_fq() is called, and 
if that succeeds then fq_domain will have been set. If it fails, or if 
the IOMMU doesn't support flush queues in the first place, then we fall 
back to the regular strict domain type.

Thanks,
Robin.

> 
> Best Regards,
> Ferdinand Schober
> 
> 
> 
> 

