Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D253168AA
	for <iommu@lists.linux.dev>; Fri, 22 Sep 2023 12:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695384788; x=1726920788;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sJqdK/kSjoMFsRG4y/Ph57Bw+CGEgCkJc9icgC07VWA=;
  b=ZeGIjqU1HfP5Gp5AMVBXBi3kQUrwxUXJ5Kz5IxZtwvunEobrHIe4emWO
   Y4HXIf/pVUktXON1uMNykNNdtlkPvCPAlmHyp5eFYT3QWu0Bja3p6dCoE
   Jh5lo1O7rVnbHCHeYkB37VeLYHROpsfuKhhtVSEAsEsDt68pLZZvLRcmG
   cs2fktDzirWXVaVq6oJmabO03UAKV9tJQ8pVv5Y6Zy7h6pLUkrmm7UW4E
   kBQZrLIkX4hsUuxzhumjzRhxmHZwOBz6Fhy6BcHl6APMG7vDm9/v6qsAY
   wmIOFiwqILbypQuXRhsrPY4YwOtI+3y4yqueMePKRjHoGanRBU/7mMn7/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="447291084"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="447291084"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 05:13:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="724153114"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="724153114"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.255.30.83]) ([10.255.30.83])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 05:13:04 -0700
Message-ID: <a4770035-9f1a-3bff-2ff2-d6b9c81e2c0b@linux.intel.com>
Date: Fri, 22 Sep 2023 20:13:02 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc: baolu.lu@linux.intel.com, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Hegde, Vasant" <Vasant.Hegde@amd.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
 "Huang2, Wei" <Wei.Huang2@amd.com>, "jsnitsel@redhat.com"
 <jsnitsel@redhat.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH v3 1/5] iommu/amd: Remove iommu_v2 module
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20230921093140.6162-1-vasant.hegde@amd.com>
 <20230921093140.6162-2-vasant.hegde@amd.com>
 <BL1PR12MB5144C5ADC106D450EA73C511F7F8A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <20230921141415.GN13733@nvidia.com>
 <BL1PR12MB51449627A11B2BDA55B97C8CF7F8A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <20230921163154.GO13733@nvidia.com>
 <19c7c139-b002-384f-5766-b87a8013029e@linux.intel.com>
 <20230922115927.GI13733@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230922115927.GI13733@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023/9/22 19:59, Jason Gunthorpe wrote:
> On Fri, Sep 22, 2023 at 10:23:26AM +0800, Baolu Lu wrote:
> 
>> 1) PCI device supports ATS but*no*  PASID
>>     In this case, ATS only means a TLB cache in the device, and it does
>>     not make much sense to cache the 1:1 mappings in the device. Even
>>     worse, the ATS translation requests could probably cause I/O
>>     congestion in corner cases. Therefore, the best choice is probably to
>>     disable ATS on the device.
> Nope. We have important use cases where ATS must always be on. 🙁

Oh, I didn't know that. Thank you for letting me know.

> 
> You might make this argument if ACS is also non-isolating though..
> 
> Regardless I think we need to get into a position where the iommu core
> is deciding if PRI or ATS is enabled for a device, not the iommu
> driver.

Agreed. I ever had a series to achieve this and it may be time to
revisit them.

One additional concern is how the core knows whether ATS should be
enabled. In my previous design, the IOMMU core turns on ATS by default
if the device is capable of it, but the driver could enable/disable it
from its driver probe() callback.

Does it make sense?

Best regards,
baolu
