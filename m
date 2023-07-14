Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8612E20F4
	for <iommu@lists.linux.dev>; Fri, 14 Jul 2023 03:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689305651; x=1720841651;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iC96bqOQX5kvCoBAcZNbqBQI/SPJtZnbz1ANg4udjG4=;
  b=Uq7b1dQl3QgM3Bv6j+BFV7T5kyoHtzd177W5nHX6ONB6DgHFUKyKpQqV
   ju1RumotXgv0HiDa+ZyOPKuK7sCP0qAB0cnO6r7oHgiGmjPFdtPv3LWJ6
   zLuvjLpotW2bvOKBZA6/bVS2Tm3CeQN90d7V1o06FZ01xg6hw66Pw/Jh3
   OV4hJXaOAMSHqk3pQ5/IAdY3MsQA2nfqdqjWd3IeJBIjp0kWcMTPMFc7n
   Wal+yGfHX0JvZlrnNUSBw8f11y2LrOY7LlWdRgeqNZrIUGd/B86GsSPAY
   3fqR3Urnxnjqu1k6huhKWCWjhfipBoFOsaGxy40W/DcrwoifLUUsQngPo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="365419801"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="365419801"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 20:34:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="787700392"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="787700392"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.191.49]) ([10.252.191.49])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 20:34:04 -0700
Message-ID: <87e78302-9f69-8db1-8a0a-b40e1f29d9c6@linux.intel.com>
Date: Fri, 14 Jul 2023 11:34:00 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@nvidia.com>,
 Will Deacon <will@kernel.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Yu, Fenghua" <fenghua.yu@intel.com>, "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH v10 6/7] iommu/vt-d: Add set_dev_pasid callback for dma
 domain
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Joerg Roedel <joro@8bytes.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Robin Murphy <robin.murphy@arm.com>
References: <20230712163355.3177511-1-jacob.jun.pan@linux.intel.com>
 <20230712163355.3177511-7-jacob.jun.pan@linux.intel.com>
 <BN9PR11MB5276C14341AC7CE6D352948F8C37A@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276C14341AC7CE6D352948F8C37A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/7/13 15:56, Tian, Kevin wrote:
>> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Sent: Thursday, July 13, 2023 12:34 AM
>>
>>
>> -	/*
>> -	 * Should never reach here until we add support for attaching
>> -	 * non-SVA domain to a pasid.
>> -	 */
>> -	WARN_ON(1);
>> +	dmar_domain = to_dmar_domain(domain);
>> +	spin_lock_irqsave(&dmar_domain->lock, flags);
>> +	list_for_each_entry(curr, &dmar_domain->dev_pasids, link_domain)
>> {
>> +		if (curr->dev == dev && curr->pasid == pasid) {
>> +			list_del(&curr->link_domain);
>> +			dev_pasid = curr;
>> +			break;
>> +		}
>> +	}
>> +	spin_unlock_irqrestore(&dmar_domain->lock, flags);
>>
> 
> what about no matching dev_pasid is find?

kfree() can handle this gracefully.

> 
>> +	domain_detach_iommu(dmar_domain, iommu);
>> +	kfree(dev_pasid);
>>   out_tear_down:
>>   	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
>>   	intel_drain_pasid_prq(dev, pasid);
>>   }
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
>> +	if (ret)
>> +		goto out_detach_iommu;
>> +
>> +	dev_pasid->dev = dev;
>> +	dev_pasid->pasid = pasid;
>> +	spin_lock_irqsave(&dmar_domain->lock, flags);
>> +	list_add(&dev_pasid->link_domain, &dmar_domain->dev_pasids);
>> +	spin_unlock_irqrestore(&dmar_domain->lock, flags);
>> +
>> +	return 0;
>> +out_detach_iommu:
>> +	domain_detach_iommu(dmar_domain, iommu);
>> +out_free:
>> +	kfree(dev_pasid);
>> +	return ret;
>> +}
>> +
>>   const struct iommu_ops intel_iommu_ops = {
>>   	.capable		= intel_iommu_capable,
>>   	.domain_alloc		= intel_iommu_domain_alloc,
>> @@ -4777,6 +4869,7 @@ const struct iommu_ops intel_iommu_ops = {
>>   #endif
>>   	.default_domain_ops = &(const struct iommu_domain_ops) {
>>   		.attach_dev		= intel_iommu_attach_device,
>> +		.set_dev_pasid		= intel_iommu_set_dev_pasid,
>>   		.map_pages		= intel_iommu_map_pages,
>>   		.unmap_pages		= intel_iommu_unmap_pages,
>>   		.iotlb_sync_map		=
>> intel_iommu_iotlb_sync_map,
>> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
>> index 6d94a29f5d52..68bb7cdf5543 100644
>> --- a/drivers/iommu/intel/iommu.h
>> +++ b/drivers/iommu/intel/iommu.h
>> @@ -595,6 +595,7 @@ struct dmar_domain {
>>
>>   	spinlock_t lock;		/* Protect device tracking lists */
>>   	struct list_head devices;	/* all devices' list */
>> +	struct list_head dev_pasids;	/* all attached pasids */
>>
>>   	struct dma_pte	*pgd;		/* virtual address */
>>   	int		gaw;		/* max guest address width */
>> @@ -717,6 +718,12 @@ struct device_domain_info {
>>   	struct pasid_table *pasid_table; /* pasid table */
>>   };
>>
>> +struct dev_pasid_info {
>> +	struct list_head link_domain;	/* link to domain siblings */
>> +	struct device *dev;		/* the physical device */
>> +	ioasid_t pasid;			/* PASID of the physical device */
>> +};
> 
> the comment for dev/pasid is meaningless.

Then we can remove them.

Best regards,
baolu
