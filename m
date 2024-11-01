Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1C3146A79
	for <iommu@lists.linux.dev>; Fri,  1 Nov 2024 04:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730435272; cv=none; b=Fklp3/3RVl/5E0s4p6VWbPa4m25qL+PbnMuhVXghwU2OE9FK5HUyaEtbMXdkX714WxD1FHkERNrpmRHNY+mitpQne2zbBC0dPDkv7FFWsjESJ8//myJgJeKjsr0P8E1oyWZuM8NvzPhjZLVSCZZCjp1fCde48xRH9V1izYedqDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730435272; c=relaxed/simple;
	bh=wh+/RwaI7po8sEY9saGvly1xg56dEmBAXqcDk5R75OU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KPYZCVTAYETPH/RJuBHehgUyB2L5ZJB5j+40q7IPJu/M4hMtSjH8+kES+kKZF6xhbYewZDAYL+uzWTB5jQh9bfRF3wrVleg9P2eb11VM4AzsNBnqVWfqW4MGNAa9ASID63ecA7LklE5lJUYlJDMz+9uA8yfQ9404+Ch5wqf0Z6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A87xs2aI; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A87xs2aI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730435269; x=1761971269;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wh+/RwaI7po8sEY9saGvly1xg56dEmBAXqcDk5R75OU=;
  b=A87xs2aIGh2FXV5Ws212imnA//2wJ7kiLVOZfiXtbdjgAP0Ec4a8pGXL
   kGCqidVGzLdHwuS8U4VGgS+NHB9Mc5nMfbCiaQnAppGqeIKaO2ff9nUbA
   9shF05w/XqsRRV6+JLOTpil5EfXwElegi6++axo+pKCR7lPXHjG0hhpqL
   3d8gglJ+OEul31uTJ+IJEWrmwVvQAbzje4Ubq23wFlWQNr2zQiOFYn/Yw
   hFgYEBzWhUas3DvjJ3S2zmtBvv+VXhHK2iGkUmY1FPz4rbvxpu7e08t7R
   GKmc8vuuEc8VFCXNYDq7ljjZvWs14VUNYBnHtbmOICsPt7Tk8IMpy9nt7
   A==;
X-CSE-ConnectionGUID: UYqq9YpmQ5+rLwJPj6g1PA==
X-CSE-MsgGUID: XgaGKLNoQo+10K1o6zX7YQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="34134314"
X-IronPort-AV: E=Sophos;i="6.11,248,1725346800"; 
   d="scan'208";a="34134314"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 21:27:48 -0700
X-CSE-ConnectionGUID: V/Agzf02SsGEkTMfaKcsuA==
X-CSE-MsgGUID: TTYTZBhqTriz+yh+SmeBxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,248,1725346800"; 
   d="scan'208";a="86791849"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 21:27:46 -0700
Message-ID: <4632a527-3ed5-438c-b850-ddaf2f782f62@linux.intel.com>
Date: Fri, 1 Nov 2024 12:27:07 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/vt-d: Drain PRQs when domain removed from RID
To: Yi Liu <yi.l.liu@intel.com>, iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joel Granados
 <joel.granados@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org
References: <20241031095139.44220-1-baolu.lu@linux.intel.com>
 <97e78485-5eb2-44cb-ab33-4f8a8488b428@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <97e78485-5eb2-44cb-ab33-4f8a8488b428@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/1/24 10:52, Yi Liu wrote:
> On 2024/10/31 17:51, Lu Baolu wrote:
>> As this iommu driver now supports page faults for requests without
>> PASID, page requests should be drained when a domain is removed from
>> the RID2PASID entry.
>>
>> This results in the intel_iommu_drain_pasid_prq() call being moved to
>> intel_pasid_tear_down_entry(). This indicates that when a translation
>> is removed from any PASID entry and the PRI has been enabled on the
>> device, page requests are flushed in the domain detachment path.
> 
> s/flushed/drained/. 'drained' might suit the spec more than 'flushed'.

Done.

> 
> Per this change, the callers of the intel_pasid_tear_down_entry() will
> get a mandatory PRQ drain. I think this makes sense. But most of the
> callers do not follow a prq drain in the before. Will it introduce
> regression (especially performance regression)?

intel_pasid_tear_down_entry() is called only in slow paths, so it should
have minimal performance impact.

>>
>> The intel_iommu_drain_pasid_prq() helper has been modified to support
>> sending device TLB invalidation requests for both PASID and non-PASID
>> cases.
> 
> would it be better to rename it to be intel_iommu_drain_prq()? Also, it
> makes much sense to separate the PRQ related code into a prq.c. :) It
> might be done later though.

Yes, this has already been addressed in another series.

> 
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c |  1 -
>>   drivers/iommu/intel/pasid.c |  1 +
>>   drivers/iommu/intel/prq.c   | 22 +++++++---------------
>>   3 files changed, 8 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 87a3563dfe54..3878f35be09d 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -4069,7 +4069,6 @@ static void intel_iommu_remove_dev_pasid(struct 
>> device *dev, ioasid_t pasid,
>>       intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
>>       kfree(dev_pasid);
>>       intel_pasid_tear_down_entry(iommu, dev, pasid, false);
>> -    intel_iommu_drain_pasid_prq(dev, pasid);
>>   }
>>   static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
>> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
>> index 7e76062a7ad2..31665fb62e1c 100644
>> --- a/drivers/iommu/intel/pasid.c
>> +++ b/drivers/iommu/intel/pasid.c
>> @@ -265,6 +265,7 @@ void intel_pasid_tear_down_entry(struct 
>> intel_iommu *iommu, struct device *dev,
>>           iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
>>       devtlb_invalidation_with_pasid(iommu, dev, pasid);
>> +    intel_iommu_drain_pasid_prq(dev, pasid);
>>   }
>>   /*
>> diff --git a/drivers/iommu/intel/prq.c b/drivers/iommu/intel/prq.c
>> index 3c50c848893f..ae7f6f34462f 100644
>> --- a/drivers/iommu/intel/prq.c
>> +++ b/drivers/iommu/intel/prq.c
>> @@ -66,12 +66,8 @@ void intel_iommu_drain_pasid_prq(struct device 
>> *dev, u32 pasid)
>>       struct pci_dev *pdev;
>>       int head, tail;
>>       u16 sid, did;
>> -    int qdep;
>>       info = dev_iommu_priv_get(dev);
>> -    if (WARN_ON(!info || !dev_is_pci(dev)))
>> -        return;
>> -
>>       if (!info->pri_enabled)
>>           return;
>> @@ -81,8 +77,6 @@ void intel_iommu_drain_pasid_prq(struct device *dev, 
>> u32 pasid)
>>       sid = PCI_DEVID(info->bus, info->devfn);
>>       did = domain ? domain_id_iommu(domain, iommu) : FLPT_DEFAULT_DID;
>> -    qdep = pci_ats_queue_depth(pdev);
>> -
>>       /*
>>        * Check and wait until all pending page requests in the queue are
>>        * handled by the prq handling thread.
>> @@ -114,15 +108,13 @@ void intel_iommu_drain_pasid_prq(struct device 
>> *dev, u32 pasid)
>>       desc[0].qw0 = QI_IWD_STATUS_DATA(QI_DONE) |
>>               QI_IWD_FENCE |
>>               QI_IWD_TYPE;
>> -    desc[1].qw0 = QI_EIOTLB_PASID(pasid) |
>> -            QI_EIOTLB_DID(did) |
>> -            QI_EIOTLB_GRAN(QI_GRAN_NONG_PASID) |
>> -            QI_EIOTLB_TYPE;
>> -    desc[2].qw0 = QI_DEV_EIOTLB_PASID(pasid) |
>> -            QI_DEV_EIOTLB_SID(sid) |
>> -            QI_DEV_EIOTLB_QDEP(qdep) |
>> -            QI_DEIOTLB_TYPE |
>> -            QI_DEV_IOTLB_PFSID(info->pfsid);
>> +    qi_desc_piotlb(did, pasid, 0, -1, 0, &desc[1]);
> 
> Does it make more sense to submit iotlb desc when @pasid == IOMMU_NO_PASID
> just like you've done to the devtlb desc? Spec looks to be unclear on this
> part, but it sounds reasonable to use iotlb desc for the
> @pasid == IOMMU_NO_PASID case.

You are right. I will make it like below:

         if (pasid == IOMMU_NO_PASID) {
                 qi_desc_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH, 
&desc[1]);
                 qi_desc_dev_iotlb(sid, info->pfsid, info->ats_qdep, 0,
                                   MAX_AGAW_PFN_WIDTH, &desc[2]);
         } else {
                 qi_desc_piotlb(did, pasid, 0, -1, 0, &desc[1]);
                 qi_desc_dev_iotlb_pasid(sid, info->pfsid, pasid, 
info->ats_qdep,
                                         0, MAX_AGAW_PFN_WIDTH, &desc[2]);
         }


> 
>> +    if (pasid == IOMMU_NO_PASID)
>> +        qi_desc_dev_iotlb(sid, info->pfsid, info->ats_qdep, 0,
>> +                  MAX_AGAW_PFN_WIDTH, &desc[2]);
>> +    else
>> +        qi_desc_dev_iotlb_pasid(sid, info->pfsid, pasid, info->ats_qdep,
>> +                    0, MAX_AGAW_PFN_WIDTH, &desc[2]);
> 
> I noticed devtlb_invalidation_with_pasid() passes '64 - VTD_PAGE_SHIFT'
> which is equal to MAX_AGAW_PFN_WIDTH. Might be good to consolidate it. :)

Probably cleanup it in a separated patch.

>>   qi_retry:
>>       reinit_completion(&iommu->prq_complete);
>>       qi_submit_sync(iommu, desc, 3, QI_OPT_WAIT_DRAIN);
> 

0day reported a compiling issue:

drivers/iommu/intel/prq.c: In function 'intel_iommu_drain_pasid_prq':
 >> drivers/iommu/intel/prq.c:66:25: warning: variable 'pdev' set but 
not used [-Wunused-but-set-variable]
       66 |         struct pci_dev *pdev;
          |                         ^~~~

I will fix it in a v2.

Thanks,
baolu
