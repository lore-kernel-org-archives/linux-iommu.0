Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0131F79F8
	for <iommu@lists.linux.dev>; Thu, 31 Aug 2023 09:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693474941; x=1725010941;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=W1YtMODMLSjOhRWA42ANSxqsEnXqVPHuzMfRWe19dvM=;
  b=nBZpoGdJNyuLlU+0HTXoE4GN2M1y/mskDGxRmj3F+ILEf9GMKAvPPM4N
   3mlzNs8fcW2uUpO+e+B89BNrjcEy/4m28sFW6w1P42bdgo32yduQ0UvYt
   Gy4THVSF58Qd74/p2ncyjIcAlr0LQ9hTdQTBRMAlcxpzfxw7AZdpMhlnx
   F+rthxlTOasbeKIaAiFbSjlbZUiShJ/BwAk4tY1TpUYTvfPA7qpe6XZNi
   kbpj7wi2IjMpTiFwM0aU5XCkxESapapBLJIJ9xx2Ac/u5PktJdxwuAgrF
   Feh6oUL/gg2lOz/iBjbJ6X+5RZdXFE3yYumofCFAsWi0E12eraLjAeFXw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="355385886"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="355385886"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 02:42:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="768718914"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="768718914"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.210.87]) ([10.254.210.87])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 02:42:15 -0700
Message-ID: <94c39a16-cd25-7cd2-33dd-f6bd43056db4@linux.intel.com>
Date: Thu, 31 Aug 2023 17:42:13 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Cc: baolu.lu@linux.intel.com, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 09/10] iommu: Make iommu_queue_iopf() more generic
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20230825023026.132919-1-baolu.lu@linux.intel.com>
 <20230825023026.132919-10-baolu.lu@linux.intel.com>
 <BN9PR11MB52762A33BC9F41AB424915688CE3A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <cbfbe969-1a92-52bf-f00c-3fb89feefd66@linux.intel.com>
 <BN9PR11MB527624F1CC4A545FBAE3C9C98CE6A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <BN9PR11MB5276E7D9BCD0A7C1D38D624D8CE6A@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276E7D9BCD0A7C1D38D624D8CE6A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/8/30 16:50, Tian, Kevin wrote:
>> From: Tian, Kevin
>> Sent: Wednesday, August 30, 2023 3:44 PM
>>
>>> From: Baolu Lu<baolu.lu@linux.intel.com>
>>> Sent: Saturday, August 26, 2023 4:01 PM
>>>
>>> On 8/25/23 4:17 PM, Tian, Kevin wrote:
>>>>> +
>>>>>    /**
>>>>>     * iopf_queue_flush_dev - Ensure that all queued faults have been
>>>>> processed
>>>>>     * @dev: the endpoint whose faults need to be flushed.
>>>> Presumably we also need a flush callback per domain given now
>>>> the use of workqueue is optional then flush_workqueue() might
>>>> not be sufficient.
>>>>
>>> The iopf_queue_flush_dev() function flushes all pending faults from the
>>> IOMMU queue for a specific device. It has no means to flush fault queues
>>> out of iommu core.
>>>
>>> The iopf_queue_flush_dev() function is typically called when a domain is
>>> detaching from a PASID. Hence it's necessary to flush the pending faults
>>> from top to bottom. For example, iommufd should flush pending faults in
>>> its fault queues after detaching the domain from the pasid.
>>>
>> Is there an ordering problem? The last step of intel_svm_drain_prq()
>> in the detaching path issues a set of descriptors to drain page requests
>> and responses in hardware. It cannot complete if not all software queues
>> are drained and it's counter-intuitive to drain a software queue after
>> the hardware draining has already been completed.
> to be clear it's correct to drain request queues from bottom to top as the
> lower level queue is the input to the higher level queue. But for response
> the lowest draining needs to wait for response from higher levels. It's
> interesting that intel-iommu driver combines draining hw page requests
> and responses in one step in intel_svm_drain_prq(). this also needs some
> consideration regarding to iommufd...
> 

I agree with you. For the responses, we can iterate over the list of
page requests pending to respond. If any fault matches the pasid and the
device, we can drain it by responding IOMMU_PAGE_RESP_INVALID to the
device.

After that the responses for the drained faults will be dropped by the
iommu_page_response() interface.

Best regards,
baolu
