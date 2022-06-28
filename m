Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4DC7A
	for <iommu@lists.linux.dev>; Tue, 28 Jun 2022 09:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656407756; x=1687943756;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OHaCPTb3tQJyC9jPefSdwGvmT4LNH8ytKUBKidFJYOM=;
  b=FT5nGkzlU68kcdtJXjphByVYsVr4w0tARLzaTYJJwZB4kqkXjZiB6Co5
   zAVTPUFwXkkuDSBtYm2i73l3V0lLzh3RPr/2PWwS/Z4Uc4+WnzubE3GV0
   5LVP8pW7rviUse6SgQfrH2IZ3HbMlE9lBn5mA60jFC30WTG+8L+6TN4lX
   DlMHzp2ct5MkCO3Py8aMeGBi5S/camK/AQ36XBZFT3RAQi/8p63WISLyX
   7QwfMLBiMp9C87Zl0+mO0GO/IT5KCEpi7Xnl8MPq4x/WmQP/lAVTBGrXO
   jmzcefgXKHCDWZvhMzUgMRBjBKH16/zIPynMqpNFDFZ63VTdE8reZyk39
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="307166952"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="307166952"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 02:10:19 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="594708620"
Received: from zhaohaif-mobl1.ccr.corp.intel.com (HELO [10.254.212.145]) ([10.254.212.145])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 02:10:14 -0700
Message-ID: <75b17c70-1658-91ea-0992-1be769550943@linux.intel.com>
Date: Tue, 28 Jun 2022 17:10:11 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v9 10/11] iommu: Per-domain I/O page fault handling
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
Cc: Eric Auger <eric.auger@redhat.com>, Liu Yi L <yi.l.liu@intel.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>, iommu@lists.linux-foundation.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-11-baolu.lu@linux.intel.com>
 <faacb997-0c0a-04e1-903d-53857f463214@linux.intel.com>
 <693a3604-d70b-e08c-2621-7f0cb9bdb6ca@linux.intel.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <693a3604-d70b-e08c-2621-7f0cb9bdb6ca@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Message-ID: <20220628091011.RfUvWBHU7Fx-X5XmSvqdA9A-TfAqIDYvwlh-N1Eycqk@z>

Hi, Baolu

在 2022/6/28 14:28, Baolu Lu 写道:
> Hi Ethan,
>
> On 2022/6/27 21:03, Ethan Zhao wrote:
>> Hi,
>>
>> 在 2022/6/21 22:43, Lu Baolu 写道:
>>> Tweak the I/O page fault handling framework to route the page faults to
>>> the domain and call the page fault handler retrieved from the domain.
>>> This makes the I/O page fault handling framework possible to serve more
>>> usage scenarios as long as they have an IOMMU domain and install a page
>>> fault handler in it. Some unused functions are also removed to avoid
>>> dead code.
>>>
>>> The iommu_get_domain_for_dev_pasid() which retrieves attached domain
>>> for a {device, PASID} pair is used. It will be used by the page fault
>>> handling framework which knows {device, PASID} reported from the iommu
>>> driver. We have a guarantee that the SVA domain doesn't go away during
>>> IOPF handling, because unbind() waits for pending faults with
>>> iopf_queue_flush_dev() before freeing the domain. Hence, there's no 
>>> need
>>> to synchronize life cycle of the iommu domains between the unbind() and
>>> the interrupt threads.
>>>
>>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>> ---
>>>   drivers/iommu/io-pgfault.c | 64 
>>> +++++---------------------------------
>>>   1 file changed, 7 insertions(+), 57 deletions(-)
>>>
>>> diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
>>> index aee9e033012f..4f24ec703479 100644
>>> --- a/drivers/iommu/io-pgfault.c
>>> +++ b/drivers/iommu/io-pgfault.c
>>> @@ -69,69 +69,18 @@ static int iopf_complete_group(struct device 
>>> *dev, struct iopf_fault *iopf,
>>>       return iommu_page_response(dev, &resp);
>>>   }
>>> -static enum iommu_page_response_code
>>> -iopf_handle_single(struct iopf_fault *iopf)
>>> -{
>>> -    vm_fault_t ret;
>>> -    struct mm_struct *mm;
>>> -    struct vm_area_struct *vma;
>>> -    unsigned int access_flags = 0;
>>> -    unsigned int fault_flags = FAULT_FLAG_REMOTE;
>>> -    struct iommu_fault_page_request *prm = &iopf->fault.prm;
>>> -    enum iommu_page_response_code status = IOMMU_PAGE_RESP_INVALID;
>>> -
>>> -    if (!(prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID))
>>> -        return status;
>>> -
>>> -    mm = iommu_sva_find(prm->pasid);
>>> -    if (IS_ERR_OR_NULL(mm))
>>> -        return status;
>>> -
>>> -    mmap_read_lock(mm);
>>> -
>>> -    vma = find_extend_vma(mm, prm->addr);
>>> -    if (!vma)
>>> -        /* Unmapped area */
>>> -        goto out_put_mm;
>>> -
>>> -    if (prm->perm & IOMMU_FAULT_PERM_READ)
>>> -        access_flags |= VM_READ;
>>> -
>>> -    if (prm->perm & IOMMU_FAULT_PERM_WRITE) {
>>> -        access_flags |= VM_WRITE;
>>> -        fault_flags |= FAULT_FLAG_WRITE;
>>> -    }
>>> -
>>> -    if (prm->perm & IOMMU_FAULT_PERM_EXEC) {
>>> -        access_flags |= VM_EXEC;
>>> -        fault_flags |= FAULT_FLAG_INSTRUCTION;
>>> -    }
>>> -
>>> -    if (!(prm->perm & IOMMU_FAULT_PERM_PRIV))
>>> -        fault_flags |= FAULT_FLAG_USER;
>>> -
>>> -    if (access_flags & ~vma->vm_flags)
>>> -        /* Access fault */
>>> -        goto out_put_mm;
>>> -
>>> -    ret = handle_mm_fault(vma, prm->addr, fault_flags, NULL);
>>> -    status = ret & VM_FAULT_ERROR ? IOMMU_PAGE_RESP_INVALID :
>>> -        IOMMU_PAGE_RESP_SUCCESS;
>>> -
>>> -out_put_mm:
>>> -    mmap_read_unlock(mm);
>>> -    mmput(mm);
>>> -
>>> -    return status;
>>> -}
>>> -
>>
>> Once the iopf_handle_single() is removed, the name of 
>> iopf_handle_group() looks a little weired
>>
>> and confused, does this group mean the iommu group (domain) ? while I 
>> take some minutes to
>
> No. This is not the iommu group. It's page request group defined by the
> PCI SIG spec. Multiple page requests could be put in a group with a
> same group id. All page requests in a group could be responded to device
> in one shot.

Thanks your explaination, understand the concept of PCIe PRG.  I meant

do we still have the necessity to mention the "group" here in the name

iopf_handle_group(),  which one is better ? iopf_handle_prg() or

iopf_handler(),  perhaps none of them ? :)


Thanks，

Ethan

>
> Best regards,
> baolu
>
>>
>> look into the code, oh, means a batch / list / queue  of iopfs , and 
>> iopf_handle_group() becomes a
>>
>> generic iopf_handler() .
>>
>> Doe it make sense to revise the names of iopf_handle_group(), 
>> iopf_complete_group,  iopf_group in
>>
>> this patch set ?
>>
>>
>> Thanks,
>>
>> Ethan
>>
>>>   static void iopf_handle_group(struct work_struct *work)
>>>   {
>>>       struct iopf_group *group;
>>> +    struct iommu_domain *domain;
>>>       struct iopf_fault *iopf, *next;
>>>       enum iommu_page_response_code status = IOMMU_PAGE_RESP_SUCCESS;
>>>       group = container_of(work, struct iopf_group, work);
>>> +    domain = iommu_get_domain_for_dev_pasid(group->dev,
>>> +                group->last_fault.fault.prm.pasid);
>>> +    if (!domain || !domain->iopf_handler)
>>> +        status = IOMMU_PAGE_RESP_INVALID;
>>>       list_for_each_entry_safe(iopf, next, &group->faults, list) {
>>>           /*
>>> @@ -139,7 +88,8 @@ static void iopf_handle_group(struct work_struct 
>>> *work)
>>>            * faults in the group if there is an error.
>>>            */
>>>           if (status == IOMMU_PAGE_RESP_SUCCESS)
>>> -            status = iopf_handle_single(iopf);
>>> +            status = domain->iopf_handler(&iopf->fault,
>>> +                              domain->fault_data);
>>>           if (!(iopf->fault.prm.flags &
>>>                 IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE))
>>
>
-- 
"firm, enduring, strong, and long-lived"

