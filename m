Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFA6136A
	for <iommu@lists.linux.dev>; Fri, 26 May 2023 02:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685069046; x=1716605046;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=K2L7F0AhfcD0ID6KXhv9G7ICbjFdlyyMaRSOmispyuA=;
  b=R/AlASW+lVqij8u4gvG/iG2YGhBWig+vVj90iJVHMn0POcu4zUs3gEut
   ML/6YMu99ICkTTNgtVox2rU5yZ5LUvL/qDQ0Vi0VhTRKixdGSCcMfvecF
   lipqlC5fI9ICw9XK7JWMt6W7GX1Ad51hDcPhCVZJxmOfaNL2J+iEkIBYU
   PilpGVta1iwwEvzUqreeOFBoin+n7loyQ2qYaCo4B8FxG/p8EMpt6q2IS
   mSAznOMD+aqstwvi7/CwVa+EEMeZ3T9mG0fa0gEFP7OfDdxRuj2fOQ0bw
   oXpZHlIjMv+DYG4qbqZD41MUClxX3tB7VdtiIpkjy62lwz8v1QYLMQSb0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="352932984"
X-IronPort-AV: E=Sophos;i="6.00,192,1681196400"; 
   d="scan'208";a="352932984"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 19:44:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="1035174118"
X-IronPort-AV: E=Sophos;i="6.00,192,1681196400"; 
   d="scan'208";a="1035174118"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga005.fm.intel.com with ESMTP; 25 May 2023 19:44:00 -0700
Message-ID: <01ed700a-5c20-849e-4f4f-070fc4e1fa12@linux.intel.com>
Date: Fri, 26 May 2023 10:43:14 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc: baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, "Raj, Ashok" <ashok.raj@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Yu, Fenghua" <fenghua.yu@intel.com>,
 "Jiang, Dave" <dave.jiang@intel.com>, "Luck, Tony" <tony.luck@intel.com>,
 "Zanussi, Tom" <tom.zanussi@intel.com>,
 "Ranganathan, Narayan" <narayan.ranganathan@intel.com>
Subject: Re: [PATCH v7 3/4] iommu/vt-d: Add set_dev_pasid callback for dma
 domain
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "vkoul@kernel.org" <vkoul@kernel.org>
References: <20230523173451.2932113-1-jacob.jun.pan@linux.intel.com>
 <20230523173451.2932113-4-jacob.jun.pan@linux.intel.com>
 <BN9PR11MB52760139A4844C8DF0EE1BE98C469@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52760139A4844C8DF0EE1BE98C469@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/25/23 2:56 PM, Tian, Kevin wrote:
>> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Sent: Wednesday, May 24, 2023 1:35 AM
>>
>> @@ -1472,6 +1482,37 @@ static void iommu_flush_dev_iotlb(struct
>> dmar_domain *domain,
>>   	spin_lock_irqsave(&domain->lock, flags);
>>   	list_for_each_entry(info, &domain->devices, link)
>>   		__iommu_flush_dev_iotlb(info, addr, mask);
>> +
>> +	list_for_each_entry(dev_pasid, &domain->dev_pasids, link_domain)
>> {
>> +		info = dev_iommu_priv_get(dev_pasid->dev);
>> +		qi_flush_dev_iotlb_pasid(info->iommu,
>> +					 PCI_DEVID(info->bus, info->devfn),
>> +					 info->pfsid, dev_pasid->pasid,
>> +					 info->ats_qdep, addr,
>> +					 mask);
>> +	}
> 
> Check info->ats_enabled instead of doing it blindly.

Yeah!

> 
>> +static void domain_flush_pasid_iotlb(struct intel_iommu *iommu,
>> +				     struct dmar_domain *domain, u64 addr,
>> +				     unsigned long npages, bool ih)
>> +{
>> +	u16 did = domain_id_iommu(domain, iommu);
>> +	struct dev_pasid_info *dev_pasid;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&domain->lock, flags);
>> +	list_for_each_entry(dev_pasid, &domain->dev_pasids, link_domain)
>> +		qi_flush_piotlb(iommu, did, dev_pasid->pasid, addr, npages,
>> ih);
>> +
>> +	if (!list_empty(&domain->devices))
>> +		qi_flush_piotlb(iommu, did, IOMMU_NO_PASID, addr,
>> npages, ih);
> 
> Old code doesn't have this empty list check. I'm not sure whether any
> corner case might exist but if you do plan to add it it's better to put it
> in a separate patch to allow bisect.

Sure. Better to do it in a separated refactoring patch.

> 
>>   	spin_unlock_irqrestore(&domain->lock, flags);
>>   }
>>
>> @@ -1492,7 +1533,7 @@ static void iommu_flush_iotlb_psi(struct
>> intel_iommu *iommu,
>>   		ih = 1 << 6;
>>
>>   	if (domain->use_first_level) {
>> -		qi_flush_piotlb(iommu, did, IOMMU_NO_PASID, addr, pages,
>> ih);
>> +		domain_flush_pasid_iotlb(iommu, domain, addr, pages, ih);
>>   	} else {
>>   		unsigned long bitmask = aligned_pages - 1;
>>
> 
> Why cannot this pasid be used with a second level config?

Perhaps I didn't get you correctly.

PASID based IOTLB invalidation is only for first level.

Spec 6.5.2.4:

The PASID-based-IOTLB Invalidate Descriptor (p_iotlb_inv_dsc) allows
software to invalidate IOTLB and the paging-structure-caches. This
descriptor is expected to be used when software has changed
first-stage tables and wants to invalidate affected cache entries.

IOTLB invalidation is for second level. See spec 6.5.2.3.

> 
>> @@ -4720,25 +4762,99 @@ static void intel_iommu_iotlb_sync_map(struct
>> iommu_domain *domain,
>>   static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t
>> pasid)
>>   {
>>   	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
>> +	struct dev_pasid_info *curr, *dev_pasid = NULL;
>> +	struct dmar_domain *dmar_domain;
>>   	struct iommu_domain *domain;
>> +	unsigned long flags;
>>
>> -	/* Domain type specific cleanup: */
>>   	domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
>> -	if (domain) {
>> -		switch (domain->type) {
>> -		case IOMMU_DOMAIN_SVA:
>> -			intel_svm_remove_dev_pasid(dev, pasid);
>> -			break;
>> -		default:
>> -			/* should never reach here */
>> -			WARN_ON(1);
>> +	if (!domain)
>> +		goto out_tear_down;
>> +
>> +	/*
>> +	 * The SVA implementation needs to stop mm notification, drain the
>> +	 * pending page fault requests before tearing down the pasid entry.
>> +	 * The VT-d spec (section 6.2.3.1) also recommends that software
>> +	 * could use a reserved domain id for all first-only and pass-through
>> +	 * translations. Hence there's no need to call
>> domain_detach_iommu()
>> +	 * in the sva domain case.
>> +	 */
> 
> It's probably clearer to say:
> 
> /*
>   * SVA domain requires special treatment before tearing down the pasid
>   * entry:
>   *   1) pasid is stored in mm instead of in dev_pasid;
>   *   2) all SVA domains share a reserved domain id per recommendation
>   *      from VT-d spec (section 6.2.3.1) so domain_detach_iommu() is
>   *      not required;
>   *   3) additional cleanup is required e.g. stopping mm notification,
>   *      draining the pending page fault requests, etc.
>   * Better handle it in a separate helper.
>   */

It's better.

>>
>> +static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
>> +				     struct device *dev, ioasid_t pasid)
>> +{
>> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
>> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>> +	struct intel_iommu *iommu = info->iommu;
>> +	struct dev_pasid_info *dev_pasid;
>> +	unsigned long flags;
>> +	int ret;
>> +
>> +	if (!pasid_supported(iommu) || dev_is_real_dma_subdevice(dev))
>> +		return -EOPNOTSUPP;
>> +
>> +	if (context_copied(iommu, info->bus, info->devfn))
>> +		return -EBUSY;
>> +
>> +	ret = prepare_domain_attach_device(domain, dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	dev_pasid = kzalloc(sizeof(*dev_pasid), GFP_KERNEL);
>> +	if (!dev_pasid)
>> +		return -ENOMEM;
> 
> should it check whether this pasid has been attached?

Has been checked by iommu_attach_device_pasid() in core.

> 
>> +
>> +	ret = domain_attach_iommu(dmar_domain, iommu);
>> +	if (ret)
>> +		goto out_free;
>> +
>> +	if (domain_type_is_si(dmar_domain))
>> +		ret = intel_pasid_setup_pass_through(iommu, dmar_domain,
>> +						     dev, pasid);
>> +	else if (dmar_domain->use_first_level)
>> +		ret = domain_setup_first_level(iommu, dmar_domain,
>> +					       dev, pasid);
>> +	else
>> +		ret = intel_pasid_setup_second_level(iommu, dmar_domain,
>> +						     dev, pasid);
> 
> Here you allow attaching pasid to a domain using second-level but all
> prior changes are only for first-level.

As explained, prior changes are for pasid-base iotlb invalidation for
first level page table change. Or perhaps I didn't get you correctly?

Best regards,
baolu
