Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA48367
	for <iommu@lists.linux.dev>; Tue, 28 Jun 2022 05:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656395785; x=1687931785;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jkkFnV1SzLceUSN26FhY9YeMuVcIqRLbH9OTJaJLTP8=;
  b=JJ6gwNDVvRckN6qzrMd6jJEKhcxYymREA/j4gE9A+bFiBtscZoZnr2eR
   K3IfyE0hU/CdAlNO972tfeYoeayBlICzHc/HuARsLml4jUWXg+4fiPqEs
   lCL+F4+jeVXswmGiZ/UKCoVhIn/GU0d+6dC2WVFqBINa5N/Ikh+1Kn9Xe
   5mdWpkYpf7ZepmKn+luYysm50JAPEaZsgoU0psV5IBpBy8qz9+0/fxR3Y
   aJkKKvG3M1oF4iL0qO5qkyv7bAzaV5xEQoQdF909m8GpEAsLHAVxNhTHn
   fNf9y2KnPMATyeevwxv4FEXMT2wBN/tTOfLNh8UIsSNpoeyOh588Q1j7e
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="282378835"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="282378835"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 22:53:46 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="646762122"
Received: from ltang11-mobl1.ccr.corp.intel.com (HELO [10.249.169.64]) ([10.249.169.64])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 22:53:37 -0700
Message-ID: <543603e3-9d08-59ee-01f2-8dd6e7c73a15@linux.intel.com>
Date: Tue, 28 Jun 2022 13:53:35 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc: baolu.lu@linux.intel.com, Eric Auger <eric.auger@redhat.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Pan, Jacob jun"
 <jacob.jun.pan@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 07/11] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-8-baolu.lu@linux.intel.com>
 <BN9PR11MB5276297FAEB8C9774AABAD208CB99@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276297FAEB8C9774AABAD208CB99@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID: <20220628055335.SPvas9ZTerIPZXkrwAqGV0RLz3TcywQ_tXuOXuVYMK8@z>

On 2022/6/27 18:14, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, June 21, 2022 10:44 PM
>> +struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct
>> mm_struct *mm)
>> +{
>> +	struct iommu_domain *domain;
>> +	ioasid_t max_pasids;
>> +	int ret = -EINVAL;
>> +
>> +	/* Allocate mm->pasid if necessary. */
> 
> this comment is for iommu_sva_alloc_pasid()

Updated.

> 
>> +	max_pasids = dev->iommu->max_pasids;
>> +	if (!max_pasids)
>> +		return ERR_PTR(-EOPNOTSUPP);
>> +
>> +	ret = iommu_sva_alloc_pasid(mm, 1, max_pasids - 1);
>> +	if (ret)
>> +		return ERR_PTR(ret);
>> +
> 
> 
> ...
>> +void iommu_sva_unbind_device(struct iommu_sva *handle)
>> +{
>> +	struct device *dev = handle->dev;
>> +	struct iommu_domain *domain =
>> +			container_of(handle, struct iommu_domain, bond);
>> +	ioasid_t pasid = iommu_sva_get_pasid(handle);
>> +
>> +	mutex_lock(&iommu_sva_lock);
>> +	if (refcount_dec_and_test(&domain->bond.users)) {
>> +		iommu_detach_device_pasid(domain, dev, pasid);
>> +		iommu_domain_free(domain);
>> +	}
>> +	mutex_unlock(&iommu_sva_lock);
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_sva_unbind_device);
>> +
>> +u32 iommu_sva_get_pasid(struct iommu_sva *handle)
>> +{
>> +	struct iommu_domain *domain =
>> +			container_of(handle, struct iommu_domain, bond);
>> +
>> +	return domain->mm->pasid;
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
> 
> Looks this is only used by unbind_device. Just open code it.

It's part of current IOMMU/SVA interfaces for the device drivers, and
has been used in various drivers.

$ git grep iommu_sva_get_pasid
drivers/dma/idxd/cdev.c:                pasid = iommu_sva_get_pasid(sva);
drivers/iommu/iommu-sva-lib.c:  ioasid_t pasid = 
iommu_sva_get_pasid(handle);
drivers/iommu/iommu-sva-lib.c:u32 iommu_sva_get_pasid(struct iommu_sva 
*handle)
drivers/iommu/iommu-sva-lib.c:EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
drivers/misc/uacce/uacce.c:     pasid = iommu_sva_get_pasid(handle);
include/linux/iommu.h:u32 iommu_sva_get_pasid(struct iommu_sva *handle);
include/linux/iommu.h:static inline u32 iommu_sva_get_pasid(struct 
iommu_sva *handle)

Or, I missed anything?

Best regards,
baolu
