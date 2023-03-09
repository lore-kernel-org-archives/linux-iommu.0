Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6A3628
	for <iommu@lists.linux.dev>; Thu,  9 Mar 2023 01:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678326255; x=1709862255;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4KAyNFjB6MR3x2c7wk0ZgGpMkoqsgma6RxENs34cggA=;
  b=HF/ftys38fDMzMWZRkHXSVr9822k6cDVKCNtFVGlPy9L5EttQuV1aq6J
   H2KvoVtBLPZTKaJ8JEr0mFmsj0Cu3+uWQ21BASBJF/qkvEd4G+wZ/wh9p
   ivYJ9UoGB09Pr13xIBqpJaxSyNj34EuVSH2KSqvomyERTeSBgl3kNfnlE
   LdvClJ6t7DOsCVrS2MAK5dbzCv9SkySoHaIRJE5P/rw7H1pwuKPEfUuLM
   do8ttvhhYKsIMgpO2ggMUhTK8hYzsrOA5E6L8HjpU8+sp/AMUYzRQL8nl
   tkEVRB/PoZlQWywt0FzVFS4k2hMA6lGmLvo+uR/f8B7HYh5126tpn4O3p
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="333797857"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="333797857"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 17:44:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="766235333"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="766235333"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Mar 2023 17:44:12 -0800
Message-ID: <a2a198ec-2a11-28f5-db2d-ca8c7ec76cbe@linux.intel.com>
Date: Thu, 9 Mar 2023 09:43:13 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 Kevin Tian <kevin.tian@intel.com>, linux-kselftest@vger.kernel.org,
 kvm@vger.kernel.org, Nicolin Chen <nicolinc@nvidia.com>,
 Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 05/17] iommufd: Keep track of each device's reserved
 regions instead of groups
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <5-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
 <9a047c7f-924d-0c8a-7055-fcbe7c84429b@linux.intel.com>
 <ZAijolW3I1BOSjpn@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZAijolW3I1BOSjpn@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/8/23 11:02 PM, Jason Gunthorpe wrote:
> On Wed, Mar 08, 2023 at 08:32:03PM +0800, Baolu Lu wrote:
>>> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
>>> index 2ff192777f27d3..22863759c3bfb0 100644
>>> --- a/drivers/iommu/iommufd/iommufd_private.h
>>> +++ b/drivers/iommu/iommufd/iommufd_private.h
>>> @@ -76,10 +76,9 @@ int iopt_table_add_domain(struct io_pagetable *iopt,
>>>    			  struct iommu_domain *domain);
>>>    void iopt_table_remove_domain(struct io_pagetable *iopt,
>>>    			      struct iommu_domain *domain);
>>> -int iopt_table_enforce_group_resv_regions(struct io_pagetable *iopt,
>>> -					  struct device *device,
>>> -					  struct iommu_group *group,
>>> -					  phys_addr_t *sw_msi_start);
>>> +int iopt_table_enforce_dev_resv_regions(struct io_pagetable *iopt,
>>> +					struct device *dev,
>>> +					phys_addr_t *sw_msi_start);
>>>    int iopt_set_allow_iova(struct io_pagetable *iopt,
>>>    			struct rb_root_cached *allowed_iova);
>>>    int iopt_reserve_iova(struct io_pagetable *iopt, unsigned long start,
>>
>> Perhaps a silly question. The reserved regions are enforced in IOVA when
>> a device is added to the igroup's device list. Should it be released
>> after the device is removed from the list?
> 
> Yes, it is, iommufd_hw_pagetable_detach() does it right after the
> list_del()
> 
>> This may not be appropriate because the devices may share some common
>> reserved regions, such as the IOMMU_RESV_MSI.
> 
> Common reserved regions are duplicated for every device just as they
> were duplicated for every group.
> 
> The duplicates are keyed with an owner that is equal to the 'struct
> device *' so we only remove the IOVA specific to the struct device.
> 
> The interval tree effectively unions the duplicated and overlapping
> IOVA regions during lookup.
> 
> It is done this way to avoid memory allocation on destruction
> paths. We never have to chop up merged IOVA regions or something to
> remove a device.

Ah! Yes. This has been considered. I should read further into
iopt_reserve_iova() and iopt_remove_reserved_iova(). Thanks for the
explanation.

Best regards,
baolu
