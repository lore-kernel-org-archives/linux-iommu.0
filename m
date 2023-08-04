Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6A91FC2
	for <iommu@lists.linux.dev>; Fri,  4 Aug 2023 02:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691116222; x=1722652222;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ww28U0Yxcn4IXXWb/1angMkXspXgSO7vMBOjgVhYIMA=;
  b=eS5denZFHHq5DmtCAkyk7o7kqvIce1JbB8U3YYZKnVmMNs/L6RcMF+sZ
   yR7CCo2tdYNKYswWiWaZPFbCw8faDkzYPJvWH0tTqZ22fAe4N6nZTUhFY
   2u9wfdYzTNWDaTYJU+DwzAhIZ8mBEItrC+tYow7ynOm+OcLca/i+uuHqH
   Znnnog4s3BTuwfE1rx8kc9RaEdZxOwmWGPVkW75ElbFXz74XVqcFeQN+C
   7t9GPXovJeNrKxiRt4wC1chIv1FEZSGYYT+h5FHX3UtiJqLcPU6xwPWCO
   mYWbNaVXhTZ/x9veW5WpXTtbl06L0Ap8ueFxJr4xE+bNJ4LsADoophSlR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="401001583"
X-IronPort-AV: E=Sophos;i="6.01,253,1684825200"; 
   d="scan'208";a="401001583"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 19:30:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="819919134"
X-IronPort-AV: E=Sophos;i="6.01,253,1684825200"; 
   d="scan'208";a="819919134"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.210.88]) ([10.254.210.88])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 19:30:14 -0700
Message-ID: <ff357c87-f554-d89c-ce0e-e38886374da5@linux.intel.com>
Date: Fri, 4 Aug 2023 10:30:12 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] iommu: Make pasid array per device
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>, "Tian, Kevin" <kevin.tian@intel.com>
References: <20230801063125.34995-1-baolu.lu@linux.intel.com>
 <ZMplBfgSb8Hh9jLt@ziepe.ca>
 <BN9PR11MB527649D7E79E29291DA1A5538C08A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZMvFR52o86upAVrp@ziepe.ca>
 <15c6f634-f00a-dfa7-9759-161ec201460a@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <15c6f634-f00a-dfa7-9759-161ec201460a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023/8/4 10:20, Baolu Lu wrote:
> On 2023/8/3 23:18, Jason Gunthorpe wrote:
>> On Thu, Aug 03, 2023 at 12:44:03AM +0000, Tian, Kevin wrote:
>>>> From: Jason Gunthorpe<jgg@ziepe.ca>
>>>> Sent: Wednesday, August 2, 2023 10:16 PM
>>>>
>>>> On Tue, Aug 01, 2023 at 02:31:23PM +0800, Lu Baolu wrote:
>>>>> The PCI PASID enabling interface guarantees that the address space 
>>>>> used
>>>>> by each PASID is unique. This is achieved by checking that the PCI ACS
>>>>> path is enabled for the device. If the path is not enabled, then the
>>>>> PASID feature cannot be used.
>>>>>
>>>>>      if (!pci_acs_path_enabled(pdev, NULL, PCI_ACS_RR | PCI_ACS_UF))
>>>>>              return -EINVAL;
>>>>>
>>>>> The PASID array is not an attribute of the IOMMU group. It is more
>>>>> natural to store the PASID array in the per-device IOMMU data. This
>>>>> makes the code clearer and easier to understand. No functional changes
>>>>> are intended.
>>>> Is there a reason to do this?
>>>>
>>>> *PCI*  requires the ACS/etc because PCI kind of messed up how switches
>>>> handled PASID so PASID doesn't work otherwise.
>>>>
>>>> But there is nothing that says other bus type can't have working
>>>> (non-PCI) PASID and still have device isolation issues.
>>>>
>>>> So unless there is a really strong reason to do this we should keep
>>>> the PASID list in the group just like the domain.
>>>>
>>> this comes from the consensus in [1].
>>>
>>> [1]https://lore.kernel.org/linux-iommu/ZAcyEzN4102gPsWC@nvidia.com/
>> That consensus was that we don't have PASID support if there is
>> multi-device groups, at least in iommufd.. That makes sense. If we
>> want to change the core code to enforce this that also makes sense
> 
> In my initial plan, I had a third patch that would have enforced single-
> device groups for PASID interfaces in the core. But I ultimately dropped
> it because it is the fact for PCI devices, but I am not sure about other
> buses although perhaps there is none.
> 
>> But this series is just moving the array?
> 
> So I took the first step by moving the pasid_array from iommu group to
> the device. 😄

In my mind, iommu_group was introduced to solve the PCI alias and P2P
transactions which bypass IOMMU translation. When we enter the PASID
world, the architecture should disallow these anymore. Hence, it's safe
to move pasid_array to device.

This was the motivation of this series.

Best regards,
baolu
