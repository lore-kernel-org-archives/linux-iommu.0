Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4442CA2
	for <iommu@lists.linux.dev>; Mon, 27 Jun 2022 13:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656335040; x=1687871040;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pvt1FnCHqt1/XWnPYD13BBulCVA6oKyVYSxAmRYprsc=;
  b=h4iYDHUr2tGFVnm4Pj+n+SSgarzIa7TIJgQ9UnH39OGOJcDKjkCY8cPK
   PSJcn0+xcCIQxVzCRIaqry7NuDwBtenvydeGhaX1rKuOmmMLUaRU1kuDq
   ZwrUgnFayJ2NvmicTOAydrWs//L+lUArDpaZj92UT0b4Evrc/R8wob2xs
   NR3iuufpqO1GYPnKymVBegAWzKXFCmEungSn5EydGl6fIrGNilLKonOHs
   USu/QnPbUYFnB5xS/9XDFaVLRxSKfcZYtOfqrQGQoO9JzQsTk+MRMokAB
   Bl60bgKXJK/TjYtGccvpspphWkR3/HmjiBCWFbp2yQ25Thu9LGA8ZEQcO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="280203882"
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="280203882"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 06:03:59 -0700
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="646418348"
Received: from zhaohaif-mobl1.ccr.corp.intel.com (HELO [10.254.210.224]) ([10.254.210.224])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 06:03:55 -0700
Message-ID: <faacb997-0c0a-04e1-903d-53857f463214@linux.intel.com>
Date: Mon, 27 Jun 2022 21:03:52 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v9 10/11] iommu: Per-domain I/O page fault handling
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
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
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <20220621144353.17547-11-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Message-ID: <20220627130352.1_N_TuOoTFB6CnklWAR3iEYQtV2M_1nbLc4TNsmZUIU@z>

Hi,

在 2022/6/21 22:43, Lu Baolu 写道:
> Tweak the I/O page fault handling framework to route the page faults to
> the domain and call the page fault handler retrieved from the domain.
> This makes the I/O page fault handling framework possible to serve more
> usage scenarios as long as they have an IOMMU domain and install a page
> fault handler in it. Some unused functions are also removed to avoid
> dead code.
>
> The iommu_get_domain_for_dev_pasid() which retrieves attached domain
> for a {device, PASID} pair is used. It will be used by the page fault
> handling framework which knows {device, PASID} reported from the iommu
> driver. We have a guarantee that the SVA domain doesn't go away during
> IOPF handling, because unbind() waits for pending faults with
> iopf_queue_flush_dev() before freeing the domain. Hence, there's no need
> to synchronize life cycle of the iommu domains between the unbind() and
> the interrupt threads.
>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>   drivers/iommu/io-pgfault.c | 64 +++++---------------------------------
>   1 file changed, 7 insertions(+), 57 deletions(-)
>
> diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
> index aee9e033012f..4f24ec703479 100644
> --- a/drivers/iommu/io-pgfault.c
> +++ b/drivers/iommu/io-pgfault.c
> @@ -69,69 +69,18 @@ static int iopf_complete_group(struct device *dev, struct iopf_fault *iopf,
>   	return iommu_page_response(dev, &resp);
>   }
>   
> -static enum iommu_page_response_code
> -iopf_handle_single(struct iopf_fault *iopf)
> -{
> -	vm_fault_t ret;
> -	struct mm_struct *mm;
> -	struct vm_area_struct *vma;
> -	unsigned int access_flags = 0;
> -	unsigned int fault_flags = FAULT_FLAG_REMOTE;
> -	struct iommu_fault_page_request *prm = &iopf->fault.prm;
> -	enum iommu_page_response_code status = IOMMU_PAGE_RESP_INVALID;
> -
> -	if (!(prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID))
> -		return status;
> -
> -	mm = iommu_sva_find(prm->pasid);
> -	if (IS_ERR_OR_NULL(mm))
> -		return status;
> -
> -	mmap_read_lock(mm);
> -
> -	vma = find_extend_vma(mm, prm->addr);
> -	if (!vma)
> -		/* Unmapped area */
> -		goto out_put_mm;
> -
> -	if (prm->perm & IOMMU_FAULT_PERM_READ)
> -		access_flags |= VM_READ;
> -
> -	if (prm->perm & IOMMU_FAULT_PERM_WRITE) {
> -		access_flags |= VM_WRITE;
> -		fault_flags |= FAULT_FLAG_WRITE;
> -	}
> -
> -	if (prm->perm & IOMMU_FAULT_PERM_EXEC) {
> -		access_flags |= VM_EXEC;
> -		fault_flags |= FAULT_FLAG_INSTRUCTION;
> -	}
> -
> -	if (!(prm->perm & IOMMU_FAULT_PERM_PRIV))
> -		fault_flags |= FAULT_FLAG_USER;
> -
> -	if (access_flags & ~vma->vm_flags)
> -		/* Access fault */
> -		goto out_put_mm;
> -
> -	ret = handle_mm_fault(vma, prm->addr, fault_flags, NULL);
> -	status = ret & VM_FAULT_ERROR ? IOMMU_PAGE_RESP_INVALID :
> -		IOMMU_PAGE_RESP_SUCCESS;
> -
> -out_put_mm:
> -	mmap_read_unlock(mm);
> -	mmput(mm);
> -
> -	return status;
> -}
> -

Once the iopf_handle_single() is removed, the name of 
iopf_handle_group() looks a little weired

and confused, does this group mean the iommu group (domain) ? while I 
take some minutes to

look into the code, oh, means a batch / list / queue  of iopfs , and 
iopf_handle_group() becomes a

generic iopf_handler() .

Doe it make sense to revise the names of iopf_handle_group(), 
iopf_complete_group,  iopf_group in

this patch set ?


Thanks,

Ethan

>   static void iopf_handle_group(struct work_struct *work)
>   {
>   	struct iopf_group *group;
> +	struct iommu_domain *domain;
>   	struct iopf_fault *iopf, *next;
>   	enum iommu_page_response_code status = IOMMU_PAGE_RESP_SUCCESS;
>   
>   	group = container_of(work, struct iopf_group, work);
> +	domain = iommu_get_domain_for_dev_pasid(group->dev,
> +				group->last_fault.fault.prm.pasid);
> +	if (!domain || !domain->iopf_handler)
> +		status = IOMMU_PAGE_RESP_INVALID;
>   
>   	list_for_each_entry_safe(iopf, next, &group->faults, list) {
>   		/*
> @@ -139,7 +88,8 @@ static void iopf_handle_group(struct work_struct *work)
>   		 * faults in the group if there is an error.
>   		 */
>   		if (status == IOMMU_PAGE_RESP_SUCCESS)
> -			status = iopf_handle_single(iopf);
> +			status = domain->iopf_handler(&iopf->fault,
> +						      domain->fault_data);
>   
>   		if (!(iopf->fault.prm.flags &
>   		      IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE))

-- 
"firm, enduring, strong, and long-lived"

