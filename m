Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8EC4369A
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 05:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780292824; cv=none; b=gxny/j/jfGYRIj6pAYbdYdTox9rOwdn6fkFIqi//7iT2uhIqdljA06CI6hMnyHXYJFaS7Nr+jJQT9tG5Th7DuUwNXabMm7Isuxn6Wv4kMVaJimrl37OIUA5hAg4DYF1EzkTvQHk1s7bA9htw/EKbizWI4xydVmtaoxuLIs3yrt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780292824; c=relaxed/simple;
	bh=Z5R1xGmokUBdnq6ygG70pKfSM0qXM+I+wqu1K0VRv+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UswpdKda0yJcL5a7njXEmLHdNHUoO6aqTNrFUuKezDqoFJywc9y3AAbQ0S1km3QIrbKAzA2fplUDiQoqAkmZNvMVMQEmOVADs9H7MrG9kl26u5wR53aDCGNP5s7eUNabrlNjDTOJL0eayGI9h+SqzSVC1M/1v4E3GTCmLcZNKpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EyyjxPQu; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EyyjxPQu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780292821; x=1811828821;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Z5R1xGmokUBdnq6ygG70pKfSM0qXM+I+wqu1K0VRv+0=;
  b=EyyjxPQuA6cKbezT7uzVwUBtAb+damxynlDdhwdrxw0cYfZ5L7UvpeNo
   O6tlWIBRPdFnp/Kmsn8z7bYqYLSf/B9Kn5tFqJIRcV8EThCYXat9MxIsd
   GXaUn4oLI3VYDb0pW8s7W7FDi96g16OhErqlcjn77hVE5R9sIIAvVQ6Uw
   CHM9WS2np+YDWuuVPfedK+M8W6Dd+ZH7moLXvEqv5aqgfVknIkjnrYRr3
   0X8AM44Kj4srEIi+GNl2QPzARHC/YY2eNWZLL89Wws9WWFJRZEJ8LvdZw
   KrN/0ogtLcOhtvcIrGNu7tzu9p4gDwBmP6Is9Zvf72+CG3TRdSevprloq
   g==;
X-CSE-ConnectionGUID: uRb4rgu9TDuT5rlMp+ympw==
X-CSE-MsgGUID: pn/teT3HQgORNqoKKyOfhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="84902910"
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="84902910"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 22:47:01 -0700
X-CSE-ConnectionGUID: sFzJLnMvQ/CN/BYogl2GrQ==
X-CSE-MsgGUID: 3dvkfYytQYWMOisCEcbdhQ==
X-ExtLoop1: 1
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 22:46:59 -0700
Message-ID: <fd3f4dc1-a3f7-4b0b-9624-78dec1dc8392@linux.intel.com>
Date: Mon, 1 Jun 2026 13:46:08 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: Clear Present bit before tearing down
 scalable-mode context entry
To: Michael Bommarito <michael.bommarito@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260528025557.3209367-1-michael.bommarito@gmail.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260528025557.3209367-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/28/26 10:55, Michael Bommarito wrote:
> device_pasid_table_teardown() zeroes the 128-bit scalable-mode context
> entry with context_clear_entry() while the Present bit is still set. This
> creates a window where the hardware can fetch a torn entry, with some
> fields already zeroed while Present is still set, leading to unpredictable
> behavior or spurious faults. The context-cache invalidation is issued only
> after the entry has been zeroed, and intel_pasid_free_table() then frees
> the PASID directory pages, so the IOMMU can keep walking a stale Present=1
> entry that points at freed memory.
> 
> While x86 provides strong write ordering, the compiler may reorder the two
> 64-bit writes to the entry, and the hardware fetch is not guaranteed to be
> atomic with respect to multiple CPU writes.
> 
> Commit c1e4f1dccbe9d ("iommu/vt-d: Clear Present bit before tearing down
> context entry") fixed this exact pattern in domain_context_clear_one() and
> the copied-context path, but device_pasid_table_teardown() was not
> converted.
> 
> Align it with the "Guidance to Software for Invalidations" in the VT-d
> spec, Section 6.5.3.3, using the same ownership handshake as the sibling
> fix: clear only the Present bit, flush it to the IOMMU, perform the
> context-cache invalidation, and only then zero the rest of the entry.
> 
> Fixes: 81e921fd32161 ("iommu/vt-d: Fix NULL domain on device release")
> Signed-off-by: Michael Bommarito<michael.bommarito@gmail.com>
> Assisted-by:Claude:claude-opus-4-7
> ---
> Found by static analysis while auditing the callers of context_clear_entry()
> for the same teardown ordering that c1e4f1dccbe9d addressed. This site is
> reachable only in scalable mode, so it does not manifest on the legacy-mode
> hardware available to me; I could not trigger a runtime fault and the change
> is verified by code inspection only, on the same basis as the sibling fix.
> Compile-tested on x86_64 with CONFIG_INTEL_IOMMU; no new warnings.
> 
>   drivers/iommu/intel/pasid.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Sashiko reported a pre-existing issue:

https://sashiko.dev/#/patchset/20260528025557.3209367-1-michael.bommarito%40gmail.com

I have added it to my task list and will follow up with a fix in a
separate patch.

[Severity: Critical]
This is a pre-existing issue, but does this context cache flush actually
invalidate the alias BDF?

It looks like intel_context_flush_no_pasid() issues a device-selective
invalidation that is hardcoded to use the primary device's BDF from info
(PCI_DEVID(info->bus, info->devfn)), completely ignoring the alias's bus
and devfn parameters passed into device_pasid_table_teardown().

If device_pasid_table_teardown() is called for a DMA alias, the IOMMU
context cache for the alias BDF might never be invalidated.

When the domain's page tables or scalable-mode PASID directories are
subsequently freed, could any DMA arriving under the alias BDF cause the
IOMMU hardware to walk the stale cache entry into freed system memory?

Thanks,
baolu
