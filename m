Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C13C746B
	for <iommu@lists.linux.dev>; Tue, 22 Aug 2023 07:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692690167; x=1724226167;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PtfQlBNpQEHy7YglStwyz4T6JAjzzd90JE4ZiwNrUUI=;
  b=l70OAzj7pAgwAqzRDo2l32lcGhsj48hzVvEkD83LvcQupuBsT8HgJlpF
   PpN7AwpdTEbUpQsWP+qY2MUE6F9aUi+XFAyJqXf8HJe4LM8isI2GZokWy
   hX7iIKKud5ex74lHIXMfmdnLKgQOHRvw1i7mnt9BuouvvrrH/bT4YyV3j
   8q9DJqyB8gYmYwsCX2+50v/sBMhsKy8flr6O5AzEgg30mogByqkB3E+Zh
   Fxbl144/Ohv5ZP7FWBytekBlN+PZqvOu6KubLv4kGnvWo5gdzf/xnNCdH
   Uvy/fUTSpcUUrGa7bMGLEQLUTiWtMHFmeIJV9RRzGP7/pQxu63IDoP4wq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="440176175"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="440176175"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 00:42:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="771268894"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="771268894"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.189.107]) ([10.252.189.107])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 00:42:41 -0700
Message-ID: <ed0c0d2b-dee0-dd43-dee4-a73a46686168@linux.intel.com>
Date: Tue, 22 Aug 2023 15:42:37 +0800
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
Subject: Re: [PATCH v3 05/11] iommu: Merge iopf_device_param into
 iommu_fault_param
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20230817234047.195194-1-baolu.lu@linux.intel.com>
 <20230817234047.195194-6-baolu.lu@linux.intel.com>
 <ZOOZJ/aQNKY2UDxj@ziepe.ca>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZOOZJ/aQNKY2UDxj@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/8/22 1:04, Jason Gunthorpe wrote:
> On Fri, Aug 18, 2023 at 07:40:41AM +0800, Lu Baolu wrote:
>> @@ -472,21 +473,31 @@ struct iommu_fault_event {
>>    * struct iommu_fault_param - per-device IOMMU fault data
>>    * @handler: Callback function to handle IOMMU faults at device level
>>    * @data: handler private data
>> - * @faults: holds the pending faults which needs response
>>    * @lock: protect pending faults list
>> + * @dev: the device that owns this param
>> + * @queue: IOPF queue
>> + * @queue_list: index into queue->devices
>> + * @partial: faults that are part of a Page Request Group for which the last
>> + *           request hasn't been submitted yet.
>> + * @faults: holds the pending faults which needs response
>>    */
>>   struct iommu_fault_param {
>>   	iommu_dev_fault_handler_t handler;
>>   	void *data;
>> -	struct list_head faults;
>> -	struct mutex lock;
>> +	struct mutex			lock;
>> +
>> +	struct device			*dev;
>> +	struct iopf_queue		*queue;
>> +	struct list_head		queue_list;
>> +
>> +	struct list_head		partial;
>> +	struct list_head		faults;
>>   };
> Don't add the horizontal spaces

Fixed. Thanks!

Best regards,
baolu
