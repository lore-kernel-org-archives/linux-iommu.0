Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204563C1C
	for <iommu@lists.linux.dev>; Sun, 31 Jul 2022 13:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659275271; x=1690811271;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G9GK/9YI1yKGfpyKC+h7PPNL75WRdhhLc2kt2Or+8ak=;
  b=MvQGWKeVGnSfw6BtPGHCLyX0I9zUFJSviaB/McagXPkdEer2XAfc4WA2
   U4DBnZVS2hEOv+gd1Ik6NS0lUDYOV6FE/wil2ds81eGA5v3S+gkQSgHFx
   G76d5GPS5i0CHti8fJzR2AiTGj9hS8jg01C2yTSW/OnWYp6aOJ9j2pYtq
   +MlXU8fXiBbskNM4Zq9hvtaMKKvWEB7UBZkmkni+QT2iyhYYQ+WrX+lFr
   lGy92KKUR4g2sMc1N8ptGbyuyHNV0Qcxt6CChLYYxIczml7utGhhMmOvg
   hIkx3PzNXMXm0Z08DWzc5QObNmSYtd8XYvuCDjafjvfwWoIVo7NNVfzyv
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="269378683"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="269378683"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 06:47:50 -0700
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="629932522"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.208.191]) ([10.254.208.191])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 06:47:45 -0700
Message-ID: <fb86ccdb-dd03-206c-dabc-25d96273ebad@linux.intel.com>
Date: Sun, 31 Jul 2022 21:47:44 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc: baolu.lu@linux.intel.com, Eric Auger <eric.auger@redhat.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>,
 Zhangfei Gao <zhangfei.gao@linaro.org>, Zhu Tony <tony.zhu@intel.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v10 10/12] iommu: Prepare IOMMU domain for IOPF
Content-Language: en-US
To: Yi Liu <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-11-baolu.lu@linux.intel.com>
 <b0403334-1b88-e75a-418d-71a78ef97c9c@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <b0403334-1b88-e75a-418d-71a78ef97c9c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2022/7/31 20:50, Yi Liu wrote:
> On 2022/7/5 13:07, Lu Baolu wrote:
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
>>   include/linux/iommu.h         |  3 ++
>>   drivers/iommu/iommu-sva-lib.h |  8 +++++
>>   drivers/iommu/io-pgfault.c    |  7 +++++
>>   drivers/iommu/iommu-sva-lib.c | 58 +++++++++++++++++++++++++++++++++++
>>   drivers/iommu/iommu.c         |  4 +++
>>   5 files changed, 80 insertions(+)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index ae0cfca064e6..47610f21d451 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -105,6 +105,9 @@ struct iommu_domain {
>>       unsigned long pgsize_bitmap;    /* Bitmap of page sizes in use */
>>       struct iommu_domain_geometry geometry;
>>       struct iommu_dma_cookie *iova_cookie;
>> +    enum iommu_page_response_code (*iopf_handler)(struct iommu_fault 
>> *fault,
>> +                              void *data);
>> +    void *fault_data;
>>       union {
>>           struct {
>>               iommu_fault_handler_t handler;
>> diff --git a/drivers/iommu/iommu-sva-lib.h 
>> b/drivers/iommu/iommu-sva-lib.h
>> index 8909ea1094e3..1b3ace4b5863 100644
>> --- a/drivers/iommu/iommu-sva-lib.h
>> +++ b/drivers/iommu/iommu-sva-lib.h
>> @@ -26,6 +26,8 @@ int iopf_queue_flush_dev(struct device *dev);
>>   struct iopf_queue *iopf_queue_alloc(const char *name);
>>   void iopf_queue_free(struct iopf_queue *queue);
>>   int iopf_queue_discard_partial(struct iopf_queue *queue);
>> +enum iommu_page_response_code
>> +iommu_sva_handle_iopf(struct iommu_fault *fault, void *data);
>>   #else /* CONFIG_IOMMU_SVA */
>>   static inline int iommu_queue_iopf(struct iommu_fault *fault, void 
>> *cookie)
>> @@ -63,5 +65,11 @@ static inline int iopf_queue_discard_partial(struct 
>> iopf_queue *queue)
>>   {
>>       return -ENODEV;
>>   }
>> +
>> +static inline enum iommu_page_response_code
>> +iommu_sva_handle_iopf(struct iommu_fault *fault, void *data)
>> +{
>> +    return IOMMU_PAGE_RESP_INVALID;
>> +}
>>   #endif /* CONFIG_IOMMU_SVA */
>>   #endif /* _IOMMU_SVA_LIB_H */
>> diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
>> index 1df8c1dcae77..aee9e033012f 100644
>> --- a/drivers/iommu/io-pgfault.c
>> +++ b/drivers/iommu/io-pgfault.c
>> @@ -181,6 +181,13 @@ static void iopf_handle_group(struct work_struct 
>> *work)
>>    * request completes, outstanding faults will have been dealt with 
>> by the time
>>    * the PASID is freed.
>>    *
>> + * Any valid page fault will be eventually routed to an iommu domain 
>> and the
>> + * page fault handler installed there will get called. The users of this
>> + * handling framework should guarantee that the iommu domain could 
>> only be
>> + * freed after the device has stopped generating page faults (or the 
>> iommu
>> + * hardware has been set to block the page faults) and the pending 
>> page faults
>> + * have been flushed.
>> + *
>>    * Return: 0 on success and <0 on error.
>>    */
>>   int iommu_queue_iopf(struct iommu_fault *fault, void *cookie)
>> diff --git a/drivers/iommu/iommu-sva-lib.c 
>> b/drivers/iommu/iommu-sva-lib.c
>> index 751366980232..536d34855c74 100644
>> --- a/drivers/iommu/iommu-sva-lib.c
>> +++ b/drivers/iommu/iommu-sva-lib.c
>> @@ -167,3 +167,61 @@ u32 iommu_sva_get_pasid(struct iommu_sva *handle)
>>       return domain->mm->pasid;
>>   }
>>   EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
>> +
>> +/*
>> + * I/O page fault handler for SVA
>> + */
>> +enum iommu_page_response_code
>> +iommu_sva_handle_iopf(struct iommu_fault *fault, void *data)
>> +{
>> +    vm_fault_t ret;
>> +    struct vm_area_struct *vma;
>> +    struct mm_struct *mm = data;
>> +    unsigned int access_flags = 0;
>> +    unsigned int fault_flags = FAULT_FLAG_REMOTE;
>> +    struct iommu_fault_page_request *prm = &fault->prm;
>> +    enum iommu_page_response_code status = IOMMU_PAGE_RESP_INVALID;
>> +
>> +    if (!(prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID))
>> +        return status;
>> +
>> +    if (IS_ERR_OR_NULL(mm) || !mmget_not_zero(mm))
> 
> is it possible to be ERR or NULL? The mm life circle should have been 
> guaranteed by the mmgrab() in iommu_sva_domain_alloc(). Perhaps coding
> issue if it happens. :-)

Updated. Thanks!

Best regards,
baolu
