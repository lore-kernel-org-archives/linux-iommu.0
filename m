Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB81629CFE
	for <iommu@lists.linux.dev>; Tue,  2 Jul 2024 02:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719889016; cv=none; b=tZL3VaMknHR13Fjw34CSaI+yrvIYHGIpwO8nK/LpI+IbK4JZB07PpoHeyjzduKT1LePR4wvWFdhgLdCk3MbKGu2i1EGxHmZzJiiSA5sMRXK0czdubFEA+6aaUg08C68zcnUcKU/Cw9S/X98oEtGim+1lb20C4n2WjoSC6IpD/x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719889016; c=relaxed/simple;
	bh=PJeB1T6WtFGRGHqRWzoEPRuTK3UanbHnCIilELdSNEA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XwIeIenw926IwBntc+k7d3K0uH48tXlcu+FRP7dmwgQ1QD8t3cetWTB3w5fIu8NCBGby8/9+hiLEMXjoVSW21K1faJ2T4hCBMktpMn3lWorUkqmejJ5M8hc9+qozZAj5hkv5E7pgYh/6D6Yc8DQSSezx4zH6Ocm1BJQpQkhl5eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pmn4rVl5; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pmn4rVl5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719889014; x=1751425014;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PJeB1T6WtFGRGHqRWzoEPRuTK3UanbHnCIilELdSNEA=;
  b=Pmn4rVl5yKVYdC71KyN/P9yegbx0VZ7H0NHnV3EICcyjhxX3eW2PzdMm
   YuJSnVdqDCYm0rCS/+6HRPZTjiq3zCahIIKkrRPBwqvJqdfbV7ErsASpR
   eTnYG4oKj8FG7oi3Rm/m4aWh1xJu5mGLCnkBj8sffZLDd1cWuoowdskPo
   zczUoYUn/tdMonO8M6e+xPH03Ps2wprIeVYCACrEj8MOOawcxDgdj+NrW
   QLDeT/x63rrULB28k26Q/wsz8jgTFAzq627qyPLMGIVj4doyt9TYdbhCM
   ttKYCFEbyOfdR1Rdbv+NlhYCeYKGP0O9mX1tIQGk0l4NhaUxjBcEDlkxU
   Q==;
X-CSE-ConnectionGUID: mIfdIHrhT2SI5aHg0pWGEQ==
X-CSE-MsgGUID: 2IotXd8zQru/i8vz5RXZKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="17171748"
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="17171748"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 19:56:54 -0700
X-CSE-ConnectionGUID: jv1h/Hj1Tsi9eKZnFDIjjg==
X-CSE-MsgGUID: 7c35zjW2RfmY6UoGVFRosw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="50598103"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa003.jf.intel.com with ESMTP; 01 Jul 2024 19:56:52 -0700
Message-ID: <663b7309-31e6-4b60-a792-b7aca77c190d@linux.intel.com>
Date: Tue, 2 Jul 2024 10:54:09 +0800
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
Subject: Re: [PATCH v2 1/2] iommu/vt-d: Add helper to flush caches for context
 change
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20240627023121.50166-1-baolu.lu@linux.intel.com>
 <20240627023121.50166-2-baolu.lu@linux.intel.com>
 <20240701172319.264e718c@jacob-builder>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240701172319.264e718c@jacob-builder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/2/24 8:23 AM, Jacob Pan wrote:
> On Thu, 27 Jun 2024 10:31:20 +0800, Lu Baolu<baolu.lu@linux.intel.com>
> wrote:
> 
>> +/*
>> + * Cache invalidations after change in a context table entry that was
>> present
>> + * according to the Spec 6.5.3.3 (Guidance to Software for
>> Invalidations). If
>> + * IOMMU is in scalable mode and all PASID table entries of the device
>> were
>> + * non-present, set affect_domains to true. Otherwise, false.
>> + */
> The spec says:
> "Domain-selective PASID-cache invalidation to affected domains (can be
> skipped if all PASID entries were not-present and CM=0)"
> 
> So we should skip PASID cache invalidation if affect_domain is true
> according to this comment.
> 
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
>> +	 * Device-selective context-cache invalidation. The Domain-ID
>> field
>> +	 * of the Context-cache Invalidate Descriptor is ignored by
>> hardware
>> +	 * when operating in scalable mode. Therefore the @did value
>> doesn't
>> +	 * matter in scalable mode.
>> +	 */
>> +	iommu->flush.flush_context(iommu, did, PCI_DEVID(info->bus,
>> info->devfn),
>> +				   DMA_CCMD_MASK_NOBIT,
>> DMA_CCMD_DEVICE_INVL); +
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
>> +	 * - Domain-selective PASID-cache invalidation to affected
>> domains
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
> This is conflicting with the comments above where PASID cache flush can be
> skipped if affect_domain==true, no?

Yes. I have fixed it in the v3.

Best regards,
baolu
