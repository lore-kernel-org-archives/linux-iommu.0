Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4610F433A9
	for <iommu@lists.linux.dev>; Wed,  5 Jun 2024 02:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717552946; cv=none; b=YbU+8bcpfAaC/CNmqgFWxFISJOHX8+cZj198abjqnxXl8MHmrk++6FhH9CkK92lVihHHn5sB+5bmhAf+IN4EyYkLwjwObtozj70N0YacMZEfTK6tOa/RPGaoZ+qK5sz9mC1/YCGdcFyqUxG2CqEcKWrw/wrDkg2Jg89pB92BJHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717552946; c=relaxed/simple;
	bh=DVudwJDdRkFCO/7DezhJu4C8/HNl1KHfIYtmD/xTOpU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lrLH5UY9uICRYr/KXinqmCDp04v77wZokeD91iKCtfcqiBFron19UmoVFsHk8Fv80IuwwUXAEMJgmEcf8OAkRE9zcfyqb2IVMZNH+Tu44GzfcSv5t8UhpEZcTKQAZgZzdslO84x70rnZD9xbqGhz9778cw+OviwCXIab0Mz78Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BqR2CXy1; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BqR2CXy1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717552943; x=1749088943;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DVudwJDdRkFCO/7DezhJu4C8/HNl1KHfIYtmD/xTOpU=;
  b=BqR2CXy1+3Jj04Lpa1KPl87ywlpCBAs79nr4RVvkm5njy/0wXhH0hhNl
   gH14gFdCsCGsIzYyCU5IDoxsTq2hJQH0x6jyw+VWVZ7hJ+f/0M0kDFDXQ
   fp1ZDdX56owIHQYqFw9qw4zS/Juv+A0x6RmxO6uOz7uzEzmD7sHgH/85o
   ljhiI/25Le8JXx+Jwa1exWIWkGBZe4vD5qpQEMiQtm1yzXygDUjbAklUI
   7CBS35Mey2dOzNaIo03mpLv2h42JuBjrk+ajpGlCgOAiawGxmcJW9RMoB
   +TX+0RRwqcY50evKDTMAllxA63SDIgCzcQDotYWDznYiqdq4m5cMW/DQU
   w==;
X-CSE-ConnectionGUID: vlLCGlx0SzuvZpdmECRfGQ==
X-CSE-MsgGUID: 3kv9/CSnQVSXf7OvNAcz1Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="13942504"
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="13942504"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 19:02:23 -0700
X-CSE-ConnectionGUID: RItW8yqwTuq9l9wOE2V1jA==
X-CSE-MsgGUID: e3RctwFJShOkhwUisZR8pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="37870969"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa006.jf.intel.com with ESMTP; 04 Jun 2024 19:02:17 -0700
Message-ID: <91a42f46-060a-4430-a10a-7bfded67c4a9@linux.intel.com>
Date: Wed, 5 Jun 2024 10:00:09 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Kalle Valo <kvalo@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>, mst@redhat.com,
 Jason Wang <jasowang@redhat.com>, Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Mikko Perttunen <mperttunen@nvidia.com>, iommu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/22] iommu: Add iommu_user_domain_alloc() interface
To: Yi Liu <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
References: <20240604015134.164206-1-baolu.lu@linux.intel.com>
 <20240604015134.164206-2-baolu.lu@linux.intel.com>
 <445fae9f-ea1e-4864-9f0e-f348c51146a1@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <445fae9f-ea1e-4864-9f0e-f348c51146a1@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/4/24 4:03 PM, Yi Liu wrote:
> On 2024/6/4 09:51, Lu Baolu wrote:
>> Commit <909f4abd1097> ("iommu: Add new iommu op to create domains owned
>> by userspace") added a dedicated iommu op to allocate a user domain.
>> While IOMMUFD has already made use of this callback, other frameworks
>> like vfio/type1 and vDPA still use the paging domain allocation 
>> interface.
>>
>> Add a new interface named iommu_user_domain_alloc(), which indicates the
>> allocation of a domain for device DMA managed by user space driver. All
>> device passthrough frameworks could use this interface for their domain
>> allocation.
>>
>> Although it is expected that all iommu drivers could implement their own
>> domain_alloc_user ops, most drivers haven't implemented it yet. Rollback
>> to the paging domain allocation interface if the iommu driver hasn't
>> implemented this op yet.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   include/linux/iommu.h |  6 ++++++
>>   drivers/iommu/iommu.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 48 insertions(+)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 7bc8dff7cf6d..6648b2415474 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -780,6 +780,7 @@ extern bool iommu_present(const struct bus_type 
>> *bus);
>>   extern bool device_iommu_capable(struct device *dev, enum iommu_cap 
>> cap);
>>   extern bool iommu_group_has_isolated_msi(struct iommu_group *group);
>>   extern struct iommu_domain *iommu_domain_alloc(const struct bus_type 
>> *bus);
>> +struct iommu_domain *iommu_user_domain_alloc(struct device *dev, u32 
>> flags);
>>   extern void iommu_domain_free(struct iommu_domain *domain);
>>   extern int iommu_attach_device(struct iommu_domain *domain,
>>                      struct device *dev);
>> @@ -1086,6 +1087,11 @@ static inline struct iommu_domain 
>> *iommu_domain_alloc(const struct bus_type *bus
>>       return NULL;
>>   }
>> +static inline struct iommu_domain *iommu_user_domain_alloc(struct 
>> device *dev, u32 flags)
>> +{
>> +    return ERR_PTR(-ENODEV);
>> +}
>> +
>>   static inline void iommu_domain_free(struct iommu_domain *domain)
>>   {
>>   }
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 9df7cc75c1bc..f1416892ef8e 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -2032,6 +2032,48 @@ struct iommu_domain *iommu_domain_alloc(const 
>> struct bus_type *bus)
>>   }
>>   EXPORT_SYMBOL_GPL(iommu_domain_alloc);
>> +/**
>> + * iommu_user_domain_alloc() - Allocate a user domain
>> + * @dev: device for which the domain is allocated
>> + * @flags: iommufd_hwpt_alloc_flags defined in uapi/linux/iommufd.h
>> + *
>> + * Allocate a user domain which will be managed by a userspace 
>> driver. Return
>> + * allocated domain if successful, or a ERR pointer for failure.
> 
> do you want to mention that this is for paging domain allocation?

You are worrying about its confusion with nesting domain allocation,
right? My understanding is that if we want a common interface for
nesting domain allocation, we should make it in another interface. Here,
the user domain is a paging domain for GVA->HPA mapping, which is common
across iommufd, vfio, and vdpa.

> 
>> + */
>> +struct iommu_domain *iommu_user_domain_alloc(struct device *dev, u32 
>> flags)
>> +{
>> +    struct iommu_domain *domain;
>> +    const struct iommu_ops *ops;
>> +
>> +    if (!dev_has_iommu(dev))
>> +        return ERR_PTR(-ENODEV);
>> +
>> +    ops = dev_iommu_ops(dev);
>> +    if (ops->domain_alloc_user) {
>> +        domain = ops->domain_alloc_user(dev, flags, NULL, NULL);
>> +        if (IS_ERR(domain))
>> +            return domain;
>> +
>> +        domain->type = IOMMU_DOMAIN_UNMANAGED;
>> +        domain->owner = ops;
>> +        domain->pgsize_bitmap = ops->pgsize_bitmap;
> 
> this seems to break the iommufd selftest as the mock driver sets extra
> bits in the domain->pgsize_bitmap in allocation. Override it may fail
> something in the testing. you may need to check if domain->pgsize_bitmap
> is set or use &=.
> 
> static struct iommu_domain *mock_domain_alloc_paging(struct device *dev)
> {
>      struct mock_dev *mdev = container_of(dev, struct mock_dev, dev);
>      struct mock_iommu_domain *mock;
> 
>      mock = kzalloc(sizeof(*mock), GFP_KERNEL);
>      if (!mock)
>          return NULL;
>      mock->domain.geometry.aperture_start = MOCK_APERTURE_START;
>      mock->domain.geometry.aperture_end = MOCK_APERTURE_LAST;
>      mock->domain.pgsize_bitmap = MOCK_IO_PAGE_SIZE;
>      if (dev && mdev->flags & MOCK_FLAGS_DEVICE_HUGE_IOVA)
>          mock->domain.pgsize_bitmap |= MOCK_HUGE_PAGE_SIZE;
>      mock->domain.ops = mock_ops.default_domain_ops;
>      mock->domain.type = IOMMU_DOMAIN_UNMANAGED;
>      xa_init(&mock->pfns);
>      return &mock->domain;
> }

You are right. I should follow the code in __iommu_domain_alloc()

         /*
          * If not already set, assume all sizes by default; the driver
          * may override this later
          */
         if (!domain->pgsize_bitmap)
                 domain->pgsize_bitmap = ops->pgsize_bitmap;

Does it work?

Best regards,
baolu
