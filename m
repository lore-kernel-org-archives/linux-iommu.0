Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C482D12ED
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 06:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778655559; cv=none; b=pLtTEKW2RpcMrEaBeME7YtoF39yW5BHnAZT3vnElOmZ5aGUWHUe+VN08lxMikWlcWyFcv5s2aduESBXlLEifWIj3DNOET3hTke3Uba5xJPbWr+epw1G/xlgcA+AKQMTjs2GSVtE9amsfMvAtofEbWlWZZMxp7Xt3JoplXMQpKOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778655559; c=relaxed/simple;
	bh=u/5enIcr7VRpXJQ6J20DXBwlIJBgiLhXA59pBk4Zgz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bGpj59UYr02mZlY6HYAknDPkrZ7n0lq01CEMt2K5nayCQNK1G5dSXYLWKAf6K1oYj/QyD3WIUZeIMyvJYAJqq9SX1qgzRjYYCQmQauC4U6UrseWXgwUBzixXLTNcaEpr63OiVNhBqnid9Lx/VhSYEnwDBBJdswLrUOI9gXRd+xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ko11BalG; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ko11BalG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778655557; x=1810191557;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=u/5enIcr7VRpXJQ6J20DXBwlIJBgiLhXA59pBk4Zgz4=;
  b=ko11BalGt+TPY8zB4armR+lVG7PINOyzmXIfZ3FNCJP8A+W/A8mL2fpq
   8AbNBycJL6+pr6MqJZiWPE/Cjdmo4cFyoMVjoOqbIdqO3C0n3P+/vqDCs
   GTnih+tLpLXtWgAqszVO/skpmpjQg7g/UpfrqK/8f/hBlfR6UTC2hfKrs
   wlBV8W9OX/q2W4r5iI8wPLWN5AUuqGXHAAWMwPGeeH3ED+kBEVSEs2cgU
   f+TgKUJDllTZjy7AK4eJrtGW6iPTp0qY6MYJz3DMCTXjq1X7GnKNuvV1i
   rVgvwaO/DkwjJBhXilD8TNiBifvgfdxz3KcsxDHKFUetiwQyUtsgquAXN
   Q==;
X-CSE-ConnectionGUID: Ml9YtQdFRhW5nXNPJzWMFA==
X-CSE-MsgGUID: BexgVIwZR5exLZEm71nIcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79288067"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="79288067"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 23:59:17 -0700
X-CSE-ConnectionGUID: aEsqia+WRGmzeBnIR9fBCA==
X-CSE-MsgGUID: 8XitU1f/Sb+QM77/oCmPbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="261490423"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 23:59:12 -0700
Message-ID: <da30f8e1-b794-4bcf-9c96-7e38f319cf35@linux.intel.com>
Date: Wed, 13 May 2026 14:58:40 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/9] iommufd: Support a HWPT without an iommu driver
 for noiommu
To: Jacob Pan <jacob.pan@linux.microsoft.com>, linux-kernel@vger.kernel.org,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson <alex@shazbot.org>,
 Joerg Roedel <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>,
 David Matlack <dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>,
 Nicolin Chen <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Yi Liu <yi.l.liu@intel.com>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>, skhawaja@google.com,
 pasha.tatashin@soleen.com, Will Deacon <will@kernel.org>
References: <20260511184116.3687392-1-jacob.pan@linux.microsoft.com>
 <20260511184116.3687392-3-jacob.pan@linux.microsoft.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260511184116.3687392-3-jacob.pan@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/12/26 02:41, Jacob Pan wrote:
> From: Jason Gunthorpe<jgg@nvidia.com>
> 
> Create just a little part of a real iommu driver, enough to
> slot in under the dev_iommu_ops() and allow iommufd to call
> domain_alloc_paging_flags() and fail everything else.
> 
> This allows explicitly creating a HWPT under an IOAS.
> 
> A new Kconfig option IOMMUFD_NOIOMMU is introduced to differentiate
> from the VFIO group/container based noiommu mode.
> 
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>
> Signed-off-by: Jacob Pan<jacob.pan@linux.microsoft.com>
> ---
> v5:
>     - Use the new IOMMUFD_NOIOMMU Kconfig instead of VFIO_NOIOMMU
>     - Use consistent wording referring to VFIO noiommu mode (Kevin)
>     - Copyright date fix (Kevin)
> v4:
>     - Make iommufd_noiommu_ops const
> v3:
>     - Add comment to explain the design difference over the
>       legacy noiommu VFIO code.
> ---
>   drivers/iommu/iommufd/Kconfig           |  13 +++
>   drivers/iommu/iommufd/Makefile          |   1 +
>   drivers/iommu/iommufd/hw_pagetable.c    |  15 +++-
>   drivers/iommu/iommufd/hwpt_noiommu.c    | 102 ++++++++++++++++++++++++
>   drivers/iommu/iommufd/iommufd_private.h |   2 +
>   5 files changed, 131 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/iommu/iommufd/hwpt_noiommu.c
> 
> diff --git a/drivers/iommu/iommufd/Kconfig b/drivers/iommu/iommufd/Kconfig
> index 455bac0351f2..74d6ea5b5b3b 100644
> --- a/drivers/iommu/iommufd/Kconfig
> +++ b/drivers/iommu/iommufd/Kconfig
> @@ -16,6 +16,19 @@ config IOMMUFD
>   	  If you don't know what to do here, say N.
>   
>   if IOMMUFD
> +config IOMMUFD_NOIOMMU
> +	bool
> +	depends on !GENERIC_ATOMIC64 # IOMMU_PT_AMDV1 requires cmpxchg64
> +	select GENERIC_PT
> +	select IOMMU_PT
> +	select IOMMU_PT_AMDV1
> +	help
> +	  Provides a SW-only IO page table for devices without hardware
> +	  IOMMU backing. This uses the AMDV1 page table format for
> +	  IOVA-to-PA lookups only, not for hardware DMA translation.
> +
> +	  Selected by VFIO_CDEV_NOIOMMU. Not intended to be enabled directly.
> +
>   config IOMMUFD_VFIO_CONTAINER
>   	bool "IOMMUFD provides the VFIO container /dev/vfio/vfio"
>   	depends on VFIO_GROUP && !VFIO_CONTAINER
> diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
> index 71d692c9a8f4..67207914bb6e 100644
> --- a/drivers/iommu/iommufd/Makefile
> +++ b/drivers/iommu/iommufd/Makefile
> @@ -10,6 +10,7 @@ iommufd-y := \
>   	vfio_compat.o \
>   	viommu.o
>   
> +iommufd-$(CONFIG_IOMMUFD_NOIOMMU) += hwpt_noiommu.o
>   iommufd-$(CONFIG_IOMMUFD_TEST) += selftest.o
>   
>   obj-$(CONFIG_IOMMUFD) += iommufd.o
> diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
> index fe789c2dc0c9..0ae14cd3fc72 100644
> --- a/drivers/iommu/iommufd/hw_pagetable.c
> +++ b/drivers/iommu/iommufd/hw_pagetable.c
> @@ -8,6 +8,15 @@
>   #include "../iommu-priv.h"
>   #include "iommufd_private.h"
>   
> +static const struct iommu_ops *get_iommu_ops(struct iommufd_device *idev)
> +{
> +	if (IS_ENABLED(CONFIG_IOMMUFD_NOIOMMU) && !idev->igroup->group)
> +		return &iommufd_noiommu_ops;
> +	if (WARN_ON_ONCE(!idev->dev->iommu))
> +		return NULL;
> +	return dev_iommu_ops(idev->dev);
> +}
> +
>   static void __iommufd_hwpt_destroy(struct iommufd_hw_pagetable *hwpt)
>   {
>   	if (hwpt->domain)
> @@ -114,11 +123,13 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
>   				IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
>   				IOMMU_HWPT_FAULT_ID_VALID |
>   				IOMMU_HWPT_ALLOC_PASID;
> -	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
> +	const struct iommu_ops *ops = get_iommu_ops(idev);
>   	struct iommufd_hwpt_paging *hwpt_paging;
>   	struct iommufd_hw_pagetable *hwpt;
>   	int rc;
>   
> +	if (!ops)
> +		return ERR_PTR(-ENODEV);

Nit: it's unnecessary to add this check. get_iommu_ops() will WARN if
ops is NULL. The previous code assumes that ops is always valid and does
not return here. If you want to change this behavior, it’s better to
explain the reasoning in the commit message.

Otherwise it looks good to me.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Thanks,
baolu
