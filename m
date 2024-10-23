Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484684C7C
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 04:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729658991; cv=none; b=LVmHktg6XIsR4V6bsvn0TN1MBVPCfSGC/KInQPhgPCnAYg/y53clKngUKqt/9XUW/YkOWpQsGzTZ7qblnTvdZE1hSb1S7vG7tp6YPVBg1DxdX8iScXnJJ+aMHqKiPIhSlsY4W6cCQ43tJHOJQAf8pQqwbxBoHYI2fQpghfrMDV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729658991; c=relaxed/simple;
	bh=f2yXnjITIt85IcBIn57+JEnGX7bPxudFkpc0kQq6JdM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RhSt7wf69TIt1WOTuvF7fPp3fLYTUA4W2/E6o6O86CCWbzgbzdWVVAdOJH8K71crxovW7zmZxIcwKIcQB+l6CudDc/Qt22le/9waFdS9KKOsZcXOrITyyLBdM/grEb+j0gUamWZXyCDPSLdAxnjlOexsI2wrcKpafJFLnwy9aTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bNpELxqX; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bNpELxqX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729658989; x=1761194989;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=f2yXnjITIt85IcBIn57+JEnGX7bPxudFkpc0kQq6JdM=;
  b=bNpELxqXbntBYQMfbkP6IQJ7srmoR34pRKYi7JS4tqt1SHsyhH/6OuN/
   1uuBREPQcfDiNA96JVy3X3irJobfRCG04X+bwyPaETWTCB8OKyktOy2d9
   TICYQrKqMFpdY3SN2RzypH9v0XBTRdHUEM9aF+TeawvkXer8m/0zRsCbN
   P2HWO8Icf5Zt/YcywnQ9Jxpio0+h9Sm7klJXqK/GpcWSRRC8lKxbnOWan
   OMImgZuaYwhSmHbWRobPjEELRhQ4fRNJklBqdQFCOU2xZbTg8DvgpITZP
   B3LaK6mgNZdqQQW2Oy6+LhlV3+3fnrFc80seZT38ZS6/8EVZR49k4g0QC
   w==;
X-CSE-ConnectionGUID: V95cTeytREua+tN6ApFN6A==
X-CSE-MsgGUID: lYxk9qQ/SyuMn5B5AtY2bw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29104547"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29104547"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 21:49:49 -0700
X-CSE-ConnectionGUID: Xa3vEpUyTyWSg/nBXKZ4jA==
X-CSE-MsgGUID: Zgp435YRS3em+cbkWuPnqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="79651501"
Received: from unknown (HELO [10.238.0.51]) ([10.238.0.51])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 21:49:46 -0700
Message-ID: <813d32e8-e84c-4744-bc2c-b76adc10d00f@linux.intel.com>
Date: Wed, 23 Oct 2024 12:49:44 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, dwmw2@infradead.org, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, chao.p.peng@intel.com,
 Kyung Min Park <kyung.min.park@intel.com>
Subject: Re: [PATCH 2/2] iommu/vt-d: Fix checks in pgtable_walk()
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20241022095017.479081-1-zhenzhong.duan@intel.com>
 <20241022095017.479081-3-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241022095017.479081-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/22 17:50, Zhenzhong Duan wrote:
> It's not accurate to dump super page as non-present page,
> meanwhile bit7 in first level page table entry is PAT bit,

Can you please explain how the 'bit7 in first level page table entry' is
relevant to the changes made in this patch?

Also, please make full use of the maximum length of the commit message
line.

> also pointer pte is never NULL in pgtable_walk() context.
> 
> Fixes: 914ff7719e8a ("iommu/vt-d: Dump DMAR translation structure when DMA fault occurs")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 8288b0ee7a61..fec5cc1147f3 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -707,14 +707,14 @@ static void pgtable_walk(struct intel_iommu *iommu, unsigned long pfn,
>   	while (1) {
>   		offset = pfn_level_offset(pfn, level);
>   		pte = &parent[offset];
> -		if (!pte || (dma_pte_superpage(pte) || !dma_pte_present(pte))) {
> +		if (!dma_pte_present(pte)) {
>   			pr_info("PTE not present at level %d\n", level);
>   			break;
>   		}
>   
>   		pr_info("pte level: %d, pte value: 0x%016llx\n", level, pte->val);
>   
> -		if (level == 1)
> +		if (level == 1 || dma_pte_superpage(pte))
>   			break;
>   
>   		parent = phys_to_virt(dma_pte_addr(pte));

Thanks,
baolu
