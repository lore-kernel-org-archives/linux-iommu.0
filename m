Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6341F956;
	Sun, 28 Dec 2025 14:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766933354; cv=none; b=SVhRuUS1SLVxpigZHZ67jS9LsH3fsWcWePWrymeX6JYN2zqbXALHVPD/30N3tgDUwPKUVYqsLV6QBJW31a3I0JSkY0AtQII7YvPNoaCN+0fsd/8W+vp3GOMl1fAdvBQ8SMdcXyCOyERMwQsmAqkbFprNvFHmqGThOToggN9Nm0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766933354; c=relaxed/simple;
	bh=KsIQ/N3MhVA4l2rlxf/X6rqlexltaiPqA/C+R9KBRrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8DrP6a5PDihEdYIE9uzsfGrR+wYCXHBh1dOT9PwGpzUIXCNyARcoITSRa108GWYbrN0gRn0Wpk2FlGdlkNY5AUaC2tuiemlhgbRJ2LUV+qV67Ano5mZC8fcBvz2IddpDNNXu89D8QwkcV4e/cXL9FDFOWVPXYPKbkM9lNr9T3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qxr7ascq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxr7ascq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D38BC4CEFB;
	Sun, 28 Dec 2025 14:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766933354;
	bh=KsIQ/N3MhVA4l2rlxf/X6rqlexltaiPqA/C+R9KBRrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qxr7ascqLWsFOwQZLmWr4VaoaU6kLt3JWfsyukATtuABzJxpEZhqUFeO5FQAhs+ir
	 u+cu2HY3hReFb+9sXcFor11aS/eIJMyuJ68Nmt/L+c2T0y3p+0rkU3gMrVEqEGGT26
	 hNG//3ORDr7c1ijghi5Ug5ZvJpG77gZxoqnLrhKcMTDOR0VSqIASJ2vv+Y8cPZIU/R
	 TyyELt1hdTT3RjWVZtdsFz/Yn3kHtB6+BiS+aVF/R8MuwUvFb7nETSS2aMOFPcoJA6
	 bNJ47oEeKqGd4FlgSKH6xIdPpwQG0Fv+x+JMZG7xHiN0aummhOQwA1dvg6SgWN7Jkc
	 XiChRt88500Gg==
Date: Sun, 28 Dec 2025 16:49:09 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Barry Song <21cnbao@gmail.com>
Cc: catalin.marinas@arm.com, m.szyprowski@samsung.com, robin.murphy@arm.com,
	will@kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Joerg Roedel <joro@8bytes.org>, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Tangquan Zheng <zhengtangquan@oppo.com>
Subject: Re: [PATCH v2 4/8] dma-mapping: Separate DMA sync issuing and
 completion waiting
Message-ID: <20251228144909.GR11869@unreal>
References: <20251226225254.46197-1-21cnbao@gmail.com>
 <20251226225254.46197-5-21cnbao@gmail.com>
 <20251227200706.GN11869@unreal>
 <CAGsJ_4zyascnpQ1cB-BMO9PDeeRZTBAh8Z-j-ip=RcxApa4zSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4zyascnpQ1cB-BMO9PDeeRZTBAh8Z-j-ip=RcxApa4zSg@mail.gmail.com>

On Sun, Dec 28, 2025 at 10:45:13AM +1300, Barry Song wrote:
> On Sun, Dec 28, 2025 at 9:07 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Sat, Dec 27, 2025 at 11:52:44AM +1300, Barry Song wrote:
> > > From: Barry Song <baohua@kernel.org>
> > >
> > > Currently, arch_sync_dma_for_cpu and arch_sync_dma_for_device
> > > always wait for the completion of each DMA buffer. That is,
> > > issuing the DMA sync and waiting for completion is done in a
> > > single API call.
> > >
> > > For scatter-gather lists with multiple entries, this means
> > > issuing and waiting is repeated for each entry, which can hurt
> > > performance. Architectures like ARM64 may be able to issue all
> > > DMA sync operations for all entries first and then wait for
> > > completion together.
> > >
> > > To address this, arch_sync_dma_for_* now issues DMA operations in
> > > batch, followed by a flush. On ARM64, the flush is implemented
> > > using a dsb instruction within arch_sync_dma_flush().
> > >
> > > For now, add arch_sync_dma_flush() after each
> > > arch_sync_dma_for_*() call. arch_sync_dma_flush() is defined as a
> > > no-op on all architectures except arm64, so this patch does not
> > > change existing behavior. Subsequent patches will introduce true
> > > batching for SG DMA buffers.
> > >
> > > Cc: Leon Romanovsky <leon@kernel.org>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > > Cc: Robin Murphy <robin.murphy@arm.com>
> > > Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> > > Cc: Ard Biesheuvel <ardb@kernel.org>
> > > Cc: Marc Zyngier <maz@kernel.org>
> > > Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> > > Cc: Ryan Roberts <ryan.roberts@arm.com>
> > > Cc: Suren Baghdasaryan <surenb@google.com>
> > > Cc: Joerg Roedel <joro@8bytes.org>
> > > Cc: Juergen Gross <jgross@suse.com>
> > > Cc: Stefano Stabellini <sstabellini@kernel.org>
> > > Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> > > Cc: Tangquan Zheng <zhengtangquan@oppo.com>
> > > Signed-off-by: Barry Song <baohua@kernel.org>
> > > ---
> > >  arch/arm64/include/asm/cache.h |  6 ++++++
> > >  arch/arm64/mm/dma-mapping.c    |  4 ++--
> > >  drivers/iommu/dma-iommu.c      | 37 +++++++++++++++++++++++++---------
> > >  drivers/xen/swiotlb-xen.c      | 24 ++++++++++++++--------
> > >  include/linux/dma-map-ops.h    |  6 ++++++
> > >  kernel/dma/direct.c            |  8 ++++++--
> > >  kernel/dma/direct.h            |  9 +++++++--
> > >  kernel/dma/swiotlb.c           |  4 +++-
> > >  8 files changed, 73 insertions(+), 25 deletions(-)
> >
> > <...>
> >
> > > +#ifndef arch_sync_dma_flush
> > > +static inline void arch_sync_dma_flush(void)
> > > +{
> > > +}
> > > +#endif
> >
> > Over the weekend I realized a useful advantage of the ARCH_HAVE_* config
> > options: they make it straightforward to inspect the entire DMA path simply
> > by looking at the .config.
> 
> I am not quite sure how much this benefits users, as the same
> information could also be obtained by grepping for
> #define arch_sync_dma_flush in the source code.

It differs slightly. Users no longer need to grep around or guess whether this
platform used the arch_sync_dma_flush path. A simple grep for ARCH_HAVE_ in
/proc/config.gz provides the answer.

> 
> >
> > Thanks,
> > Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> 
> Thanks very much, Leon, for reviewing this over the weekend. One thing
> you might have missed is that I place arch_sync_dma_flush() after all
> arch_sync_dma_for_*() calls, for both single and sg cases. I also
> used a Python script to scan the code and verify that every
> arch_sync_dma_for_*() is followed by arch_sync_dma_flush(), to ensure
> that no call is left out.
> 
> In the subsequent patches, for sg cases, the per-entry flush is
> replaced by a single flush of the entire sg. Each sg case has
> different characteristics: some are straightforward, while others
> can be tricky and involve additional contexts.

I didn't overlook it, and I understand your rationale. However, this is
not how kernel patches should be structured. You should not introduce
code in patch X and then move it elsewhere in patch X + Y.

Place the code in the correct location from the start. Your patches are
small enough to review as is.

Thanks"
> 
> Thanks
> Barry
