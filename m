Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB3881F
	for <iommu@lists.linux.dev>; Tue,  2 Jul 2024 04:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719895438; cv=none; b=KGKLNuVx+S1JuJ4oRn0sJDroccj+aYN6FEZnSSyXluZewvkSG/NhPrC7gn3RbnmdGjo4aq9s3lOz6uqJe5y4MQ2sXXGVWf4XnkzX+vQkOR63VOKi9A0fMlMlg79BEapvqY8lU3kmV8FUHbJYZuj7FnrDo3b/4ihcKiXU7EUwrQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719895438; c=relaxed/simple;
	bh=U1KMTYoPLKoCRAZBF9O7SRNdvIwfAxTI0LpK7oLh1hM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=J4uXhUpLdklwwRSVTRqcD03+ywmP2o7xHVYyMBLZqisE3pycAWg/6uRN2Dz6dhUrfJcPek5bhFYxd9t6cs+Qan28x0g4U7QQUN3AHwaG2kgR2zNf69vDzSDSlT0zGtSJjXNfaSG0itCBSMZdlZGxpYNpW/JlDdui2oD6TvPa0Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K/DrFhSF; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K/DrFhSF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719895437; x=1751431437;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=U1KMTYoPLKoCRAZBF9O7SRNdvIwfAxTI0LpK7oLh1hM=;
  b=K/DrFhSFGqR55F527aV9J2KpXY2l1sI/o0xdOJmOtrCLfsNuWY5L/Who
   wUjJUr/u8twDRX4xP4JVIqumfoR6WEc6q3rTWdqDw9kLQzeEBxlwfzEVy
   wDonmRlG3JxhJjwk2mCGmiRna9ZHpTAwAG/bQN0xRiDn/XwLhf0Ja5bLW
   +FZgXsxishomCwNmNM2IMdU15M3t52VECM9XFQSyoxj3z+Aa9ljLvO9np
   aKpFMICl2+tkkcD/pPe6rc9IrBTdE/6YzeMxrw8MtPg42YjeRFx7n1Sns
   q1NRnplL4uElgatqPZnB9IxAMu+BVnZl69VAd0xPSnpQzaGu71Obxlnlo
   g==;
X-CSE-ConnectionGUID: DNkUMK5NT+OcdpalJZFJ4w==
X-CSE-MsgGUID: 8BapvcwiRMiI0wTvahS/9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="19949322"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="19949322"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 21:43:45 -0700
X-CSE-ConnectionGUID: nFLlpfeqReGtwzdUUY5pUA==
X-CSE-MsgGUID: FGLn7LxAR9CQ/1WQMDr+tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="45725715"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.237.100]) ([10.124.237.100])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 21:43:44 -0700
Message-ID: <28ade99a-13ad-4b01-aff2-711c006856fd@linux.intel.com>
Date: Tue, 2 Jul 2024 12:43:41 +0800
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
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iommu/vt-d: Add helper to flush caches for context
 change
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20240701112317.94022-1-baolu.lu@linux.intel.com>
 <20240701112317.94022-2-baolu.lu@linux.intel.com>
 <20240701214128.5523a1ea@jacob-builder>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240701214128.5523a1ea@jacob-builder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/7/2 12:41, Jacob Pan wrote:
> On Mon,  1 Jul 2024 19:23:16 +0800, Lu Baolu<baolu.lu@linux.intel.com>
> wrote:
> 
>> +	if (flush_domains) {
>> +		/*
>> +		 * If the IOMMU is running in scalable mode and there
>> might
>> +		 * be potential PASID translations, the caller should
>> hold
>> +		 * the lock to ensure that context changes and cache
>> flushes
>> +		 * are atomic.
>> +		 */
>> +		assert_spin_locked(&iommu->lock);
>> +		for (i = 0; i < info->pasid_table->max_pasid; i++) {
>> +			pte = intel_pasid_get_entry(info->dev, i);
>> +			if (!pte || !pasid_pte_is_present(pte))
>> +				continue;
> Is it worth going through 1M PASIDs just to skip the PASID cache
> invalidation? Or just do the flush on all used DIDs unconditionally.

Currently we don't track all domains attached to a device. If such
optimization is necessary, perhaps we can add it later.

Best regards,
baolu
