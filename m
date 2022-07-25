Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218B262D
	for <iommu@lists.linux.dev>; Mon, 25 Jul 2022 10:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658744543; x=1690280543;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wAXUudd2bYpf3nYYKav//ZqBy0T3UuLekipqsksLhYI=;
  b=F0PDVIcnjY3mtTwFj4UHqyNOwqUKPlIfJWT+eDaFBR0B9yPcPeDKkVU/
   tlx85XZJTYpHiwnBNi2KLhbhCxpDzsiXGtexguO2iBppDV3BO59q1qXVb
   +RWuB2lFGZhJ016aEnp615bVGcFeW0V29kn3jo2PxmLNTKWWmpY1aULHE
   t50Oj4VjVYWMi164kEcvXp2swYe3dEB3EOe8F4dvB6fP3ZxchvBxxDGDv
   QOf0pfrnFA/p6gvSLH62bfCnszphlO/lXQM8Zy56FFootl29T59BA1jqK
   8jx1PVnus1lI8tm9gKWU0PT7E9WF+WqoIHJY9MYaGAI5cCCyFjQVRtUyC
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="373968107"
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="373968107"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 03:22:09 -0700
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="658130002"
Received: from liangk-mobl.ccr.corp.intel.com (HELO [10.255.30.67]) ([10.255.30.67])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 03:22:06 -0700
Message-ID: <b868cd13-4902-7d60-048a-31bb92b94cda@linux.intel.com>
Date: Mon, 25 Jul 2022 18:22:06 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Christoph Hellwig <hch@infradead.org>, "Raj, Ashok" <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
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
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-9-baolu.lu@linux.intel.com>
 <20220723142650.GH79279@nvidia.com>
 <bffb6e2d-d310-49b9-0725-37ab4263c22d@linux.intel.com>
 <BN9PR11MB52764D3E07E6755EF52DDC138C959@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52764D3E07E6755EF52DDC138C959@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/7/25 15:50, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Sunday, July 24, 2022 9:48 PM
>>>
>>> The API is really refcounting the PASID:
>>>
>>>> +struct iommu_sva *iommu_sva_bind_device(struct device *dev,
>>>> +					struct mm_struct *mm);
>>>> +void iommu_sva_unbind_device(struct iommu_sva *handle);
>>>
>>> So what you need to do is store that 'iommu_sva' in the group's PASID
>>> xarray.
>>>
>>> The bind logic would be
>>>
>>>     sva = xa_load(group->pasid, mm->pasid)
>>>     if (sva)
>>>        refcount_inc(sva->users)
>>>        return sva
>>>     sva = kalloc
>>>     sva->domain = domain
>>>     xa_store(group->pasid, sva);
>>
>> Thanks for the suggestion. It makes a lot of sense to me.
>>
>> Furthermore, I'd like to separate the generic data from the caller-
>> specific things because the group->pasid_array should also be able to
>> serve other usages. Hence, the attach/detach_device_pasid interfaces
>> might be changed like below:
>>
>> /* Collection of per-pasid IOMMU data */
>> struct group_pasid {
>> 	struct iommu_domain *domain;
>> 	void *priv;
>> };
>>
> 
> Is there any reason why pasid refcnt is sva specific and needs to be
> in a priv field?

I am going to store the iommu_sva data which represents the bind
relationship between device and domain.

Best regards,
baolu
