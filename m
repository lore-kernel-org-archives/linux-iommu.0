Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8A0B65B
	for <iommu@lists.linux.dev>; Wed, 13 Sep 2023 06:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694585944; x=1726121944;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gXx1hvpx2HZolUiJN5DvXobD3nkeVdRetajrTVny9lU=;
  b=kE32guir/itE28cbcNSCek90pdhRYP/9HH6iCknX9UHM5jEvdVpvLkdf
   5Ob+l15RsyBAD9L8rH0x+ZBtpvA/MEV1TQZydZW5DJl7sxWfoJjsd9WBl
   YCmN9I/zz4UQ9AJ5QztHV72GvwU1uvg46qxfAOJ0rlPtPrdzdXL+l2HoU
   642kLBOeOQBc0fxM1dZIKDnRDZnTA+wEpsQ3LcvcVowd5h1sXZGY3rjLK
   t/s3lSO3CMgrYqVHac46LlDgC5djjicwmu8Ib0EsHrp/NsHxyZ2Coc1rL
   CWlthsk5XBsshDrqtm46u3Yet7zRhx0K4pKV1JQ4V5oGYyIKREnUFsZ47
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="445015013"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="445015013"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 23:19:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="779079996"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="779079996"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.255.28.153]) ([10.255.28.153])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 23:18:58 -0700
Message-ID: <2d41220e-cab0-b931-b8be-b394ee8f301e@linux.intel.com>
Date: Wed, 13 Sep 2023 14:18:56 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Cc: baolu.lu@linux.intel.com, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 09/10] iommu: Make iommu_queue_iopf() more generic
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20230825023026.132919-1-baolu.lu@linux.intel.com>
 <20230825023026.132919-10-baolu.lu@linux.intel.com>
 <BN9PR11MB52762A33BC9F41AB424915688CE3A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <cfd9e0b8-167e-a79b-9ef1-b3bfa38c9199@linux.intel.com>
 <BN9PR11MB5276926066CC3A8FCCFD3DB08CE6A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ed11a5c4-7256-e6ea-e94e-0dfceba6ddbf@linux.intel.com>
 <BN9PR11MB5276622C8271402487FA44708CE4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <c9228377-0a5c-adf8-d0ef-9a791226603d@linux.intel.com>
 <BN9PR11MB52764790D53DF8AB4ED417098CF2A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <eca39154-bc45-3c7d-88a9-b377f4d248f9@linux.intel.com>
 <BN9PR11MB52769C830A65FCE6CBA037278CF0A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52769C830A65FCE6CBA037278CF0A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/9/13 10:34, Tian, Kevin wrote:
>> From: Baolu Lu<baolu.lu@linux.intel.com>
>> Sent: Monday, September 11, 2023 8:46 PM
>>
>> On 2023/9/11 14:57, Tian, Kevin wrote:
>>>> From: Baolu Lu<baolu.lu@linux.intel.com>
>>>> Sent: Tuesday, September 5, 2023 1:24 PM
>>>>
>>>> Hi Kevin,
>>>>
>>>> I am trying to address this issue in below patch. Does it looks sane to
>>>> you?
>>>>
>>>> iommu: Consolidate per-device fault data management
>>>>
>>>> The per-device fault data is a data structure that is used to store
>>>> information about faults that occur on a device. This data is allocated
>>>> when IOPF is enabled on the device and freed when IOPF is disabled. The
>>>> data is used in the paths of iopf reporting, handling, responding, and
>>>> draining.
>>>>
>>>> The fault data is protected by two locks:
>>>>
>>>> - dev->iommu->lock: This lock is used to protect the allocation and
>>>>      freeing of the fault data.
>>>> - dev->iommu->fault_parameter->lock: This lock is used to protect the
>>>>      fault data itself.
>>>>
>>>> Improve the iopf code to enforce this lock mechanism and add a
>> reference
>>>> counter in the fault data to avoid use-after-free issue.
>>>>
>>> Can you elaborate the use-after-free issue and why a new user count
>>> is required?
>> I was concerned that when iommufd uses iopf, page fault report/response
>> may occur simultaneously with enable/disable PRI.
>>
>> Currently, this is not an issue as the enable/disable PRI is in its own
>> path. In the future, we may discard this interface and enable PRI when
>> attaching the first PRI-capable domain, and disable it when detaching
>> the last PRI-capable domain.
> Then let's not do it now until there is a real need after you have a
> thorough design for iommufd.

I revisited this part of code and found that it's still valuable to make
the code clean and simple. The fault parameter is accessed in various
paths, such as reporting iopf, responding iopf, draining iopf's, adding
queue and removing queue. In each path, we need to repeat below locking
code:

	mutex_lock(&dev->iommu->lock);
	fault_param = dev->iommu->fault_param;
	if (!fault_param) {
		mutex_unlock(&dev->iommu->lock);
		return -ENODEV;
	}

	/* use the fault parameter */
	... ...

	mutex_unlock(&dev->iommu->lock);

The order of the locks is also important. Otherwise, a possible deadlock
issue will be reported by lockdep.

By consolidating above code in iopf_get/put_dev_fault_param() helpers,
it could be simplified as:

	fault_param = iopf_get_dev_fault_param(dev);
	if (!fault_param)
		return -ENODEV;

	/* use the fault parameter */
	... ...

	iopf_put_dev_fault_param(fault_param);

The lock order issue is removed. And it will make the code simpler and
easier for maintenance.

Best regards,
baolu
