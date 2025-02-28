Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3CE191F94
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 03:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740712605; cv=none; b=crVsPfGhBqCygopWApPu85H6p1XH6Pp8nyPPuX3XXyqO1FMTDy7f6eIgXs5G1FQrelbTRtVZA2UD2a0ZPVsOGbDm3+wJhbHX+tzU9oNbDl8P6iPQ3SgT+nhrBNV5DAzAOicDDC7Adeltyc5rhIqd+MIqctylu7BD1jjtSMBUKBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740712605; c=relaxed/simple;
	bh=945iZjBC6be0i+7TRujKrgv5Y70HZgVmXmfGIOQ7IZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RP4WmRIe/aTO/GgK72pDB6eq0nCG7b9cx/B7TfCuFmGrbdxDdSwykneDYvZxu31U7/HGdiJULPNwvHy8wmX7JGaXSCt6iulAKkO7iyeGtcraqwZTcUpMiGL/2nq2f+hInA5pGe2LMGOjCcaGvgZfn0ZcnrnsP+01s0AP5GG4nyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lqQYjhqT; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lqQYjhqT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740712604; x=1772248604;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=945iZjBC6be0i+7TRujKrgv5Y70HZgVmXmfGIOQ7IZk=;
  b=lqQYjhqT6DIcwDxUxZAVGgt3GMaXXeaPHJi8Ct60n7uY2khhC7FZpQwl
   zOwb0Gx/88ifdRz1d1iiy+GWr3fRRQl0K3+BSdT/59gcRznu32xGXL3Jq
   wNUVq0LsDpmRB0cjU/MAboXkosEODvC2B7Sbl0Mqek0rLLKfHkb3QFNNr
   s3vk/AQpcikLm745AR+Hqp0W/lGTVTSKSd34YeYQDWwrzmDdEivJ41nzF
   4aVsrF10tZ/PpdK6KxPM6yFmTdjMSdoTr+2lyZc+54Wv8PuaN4sY4ZQHS
   KKTzVtFcJnRVadbqLcg+3L7XejqxUsf8ZG3r6In72CVpcUkOI50hpQxfl
   g==;
X-CSE-ConnectionGUID: aCeqjXcYTta8I47uuBFbqQ==
X-CSE-MsgGUID: JA83l6cIRpalngfIVsxM8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="40876277"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="40876277"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 19:16:43 -0800
X-CSE-ConnectionGUID: lnBAp3OeSsGMY8TYtxyRqw==
X-CSE-MsgGUID: 8DUBKbovT824AL+9mZx9xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="154397759"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 19:16:41 -0800
Message-ID: <f6d0fcb1-b974-440f-9208-257422bc01a6@linux.intel.com>
Date: Fri, 28 Feb 2025 11:13:23 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] iommu: Add private_data_owner to iommu_domain
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com,
 robin.murphy@arm.com, joro@8bytes.org, will@kernel.org
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1740705776.git.nicolinc@nvidia.com>
 <45c03a1bc86528c9194589cc3a5afe3eb2a15c9e.1740705776.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <45c03a1bc86528c9194589cc3a5afe3eb2a15c9e.1740705776.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/28/25 09:31, Nicolin Chen wrote:
> Steal two bits from the 32-bit "type" in struct iommu_domain to store a
> new tag for private data owned by either dma-iommu or iommufd.
> 
> Set the domain->private_data_owner in dma-iommu and iommufd. These will
> be used to replace the sw_msi function pointer.
> 
> Suggested-by: Jason Gunthorpe<jgg@nvidia.com>
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> ---
>   include/linux/iommu.h                | 7 ++++++-
>   drivers/iommu/dma-iommu.c            | 2 ++
>   drivers/iommu/iommufd/hw_pagetable.c | 3 +++
>   3 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index e93d2e918599..4f2774c08262 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -209,8 +209,13 @@ struct iommu_domain_geometry {
>   #define IOMMU_DOMAIN_PLATFORM	(__IOMMU_DOMAIN_PLATFORM)
>   #define IOMMU_DOMAIN_NESTED	(__IOMMU_DOMAIN_NESTED)
>   
> +#define IOMMU_DOMAIN_DATA_OWNER_NONE (0U)
> +#define IOMMU_DOMAIN_DATA_OWNER_DMA (1U)
> +#define IOMMU_DOMAIN_DATA_OWNER_IOMMUFD (2U)
> +
>   struct iommu_domain {
> -	unsigned type;
> +	u32 type : 30;
> +	u32 private_data_owner : 2;

Is there any special consideration for reserving only 2 bits for the
private data owner? Is it possible to allocate more bits so that it
could be more extensible for the future?

For example, current iommu core allows a kernel device driver to
allocate a paging domain and replace the default domain for kernel DMA.
This suggests the private data owner bits may be needed beyond iommu-dma
and iommufd.

Thanks,
baolu
