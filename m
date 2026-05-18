Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DE43FD151;
	Mon, 18 May 2026 12:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779106251; cv=none; b=tKxUW9E+r0OeZsw8PaBHVCItJmeROwrTh9d4POdy/gIhqFdrAvxlGQqD2NL1cGmG9NZKgu89IGWKwzaV59NCOzVgbtEjsGS/lxCYgNA7pcey3iEfjtkJOwKSnkl2vQBxr6/dCZic0KjVgFoyp//AeijboaV/TSVpU8W7YgwwWrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779106251; c=relaxed/simple;
	bh=xSQXkBeqQfuzt3MyNGcM+hictfIQ4ayJ2n6L7E4bSyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=deapLtpQTmxCGAbxKAQVIi1E+P1+Axkb9ac7wgPtIAuaOaDzm/zoaGPswVE857Khe6VeG2mByXk2XLw+CfHGsb96ikl22pPzoogJCvwEb9lToxGLq6rZ5YDDNPj4RaaPRaXZ9Mne5uA52hjTW5HQEPFKNKgKoFAZ5rngcbH3AoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qT112l9o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qT112l9o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B2FC2BCC6;
	Mon, 18 May 2026 12:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779106251;
	bh=xSQXkBeqQfuzt3MyNGcM+hictfIQ4ayJ2n6L7E4bSyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qT112l9oe/+26yri6aANqUV2z6xKRPiTwrm3KzZiw5GlOz7Q779+/Vmc7YIIdVWTI
	 4dJ5zudXEIPbMaHztLkdMvAKk/wduoycJsbTsKz7zi2oHuDVr1ldirhx/PDG7hNrkd
	 oXdZk98df+xh4t+9uJD+qadMq9a6vbd6eZMna0G+6fZtVWSNlL5+7jAkN2lkZGoytt
	 AyHVtrcQiOHTqz53MQgqnetgw401BSSwxhjrcjOt4AFV6KLLCdifaqXPtFpHubXs6l
	 eTzBXgiDfgoL9sleAcbWY0hhBoPqzFf5Plq0DkYybpJLGdxTJ95a9OlzQv8Vv6t6hr
	 h60Y/Mjbhx1iA==
Date: Mon, 18 May 2026 15:10:47 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: m.szyprowski@samsung.com, hch@lst.de, robin.murphy@arm.com,
	djbw@kernel.org, akpm@linux-foundation.org, catalin.marinas@arm.com,
	harry@kernel.org, ming.lei@redhat.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-debug: skip cacheline overlap tracking on
 cache-coherent architectures
Message-ID: <20260518121047.GR33515@unreal>
References: <20260518113251.64844-1-mikhail.v.gavrilov@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260518113251.64844-1-mikhail.v.gavrilov@gmail.com>

On Mon, May 18, 2026 at 04:32:51PM +0500, Mikhail Gavrilov wrote:
> The dma-debug cacheline overlap tracking emits two distinct warnings
> when multiple DMA mappings share a cacheline:
> 
>   1. add_dma_entry() calls err_printk("cacheline tracking EEXIST,
>      overlapping mappings aren't supported\n") on every -EEXIST from
>      active_cacheline_insert().
> 
>   2. active_cacheline_inc_overlap() calls WARN_ONCE("exceeded %d
>      overlapping mappings of cacheline %pa\n", ...) when the 3-bit
>      per-cacheline overlap counter in the dma_active_cacheline radix
>      tree would saturate past ACTIVE_CACHELINE_MAX_OVERLAP (= 7).
> 
> Commit 3d48c9fd78dd ("dma-debug: suppress cacheline overlap warning
> when arch has no DMA alignment requirement") suppressed (1) on
> architectures where hardware bus snooping makes cacheline-overlapping
> DMA mappings safe.  The same reasoning applies to (2): the tracking is
> pure overhead on those architectures, and (2) still fires under real
> workloads, e.g. heavy NVMe block I/O on x86_64:
> 
>   DMA-API: exceeded 7 overlapping mappings of cacheline 0x...
>   WARNING: kernel/dma/debug.c:465 at add_dma_entry+0x394/0x410
>   Call Trace:
>    add_dma_entry+...
>    debug_dma_map_phys+...
>    dma_map_phys+...
>    blk_dma_map_iter_start+...
>    nvme_map_data+...
> 
> The block layer routinely produces nine or more concurrent in-flight
> mappings whose buffers share a single cacheline.  On hardware-coherent
> systems this is harmless, but it saturates the tag-based overlap
> counter and produces a splat indistinguishable from a real driver bug.
> 
> Extend the gate to skip the cacheline overlap tracking entirely on
> cache-coherent architectures, mirroring the DMA_TO_DEVICE early-return
> that already exists for the same "tracking is unnecessary" reason.  The
> helper dma_debug_cacheline_tracking_needed() captures the condition and
> is symmetric to the existing add_dma_entry() check.
> 
> The same DMA_BOUNCE_UNALIGNED_KMALLOC + SWIOTLB suppression that
> commit 03521c892bb8 ("dma-debug: don't report false positives with
> DMA_BOUNCE_UNALIGNED_KMALLOC") added to (1) applies here for the same
> reason: unaligned kmalloc buffers are bounced through aligned swiotlb
> buffers, so the original cacheline overlap never reaches DMA.  The
> helper preserves both suppression conditions.
> 
> Reproducer (out-of-tree module): map a single 8-byte buffer with
> dma_map_single(..., DMA_BIDIRECTIONAL) nine times in a row.  The 9th
> call deterministically fires the WARN_ONCE on an unfixed kernel; with
> this patch applied no warning is emitted regardless of the number of
> overlapping mappings.

I would say this reproducer is incorrect. From what I recall, the only two
legitimate use cases for cacheline overlap are virtio and RDMA. The first
intentionally relies on it for small allocations, and the second exports the
cachelines to the user space and cannot operate on non‑coherent architectures.

Thanks
