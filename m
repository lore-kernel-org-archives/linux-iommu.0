Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9C11DE885
	for <iommu@lists.linux.dev>; Fri,  9 Jan 2026 06:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767940373; cv=none; b=KYk1nesQxGZSpkuWpQ7yF4IFCLecUE8UK49SFp51bbwAGyZlpRfqBrmJdo71Dyh8e0PALazgahNP/o3WdQO2b8DL8VOhqGuvFOx+YKb08N9QhjMdO/cYkSD97K6bubqlKlCtuc/iffYOqWGA9zXromo5Ishg12aJm7HXVbSZBcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767940373; c=relaxed/simple;
	bh=o1bzcRFAbGGR1RiZWRemxRqqakMYAxgbuXzphpzN8kQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bce5WXHBsXc0OcACatlZ486vxSUoB0xfjyZruNdX3YjZPjOtJaPe/ScgAkm8Q3u+wkDmnofLtBD/Qz1PgdAUOu937C9L7sEoeGDhwDFU+8UghCA4nolCGvjAjnzTlOYcYxX1Un/8jDi59uNa1iLRBeC9RlGqBRmooVG+Z/cbd8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hM9K1i9w; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hM9K1i9w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767940372; x=1799476372;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=o1bzcRFAbGGR1RiZWRemxRqqakMYAxgbuXzphpzN8kQ=;
  b=hM9K1i9wUGHnZwF8ndqx5tkWPOKRIUdln86nXvWsIF6QggQMAvXKkSIG
   LmTKALVHXw7JPWnoCMi2yaK7+DuYy6pKG5oeDGBzh6WWSLtTXc+12QOT7
   vZxcjgCj1abiCjUFyfUky/1G/JogZuDIRuukHOi03Zp0bQDuYC1+uTsDF
   t1vXF6fowjuraCfeSzeS0JB04E3tYpRzTApEkI01kg/txihXO7NB1K9WD
   IdL8yZLod7Ldt+pMBpiwJX2dRxuPo21rQe/90kiefxu08LjLKuA/TilRl
   UOXaGtCLWMQwDhe3k70qwSatzWmhJKUnoQMgKSJu88lnRVJ8/FElkL8iU
   Q==;
X-CSE-ConnectionGUID: /QZK+L70StCzraB1tzg4zQ==
X-CSE-MsgGUID: TTJldM+iR2asWOlC/NdMaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="80687238"
X-IronPort-AV: E=Sophos;i="6.21,212,1763452800"; 
   d="scan'208";a="80687238"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 22:32:51 -0800
X-CSE-ConnectionGUID: f8qXV5c8RbCS71bpbPWKhA==
X-CSE-MsgGUID: bIzjGvcTQc6xiXul/PRKdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,212,1763452800"; 
   d="scan'208";a="203173713"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 22:31:57 -0800
Message-ID: <2f9e3589-d488-4ffb-9ae9-0d69ac77a8fb@linux.intel.com>
Date: Fri, 9 Jan 2026 14:32:12 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] iommu/vt-d: Ensure memory ordering in context &
 root entry updates
To: "Tian, Kevin" <kevin.tian@intel.com>, Dmytro Maluka
 <dmaluka@chromium.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: David Woodhouse <dwmw2@infradead.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
 Aashish Sharma <aashish@aashishsharma.net>,
 Grzegorz Jaszczyk <jaszczyk@chromium.org>,
 "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
References: <20251227175728.4358-1-dmaluka@chromium.org>
 <20260105181200.GH125261@ziepe.ca> <aVwI_SHHGPl0xndu@google.com>
 <20260105191410.GJ125261@ziepe.ca> <aVwZkFQ-iQ7OHMi2@google.com>
 <20260106001418.GK125261@ziepe.ca> <aV0TalseaDGW-1Jp@mitya-t14-2025>
 <20260106142301.GS125261@ziepe.ca> <aV0vM9ad-4QhCNaA@mitya-t14-2025>
 <BN9PR11MB52764C6A9F1774DDAFED41258C85A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52764C6A9F1774DDAFED41258C85A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/8/26 10:09, Tian, Kevin wrote:
>> From: Dmytro Maluka <dmaluka@chromium.org>
>> Sent: Tuesday, January 6, 2026 11:50 PM
>>
>> On Tue, Jan 06, 2026 at 10:23:01AM -0400, Jason Gunthorpe wrote:
>>> On Tue, Jan 06, 2026 at 02:51:38PM +0100, Dmytro Maluka wrote:
>>>> Regarding flushing caches right after that - what for? (BTW the Intel
>>>> driver doesn't do that either.) If we don't do that and as a result the
>>>> HW is using an old entry cached before we cleared the present bit, it
>>>> is not affected by our later modifications anyway.
>>>
>>> You don't know what state the HW fetcher is in. This kind of race is possible:
>>>
>>>       CPU                 FETCHER
>>>                          read present = 1
>>>      present = 0
>>>      mangle qword 1
>>>                          read qword 1
>>>                          < fail - HW sees a corrupted entry >
>>>
>>> The flush is not just a flush but a barrier to synchronize with the HW
>>> that it is done all fetches that may have been dependent on seeing
>>> present = 1.
>>>
>>> So missing a flush after clearing present is possibly a bug today - I
>>> don't remember what guarenteed the atomic size is for Intel IOMMU
>>> though, if the atomic size is the whole entry it is OK since there is
>>> only one fetcher read. Though AMD is 128 bits and ARM is 64 bits.
>>
>> Indeed, may be a bug... In the VT-d spec I don't immediately see a
>> guarantee that context and PASID entries are fetched atomically. (And
>> for PASID entries, which are 512 bits, that seems particularly
>> unlikely.)
>>
> 
> 512bits atomicity is possible, but not on the PASID entry.
> 
> VT-d spec, head of section 9 (Translation Structure Formats):
> 
> "
> This chapter describes the memory-resident structures for DMA and
> interrupt remapping. Hardware must access structure entries that
> are 64-bit or 128-bit atomically. Hardware must update a 512-bit
> Posted Interrupt Descriptor (see Section 9.11 for details) atomically.
> Other than the Posted Interrupt Descriptor (PID), hardware is allowed
> to break access to larger than 128-bit entries into multiple aligned
> 128-bit accesses.
> "
> 
> root entry, scalable root entry, context entry and IRTE are 128bits
> so they are OK.
> 
> scalable context entry are 256bits but only the lower 128bits are
> defined so it's OK for now.
> 
> scalable PASID directory entry is 64bits. ok.
> 
> posted interrupt descriptor is 512bits with atomicity guaranteed.
> 
> but we do have problem on scalable pasid entry which is 512bits.
>    - bits beyond 191 are for future hardware, not a problem now
>    - bits 128-191 are for 1st-stage
>    - bits 0-127 manages stage selection, 2nd-stage, and some 1st-stage
> 
> so in theory 1st-stage and nesting are affected by this bug.

Yes. This is a real software bug. The hardware is legally allowed to
tear the pasid table entry read into 4 128-bit chunks. For first-stage
(first-only or nested) translation, chunk 1 (bit 0-127) and chunk 2 (bit
128-191) both contain active configuration data, hardware could possibly
read a entry composed of half-old and half-new data.

The VT-d spec defines software guide for pasid table entry manipulation
in section 6.5.3.3 (Guidance to Software for Invalidations), I think the
Linux driver doesn't handle the handshake between CPU and IOMMU hardware
in the right way.

The correct way should be a clear-flush-update sequence, that is, when
tearing down a present pasid table entry, the software should

1. Clear the Present bit;
2. Invalidate the cache according to section 6.5.3.3;
[now CPU owns the pasid table entry]
3. Update other fields;
4. Set the Present bit;
[now the VT-d hardware owns the pasid table entry].

> 
> In reality:
>    - iommu driver shouldn't receive an attach request on an in-use pasid
>      entry, so the cache should remain cleared (either at initial state or
>      flushed by previous teardown) then hw won't use a partial 1st-stage
>      config after seeing the entry as non-present.

Yes. But the current tear down process is buggy as described above.

> 
>    - replace is already broken, as the entry should not be cleared in the
>      1st place then this bug will be fixed when replace is reworked.

We still have a long way to go before achieving the real replace since
the hardware doesn't guarantee 512-bit atomicity, "hitless" is very
difficult.

> 
> If no oversight (Baolu?), probably we don't need to fix it strictly following
> Jason's pseudo logic at this point. Instead, just rename pasid_clear_entry()
> to pasid_clear_entry_no_flush() for now (with some comment to clarify
> the expectation), and rework the replace path in parallel.
> We may never require a pasid_clear_entry_flush_cache() once hitless> replace is in place. 😊

Perhaps we can first add pasid_entry_clear_present() to fulfill the
clear-flush-update handshake between the software and the IOMMU hardware
while reworking the PASID replace path?

Thanks,
baolu
