Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396DB2FF16C;
	Mon, 22 Dec 2025 08:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766393365; cv=none; b=tSJTz3dRrOtb9Kd+Uft3FF/5neLrIfx99U2se1hSb57NCO7p0zbS+UPQf+eH28wgL7bnSU0Jz5XU1V7AXhnz842UDnqGBANrB+Nafq01k5itWUyRu9wBUjUEUq6ms+OXBeFwf8YHVopIi4RGbKaJYoN+Cw+X2zfh/mZemHtUCxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766393365; c=relaxed/simple;
	bh=oWca8sld6uaR00gnqz5NRm6geqCm1R+PSwh673eaF+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ViOVj+On9R2TGkarCnpNHPV0ehc20vkhTw2iE0eoM3lAO2IXVDbvqFhZh9qa50JX0xS6ktGgSDi8nCagBTkTqbKFPqCUOqGPP/Yyp+mfeel1qR+pnAjfRaXUY4IjyFdLnItmuvbGkOdVYShcL1feRqqpvgyY1Nmvbk9pVDvba84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eebXp7SC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eebXp7SC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C8AC4CEF1;
	Mon, 22 Dec 2025 08:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766393365;
	bh=oWca8sld6uaR00gnqz5NRm6geqCm1R+PSwh673eaF+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eebXp7SCur2PVnqDo7vLANpRKY+zTW6tc/OHAoL0XAgL5cTLODN2c/6tItcWna9s4
	 98TAewGbtPY/uRxAta8TwhLJ3Xppunxdn3QKeqK8HoUZiFQezmAuGFNOp5S+XynC16
	 eanK2PxZe8tD78F5Eti1ttx4nimf4/mL84+8z0R7p/N8D9WQzu3ZPyoB2IGmXcSL2w
	 wP/0ucfmYDQU1D36uYCFJ1cA9ztygMOz59U2DvLysafGLDYDJTj02riBX517iyp7nZ
	 PduYm7iLWqmmrb5uPmVcN1V3iD1WJ8m7GaSog8lduZckQHyR3qEfJaIFxswHwq5r0e
	 OEKJuMo1iuauA==
Date: Mon, 22 Dec 2025 10:49:21 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Barry Song <21cnbao@gmail.com>
Cc: ada.coupriediaz@arm.com, anshuman.khandual@arm.com, ardb@kernel.org,
	catalin.marinas@arm.com, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	m.szyprowski@samsung.com, maz@kernel.org, robin.murphy@arm.com,
	ryan.roberts@arm.com, surenb@google.com, v-songbaohua@oppo.com,
	will@kernel.org, zhengtangquan@oppo.com
Subject: Re: [PATCH 5/6] dma-mapping: Allow batched DMA sync operations if
 supported by the arch
Message-ID: <20251222084921.GA13529@unreal>
References: <20251221115523.GI13030@unreal>
 <20251221192458.1320-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251221192458.1320-1-21cnbao@gmail.com>

On Mon, Dec 22, 2025 at 03:24:58AM +0800, Barry Song wrote:
> On Sun, Dec 21, 2025 at 7:55 PM Leon Romanovsky <leon@kernel.org> wrote:
> [...]
> > > +
> >
> > I'm wondering why you don't implement this batch‑sync support inside the
> > arch_sync_dma_*() functions. Doing so would minimize changes to the generic
> > kernel/dma/* code and reduce the amount of #ifdef‑based spaghetti.
> >
> 
> There are two cases: mapping an sg list and mapping a single
> buffer. The former can be batched with
> arch_sync_dma_*_batch_add() and flushed via
> arch_sync_dma_batch_flush(), while the latter requires all work to
> be done inside arch_sync_dma_*(). Therefore,
> arch_sync_dma_*() cannot always batch and flush.

Probably in all cases you can call the _batch_ variant, followed by _flush_,  
even when handling a single page. This keeps the code consistent across all  
paths. On platforms that do not support _batch_, the _flush_ operation will be  
a NOP anyway.

I would also rename arch_sync_dma_batch_flush() to arch_sync_dma_flush().

You can also minimize changes in dma_direct_map_phys() too, by extending
it's signature to provide if flush is needed or not.

dma_direct_map_phys(....) -> dma_direct_map_phys(...., bool flush):

static inline dma_addr_t dma_direct_map_phys(...., bool flush)
{
	....

	if (dma_addr != DMA_MAPPING_ERROR && !dev_is_dma_coherent(dev) &&
	    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO)))
        {
	    	arch_sync_dma_for_device(phys, size, dir);
		if (flush)
			arch_sync_dma_flush();
	}
}

Thanks
