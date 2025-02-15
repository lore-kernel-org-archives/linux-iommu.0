Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E85E19F127
	for <iommu@lists.linux.dev>; Sat, 15 Feb 2025 10:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739614153; cv=none; b=cuRRdvz6rDxfXc6iTFBzJJGtBijmZhsS8aoJN7dsz0umRUuEy1oWGPoO4KayBQFOiZ2N/VNj4R0yss5WKqIeBC+dCRzl1Eq2+kYbO8sVpzsv/2aTolfDu760nSNMWLwNQ2c1PSQ9xfbZSnMepivZ5jBOzhMuRILNNN6QaTXUHB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739614153; c=relaxed/simple;
	bh=xH3ekLyCUJXjtIM6uXeT6Wz5TQoPzfdJQKog0Ix76xE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pXjeizcCDPYrEXAk7eJbabTBjO+iAgCUTXX5E/LQLGjbEj3USCRUlR9ZWiIAkyw6+N14sl8v+5i120ohU2mB++pFrGDE+lno3/u7nVjeSVbfuWsoZRpmdjv1eBaqSRX+/hBgNtVFYKJEarum9hZFWdsWB5jfr0pGsUCAgnyLRs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E/YIaglY; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E/YIaglY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739614152; x=1771150152;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xH3ekLyCUJXjtIM6uXeT6Wz5TQoPzfdJQKog0Ix76xE=;
  b=E/YIaglYoP0QORFb/UHCQq/i4IHjVX8W7kUgJAeDwIpTZzHqBVz9hz13
   7nodmRHB2giVlHqq9aNLQJenLaFajXCu8tqpL6e8IZ5otTzS+MhY/zzht
   lX5SHHOqVx5S++b6tZmjMYEN6swLqy2VmCf1OgnJitEh+IjNzd800KSOc
   Y/67GEnoc05yaMd9GK8VigeLImvaUI3PKgeh1QLl7hxxjn4FdSw1qtcAA
   L5+NLcs8wQA8YscT7nPBZlvJGHO1FsSbW9beCysVRntSZU3B4WOjcWrWc
   2Dvjgk5P3LvN1GwljTiWaYo1oSCuBShggN34LvHHIh5yTRYUDFRDkvpCQ
   w==;
X-CSE-ConnectionGUID: 3UK6IHfMTQGa6ij3Et1n5Q==
X-CSE-MsgGUID: TREDN4+CRFO/nYR+KTqkqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40628889"
X-IronPort-AV: E=Sophos;i="6.13,288,1732608000"; 
   d="scan'208";a="40628889"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 02:09:11 -0800
X-CSE-ConnectionGUID: cSns9aWoTzGhPl1aIFPH/A==
X-CSE-MsgGUID: IixXSpCuR9CDqZiOuF0NHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,288,1732608000"; 
   d="scan'208";a="114186845"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 02:09:09 -0800
Message-ID: <d578bf4c-f475-42bf-9cb8-21941fc7af88@linux.intel.com>
Date: Sat, 15 Feb 2025 18:06:11 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] iommu: Remove IOMMU_DEV_FEAT_SVA/_IOPF
To: Zhangfei Gao <zhangfei.gao@linaro.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Vinod Koul <vkoul@kernel.org>, Zhou Wang <wangzhou1@hisilicon.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
 <CABQgh9FMy7oVt9+enSpJxXvkux+czMFqbsPZVgmBV+rFWWvhGA@mail.gmail.com>
 <20250214125600.GA3696814@ziepe.ca>
 <CABQgh9FQYe46hfjcs+o6GfLaS7OfSqrmvXUzOKd6PRK8oBF8Jw@mail.gmail.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CABQgh9FQYe46hfjcs+o6GfLaS7OfSqrmvXUzOKd6PRK8oBF8Jw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/15/25 16:11, Zhangfei Gao wrote:
> It does not relate to multi devices, one device also happens when user
> page fault triggers.
> 
> iopf_queue_remove_device is called.
> rcu_assign_pointer(param->fault_param, NULL);
> 
> call trace
> [  304.961312] Call trace:
> [  304.961314]  show_stack+0x20/0x38 (C)
> [  304.961319]  dump_stack_lvl+0xc0/0xd0
> [  304.961324]  dump_stack+0x18/0x28
> [  304.961327]  iopf_queue_remove_device+0xb0/0x1f0
> [  304.961331]  arm_smmu_remove_master_domain+0x204/0x250
> [  304.961336]  arm_smmu_attach_commit+0x64/0x100
> [  304.961338]  arm_smmu_attach_dev_nested+0x104/0x1a8
> [  304.961340]  __iommu_attach_device+0x2c/0x110
> [  304.961343]  __iommu_device_set_domain.isra.0+0x78/0xe0
> [  304.961345]  __iommu_group_set_domain_internal+0x78/0x160
> [  304.961347]  iommu_replace_group_handle+0x9c/0x150
> [  304.961350]  iommufd_fault_domain_replace_dev+0x88/0x120
> [  304.961353]  iommufd_device_do_replace+0x190/0x3c0
> [  304.961355]  iommufd_device_change_pt+0x270/0x688
> [  304.961357]  iommufd_device_replace+0x20/0x38
> [  304.961359]  vfio_iommufd_physical_attach_ioas+0x30/0x78
> [  304.961363]  vfio_df_ioctl_attach_pt+0xa8/0x188
> [  304.961366]  vfio_device_fops_unl_ioctl+0x310/0x990
> 
> 
> When page fault triggers:
> 
> [ 1016.383578] ------------[ cut here ]-----------
> [ 1016.388184] WARNING: CPU: 35 PID: 717 at
> drivers/iommu/io-pgfault.c:231 iommu_report_device_fault+0x2c8/0x470

It's likely that iopf_queue_add_device() was not called for this device.

Thanks,
baolu
