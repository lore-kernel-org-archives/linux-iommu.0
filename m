Received: from mgamail.intel.com (unknown [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0455012B67
	for <iommu@lists.linux.dev>; Thu,  3 Aug 2023 07:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691048191; x=1722584191;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=L0xn3LN+iLDuwnDfC10OXNIFwR0hNYvlK8cIufvM8+I=;
  b=nBPWL4BWhMbEVPSDjrGRp3O9uawNqp0PYXXdNBwFhjbK9cm9ym1K5SRH
   mhU5hVb9LWQRCshYlNfuFcTKZKUJ6frR3SsMJXBq6QnguZcIhQdZol39a
   M0v1ESG3CxY3fd8io68FED89lpfZ+4jBBwq5+omxuSsJysNCzAJXS1ybA
   l6blzmPeZul1jE1tekPs6xI/PadqyffbehWAtz7Ouq/SGNDbC7yn0a8Or
   LDhgRFHxDU7HAOQ/+2OCtmEySd6GOJc16bxyxX+zx80sbqz57G6yVwUht
   csKi61OS5APy62Q1oYgZ/onwf7JtuEPmyt9RfrvulmGfDBfVMSbu1tSS5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="368696072"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="368696072"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 00:36:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="764494874"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="764494874"
Received: from zhaoyuan-mobl.ccr.corp.intel.com (HELO [10.254.213.243]) ([10.254.213.243])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 00:36:16 -0700
Message-ID: <898e9680-3e5c-29d5-39d0-f9648165a2d6@linux.intel.com>
Date: Thu, 3 Aug 2023 15:36:13 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: baolu.lu@linux.intel.com, "cohuck@redhat.com" <cohuck@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
 "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
 "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com" <lulu@redhat.com>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v4 09/12] iommu/vt-d: Add iotlb flush for nested domain
To: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
 <20230724111335.107427-10-yi.l.liu@intel.com>
 <BN9PR11MB527690EBAA872A16AE8926F88C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <58ae9095-28f2-a44a-b0e5-be82e1eae9d9@linux.intel.com>
 <BN9PR11MB52764994FB32B2B1CD9C95068C08A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <40d9b0fa-4a36-c3b7-53bb-4333ff89dc45@linux.intel.com>
 <BN9PR11MB5276FED948D84DAA81D09C838C08A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276FED948D84DAA81D09C838C08A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/8/3 12:13, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Thursday, August 3, 2023 12:06 PM
>>
>> On 2023/8/3 12:00, Tian, Kevin wrote:
>>>> From: Baolu Lu <baolu.lu@linux.intel.com>
>>>> Sent: Thursday, August 3, 2023 11:25 AM
>>>>
>>>> On 2023/8/2 15:46, Tian, Kevin wrote:
>>>>>> From: Liu, Yi L <yi.l.liu@intel.com>
>>>>>> Sent: Monday, July 24, 2023 7:14 PM
>>>>>>
>>>>>> +
>>>>>> +		spin_lock_irqsave(&dmar_domain->lock, flags);
>>>>>> +		list_for_each_entry(info, &dmar_domain->devices, link)
>>>>>> +			intel_nested_invalidate(info->dev, dmar_domain,
>>>>>> +						req->addr, req->npages);
>>>>>> +		spin_unlock_irqrestore(&dmar_domain->lock, flags);
>>>>>
>>>>> Disabling interrupt while invalidating iotlb is certainly unacceptable.
>>>>>
>>>>> Actually there is no need to walk devices. Under dmar_domain there
>>>>> is already a list of attached iommu's.
>>>>
>>>> Walking device is only necessary when invalidating device TLB. For iotlb
>>>> invalidation, it only needs to know the iommu's.
>>>>
>>>
>>> even for device tlb we may think whether there is any better way
>>> to avoid disabling interrupt. It's a slow path, especially in a guest.
>>
>> I ever tried this. But some device drivers call iommu_unmap() in the
>> interrupt critical path. :-( So we have a long way to go.
>>
> 
> emmm... this path only comes from iommufd and the domain is
> user-managed. There won't be kernel drivers to call iommu_unmap()
> on such domain.

Probably we can use a different lock for nested domain and add a comment
around the lock with above explanation.

Best regards,
baolu

