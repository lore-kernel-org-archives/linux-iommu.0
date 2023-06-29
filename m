Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A017710ED
	for <iommu@lists.linux.dev>; Thu, 29 Jun 2023 01:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688000836; x=1719536836;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=b9GdT6r2b9r4HGFh4jKr0wne/bp8GHgArZMHuUjrA0Y=;
  b=c452Wr/pCsAKGOCw1KUDOajDTzrJECUWtzRAgeMErZXXI22768ukv7qN
   fsUAmHjyQbw0tUsWNVd5odNGsXfdb70MGCSQCG7tVM9XkvTxBW5DNa4CN
   e5+iNuNX+1bRycxKe99CfGlzPo3ZQLICfLItQysyKGvKNqTl4qvyNL/i5
   a1A7BgmwAeH0LhWud8BmK4wAMVvh0clvAbbP3WdbKDvIULcssvXIwRCWD
   PR8RvPTu20bR3igaIXGJzMtvWqz9wOJqLbEp6F6YFZD7sT+ExbKNxnQrb
   +PgDfHUcFd6XB1uVVNGVQv7mhQA2v0HjoKhUySoHaXlCJWUXBsTTQ6cQ4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="341581966"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="341581966"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 18:07:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="717179669"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="717179669"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.186.48]) ([10.252.186.48])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 18:07:09 -0700
Message-ID: <7669371f-c529-78ec-1303-9b3a6e23cdce@linux.intel.com>
Date: Thu, 29 Jun 2023 09:07:04 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Cc: baolu.lu@linux.intel.com, Nicolin Chen <nicolinc@nvidia.com>,
 Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, Yi Liu
 <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 iommu@lists.linux.dev, linux-kselftest@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCHES 00/17] IOMMUFD: Deliver IO page faults to user space
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20230530053724.232765-1-baolu.lu@linux.intel.com>
 <ZHZFi28jRxeZMKK3@Asurada-Nvidia>
 <a8ccbac8-c456-d116-24a2-7503ccbb720c@linux.intel.com>
 <ZJnZ7bEIZHsqmyAG@ziepe.ca>
 <26b97776-7ce5-51f6-77b7-0ce837aa7cca@linux.intel.com>
 <ZJwsW3eFy0bMhkOt@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZJwsW3eFy0bMhkOt@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/6/28 20:49, Jason Gunthorpe wrote:
> On Wed, Jun 28, 2023 at 10:00:56AM +0800, Baolu Lu wrote:
>>> If the driver created a SVA domain then the op should point to some
>>> generic 'handle sva fault' function. There shouldn't be weird SVA
>>> stuff in the core code.
>>>
>>> The weird SVA stuff is really just a generic per-device workqueue
>>> dispatcher, so if we think that is valuable then it should be
>>> integrated into the iommu_domain (domain->ops->use_iopf_workqueue =
>>> true for instance). Then it could route the fault through the
>>> workqueue and still invoke domain->ops->iopf_handler.
>>>
>>> The word "SVA" should not appear in any of this.
>>
>> Yes. We should make it generic. The domain->use_iopf_workqueue flag
>> denotes that the page faults of a fault group should be put together and
>> then be handled and responded in a workqueue. Otherwise, the page fault
>> is dispatched to domain->iopf_handler directly.
> 
> It might be better to have iopf_handler and
> iopf_handler_work function pointers to distinguish to two cases.

Both are okay. Let's choose one when we have the code.

> 
>>> Not sure what iommu_register_device_fault_handler() has to do with all
>>> of this.. Setting up the dev_iommu stuff to allow for the workqueue
>>> should happen dynamically during domain attach, ideally in the core
>>> code before calling to the driver.
>>
>> There are two pointers under struct dev_iommu for fault handling.
>>
>> /**
>>   * struct dev_iommu - Collection of per-device IOMMU data
>>   *
>>   * @fault_param: IOMMU detected device fault reporting data
>>   * @iopf_param:  I/O Page Fault queue and data
>>
>> [...]
>>
>> struct dev_iommu {
>>          struct mutex lock;
>>          struct iommu_fault_param        *fault_param;
>>          struct iopf_device_param        *iopf_param;
>>
>> My understanding is that @fault_param is a place holder for generic
>> things, while @iopf_param is workqueue specific.
> 
> Well, lets look
> 
> struct iommu_fault_param {
> 	iommu_dev_fault_handler_t handler;
> 	void *data;
> 
> These two make no sense now. handler is always iommu_queue_iopf. Given
> our domain centric design we want the function pointer in the domain,
> not in the device. So delete it.

Agreed.

> 
> 	struct list_head faults;
> 	struct mutex lock;
> 
> Queue of unhandled/unacked faults? Seems sort of reasonable

It's the list of faults pending for response.

>> @iopf_param could be allocated on demand. (perhaps renaming it to a more
>> meaningful one?) It happens before a domain with use_iopf_workqueue flag
>> set attaches to a device. iopf_param keeps alive until device_release.
> 
> Yes
> 
> Do this for the iommu_fault_param as well, in fact, probably just put
> the two things together in one allocation and allocate if we attach a
> PRI using domain. I don't think we need to micro optimze further..

Yeah, let me try this.

Best regards,
baolu

