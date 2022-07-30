Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5068F23A4
	for <iommu@lists.linux.dev>; Sat, 30 Jul 2022 06:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659161867; x=1690697867;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=oFW1VFvsvwUQ1O2ptLBiOxnNK5bxa7Wr2RcCeO0TdgM=;
  b=ILLsFTSHzDCYwvqTcRnX/g3EkDxGHnyMuTSWrRFegYptu4SG1DxHftUe
   4lAXFfJXvT+NXlLiDWj+VD3Cq3ggg/w9mgq5s5QgbrH16Gd7FqkRd2tQL
   PBGiNRGaTlzuDXZ0VYHk6auEDlKNe/rPJOXs6BZiYalFu2pp5WVRJjyRk
   x5egFPU857yaaA7CljyEtjAKZUslfFkPkxtKOMoM0o9H6aXcFODg/FkCE
   jxK3NuyYIn2ElDXWl3OGLW+LOzMchURKzEsSwArCpgzlTbHxtsTIUEgfx
   DNVnZthSUZZ4Mm7F4C2ChxW3RLx5y85jlpWSWrMKUo9B4z72AZqfVI0Nt
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="375199203"
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="375199203"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 23:17:46 -0700
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="660516517"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.174]) ([10.254.210.174])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 23:17:42 -0700
Message-ID: <01a591dc-4918-3c8d-e3f4-b4b738919ee5@linux.intel.com>
Date: Sat, 30 Jul 2022 14:17:40 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Christoph Hellwig <hch@infradead.org>, "Raj, Ashok" <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
 Eric Auger <eric.auger@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
 Zhangfei Gao <zhangfei.gao@linaro.org>, "Zhu, Tony" <tony.zhu@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-5-baolu.lu@linux.intel.com>
 <20220723141118.GD79279@nvidia.com>
 <686b137f-232a-2a78-beb0-e4373bd20959@linux.intel.com>
 <20220725144005.GE3747@nvidia.com>
 <6da27a6b-b580-4ba4-24c8-ebdfb2d9345d@linux.intel.com>
 <20220726135722.GC4438@nvidia.com>
 <BN9PR11MB5276974ABA5981A7361953708C979@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220727115339.GM4438@nvidia.com>
 <BN9PR11MB52766C3D37FA985DEBDC30C78C969@BN9PR11MB5276.namprd11.prod.outlook.com>
 <YuJ6MXoNTj0RKCb8@nvidia.com>
 <78376ca4-9b55-7609-abf1-27a1a376a8e0@linux.intel.com>
 <BN9PR11MB52761058CFCB9397F6A73A958C999@BN9PR11MB5276.namprd11.prod.outlook.com>
 <64667345-7f7f-74ec-215a-f2d36be0f9ce@linux.intel.com>
 <BN9PR11MB5276ED7CE0C8CE192B4EACB68C999@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v10 04/12] iommu: Add attach/detach_dev_pasid iommu
 interface
In-Reply-To: <BN9PR11MB5276ED7CE0C8CE192B4EACB68C999@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/7/29 12:22, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Friday, July 29, 2022 11:21 AM
>>
>> On 2022/7/29 10:56, Tian, Kevin wrote:
>>>> +static bool iommu_group_device_pasid_viable(struct iommu_group
>> *group,
>>>> +					    struct device *dev)
>>>> +{
>>>> +	int count;
>>>> +
>>>> +	count = iommu_group_device_count(group);
>>>> +	if (count != 1)
>>>> +		return false;
>>>> +
>>>> +	/*
>>>> +	 * Block PASID attachment in cases where the PCI fabric is
>>>> +	 * routing based on address. PCI/ACS disables that.
>>>> +	 */
>>>> +	if (dev_is_pci(dev))
>>>> +		return pci_acs_path_enabled(to_pci_dev(dev), NULL,
>>>> +					    REQ_ACS_FLAGS);
>>> I think we are leaning toward doing above check in pci_enable_pasid().
>>> Then no singleton check inside iommu core.
>>
>> The iommu grouping also considers other things, like PCI alias. There
>> are many calls of pci_add_dma_alias() in drivers/pci/quirks.c.
>> Therefore, I believe that pci_acs_path_enabled() returning true doesn't
>> guarantees a singleton group.
> 
> Is there an actual problem of sharing PASID table between aliasing RIDs?
> As long as ACS is enabled the device is isolated from other devices
> in the fabric. DMA aliases don't change that fact and there is no p2p
> between aliasing RIDs.

Yes. Agreed.

At present, the visible PASID use cases only occur on the singleton
groups, so we can start to support it from this simple situation. In the
future, if the multi-device groups need to support pasid, we can simply
apply the domain to the PASIDs of all device of the group.

> 
>>
>>>
>>> Presumably similar check can be done in DT/ACPI path of enabling pasid?
>>>
>>
>> I can't find the pasid (or anything similar) enabling interfaces for
>> DT or ACPI. They are device specific?
>>
> 
> Looks only PCI PASID is supported so far. both in Intel/ARM/AMD
> drivers. If other buses will support PASID one day, then ACS-equivalent
> can be also checked in their PASID enabling APIs.

Yes. Fair enough.

Best regards,
baolu
