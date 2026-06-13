Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8957E25487C
	for <iommu@lists.linux.dev>; Sat, 13 Jun 2026 01:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781315529; cv=none; b=KPgQWBfi0gMxke+5ghV3dSHuuuRBRtPncqDyggChlQdoqEfwX8sqc3W9IrlOPklKMMgqkn0e3A4gNNfUR1WkG0ZBZtsi5hp+kN0gTTnllKQkOxQVBedUvtXuqXOaSe4tICpFM06/BCPFp2XAgGqZpm0LHu0q7PqYCIX2fbK8eIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781315529; c=relaxed/simple;
	bh=LH5UCGkTZwk7d4AfxlGMEsn46QiMb+z5xWZRSkNt3LU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YBe0CdgOqRrjHFBgQBmVwzeE/wHKSQJRbt4I5Li50UnI+Y1+mUslvIw5sJJ4JOI2u9Z2NiHctsPXex10slIaSUMUEg9g0JOKOmPoi4ly/XZc1hVbZUvNt4zHHy+HN4aTampVRxtc9logP5dFy04omhvRkAkeET2cEdOnwOTpyKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZY5QSkp8; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZY5QSkp8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781315528; x=1812851528;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LH5UCGkTZwk7d4AfxlGMEsn46QiMb+z5xWZRSkNt3LU=;
  b=ZY5QSkp8E6EIzILsN5G9PSeC4p3NTi9X2POifVt14pJgoZuw0NV8Y33s
   NHHVapOqb7nb7RdWALYf2K9Qpik4npzQ0BiAOW+/TCh9YhUZZEgZySJ/s
   PKjY8NGSvNH23FTras/7oEgSAihMprNCFVSfRgDgoC0Kh9lYZxfjLP5LE
   V3DLgzfcEo0kkgVXwQ5uL+a3/twM1CAbny7xSZruhXk6GSnGW3oAWM0Kd
   7GeXVa8AGm7GoBl0272yoMUESE9W2StonhGx5B8cXwJKx/1AvMFEx55T3
   zVTqxDZV1qXDH0veqCqN7H/PBNDyzSQMnTayEyv00diM/hylVf+dAAZsC
   w==;
X-CSE-ConnectionGUID: 9DSYGfaBQyGr3NAhFZ0pMw==
X-CSE-MsgGUID: FQyowTn9SuuU7YYmk26lYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11815"; a="99571403"
X-IronPort-AV: E=Sophos;i="6.24,201,1774335600"; 
   d="scan'208";a="99571403"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 18:52:07 -0700
X-CSE-ConnectionGUID: R5kgLqjgRrKGpyBcsJp/0w==
X-CSE-MsgGUID: p4uuJ7rTS1qCSiS3nRRq/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,201,1774335600"; 
   d="scan'208";a="246998757"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 18:52:05 -0700
Message-ID: <80702799-cb99-47c0-8d25-8867ab1ea69d@linux.intel.com>
Date: Sat, 13 Jun 2026 09:50:52 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: Clear Present bit before tearing down
 scalable-mode context entry
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260528025557.3209367-1-michael.bommarito@gmail.com>
 <b0278f4d-681c-4731-bc8d-130a56e6d935@linux.intel.com>
 <20260611115257.GD1066031@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260611115257.GD1066031@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/11/26 19:52, Jason Gunthorpe wrote:
> On Mon, Jun 01, 2026 at 01:35:08PM +0800, Baolu Lu wrote:
>> On 5/28/26 10:55, Michael Bommarito wrote:
>>> device_pasid_table_teardown() zeroes the 128-bit scalable-mode context
>>> entry with context_clear_entry() while the Present bit is still set. This
>>> creates a window where the hardware can fetch a torn entry, with some
>>> fields already zeroed while Present is still set, leading to unpredictable
>>> behavior or spurious faults. The context-cache invalidation is issued only
>>> after the entry has been zeroed, and intel_pasid_free_table() then frees
>>> the PASID directory pages, so the IOMMU can keep walking a stale Present=1
>>> entry that points at freed memory.
>>>
>>> While x86 provides strong write ordering, the compiler may reorder the two
>>> 64-bit writes to the entry, and the hardware fetch is not guaranteed to be
>>> atomic with respect to multiple CPU writes.
>>>
>>> Commit c1e4f1dccbe9d ("iommu/vt-d: Clear Present bit before tearing down
>>> context entry") fixed this exact pattern in domain_context_clear_one() and
>>> the copied-context path, but device_pasid_table_teardown() was not
>>> converted.
>>>
>>> Align it with the "Guidance to Software for Invalidations" in the VT-d
>>> spec, Section 6.5.3.3, using the same ownership handshake as the sibling
>>> fix: clear only the Present bit, flush it to the IOMMU, perform the
>>> context-cache invalidation, and only then zero the rest of the entry.
>>>
>>> Fixes: 81e921fd32161 ("iommu/vt-d: Fix NULL domain on device release")
>>> Signed-off-by: Michael Bommarito<michael.bommarito@gmail.com>
>>> Assisted-by:Claude:claude-opus-4-7
>>> ---
>>> Found by static analysis while auditing the callers of context_clear_entry()
>>> for the same teardown ordering that c1e4f1dccbe9d addressed. This site is
>>> reachable only in scalable mode, so it does not manifest on the legacy-mode
>>> hardware available to me; I could not trigger a runtime fault and the change
>>> is verified by code inspection only, on the same basis as the sibling fix.
>>> Compile-tested on x86_64 with CONFIG_INTEL_IOMMU; no new warnings.
>>>
>>>    drivers/iommu/intel/pasid.c | 4 +++-
>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>> Queued for linux-next. Thank you!
> What happened to your work to move over to the ARM updator that
> doesn't have any of these bugs? 🙂

I am working on that series, but since this is a fix that should be
backported, I queued it for this merge cycle.

Thanks,
baolu
