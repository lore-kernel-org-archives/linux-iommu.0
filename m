Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4514433B6FD
	for <iommu@lists.linux.dev>; Tue, 24 Feb 2026 20:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771966684; cv=none; b=m+X0yU3ZDAeGL7s7A6JE2TjytEPI3htgw8USHCsLvdKxLR01+e12U5/cxbx4bAn8VP6A9mQGmo95EYOdMEjygFAT64XPJhHNGOCR+jUVCiWk9dwiYQl3pfNc0xWz3AmoNEktnuOYBcexajnlZ6FwDPmwd7XlNvCdxvNtdru2oi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771966684; c=relaxed/simple;
	bh=kSwpkSCqUHWfyiluPXFGACIrpfsKwv5ePv+HerBIP4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkQaeiu4j9INDdkIcwdJHh89PxwDbmzMy1G5uzp7F6Blqvs5ZeZ6k+GyH0FOjgSSLBC3wVHeXUHbFbDqOPzRMyZMjWI4doLTp79ZjGaNlIRwbd/gAc7LtI6jkzY0OF9vMN7PzK++CISUlO06whXNTR0TYVjOXn6OgTas3yfDqvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MVUi5zXe; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MVUi5zXe"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2aad8123335so5725ad.1
        for <iommu@lists.linux.dev>; Tue, 24 Feb 2026 12:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771966682; x=1772571482; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dCfIJGNanLX/GKzPG5uplkTp3s1FhuLnYoYswoYHgEA=;
        b=MVUi5zXeAp6QZY8mwKj2/PXTH8wIjSzdda2FMTS19lMVvUjW62UyxOcEgKBYpG549/
         h61n35JwVFQjhcKu3r//iPH9pvRE3QAtxR8ZfOmwk2fk41qOFL0VLffhhQp87n0oYkXr
         CUER8pg4Pifbdcx/fJtXpgk2A+3D1qt6TQumh+kmwlIK3FnJQP16NVD++9ds1IVQ9+WQ
         52wakny0RIGFzj9gKNPctkjPxxPr5RoLVGSM429QeUNZjCBlHMcZEDbuX1uiOKTSNjbf
         SqKkPGgcEUpUPnikhoCzcW32SvanjYjdsml8Sm3Yt/aP4NSIilTNKT31chZa7rO9oXAJ
         yBeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771966682; x=1772571482;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dCfIJGNanLX/GKzPG5uplkTp3s1FhuLnYoYswoYHgEA=;
        b=MOOaJ67P4n2hxo6LMQ6V4H8PROfCcnhumCn37rQUzGo6cC/NTxWpZmzBKHllxf59mY
         RpMBcXtm0lX9NvUVGDeLTF8jIATGnB72gTRwZC00i51w4uFNa3opkbUfYQbwbhAGGDwo
         RLfNJ0o+sOBYO9L6P78AS86qlgrtiZK+nnCWYi+HTokd0CVDKJHYgNKRuFcZk/S1JuHk
         967O8+GOpqAo0sP0/9yTAyZVR4wvmKcmMfGkDVHXIMGb3A2Bx8gV/DdQwala0btYCjZb
         Fgmkla6pmkrhynwky9o/A4TUgmKhTFrpFYunR+SgmlpRYtLnlXhDGQAYcTLt45SByu8X
         5z2w==
X-Forwarded-Encrypted: i=1; AJvYcCXqGqjOBYlf1wZVbvWjxQYd73T89jm/nQgqaqVshC1vIWqPismttpPtk9tih3yoS81vF/b/TQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxsm0HETy0Fdw4JQ3oYhYtpmf1qZuZdcCl31/0sYcpUEcXo9SOw
	iHndiQkB7rWmw8yri+jNXmYf1scsQ1y5e2OYj96Sq0o5S2P4zvcWSN+c9raPpuuO0w==
X-Gm-Gg: ATEYQzzU6egiZESjD7RNI+HRvsrOwuiilk/prkcNMnyFugIPbNkafQdzjIaxBh4fwo+
	AGLUfkH0lsMlAjWPXxsmpYhSicQg/glCl2886yl77+8kZ5pYfGnyDY5BNQGEbiXAU66DoQsNqAy
	x99bFvEaH4YbfSC9m5FQ8yeQvkKbB1FbajXMXuNDSZiKtURlr+Zzw23DiIpkew+KNSQE24NMwCI
	PvXzX6P57cVNPpX/goGf0VCJfOPGM+N19cs5kh6m8zJyB+ROddd6uxrvng2sLxERPmLVWFreJc+
	Rsvj1nQGrNoeF5Lu+ic3ezQwV9CBOT0c/m/0NnV2EQ6da6Mcgn32x6t3kVRowSZ1DLbWt7Tw7mE
	eirel612goJYwSljBGRiOTm+goSFE6UMh5y9EKcagfjfjDe+7y1a/GpyY6BcYqErppvbIuMw94O
	4PCDtokiiEAZSXMGiSP3eZqYYyDZ4caO6OHPZovXVaTXWqUtO0PI3GYwGtFu8MhsSvpSa7g0k=
X-Received: by 2002:a17:903:2410:b0:2a1:3cdc:7720 with SMTP id d9443c01a7336-2add13b3df7mr25705ad.21.1771966681213;
        Tue, 24 Feb 2026 12:58:01 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35902bdaffdsm686832a91.17.2026.02.24.12.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 12:58:00 -0800 (PST)
Date: Tue, 24 Feb 2026 20:57:56 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Ashish Mhetre <amhetre@nvidia.com>, robin.murphy@arm.com,
	joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH RFC] iommu/dma: Validate page before accessing P2PDMA
 state
Message-ID: <aZ4Q1HA9q1ojsVYY@google.com>
References: <20260224104257.1641429-1-amhetre@nvidia.com>
 <20260224123221.GM10607@unreal>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260224123221.GM10607@unreal>

On Tue, Feb 24, 2026 at 02:32:21PM +0200, Leon Romanovsky wrote:
> On Tue, Feb 24, 2026 at 10:42:57AM +0000, Ashish Mhetre wrote:
> > When mapping scatter-gather entries that reference reserved
> > memory regions without struct page backing (e.g., bootloader created
> > carveouts), is_pci_p2pdma_page() dereferences the page pointer
> > returned by sg_page() without first verifying its validity.
> 
> I believe this behavior started after commit 88df6ab2f34b  
> ("mm: add folio_is_pci_p2pdma()"). Prior to that change, the
> is_zone_device_page(page) check would return false when given a
> non‑existent page pointer.
> 

Doesn't folio_is_pci_p2pdma() also check for zone device?
I see[1] that it does:

static inline bool folio_is_pci_p2pdma(const struct folio *folio)
{
	return IS_ENABLED(CONFIG_PCI_P2PDMA) &&
		folio_is_zone_device(folio) &&
		folio->pgmap->type == MEMORY_DEVICE_PCI_P2PDMA;
}

I believe the problem arises due to the page_folio() call in
folio_is_pci_p2pdma(page_folio(page)); within is_pci_p2pdma_page().
page_folio() assumes it has a valid struct page to work with. For these
carveouts, that isn't true.

Potentially something like the following would stop the crash:

diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index e3c2ccf872a8..e47876021afa 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -197,7 +197,8 @@ static inline void folio_set_zone_device_data(struct folio *folio, void *data)

 static inline bool is_pci_p2pdma_page(const struct page *page)
 {
-       return IS_ENABLED(CONFIG_PCI_P2PDMA) &&
+       return IS_ENABLED(CONFIG_PCI_P2PDMA) && page &&
+               pfn_valid(page_to_pfn(page)) &&
                folio_is_pci_p2pdma(page_folio(page));
 }


But my broader question is: why are we calling a page-based API like 
is_pci_p2pdma_page() on non-struct-page memory in the first place?
Could we instead add a helper to verify if the sg_page() return value
is actually backed by a struct page? If it isn't, we should arguably
skip the P2PDMA logic entirely and fall back to a dma_map_phys style 
path. Isn't handling these "pageless" physical ranges the primary reason
dma_map_phys exists?

+mm list

Thanks,
Praan

[1] https://elixir.bootlin.com/linux/v6.19.3/source/include/linux/memremap.h#L179


> If any fix is needed, the is_pci_p2pdma_page() must be changed and not iommu.
> 
> Thanks
> 
> > 
> > This causes a kernel paging fault when CONFIG_PCI_P2PDMA is enabled
> > and dma_map_sg_attrs() is called for memory regions that have no
> > associated struct page:
> > 
> > Unable to handle kernel paging request at virtual address fffffc007d100000
> >   ...
> >   Call trace:
> >    iommu_dma_map_sg+0x118/0x414
> >    dma_map_sg_attrs+0x38/0x44
> > 
> > Fix this by adding a pfn_valid() check before calling
> > is_pci_p2pdma_page(). If the page frame number is invalid, skip the
> > P2PDMA check entirely as such memory cannot be P2PDMA memory anyway.
> > 
> > Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> > ---
> >  drivers/iommu/dma-iommu.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 5dac64be61bb..5f45f33b23c2 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -1423,6 +1423,9 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
> >  		size_t s_length = s->length;
> >  		size_t pad_len = (mask - iova_len + 1) & mask;
> >  
> > +		if (!pfn_valid(page_to_pfn(sg_page(s))))
> > +			goto post_pci_p2pdma;
> > +
> >  		switch (pci_p2pdma_state(&p2pdma_state, dev, sg_page(s))) {
> >  		case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
> >  			/*
> > @@ -1449,6 +1452,7 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
> >  			goto out_restore_sg;
> >  		}
> >  
> > +post_pci_p2pdma:
> >  		sg_dma_address(s) = s_iova_off;
> >  		sg_dma_len(s) = s_length;
> >  		s->offset -= s_iova_off;
> > -- 
> > 2.25.1
> > 
> > 
> 
