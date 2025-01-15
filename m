Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DC93BB54
	for <iommu@lists.linux.dev>; Wed, 15 Jan 2025 05:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736918829; cv=none; b=PDp4eB9UhGOV3mbHHf56hM40lzj/vKMLVfBKU766s8trsaEJMJ4mHvAO0EW9i/CFCmb3X/Qid8iQhpcCNv7QTiIHeozUfngXTfxddiSkHooOMO2Wl0j0V0wzAWHZ1fAg7YJBRwcA9oEnrt4XgSFoAqsnRchtmS7A7tnCspwb2ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736918829; c=relaxed/simple;
	bh=Hl0wAbVjeMsE0UYAxfGU0QJaqVw4O+YeZk+8HYXaDAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RvzQ6yOfF4QaY9S6+adzTZn4NHVsuBrtgDf4SBi2H7rBCx0j5N9Sf3IB8jozEh5QZ6PeQrlAdgMo7Gz2wd63xwIl+iWevTW2g4EbfVr8nYkuqd7Y6DgGNgRtfWrUwUc4KRRUGfKwqkQipAzFDkbVMQGxwmQxPNGHDG09CihQCLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JGlc1ZOe; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JGlc1ZOe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736918828; x=1768454828;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Hl0wAbVjeMsE0UYAxfGU0QJaqVw4O+YeZk+8HYXaDAE=;
  b=JGlc1ZOehQj4BBxtANU25Hb3eQkx2wRKYurqdb5ZF5O6QMUfP8bq6b6Y
   uv0KxujSCrhcig8EqBL1NgHIdL8xuBzqAiAOlZqX6WQVobuYnIK2GME3h
   d2oPWd9Uz6TiMwTXEJxmWLCgY7oD7ktMNj+1mtiXWoTeXBmKiD4oi3C9l
   YrQgEzdnu0r7+6S+Vid3eb15/yuxhwP4UQAYTvSIJ8L3oOW5f9xUUxUE2
   Q985CfvDfBX83khd956o8RasxAPOqplCmJMytRq5LrwpQO1qOxOBoISC9
   Ec4KVRqkRjzMCA3RL6hM0ux4NgMHAliFiJ4CcYk6JJ1isbjH92ixcAlJZ
   Q==;
X-CSE-ConnectionGUID: +GzUVimmSJ+r5EBsmhN0FQ==
X-CSE-MsgGUID: fXLHjU93StGqTaNg4sXTLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="37400271"
X-IronPort-AV: E=Sophos;i="6.12,316,1728975600"; 
   d="scan'208";a="37400271"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 21:27:07 -0800
X-CSE-ConnectionGUID: JcAKRtFiSfq8PL4EJ4TirQ==
X-CSE-MsgGUID: yW2B42wdTfK87TZDaD/LGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="109643919"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 21:27:05 -0800
Message-ID: <1cbee44f-4fce-4e9c-8b95-cd1fa25f5921@linux.intel.com>
Date: Wed, 15 Jan 2025 13:24:53 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rc 2/2] iommufd/fault: Use a separate spinlock to protect
 fault->deliver list
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com
References: <cover.1736894696.git.nicolinc@nvidia.com>
 <56c73c27b572e9c677182e99b5244184bdef7541.1736894696.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <56c73c27b572e9c677182e99b5244184bdef7541.1736894696.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/15/25 07:28, Nicolin Chen wrote:
> The fault->mutex was to serialize the fault read()/write() fops and the
> iommufd_fault_auto_response_faults(). And it was also conveniently used
> to protect fault->deliver in poll() and iommufd_fault_iopf_handler().
> 
> However, copy_from/to_user() may sleep if pagefaults are enabled. Thus,
> they could take a long time to wait for user pages to swap in, blocking
> iommufd_fault_iopf_handler() and its caller that is typically a shared
> IRQ handler of an IOMMU driver, resulting in a potential global DOS.
> 
> Instead of resuing the mutex to protect the fault->deliver list, add a
> separate spinlock to do the job, so iommufd_fault_iopf_handler() would
> no longer be blocked by copy_from/to_user().
> 
> Provide two list manipulation helpers for fault->deliver:
>   - Extract the first iopf_group out of the fault->deliver list
>   - Restore an iopf_group back to the head of the fault->deliver list
> 
> Replace list_first_entry and list_for_each accordingly.
> 
> Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
> Cc:stable@vger.kernel.org
> Suggested-by: Jason Gunthorpe<jgg@nvidia.com>
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> ---
>   drivers/iommu/iommufd/iommufd_private.h | 26 +++++++++++++++
>   drivers/iommu/iommufd/fault.c           | 43 ++++++++++++++-----------
>   2 files changed, 50 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index b6d706cf2c66..d3097c857abf 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -445,12 +445,38 @@ struct iommufd_fault {
>   
>   	/* The lists of outstanding faults protected by below mutex. */

It's better to update above comment as well.

>   	struct mutex mutex;
> +	spinlock_t lock; /* protects the deliver list */
>   	struct list_head deliver;
>   	struct xarray response;
>   
>   	struct wait_queue_head wait_queue;
>   };
>   
> +/* Extract the first node out of the fault->deliver list */
> +static inline struct iopf_group *
> +iommufd_fault_deliver_extract(struct iommufd_fault *fault)
> +{
> +	struct list_head *list = &fault->deliver;
> +	struct iopf_group *group = NULL;
> +
> +	spin_lock(&fault->lock);
> +	if (!list_empty(list)) {
> +		group = list_first_entry(list, struct iopf_group, node);
> +		list_del(&group->node);
> +	}
> +	spin_unlock(&fault->lock);
> +	return group;
> +}
> +
> +/* Restore a node back to the head in fault->deliver */
> +static inline void iommufd_fault_deliver_restore(struct iommufd_fault *fault,
> +						 struct iopf_group *group)
> +{
> +	spin_lock(&fault->lock);
> +	list_add(&fault->deliver, &group->node);

This is not right. It should be

	list_add(&group->node, &fault->deliver);

> +	spin_unlock(&fault->lock);
> +}

Others look good to me. With above addressed,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

