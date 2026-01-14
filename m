Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653402D7DE2
	for <iommu@lists.linux.dev>; Wed, 14 Jan 2026 05:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768369101; cv=none; b=nbdq/03xLvgXbnJXnHsWYx3xuRJN3uJV5jrlHDoAvQuGven5rowhJ1CVj2+W/QnS15QUeZRoAvv/Q4NV1FcJVcsoOG2qGyU/LA15ULT3/vIlQKF7cpsJXN3xSyc8vW3lsy7Oq8uGtD+nJO597g0rIeZ9VYouJLO9qCleJAvaeyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768369101; c=relaxed/simple;
	bh=NaWNGC8eIe6DWhS5jjIGjpVMO28905qyt/11nl+saBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uSKRpKvkg6ylfj5cgxKQrC5plez/PRHcz2EuObczkFS+hnku+zop6NQaxMEXWTSu3yBaHmYpE7bsARiJR77I8EqtTbE2NmD+DQo4M36n4CVMDpiJkdJZAerJU9z2xs4M1k/2wqtaXIBG5s07wJvX/oORLI36tLQTYqfKuvEWVKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WQwp/ubH; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WQwp/ubH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768369093; x=1799905093;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NaWNGC8eIe6DWhS5jjIGjpVMO28905qyt/11nl+saBY=;
  b=WQwp/ubHjZU4ShnFLC/RM1rDfSLQk1MOv+qUgiBjCx524sE976po0Tsm
   41AX0/X0k5CFLQ6pPKkPevFtR+3lcG+afpfW3TVKZaLHjKrpyozGZBjeg
   WvCOi7kSePUOtG9OXHMupdVVgULA17raM6sfUiZ5nZxqQfFDlgAkRtMq6
   2Pf1JlbeLn8GTxJKkvcO9XmqubWytvymuKB70wDFVl8KNQ8WTnKC+JizM
   rjn+XJtV7O0ADgo/4277WYUHcPIXVcrqlFfzlkWfjigLxyQzvt4m4KJr/
   DNqGgvb2A3cfkbYlrBfw9h6O5CxHS6KzS2q8Yk2YbJ/5tqVxGziB5BYTJ
   w==;
X-CSE-ConnectionGUID: BT3SxlO2RvWlw0PuImnMgg==
X-CSE-MsgGUID: iIprT5cqTzKjBGm2KB8ERw==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="81112322"
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="81112322"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 21:38:10 -0800
X-CSE-ConnectionGUID: yInFS5wVRaaDy0aIdlqY/Q==
X-CSE-MsgGUID: jhDDwrdeRyyLOcfa+tUhVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="209631175"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 21:38:07 -0800
Message-ID: <8e232d7f-9436-401e-9abc-308492a1fcbf@linux.intel.com>
Date: Wed, 14 Jan 2026 13:38:13 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iommu/vt-d: Clear Present bit before tearing down
 PASID entry
To: Dmytro Maluka <dmaluka@chromium.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
 Aashish Sharma <aashish@aashishsharma.net>
References: <20260113030052.977366-1-baolu.lu@linux.intel.com>
 <20260113030052.977366-3-baolu.lu@linux.intel.com>
 <aWaeUJcAFQ_vbJtd@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <aWaeUJcAFQ_vbJtd@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/14/26 03:34, Dmytro Maluka wrote:
> On Tue, Jan 13, 2026 at 11:00:47AM +0800, Lu Baolu wrote:
>> The Intel VT-d Scalable Mode PASID table entry consists of 512 bits (64
>> bytes). When tearing down an entry, the current implementation zeros the
>> entire 64-byte structure immediately.
>>
>> However, the IOMMU hardware may fetch these 64 bytes using multiple
>> internal transactions (e.g., four 128-bit bursts). If a hardware fetch
>> occurs simultaneously with the CPU zeroing the entry, the hardware could
>> observe a "torn" entry — where some chunks are zeroed and others still
>> contain old data — leading to unpredictable behavior or spurious faults.
>>
>> Follow the "Guidance to Software for Invalidations" in the VT-d spec
>> (Section 6.5.3.3) by implementing a proper ownership handshake:
>>
>> 1. Clear only the 'Present' (P) bit of the PASID entry. This tells the
>>     hardware that the entry is no longer valid.
>> 2. Execute the required invalidation sequence (PASID cache, IOTLB, and
>>     Device-TLB flush) to ensure the hardware has released all cached
>>     references to the entry.
>> 3. Only after the flushes are complete, zero out the remaining fields of
>>     the PASID entry.
>>
>> Additionally, add an explicit clflush in intel_pasid_clear_entry() to
>> ensure that the cleared entry is visible to the IOMMU on systems where
>> memory coherency (ecap_coherent) is not supported.
>>
>> Fixes: 0bbeb01a4faf ("iommu/vt-d: Manage scalalble mode PASID tables")
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/pasid.h | 12 ++++++++++++
>>   drivers/iommu/intel/pasid.c |  9 +++++++--
>>   2 files changed, 19 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
>> index b4c85242dc79..35de1d77355f 100644
>> --- a/drivers/iommu/intel/pasid.h
>> +++ b/drivers/iommu/intel/pasid.h
>> @@ -237,6 +237,18 @@ static inline void pasid_set_present(struct pasid_entry *pe)
>>   	pasid_set_bits(&pe->val[0], 1 << 0, 1);
>>   }
>>   
>> +/*
>> + * Clear the Present (P) bit (bit 0) of a scalable-mode PASID table entry.
>> + * This initiates the transition of the entry's ownership from hardware
>> + * to software. The caller is responsible for fulfilling the invalidation
>> + * handshake recommended by the VT-d spec, Section 6.5.3.3 (Guidance to
>> + * Software for Invalidations).
>> + */
>> +static inline void pasid_clear_present(struct pasid_entry *pe)
>> +{
>> +	pasid_set_bits(&pe->val[0], 1 << 0, 0);
>> +}
>> +
>>   /*
>>    * Setup Page Walk Snoop bit (Bit 87) of a scalable mode PASID
>>    * entry.
>> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
>> index 298a39183996..4f36138448d8 100644
>> --- a/drivers/iommu/intel/pasid.c
>> +++ b/drivers/iommu/intel/pasid.c
>> @@ -178,7 +178,8 @@ static struct pasid_entry *intel_pasid_get_entry(struct device *dev, u32 pasid)
>>    * Interfaces for PASID table entry manipulation:
>>    */
>>   static void
>> -intel_pasid_clear_entry(struct device *dev, u32 pasid, bool fault_ignore)
>> +intel_pasid_clear_entry(struct intel_iommu *iommu, struct device *dev,
>> +			u32 pasid, bool fault_ignore)
>>   {
>>   	struct pasid_entry *pe;
>>   
>> @@ -190,6 +191,9 @@ intel_pasid_clear_entry(struct device *dev, u32 pasid, bool fault_ignore)
>>   		pasid_clear_entry_with_fpd(pe);
>>   	else
>>   		pasid_clear_entry(pe);
>> +
>> +	if (!ecap_coherent(iommu->ecap))
>> +		clflush_cache_range(pe, sizeof(*pe));
>>   }
>>   
>>   static void
>> @@ -272,7 +276,7 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
>>   
>>   	did = pasid_get_domain_id(pte);
>>   	pgtt = pasid_pte_get_pgtt(pte);
>> -	intel_pasid_clear_entry(dev, pasid, fault_ignore);
>> +	pasid_clear_present(pte);
>>   	spin_unlock(&iommu->lock);
>>   
>>   	if (!ecap_coherent(iommu->ecap))
>> @@ -286,6 +290,7 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
>>   		iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
>>   
>>   	devtlb_invalidation_with_pasid(iommu, dev, pasid);
>> +	intel_pasid_clear_entry(iommu, dev, pasid, fault_ignore);
> Is it safe to do this with iommu->lock already unlocked?

Yes, it is. The PASID entry lifecycle is serialized by the iommu_group-
 >mutex in the iommu core, which ensures that no other thread can attempt
to allocate or setup this same PASID until intel_pasid_tear_down_entry()
has returned.

The iommu->lock is held during the initial transition (P->0) to ensure
atomicity against other hardware-table walkers, but once the P bit is
cleared and the caches are flushed, the final zeroing of the 'dead'
entry does not strictly require the spinlock because the PASID remains
reserved in software until the function completes.

Thanks,
baolu
