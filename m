Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9961F7A
	for <iommu@lists.linux.dev>; Tue, 26 Jul 2022 08:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658825227; x=1690361227;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FTdA1qmyryouVTB4vR/QuyKSs43K1/v260tWZ8UUxt8=;
  b=dTNN8ccPXKBbyjKW6ShqXDoX9+KXSdTBL0ihfHwAjuF7NiJA/AqNCa5b
   94JmdfsSlrnvOZM4lZjecJFhSVZX6VJCmJvIKsAIDuiHo8bV6AI2rcdNW
   3M0vd6PGEWPHu6QjbcbvQa4tgNSC48C/cPGKvx43Otj4edFp12VLaZa3Q
   Xu6S4QgcmPiOcWqVJvYdvW8k63EY1PAkNdJPV8QG9U6G5bwaSKrikU9y/
   h4jLP0dZQotJDSnjSBZjW0ZMgPd3kLxTkIWD3yMwSixMFbXOWEw6Cu8IO
   IJPhmQ9iNmtRCmTu8rGeaRoofeMW4fucOiA1UDGV2I4gGyv1lQ3NScNrZ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="274766417"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="274766417"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 01:47:06 -0700
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="575404438"
Received: from hzhi-mobl4.ccr.corp.intel.com (HELO [10.255.30.159]) ([10.255.30.159])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 01:47:02 -0700
Message-ID: <d8f2646d-be6a-9636-3e9d-8e1d65ecb0c4@linux.intel.com>
Date: Tue, 26 Jul 2022 16:47:00 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc: baolu.lu@linux.intel.com, "Tian, Kevin" <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@infradead.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
 Eric Auger <eric.auger@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
 Zhangfei Gao <zhangfei.gao@linaro.org>, "Zhu, Tony" <tony.zhu@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 08/12] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-9-baolu.lu@linux.intel.com>
 <20220723142650.GH79279@nvidia.com>
 <bffb6e2d-d310-49b9-0725-37ab4263c22d@linux.intel.com>
 <BN9PR11MB52764D3E07E6755EF52DDC138C959@BN9PR11MB5276.namprd11.prod.outlook.com>
 <b868cd13-4902-7d60-048a-31bb92b94cda@linux.intel.com>
 <20220725144758.GG3747@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220725144758.GG3747@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/7/25 22:47, Jason Gunthorpe wrote:
> On Mon, Jul 25, 2022 at 06:22:06PM +0800, Baolu Lu wrote:
>> On 2022/7/25 15:50, Tian, Kevin wrote:
>>>> From: Baolu Lu <baolu.lu@linux.intel.com>
>>>> Sent: Sunday, July 24, 2022 9:48 PM
>>>>>
>>>>> The API is really refcounting the PASID:
>>>>>
>>>>>> +struct iommu_sva *iommu_sva_bind_device(struct device *dev,
>>>>>> +					struct mm_struct *mm);
>>>>>> +void iommu_sva_unbind_device(struct iommu_sva *handle);
>>>>>
>>>>> So what you need to do is store that 'iommu_sva' in the group's PASID
>>>>> xarray.
>>>>>
>>>>> The bind logic would be
>>>>>
>>>>>      sva = xa_load(group->pasid, mm->pasid)
>>>>>      if (sva)
>>>>>         refcount_inc(sva->users)
>>>>>         return sva
>>>>>      sva = kalloc
>>>>>      sva->domain = domain
>>>>>      xa_store(group->pasid, sva);
>>>>
>>>> Thanks for the suggestion. It makes a lot of sense to me.
>>>>
>>>> Furthermore, I'd like to separate the generic data from the caller-
>>>> specific things because the group->pasid_array should also be able to
>>>> serve other usages. Hence, the attach/detach_device_pasid interfaces
>>>> might be changed like below:
>>>>
>>>> /* Collection of per-pasid IOMMU data */
>>>> struct group_pasid {
>>>> 	struct iommu_domain *domain;
>>>> 	void *priv;
>>>> };
>>>>
>>>
>>> Is there any reason why pasid refcnt is sva specific and needs to be
>>> in a priv field?
>>
>> I am going to store the iommu_sva data which represents the bind
>> relationship between device and domain.
> 
> Why do you need that?
> 
> If you are starting at the pasid xarray then you already know the
> group/device, so we don't need to store it again.
> 
> The only thing needed is the refcount so just store a refcount in this
> structure and be done with it. If someone needs to add something later
> then we can use a union or something, but right now adding an untagged
> void * is bad.

Fair enough. I will update it accordingly.

Best regards,
baolu
