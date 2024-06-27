Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7644052F74
	for <iommu@lists.linux.dev>; Thu, 27 Jun 2024 08:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719476511; cv=none; b=N1pgZFYM4ZcMWiPf1qH+87PatrIOyyphC19Izndn0jodpwkAeXYoFFJ/zWtvAZWY1/aekHdiVDab/XVCvKBVUVbV7HoDUw1riT57j9oezoQcAFkxC+GgXZkKtefs5J07E0B1WlaAnk66Q+cymmOdZ7kDFJsnrgGkO+Ia3uDQZXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719476511; c=relaxed/simple;
	bh=aF/z9701/vx7r4HE8CWjsuNICPLRcQEmaUgi1MxOYaQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oe1F96lRkoi5X5QHgtjb+xY+Ylnc7laxNbG0UDw0K/b46lxDub0DAXF0l3sy5ymxVrsWCarVglEVO9WJ+kP2q8yvu5bPazYWaoIyNGD3LK1ypxEHP2tBHjoSEXd8E7oUJVE+fWAAFFkar0EV7hNdNEKATWgxqwKbuwNe/AqlBds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lBav+fy4; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lBav+fy4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719476510; x=1751012510;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aF/z9701/vx7r4HE8CWjsuNICPLRcQEmaUgi1MxOYaQ=;
  b=lBav+fy4oQPOXaGnWHsTWY8AMuFdMxOGM76xf1Hz0pH6zY41tCH11+yd
   rWAOrBJr46B4KQkiel6DET5393BdgnEGptOodY+DdG/MTWqQSMm44Y8Vl
   YDk68giJxEFozpq8psiKl0Zwjv9j0uO1wLsdktMefYVaAVT+cRgnTguRL
   fROdobKiORnS9rBdIMIFxWCAn3AmjgjqYRJ/kOpj9PmUudbOrdCSJY2e5
   yhx3dvm2peWPodjdpL5AccAdlK3ImJgsgLBEDVtp/laI+lMe510ZHT7bC
   HgT6uE7M2WQuRQ4TBy94HFYrhyFE2GZryFmzx45rf+5T7G9Tm+Vpi6ery
   w==;
X-CSE-ConnectionGUID: oZrL8QddRWWm0dRnYbWJOw==
X-CSE-MsgGUID: 8nrOyjdbReSo4FOVhG7YXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="19475692"
X-IronPort-AV: E=Sophos;i="6.08,269,1712646000"; 
   d="scan'208";a="19475692"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 01:21:50 -0700
X-CSE-ConnectionGUID: Z1DfNlJ+S6mb6GgSTs+Iig==
X-CSE-MsgGUID: Xfpz0GiGRF+TDnmW7qQUtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,269,1712646000"; 
   d="scan'208";a="44259763"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.125.248.220]) ([10.125.248.220])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 01:21:48 -0700
Message-ID: <80d727b4-c1eb-49d1-9b4a-ab3f0a4b54e2@linux.intel.com>
Date: Thu, 27 Jun 2024 16:21:45 +0800
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
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527642AD41669FCF390297378CD72@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/6/27 14:08, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Thursday, June 27, 2024 10:31 AM
>>
>> +/*
>> + * Cache invalidations after change in a context table entry that was present
>> + * according to the Spec 6.5.3.3 (Guidance to Software for Invalidations). If
>> + * IOMMU is in scalable mode and all PASID table entries of the device were
>> + * non-present, set affect_domains to true. Otherwise, false.
> 
> if no PASID is present then the flag should be false.
> 
> s/affect_domains/flush_domains/

Yes.

> 
>> + */
>> +void intel_context_flush_present(struct device_domain_info *info,
>> +				 struct context_entry *context,
>> +				 bool affect_domains)
>> +{
>> +	struct intel_iommu *iommu = info->iommu;
>> +	u16 did = context_domain_id(context);
>> +	struct pasid_entry *pte;
>> +	int i;
>> +
>> +	assert_spin_locked(&iommu->lock);
>> +
>> +	/*
>> +	 * Device-selective context-cache invalidation. The Domain-ID field
>> +	 * of the Context-cache Invalidate Descriptor is ignored by hardware
>> +	 * when operating in scalable mode. Therefore the @did value
>> doesn't
>> +	 * matter in scalable mode.
>> +	 */
>> +	iommu->flush.flush_context(iommu, did, PCI_DEVID(info->bus, info-
>>> devfn),
>> +				   DMA_CCMD_MASK_NOBIT,
>> DMA_CCMD_DEVICE_INVL);
>> +
>> +	/*
>> +	 * For legacy mode:
>> +	 * - Domain-selective IOTLB invalidation
>> +	 * - Global Device-TLB invalidation to all affected functions
>> +	 */
>> +	if (!sm_supported(iommu)) {
>> +		iommu->flush.flush_iotlb(iommu, did, 0, 0,
>> DMA_TLB_DSI_FLUSH);
>> +		__context_flush_dev_iotlb(info);
>> +
>> +		return;
>> +	}
>> +
>> +	/*
>> +	 * For scalable mode:
>> +	 * - Domain-selective PASID-cache invalidation to affected domains
>> +	 * - Domain-selective IOTLB invalidation to affected domains
>> +	 * - Global Device-TLB invalidation to affected functions
>> +	 */
>> +	if (affect_domains) {
>> +		for (i = 0; i < info->pasid_table->max_pasid; i++) {
>> +			pte = intel_pasid_get_entry(info->dev, i);
>> +			if (!pte || !pasid_pte_is_present(pte))
>> +				continue;
>> +
>> +			did = pasid_get_domain_id(pte);
>> +			qi_flush_pasid_cache(iommu, did,
>> QI_PC_ALL_PASIDS, 0);
>> +			iommu->flush.flush_iotlb(iommu, did, 0, 0,
>> DMA_TLB_DSI_FLUSH);
>> +		}
>> +	}
>> +
>> +	__context_flush_dev_iotlb(info);
>> +}
>> --
>> 2.34.1
>>
> 
> this change moves the entire cache invalidation flow inside
> iommu->lock. Though the directly-affected operations are not in
> critical path the indirect impact applies to all other paths acquiring
> iommu->lock given it'll be held unnecessarily longer after this
> change.
> 
> If the only requirement of holding iommu->lock is to walk the pasid
> table, probably we can collect a bitmap of DID's in the locked walk
> and then invalidate each in a loop outside of iommu->lock. Here
> we only care about DIDs associated with the old context entry at
> this point. New pasid attach will hit new context entry. Concurrent
> pasid detach then may just come with duplicated invalidations.

The iommu->lock is not only for the PASID table walk. The basic
schematic here is that once a present context table entry is being
changed, all PASID entries should not be altered until all the related
caches have been flushed. This is because the configuration of the
context entry might also impact PASID translation.

Previously, we did not apply this lock because all those cases involved
changing the context entry from present to non-present, and we were
certain that all PASID entries were empty. Now, as we are making it a
generic helper that also serves scenarios where the entry remains
present after the change, we need this lock to ensure that no PASID
entry changes occur at the same time.

Best regards,
baolu
