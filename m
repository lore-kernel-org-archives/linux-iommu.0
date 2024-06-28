Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADD2481D7
	for <iommu@lists.linux.dev>; Fri, 28 Jun 2024 11:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719573913; cv=none; b=syJSMC7Qd+/q+tt5FJ2KCgw/2lnyTw+uebg+kVHohbnA95t68mSjC0CkT3hYnfOSq1jdF104Rtp5Lq+A0882C3JPeRQGdldFOZX1DQUkqri3970PhPh1LTopafgw42Hv1UMptSvkw3DfnYRc+KLSjGN/tOm6P3Cs0dveP+s0sJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719573913; c=relaxed/simple;
	bh=zVan0NHkWDffat6lSLM3TgKs5irxqac2uR3WD3BclUI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MyE2YkxvrGXh35yLCAQZ85tr7flVN8NJqHhRaLH79GaUVMIeRf83MpONr4X0eHlvVmX9G9wQ80KMKcfr/AmMOtZePnBjCC/35ap1Bp6Pdt9E8fhkvqxsUOReZ8BvQ9l+cgynjwqcFjLoo7Las4m7hyGP+LjLE7Hr4trplLk2NgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gGKGKKwO; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gGKGKKwO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719573910; x=1751109910;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zVan0NHkWDffat6lSLM3TgKs5irxqac2uR3WD3BclUI=;
  b=gGKGKKwO4gVv8xtKV+ymf0q58pE0PfpwU00RcOYygf+/K05nENRpqrOf
   QUNHF2XW4SE7EkrBEHtgHjcc24TTtwGCUR5RpbFV9m2HKBSB0RyIj/YsX
   cH3IlcLFieX5JzHwiGQvJ8M9XBJMjk9zC47dmh7CuSdSBrGgRwTI1oO5B
   YYvAb6/ZwxKqQQpmGG8kTZI3t7USzoTWC/1Wp2edilRUKMJZO8W0cxmVg
   hCp3ZzaT0GXr3+n/luc+0bccYtdZ3237KAhus5IQcZrdCu2ClJA5drBW4
   PUhC0W77hw8czBKf7JXLx/7A9BAzkH5XwMyUSr0tDS/5BUukpM3womC+4
   w==;
X-CSE-ConnectionGUID: SCH0pTfrTUygfMmGoPTLZA==
X-CSE-MsgGUID: vvgIwSqlTXqWbuaRF0YCEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16428291"
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="16428291"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 04:25:10 -0700
X-CSE-ConnectionGUID: rjlAP/UTQLSfbC2jIrnDPw==
X-CSE-MsgGUID: 8efYNTgTQKux6IzMXd87yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="44548285"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.125.248.220]) ([10.125.248.220])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 04:24:54 -0700
Message-ID: <92346e46-7306-4ed2-ad74-d20b0dbc60a4@linux.intel.com>
Date: Fri, 28 Jun 2024 19:24:51 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] iommu/vt-d: Add helper to flush caches for context
 change
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20240627023121.50166-1-baolu.lu@linux.intel.com>
 <20240627023121.50166-2-baolu.lu@linux.intel.com>
 <BN9PR11MB527642AD41669FCF390297378CD72@BN9PR11MB5276.namprd11.prod.outlook.com>
 <80d727b4-c1eb-49d1-9b4a-ab3f0a4b54e2@linux.intel.com>
 <BN9PR11MB52760D102BD4F0AD7C24BCD58CD02@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52760D102BD4F0AD7C24BCD58CD02@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/6/28 15:43, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Thursday, June 27, 2024 4:22 PM
>>
>> On 2024/6/27 14:08, Tian, Kevin wrote:
>>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>>> Sent: Thursday, June 27, 2024 10:31 AM
>>>>
>>>> + */
>>>> +void intel_context_flush_present(struct device_domain_info *info,
>>>> +				 struct context_entry *context,
>>>> +				 bool affect_domains)
>>>> +{
>>>> +	struct intel_iommu *iommu = info->iommu;
>>>> +	u16 did = context_domain_id(context);
>>>> +	struct pasid_entry *pte;
>>>> +	int i;
>>>> +
>>>> +	assert_spin_locked(&iommu->lock);
>>>> +
>>>> +	/*
>>>> +	 * Device-selective context-cache invalidation. The Domain-ID field
>>>> +	 * of the Context-cache Invalidate Descriptor is ignored by hardware
>>>> +	 * when operating in scalable mode. Therefore the @did value
>>>> doesn't
>>>> +	 * matter in scalable mode.
>>>> +	 */
>>>> +	iommu->flush.flush_context(iommu, did, PCI_DEVID(info->bus, info-
>>>>> devfn),
>>>> +				   DMA_CCMD_MASK_NOBIT,
>>>> DMA_CCMD_DEVICE_INVL);
>>>> +
>>>> +	/*
>>>> +	 * For legacy mode:
>>>> +	 * - Domain-selective IOTLB invalidation
>>>> +	 * - Global Device-TLB invalidation to all affected functions
>>>> +	 */
>>>> +	if (!sm_supported(iommu)) {
>>>> +		iommu->flush.flush_iotlb(iommu, did, 0, 0,
>>>> DMA_TLB_DSI_FLUSH);
>>>> +		__context_flush_dev_iotlb(info);
>>>> +
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	/*
>>>> +	 * For scalable mode:
>>>> +	 * - Domain-selective PASID-cache invalidation to affected domains
>>>> +	 * - Domain-selective IOTLB invalidation to affected domains
>>>> +	 * - Global Device-TLB invalidation to affected functions
>>>> +	 */
>>>> +	if (affect_domains) {
>>>> +		for (i = 0; i < info->pasid_table->max_pasid; i++) {
>>>> +			pte = intel_pasid_get_entry(info->dev, i);
>>>> +			if (!pte || !pasid_pte_is_present(pte))
>>>> +				continue;
>>>> +
>>>> +			did = pasid_get_domain_id(pte);
>>>> +			qi_flush_pasid_cache(iommu, did,
>>>> QI_PC_ALL_PASIDS, 0);
>>>> +			iommu->flush.flush_iotlb(iommu, did, 0, 0,
>>>> DMA_TLB_DSI_FLUSH);
>>>> +		}
>>>> +	}
>>>> +
>>>> +	__context_flush_dev_iotlb(info);
>>>> +}
>>>> --
>>>> 2.34.1
>>>>
>>>
>>> this change moves the entire cache invalidation flow inside
>>> iommu->lock. Though the directly-affected operations are not in
>>> critical path the indirect impact applies to all other paths acquiring
>>> iommu->lock given it'll be held unnecessarily longer after this
>>> change.
>>>
>>> If the only requirement of holding iommu->lock is to walk the pasid
>>> table, probably we can collect a bitmap of DID's in the locked walk
>>> and then invalidate each in a loop outside of iommu->lock. Here
>>> we only care about DIDs associated with the old context entry at
>>> this point. New pasid attach will hit new context entry. Concurrent
>>> pasid detach then may just come with duplicated invalidations.
>>
>> The iommu->lock is not only for the PASID table walk. The basic
>> schematic here is that once a present context table entry is being
>> changed, all PASID entries should not be altered until all the related
>> caches have been flushed. This is because the configuration of the
>> context entry might also impact PASID translation.
> 
> Is it what the spec explicitly requires? My impression was that we
> need to invalidate any cache which may be associated with the old
> context entry, which is not equal to prohibiting PASID entries from
> being changed at the same time (as long as those changes won't
> cause a stale cache entry being active).

No, I didn't find that the VT-d spec explicitly requires this. But
conceptually, the context entry controls features of the whole device,
while pasid entries control the translation on a pasid. The change in
context entry potentially impacts the pasid translation ...

> 
> e.g. let's say this helper collects valid pasid entries (2, 3, 4) and
> associated DIDs (x, y, z) in a locked walk of the pasid table and
> then follows the spec sequence to invalidate the pasid cache
> for (2, 3, 4) and the iotlb for (x, y, z) outside of the lock.
> 
> there could be several concurrent scenarios if iommu->lock is
> only guarded on the pasid table walking:
> 
> 1) pasid entry #1 is torn down before the locked walk. The
> teardown path will invalidate its pasid cache and iotlb properly.
> 2) pasid entry #4 is torn down after the locked walk. Then we may
> see duplicated invalidations both in this helper and in the
> teardown path.
> 3) new pasid attach before locked walk may be associated with
> either old or new context entry, depending on whether it's passed
> the context cache invalidation. In any case it will be captured by
> locked walk and then have related cache invalidated in the helper.
> 4) new pasid attach after locked walk is always safe as related
> cache will only be associated with the new context entry.

... hence, from the driver's point of view, let's start from simplicity
unless there's any real use case.

>>
>> Previously, we did not apply this lock because all those cases involved
>> changing the context entry from present to non-present, and we were
>> certain that all PASID entries were empty. Now, as we are making it a
>> generic helper that also serves scenarios where the entry remains
>> present after the change, we need this lock to ensure that no PASID
>> entry changes occur at the same time.
>>
> 
> Even if we want to do a conservative locking I prefer to not applying
> it to existing paths which clearly have no need for extended lock.
> 
> Then probably making a specific helper for pri flip makes more sense
> than generalizing code to incur unnecessary lock overhead on existing
> paths...

Yes, agreed with you. We don't need to extend this lock mechanism change
to the existing cases where it's unnecessary.

How about below additional changes?

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index c5d9c2283977..523407f6f6b2 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1954,8 +1954,8 @@ static void domain_context_clear_one(struct 
device_domain_info *info, u8 bus, u8

  	context_clear_entry(context);
  	__iommu_flush_cache(iommu, context, sizeof(*context));
-	intel_context_flush_present(info, context, true);
  	spin_unlock(&iommu->lock);
+	intel_context_flush_present(info, context, true);
  }

  static int domain_setup_first_level(struct intel_iommu *iommu,
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 01156135e60f..9a7b5668c723 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -690,8 +690,8 @@ static void device_pasid_table_teardown(struct 
device *dev, u8 bus, u8 devfn)

  	context_clear_entry(context);
  	__iommu_flush_cache(iommu, context, sizeof(*context));
+	spin_unlock(&iommu->lock);
  	intel_context_flush_present(info, context, false);
-	spin_unlock(&iommu->lock);
  }

  static int pci_pasid_table_teardown(struct pci_dev *pdev, u16 alias, 
void *data)
@@ -889,8 +889,6 @@ void intel_context_flush_present(struct 
device_domain_info *info,
  	struct pasid_entry *pte;
  	int i;

-	assert_spin_locked(&iommu->lock);
-
  	/*
  	 * Device-selective context-cache invalidation. The Domain-ID field
  	 * of the Context-cache Invalidate Descriptor is ignored by hardware
@@ -919,6 +917,13 @@ void intel_context_flush_present(struct 
device_domain_info *info,
  	 * - Global Device-TLB invalidation to affected functions
  	 */
  	if (flush_domains) {
+		/*
+		 * If the IOMMU is running in scalable mode and there might
+		 * be potential PASID translations, the caller should hold
+		 * the lock to ensure that context changes and cache flushes
+		 * are atomic.
+		 */
+		assert_spin_locked(&iommu->lock);
  		for (i = 0; i < info->pasid_table->max_pasid; i++) {
  			pte = intel_pasid_get_entry(info->dev, i);
  			if (!pte || !pasid_pte_is_present(pte))

Best regards,
baolu
