Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C270B1607AC
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 16:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740758507; cv=none; b=kMfQtR+yjWn/CW/Gp1EEG85k8kpuX8ehhvmowGF5BfkEdjCkYqwq7/+xRXZES2F7u3zw4XZxg+VO+j/+Td3LKwrZUNqJx3qRlofSkapTWt4k/ksrBN1Jwowd0WIz2DwP193iww9XlYrZXSi3V3kTVkcKN0EcD2QZQuU+zNiFPPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740758507; c=relaxed/simple;
	bh=pUJ30oFhCo48SwV5aqPFurAK6czgannmXiqE8JlUSCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VjUQfRgiEB1WfX5lvIRpUX7UHrNihJEI/K5DGG9oadIbnK2IgVFbwYzfNrpbL3MF6IqKoJsQM3aNcbjCBU9kgDnzO2e31SU9Vzix3+1qRGjJPNCUNXm47eJEXvy/mZAfxo+2mn+Rh62eH4XKcicNwBCmjqmeN9li3qepGfDAeCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A411150C;
	Fri, 28 Feb 2025 08:02:00 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A87B3F5A1;
	Fri, 28 Feb 2025 08:01:44 -0800 (PST)
Message-ID: <9ee55e38-b92d-45e1-80df-a6d08c9baccc@arm.com>
Date: Fri, 28 Feb 2025 16:01:43 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Please pull IOMMUFD shared branch
To: Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>
References: <20250228142933.GA105053@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250228142933.GA105053@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/02/2025 2:29 pm, Jason Gunthorpe wrote:
> Hi Joerg,
> 
> As discussed here is the shared branch with the three series.
> 
> Thanks,
> Jason
> 
> The following changes since commit a64dcfb451e254085a7daee5fe51bf22959d52d3:
> 
>    Linux 6.14-rc2 (2025-02-09 12:45:03 -0800)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git tags/for-joerg
> 
> for you to fetch changes up to 5e9f822c9c683ae884fa5e71df41d1647b2876c6:
> 
>    iommu: Swap the order of setting group->pasid_array and calling attach op of iommu drivers (2025-02-28 10:07:14 -0400)
> 
> ----------------------------------------------------------------
> iommu shared branch with iommufd
> 
> The three dependent series on a shared branch:
> 
> - Change the iommufd fault handle into an always present hwpt handle in
>    the domain
> 
> - Give iommufd its own SW_MSI implementation along with some IRQ layer
>    rework
> 
> - Improvements to the handle attach API
> 
> ----------------------------------------------------------------
> Jason Gunthorpe (5):
>        genirq/msi: Store the IOMMU IOVA directly in msi_desc instead of iommu_cookie
>        genirq/msi: Refactor iommu_dma_compose_msi_msg()
>        iommu: Make iommu_dma_prepare_msi() into a generic operation

So we're just merging this anyway despite it getting no review other 
than my objection to it? Oh well...

Robin.

>        irqchip: Have CONFIG_IRQ_MSI_IOMMU be selected by irqchips that need it
>        iommufd: Implement sw_msi support natively
> 
> Nicolin Chen (3):
>        iommufd: Make attach_handle generic than fault specific
>        iommufd/fault: Remove iommufd_fault_domain_attach/detach/replace_dev()
>        iommu: Turn fault_data to iommufd private pointer
> 
> Yi Liu (4):
>        iommu: Make @handle mandatory in iommu_{attach|replace}_group_handle()
>        iommu: Drop iommu_group_replace_domain()
>        iommu: Store either domain or handle in group->pasid_array
>        iommu: Swap the order of setting group->pasid_array and calling attach op of iommu drivers
> 
>   drivers/iommu/Kconfig                   |   1 -
>   drivers/iommu/dma-iommu.c               |  65 +++-----
>   drivers/iommu/iommu-priv.h              |   3 -
>   drivers/iommu/iommu.c                   | 164 +++++++++++++-------
>   drivers/iommu/iommufd/device.c          | 266 +++++++++++++++++++++++++++++---
>   drivers/iommu/iommufd/fault.c           | 130 +---------------
>   drivers/iommu/iommufd/hw_pagetable.c    |   5 +-
>   drivers/iommu/iommufd/iommufd_private.h |  64 ++++----
>   drivers/iommu/iommufd/main.c            |   9 ++
>   drivers/irqchip/Kconfig                 |   4 +
>   drivers/irqchip/irq-gic-v2m.c           |   5 +-
>   drivers/irqchip/irq-gic-v3-its.c        |  13 +-
>   drivers/irqchip/irq-gic-v3-mbi.c        |  12 +-
>   drivers/irqchip/irq-ls-scfg-msi.c       |   5 +-
>   include/linux/iommu.h                   |  56 ++++---
>   include/linux/msi.h                     |  55 ++++---
>   kernel/irq/Kconfig                      |   1 +
>   17 files changed, 501 insertions(+), 357 deletions(-)
