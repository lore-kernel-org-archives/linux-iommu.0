Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A4D176ACB
	for <iommu@lists.linux.dev>; Fri,  9 Aug 2024 08:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723191744; cv=none; b=uNkOKekGDKhtzgOUQ/DVr9bBah4aWizaFF2Tf1+lLqrt2smmWbFLHt8h7ZKqbzTVI/JzE1leGMGIfpd0dUpnwSpEXrT1hKp4kav2UFePlvfbasrbhBMOLR1eZ6gxMNQnufg+1mVlJxNnom9sefyedI7Yfk9Bo2sLxeaX8Ykp8ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723191744; c=relaxed/simple;
	bh=7AEHdMbI9dPiNWAmnQSnggKsq9igIUCEtkuoWmoPLHs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IvMcVMFJpbgF/fOHzWyZ83zB6NJOGDknwy8zrLRAQd4SCnGexfuVcx+hl59T50KSZmF1kH5AmOQ2WTPhkCUyg+xow1rEhV855r7YlROTqnb17Fh77mLeRmHc1PmlgsgVW3EzTIZbGfEu+MwkZdZ40Djwx4z/KSip9Hclzh/qpsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NpFSqeEM; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NpFSqeEM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723191743; x=1754727743;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7AEHdMbI9dPiNWAmnQSnggKsq9igIUCEtkuoWmoPLHs=;
  b=NpFSqeEM0XK18V783yNh86Aa4M4BsUvP45XWQPeKBqjuGFMh02nKyksL
   1Et62/z3Q7K7rIk0brF0lSvkwxa8WbMDLnQZMQv3PfWJRGfoGjObSdGLT
   8yLlYv+q0NC9aSv5yoO8Yw+lEW3MKvb2QcgtrhbNgZu/isNau0d3qgerO
   paTVKkUMPGit+MOZIz1XdIKwUeDsObQTNeATkH8WgRrbNKNHblXXoTTmb
   Y0QDoem3pPW9T2jORULPkRi/jFjMgHFl4OQDYfokJkATnuqWq2e/pUOkf
   i1vIxM70YVrsLJ78tMf+SiXyUC8UjD7103W9yxBZfuNs54Qj81GTh3u1R
   w==;
X-CSE-ConnectionGUID: 6nyjtq2/SlmPsxJDVpME+Q==
X-CSE-MsgGUID: uxADp6LQRLi0oXFThpZ1oA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="32764859"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="32764859"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 01:22:22 -0700
X-CSE-ConnectionGUID: klIUwH2bTK+vfSxq9FfQDQ==
X-CSE-MsgGUID: pBFP0nLkQ/KWPEyJ0IVr+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="58058848"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.229.145]) ([10.124.229.145])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 01:22:21 -0700
Message-ID: <284bed78-c9ff-4715-a85e-bf353cabaa22@linux.intel.com>
Date: Fri, 9 Aug 2024 16:22:18 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] vt-d/iommu: Enable batching of IOTLB/Dev-IOTLB
 invalidations
To: Tina Zhang <tina.zhang@intel.com>, Kevin Tian <kevin.tian@intel.com>
References: <20240809025431.14605-1-tina.zhang@intel.com>
 <20240809025431.14605-6-tina.zhang@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240809025431.14605-6-tina.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/9 10:54, Tina Zhang wrote:
> +static inline void handle_batched_iotlb_descs(struct dmar_domain *domain,
> +					 struct cache_tag *tag,
> +					 unsigned long addr,
> +					 unsigned long pages,
> +					 unsigned long mask,
> +					 int ih)
> +{
> +	struct intel_iommu *iommu = tag->iommu;
> +
> +	if (domain->use_first_level) {
> +		qi_batch_add_piotlb_desc(iommu, tag->domain_id,
> +					 tag->pasid, addr, pages,
> +					 ih, domain->qi_batch);
> +	} else {
> +		/*
> +		 * Fallback to domain selective flush if no
> +		 * PSI support or the size is too big.
> +		 */
> +		if (!cap_pgsel_inv(iommu->cap) ||
> +		    mask > cap_max_amask_val(iommu->cap) ||
> +		    pages == -1)
> +			qi_batch_add_iotlb_desc(iommu, tag->domain_id,
> +						0, 0, DMA_TLB_DSI_FLUSH,
> +						domain->qi_batch);
> +		else
> +			qi_batch_add_iotlb_desc(iommu, tag->domain_id,
> +						addr | ih, mask,
> +						DMA_TLB_PSI_FLUSH,
> +						domain->qi_batch);
> +	}
> +
> +}

What if the iommu driver is running on an early or emulated hardware
where the queued invalidation is not supported?

Thanks,
baolu
