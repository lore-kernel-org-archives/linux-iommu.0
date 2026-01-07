Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1117A259C84;
	Wed,  7 Jan 2026 07:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767772459; cv=none; b=jerM5NjyT88sC/MIScVgx3UFlc9m7KZ2TrcG0I1X65tRQFIcmXyZB//dOlZyDLPiIH4oAoiX7RiP48f72wP1ChmqUJYyGTZB3HpCw65hK5k3vJkCF6/yEpbXA/vp2kkboYiq7yPn/6W8cOomFMm1K5eL0BcptpGt9WA236NTLJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767772459; c=relaxed/simple;
	bh=IJfaPCj/Ro7N4LJzkmqwZpte1m5fLCvqEg3Yi9qSa/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmTbsYPWAIcmNq3uVHLDcqzTeZSZw2U4LspJ7Hwj9UomO4VNNhak8ZNY8XZ8pUylBYmvOF1zJCFkQD9dnWbuTmyoiWq87cnaJ6TaDYkdMGDDUNuGZ5k8qqOkf2rrHsgoRbX1Zjg6t8cDC0Pwk76WnprWciNzVhKfryrdSebec3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JegFElB4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JegFElB4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366ADC4CEF7;
	Wed,  7 Jan 2026 07:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767772458;
	bh=IJfaPCj/Ro7N4LJzkmqwZpte1m5fLCvqEg3Yi9qSa/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JegFElB4jfM6lIyqKfOUEJmukL5QcBuXQQCS1oWKX/mXqRH1La+ORK7qxKkRK97t1
	 UpXoiQVQFSfboQKHgYUuMFwg/5O3Rd81m1mG1lk7kajHvCCddaxg9zzvFJFzoCL5M9
	 DB6ldMtJc38E38hDgUAxRo6vz9wGXGEZncuXsCbDdWtoTWUNsvsd4MSZexskkOMrAG
	 lmjCcWVP9uN1Gd7GSKAeLe0jYdbbdrZESH7yo63D9W5zhX9y49sK2mWwfo/1mCDcpC
	 q+MP/ZYycMVhRnWG5yZ04253/4EDluvRHL7pltvITIR6/dH3lj7namEjrQJew9TpUd
	 W2sBYSB/ZcG2Q==
Date: Wed, 7 Jan 2026 09:54:14 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Barry Song <21cnbao@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>, catalin.marinas@arm.com,
	m.szyprowski@samsung.com, will@kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tangquan Zheng <zhengtangquan@oppo.com>
Subject: Re: [PATCH v2 5/8] dma-mapping: Support batch mode for
 dma_direct_sync_sg_for_*
Message-ID: <20260107075414.GA11783@unreal>
References: <20251226225254.46197-1-21cnbao@gmail.com>
 <20251226225254.46197-6-21cnbao@gmail.com>
 <20251227200933.GO11869@unreal>
 <CAGsJ_4yA83-K7PXiEtyidzF_j6qqKkt92z485KBS9+zGe_rjnw@mail.gmail.com>
 <20251228145041.GS11869@unreal>
 <CAGsJ_4yex5MKQkGtFr2zUcg4h0PtsFs2QVcE_NSfiyOn4qBzhQ@mail.gmail.com>
 <de876e61-42c5-414d-b439-2f9196c6c128@arm.com>
 <CAGsJ_4xYqseJMFXOU39JJW4Lk2ZHXAnRJLhZdVuFLxAi=Dy5sw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4xYqseJMFXOU39JJW4Lk2ZHXAnRJLhZdVuFLxAi=Dy5sw@mail.gmail.com>

On Wed, Jan 07, 2026 at 08:47:36AM +1300, Barry Song wrote:
> On Wed, Jan 7, 2026 at 8:12 AM Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > On 2026-01-06 6:41 pm, Barry Song wrote:
> > > On Mon, Dec 29, 2025 at 3:50 AM Leon Romanovsky <leon@kernel.org> wrote:
> > >>
> > >> On Sun, Dec 28, 2025 at 09:52:05AM +1300, Barry Song wrote:
> > >>> On Sun, Dec 28, 2025 at 9:09 AM Leon Romanovsky <leon@kernel.org> wrote:
> > >>>>
> > >>>> On Sat, Dec 27, 2025 at 11:52:45AM +1300, Barry Song wrote:
> > >>>>> From: Barry Song <baohua@kernel.org>
> > >>>>>
> > >>>>> Instead of performing a flush per SG entry, issue all cache
> > >>>>> operations first and then flush once. This ultimately benefits
> > >>>>> __dma_sync_sg_for_cpu() and __dma_sync_sg_for_device().
> > >>>>>
> > >>>>> Cc: Leon Romanovsky <leon@kernel.org>
> > >>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
> > >>>>> Cc: Will Deacon <will@kernel.org>
> > >>>>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > >>>>> Cc: Robin Murphy <robin.murphy@arm.com>
> > >>>>> Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> > >>>>> Cc: Ard Biesheuvel <ardb@kernel.org>
> > >>>>> Cc: Marc Zyngier <maz@kernel.org>
> > >>>>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> > >>>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
> > >>>>> Cc: Suren Baghdasaryan <surenb@google.com>
> > >>>>> Cc: Tangquan Zheng <zhengtangquan@oppo.com>
> > >>>>> Signed-off-by: Barry Song <baohua@kernel.org>
> > >>>>> ---
> > >>>>>   kernel/dma/direct.c | 14 +++++++-------
> > >>>>>   1 file changed, 7 insertions(+), 7 deletions(-)
> > >>>>
> > >>>> <...>
> > >>>>
> > >>>>> -             if (!dev_is_dma_coherent(dev)) {
> > >>>>> +             if (!dev_is_dma_coherent(dev))
> > >>>>>                        arch_sync_dma_for_device(paddr, sg->length,
> > >>>>>                                        dir);
> > >>>>> -                     arch_sync_dma_flush();
> > >>>>> -             }
> > >>>>>        }
> > >>>>> +     if (!dev_is_dma_coherent(dev))
> > >>>>> +             arch_sync_dma_flush();
> > >>>>
> > >>>> This patch should be squashed into the previous one. You introduced
> > >>>> arch_sync_dma_flush() there, and now you are placing it elsewhere.
> > >>>
> > >>> Hi Leon,
> > >>>
> > >>> The previous patch replaces all arch_sync_dma_for_* calls with
> > >>> arch_sync_dma_for_* plus arch_sync_dma_flush(), without any
> > >>> functional change. The subsequent patches then implement the
> > >>> actual batching. I feel this is a better approach for reviewing
> > >>> each change independently. Otherwise, the previous patch would
> > >>> be too large.
> > >>
> > >> Don't worry about it. Your patches are small enough.
> > >
> > > My hardware does not require a bounce buffer, but I am concerned that
> > > this patch may be incorrect for systems that do require one.
> > >
> > > Now it is:
> > >
> > > void dma_direct_sync_sg_for_cpu(struct device *dev,
> > >                  struct scatterlist *sgl, int nents, enum dma_data_direction dir)
> > > {
> > >          struct scatterlist *sg;
> > >          int i;
> > >
> > >          for_each_sg(sgl, sg, nents, i) {
> > >                  phys_addr_t paddr = dma_to_phys(dev, sg_dma_address(sg));
> > >
> > >                  if (!dev_is_dma_coherent(dev))
> > >                          arch_sync_dma_for_cpu(paddr, sg->length, dir);
> > >
> > >                  swiotlb_sync_single_for_cpu(dev, paddr, sg->length, dir);
> > >
> > >                  if (dir == DMA_FROM_DEVICE)
> > >                          arch_dma_mark_clean(paddr, sg->length);
> > >          }
> > >
> > >          if (!dev_is_dma_coherent(dev)) {
> > >                  arch_sync_dma_flush();
> > >                  arch_sync_dma_for_cpu_all();
> > >          }
> > > }
> > >
> > > Should we call swiotlb_sync_single_for_cpu() and
> > > arch_dma_mark_clean() after the flush to ensure the CPU sees the
> > > latest data and that the memcpy is correct? I mean:
> >
> > Yes, this and the equivalents in the later patches are broken for all
> > the sync_for_cpu and unmap paths which may end up bouncing (beware some
> > of them get a bit fiddly) - any cache maintenance *must* be completed
> > before calling SWIOTLB. As for mark_clean, IIRC that was an IA-64 thing,
> > and appears to be entirely dead now.
> 
> Thanks, Robin. Personally, I would prefer an approach like the one below—
> that is, not optimizing the bounce buffer cases, as they are already slow
> due to hardware limitations with memcpy, and optimizing them would make
> the code quite messy.
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 550a1a13148d..a4840f7e8722 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -423,8 +423,11 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
>         for_each_sg(sgl, sg, nents, i) {
>                 phys_addr_t paddr = dma_to_phys(dev, sg_dma_address(sg));
> 
> -               if (!dev_is_dma_coherent(dev))
> +               if (!dev_is_dma_coherent(dev)) {
>                         arch_sync_dma_for_cpu(paddr, sg->length, dir);
> +                       if (unlikely(dev->dma_io_tlb_mem))
> +                               arch_sync_dma_flush();
> +               }
> 
>                 swiotlb_sync_single_for_cpu(dev, paddr, sg->length, dir);
> 
> I’d like to check with you, Leon, and Marek on your views about this.

I agree with your point that the non‑SWIOTLB path is the performant one and
should be preferred. My concern is that you are accessing the
dma_io_tlb_mem variable directly from direct.c, which looks like a layer
violation.

You likely need to introduce an is_swiotlb_something() helper for this.

BTW, please send a v3 instead of posting incremental follow‑ups.
It's hard to track the changes across multiple small additions.

Thanks.
> 
> Thanks
> Barry
