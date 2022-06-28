Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7347A257A
	for <iommu@lists.linux.dev>; Tue, 28 Jun 2022 12:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656418702; x=1687954702;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Xu+W3z9Vfv/K82AHMIeu/0YjAhTvZA+Ccl9JNUx64kI=;
  b=czGrpXVNwacjY6A3HFyMGIVH64Hw8Pubda4e6YTwUWqvmCVSbLJX/CVv
   BtDOHEaQhGRU/quLtotcB6pnrn3rNUGOk9foIn5YW60sDBHAZxUxTTuzv
   pJhuON1Y0CZzXURVflCNeiNoz9SUo2iqz4AkFNgO1qhHkSUeg9POml2sJ
   roRcWKx4+AHQfpej3MPkreg3ryCtAa3/8Kp36Sv4DeL2wg9m0japTRpvW
   +FqSQJ4LLL8yxN9W1yvc/AWZADZQl3qifz+mJO8cGMYMzAIM02300tHDL
   m8SWcb6OioLIjixrvK1+7scYlkoBAKElmBeO8Hyj5WU0i2ndhcSoEKNh7
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="307205915"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="307205915"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 05:18:21 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="646891842"
Received: from ltang11-mobl1.ccr.corp.intel.com (HELO [10.249.169.64]) ([10.249.169.64])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 05:18:17 -0700
Message-ID: <826513b6-15d3-902d-03c2-7f7e68a84095@linux.intel.com>
Date: Tue, 28 Jun 2022 20:18:16 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
 Eric Auger <eric.auger@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 10/11] iommu: Per-domain I/O page fault handling
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-11-baolu.lu@linux.intel.com>
 <BN9PR11MB52768181B0EB29DBCB11AEA68CB89@BN9PR11MB5276.namprd11.prod.outlook.com>
 <YrrNarTWvMydIDwQ@myrica>
 <BN9PR11MB527605AA0663E8BE592898FE8CB89@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527605AA0663E8BE592898FE8CB89@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID: <20220628121816.lYbltpMnr7gwOVlAZ404zprRFFn9f9hsdNlTbYPDDb8@z>

On 2022/6/28 18:02, Tian, Kevin wrote:
>> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
>> Sent: Tuesday, June 28, 2022 5:44 PM
>>
>> On Tue, Jun 28, 2022 at 08:39:36AM +0000, Tian, Kevin wrote:
>>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>>> Sent: Tuesday, June 21, 2022 10:44 PM
>>>>
>>>> Tweak the I/O page fault handling framework to route the page faults to
>>>> the domain and call the page fault handler retrieved from the domain.
>>>> This makes the I/O page fault handling framework possible to serve more
>>>> usage scenarios as long as they have an IOMMU domain and install a
>> page
>>>> fault handler in it. Some unused functions are also removed to avoid
>>>> dead code.
>>>>
>>>> The iommu_get_domain_for_dev_pasid() which retrieves attached
>> domain
>>>> for a {device, PASID} pair is used. It will be used by the page fault
>>>> handling framework which knows {device, PASID} reported from the
>> iommu
>>>> driver. We have a guarantee that the SVA domain doesn't go away during
>>>> IOPF handling, because unbind() waits for pending faults with
>>>> iopf_queue_flush_dev() before freeing the domain. Hence, there's no
>> need
>>>> to synchronize life cycle of the iommu domains between the unbind() and
>>>> the interrupt threads.
>>>
>>> I found iopf_queue_flush_dev() is only called in intel-iommu driver. Did
>>> I overlook anything?
>>
>> The SMMU driver will need it as well when we upstream PRI support.
>> Currently it only supports stall, and that requires the device driver to
>> flush all DMA including stalled transactions *before* calling unbind(), so
>> ne need for iopf_queue_flush_dev() in this case.
>>
> 
> then it makes sense. Probably Baolu can add this information in the
> commit msg so others with similar question can quickly get the
> point here.

Sure. Updated.

Best regards,
baolu
