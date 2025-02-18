Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7EE14A0B7
	for <iommu@lists.linux.dev>; Tue, 18 Feb 2025 03:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739847637; cv=none; b=X+e7wAG7RSNNQkR1GeFhYbjc9K7kW64HJgQ2BZwEn0hj+zTOKNSiDUP7SgwAZawY2si3MFGJ+v9/3kqZ59eqg3mR6YknY25xhCarIN/9c+WSYXgLOSxCO3zqgzNoMHQkxNYJ43pta9UJDsUe4BN2x5HJUKEyUZkkGGVMZkWMaNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739847637; c=relaxed/simple;
	bh=vo4iIqOccXJo5BGr+furQ+7eK/ctsfLTpSO/mzH9F9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YXJAnHrDu4dYyX3UYlnerrQFa6HsbCY5+k6VJodvrbLYfrm5YXxcn3lhVctKg1Zl8unEVFMa7g0AuVtAv1jmh6UKiJ1cmk6e8QpKXx2y6C8gXTUitEr1UuBpU2fUUY1s5RJlr/5WNV4kaQOcbAPxYOdF18IvBI64SqbCXbv52Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fM0PmJKM; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fM0PmJKM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739847635; x=1771383635;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vo4iIqOccXJo5BGr+furQ+7eK/ctsfLTpSO/mzH9F9U=;
  b=fM0PmJKMNMn+Fbx7JzTeJWvemZ/TQh+v+eU0FGiAp+qjpDs3KCj1Df6k
   bfvouWzhLgynzGQZVCyrSOLv/I5JCYFM6lRmLaOCjRUPbb+M7BUd2rCGt
   fgMqpriciwAqCDRRemyqtfj9bjuYm/SzDzpDgxZ7+9hJXcUcTqSzV4oWf
   240TvdfwLoQlalP12waBuJVFQZTlS0QPJ3+weVqwicooUtS4CqNpP5EqV
   KEJaJSHH+nYDNC4odMAR1mfIJCPk8+ZcWvgTxJ5cmC+ITJLq0RcGYC+N9
   AowoHSozWNeJYnQd9DOIX7ddP0a/yd4SeEc4U6wtdR+CPl8hz7/zIjNPP
   w==;
X-CSE-ConnectionGUID: NKf76AgxSJ6KXaS9wJiBvg==
X-CSE-MsgGUID: nuHcGlIiTQmLCJqNRo0zOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44457569"
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; 
   d="scan'208";a="44457569"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 19:00:35 -0800
X-CSE-ConnectionGUID: cXOsJFYfSjiWBQAJo3GxvA==
X-CSE-MsgGUID: a2+gEoMbSGGZbPwOXFtWww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; 
   d="scan'208";a="114012065"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 19:00:32 -0800
Message-ID: <59998dcc-9452-4efd-be69-d95754217633@linux.intel.com>
Date: Tue, 18 Feb 2025 10:57:30 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] iommu: Remove IOMMU_DEV_FEAT_SVA/_IOPF
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
 Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
 <CABQgh9FMy7oVt9+enSpJxXvkux+czMFqbsPZVgmBV+rFWWvhGA@mail.gmail.com>
 <20250214125600.GA3696814@ziepe.ca>
 <CABQgh9FQYe46hfjcs+o6GfLaS7OfSqrmvXUzOKd6PRK8oBF8Jw@mail.gmail.com>
 <d578bf4c-f475-42bf-9cb8-21941fc7af88@linux.intel.com>
 <CABQgh9EG3gjtw19qvr7OhxKmR8E6+xwBf9b3=WPNrXRc-m9DjQ@mail.gmail.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CABQgh9EG3gjtw19qvr7OhxKmR8E6+xwBf9b3=WPNrXRc-m9DjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/15/25 19:35, Zhangfei Gao wrote:
> On Sat, 15 Feb 2025 at 18:09, Baolu Lu<baolu.lu@linux.intel.com> wrote:
>> On 2/15/25 16:11, Zhangfei Gao wrote:
>>> It does not relate to multi devices, one device also happens when user
>>> page fault triggers.
>>>
>>> iopf_queue_remove_device is called.
>>> rcu_assign_pointer(param->fault_param, NULL);
>>>
>>> call trace
>>> [  304.961312] Call trace:
>>> [  304.961314]  show_stack+0x20/0x38 (C)
>>> [  304.961319]  dump_stack_lvl+0xc0/0xd0
>>> [  304.961324]  dump_stack+0x18/0x28
>>> [  304.961327]  iopf_queue_remove_device+0xb0/0x1f0
>>> [  304.961331]  arm_smmu_remove_master_domain+0x204/0x250
>>> [  304.961336]  arm_smmu_attach_commit+0x64/0x100
>>> [  304.961338]  arm_smmu_attach_dev_nested+0x104/0x1a8
>>> [  304.961340]  __iommu_attach_device+0x2c/0x110
>>> [  304.961343]  __iommu_device_set_domain.isra.0+0x78/0xe0
>>> [  304.961345]  __iommu_group_set_domain_internal+0x78/0x160
>>> [  304.961347]  iommu_replace_group_handle+0x9c/0x150
>>> [  304.961350]  iommufd_fault_domain_replace_dev+0x88/0x120
>>> [  304.961353]  iommufd_device_do_replace+0x190/0x3c0
>>> [  304.961355]  iommufd_device_change_pt+0x270/0x688
>>> [  304.961357]  iommufd_device_replace+0x20/0x38
>>> [  304.961359]  vfio_iommufd_physical_attach_ioas+0x30/0x78
>>> [  304.961363]  vfio_df_ioctl_attach_pt+0xa8/0x188
>>> [  304.961366]  vfio_device_fops_unl_ioctl+0x310/0x990
>>>
>>>
>>> When page fault triggers:
>>>
>>> [ 1016.383578] ------------[ cut here ]-----------
>>> [ 1016.388184] WARNING: CPU: 35 PID: 717 at
>>> drivers/iommu/io-pgfault.c:231 iommu_report_device_fault+0x2c8/0x470
>> It's likely that iopf_queue_add_device() was not called for this device.
> iopf_queue_add_device is called, but quickly iopf_queue_remove_device
> is called during guest bootup.
> Then fault_param is set to NULL.
> 
> arm_smmu_attach_commit
> arm_smmu_remove_master_domain
> // newly added in the first patch
>         if (master_domain) {
>                    if (master_domain->using_iopf)

It seems the above check is incorrect. We only need to disable iopf when
an iopf-capable domain is about to be removed. Will the following
additional change make any difference?

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c 
b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 28e67a9e3861..9b9ef738d070 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2822,7 +2822,7 @@ static void arm_smmu_remove_master_domain(struct 
arm_smmu_master *master,
         spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);

         if (master_domain) {
-               if (master_domain->using_iopf)
+               if (domain->iopf_handler)
                         arm_smmu_disable_iopf(master);
                 kfree(master_domain);
         }

>                            arm_smmu_disable_iopf(master); ->
> iopf_queue_remove_device
>                    kfree(master_domain);
>            }
> 
> As a comparison, without this patchset, only iopf_queue_add_device is
> called, not call iopf_queue_remove_device

Thanks,
baolu
