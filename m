Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7E2423149;
	Tue,  3 Mar 2026 13:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772542968; cv=none; b=BxRExdYuCoPRDO+NtKsatruohykPgTMeyKr08b5I4d/e/iOgic/GgL4TZAIlC7ragC6jCcAKlkodQctR9fhvJZ2aHYOUHWBazI91BPEz5XrrLzzSB9tcJbl9Kk6hza/Uz+ZfXRAcrQqLeoYJaVWD354bYImChcsYEYUf3f2n9Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772542968; c=relaxed/simple;
	bh=nbMLQsjDZkCUDwUT+GwGHmBHBs1qTAJm1jRsNfWwmoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvhqCkujohAr+zIYEbnXCdTbO6AGUkQpKayDAdycTSyDWeFtA6KpDc+qVQB2/+PUZM3SHQGpqtoBRUTa/ZU2fxrTCplJt63C2zum0nn97JCMcK3nUoMuep+An50ULW0VaDyVBYhaXL1LAxKEGlBfN8AgjOAh+LLHNhJiIC93CVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=NsjNPIOk; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="NsjNPIOk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JjP44SBlkIUEEU7UZs1N7B9Mcuoc4Tdde0t8mN1Kmx8=; b=NsjNPIOkDmPH5OoXUbe5VuwOSP
	Y1OBjUQ5SXr9ZBK/1gU7+YSKJV5oLafmmGoZjJvAuOM1gwkLbX2EtC+rnDqKYAu+iQZ+0PFoIPIHt
	jFxa5fcDIsbdy2ujO7zJGeHzcEoAozoPllWmBhA8tuM5XIaOXhNAtIDfEi+BO44jc8+KaAxs3wegV
	EoAt4dY1EzLs1+C15nDxWSSMBlqxEiG5QnYSEbVz2iJS7HWnEm5SUOZYVyrCeCbGZujv2Upuwld1X
	DqHhT5NnJSpJ2XuBoEkhK44koPuAZhdD7mDoIq+zS8+csFbo/r2XM6VHqtrsx7wmoAqsW/F4X6XMY
	40iRT4LA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vxPOU-00FCOc-1h; Tue, 03 Mar 2026 13:02:34 +0000
Date: Tue, 3 Mar 2026 05:02:29 -0800
From: Breno Leitao <leitao@debian.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	ttoukan.linux@gmail.com, netdev@vger.kernel.org, kbusch@kernel.org, 
	Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH] iommu/dma: Rate-limit WARN in iommu_dma_unmap_phys()
Message-ID: <aabbv39ZqJud9m1g@gmail.com>
References: <20260211-dma_io_mmu-v1-1-cf89e24437af@debian.org>
 <20260213112355.GP12887@unreal>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213112355.GP12887@unreal>
X-Debian-User: leitao

hello Leon,

On Fri, Feb 13, 2026 at 01:23:55PM +0200, Leon Romanovsky wrote:
> On Wed, Feb 11, 2026 at 07:13:03AM -0800, Breno Leitao wrote:
> > When a PCI error (e.g. AER error or DPC containment) marks the PCI
> > channel as frozen or permanently failed, the IOMMU mappings for the
> > device may already be torn down. If a driver continues processing
> > completions in this state, every call to dma_unmap_page() triggers a
> > WARN_ON in iommu_dma_unmap_phys().
> > 
> > In a real-world crash scenario on an NVIDIA Grace (ARM64) platform, a
> > DPC event froze the PCI channel and the mlx5 NAPI poll continued
> > processing error CQEs, calling dma_unmap for each pending WQE. With
> > dozens of pending WQEs, the resulting WARN_ON storm monopolized the CPU
> > in softirq context for over 23 seconds, triggering a soft lockup panic.
> > 
> > Replace WARN_ON(!phys) with WARN_RATELIMIT() to cap the warning output
> > at the kernel's default rate limit (10 messages per 5 seconds), while
> > still providing visibility into the failure with the device name in the
> > message.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > Fixes: 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers")
> > ---
> > I initially attempted to fix this in the driver itself, but that approach
> > doesn't appear to be optimal, given the mappings can go away at any
> > time, which is impossible to check at any time. Please see the discussion at:
> > 
> > https://lore.kernel.org/all/20260209-mlx5_iommu-v1-1-b17ae501aeb2@debian.org/
> > ---
> >  drivers/iommu/dma-iommu.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> We have similar failure in our regression and the proposal fix is below,
> can you please try if it fixes your issue too?

This is not a trivial test to run, but, the early tested showed some good
results.

I will report back if I find regressions later,

Thanks for the fix,
--breno
