Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0312A59
	for <iommu@lists.linux.dev>; Thu, 27 Feb 2025 04:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740629018; cv=none; b=ESjkOkhGYLK2lTOUwp3Nqesue4TEa35rhl/hHUjSp/+V3QQrzw5+l0aRS9jgTnXd/EEyB8HNNNfMdiG+wSvxFUsqj1Wlpt+czScVrEUKnyIVHF8gPgZsi/cJtJ2L8J9aS6rBP/OWuZLUSaiIZ1Ebdd4JOHCwCL39ZOTuDhSeM9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740629018; c=relaxed/simple;
	bh=2bbTH6f1f9kGNQ+GLtPcoWsOeY6gNXU6UGy4sy5Wrlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lpyqypzYcsa0xEz4VfNyLdXRLyZSrSkKHGwI9Dh+RLnEhZlWL4e7THeMxX9bJXAgVrx4BcNQMLZKDa4gtCkuvZjfeCtkw0alaN+4rMT+cGSkFsxHu8+XLWrIUQjl8fwosbTACdQj9ThXxsuszpMX2Kdo3G0TW3Ft1d4posl5Ya4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ix2SB7Wm; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ix2SB7Wm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740629017; x=1772165017;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2bbTH6f1f9kGNQ+GLtPcoWsOeY6gNXU6UGy4sy5Wrlw=;
  b=Ix2SB7Wml4AQnpbdMGdl0C6p0JwQmtYUr0zkbAyMrTLWnWy+4NQhdC1g
   Nqf+xlgu8RjyNIig922wwjbwjeYgbaGEU//bs+o0a31BbA/KlhiL0vOVT
   uSzARgzIcVaglhN9G1LCoWMtljJBpf1iYW+pmV01mz9Cpw7cm/JTifN9l
   pmgIkIBqhGiA9Le76Aw7RvvlebWctOTiDb2dTYAGyQ0ydpcRiQDow1hFS
   f0jLQYuUv5ER1MynIutbLnjwgsrhJRSPhDIjP61EGENkjqrEyBco2Htsp
   OIcNNU9mrjmWIrGnxxwR+wgGVqij1+T6Ruttw1SS7xwk1Jd0VMy47RMaF
   g==;
X-CSE-ConnectionGUID: hKtkNBW2S1Cwt+d5tlrQsg==
X-CSE-MsgGUID: Y6Dd1/10RO2YLle26ci+VQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="41425886"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="41425886"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 20:03:37 -0800
X-CSE-ConnectionGUID: NOS4BGbyRZmy7i5LP+BZhg==
X-CSE-MsgGUID: lwa7GDYOSzyp6DyiPADhpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="116676306"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 20:03:34 -0800
Message-ID: <2c03eeaa-d9c9-4b4a-bf15-c1d1c2a79b36@linux.intel.com>
Date: Thu, 27 Feb 2025 12:00:18 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 09/12] iommufd: Allow allocating PASID-compatible
 domain
To: Yi Liu <yi.l.liu@intel.com>, kevin.tian@intel.com, jgg@nvidia.com
Cc: joro@8bytes.org, iommu@lists.linux.dev, nicolinc@nvidia.com
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-10-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250226114032.4591-10-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/26/25 19:40, Yi Liu wrote:
> The underlying infrastructure has supported the PASID attach and related
> enforcement per the requirement of the IOMMU_HWPT_ALLOC_PASID flag. This
> extends iommufd to support PASID compatible domain requested by userspace
> or the PASID compatible domain allocated in the auto_domain path.
> 
> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
> ---
>   drivers/iommu/iommufd/device.c       | 4 +++-
>   drivers/iommu/iommufd/hw_pagetable.c | 7 ++++---
>   2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index e0f097b04467..afba66211b11 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -735,7 +735,9 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev, ioasid_t pasid,
>   		goto out_unlock;
>   	}
>   
> -	hwpt_paging = iommufd_hwpt_paging_alloc(idev->ictx, ioas, idev, 0,
> +	hwpt_paging = iommufd_hwpt_paging_alloc(idev->ictx, ioas, idev,
> +						pasid != IOMMU_NO_PASID ?
> +						IOMMU_HWPT_ALLOC_PASID : 0,
>   						immediate_attach, NULL);

I still don't have a complete understanding of PASID-compatible domains
and the appropriate policies for attach/detach/replacing. I understand
that it is for the AMD IOMMU, but the AMD iommu driver doesn't yet
support attaching domains other than SVA to a device's PASID.

If that's the case, wouldn't the PASID-compatible domain logic
introduced here a dead code? Why not placing it in a separate series and
test it on real hardware before merging?

Thanks,
baolu
