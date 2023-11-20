Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389D41878
	for <iommu@lists.linux.dev>; Mon, 20 Nov 2023 02:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TxPvC/9J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700449042; x=1731985042;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=sT/vTgYcrOwvk1VNI9b9F4OYgRzQaXbiy9iT8gGQsLs=;
  b=TxPvC/9JvvXgxw0l5GQ6vFVYdJ4TRxnpOMvYUIuJAnI+KF9gzVjvP3aI
   +EEiGheOPJTJhbr2RfZeHBqYSQn5KwahRUfR08E4cC4oro6Ahf5tiZ4AV
   vX3chb7QgcANfC6JNTRvWztKGEWH3NibUKtwM63HbtzYRdMIWwzh3QHZr
   pzG48gtCBZDWQi+fWoqa53mf5Cr14e+pXMdzbZVGNPECDRwS2TnJpVC/v
   tsRdu9axmJsXuD8JMJPMHqe+Z9LUrFa36iqrLsg2ORKMxGzxe4Y/GvDiW
   YW3lA7/gFXwzj/j95KWm9gooMTWv+SrGrkrGjtAi24hB3nyEFDISghqqy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="477750088"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="477750088"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 18:57:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="742597924"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="742597924"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 18:57:17 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Alistair Popple <apopple@nvidia.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,  Joerg Roedel <joro@8bytes.org>,
  Will Deacon <will@kernel.org>,  "Robin Murphy" <robin.murphy@arm.com>,
  Jason Gunthorpe <jgg@ziepe.ca>,  Kevin Tian <kevin.tian@intel.com>,
  <iommu@lists.linux.dev>,  <linux-kernel@vger.kernel.org>,
  <stable@vger.kernel.org>,  Luo Yuzhang <yuzhang.luo@intel.com>,  Tony Zhu
 <tony.zhu@intel.com>, Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix incorrect cache invalidation for mm
 notification
In-Reply-To: <87edgll1up.fsf@nvdebian.thelocal> (Alistair Popple's message of
	"Mon, 20 Nov 2023 10:57:43 +1100")
References: <20231117090933.75267-1-baolu.lu@linux.intel.com>
	<87edgll1up.fsf@nvdebian.thelocal>
Date: Mon, 20 Nov 2023 10:55:15 +0800
Message-ID: <877cmdcewc.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Alistair Popple <apopple@nvidia.com> writes:

> Lu Baolu <baolu.lu@linux.intel.com> writes:
>
>> Commit 6bbd42e2df8f ("mmu_notifiers: call invalidate_range() when
>> invalidating TLBs") moved the secondary TLB invalidations into the TLB
>> invalidation functions to ensure that all secondary TLB invalidations
>> happen at the same time as the CPU invalidation and added a flush-all
>> type of secondary TLB invalidation for the batched mode, where a range
>> of [0, -1UL) is used to indicates that the range extends to the end of
>> the address space.
>>
>> However, using an end address of -1UL caused an overflow in the Intel
>> IOMMU driver, where the end address was rounded up to the next page.
>> As a result, both the IOTLB and device ATC were not invalidated correctly.
>
> Thanks for catching. This fix looks good so:
>
> Reviewed-by: Alistair Popple <apopple@nvidia.com>
>
> However examining the fixes patch again I note that we are calling
> mmu_notifier_invalidate_range(mm, 0, -1UL) from
> arch_tlbbatch_add_pending() in arch/x86/include/asm/tlbflush.h.
>
> That seems suboptimal because we would be doing an invalidate all for
> every page unmap,

Yes.  This can be performance regression for IOMMU TLB flushing.  For
CPU, it's "flush smaller ranges with more IPI" vs. "flush whole range
with less IPI", and in general the later wins because the high overhead
of IPI.  But, IIUC, for IOMMU TLB, it becomes "flush smaller ranges"
vs. "flush whole range".  That is generally bad.  It may be better to
restore the original behavior.  Can we just pass the size of TLB
flushing in set_tlb_ubc_flush_pending()->arch_tlbbatch_add_pending(),
and flush the IOMMU TLB for the range?

> and as of db6c1f6f236d ("mm/tlbbatch: introduce
> arch_flush_tlb_batched_pending()") arch_flush_tlb_batched_pending()
> calls flush_tlb_mm() anyway. So I think we can probably drop the
> explicit notifier call from arch_flush_tlb_batched_pending().

arch_flush_tlb_batched_pending() is used when we need to change page
table (e.g., munmap()) in parallel with TLB flushing batching (e.g.,
try_to_unmap()).  The actual TLB flushing part for
set_tlb_ubc_flush_pending()->arch_tlbbatch_add_pending() is
try_to_unmap_flush()->arch_tlbbatch_flush().

> Will put togeather a patch for that.
>
>  - Alistair
>
>> Add a flush all helper function and call it when the invalidation range
>> is from 0 to -1UL, ensuring that the entire caches are invalidated
>> correctly.
>>

[snip]

--
Best Regards,
Huang, Ying
