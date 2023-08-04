Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CB71FC8
	for <iommu@lists.linux.dev>; Fri,  4 Aug 2023 05:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691127428; x=1722663428;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Z5zADW3+ohgukQOtaiiN0wnTwVTCNGNMYD2gY+atwEg=;
  b=PXxBvtZ5GYh6lHqPRT3BUI9nqFeWiBe272J5UtzcP36rIrfCPp8uledG
   VtF4hx+f+kqSUobzVASdEciHWxPdbr1/Z6B9e2/FbsCu+y8+jpA5tpIqo
   BuhJ7Jif9nJHMZlER+4x06gX16/ZGpken6+FFZrgMNKsNDGm2Dc4ekZFS
   lR+hbwX/ATX9WfioImDvHoPg1ADNn7QYKOMWtuyKEQXGrNdbKL89YdiuW
   xUtL0YUgz4jrbUI5hUuu818G1mj7/qj8ibMPku5vqp+9UlvbHlHLnrwCh
   SP4acc2ddVtwJv1Hv5fG5ruUAunBO1YOG87smIqwUzOwDQAjbkvn3rOYG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="367533367"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="367533367"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 22:37:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="764958817"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="764958817"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga001.jf.intel.com with ESMTP; 03 Aug 2023 22:37:04 -0700
Message-ID: <9ae1fc82-d4d9-7050-b66f-b15184dc0278@linux.intel.com>
Date: Fri, 4 Aug 2023 13:34:53 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: baolu.lu@linux.intel.com, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 06/12] iommu: Make dev->fault_param static
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20230727054837.147050-1-baolu.lu@linux.intel.com>
 <20230727054837.147050-7-baolu.lu@linux.intel.com>
 <BN9PR11MB5276BE0DB32E8E7ACD84828E8C08A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ae481bea-e692-dc88-61ba-90d9ab4f9b48@linux.intel.com>
 <BN9PR11MB5276214F6B8D4E4529C559EE8C09A@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276214F6B8D4E4529C559EE8C09A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/4/23 11:56 AM, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Friday, August 4, 2023 11:17 AM
>>
>> On 2023/8/3 16:08, Tian, Kevin wrote:
>>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>>> Sent: Thursday, July 27, 2023 1:49 PM
>>>>
>>>>
>>>>    	mutex_init(&param->lock);
>>>> +	param->fault_param = kzalloc(sizeof(*param->fault_param),
>>>> GFP_KERNEL);
>>>> +	if (!param->fault_param) {
>>>> +		kfree(param);
>>>> +		return -ENOMEM;
>>>> +	}
>>>> +	mutex_init(&param->fault_param->lock);
>>>> +	INIT_LIST_HEAD(&param->fault_param->faults);
>>>
>>> let's also move 'partial' from struct iopf_device_param into struct
>>> iommu_fault_param. That logic is not specific to sva.
>>>
>>> meanwhile probably iopf_device_param can be renamed to
>>> iopf_sva_param since all the remaining fields are only used by
>>> the sva handler.
>>>
>>> current naming (iommu_fault_param vs. iopf_device_param) is a
>>> bit confusing when reading related code.
>>
>> My understanding is that iommu_fault_param is for all kinds of iommu
>> faults. Currently they probably include recoverable IO page faults or
>> unrecoverable DMA faults.
>>
>> While, iopf_device_param is for the recoverable IO page faults. I agree
>> that this naming is not specific and even confusing. Perhaps renaming it
>> to something like iommu_iopf_param?
>>
> 
> or just iopf_param.

Okay.

Best regards,
baolu
