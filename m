Received: from mgamail.intel.com (unknown [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E221847
	for <iommu@lists.linux.dev>; Thu,  3 Aug 2023 04:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691035545; x=1722571545;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WgVb4J59RLF3p1cq5nNgzuJOUGR0j/yT9TP7r6Wj8Zg=;
  b=RSdXtfy3yB/WtzKwtvg6ArOjIFVbs8cOFaxPCGeRckTWzXs3Jr3EL2si
   B6fVc/o+TrlylKvKbLaygGT4j9QeT5UB93ctwAgudyfDI27eT7K1HB4at
   dL+xNnn/atfT0HE21vhlm5VYw/pX6r8JeJHtft5+fd4F+qVRY56Qozgc9
   qMKmgBdnMElRg8uSa4f3JwhUZz1fgo+dwm7N8Xl3tmpZ+IpnbvJ854Bi5
   e4CdS473Noh2AJZD81K9ovqznTosMQ7VkD2AH1frDHyEygURKBZLIJdtN
   uO0/COYig1k/Gc3R+wGrWsxyXdv4eGytCTmCXbdOb0sZIpz5EfprRjrFH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="349360924"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="349360924"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 21:05:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="872767507"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.255.31.34]) ([10.255.31.34])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 21:05:41 -0700
Message-ID: <40d9b0fa-4a36-c3b7-53bb-4333ff89dc45@linux.intel.com>
Date: Thu, 3 Aug 2023 12:05:37 +0800
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
Content-Language: en-US
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
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52764994FB32B2B1CD9C95068C08A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/8/3 12:00, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Thursday, August 3, 2023 11:25 AM
>>
>> On 2023/8/2 15:46, Tian, Kevin wrote:
>>>> From: Liu, Yi L <yi.l.liu@intel.com>
>>>> Sent: Monday, July 24, 2023 7:14 PM
>>>>
>>>> +
>>>> +		spin_lock_irqsave(&dmar_domain->lock, flags);
>>>> +		list_for_each_entry(info, &dmar_domain->devices, link)
>>>> +			intel_nested_invalidate(info->dev, dmar_domain,
>>>> +						req->addr, req->npages);
>>>> +		spin_unlock_irqrestore(&dmar_domain->lock, flags);
>>>
>>> Disabling interrupt while invalidating iotlb is certainly unacceptable.
>>>
>>> Actually there is no need to walk devices. Under dmar_domain there
>>> is already a list of attached iommu's.
>>
>> Walking device is only necessary when invalidating device TLB. For iotlb
>> invalidation, it only needs to know the iommu's.
>>
> 
> even for device tlb we may think whether there is any better way
> to avoid disabling interrupt. It's a slow path, especially in a guest.

I ever tried this. But some device drivers call iommu_unmap() in the
interrupt critical path. :-( So we have a long way to go.

Best regards,
baolu
