Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D621E3B3BF2
	for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 07:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773301868; cv=none; b=KWmHn954HS2gc6R4h0M9zNl3bZIMz5bf9WuhcHCBpPApslkmaNgv77xZIwqAK3DIbqx0sqxF5N2uwbu3YwWmawBw+Dmx3eZ7nHFeYSeDUIoA0PlICgebUANawo6Nd2/lk/UVhcsgC6s2ugpQeFDLGT18PswWQNzsq3tyt8Nz4mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773301868; c=relaxed/simple;
	bh=Usjq7gCVH0h3I9rHEDHU0rerhoekol8KRpIBZR5dftE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DoShj/xpFHAcxo97dNhJVTDBEqXuuJKUh5Yha4cmigb5eRrDvY/ntH63Nk8nGuu4Z1DXUAgd5Z5WpdFj0jVxWReOkIlskniczI1mCmVGCYa+1AxpZJiENwEgVF6vVc848xz1a5JzYWpNLJM5ZIP6FTm1WMfO8jQvqd/fJq+A6BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=flFS63n4; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="flFS63n4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773301858; x=1804837858;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Usjq7gCVH0h3I9rHEDHU0rerhoekol8KRpIBZR5dftE=;
  b=flFS63n4nFqZrQgoG86/grRIZM0caIPI4DuyM6NQv00Ci1FraEcNISIU
   76GnpYYCd8ZUvv9Mgeftxi+QV5RIxkUHbOepcBgDDj9ANzP7tsescXKz3
   E4U4ffGSKy73qkZooQZGqEXH//XXxi7myhOBqdpFGxEvKPEznVxmnVnNX
   usjUW8In2BeajzWHe57Hn8ZbPtmbfpQJFH2NgzorQKALXoceCoNQ8HGp5
   7zXb9CHejfSxaI3s3EUbB9rJlTDTpJ6JZOqyGD7VOqCUOBWy4ycsCzdFq
   jwtFPQjvPm9RXeN2VNwvl1TEu+128IMgJeKEUgTAqqBk9xve8IQsxonej
   w==;
X-CSE-ConnectionGUID: AMSH8Sn1RHqekXrzP1LG8A==
X-CSE-MsgGUID: uyPjDLweTz6pqrbUHzZCSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="74263413"
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="74263413"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 00:50:57 -0700
X-CSE-ConnectionGUID: K+IkiWk3Qs6C0zVsMlM2DQ==
X-CSE-MsgGUID: ex/a9I8zS8uo/C8kfYr3bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="258642759"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 00:50:54 -0700
Message-ID: <4fbe6dcf-1105-4efc-b755-81a5bfb74090@linux.intel.com>
Date: Thu, 12 Mar 2026 15:50:03 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] iommu/vt-d: Add entry_sync support for PASID entry
 updates
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Dmytro Maluka <dmaluka@chromium.org>, Samiullah Khawaja
 <skhawaja@google.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260309060648.276762-1-baolu.lu@linux.intel.com>
 <20260309060648.276762-3-baolu.lu@linux.intel.com>
 <20260309134116.GE3717316@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260309134116.GE3717316@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/9/26 21:41, Jason Gunthorpe wrote:
>> +static void intel_pasid_sync(struct entry_sync_writer128 *writer)
>> +{
>> +	struct intel_pasid_writer *p_writer = container_of(writer,
>> +			struct intel_pasid_writer, writer);
>> +	struct intel_iommu *iommu = p_writer->iommu;
>> +	struct device *dev = p_writer->dev;
>> +	bool was_present, is_present;
>> +	u32 pasid = p_writer->pasid;
>> +	struct pasid_entry *pte;
>> +	u16 old_did, old_pgtt;
>> +
>> +	pte = intel_pasid_get_entry(dev, pasid);
>> +	was_present = p_writer->was_present;
>> +	is_present = pasid_pte_is_present(pte);
>> +	old_did = pasid_get_domain_id(&p_writer->orig_pte);
>> +	old_pgtt = pasid_pte_get_pgtt(&p_writer->orig_pte);
>> +
>> +	/* Update the last present state: */
>> +	p_writer->was_present = is_present;
>> +
>> +	if (!ecap_coherent(iommu->ecap))
>> +		clflush_cache_range(pte, sizeof(*pte));
>> +
>> +	/* Sync for "P=0" to "P=1": */
>> +	if (!was_present) {
>> +		if (is_present)
>> +			pasid_flush_caches(iommu, pte, pasid,
>> +					   pasid_get_domain_id(pte));
>> +
>> +		return;
>> +	}
>> +
>> +	/* Sync for "P=1" to "P=1": */
>> +	if (is_present) {
>> +		intel_pasid_flush_present(iommu, dev, pasid, old_did, pte);
>> +		return;
>> +	}
>> +
>> +	/* Sync for "P=1" to "P=0": */
>> +	pasid_cache_invalidation_with_pasid(iommu, old_did, pasid);
> Why all this logic? All this different stuff does is meddle with the
> IOTLB and it should not seen below.
> 
> If the sync is called it should just always call
> pasid_cache_invalidation_with_pasid(), that's it.
> 
> Writer has already eliminated all cases where sync isn't needed.

You're right. The library should simplify things. I will remove the
state tracking. The callback will only ensure that memory is flushed
(for non-coherent mode) and the relevant PASID cache is invalidated.

> 
>> +	if (old_pgtt == PASID_ENTRY_PGTT_PT || old_pgtt == PASID_ENTRY_PGTT_FL_ONLY)
>> +		qi_flush_piotlb(iommu, old_did, pasid, 0, -1, 0);
>> +	else
>> +		iommu->flush.flush_iotlb(iommu, old_did, 0, 0, DMA_TLB_DSI_FLUSH);
>> +	devtlb_invalidation_with_pasid(iommu, dev, pasid);
> The IOTLB should already be clean'd before the new entry using the
> cache tag is programmed. Cleaning it after the entry is live is buggy.
 > > The writer logic ensures it never sees a corrupted entry, so the clean
> cache tag cannot be mangled during the writing process.
> 
> The way ARM is structured has the cache tags clean if they are in the
> allocator bitmap, so when the driver fetches a new tag and starts
> using it is clean and non cleaning is needed
> 
> When it frees a tag it cleans it and then returns it to the allocator.

If I understand your remark correctly, the driver should only need the
following in the sync callback:

- clflush (if non-coherent) to ensure the entry is in physical memory.
- PASID cache invalidation to force the hardware to re-read the entry.
- Device-TLB invalidation to drop local device caches.

Does that sound right? I can move the general IOTLB/PIOTLB invalidation
logic to the domain detach/free paths.

> ATC invalidations should always be done after the PASID entry is
> written. During a hitless update both translations are unpredictably
> combined, this is unavoidable and OK.

The VT-d spec (Sections 6.5.2.5 and 6.5.2.6) explicitly mandates that an
IOTLB invalidation must precede the Device-TLB invalidation. If we only
do the device-TLB invalidation in the sync callback, we risk the device
re-fetching a stale translation from the IOMMU's internal IOTLB.

Thanks,
baolu
