Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3E220DD65
	for <iommu@lists.linux.dev>; Wed,  5 Feb 2025 02:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738722522; cv=none; b=OW1k47O7A8aRQdx1RC/KVVDr4un2PYaUBgIJ9p7QxGgrHggQVNetBfevqCistIWLN2v424mhlntoTdkoiEAq9gxsGBGxuguokmNWtuibj4yEBVRrT5s1kBnPvSdeHm04E+jKVe1OI5Qqlu+oG/pWU2TnZzZcPYjI78IVcYV9Rc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738722522; c=relaxed/simple;
	bh=Xk8RR9GftsHj4y0HQNqLNT78o3cejeCFocN4ysQOLqQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ks7J6YFL7XSX/LI8GqgBUQ5z8FELYWd/egBAmBTfuGXrHEbXfqrfRRYQp9yI/lxsMzZQACZcUhE6u4UjAy12dc4zQZsPXHWwNdXIR1aAzoRwvLSSbAFVBILrQM0gJkuaT9Cb38SPnuaC+At6dVb5qIyO7rjCBHntmc6vyxGlH/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AwuRvFFk; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AwuRvFFk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738722520; x=1770258520;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Xk8RR9GftsHj4y0HQNqLNT78o3cejeCFocN4ysQOLqQ=;
  b=AwuRvFFk7RzGQngEOrHxjIbc5pv309QnQvPWYGCArGV4Y6ZhKmMsetCq
   6jFZ4PLNA9ViIvlQLqYu2UvdC3CPl9/OVJBpCLhYirg0j1Kt0L0XEg05/
   ggH0CQHwx7taxmUs4lh4liIWMIQho2huO+gSMdnNBWSFOu4GINvhDykEG
   PuhO4kZ5J9L11vJ4W/PJNkIV/d2v30MYgYO8SR1z8SyKpR/80QRmKhuuF
   ERzszQdQhbM2iF9k9O2hjGm6sSK9QVMhFgqR4/gncQoWCHTfwvC9funoL
   WwxWQocJh7OUwjLeJNnhGjnfI1hKtE/D9p7yQ8YezpFc+7PbCtlk0zKzH
   Q==;
X-CSE-ConnectionGUID: 11sdI03DRPWRryc4XCaPVA==
X-CSE-MsgGUID: xmdQt+SASZCgqACV3jOCYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="39380946"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="39380946"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 18:28:40 -0800
X-CSE-ConnectionGUID: c0apBYhbSOSFXVZwC1lGnQ==
X-CSE-MsgGUID: U+8h4zgnRyuh/QffODtlhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="134012636"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.242.149]) ([10.124.242.149])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 18:28:37 -0800
Message-ID: <941d401c-c009-4dcf-bb93-00c25490dd38@linux.intel.com>
Date: Wed, 5 Feb 2025 10:28:35 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Make intel_iommu_drain_pasid_prq()
 cover faults for RID
To: Yi Liu <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>
References: <20250121023150.815972-1-baolu.lu@linux.intel.com>
 <3cca401b-e274-471b-8910-bb30873ead1b@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <3cca401b-e274-471b-8910-bb30873ead1b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/1/21 15:01, Yi Liu wrote:
> On 2025/1/21 10:31, Lu Baolu wrote:
>> This driver supports page faults on PCI RID since commit <9f831c16c69e>
>> ("iommu/vt-d: Remove the pasid present check in prq_event_thread") by
>> allowing the reporting of page faults with the pasid_present field 
>> cleared
>> to the upper layer for further handling. The fundamental assumption here
>> is that the detach or replace operations act as a fence for page faults.
>> This implies that all pending page faults associated with a specific RID
>> or PASID are flushed when a domain is detached or replaced from a device
>> RID or PASID.
>>
>> However, the intel_iommu_drain_pasid_prq() helper does not correctly
>> handle faults for RID. This leads to faults potentially remaining pending
>> in the iommu hardware queue even after the domain is detached, thereby
>> violating the aforementioned assumption.
>>
>> Fix this issue by extending intel_iommu_drain_pasid_prq() to cover faults
>> for RID.
>>
>> Fixes: 9f831c16c69e ("iommu/vt-d: Remove the pasid present check in 
>> prq_event_thread")
>> Cc: stable@vger.kernel.org
>> Suggested-by: Kevin Tian <kevin.tian@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>> ---
>>   drivers/iommu/intel/prq.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> Change log:
>> v2:
>>   - Add check on page faults targeting RID.
>>
>> v1: https://lore.kernel.org/linux-iommu/20250120080144.810455-1- 
>> baolu.lu@linux.intel.com/
>>
>> diff --git a/drivers/iommu/intel/prq.c b/drivers/iommu/intel/prq.c
>> index c2d792db52c3..064194399b38 100644
>> --- a/drivers/iommu/intel/prq.c
>> +++ b/drivers/iommu/intel/prq.c
>> @@ -87,7 +87,9 @@ void intel_iommu_drain_pasid_prq(struct device *dev, 
>> u32 pasid)
>>           struct page_req_dsc *req;
>>           req = &iommu->prq[head / sizeof(*req)];
>> -        if (!req->pasid_present || req->pasid != pasid) {
>> +        if (req->rid != sid ||
> 
> Does intel-iommu driver managed pasid per-bdf? or global? If the prior one,
> the rid check is needed even in the old time that does not PRIs in the RID
> path.

Do you mean that this fix should be back ported farther than the fix tag
commit?

The iommu driver doesn't manage the PASID. IOMMUFD and SVA do actually.
The SVA uses global PASID. IOMMUFD doesn't yet support PASIDs, pending
the merging of your patches. Therefore, per-BDF PASID management is not
currently implemented in the Linux tree. Anything I overlooked?

---
baolu
