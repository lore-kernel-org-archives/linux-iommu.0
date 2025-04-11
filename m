Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A2C2572
	for <iommu@lists.linux.dev>; Fri, 11 Apr 2025 01:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744335271; cv=none; b=ZifngpdgKDo2pAMWiet8LCr4/LXRVad3q/+7tiy5iKfKx7xyY+H5Ry7R26tcdpXi+/c0SPgtX1kZEgC4yfVmcWSKr2yh5NGimTvCyxuP1Hv8qZZlYAin8ImgTb5URzQxSNlTwh+qH+Ohm1dSgPmAM/ieOgVBkMQYdLbKT/yKVh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744335271; c=relaxed/simple;
	bh=4r9A1MenU9zKX6egX2Iiqpx8tzE5u/PHT5eSAyMrLos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TiB9bT07t47ypaWuPQ+xZoSHKrI9d86FsJX/GsKJvS5C0JOyZ82RpODg5xCuXubRT/sK+7b/J/fnZnN6TTLAf7tbN2U+UYO9eGUHG9Qtgs5g29s1/DoTA6hK6M5N+Jyx09jWzFflNZcaW5V2r7O6KcyhnHClISpTRrkC6ezFsSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kdzy2goO; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kdzy2goO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744335269; x=1775871269;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4r9A1MenU9zKX6egX2Iiqpx8tzE5u/PHT5eSAyMrLos=;
  b=Kdzy2goOzNBue0VvSwoZSzqt5Y7Pwx0sqOQ9XjFsY3tA31ImKyoAooFT
   dVD0o3UdF52tPKGoAXMTOesyozJnkpw5ZFjWMLrIuT+jT427cVYDtlshM
   /98og32qKiAcn0vhf4wAt/SxgRyZ5m1CQegfoXQbnQVX0ZF1mzm6MkGu6
   IxPk7QglBVNUq5PUan8lIhekI/UzzPESGG8r60AfEV1gPevt6Dh+FfYEZ
   Ovxoe+eZGF/Rz68SSISWFpsdkhJwEJK58VEy7wqvT/ovg48yvwtKr7Cj7
   YN37hBYeMY3g7cNDezdBWmLK0P5T7IKdmjZnyJdDkhjg+YzMoWF6KvHtF
   A==;
X-CSE-ConnectionGUID: fztoDlXSSyitAauOLo5slQ==
X-CSE-MsgGUID: ITwRN/M8TZ+1TtqG/7fcVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="63420147"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="63420147"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 18:34:29 -0700
X-CSE-ConnectionGUID: /HCVeMQoT+GBi+QC4JIjng==
X-CSE-MsgGUID: bkvcaS3fShyZlmmG1FCTbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="134226663"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 18:34:28 -0700
Message-ID: <a0a9861e-699e-4bb9-9e30-09d70cb83644@linux.intel.com>
Date: Fri, 11 Apr 2025 09:30:34 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: Clear IOMMU DMA ops when detaching a device from
 its IOMMU group
To: Chen-Yu Tsai <wenst@chromium.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250410101001.429694-1-wenst@chromium.org>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250410101001.429694-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/10/25 18:09, Chen-Yu Tsai wrote:
> In recent changes to the IOMMU subsystem seen in v6.15-rc1, the process
> and order of how IOMMU linked devices are brought up has changed. Now
> when the IOMMU is probed, the IOMMU subsystem core will attempt to link
> or attach devices described in the device tree as using the IOMMU to
> the IOMMU's associated group or domain. If any part of this fails, the
> whole process is (mostly) undone. The IOMMU failure is then treated as
> a deferred probe; after sufficient time, the deferred probe times out
> and the attached devices are brought out without the IOMMU.
> 
> In the process of undoing changes, one part was missed. When a device
> is initialized for use with the IOMMU, iommu_setup_dma_ops() is also
> called, which signals that DMA operations should go through the IOMMU.
> This part was not reverted when the IOMMU changes were undone. When
> the device later probes without the IOMMU, DMA operations would attempt
> to use IOMMU operations with no IOMMU domain present, causing a crash.
> 
> The above was observed on an MT8188 Chromebook. The MT8188 device tree
> had incorrectly described the IOMMU endpoint for part of its display
> pipeline; the IOMMU driver would successfully attach a couple hardware
> blocks, fail at the incorrectly described one, and roll back all
> changes. Later when the deferred probe times out, the display pipleine
> probes without the IOMMU, but when a framebuffer is allocated, it goes
> through the IOMMU DMA ops, causing a NULL pointer dereference crash.
> 
> Add a helper that is the opposite of iommu_setup_dma_ops(), and call it
> when the IOMMU-enabled device is being detached from its IOMMU.
> 
> Closes:https://lore.kernel.org/all/CAGXv+5HJpTYmQ2h- 
> GD7GjyeYT7bL9EBCvu0mz5LgpzJZtzfW0w@mail.gmail.com/
> Signed-off-by: Chen-Yu Tsai<wenst@chromium.org>
> ---
> This patch should be applied for v6.15. It's not immediately clear to
> me which commit is the actual cause, so I did not add a Fixes tag.

I guess it might be:

Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe 
path")

Or, something near that. Please verify before apply.

> ---
>   drivers/iommu/dma-iommu.c | 5 +++++
>   drivers/iommu/dma-iommu.h | 5 +++++
>   drivers/iommu/iommu.c     | 2 ++
>   3 files changed, 12 insertions(+)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index cb7e29dcac15..62a51d84ffe1 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1739,6 +1739,11 @@ void iommu_setup_dma_ops(struct device *dev)
>   	dev->dma_iommu = false;
>   }
>   
> +void iommu_clear_dma_ops(struct device *dev)
> +{
> +	dev->dma_iommu = false;
> +}
> +
>   static bool has_msi_cookie(const struct iommu_domain *domain)
>   {
>   	return domain && (domain->cookie_type == IOMMU_COOKIE_DMA_IOVA ||
> diff --git a/drivers/iommu/dma-iommu.h b/drivers/iommu/dma-iommu.h
> index eca201c1f963..dfd31cb9e685 100644
> --- a/drivers/iommu/dma-iommu.h
> +++ b/drivers/iommu/dma-iommu.h
> @@ -10,6 +10,7 @@
>   #ifdef CONFIG_IOMMU_DMA
>   
>   void iommu_setup_dma_ops(struct device *dev);
> +void iommu_clear_dma_ops(struct device *dev);
>   
>   int iommu_get_dma_cookie(struct iommu_domain *domain);
>   void iommu_put_dma_cookie(struct iommu_domain *domain);
> @@ -30,6 +31,10 @@ static inline void iommu_setup_dma_ops(struct device *dev)
>   {
>   }
>   
> +static inline void iommu_clear_dma_ops(struct device *dev)
> +{
> +}
> +
>   static inline int iommu_dma_init_fq(struct iommu_domain *domain)
>   {
>   	return -EINVAL;
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index c8033ca66377..498f8f48394c 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -677,6 +677,8 @@ static void __iommu_group_remove_device(struct device *dev)
>   	struct iommu_group *group = dev->iommu_group;
>   	struct group_device *device;
>   
> +	iommu_clear_dma_ops(dev);
> +
>   	mutex_lock(&group->mutex);
>   	for_each_group_device(group, device) {
>   		if (device->dev != dev)

I don't think there needs to be an inline helper for this one-time call.
Perhaps you can simply do it like this:

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index c8033ca66377..cd9d7a0fcaa0 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -536,6 +536,7 @@ static void iommu_deinit_device(struct device *dev)

         /* Caller must put iommu_group */
         dev->iommu_group = NULL;
+       dev->dma_iommu = false;
         module_put(ops->owner);
         dev_iommu_free(dev);
  }

?

Thanks,
baolu
