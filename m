Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3B03E95A4
	for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 11:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776944094; cv=none; b=DuFsDOqxYoIdtNfs5LOLMFREMKKBfHEPF0+4X26as1cUS5dTxoGJ8chjxTsu2j0qUAnPubrCjtJTA0T1kxQ8n3BooVU8d09ubXxky94Po50VVwP7B17j+3xPRBC3KibOnMy33lv1M2IsQgrQRKSUyva75YFr0KrXVDaVU7LiG+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776944094; c=relaxed/simple;
	bh=5AOp3aZ4V6oSSyVRYWRVHttuXACP2bAiEzdTGCMs/IA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=upbxFpcZgdjq0mpmBonVl9zmc747BofId6TkDgx13xwqkPzl+liU1gkHzOlyneeHnTNxgdEhRTeotb/GUzTDoTY0WcIJL4q1uctXcyxORCTlOLNfCjNEPoSRw6iUe9YzWpUnVUcltAe/DeqktaKP0iIF1nFwtPxpLVcgu9S8RMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qhsV5f6N; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qhsV5f6N"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C0251C25;
	Thu, 23 Apr 2026 04:34:43 -0700 (PDT)
Received: from [10.57.22.141] (unknown [10.57.22.141])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 339AB3F23F;
	Thu, 23 Apr 2026 04:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776944088; bh=5AOp3aZ4V6oSSyVRYWRVHttuXACP2bAiEzdTGCMs/IA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qhsV5f6N/zRDP6KLKoajiAWPCcpVlMWem4t4ROAenu9G+mRWv1eNH0clKp2hDS9Yb
	 rbClnksRUtcMM8ZpGMXZ/z7PXXU51ApSbX7GJAl3rAZayDdc1Tg5ObV0nkvexKnIV3
	 qGquutoFcp8ujr+hHv60zmtaVegK9Ld0YHt/JQAs=
Message-ID: <31d762d0-9b5d-4199-a30d-8b67d246dab0@arm.com>
Date: Thu, 23 Apr 2026 12:34:39 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable 6.12 0/2] iommu/vt-d+dma: fix stale DMA PTE WARN on
 IOVA reuse (regression v6.12.75)
To: avinash pal <avinashpal441@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260423100904.5966-1-avinashpal441@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260423100904.5966-1-avinashpal441@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-04-23 11:09 am, avinash pal wrote:
> Two-patch series addressing the stale-DMA-PTE WARN_ON regression that
> hits kernels 6.12.75 and 6.12.76 when Intel IOMMU is enabled.
> 
>    Bugzilla : https://bugzilla.kernel.org/show_bug.cgi?id=221389

That appears to be some tracing tool bug?

>    Unaffected: v6.12.74   (confirmed: Giovanni Pancotti, 2026-04-22)
>    Affected  : v6.12.76   (WARN on ATA/SCSI DMA workloads)
>    Workaround: intel_iommu=off
> 
> Root cause
> ==========
> The lazy-flush path in __iommu_dma_unmap_sg() releases an IOVA back to
> the allocator via free_iova_fast() before iommu_iotlb_sync() drains the
> hardware TLB.  A concurrent map() on the same domain receives the same
> IOVA and hits a live PTE in __domain_mapping():

And sorry, but all of this is such complete and utter nonsense that I 
can only assume it's AI slop, as I can't imagine any motivated human 
developer investing the effort to be so wrong in such an intricate level 
of detail.

If the pagetables have got out of sync with the IOVA state because some 
DMA API caller passed the wrong address/size to dma_unmap_*, that's a 
bug in whatever drivers/subsystem is making the DMA API calls - try 
throwing CONFIG_DMA_API_DEBUG at it.

>    CPU 0 (unmap, lazy path)        CPU 1 (concurrent map)
>    ──────────────────────────      ───────────────────────────────
>    iommu_unmap(iova)
>    free_iova_fast(iova)  ← live
>                                    alloc_iova_fast() → same iova
>                                    __domain_mapping()
>                                      dma_pte_present() == true
>                                      WARN_ON_ONCE()          ← hit
> 
> Patches
> =======
> 1/2  iommu/vt-d: fail map loudly on stale DMA PTE
>       - Replaces bare WARN(1,...) with pr_err_ratelimited + WARN_ON_ONCE
>       - Prints vPFN + old PTE value for debugging
>       - Returns -EEXIST; no silent double-map
> 
> 2/2  iommu/dma: sync IOTLB before releasing IOVA on sg unmap
>       - Adds iommu_iotlb_sync() before free_iova_fast() on lazy path
>       - Closes the race window; strict-mode path already does this
> 
> ACTION NEEDED by reviewer: run
>    git log v6.12.74..v6.12.76 -- drivers/iommu/dma-iommu.c
> to identify the offending commit for the Fixes: tag in patch 2/2.

No, that's not how upstream review works. However, since I can guess the 
outcome already:

~/src/linux$ git log v6.12.74..v6.12.76 -- drivers/iommu/dma-iommu.c
~/src/linux$

Oh dear, there were no changes at all!? But... that could only mean that 
the nonsensical hypothesis dreamed up by overpowered autocomplete was in 
fact not true. How could this be!?

Thanks,
Robin.

> 
> avinash pal (2):
>    iommu/vt-d: fail map loudly on stale DMA PTE
>    iommu/dma: sync IOTLB before releasing IOVA on sg unmap
> 
>   drivers/iommu/dma-iommu.c   |  9 +++++++
>   drivers/iommu/intel/iommu.c | 50 ++++++++++++++++++++++++++++---------
>   2 files changed, 47 insertions(+), 12 deletions(-)
> 
> 
> base-commit: 444b39ef6108313e8452010b22aaba588e8fb92b

