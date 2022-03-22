Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69BF3C433EF
	for <iommu@archiver.kernel.org>; Tue, 22 Mar 2022 05:28:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 15F33606C6;
	Tue, 22 Mar 2022 05:28:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RwUKd8h_X3IQ; Tue, 22 Mar 2022 05:28:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A137260A9C;
	Tue, 22 Mar 2022 05:28:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4FB39C0012;
	Tue, 22 Mar 2022 05:28:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24401C000B
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 05:28:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 083F240A9F
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 05:28:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eHXTthhdokzU for <iommu@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 05:28:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BEA51400B8
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 05:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647926920; x=1679462920;
 h=message-id:date:mime-version:cc:to:references:from:
 subject:in-reply-to:content-transfer-encoding;
 bh=APxeAEopBRCFgm1KXudSbbtliPjdlsQ/3Hia294wMx4=;
 b=I60d8tTEe7pJU9z1yINRjfijcaZuLV3QWKMkSyH3wRPsN99KBnqd6jzw
 5jI2yPt+ZcXrBFux6Z219GcgF02/uRHyvxlcJn/XQDl49RqEXuffroYPH
 3PI8ByroyBuxSs6F+eObLrFtGOrKCu1NIDZrlra9BtSxKtPvO7+5r0057
 6FkCO9DJlpV1K5phvn66+Ixo+INDDGuR69C9i/g1XhePDF6QAkze+OTZP
 27Z7S6I1Ec7LxjrmHpXhLGJt6WM4aXlTRmvjKSlmVAEHS3aiFFK4996Bv
 t9xLA07zfb19aMXRoozp133669IGz8Udfag0WTdT9csgvz8guDAPSougY w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="344156366"
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; d="scan'208";a="344156366"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2022 22:28:39 -0700
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; d="scan'208";a="560211178"
Received: from ellenyin-mobl.ccr.corp.intel.com (HELO [10.254.213.205])
 ([10.254.213.205])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2022 22:28:35 -0700
Message-ID: <3165c557-b96e-a410-1e0d-2bea1048fb29@linux.intel.com>
Date: Tue, 22 Mar 2022 13:28:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-11-baolu.lu@linux.intel.com>
 <Yjhj5F0fUWRRKh3v@myrica>
From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH RFC 10/11] iommu: Make IOPF handling framework generic
In-Reply-To: <Yjhj5F0fUWRRKh3v@myrica>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022/3/21 19:39, Jean-Philippe Brucker wrote:
> On Sun, Mar 20, 2022 at 02:40:29PM +0800, Lu Baolu wrote:
>> The existing IOPF handling framework only handles the I/O page faults for
>> SVA. Ginven that we are able to link iommu domain with each I/O page fault,
>> we can now make the I/O page fault handling framework more general for
>> more types of page faults.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   include/linux/iommu.h         |  4 +++
>>   drivers/iommu/io-pgfault.c    | 67 ++++++-----------------------------
>>   drivers/iommu/iommu-sva-lib.c | 59 ++++++++++++++++++++++++++++++
>>   3 files changed, 73 insertions(+), 57 deletions(-)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 803e7b07605e..11c65a7bed88 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -50,6 +50,8 @@ struct iommu_dma_cookie;
>>   typedef int (*iommu_fault_handler_t)(struct iommu_domain *,
>>   			struct device *, unsigned long, int, void *);
>>   typedef int (*iommu_dev_fault_handler_t)(struct iommu_fault *, void *);
>> +typedef enum iommu_page_response_code (*iommu_domain_iopf_handler_t)
>> +			(struct iommu_fault *, void *);
>>   
>>   struct iommu_domain_geometry {
>>   	dma_addr_t aperture_start; /* First address that can be mapped    */
>> @@ -101,6 +103,8 @@ struct iommu_domain {
>>   	struct iommu_domain_geometry geometry;
>>   	struct iommu_dma_cookie *iova_cookie;
>>   	struct mm_struct *sva_cookie;
>> +	iommu_domain_iopf_handler_t fault_handler;
>> +	void *fault_data;
>>   };
>>   
>>   static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
>> diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
>> index 1df8c1dcae77..dad0e40cd8d2 100644
>> --- a/drivers/iommu/io-pgfault.c
>> +++ b/drivers/iommu/io-pgfault.c
>> @@ -69,62 +69,6 @@ static int iopf_complete_group(struct device *dev, struct iopf_fault *iopf,
>>   	return iommu_page_response(dev, &resp);
>>   }
>>   
>> -static enum iommu_page_response_code
>> -iopf_handle_single(struct iopf_fault *iopf)
>> -{
>> -	vm_fault_t ret;
>> -	struct mm_struct *mm;
>> -	struct vm_area_struct *vma;
>> -	unsigned int access_flags = 0;
>> -	unsigned int fault_flags = FAULT_FLAG_REMOTE;
>> -	struct iommu_fault_page_request *prm = &iopf->fault.prm;
>> -	enum iommu_page_response_code status = IOMMU_PAGE_RESP_INVALID;
>> -
>> -	if (!(prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID))
>> -		return status;
>> -
>> -	mm = iommu_sva_find(prm->pasid);
>> -	if (IS_ERR_OR_NULL(mm))
>> -		return status;
>> -
>> -	mmap_read_lock(mm);
>> -
>> -	vma = find_extend_vma(mm, prm->addr);
>> -	if (!vma)
>> -		/* Unmapped area */
>> -		goto out_put_mm;
>> -
>> -	if (prm->perm & IOMMU_FAULT_PERM_READ)
>> -		access_flags |= VM_READ;
>> -
>> -	if (prm->perm & IOMMU_FAULT_PERM_WRITE) {
>> -		access_flags |= VM_WRITE;
>> -		fault_flags |= FAULT_FLAG_WRITE;
>> -	}
>> -
>> -	if (prm->perm & IOMMU_FAULT_PERM_EXEC) {
>> -		access_flags |= VM_EXEC;
>> -		fault_flags |= FAULT_FLAG_INSTRUCTION;
>> -	}
>> -
>> -	if (!(prm->perm & IOMMU_FAULT_PERM_PRIV))
>> -		fault_flags |= FAULT_FLAG_USER;
>> -
>> -	if (access_flags & ~vma->vm_flags)
>> -		/* Access fault */
>> -		goto out_put_mm;
>> -
>> -	ret = handle_mm_fault(vma, prm->addr, fault_flags, NULL);
>> -	status = ret & VM_FAULT_ERROR ? IOMMU_PAGE_RESP_INVALID :
>> -		IOMMU_PAGE_RESP_SUCCESS;
>> -
>> -out_put_mm:
>> -	mmap_read_unlock(mm);
>> -	mmput(mm);
>> -
>> -	return status;
>> -}
>> -
>>   static void iopf_handle_group(struct work_struct *work)
>>   {
>>   	struct iopf_group *group;
>> @@ -134,12 +78,21 @@ static void iopf_handle_group(struct work_struct *work)
>>   	group = container_of(work, struct iopf_group, work);
>>   
>>   	list_for_each_entry_safe(iopf, next, &group->faults, list) {
>> +		struct iommu_domain *domain;
>> +
>> +		domain = iommu_get_domain_for_dev_pasid(group->dev,
>> +							iopf->fault.prm.pasid);
> 
> Do we have a guarantee that the domain is not freed while we handle the
> fault?  We could prevent unbind() while there are pending faults on this
> bond. But a refcount on SVA domains could defer freeing, and would also
> help with keeping the semantics where bind() returns a single refcounted
> bond for any {dev, mm}.
> 
> Given that this path is full of circular locking pitfalls, and to keep the
> fault handler efficient (well, at least not make it worse), we should
> probably keep a getter like iommu_sva_find() that does not require
> locking.

Agreed. We need a mechanism to ensure concurrency. I will look into it.

> 
>> +
>> +		if (!domain || !domain->fault_handler)
>> +			status = IOMMU_PAGE_RESP_INVALID;
>> +
>>   		/*
>>   		 * For the moment, errors are sticky: don't handle subsequent
>>   		 * faults in the group if there is an error.
>>   		 */
>>   		if (status == IOMMU_PAGE_RESP_SUCCESS)
>> -			status = iopf_handle_single(iopf);
>> +			status = domain->fault_handler(&iopf->fault,
>> +						       domain->fault_data);
> 
> If we make this a direct call and only use a light getter for the
> PASID->mm lookup we don't need to look at the domain at all. Or are you
> planning to add external fault handlers?

Yes. I'd like the I/O page fault handling framework to work for
external domains as well, for example, the I/O page faults for user
space page table should be routed to user space.

> 
>>   
>>   		if (!(iopf->fault.prm.flags &
>>   		      IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE))
>> diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
>> index 47cf98e661ff..01fa8096bd02 100644
>> --- a/drivers/iommu/iommu-sva-lib.c
>> +++ b/drivers/iommu/iommu-sva-lib.c
>> @@ -87,6 +87,63 @@ static struct iommu_domain *iommu_sva_domain_alloc(struct device *dev)
>>   	return domain;
>>   }
>>   
>> +static enum iommu_page_response_code
>> +iommu_sva_handle_iopf(struct iommu_fault *fault, void *data)
>> +{
>> +	vm_fault_t ret;
>> +	struct mm_struct *mm;
>> +	struct vm_area_struct *vma;
>> +	unsigned int access_flags = 0;
>> +	struct iommu_domain *domain = data;
>> +	unsigned int fault_flags = FAULT_FLAG_REMOTE;
>> +	struct iommu_fault_page_request *prm = &fault->prm;
>> +	enum iommu_page_response_code status = IOMMU_PAGE_RESP_INVALID;
>> +
>> +	if (!(prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID))
>> +		return status;
>> +
>> +	mm = domain->sva_cookie;
>> +	if (IS_ERR_OR_NULL(mm))
>> +		return status;
>> +
>> +	mmap_read_lock(mm);
>> +
>> +	vma = find_extend_vma(mm, prm->addr);
>> +	if (!vma)
>> +		/* Unmapped area */
>> +		goto out_put_mm;
>> +
>> +	if (prm->perm & IOMMU_FAULT_PERM_READ)
>> +		access_flags |= VM_READ;
>> +
>> +	if (prm->perm & IOMMU_FAULT_PERM_WRITE) {
>> +		access_flags |= VM_WRITE;
>> +		fault_flags |= FAULT_FLAG_WRITE;
>> +	}
>> +
>> +	if (prm->perm & IOMMU_FAULT_PERM_EXEC) {
>> +		access_flags |= VM_EXEC;
>> +		fault_flags |= FAULT_FLAG_INSTRUCTION;
>> +	}
>> +
>> +	if (!(prm->perm & IOMMU_FAULT_PERM_PRIV))
>> +		fault_flags |= FAULT_FLAG_USER;
>> +
>> +	if (access_flags & ~vma->vm_flags)
>> +		/* Access fault */
>> +		goto out_put_mm;
>> +
>> +	ret = handle_mm_fault(vma, prm->addr, fault_flags, NULL);
>> +	status = ret & VM_FAULT_ERROR ? IOMMU_PAGE_RESP_INVALID :
>> +		IOMMU_PAGE_RESP_SUCCESS;
>> +
>> +out_put_mm:
>> +	mmap_read_unlock(mm);
>> +	mmput(mm);
> 
> mmget_not_zero() is missing since iommu_sva_find() is gone. I'm guessing
> we still need it in case the process dies

Agreed.

> 
> Thanks,
> Jean

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
