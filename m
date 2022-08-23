Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2D4EB8
	for <iommu@lists.linux.dev>; Tue, 23 Aug 2022 07:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661239851; x=1692775851;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=j51hMQhIOMj+pWMUO1f6irDGuNzX4i/XllUj8uvQjxw=;
  b=J+aaFbYUgyZk3SN304mEVzUBpKbBJx03QDJhWlFhZ+8PtUOsO10YD6Q+
   Clj8F9f+5i8SDEFz5XAin1JQDHFhj5YTh96nlkrCJzSpcn7HyEADG4BB1
   abupMYzc2pQD10CWtFyOWg7YUh1LRyehgMEdU1n4j/RavpWvXMLBTyF0f
   fuFuRvs++aNdrNQQWicqzGsWnMcPvXQ164qR7PN9bCKqVyAAaklkUD9+T
   ysa6rrtzTRntWXJY1O/zaCGHaLkKqLZBJdhJqGzW+372pg+7lNJpgQKUQ
   kSW61gut10lC8F+cOpX0zajNNR4T3JjxXaNRFZ3goqmHxIBte4TAT38ab
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="293614300"
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="293614300"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 00:30:31 -0700
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="642344795"
Received: from xujinlon-mobl.ccr.corp.intel.com (HELO [10.254.211.102]) ([10.254.211.102])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 00:30:23 -0700
Message-ID: <d538aa77-ac9a-e436-5558-e97e9c68d222@linux.intel.com>
Date: Tue, 23 Aug 2022 15:30:21 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Christoph Hellwig <hch@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
 Eric Auger <eric.auger@redhat.com>, Liu Yi L <yi.l.liu@intel.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>,
 Zhangfei Gao <zhangfei.gao@linaro.org>, Zhu Tony <tony.zhu@intel.com>,
 iommu@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v11 05/13] iommu: Add attach/detach_dev_pasid iommu
 interface
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220817012024.3251276-1-baolu.lu@linux.intel.com>
 <20220817012024.3251276-6-baolu.lu@linux.intel.com>
 <Yv4/s6lX6Nq+40tu@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Yv4/s6lX6Nq+40tu@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/8/18 21:33, Jason Gunthorpe wrote:
> On Wed, Aug 17, 2022 at 09:20:16AM +0800, Lu Baolu wrote:
> 
>> +static int __iommu_set_group_pasid(struct iommu_domain *domain,
>> +				   struct iommu_group *group, ioasid_t pasid)
>> +{
>> +	struct iommu_domain *ops_domain;
>> +	struct group_device *device;
>> +	int ret = 0;
>> +
>> +	if (domain == group->blocking_domain)
>> +		ops_domain = xa_load(&group->pasid_array, pasid);
>> +	else
>> +		ops_domain = domain;
> 
> This seems weird, why isn't this just always
> 
> domain->ops->set_dev_pasid()?

Sure. I will fix this in the next version.

> 
>> +	if (curr) {
>> +		ret = xa_err(curr) ? : -EBUSY;
>> +		goto out_unlock;
>> +	}
>> +
>> +	ret = __iommu_set_group_pasid(domain, group, pasid);
>> +	if (ret) {
>> +		__iommu_set_group_pasid(group->blocking_domain, group, pasid);
>> +		xa_erase(&group->pasid_array, pasid);
> 
> I was looking at this trying to figure out why we are having
> attach/detach semantics vs set and this error handling seems to be the
> reason
> 
> Lets add a comment because it is subtle thing:
> 
>    Setting a PASID to a blocking domain cannot fail, so we can always
>    safely error unwind a failure to attach a domain back to the original
>    group configuration of the PASID being unused.

Updated.

> 
>> +/*
>> + * iommu_detach_device_pasid() - Detach the domain from pasid of device
>> + * @domain: the iommu domain.
>> + * @dev: the attached device.
>> + * @pasid: the pasid of the device.
>> + *
>> + * The @domain must have been attached to @pasid of the @dev with
>> + * iommu_attach_device_pasid().
>> + */
>> +void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
>> +			       ioasid_t pasid)
> 
> Don't pass domain here?

It is checked in the function to make sure that the detached domain is
the same one as the previous attached one.

> 
>> +/*
>> + * iommu_get_domain_for_dev_pasid() - Retrieve domain for @pasid of @dev
>> + * @dev: the queried device
>> + * @pasid: the pasid of the device
>> + *
>> + * This is a variant of iommu_get_domain_for_dev(). It returns the existing
>> + * domain attached to pasid of a device. It's only for internal use of the
>> + * IOMMU subsystem. The caller must take care to avoid any possible
>> + * use-after-free case.
> 
> How exactly does the caller manage that?

"... the returned domain pointer could only be used before detaching
from the device PASID."

> 
>> + *
>> + * Return: attached domain on success, NULL otherwise.
>> + */
>> +struct iommu_domain *
>> +iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid)
>> +{
>> +	struct iommu_domain *domain;
>> +	struct iommu_group *group;
>> +
>> +	if (!pasid_valid(pasid))
>> +		return NULL;
> 
> Why bother? If the pasid is not valid then it definitely won't be in the xarray.

Removed.

> But otherwise this overall thing seems fine to me

Thank you!

Best regards,
baolu
