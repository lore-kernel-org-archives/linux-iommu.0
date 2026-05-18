Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0664508F4;
	Mon, 18 May 2026 12:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779108815; cv=none; b=Ixy+q7n2Uj5kGw6T1Jb7Sr9THtBXLWw0XFOrGntICnQ3Dby4XzYLhxwMc33dEzxBKfM4Wkb3hhxD/ECARkF4sc/nQErgvRyOLMupGuFpTCe8uVgZ0y4H/MiU2A1UjYU6eUgdGiIiLoyJDgx9bzJCBgqk5GzdG3UCiykRB4mbhFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779108815; c=relaxed/simple;
	bh=y21Wwsdb9da3Is6q2ePZWfh4VYNlIMx4FrnnNvuO6VQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jehWBwRsHd3dN7jSPJzAlYxSU4vxvk5MS9rwUKOFBVE/+hpEIxXV2lkPvYDMzBxuQeZfjRwEphed3cV+GMIWa7zVcKlM+vwR0CX+CI/z3VD5q3Oma/WIlXH2zX/817yc8RNIxTvIdJkmcnuy/ctVSx9DKEqsQdxjDmxK4IfggR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=La1zhCZL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="La1zhCZL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED436C4AF0B;
	Mon, 18 May 2026 12:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779108815;
	bh=y21Wwsdb9da3Is6q2ePZWfh4VYNlIMx4FrnnNvuO6VQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=La1zhCZL+/kF3BC6iaS6Jb9IpMWSJbkVVf0uQjbYpUzpPlKmNCV54uVMexNeY8Sug
	 CvaJhfg11aiCDsftdntdS50RKx+t1H31BvdMAuywH4F0bgHbRCXZwpOgcwLKjTSK/8
	 Qs21lmUpP0jcyE0o4Pl5IMWKXqzWQe4JSHsw8iZqPxNWomKQra1VbZp7HLv8vwoI/p
	 uDeMgwsC6w1+3UXPfEBFcnKY33c+vvB9H6FnpMqjsiNg3u+V2HBEIXTkcwbsHX+tzj
	 o0/000h8b6KGHTUgqTlfTpi+FlgzPCkEvbUpypmWO2QMNcq5Dw4E7eMNtYwE9peANP
	 +4N2W5nanzo2A==
Date: Mon, 18 May 2026 15:53:30 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: m.szyprowski@samsung.com, hch@lst.de, robin.murphy@arm.com,
	djbw@kernel.org, akpm@linux-foundation.org, catalin.marinas@arm.com,
	harry@kernel.org, ming.lei@redhat.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-debug: skip cacheline overlap tracking on
 cache-coherent architectures
Message-ID: <20260518125330.GT33515@unreal>
References: <20260518113251.64844-1-mikhail.v.gavrilov@gmail.com>
 <20260518121047.GR33515@unreal>
 <CABXGCsMxZ7VieyzWEmpGdxohdbTJ_qf_1ZOw0eF5g9i0YeOc3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABXGCsMxZ7VieyzWEmpGdxohdbTJ_qf_1ZOw0eF5g9i0YeOc3w@mail.gmail.com>

On Mon, May 18, 2026 at 05:23:15PM +0500, Mikhail Gavrilov wrote:
> On Mon, May 18, 2026 at 5:10 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > I would say this reproducer is incorrect. From what I recall, the only two
> > legitimate use cases for cacheline overlap are virtio and RDMA.
> 
> The wild trace in the commit message is NVMe block I/O -- neither virtio
> nor RDMA:
> 
>   add_dma_entry -> debug_dma_map_phys -> dma_map_phys ->
>   blk_dma_map_iter_start -> nvme_map_data
> 
> The block layer submits many concurrent in-flight requests; small
> kmalloc'd buffers naturally land in the same cacheline under high IOPS,
> which is incidental rather than intentional overlap.  Ming Lei's report
> linked in the commit message [1] enumerates additional non-virtio /
> non-RDMA cases hitting the same WARN: liburing iopoll tests, raid1,
> dm-thin and other storage utilities.

Actually, later in that thread, people agreed that this debug message
correctly pointed out the underlying issue in the code.
https://lore.kernel.org/all/20241015075418.GA25487@lst.de/

> 
> > The first intentionally relies on it for small allocations, and the second exports the
> > cachelines to the user space and cannot operate on non‑coherent architectures.
> 
> The reproducer isn't claiming to be either of those.  It deterministically
> reaches the same state-based gate the wild NVMe trace hits
> (!is_cache_clean && overlap > 7, with direction != DMA_TO_DEVICE, after
> the v2 coherent-arch / SWIOTLB-bounce suppressions are evaluated).  Since
> that gate has no subsystem-specific term, any caller -- synthetic or real
> -- reaching it with those state values triggers the same WARN.
> 
> If the broader concern is that the block layer should opt into your
> coherency-attribute work rather than relying on debug-side suppression,
> that's a reasonable longer-term direction.  But it's additive: even with
> opt-in adoption, the WARN remains a false positive on coherent arches
> for callers that don't annotate -- which is exactly what v2 (3d48c9fd78dd)
> already established for the sibling "cacheline tracking EEXIST" err_printk.

How difficult is it to annotate call sites?

Thanks

> 
> [1] https://lore.kernel.org/all/ZwxzdWmYcBK27mUs@fedora/
> 
> -- 
> Thanks,
> Mikhail
> 
