Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9604BC2D0
	for <iommu@lists.linux.dev>; Wed, 17 Jan 2024 07:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705478386; cv=none; b=IpZpr90x3lDCQc5NEDtqCkCL6o/5/jhEyIgoLMxy6Pvu2QB9G0d1FqOsoOx9DXJlSkPGpD25x94lF0WvVrx0RY/k967C36jxDZWHs06G30qGKoP1JJBjqFbpcS5dIU1NE7+haHU0dD6lzaD361+wf9CVSzdpdpfq4EGvh4Cr27g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705478386; c=relaxed/simple;
	bh=q8c59/EJ5bIt4NOvBoNfCEOa6PuuRucxatD3d6XtNwc=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:Received:Message-ID:Date:MIME-Version:User-Agent:Cc:
	 Subject:Content-Language:To:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding; b=k7A3jwlyEmMsp+tWZmiWXNNDQKBZnX4T/T23f9sh9ZgfXy+cIisy3OL+d/fkmNy5PXzX16sTORDJLbXA32mxJkpemkcYXGPPWwzzkKAt2NMpAo+RHu4GPxtI659Djd3lZIt4iz1Iqo+X8ihdhIXQdeeMscoECECDXxGiAyENNyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Or3gpSa3; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Or3gpSa3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705478384; x=1737014384;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q8c59/EJ5bIt4NOvBoNfCEOa6PuuRucxatD3d6XtNwc=;
  b=Or3gpSa3I4v27TK7/XgSxrozMocpOPdD1FCK3qdsjW7IEmmM5M+OybWJ
   8ofHgYTh0b3MJxU19OVnoDDMc8L3+m6tEYmBk9KB98aWmGv0rAoBKBlBR
   ItzVPEon5Au0NM3rH2MbAONH0BB4AWHpv7rhzeRmfYwfeGLPwzUtxTltP
   2MFxHQtid5Sus85Ln/rityz+5zEp71PgFOCycBY+bBQgeaQnxGLtZpg7m
   lQJngEn5dQf5z/CIL9lVCuvFBzpCCWDE4w2KtTqxetOEFEH+4D8YZhT9X
   gmYLtaVRzVJVYLEgWCHcZJg+iaNBZphpCGW6xjFP5YYYA9LNoU0Ga4wFY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="464386764"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="464386764"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 23:59:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="32748405"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.171.146]) ([10.249.171.146])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 23:59:42 -0800
Message-ID: <a68120c9-9114-4312-b260-6b82303f2ef5@linux.intel.com>
Date: Wed, 17 Jan 2024 15:59:40 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>
Subject: Re: [PATCH 11/11] iommu/vt-d: Remove superfluous IOMMU IOTLB
 invalidations
Content-Language: en-US
To: Tina Zhang <tina.zhang@intel.com>, iommu@lists.linux.dev
References: <20240116011146.18645-1-tina.zhang@intel.com>
 <20240116011146.18645-12-tina.zhang@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240116011146.18645-12-tina.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/1/16 9:11, Tina Zhang wrote:
> Devices behind different IOMMUs can be bound to one sva domain. When a
> range of a sva domain address is being invalidated, VT-d driver needs to
> issue IOMMU IOTLB and Dev-IOTLB invalidation commands to ask IOMMU
> hardware and related devices to invalidate their caches.
> 
> The current logic issues both IOTLB invalidation command and device-TLB
> command per device, which leads to superfluous IOTLB invalidation (e.g.,
> if there are four devices behind a IOMMU are attached to one sva domain.
> In the current logic, during handing intel_invalidate_range(), four IOTLB
> invalidation commands and four Dev-IOTLB invalidation commands will be
> issued. However, only one IOTLB invalidation command and four Dev-IOTLB
> invalidation command are necessary.), and therefore impacts run-time
> performance.
> 
> The patch removes the redundant IOMMU IOTLB invalidations by allowing
> issuing IOMMU IOTLB invalidation command per iommu instead of per device.
> 
> Suggested-by: Sanjay Kumar<sanjay.k.kumar@intel.com>
> Signed-off-by: Tina Zhang<tina.zhang@intel.com>
> ---
>   drivers/iommu/intel/svm.c | 53 ++++++++++++++++++---------------------
>   1 file changed, 25 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 79d1f3107847..bf4962eb229c 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -134,31 +134,39 @@ void intel_svm_check(struct intel_iommu *iommu)
>   	iommu->flags |= VTD_FLAG_SVM_CAPABLE;
>   }
>   
> -static void __flush_svm_range_dev(struct dmar_domain *domain,
> -				  struct dev_pasid_info *dev_pasid,
> +static void __flush_svm_range(struct iommu_domain *domain,
>   				  unsigned long address,
>   				  unsigned long pages, int ih)
>   {
> -	struct device_domain_info *info = dev_iommu_priv_get(dev_pasid->dev);
> -	u32 pasid = mm_get_enqcmd_pasid(domain->domain.mm);
> +	u32 pasid = mm_get_enqcmd_pasid(domain->mm);
> +	struct device_domain_info *dev_info;
> +	struct iommu_domain_info *iommu_info;
> +	struct dev_pasid_info *dev_pasid;
> +	unsigned long idx;
>   
>   	if (WARN_ON(!pages))
>   		return;
>   
> -	qi_flush_piotlb(info->iommu, dev_pasid->did, pasid, address, pages, ih);
> -	if (info->ats_enabled) {
> -		qi_flush_dev_iotlb_pasid(info->iommu, dev_pasid->sid, info->pfsid,
> -					 pasid, dev_pasid->qdep, address,
> -					 order_base_2(pages));
> -		quirk_extra_dev_tlb_flush(info, address, order_base_2(pages),
> -					  pasid, dev_pasid->qdep);
> +	rcu_read_lock();
> +	xa_for_each(&to_dmar_domain(domain)->iommu_array, idx, iommu_info)
> +		qi_flush_piotlb(iommu_info->iommu, dev_pasid->did,
> +				pasid, address, pages, ih);

The xa_array for iommu is already broken. We should fix it before
further use.

https://lore.kernel.org/linux-iommu/20240103124403.GM50406@nvidia.com/

Best regards,
baolu
