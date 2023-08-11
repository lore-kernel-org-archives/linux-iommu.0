Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98537F1
	for <iommu@lists.linux.dev>; Fri, 11 Aug 2023 01:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691717043; x=1723253043;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vCgMYStlmDlVJXKeZPtoTbQHCySrsyYJ68bnKcTfn8w=;
  b=AOGNvHyuf7RyMvEYgHfgo7SJ5Zi8ChRgrKZAC6mTpNezcvJXC5kegguL
   8S5v9hzmxjas01cBjU2clZUyEe0torJD5pI+zNajwL5EJcPZWnf73luWw
   /Y+tZOr9z3wzBcfTXSJa4vKxNB2VJx8mSyyLUGUDe0tQzv2Khc2X5NuqC
   PAWKTU5ttHxGS9TVu7S8PPv/H+Mt0aKvi5LNvrBuJWkhAQwc4wqPeZgCP
   +/k7tnapwWyIH+vA5jx7ETdpZBsX97PJipzfhAOy6wEYnuPPoqfigX3v3
   2hqVQxN4yVH/rXvWg+PHr+wXrWbNfpR1FZA02BaFzs6HLJmy/iM4Ng7YC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="375278987"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="375278987"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 18:24:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="822483106"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="822483106"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.214.70]) ([10.254.214.70])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 18:23:57 -0700
Message-ID: <3882aec9-c221-f431-c0f7-a764ca947655@linux.intel.com>
Date: Fri, 11 Aug 2023 09:23:55 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/12] iommu: Replace device fault handler with
 iommu_queue_iopf()
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20230727054837.147050-1-baolu.lu@linux.intel.com>
 <20230727054837.147050-5-baolu.lu@linux.intel.com>
 <ZNUq2IcvjEkwQewc@ziepe.ca>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZNUq2IcvjEkwQewc@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/8/11 2:22, Jason Gunthorpe wrote:
> On Thu, Jul 27, 2023 at 01:48:29PM +0800, Lu Baolu wrote:
>> The individual iommu drivers report iommu faults by calling
>> iommu_report_device_fault(), where a pre-registered device fault handler
>> is called to route the fault to another fault handler installed on the
>> corresponding iommu domain.
>>
>> The pre-registered device fault handler is static and won't be dynamic
>> as the fault handler is eventually per iommu domain. Replace calling
>> device fault handler with iommu_queue_iopf().
>>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/iommu.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 4352a149a935..00309f66153b 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -1381,7 +1381,7 @@ int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
>>   		mutex_unlock(&fparam->lock);
>>   	}
>>   
>> -	ret = fparam->handler(&evt->fault, fparam->data);
>> +	ret = iommu_queue_iopf(&evt->fault, dev);
>>   	if (ret && evt_pending) {
>>   		mutex_lock(&fparam->lock);
>>   		list_del(&evt_pending->list);
> I don't get it, why not remove fparam->handler/data entirely in this
> patch? There is no user once you do this change?

It needs some cleanups elsewhere, so I put it in a separate patch.

Best regards,
baolu
