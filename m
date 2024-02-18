Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3584D52D
	for <iommu@lists.linux.dev>; Sun, 18 Feb 2024 09:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708247955; cv=none; b=TyIQ/fjRVi2Nzvo7OspewiLvCMk3Sy30dxrXrwzzQd0/PrQdDky5ZMPCiM+Ip5heEECachrRxHkr66xE9qafuL+aVOdnMQ2thuGPMMtURZwkZuzLnfa7vhnBbDqXq3+/3/0vA77XqEEXyO1LQ9WBiSf6/tg0WbebIX4a9CPj69A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708247955; c=relaxed/simple;
	bh=ObU1pQt+jiF58irny4q1KSiV7qQCUauMRrwnSEE4qFg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oxkrzlGqC/XkOzsmpJfELmRZD+bmVYW14w7nbzSzdMDoHlvp+0peqxZgHmpSHP1MwKzXIsDa42gIEbXAOcaH6rjcToriDzvTQ+y9Ff73lB0/6vBldOlQ34kP4mSBLjnnL4zh2t4RobBtAJN0epfOqrb0IK68CB+abYAzqSa0XrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B7Iglfdn; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B7Iglfdn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708247954; x=1739783954;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ObU1pQt+jiF58irny4q1KSiV7qQCUauMRrwnSEE4qFg=;
  b=B7IglfdnU7rd+YDPx9GL+Ed0r7/P8WmOSVvkZjP2UlwMUzS6XfAO6UQD
   ezDRTaKTrbZkfIb+1+lE8BTBJ5sSjOoLRkaeqs6MRKe8CJda51MG9R2C8
   ShrXfzq0Kq5sykyQAWq9xKAmL2PYnVQzpBEGlQ0C1zTdeExvdy/iweVIE
   bEULe64E12K0pIyJYmK3O3LVGcxwoU56ef8Moz2tlr5dJLi+BQjPzQDjC
   hwlFJ8RlVc5cxGaJzrb86R3n9Tj2g4kl+bLrmamLGEJ0eLmFlsd0tu+PU
   hp7A0jNO0ch5iu60v+LA3r1KkYX9MCDrcxHWv8gj67ecytnnR86W6iheV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="24801681"
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="24801681"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 01:19:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="4523740"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.209.212]) ([10.254.209.212])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 01:19:11 -0800
Message-ID: <7afa0043-5230-42f7-947a-ee0e88358edf@linux.intel.com>
Date: Sun, 18 Feb 2024 17:19:09 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH 11/11] iommu/vt-d: Remove superfluous IOMMU IOTLB
 invalidations
Content-Language: en-US
To: "Zhang, Tina" <tina.zhang@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20240116011146.18645-1-tina.zhang@intel.com>
 <20240116011146.18645-12-tina.zhang@intel.com>
 <a68120c9-9114-4312-b260-6b82303f2ef5@linux.intel.com>
 <MW5PR11MB5881721113BCB56830201188894C2@MW5PR11MB5881.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <MW5PR11MB5881721113BCB56830201188894C2@MW5PR11MB5881.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/16 13:38, Zhang, Tina wrote:
>>> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
>>> index 79d1f3107847..bf4962eb229c 100644
>>> --- a/drivers/iommu/intel/svm.c
>>> +++ b/drivers/iommu/intel/svm.c
>>> @@ -134,31 +134,39 @@ void intel_svm_check(struct intel_iommu *iommu)
>>>    	iommu->flags |= VTD_FLAG_SVM_CAPABLE;
>>>    }
>>>
>>> -static void __flush_svm_range_dev(struct dmar_domain *domain,
>>> -				  struct dev_pasid_info *dev_pasid,
>>> +static void __flush_svm_range(struct iommu_domain *domain,
>>>    				  unsigned long address,
>>>    				  unsigned long pages, int ih)
>>>    {
>>> -	struct device_domain_info *info = dev_iommu_priv_get(dev_pasid-
>>> dev);
>>> -	u32 pasid = mm_get_enqcmd_pasid(domain->domain.mm);
>>> +	u32 pasid = mm_get_enqcmd_pasid(domain->mm);
>>> +	struct device_domain_info *dev_info;
>>> +	struct iommu_domain_info *iommu_info;
>>> +	struct dev_pasid_info *dev_pasid;
>>> +	unsigned long idx;
>>>
>>>    	if (WARN_ON(!pages))
>>>    		return;
>>>
>>> -	qi_flush_piotlb(info->iommu, dev_pasid->did, pasid, address, pages, ih);
>>> -	if (info->ats_enabled) {
>>> -		qi_flush_dev_iotlb_pasid(info->iommu, dev_pasid->sid, info-
>>> pfsid,
>>> -					 pasid, dev_pasid->qdep, address,
>>> -					 order_base_2(pages));
>>> -		quirk_extra_dev_tlb_flush(info, address, order_base_2(pages),
>>> -					  pasid, dev_pasid->qdep);
>>> +	rcu_read_lock();
>>> +	xa_for_each(&to_dmar_domain(domain)->iommu_array, idx,
>> iommu_info)
>>> +		qi_flush_piotlb(iommu_info->iommu, dev_pasid->did,
>>> +				pasid, address, pages, ih);
>> The xa_array for iommu is already broken. We should fix it before further use.
>>
>> https://lore.kernel.org/linux-iommu/20240103124403.GM50406@nvidia.com/
> Agree that domain->iommu_array needs to protect the element (struct iommu_domain_info) from UAF as well. This could be another topic.
> 
> I realize that we don't need to use domain->iommu_array here. What we want here is a pointer pointing to a struct intel_iommu. We can get the info from device using dev_iommu_priv_get(), instead of getting the info from iommu_array.
> 
> Besides, I'm thinking about sorting the domain->dev_pasids in intel_iommu_set_dev_pasid() to make struct dev_pasid_info of the devices behind the same IOMMU stay together. It can be helpful to reduce the redundant IOMMU IOTLB invalidations.

I think what you want here are the {domain_id, pasid} pairs to flush the
IOTLB cache in the IOMMU, right? Perhaps we could refine this code
further by introducing a structure of cache tag. The cache tags can be
stored in the domain's IOMMU array. I'm working on a solution and I can
post it for discussion later.

Best regards,
baolu
