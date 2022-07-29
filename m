Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BD37A
	for <iommu@lists.linux.dev>; Fri, 29 Jul 2022 03:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659064874; x=1690600874;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kJsMSRMn4triv25Il9mhWiVI3dfthWPMlrBpNxMmXo8=;
  b=MPkDo2jta8zSVnQYzx+mJz5GQ9Y3CbXGm0VDyS+rgc45y0kJKP2Ugy1j
   +IOFCwB/tzgKKejdfVDc1/jxEQ8PwQC7YMcDxKJaxMHWxQVg4wDsrMRZZ
   2wGdXQKqrDv567nGrVHy5FohQa2qoczqM6oR1/zz7zh8Xy64HT5Yoh3AJ
   S2BmuM2gY3qcuSuaAxOvRiRWrXyYk6dkI2NdWiGZMa91RX94Ow8021iQR
   BvcID9jdJLESk9w4TM2feRqCmt0Ma1DOxdwKB4xtEXSQkmNZEFWrbWhGP
   2Ia9bVs2OurCcpPZihI0+UqvcpmGA5Gogs08mIgy/pHDMV96VPPB02Kty
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="352678529"
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="352678529"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 20:20:55 -0700
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="660057778"
Received: from xuzhenzh-mobl.ccr.corp.intel.com (HELO [10.249.174.84]) ([10.249.174.84])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 20:20:51 -0700
Message-ID: <64667345-7f7f-74ec-215a-f2d36be0f9ce@linux.intel.com>
Date: Fri, 29 Jul 2022 11:20:49 +0800
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
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v10 04/12] iommu: Add attach/detach_dev_pasid iommu
 interface
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
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52761058CFCB9397F6A73A958C999@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/7/29 10:56, Tian, Kevin wrote:
>> +static bool iommu_group_device_pasid_viable(struct iommu_group *group,
>> +					    struct device *dev)
>> +{
>> +	int count;
>> +
>> +	count = iommu_group_device_count(group);
>> +	if (count != 1)
>> +		return false;
>> +
>> +	/*
>> +	 * Block PASID attachment in cases where the PCI fabric is
>> +	 * routing based on address. PCI/ACS disables that.
>> +	 */
>> +	if (dev_is_pci(dev))
>> +		return pci_acs_path_enabled(to_pci_dev(dev), NULL,
>> +					    REQ_ACS_FLAGS);
> I think we are leaning toward doing above check in pci_enable_pasid().
> Then no singleton check inside iommu core.

The iommu grouping also considers other things, like PCI alias. There
are many calls of pci_add_dma_alias() in drivers/pci/quirks.c.
Therefore, I believe that pci_acs_path_enabled() returning true doesn't
guarantees a singleton group.

> 
> Presumably similar check can be done in DT/ACPI path of enabling pasid?
> 

I can't find the pasid (or anything similar) enabling interfaces for
DT or ACPI. They are device specific?

Best regards,
baolu
