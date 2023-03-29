Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED17A10E3
	for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 06:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680071318; x=1711607318;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GuGO5s9eIj9SNxl6Nky1S/mvzj2pjVXEbD7qhLrdzag=;
  b=Y/3BIqAjhrsPs6kKBfHF3ippoUImXmnuLRTbn1RbKMJL+kEnbQq5ncmN
   0aSMRGdpfBeCa6ygnGl6EFpgOriQSEe7C9HJldiAIvJuddibTbvDjvIgj
   GGm/awr3rLg13iklewU6/5Efsz3BOyEXrN3gwzCb238YElKcI0uNdyJ2H
   9RckQNqtFgTyAJL1rK8tmUXaT5IeavvIvqnBaM23N8vkr5mfUywEwr/++
   H66EylHczcmQQKI+aXDmiWAeez6C9SydlmCVZasC9ApFm2ZcLJX5glEms
   NFQuvg5Iwd+lmKk4gCV6T8plZZe1AE2V6By3TTinRJGIL9m11wlgfMM+0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="340812839"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="340812839"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 23:28:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="808083289"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="808083289"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga004.jf.intel.com with ESMTP; 28 Mar 2023 23:28:33 -0700
Message-ID: <5d22bbeb-8630-9aa2-bc49-32b391ae577e@linux.intel.com>
Date: Wed, 29 Mar 2023 14:28:51 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc: baolu.lu@linux.intel.com, LKML <linux-kernel@vger.kernel.org>,
 iommu@lists.linux.dev, Jason Gunthorpe <jgg@nvidia.com>,
 Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org, vkoul@kernel.org,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Raj Ashok <ashok.raj@intel.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 "Yu, Fenghua" <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Tony Luck <tony.luck@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: Re: [PATCH v2 7/8] iommu: Export iommu_get_dma_domain
Content-Language: en-US
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
 <20230327232138.1490712-8-jacob.jun.pan@linux.intel.com>
 <e7d53d04-6b7f-05a4-3077-42470c6d2823@linux.intel.com>
 <20230328084855.7b9cd981@jacob-builder>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230328084855.7b9cd981@jacob-builder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/28/23 11:48 PM, Jacob Pan wrote:
> On Tue, 28 Mar 2023 14:04:15 +0800, Baolu Lu<baolu.lu@linux.intel.com>
> wrote:
> 
>> On 3/28/23 7:21 AM, Jacob Pan wrote:
>>> Devices that use ENQCMDS to submit work needs to retrieve its DMA
>>> domain. It can then attach PASID to the DMA domain for shared mapping
>>> (with RID) established by DMA API.
>>>
>>> Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>
>>> ---
>>>    drivers/iommu/iommu.c | 1 +
>>>    include/linux/iommu.h | 5 +++++
>>>    2 files changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>> index 10db680acaed..c51d343a75d2 100644
>>> --- a/drivers/iommu/iommu.c
>>> +++ b/drivers/iommu/iommu.c
>>> @@ -2118,6 +2118,7 @@ struct iommu_domain *iommu_get_dma_domain(struct
>>> device *dev) {
>>>    	return dev->iommu_group->default_domain;
>>>    }
>>> +EXPORT_SYMBOL_GPL(iommu_get_dma_domain);
>> Directly exporting this function for external use seems unsafe. If the
>> caller is the kernel driver for this device, it's fine because default
>> domain remains unchanged during the life cycle of the driver. Otherwise,
>> using this function may cause UAF. Keep in mind that group's default
>> domain could be changed through sysfs.
> don't you have to unload the driver?

Yes, of cause.

Hence, the getting domain interfaces are only safe to be used in the
driver of the device.

Best regards,
baolu
