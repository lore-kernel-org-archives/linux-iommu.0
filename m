Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239831E5B7B;
	Wed, 25 Feb 2026 07:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772005804; cv=none; b=kFagCkVNWRWsZEAY4t5SNKCBAroCPtVitPl+h+g+q8x3OSxOAEli7UrkFVnReMaMqfdefPe9K9GoW3IAZgM2IlZQENN+lGrt/a1gwFI3qwMusRTshzZRpO1CH5CK0lBQcZib/yyZBjlsTQVQVDRFYOQ3lS0ieiIZdJfm3rbXeWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772005804; c=relaxed/simple;
	bh=HvGkE+KfnO1/uKHBtgvhjWCUGZzE6KTtQGJZAUqruSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqDZxwYdKk1DRWjP4B1SXTMe4+XvbGXyOIMvjmldMb63c9xJN2hgLJdKzBEMlZjdfZP/6wEuAllpU5DFnF6g7zg+ZyT3hWowL8ce3S1m8HO6im0cXpbbNqBHEbG2XOj7oY1c56bCPW7EXjjeA+omUF3Gg6WS9XZlahszE2PYQiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fECYUl98; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fECYUl98"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2E1C19422;
	Wed, 25 Feb 2026 07:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772005803;
	bh=HvGkE+KfnO1/uKHBtgvhjWCUGZzE6KTtQGJZAUqruSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fECYUl984LeA3A2bhWgQE1lfBxon8xIufqg3QpJ5LB7FeVeJ8jWoyNxxeJnjRPa+2
	 7KVZxytSu4S03dc56kH2QD1bfPMdzlVY/V+5/diI/+WHJg85NCQrxzqDG9vdwREu9W
	 zWCZqivmboa20fuEtYY1kSMGfg3XiSy6nQCUAdbiPszJQ/KX7NJukb+7UYiyhLJ3c1
	 /Rd5OsbvT6kruxobHW1o9Ohn82W+slK7Va1y2d+EIEueAh9fu5Umbbnc9bySeLxvqh
	 8uQAbhYfWkO91t2xAYipJrEdKmh4sgmsZkpzUn0uGQxlCyeIw5u2xKwQUnbvkC5Jh3
	 cNycjbyFyusWg==
Date: Wed, 25 Feb 2026 09:50:00 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: Ashish Mhetre <amhetre@nvidia.com>, robin.murphy@arm.com,
	joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH RFC] iommu/dma: Validate page before accessing P2PDMA
 state
Message-ID: <20260225075000.GA9541@unreal>
References: <20260224104257.1641429-1-amhetre@nvidia.com>
 <20260224123221.GM10607@unreal>
 <aZ4Q1HA9q1ojsVYY@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZ4Q1HA9q1ojsVYY@google.com>

On Tue, Feb 24, 2026 at 08:57:56PM +0000, Pranjal Shrivastava wrote:
> On Tue, Feb 24, 2026 at 02:32:21PM +0200, Leon Romanovsky wrote:
> > On Tue, Feb 24, 2026 at 10:42:57AM +0000, Ashish Mhetre wrote:
> > > When mapping scatter-gather entries that reference reserved
> > > memory regions without struct page backing (e.g., bootloader created
> > > carveouts), is_pci_p2pdma_page() dereferences the page pointer
> > > returned by sg_page() without first verifying its validity.
> > 
> > I believe this behavior started after commit 88df6ab2f34b  
> > ("mm: add folio_is_pci_p2pdma()"). Prior to that change, the
> > is_zone_device_page(page) check would return false when given a
> > non‑existent page pointer.
> > 
> 
> Doesn't folio_is_pci_p2pdma() also check for zone device?
> I see[1] that it does:
> 
> static inline bool folio_is_pci_p2pdma(const struct folio *folio)
> {
> 	return IS_ENABLED(CONFIG_PCI_P2PDMA) &&
> 		folio_is_zone_device(folio) &&
> 		folio->pgmap->type == MEMORY_DEVICE_PCI_P2PDMA;
> }
> 
> I believe the problem arises due to the page_folio() call in
> folio_is_pci_p2pdma(page_folio(page)); within is_pci_p2pdma_page().
> page_folio() assumes it has a valid struct page to work with. For these
> carveouts, that isn't true.

Yes, i came to the same conclusion, just explained why it worked before.

> 
> Potentially something like the following would stop the crash:
> 
> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> index e3c2ccf872a8..e47876021afa 100644
> --- a/include/linux/memremap.h
> +++ b/include/linux/memremap.h
> @@ -197,7 +197,8 @@ static inline void folio_set_zone_device_data(struct folio *folio, void *data)
> 
>  static inline bool is_pci_p2pdma_page(const struct page *page)
>  {
> -       return IS_ENABLED(CONFIG_PCI_P2PDMA) &&
> +       return IS_ENABLED(CONFIG_PCI_P2PDMA) && page &&
> +               pfn_valid(page_to_pfn(page)) &&

pfn_valid() is a relatively expensive function [1] to invoke in the data path,
and is_pci_p2pdma_page() ends up being called in these execution flows.

[1] https://elixir.bootlin.com/linux/v6.19.3/source/include/linux/mmzone.h#L2167

>                 folio_is_pci_p2pdma(page_folio(page));
>  }
> 
> 
> But my broader question is: why are we calling a page-based API like 
> is_pci_p2pdma_page() on non-struct-page memory in the first place?

+1

> Could we instead add a helper to verify if the sg_page() return value
> is actually backed by a struct page?

According to the SG design, callers should store only struct page pointers.
There is one known user that violates this requirement: dmabuf, which is
gradually being migrated away from this behavior [2].

[2] https://lore.kernel.org/all/0-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com/

> If it isn't, we should arguably skip the P2PDMA logic entirely and fall
> back to a dma_map_phys style path. Isn't handling these "pageless" physical
> ranges the primary reason dma_map_phys exists?

Right. dma_map_sg() is indeed the wrong API to use for memory that is not
backed by struct page pointers.

Thanks

> 
> +mm list
> 
> Thanks,
> Praan
> 
> [1] https://elixir.bootlin.com/linux/v6.19.3/source/include/linux/memremap.h#L179
> 
> 
> > If any fix is needed, the is_pci_p2pdma_page() must be changed and not iommu.
> > 
> > Thanks
> > 
> > > 
> > > This causes a kernel paging fault when CONFIG_PCI_P2PDMA is enabled
> > > and dma_map_sg_attrs() is called for memory regions that have no
> > > associated struct page:
> > > 
> > > Unable to handle kernel paging request at virtual address fffffc007d100000
> > >   ...
> > >   Call trace:
> > >    iommu_dma_map_sg+0x118/0x414
> > >    dma_map_sg_attrs+0x38/0x44
> > > 
> > > Fix this by adding a pfn_valid() check before calling
> > > is_pci_p2pdma_page(). If the page frame number is invalid, skip the
> > > P2PDMA check entirely as such memory cannot be P2PDMA memory anyway.
> > > 
> > > Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> > > ---
> > >  drivers/iommu/dma-iommu.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > > index 5dac64be61bb..5f45f33b23c2 100644
> > > --- a/drivers/iommu/dma-iommu.c
> > > +++ b/drivers/iommu/dma-iommu.c
> > > @@ -1423,6 +1423,9 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
> > >  		size_t s_length = s->length;
> > >  		size_t pad_len = (mask - iova_len + 1) & mask;
> > >  
> > > +		if (!pfn_valid(page_to_pfn(sg_page(s))))
> > > +			goto post_pci_p2pdma;
> > > +
> > >  		switch (pci_p2pdma_state(&p2pdma_state, dev, sg_page(s))) {
> > >  		case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
> > >  			/*
> > > @@ -1449,6 +1452,7 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
> > >  			goto out_restore_sg;
> > >  		}
> > >  
> > > +post_pci_p2pdma:
> > >  		sg_dma_address(s) = s_iova_off;
> > >  		sg_dma_len(s) = s_length;
> > >  		s->offset -= s_iova_off;
> > > -- 
> > > 2.25.1
> > > 
> > > 
> > 
