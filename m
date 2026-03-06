Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A33371D1C
	for <iommu@lists.linux.dev>; Fri,  6 Mar 2026 07:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772780901; cv=none; b=kHLMhbZghCAwRsAHPR4f8W7WpeCDJXyYeHXiPtDWtQEZYx5xhnL6X4Oi1wRZpy6W0pKX1iu0Z1q/0nN+jQLOgbDJpeitq/WikkS38sK6M3ViybE2yvHn0IIcyBW/oOr44Qo3jfWAbX7S0ASbAMNzQ8ZM+hqPSMGMCFxiCyWpcLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772780901; c=relaxed/simple;
	bh=HxM1onQZsv/gkHN3wcbVvGdFjHvqt3U5VT1vgAqejlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MbCdNgI74FXPIjzKVob+OC8NQoq6SoRzquP98yMK797PY1/P58lvfY7VKnMq3G10bzQ6torQAVmk0K3xttcKWEwhjd1NGz/x1kalVVIAwbiiz2/M7v3GbRpV3ZeT3dUy/xiaPYAkA6FKu1qrkwcoRBBo4lVWx8n4KaFQhaQlKEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iLHnIFml; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iLHnIFml"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772780899; x=1804316899;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HxM1onQZsv/gkHN3wcbVvGdFjHvqt3U5VT1vgAqejlg=;
  b=iLHnIFmlzSN8MkOEZO+nWMfhINjYGb2vDkFC8pKqj4CkqmOfKNKqdsdt
   Q13xsxoQw5ME1fUck8gwRpaPGqpbtWWS5vJfz34CufB9Y8wDN6fbuvdUu
   x9e152ejlJRZbA9kRnLELRNtjfYRWIyjVSGN7P+iKMyxEojX4tF2bRgiJ
   ng4Fr4U2CXlM8WFO3CCk5aVv0JWH1XVADAKDhitmGhPkVPRpLW7WDKdtT
   lwToORELXz6i5/E8EfVsaPsBK0RDXE2uJ6ViF5KzAXjO13tbt7QuQq8fq
   VCgHmfNPimHCslGJHM8pqRr/C+EikoL1eEnQvH3ir6aF4KyBgxhfP/vt1
   A==;
X-CSE-ConnectionGUID: hf5CU6afSUeAt0EmPyXjWw==
X-CSE-MsgGUID: TTLApKsQT1eYmsk4uJt0cA==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="74001968"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="74001968"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 23:08:18 -0800
X-CSE-ConnectionGUID: H7prEQdMT2yPbZebkUG+PQ==
X-CSE-MsgGUID: Mk3vzjpXTA++RW6+bC51BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="223889687"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 23:08:16 -0800
Message-ID: <3a4ba1bb-2c45-465a-b7f4-3b999f33b1a5@linux.intel.com>
Date: Fri, 6 Mar 2026 15:07:34 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/vt-d: fix intel iommu iotlb sync hardlockup and
 retry
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>, dwmw2@infradead.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <BN9PR11MB5276CF1CB3BB86987AAFBCAC8C65A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20260209075953.2253094-1-guanghuifeng@linux.alibaba.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260209075953.2253094-1-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/9/26 15:59, Guanghui Feng wrote:
> Device-TLB Invalidation Response Time-out (ITE) handling was added in
> commit: 6ba6c3a4cacf.
> 
> When an ITE occurs, iommu will sets the ITE (Invalidation Time-out
> Error) field in the Fault Status Register. No new descriptors are
> fetched from the Invalidation Queue until software clears the ITE field
> in the Fault Status Register. Tail pointer Register updates by software
> while the ITE field is Set does not cause descriptor fetches by
> hardware. At the time ITE field is Set, hardware aborts any
> inv_wait_dsc commands pending in hardware and does not increment
> the Invalidation Queue Head register. When software clears the
> ITE field in the Fault Status Register, hardware fetches
> descriptor pointed by the Invalidation Queue Head register.
> 
> But in the qi_check_fault process, it is implemented by default
> according to the 2009 commit: 6ba6c3a4cacf, that is, only one
> struct qi_desc is submitted at a time. A qi_desc request is
> immediately followed by a wait_desc/QI_IWD_TYPE for
> synchronization. Therefore, the IOMMU driver implementation
> considers invalid queue entries at odd positions to be
> wait_desc. After ITE is set, hardware aborts any pending
> inv_wait_dsc commands in hardware. Therefore, qi_check_fault
> iterates through odd-position as wait_desc entries and sets
> desc_status to QI_ABORT. However, the current implementation
> allows multiple struct qi_desc to be submitted simultaneously,
> followed by one wait_desc, so it's no longer guaranteed that
> odd-position entries will be wait_desc. When the number of submitted
> struct qi_desc is even, wait_desc's desc_status will not be set to QI_ABORT,
> qi_check_fault will return 0, and qi_submit_sync will then
> execute in an infinite loop and cause a hard lockup when
> interrupts are disabled and the PCIe device does not respond to
> Device-TLB Invalidation requests.

---

> Additionally, if the device remains online and an IOMMU ITE
> occurs, simply returning -EAGAIN is sufficient. When processing
> the -EAGAIN result, qi_submit_sync will automatically reclaim
> all submitted struct qi_desc and resubmit the requests.
> 
> Through this modification:
> 1. Correctly triggers the resubmission of struct qi_desc when
> an ITE occurs.
> 2. Prevents the IOMMU driver from disabling interrupts and
> executing in an infinite loop within qi_submit_sync when an
> 3. Correctly handling simultaneous requests from multiple CPUs
> and multiple contexts that result in timeouts.

---

The two paragraphs above don't match the code. Would you mind cleaning
them up?

> 
> Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>

Fixes: 8a1d82462540 ("iommu/vt-d: Multiple descriptors per 
qi_submit_sync()")
Cc: stable@vger.kernel.org

> ---
>   drivers/iommu/intel/dmar.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index ec975c73cfe6..6938800e9884 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1314,7 +1314,6 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
>   	if (fault & DMA_FSTS_ITE) {
>   		head = readl(iommu->reg + DMAR_IQH_REG);
>   		head = ((head >> shift) - 1 + QI_LENGTH) % QI_LENGTH;
> -		head |= 1;
>   		tail = readl(iommu->reg + DMAR_IQT_REG);
>   		tail = ((tail >> shift) - 1 + QI_LENGTH) % QI_LENGTH;
>   
> @@ -1331,7 +1330,7 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
>   		do {
>   			if (qi->desc_status[head] == QI_IN_USE)
>   				qi->desc_status[head] = QI_ABORT;
> -			head = (head - 2 + QI_LENGTH) % QI_LENGTH;
> +			head = (head - 1 + QI_LENGTH) % QI_LENGTH;
>   		} while (head != tail);
>   
>   		/*

The code itself looks good to me.

Thanks,
baolu
