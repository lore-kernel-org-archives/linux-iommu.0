Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D708234B43D
	for <iommu@lists.linux.dev>; Fri, 16 Jan 2026 06:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768543592; cv=none; b=iRXAz0EhwwiVA0Tbt+Uw1QL2btT9SF0EBzR8+Gee9g9yHXAofih25M4DlKAxNERrfUQwBfYE1QpOTGPxicRw9DT3q5VhPBu1f8gR7rU5SCE/i2OSrFuRQ1DseesYt1ugd7D8Hw2b5LhNrZ4hMs0Ebtz/bmr3OD1Vkw8cJp4BGD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768543592; c=relaxed/simple;
	bh=Cki8LuyDdl7U9Z/ZxX0UFSLEBkjo2BF4Da0eNCWkEGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dViK8asnzhPDwmgBMXxouESJ/DkLmRHvun2/4h+8FSVDl1GAhW/D62OkMv6JfAlJH55yfJKbjy5c+bUU7RGUyrz8+hXdaZYeLluIuWl0Z33gW3tOZiFsM2a/xjVLUoJJe0YyG5gd9UN75f8JHod6MZtp9QrCAtlvzrgDhvN+DQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZEIzkO2e; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZEIzkO2e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768543591; x=1800079591;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Cki8LuyDdl7U9Z/ZxX0UFSLEBkjo2BF4Da0eNCWkEGI=;
  b=ZEIzkO2epBsvnW6r7E/l7DoEcifXZI88oAVuE+SDzd5dW9jSrYedsGCK
   Ue4Rpu9bqWZmDrWkz0Gq5b+uAVIez1Z9LgGatLWWoPhYxwH0AUOSU2GkK
   8e7UvZcXkuupcp+cnCnAN0YUNqZ2xEx8nS9aEdT+yJOjTf5BKLGtFEe9T
   gsQty0PSYRjhJJ6T5QBqg8vIUZ91zvb115tDb6UOxVKb03hOzxQNn5pMt
   eUhtxEisIhASUXt2FnPX2vd+Cs12sry8z0bn4z5US3/UWUJEu0haWGUdU
   rCIoPaJR+pNcNRCFnJA6g486bLER4TiCdv1CPGBpi4UKsL6lvEL/e5yHx
   w==;
X-CSE-ConnectionGUID: 1pDD3RycT4qQTqtR7zd/fw==
X-CSE-MsgGUID: PHGgnuepR9WkhTg9rsHKZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="73702721"
X-IronPort-AV: E=Sophos;i="6.21,230,1763452800"; 
   d="scan'208";a="73702721"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 22:06:30 -0800
X-CSE-ConnectionGUID: z94O0X6GSRe2DP9ku6Nnzg==
X-CSE-MsgGUID: gPRgDOhaQt2UDfzdTNIl8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,230,1763452800"; 
   d="scan'208";a="205576447"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 22:06:27 -0800
Message-ID: <59eb3d65-0962-4523-a4c9-8e4417217a0f@linux.intel.com>
Date: Fri, 16 Jan 2026 14:06:30 +0800
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
 <8e232d7f-9436-401e-9abc-308492a1fcbf@linux.intel.com>
 <aWd6KIGBiE-nL2IT@mitya-t14-2025>
 <6c1888bb-83ff-4121-baef-4c3c93dcbf58@linux.intel.com>
 <aWldkApQ3C9pfZ3_@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <aWldkApQ3C9pfZ3_@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/16/26 05:35, Dmytro Maluka wrote:
> On Thu, Jan 15, 2026 at 10:45:12AM +0800, Baolu Lu wrote:
>> On 1/14/26 19:12, Dmytro Maluka wrote:
>>> On Wed, Jan 14, 2026 at 01:38:13PM +0800, Baolu Lu wrote:
>>>> On 1/14/26 03:34, Dmytro Maluka wrote:
>>>>> On Tue, Jan 13, 2026 at 11:00:47AM +0800, Lu Baolu wrote:
>>>>>> +	intel_pasid_clear_entry(iommu, dev, pasid, fault_ignore);
>>>>> Is it safe to do this with iommu->lock already unlocked?
>>>>
>>>> Yes, it is. The PASID entry lifecycle is serialized by the iommu_group-
>>>>> mutex in the iommu core, which ensures that no other thread can attempt
>>>> to allocate or setup this same PASID until intel_pasid_tear_down_entry()
>>>> has returned.
>>>>
>>>> The iommu->lock is held during the initial transition (P->0) to ensure
>>>> atomicity against other hardware-table walkers, but once the P bit is
>>>> cleared and the caches are flushed, the final zeroing of the 'dead'
>>>> entry does not strictly require the spinlock because the PASID remains
>>>> reserved in software until the function completes.
>>>
>>> Ok. Just to understand: "other hardware-table walkers" means some
>>> software walkers, not hardware ones? Which software walkers are those?
>>> (I can't imagine how holding a spinlock could prevent the hardware from
>>> walking those tables. :))
>>
>> You are right. A spinlock doesn't stop the hardware. The spinlock
>> serializes software threads to ensure the hardware walker always sees a
>> consistent entry.
>>
>> When a PASID entry is active (P=1), other kernel paths might modify
>> the control bits in-place. For example:
>>
>> void intel_pasid_setup_page_snoop_control(struct intel_iommu *iommu,
>>                                            struct device *dev, u32 pasid)
>> {
>>          struct pasid_entry *pte;
>>          u16 did;
>>
>>          spin_lock(&iommu->lock);
>>          pte = intel_pasid_get_entry(dev, pasid);
>>          if (WARN_ON(!pte || !pasid_pte_is_present(pte))) {
>>                  spin_unlock(&iommu->lock);
>>                  return;
>>          }
>>
>>          pasid_set_pgsnp(pte);
>>          did = pasid_get_domain_id(pte);
>>          spin_unlock(&iommu->lock);
>>
>>          intel_pasid_flush_present(iommu, dev, pasid, did, pte);
>> }
>>
>> In this case, the iommu->lock ensures that if two threads try to modify
>> the same active entry, they don't interfere with each other and leave
>> the entry in a 'torn' state for the IOMMU hardware to read.
>>
>> In intel_pasid_tear_down_entry(), once the PASID entry is deactivated
>> (setting P=0 and flushing caches), the entry is owned exclusively  by
>> the teardown thread until it is re-configured. That's the reason why the
>> final zeroing doesn't need the spinlock.
> 
> I see. Am I correct that those other code paths (modifying an entry
> in-place) are not supposed to do that concurrently with
> intel_pasid_tear_down_entry(), i.e. they should only do that while it is
> guaranteed that the entry remains present? Otherwise there is a bug
> (hence, for example, the WARN_ON in
> intel_pasid_setup_page_snoop_control())?

The iommu driver assumes that high-level software should ensure this.

> So, holding iommu->lock during
> entry teardown is not strictly necessary (i.e. we could unlock it even
> earlier than setting P=0), i.e. holding the lock until the entry is
> deactivated is basically just a safety measure for possible buggy code?

There are other paths that may be concurrent, such as the debugfs path
(dumping the pasid table through debugfs). Therefore, keeping iommu-
 >lock in the driver is neither redundant nor buggy.

Thanks,
baolu
