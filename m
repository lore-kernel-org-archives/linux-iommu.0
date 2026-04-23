Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F54E37DE80;
	Thu, 23 Apr 2026 11:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776942615; cv=none; b=hyNyruZ18WIy8k5ADMr8Gm4mcwDa/bTQdgIujRKuAYlATE3t7SHhm/ox+q1zwojkghgVBgljlpvGjMLMfcyRWWbhTdWZ+qYlALrhKh9VwCCqrrQlwcM6NRbey5VpO/IxIFqsx+Gx+PUrrzoIhJU6UUDcIZ71Y/oiLvzebxpFyck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776942615; c=relaxed/simple;
	bh=O4/ish6+FBd5fdl85dueKnWZBgyFuHDLNZl0cPlNsDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mEuFYWhe9Kv/zxUB0R+BLv/PaW48c/acqqM0wzQ7/ffZr6i08KF45ULk1A0Qin0AHbg+9sIsoetD7dX0Mxw04R6lwzG0fD+6q4K4jzMaLP9u4R9mv+uBoTdt+wUNIBdQ7/vtBU/jIdXE5kxKJtBo5UBpn4xHmfyY6Ui9AiEvx2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s6fkDAgN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s6fkDAgN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D91EC2BCB2;
	Thu, 23 Apr 2026 11:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776942614;
	bh=O4/ish6+FBd5fdl85dueKnWZBgyFuHDLNZl0cPlNsDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s6fkDAgNqnIPMPzIVkJA88zwRPaQAmPexq5klUAdMfIlBMkOHQPCoduLwAIvP9B6L
	 F2QkWwHK4532RmdD7vQmqxJGy40ZFaxpECeayu2cNodCPwMnRpJcUKI4hLWreJRoq7
	 U0tSMjeEtzjICcbROw1BU5bWWaHMuTXBxpu/91+M=
Date: Thu, 23 Apr 2026 13:10:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: avinash pal <avinashpal441@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH stable 6.12 0/2] iommu/vt-d+dma: fix stale DMA PTE WARN
 on IOVA reuse (regression v6.12.75)
Message-ID: <2026042303-untreated-lubricate-646b@gregkh>
References: <20260423100904.5966-1-avinashpal441@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260423100904.5966-1-avinashpal441@gmail.com>

On Thu, Apr 23, 2026 at 03:39:02PM +0530, avinash pal wrote:
> Two-patch series addressing the stale-DMA-PTE WARN_ON regression that
> hits kernels 6.12.75 and 6.12.76 when Intel IOMMU is enabled.
> 
>   Bugzilla : https://bugzilla.kernel.org/show_bug.cgi?id=221389
>   Unaffected: v6.12.74   (confirmed: Giovanni Pancotti, 2026-04-22)
>   Affected  : v6.12.76   (WARN on ATA/SCSI DMA workloads)
>   Workaround: intel_iommu=off
> 
> Root cause
> ==========
> The lazy-flush path in __iommu_dma_unmap_sg() releases an IOVA back to
> the allocator via free_iova_fast() before iommu_iotlb_sync() drains the
> hardware TLB.  A concurrent map() on the same domain receives the same
> IOVA and hits a live PTE in __domain_mapping():
> 
>   CPU 0 (unmap, lazy path)        CPU 1 (concurrent map)
>   ──────────────────────────      ───────────────────────────────
>   iommu_unmap(iova)
>   free_iova_fast(iova)  ← live
>                                   alloc_iova_fast() → same iova
>                                   __domain_mapping()
>                                     dma_pte_present() == true
>                                     WARN_ON_ONCE()          ← hit
> 
> Patches
> =======
> 1/2  iommu/vt-d: fail map loudly on stale DMA PTE
>      - Replaces bare WARN(1,...) with pr_err_ratelimited + WARN_ON_ONCE
>      - Prints vPFN + old PTE value for debugging
>      - Returns -EEXIST; no silent double-map
> 
> 2/2  iommu/dma: sync IOTLB before releasing IOVA on sg unmap
>      - Adds iommu_iotlb_sync() before free_iova_fast() on lazy path
>      - Closes the race window; strict-mode path already does this
> 
> ACTION NEEDED by reviewer: run
>   git log v6.12.74..v6.12.76 -- drivers/iommu/dma-iommu.c
> to identify the offending commit for the Fixes: tag in patch 2/2.
> 
> avinash pal (2):
>   iommu/vt-d: fail map loudly on stale DMA PTE
>   iommu/dma: sync IOTLB before releasing IOVA on sg unmap
> 
>  drivers/iommu/dma-iommu.c   |  9 +++++++
>  drivers/iommu/intel/iommu.c | 50 ++++++++++++++++++++++++++++---------
>  2 files changed, 47 insertions(+), 12 deletions(-)
> 
> 
> base-commit: 444b39ef6108313e8452010b22aaba588e8fb92b
> -- 
> 2.53.0
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
