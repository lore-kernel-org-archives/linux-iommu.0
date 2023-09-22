Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F31B7FD
	for <iommu@lists.linux.dev>; Fri, 22 Sep 2023 02:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695350880; x=1726886880;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WjtJKQb906FAD2/Ch7XLbjda8s1yVinX4tQX05erhW4=;
  b=ZdLo7uEU8FpZ80EwWlPfViDQXHt0jCF7Sl5Pt/aki2OkXC+k3tl8PQlB
   z1deOjOOESomec9N6vdC+sk54iXYwKsVJdfBW2lNuA/8CfCC68K4Ougwm
   jHC23pVLHWFTDoOD7ZmfbFlNK+9Eb2LGCcgpqGDXtcJ8+fu/LpTDYWzcU
   aFDDs/GdezEmTlo7LvZC72mFJ3G08zQHmdzW+zhyzQYkDsS2M4v7WFF7W
   lI7cGb4czj7LYtG9gyYzkVUoI4VOk2i1Mb1apF635lWLvMylglMJS3zjd
   D8kAmdSs6bzZsq2ruSwiTYVJqzZkYCOleUWCgQ0WiEQNyPglb39xeClFD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="360974365"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="360974365"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 19:47:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="920986298"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="920986298"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga005.jf.intel.com with ESMTP; 21 Sep 2023 19:47:55 -0700
Message-ID: <e7c773f6-969c-0097-1bca-24d276e8a8f6@linux.intel.com>
Date: Fri, 22 Sep 2023 10:44:45 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 09/12] iommu: Make iommu_queue_iopf() more generic
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>, "Liu, Jingqi" <jingqi.liu@intel.com>
References: <20230914085638.17307-1-baolu.lu@linux.intel.com>
 <20230914085638.17307-10-baolu.lu@linux.intel.com>
 <f20b9e78-3a63-ca3e-6c04-1d80ec857898@intel.com>
 <20230921233402.GC13795@ziepe.ca>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230921233402.GC13795@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/22/23 7:34 AM, Jason Gunthorpe wrote:
> On Thu, Sep 21, 2023 at 11:25:56PM +0800, Liu, Jingqi wrote:
>>
>> On 9/14/2023 4:56 PM, Lu Baolu wrote:
>>> Make iommu_queue_iopf() more generic by making the iopf_group a minimal
>>> set of iopf's that an iopf handler of domain should handle and respond
>>> to. Add domain parameter to struct iopf_group so that the handler can
>>> retrieve and use it directly.
>>>
>>> Change iommu_queue_iopf() to forward groups of iopf's to the domain's
>>> iopf handler. This is also a necessary step to decouple the sva iopf
>>> handling code from this interface.
>>>
>>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>> ---
>>>    include/linux/iommu.h      |  4 ++--
>>>    drivers/iommu/iommu-sva.h  |  6 ++---
>>>    drivers/iommu/io-pgfault.c | 49 ++++++++++++++++++++++++++++----------
>>>    drivers/iommu/iommu-sva.c  |  3 +--
>>>    4 files changed, 42 insertions(+), 20 deletions(-)
>>>
>> ......
>>
>>> @@ -112,6 +110,7 @@ int iommu_queue_iopf(struct iommu_fault *fault, struct device *dev)
>>>    {
>>>    	int ret;
>>>    	struct iopf_group *group;
>>> +	struct iommu_domain *domain;
>>>    	struct iopf_fault *iopf, *next;
>>>    	struct iommu_fault_param *iopf_param;
>>>    	struct dev_iommu *param = dev->iommu;
>>> @@ -143,6 +142,19 @@ int iommu_queue_iopf(struct iommu_fault *fault, struct device *dev)
>>>    		return 0;
>>>    	}
>>> +	if (fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID)
>>> +		domain = iommu_get_domain_for_dev_pasid(dev, fault->prm.pasid, 0);
>>> +	else
>>> +		domain = iommu_get_domain_for_dev(dev);
>>> +
>>> +	if (!domain || !domain->iopf_handler) {
>>
>> Does it need to check if 'domain' is error ?  Like below:
>>
>>           if (!domain || IS_ERR(domain) || !domain->iopf_handler)
> 
> Urk, yes, but not like that
> 
> The IF needs to be moved into the else block as each individual
> function has its own return convention.

iommu_get_domain_for_dev_pasid() returns an ERR_PTR only if the matching
domain type is specified (non-zero).

Adding IS_ERR(domain) in the else block will make the code more
readable. Alternatively we can put a comment around above code to
explain that ERR_PTR is not a case here.

Best regards,
baolu
