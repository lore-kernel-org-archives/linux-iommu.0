Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7103207
	for <iommu@lists.linux.dev>; Sun, 24 Jul 2022 14:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658671497; x=1690207497;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4SB7MknA24m1jUG2lvk0lBvwcZyqcGj7Lokl0Nv3fhk=;
  b=lBydHmpMqWnpC/vVzgz/+MJQXd0kq8WHopmbvP98x2LrWsRz4F90wGGt
   xRrRMqKda8+a97d3soaVQIXA6tubStIB84Nss7CY46b08WlV0mWJ2HFR9
   sBN34dcbbB0g+CYo8O303jErL0ml0yK/1EnKiFi01ypSuPRNcLREl/o6x
   s7t7HU0tQoRc9ZXF/xRc0cF5PFSPiDb7pvj71v2t0PKGf1ok+yOQ4uNiO
   dLQc+G+CtvPR/uScfjTq4F9TX2/8yNxlQmtln2rS9n1mYZETAnG2q4N08
   blxZuPlGRZPT/Tv07yNccKygKxbLym02p45muvJpzmevysV7jnrBumTLv
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="274406723"
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="274406723"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 07:04:56 -0700
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="657820532"
Received: from zjiang1-mobl.ccr.corp.intel.com (HELO [10.249.170.155]) ([10.249.170.155])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 07:04:52 -0700
Message-ID: <487b533a-b289-eee7-0bd8-3be36c6e00e3@linux.intel.com>
Date: Sun, 24 Jul 2022 22:04:50 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
 Eric Auger <eric.auger@redhat.com>, Liu Yi L <yi.l.liu@intel.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>,
 Zhangfei Gao <zhangfei.gao@linaro.org>, Zhu Tony <tony.zhu@intel.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v10 10/12] iommu: Prepare IOMMU domain for IOPF
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-11-baolu.lu@linux.intel.com>
 <20220723143334.GJ79279@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220723143334.GJ79279@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/7/23 22:33, Jason Gunthorpe wrote:
> On Tue, Jul 05, 2022 at 01:07:08PM +0800, Lu Baolu wrote:
>> This adds some mechanisms around the iommu_domain so that the I/O page
>> fault handling framework could route a page fault to the domain and
>> call the fault handler from it.
>>
>> Add pointers to the page fault handler and its private data in struct
>> iommu_domain. The fault handler will be called with the private data
>> as a parameter once a page fault is routed to the domain. Any kernel
>> component which owns an iommu domain could install handler and its
>> private parameter so that the page fault could be further routed and
>> handled.
>>
>> This also prepares the SVA implementation to be the first consumer of
>> the per-domain page fault handling model. The I/O page fault handler
>> for SVA is copied to the SVA file with mmget_not_zero() added before
>> mmap_read_lock().
>>
>> Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> Tested-by: Tony Zhu <tony.zhu@intel.com>
>> ---
>>   include/linux/iommu.h         |  3 ++
>>   drivers/iommu/iommu-sva-lib.h |  8 +++++
>>   drivers/iommu/io-pgfault.c    |  7 +++++
>>   drivers/iommu/iommu-sva-lib.c | 58 +++++++++++++++++++++++++++++++++++
>>   drivers/iommu/iommu.c         |  4 +++
>>   5 files changed, 80 insertions(+)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index ae0cfca064e6..47610f21d451 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -105,6 +105,9 @@ struct iommu_domain {
>>   	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
>>   	struct iommu_domain_geometry geometry;
>>   	struct iommu_dma_cookie *iova_cookie;
>> +	enum iommu_page_response_code (*iopf_handler)(struct iommu_fault *fault,
>> +						      void *data);
>> +	void *fault_data;
>>   	union {
>>   		struct {
>>   			iommu_fault_handler_t handler;
> 
> Why do we need two falut callbacks? The only difference is that one is
> recoverable and the other is not, right?
> 
> Can we run both down the same op?

The iommu_fault_handler_t is for report_iommu_fault() which could be
replaced with the newer iommu_report_device_fault().

https://lore.kernel.org/linux-iommu/Yo4Nw9QyllT1RZbd@myrica/

> 
>> +/*
>> + * I/O page fault handler for SVA
>> + */
>> +enum iommu_page_response_code
>> +iommu_sva_handle_iopf(struct iommu_fault *fault, void *data)
>> +{
>> +	vm_fault_t ret;
>> +	struct vm_area_struct *vma;
>> +	struct mm_struct *mm = data;
>> +	unsigned int access_flags = 0;
>> +	unsigned int fault_flags = FAULT_FLAG_REMOTE;
>> +	struct iommu_fault_page_request *prm = &fault->prm;
>> +	enum iommu_page_response_code status = IOMMU_PAGE_RESP_INVALID;
>> +
>> +	if (!(prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID))
>> +		return status;
>> +
>> +	if (IS_ERR_OR_NULL(mm) || !mmget_not_zero(mm))
> 
> Do not use IS_ERR_ON_NULL. mm should never be null here since the
> fault handler should have been removed from the domain before the
> fault_data is changed.

Yes. Updated.

Best regards,
baolu

