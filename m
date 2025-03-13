Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4392661B9
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 11:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741864852; cv=none; b=GBJVuPlxBtZgG06METmV38JF50OQfstO2xjYs9zYqGNsTAant7ybYmRqlXHuXWHcxxfwYPXpSb9j308K/98zP9tMw1ciQf0bt8DDhIPGh0/AeJOo9C5m3NN2EZV8mT5fulxO51nqn4Lzyp3rgj+t3kQrf9nddCQb1a36d4KmdPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741864852; c=relaxed/simple;
	bh=7wnkqZcRu1ZH+v/YyXjTSWZVvVAgYi/52fWDQ3YqwW0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NZRvyEdwr1cwI7DfQG/M5FsYCnPhZmuR3L5tx1NtOt5aaS8kID274OFOkOlq4sAYEbIGOsYH/zMbWh8TlqXcurr2VIwybrukc66WVxCZXzPzb3oMd6mcuNfnYWGoP395k7fpyApFJ7QnS93SFTaCOVdQcrvh1bwjHOWYiuG82jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m/1Bc8sF; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m/1Bc8sF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741864849; x=1773400849;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7wnkqZcRu1ZH+v/YyXjTSWZVvVAgYi/52fWDQ3YqwW0=;
  b=m/1Bc8sFLGVdcfUJEgatp4br67JCbuRepSRE8Q+kdmxYLuxBg1ZWlLxC
   VkUfGBdmTeqPWj35sj+KFt84orYrroK8KxIxjriP2WM/F5tCtmd/S4XX4
   HhL8k/uTdf3Ztm3IxGyOdSn6QCpqogHPEEMKxLA+uzI8L60GJCKF+53ob
   hya7J5SrWMzVY4Jy83ow3WUz/5pfdhE29X5FCiow0GwNmBweTcLsisnEo
   LGuL9AyRYfIVRCoIudwsy1Wmtm3DVR5fjQ0M+bz+zdQ7bbJySJmucVpIp
   OXDQi6jnN/SRYhwpdS19mSD3KQt/GaBUNKUIn2Q5npDgLt05iGaMeou1g
   A==;
X-CSE-ConnectionGUID: f5N9Hx9US8aJCdA0Ew+54g==
X-CSE-MsgGUID: UVNq/o4LQoebDOazfKdOog==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="46628395"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="46628395"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 04:20:49 -0700
X-CSE-ConnectionGUID: gBnEKdv+RFu8ffDGHI9O8g==
X-CSE-MsgGUID: C8QiEEMSSpGKVkD5O9P1Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="121422459"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.240.153]) ([10.124.240.153])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 04:20:45 -0700
Message-ID: <b85990db-41f4-41cc-ab5c-0b952becdde7@linux.intel.com>
Date: Thu, 13 Mar 2025 19:20:43 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
 Fenghua Yu <fenghuay@nvidia.com>, Zhou Wang <wangzhou1@hisilicon.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 0/8] iommu: Remove IOMMU_DEV_FEAT_SVA/_IOPF
To: Zhangfei Gao <zhangfei.gao@linaro.org>
References: <20250313051953.4064532-1-baolu.lu@linux.intel.com>
 <CABQgh9HKaDyDQXGB5ZEGg5q4a9ak_8OB9XQ+TpUNcZd_ZMeCAQ@mail.gmail.com>
 <CABQgh9G=7q+FQ0ECZ60UjawgkAM2aeNEb6hXgndEv8S9_4CuPw@mail.gmail.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CABQgh9G=7q+FQ0ECZ60UjawgkAM2aeNEb6hXgndEv8S9_4CuPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/3/13 18:57, Zhangfei Gao wrote:
> On Thu, 13 Mar 2025 at 17:51, Zhangfei Gao<zhangfei.gao@linaro.org> wrote:
>> Hi, Baolu
>>
>> On Thu, 13 Mar 2025 at 13:19, Lu Baolu<baolu.lu@linux.intel.com> wrote:
>>> The new method for driver fault reporting support relies on the domain
>>> to specify a iopf_handler. The driver should detect this and setup the
>>> HW when fault capable domains are attached.
>>>
>>> Move SMMUv3 to use this method and have VT-D validate support during
>>> attach so that all three fault capable drivers have a no-op FEAT_SVA and
>>> _IOPF. Then remove them.
>>>
>>> This was initiated by Jason. I'm following up to remove FEAT_IOPF and
>>> further clean up.
>>>
>>> The whole series is also available at github:
>>> https://github.com/LuBaolu/intel-iommu/commits/iommu_no_feat-v4
>> I got an issue on this branch.
>>
>> Linux 6.14-rc4 + iommu_no_feat-v2
>> drivers/pci/quirks.c
>> quirk_huawei_pcie_sva will set dma-can-stall first
>> arm_smmu_probe_device will check dma-can-stall and set stall_enabled
>> accordingly.
> This working branch arm_smmu_probe_device is called from pci_bus_add_device
> So pci_fixup_device is called first
> 
> [ 1121.314405]  arm_smmu_probe_device+0x48/0x450
> [ 1121.314410]  __iommu_probe_device+0xc4/0x3c8
> [ 1121.314412]  iommu_probe_device+0x40/0x90
> [ 1121.314414]  acpi_dma_configure_id+0xb4/0x100
> [ 1121.314417]  pci_dma_configure+0xf8/0x108
> [ 1121.314421]  really_probe+0x78/0x278
> [ 1121.314425]  __driver_probe_device+0x80/0x140
> [ 1121.314427]  driver_probe_device+0x48/0x130
> [ 1121.314430]  __device_attach_driver+0xc0/0x108
> [ 1121.314432]  bus_for_each_drv+0x8c/0xf8
> [ 1121.314435]  __device_attach+0x104/0x1a0
> [ 1121.314437]  device_attach+0x1c/0x30
> [ 1121.314440]  pci_bus_add_device+0xb8/0x1f0
> [ 1121.314442]  pci_iov_add_virtfn+0x2ac/0x300
> [ 1121.314446]  sriov_enable+0x204/0x468
> [ 1121.314447]  pci_enable_sriov+0x20/0x40
> 
> 
>> This branch
>> arm_smmu_probe_device happens first, when dma-can-stall = 0, so
>> stall_enabled =0.
>> Then drivers/pci/quirks.c: quirk_xxx happens
> This not working branch: Linux 6.14-rc6 + iommu_no_feat-v4
> arm_smmu_probe_device is called by pci_device_add
> Then call pci_bus_add_device -> pci_fixup_device
> 
>    215.072859]  arm_smmu_probe_device+0x48/0x450
> [  215.072871]  __iommu_probe_device+0xc0/0x468
> [  215.072875]  iommu_probe_device+0x40/0x90
> [  215.072877]  iommu_bus_notifier+0x38/0x68
> [  215.072879]  notifier_call_chain+0x80/0x148
> [  215.072886]  blocking_notifier_call_chain+0x50/0x80
> [  215.072889]  bus_notify+0x44/0x68
> [  215.072896]  device_add+0x580/0x768
> [  215.072898]  pci_device_add+0x1e8/0x568
> [  215.072906]  pci_iov_add_virtfn+0x198/0x300
> [  215.072910]  sriov_enable+0x204/0x468
> [  215.072912]  pci_enable_sriov+0x20/0x40
> 
> pci_iov_add_virtfn:
> pci_device_add(virtfn, virtfn->bus);
> pci_bus_add_device(virtfn); -> pci_fixup_device(pci_fixup_final, dev);

This probably is not caused by this patch series. Can you please have a
try with the next branch of iommu tree? Or the latest linux-next tree?

https://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git

Thanks,
baolu
