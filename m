Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF537C
	for <iommu@lists.linux.dev>; Thu, 13 Jul 2023 03:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689219849; x=1720755849;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dSMjRg8ZP7ic8vMjHznYMQB4EEK/y11162LRsTfQBE4=;
  b=J95AV6JfeOdDSiL0yJLeT/Z6N61DkacaR4TttemrO90mrQ7jsfvit+Uu
   cwP7i1j1/ggLl1VaWrFDUT6TgWC280KJpjCT0Vl8v0yJr1Yg8P9Ze47Xl
   IrCroOgRAUXz73EJbm4g0i4jCk70PRCghi1MW2d71GV217x9pUOrxHW5Z
   5FWZwLGh5tMT3njpIlksM7HlWRS0WfZjlGRUww4KDMDaleH8YdDwtJT+f
   zU/jQxNFWOgE9PQRmDn5Ab7wxr6OrzssTbXwdIFJzq9IMLoxbwAZJOBNz
   DJKJ4huaT6H3BQYopE9rLHvtDFzwsGEtSv8voxhHhNJS34T1xXyDqOItF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="363945255"
X-IronPort-AV: E=Sophos;i="6.01,201,1684825200"; 
   d="scan'208";a="363945255"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 20:44:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="715788445"
X-IronPort-AV: E=Sophos;i="6.01,201,1684825200"; 
   d="scan'208";a="715788445"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.187.96]) ([10.252.187.96])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 20:43:58 -0700
Message-ID: <cf793119-591f-19b5-b708-45c6f3eadc79@linux.intel.com>
Date: Thu, 13 Jul 2023 11:43:55 +0800
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
 Jason Gunthorpe <jgg@ziepe.ca>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 9/9] iommu: Use fault cookie to store iopf_param
To: "Tian, Kevin" <kevin.tian@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20230711010642.19707-1-baolu.lu@linux.intel.com>
 <20230711010642.19707-10-baolu.lu@linux.intel.com>
 <20230711150249.62917dad@jacob-builder>
 <e26db44c-ec72-085d-13ee-597237ba2134@linux.intel.com>
 <BN9PR11MB527640E6FBD5271E8AF9D59B8C37A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527640E6FBD5271E8AF9D59B8C37A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/7/13 11:24, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Wednesday, July 12, 2023 11:13 AM
>>
>> On 2023/7/12 6:02, Jacob Pan wrote:
>>> On Tue, 11 Jul 2023 09:06:42 +0800, Lu Baolu<baolu.lu@linux.intel.com>
>>> wrote:
>>>
>>>> @@ -158,7 +158,7 @@ int iommu_queue_iopf(struct iommu_fault *fault,
>>>> struct device *dev)
>>>>    	 * As long as we're holding param->lock, the queue can't be
>>>> unlinked
>>>>    	 * from the device and therefore cannot disappear.
>>>>    	 */
>>>> -	iopf_param = param->iopf_param;
>>>> +	iopf_param = iommu_get_device_fault_cookie(dev, 0);
>>> I am not sure I understand how does it know the cookie type is iopf_param
>>> for PASID 0?
>>>
>>> Between IOPF and IOMMUFD use of the cookie, cookie types are different,
>>> right?
>>>
>>
>> The fault cookie is managed by the code that delivers or handles the
>> faults. The sva and IOMMUFD paths are exclusive.
>>
> 
> what about siov? A siov-capable device can support sva and iommufd
> simultaneously.

For siov case, the pasid should be global. RID and each pasid are still
exclusive, so I don't see any problem. Did I overlook anything?

Best regards,
baolu
