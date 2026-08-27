Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F61F2D249B
	for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 06:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787810975; cv=none; b=JAFBwYd377No7L8H99FWATXG2hKd4uBQgfWAoeG4hxneTpPOS6O/l4z4E37vLNw7MHd8dLGmap//gnPKzVodclV/rT9x9MmXCyEYt01Y8V297wGL8KrzPye0c5GiV3cZhClhgmor1vKFQy4OiSwhqdjsORYMsvO4AM7cSF0+LzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787810975; c=relaxed/simple;
	bh=mDll/zSBYUEMKB7xEKrppfdqwwnySHDG0yAdmQ7Vm3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V1XjNV27lpPVLTItpOVh7jSQf0r9SiERkaL4ut1lJLbcqjXcXTBOpfnCwmuibhSdJcsnTdHh0JK4v48zF5SH7Oie7eI60I6zXag0Gs8tj2xg5oT+SqJuIl9boaceMIlJwlZ76mHrHkvzmpzSHyfihb/rMbaG9bZDnW1YhweSLus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IhgTWnfE; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IhgTWnfE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787810973; x=1819346973;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mDll/zSBYUEMKB7xEKrppfdqwwnySHDG0yAdmQ7Vm3w=;
  b=IhgTWnfEeLhhdYQ+wJZ5B3+IOYbtjoT52Fzl91DJnTbCJm7d5UyPJid+
   SYKkcHM4+7uWIZfocYyAw5CtHFD23yDL7mN1/agMGWpsH65Qi385asq+M
   ymrmF2Bj+caU5U1x/daWoo5BEvPwnQ0uP2rd7LUbZUfRTvclUWIS+MdUb
   TXtlmq6nWQNWs+m/AFQpcqRBFsM2mgc8KfkfS8zEuY6FFxwbw6Gvv8euI
   oUMTBrOcKmtXGvH0Jy400bUkRGS95r7MKlMsEZ2LtP8ss7e9fdoLHMNpY
   wKzgitt7fKJ8tLrjJJ9GpmNB8g4ZlQhHhcGd9CKfc1SeTD4+w5NojOG2C
   w==;
X-CSE-ConnectionGUID: 3q7Z7fIsRjSHK/k6PYvYPA==
X-CSE-MsgGUID: suosTxwDSRujBQqJxCjCWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="87438963"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="87438963"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 23:09:32 -0700
X-CSE-ConnectionGUID: Mn5VKsKwRhu3Qp/T58hIUg==
X-CSE-MsgGUID: rZTYuaLWQHmxe/Q+Cyc9RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="264010874"
Received: from blu2-desk.sh.intel.com (HELO [10.239.156.26]) ([10.239.156.26])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 23:09:29 -0700
Message-ID: <5862e3cc-e7e4-43be-a829-8569d12d6bb4@linux.intel.com>
Date: Thu, 27 Aug 2026 14:09:26 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/18] iommu/vt-d: Clear unpreserved context entries
 during shutdown
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Pratyush Yadav <pratyush@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Matlack <dmatlack@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
References: <20260808022723.3893618-1-skhawaja@google.com>
 <20260808022723.3893618-9-skhawaja@google.com>
 <446684d8-44d0-47c5-9301-172c55efd950@linux.intel.com>
 <ao9ADjoGzgNX4t1M@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ao9ADjoGzgNX4t1M@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/27/26 04:30, Samiullah Khawaja wrote:
> 
>>> +static void clear_unpreserved_context(struct device_domain_info 
>>> *info, u8 bus, u8 devfn)
>>> +{
>>> +    struct context_entry *context;
>>> +
>>> +    /*
>>> +     * This cleanup is done during shutdown, so it should be fine to 
>>> only
>>> +     * clear the entries here and issue one global invalidation 
>>> later to
>>> +     * invalidate all cleared entries.
>>> +     *
>>> +     * Note that the device IOTLB invalidation for unpreserved 
>>> devices is
>>> +     * skipped this way, but that should not be needed as the 
>>> devices are
>>> +     * quiesced at this point. This should improve the performance 
>>> of the
>>> +     * cleanup process and avoids any invalidation timeouts because 
>>> drivers
>>> +     * might have moved devices to D3 state.
>>> +     */
>>> +    context = iommu_context_addr(info->iommu, bus, devfn, 0);
>>> +    if (context) {
>>> +        context_clear_entry(context);
>>> +        __iommu_flush_cache(info->iommu, context, sizeof(*context));
>>
>> For tearing down a present context entry, please follow the VT-d
>> recommended sequence:
>>
>> - clear only the Present bit,
>> - flush the updated entry to memory if necessary,
>> - issue the required cache invalidations,
> 
> Do we still need the individual cache invalidations if we issue global
> invalidations (context, pasid-cache and iotlb), after clearing all
> entries, as they would be done if a new root table was being setup?
> 
> Looking at the VT-d specs (Invalidation of Translation Caches), each
> invalidation type (cache, pasid and iotlb) defines granularity in both
> register and queue based interface. And the granularity indicates that
> Global invalidations clear the cached entries for that specific type.
> For example following text is used for each cache type (in queue
> interface):
> 
>    Context-cache:
>    Global Invalidation (01b): All context-cache entries cached at the
>    remapping hardware are invalidated.
> 
>    Pasid-cache:
>    Global Invalidation (11b): All PASID-cache entries are invalidated.
> 
>    Iotlb:
>    Global Invalidation (01b):
>    - All IOTLB entries are invalidated.
>    - All paging-structure-cache entries are invalidated.
> 
> A similar note about using Global invalidation is suggested in the specs
> when setting up root table (Set Root Table Pointer Operation).
> 
>    ... software must perform a global invalidate of the contextcache,
>    PASID-cache (if applicable), and IOTLB, in that order. This is
>    required to ensure hardware references only the remapping structures
>    referenced by the new root table pointer and not stale cached entries.
> 
> Also please note that this is happening during dmar unit teardown and
> system shutdown, and while the context table entries in root table are
> being cleared, the memory is not freed until the global invalidation is
> issued.
> 
> Since this is during shutdown, issuing global invalidations instead of
> multiple individual invalidations for devices and aliases is simpler and
> would likely also have shutdown time improvements and reduce the
> blackout time during liveupdate.
> 
> Please let me know if my global invalidations and granularity
> understanding is not correct.

The global-invalidation approach (similar to the “set new root table”
flow) looks correct to me.

On the device side: if ATS is enabled, some translations may still be
cached in the device. My understanding is that unpreserved devices are
already DMA-quiesced and then go through reset + reprobe (as in a normal
reboot), which should flush those device-side caches. Are we aligned on
that assumption?

> 
> I added a comment at the top of this function to explain this, let me
> know if you want me to expand it with more details.
> 
>> - then clear the remaining fields of the entry. 

One important point remains: even if cache invalidation is deferred and
done globally, we should still clear the Present bit before clearing the
rest of a context entry. While Present is set, hardware may fetch the
256-bit entry in multiple chunks. Rewriting the full entry is not atomic
(it becomes multiple CPU writes), so hardware could observe a torn value
(a mix of old and new fields), which may lead to undefined behavior or
spurious faults.

So the recommended sequence is:
- clear only the Present bit,
- flush the updated entry to memory if necessary,
- [add a comment about the delayed global invalidation approach,]
- then clear the remaining fields of the entry.

Thanks,
baolu

