Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8B418CC0C
	for <iommu@lists.linux.dev>; Fri,  9 Aug 2024 08:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723191368; cv=none; b=ruRwbvwePl1XS9O8o8+ON4NtqwjoyUk4tSkKrMafCbgxrUShwr8zG16x9/8uPilEc6CFoI/4B7BxIbq6bSD6DETMEjG9Gae/fanN80rr/JFVTknIMgSU/mV6zzAqrMgT9lqgusxOA1f20xJc0sAWaX98PoXvmLE6hIkGo4Zha2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723191368; c=relaxed/simple;
	bh=NNUqdHXSWMpCyx8Cf/GL/xeATVkSPf588l/4FAHb9U8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DpbcOuzccOSzURzoTC2cfrxogzYPEL0fgw0TWcvidV8E8zIKBB7tqGMJ8xye53k8lqiAoKWgdxGMvwaCbFbHYe73XcKRr/H0nTqm4UtP/tVYOkT7gfWGF00sdOjDz+pq4HKiC7sOaIR5r9taWBppW7Aj/9ovl0pVFXQ9nGftl4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QT2OSkZ3; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QT2OSkZ3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723191363; x=1754727363;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NNUqdHXSWMpCyx8Cf/GL/xeATVkSPf588l/4FAHb9U8=;
  b=QT2OSkZ3s1QNL6dhjikJgM185UohPxd4R9rHVZXQp/v3QZdh+/dt0kXp
   xhnpot5lgBW8o/rvIssqQpiHhRgIQv2dUZ0rryczhBNOthjsaREPJbKoG
   QVa0iqzB5E3AP5niGs7E9AgYSDm1a4Sn4gbxKXTDBBrKrkHdv3yhoUM/g
   nRQgZ3hnza5xPVWnNRITEYyt1VREF51p+agzaadYi4JaOOTlXdYStKLRA
   jEu9GH/IDPHYujxZ14xFigfYn+YbG9Ayc+CzliIzpRgbcbDw8es0kxYyP
   NoUDCdk4PvJ1vP4FE9bhD9MaNGMEk7/6ind03rkIZTMdaFkW4QVsRLQkZ
   A==;
X-CSE-ConnectionGUID: I2+1GM7WQAihM5i1kbrnUQ==
X-CSE-MsgGUID: 9Ck60fmbTmCnpxHCHm4kVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="38862945"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="38862945"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 01:16:03 -0700
X-CSE-ConnectionGUID: q92lhPNHSi6TgbaNzQAFJw==
X-CSE-MsgGUID: 0YHglm/SSNGUlYQN5X2tdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="95015828"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.229.145]) ([10.124.229.145])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 01:16:00 -0700
Message-ID: <41eda769-f1cf-4e96-9cf7-d74d4802eaf5@linux.intel.com>
Date: Fri, 9 Aug 2024 16:15:58 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] iommu/vt-d: Introduce interfaces for QI batching
 operations
To: Tina Zhang <tina.zhang@intel.com>, Kevin Tian <kevin.tian@intel.com>
References: <20240809025431.14605-1-tina.zhang@intel.com>
 <20240809025431.14605-4-tina.zhang@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240809025431.14605-4-tina.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/9 10:54, Tina Zhang wrote:
> Introduces qi_batch_xxx() interfaces to the VT-d driver to enhance the
> efficiency of IOTLB and Dev-IOTLB invalidation command processing.
> By allowing these commands to be batched together before submission,
> the patch aims to minimize the overhead previously incurred when
> handling these operations individually.
> 
> The addition of qi_batch_add_xxx() functions enable the accumulation of
> invalidation commands into a batch, while the qi_batch_flush_descs()
> function allows for the collective submission of these commands.
> 
> Signed-off-by: Tina Zhang<tina.zhang@intel.com>
> ---
>   drivers/iommu/intel/dmar.c  | 78 +++++++++++++++++++++++++++++++++++++
>   drivers/iommu/intel/iommu.h | 39 +++++++++++++++++++
>   2 files changed, 117 insertions(+)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 64724af1a618..8d55c49382fc 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1636,6 +1636,84 @@ void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
>   	qi_submit_sync(iommu, &desc, 1, 0);
>   }
>   
> +static void qi_batch_increment_index(struct intel_iommu *iommu,
> +					   struct qi_batch *batch)
> +{
> +	if (++batch->index == QI_MAX_BATCHED_DESC_COUNT)
> +		qi_batch_flush_descs(iommu, batch);
> +}
> +
> +void qi_batch_flush_descs(struct intel_iommu *iommu, struct qi_batch *batch)
> +{
> +	if (!batch->index)
> +		return;
> +
> +	qi_submit_sync(iommu, batch->descs, batch->index, 0);
> +
> +	/* Reset the index value and clean the whole batch buffer */
> +	memset(batch, 0, sizeof(struct qi_batch));
> +}
> +
> +void qi_batch_add_iotlb_desc(struct intel_iommu *iommu, u16 did, u64 addr,
> +			     unsigned int size_order, u64 type,
> +			     struct qi_batch *batch)
> +{
> +	qi_desc_iotlb(iommu, did, addr, size_order, type, &(batch->descs[batch->index]));
> +	qi_batch_increment_index(iommu, batch);
> +}
> +
> +void qi_batch_add_dev_iotlb_desc(struct intel_iommu *iommu, u16 sid,
> +				 u16 pfsid, u16 qdep, u64 addr,
> +				 unsigned int mask,
> +				 struct qi_batch *batch)
> +{
> +	/*
> +	 * According to VT-d spec, software is recommended to not submit any Device-TLB
> +	 * invalidation requests while address remapping hardware is disabled.
> +	 */
> +	if (!(iommu->gcmd & DMA_GCMD_TE))
> +		return;
> +
> +	qi_desc_dev_iotlb(sid, pfsid, qdep, addr, mask, &(batch->descs[batch->index]));
> +	qi_batch_increment_index(iommu, batch);
> +}
> +
> +void qi_batch_add_piotlb_desc(struct intel_iommu *iommu, u16 did,
> +			      u32 pasid, u64 addr,
> +			      unsigned long npages, bool ih,
> +			      struct qi_batch *batch)
> +{
> +	/*
> +	 * npages == -1 means a PASID-selective invalidation, otherwise,
> +	 * a positive value for Page-selective-within-PASID invalidation.
> +	 * 0 is not a valid input.
> +	 */
> +	if (!npages)
> +		return;
> +
> +	qi_desc_piotlb(did, pasid, addr, npages, ih, &(batch->descs[batch->index]));
> +	qi_batch_increment_index(iommu, batch);
> +}
> +
> +void qi_batch_add_dev_iotlb_pasid_desc(struct intel_iommu *iommu,
> +				       u16 sid, u16 pfsid,
> +				       u32 pasid,  u16 qdep,
> +				       u64 addr, unsigned int size_order,
> +				       struct qi_batch *batch)
> +{
> +	/*
> +	 * According to VT-d spec, software is recommended to not submit any Device-TLB
> +	 * invalidation requests while address remapping hardware is disabled.
> +	 */
> +	if (!(iommu->gcmd & DMA_GCMD_TE))
> +		return;
> +
> +	qi_desc_dev_iotlb_pasid(sid, pfsid, pasid,
> +				qdep, addr, size_order,
> +				&(batch->descs[batch->index]));
> +	qi_batch_increment_index(iommu, batch);
> +}

How about moving all these helpers into drivers/iommu/intel/cache.c?
It's the only consumer for these helpers, right?

Thanks,
baolu
