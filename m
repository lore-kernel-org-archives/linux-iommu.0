Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5A8157A72
	for <iommu@lists.linux.dev>; Fri, 18 Jul 2025 02:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752807502; cv=none; b=bZxNw9MlSDD7QZ2LI1S88kkxFSmCXZ/LSEWBmpBWfu/35OdNfQxeFW2TXMpJIsDl3aYZFJY8hSTb0nzGngK97YthTYNMu3YIvEv8ihdxG6z/Ogo/bYr8bMsTkUsmrdtzUJZpk064k0RIf2xHF8sbze8IxqEvCXrcKoJ7O8kAtXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752807502; c=relaxed/simple;
	bh=rZJmkQwqKZ7T7fqYmnIk08peIPBf4DxqJuRD3FWD7TA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uRmIgQgiASdGew0Ro2/PX4D4W1ST/wqKcNnFT/PJcNGWqGOTpluJWJZF6N2S66zmBRKpnyTd/5mKfloKk1oF7NayTPUMJf76ecl/K6mK4hoFjeSF+vdNzM1CLMrCpoaFCols5st3JnNXK7s+912fHqT/LcH52SQz+77Yqwyl+go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jZLudt9C; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jZLudt9C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752807500; x=1784343500;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rZJmkQwqKZ7T7fqYmnIk08peIPBf4DxqJuRD3FWD7TA=;
  b=jZLudt9CFGm8a5Tzv4Zr6dw69gCJd8pI2Gc5WxdCmntStqPkR6pmewY1
   vrBvuhuq4yCdkSprxQ5cKhP8Gbnxb90yYSGEEvOCzJzSHbGrk0V9LH0LJ
   +C4juBs3KlplvtkpdkXmd+LTDV0MjHH8uzReviJUgAjoHV5iLKGpqL3wb
   S3FJcd2P8bfqA6kpoP7k54RPVQ18g724JZDam3l0cNvMlVoalAoGfACvS
   +KfRB9ak9P5bRTCY8HxK4W++FY5LjvvBAHkaZMxkZg9Sfl8+K8FNXK4nU
   0zWxC+J69pgABrunQFXs4D4LvuntcmLSnr0ZovahvKHbJn6A4qOCseoCS
   A==;
X-CSE-ConnectionGUID: FpuprBEKS4qUzoY7OjR4vQ==
X-CSE-MsgGUID: n+v5wSxdRf2i3X5huqA4fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="65669911"
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="65669911"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 19:58:20 -0700
X-CSE-ConnectionGUID: O9utCyDnQPWndaZMOxjZ7A==
X-CSE-MsgGUID: Kd056GL/Qrqj617b6FuwxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="181662494"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 19:58:18 -0700
Message-ID: <3ea54d65-7ccc-479a-8912-bccd79d678d4@linux.intel.com>
Date: Fri, 18 Jul 2025 10:56:24 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] iommu/vt-d: Optimize iotlb_sync_map for
 non-caching/non-RWBF modes
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250714045028.958850-1-baolu.lu@linux.intel.com>
 <20250714045028.958850-3-baolu.lu@linux.intel.com>
 <20250716141218.GA2166806@nvidia.com>
 <8aedbbcc-9f4c-4700-acb7-43ec4f540135@linux.intel.com>
 <20250717115559.GD2177622@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250717115559.GD2177622@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/17/25 19:55, Jason Gunthorpe wrote:
> On Thu, Jul 17, 2025 at 10:40:01AM +0800, Baolu Lu wrote:
>> On 7/16/25 22:12, Jason Gunthorpe wrote:
>>> On Mon, Jul 14, 2025 at 12:50:19PM +0800, Lu Baolu wrote:
>>>> @@ -1833,6 +1845,8 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
>>>>    	if (ret)
>>>>    		goto out_block_translation;
>>>> +	domain->iotlb_sync_map |= domain_need_iotlb_sync_map(domain, iommu);
>>>
>>> This has no locking and is in the wrong order anyhow :(
>>>
>>> Any change to how invalidation works has to be done before attaching
>>> the HW so that the required invalidations are already happening before
>>> the HW can walk the page table.
>>>
>>> And you need to serialize somehow with concurrent map/unmap as iommufd
>>> doesn't prevent userspace from racing attach with map/unmap.
>>
>> domain->iotlb_sync_map does not change the driver's behavior. It simply
>> indicates that there's no need to waste time calling
>> cache_tag_flush_range_np(), as it's just a no-op.
> 
> Of course it changes the behavior, it changes what the invalidation
> callback does.
> 
> Without locking you have a race situation where a PGD is visible to HW
> that requires extra flushing and the SW is not doing the extra
> flushing.
> 
> Before any PGD is made visible to the HW the software must ensure all
> the required invalidations are happening.

Oh, I understand now. If there is no synchronization between attach/
detach and map/unmap operations, the cache invalidation behavior must be
determined when a domain is allocated.

> 
>> I previously discussed this with Kevin, and we agreed on a phase-by-
>> phase approach. As I mentioned, domain->iotlb_sync_map is merely a hint
>> for the driver, preventing it from looping through all cache tags to
>> determine if any cache invalidation work needs to be performed. We
>> already know it's predetermined that no work needs to be done.
> 
> The iteration though the cache tags is done inside a lock so it
> doesn't have this race (it has the issue I mentioned setting up the
> cache tage list though).
> 
>> RWBF is only required on some early implementations where memory
>> coherence was not yet implemented by the VT-d engine. It should be
>> difficult to find such systems in modern environments.
> 
> Then I would set it at domain creation time, check it during attach,
> and remove this race.

How about the following changes (compiled but not tested)?

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 8db8be9b7e7d..bb00dc14275d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1780,18 +1780,6 @@ static int domain_setup_first_level(struct 
intel_iommu *iommu,
  					  __pa(pgd), flags, old);
  }

-static bool domain_need_iotlb_sync_map(struct dmar_domain *domain,
-				       struct intel_iommu *iommu)
-{
-	if (cap_caching_mode(iommu->cap) && intel_domain_is_ss_paging(domain))
-		return true;
-
-	if (rwbf_quirk || cap_rwbf(iommu->cap))
-		return true;
-
-	return false;
-}
-
  static int dmar_domain_attach_device(struct dmar_domain *domain,
  				     struct device *dev)
  {
@@ -1831,8 +1819,6 @@ static int dmar_domain_attach_device(struct 
dmar_domain *domain,
  	if (ret)
  		goto out_block_translation;

-	domain->iotlb_sync_map |= domain_need_iotlb_sync_map(domain, iommu);
-
  	return 0;

  out_block_translation:
@@ -3352,6 +3338,14 @@ intel_iommu_domain_alloc_first_stage(struct 
device *dev,
  		return ERR_CAST(dmar_domain);

  	dmar_domain->domain.ops = &intel_fs_paging_domain_ops;
+	/*
+	 * iotlb sync for map is only needed for legacy implementations that
+	 * explicitly require flushing internal write buffers to ensure memory
+	 * coherence.
+	 */
+	if (rwbf_quirk || cap_rwbf(iommu->cap))
+		dmar_domain->iotlb_sync_map = true;
+
  	return &dmar_domain->domain;
  }

@@ -3386,6 +3380,14 @@ intel_iommu_domain_alloc_second_stage(struct 
device *dev,
  	if (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING)
  		dmar_domain->domain.dirty_ops = &intel_dirty_ops;

+	/*
+	 * Besides the internal write buffer flush, the caching mode used for
+	 * legacy nested translation (which utilizes shadowing page tables)
+	 * also requires iotlb sync on map.
+	 */
+	if (rwbf_quirk || cap_rwbf(iommu->cap) || cap_caching_mode(iommu->cap))
+		dmar_domain->iotlb_sync_map = true;
+
  	return &dmar_domain->domain;
  }

@@ -3446,6 +3448,11 @@ static int 
paging_domain_compatible_first_stage(struct dmar_domain *dmar_domain,
  	if (!cap_fl1gp_support(iommu->cap) &&
  	    (dmar_domain->domain.pgsize_bitmap & SZ_1G))
  		return -EINVAL;
+
+	/* iotlb sync on map requirement */
+	if ((rwbf_quirk || cap_rwbf(iommu->cap)) && !dmar_domain->iotlb_sync_map)
+		return -EINVAL;
+
  	return 0;
  }

@@ -3469,6 +3476,12 @@ paging_domain_compatible_second_stage(struct 
dmar_domain *dmar_domain,
  		return -EINVAL;
  	if (!(sslps & BIT(1)) && (dmar_domain->domain.pgsize_bitmap & SZ_1G))
  		return -EINVAL;
+
+	/* iotlb sync on map requirement */
+	if ((rwbf_quirk || cap_rwbf(iommu->cap) || 
cap_caching_mode(iommu->cap)) &&
+	    !dmar_domain->iotlb_sync_map)
+		return -EINVAL;
+
  	return 0;
  }

-- 
2.43.0

Thanks,
baolu

