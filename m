Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0535B40F8F4
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 14:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772201332; cv=none; b=osrZsAyZ+uB5s1OGi7cRPD1MPvBtQmqpJclrm/6WwAyFLlEB3M+iQShkNsaNzMOFsEYpPyiPgqzALH5zmGAz8rBVExoQrN6ncXwT/Hn0LlVW4p5L/Rmvbda2u+q5rTyx4U/QTV7vW5lbNEtUoQO6h6st5xp9qjpHNLdAiuK1z6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772201332; c=relaxed/simple;
	bh=FiPOmkSP7ehgLmpdTYk5UUCfeoVIQIAHj0q6pX90Rco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1DCUrq5LFadVTcFUvcAX3NOLh+NWPOhBYV3DD/W3Uxwt2q+WxssV9LyeHSxampK2HSms/A/VpksEjzHBMUoO3ZLrA7FGG4he+roV6WXYLCIgga80KUzDVJg4FDmYaZd9Ya/6hHNlEnnt6Xzt62p5IMTq91Kc6X5XqAm6wnXro0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z4uurJFg; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z4uurJFg"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a964077671so87245ad.0
        for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 06:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772201330; x=1772806130; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+478MnXHHm9he6xCScSmHIKPdUGXlF+DBnPVpCD0kfA=;
        b=z4uurJFgyKujjLuSVKv/1jfJeJzef9paY4RRzwLJQq1xTh/7lsleMp5YQ4CwsN19tf
         xLbezwk/y5xCsmX688mSb+BFP4EjKYj06P0oAcN8OJ9dtadBzMp5kRNmWxi/Vhif5PK8
         eY7fPU0uBvchqzGLvGxQRO7x/4qRdMyaPYHtFxV/KH9BSB2DLQkjA0ZpVxWGZIYm/3bK
         +dp6EH4xC9NR479k0QhA8hmtyzi1OTJLiH75ZWT2vdTzR/GdrOT3tibssmkT+jaTdP6K
         0Y/kNL0OryTzhbD3+xa1lpUQVYocQu1D9FUys01rWdF+UPycQj8u4PE/1o+/ck2dON/t
         BlWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772201330; x=1772806130;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+478MnXHHm9he6xCScSmHIKPdUGXlF+DBnPVpCD0kfA=;
        b=ArgOC2q9wpm/A1U1H9E9VbzkwfJ4Ht7rJl5zWcgrOC/0tlduuz/q6idfjmtswqMzru
         tFzr6geOXHSZBD7Qs18cMWamF4bOrQI5w4L+TkSRKEd6WFlU62U1BI8ZrBUH6UYf8wZ/
         5P16ZMSf5p3qRQ0bATZK74vumGuiCcOfpy8MorhhXaB/l2o5keYL/6ENQeBbgQbfo5bR
         tgfOiQpb5HqBUPQxs1jgUyG+GGLxH1MunodQ91H3yWoEnI2cwUgW+FpTj1YngulOmO/8
         nD/NlDc5ZtuEizt8S21jWz42jRRYB3n1+/yr/95+nb9Nmnzo8OQY/H7wBqoMBwSfbpuI
         Vsfw==
X-Forwarded-Encrypted: i=1; AJvYcCWojhV6W7P80qx1NhycAk4F09TDkx/hMfAflHroKLoyhLLkyCCn819CH1UIDRRjn6isMdfsPA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzKaMayTNZrTus1xnZcEq21UpH6nwCOHuEAFFs7DhsydQPatnMf
	TECVUOaTKAloV9Agwg42qZrEun+VDELKSkV8T98sTqxn/RMBd/NBhNepkyy0EbdGkQ==
X-Gm-Gg: ATEYQzwDaBF7e9C4M6asyFynLxSzfsCtxGd+Kf0tYkA0Y+xggnCXSTlYB/GjS3UzgD2
	8bwLzHhN2uDQHvphXnxu59qT+InCmdzmEkIpbyK85D97/iZuRLHiHcDWaAItejHzpcccHYdDgax
	Ma7uPDs2/ZT+geCwYwob3hfRdAGFfmYuVoE1D+sC7i54ppmv02tti1GUoNkUekCtSPGGcBQ3sVw
	AVBDNYLkfC9rAf/7ooPSyEn8a70ciiCVsFefvbMnjGhQg7pev8/lkygoYiIznNhG1VD2G8C0ZGq
	fjA4YFoKR0zp23PNjn12TUST+hbiFCwhzPIKN6S8+k/HzIKhp4R0D7dvDUZI0EAu2IkT5D3Xz17
	f47l6fszd6VClf9U3KdrRSN0KFnVmhhTJDIFL9RVQbEgLuU3H9EK2IZT7q/JQqOQPyOmJYPxtCH
	mX3M6q7+QXRTOG1/Z7bgLw2kI85ntdO2a6S6JfmvlQr1IXm1EZWLdF+IxpppjM
X-Received: by 2002:a17:903:15ce:b0:2a3:cd98:f07 with SMTP id d9443c01a7336-2adfefd95b6mr4837465ad.3.1772201329615;
        Fri, 27 Feb 2026 06:08:49 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5b148bsm77618315ad.10.2026.02.27.06.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 06:08:48 -0800 (PST)
Date: Fri, 27 Feb 2026 14:08:42 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Ashish Mhetre <amhetre@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, robin.murphy@arm.com,
	joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-mm@kvack.org, jgg@ziepe.ca, jgg@nvidia.com
Subject: Re: [PATCH RFC] iommu/dma: Validate page before accessing P2PDMA
 state
Message-ID: <aaGlapPSmFJcXsDh@google.com>
References: <20260224104257.1641429-1-amhetre@nvidia.com>
 <20260224123221.GM10607@unreal>
 <aZ4Q1HA9q1ojsVYY@google.com>
 <9d01b4e3-be5b-4c9c-8088-1d10f67f1fd8@nvidia.com>
 <20260225075609.GB9541@unreal>
 <aZ9Xccnn7JOikudb@google.com>
 <20260226075806.GE12611@unreal>
 <58634d52-5d44-4ec9-b1f6-273b5c32b525@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58634d52-5d44-4ec9-b1f6-273b5c32b525@nvidia.com>

On Fri, Feb 27, 2026 at 11:16:02AM +0530, Ashish Mhetre wrote:
> 
> 
> On 2/26/2026 1:28 PM, Leon Romanovsky wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Wed, Feb 25, 2026 at 08:11:29PM +0000, Pranjal Shrivastava wrote:
> > > On Wed, Feb 25, 2026 at 09:56:09AM +0200, Leon Romanovsky wrote:
> > > > On Wed, Feb 25, 2026 at 10:19:41AM +0530, Ashish Mhetre wrote:
> > > > > 
> > > > > On 2/25/2026 2:27 AM, Pranjal Shrivastava wrote:
> > > > > > External email: Use caution opening links or attachments
> > > > > > 
> > > > > > 
> > > > > > On Tue, Feb 24, 2026 at 02:32:21PM +0200, Leon Romanovsky wrote:
> > > > > > > On Tue, Feb 24, 2026 at 10:42:57AM +0000, Ashish Mhetre wrote:
> > > > > > > > When mapping scatter-gather entries that reference reserved
> > > > > > > > memory regions without struct page backing (e.g., bootloader created
> > > > > > > > carveouts), is_pci_p2pdma_page() dereferences the page pointer
> > > > > > > > returned by sg_page() without first verifying its validity.
> > > > > > > I believe this behavior started after commit 88df6ab2f34b
> > > > > > > ("mm: add folio_is_pci_p2pdma()"). Prior to that change, the
> > > > > > > is_zone_device_page(page) check would return false when given a
> > > > > > > non‑existent page pointer.
> > > > > > > 
> > > > > Thanks Leon for the review. This crash started after commit 30280eee2db1
> > > > > ("iommu/dma: support PCI P2PDMA pages in dma-iommu map_sg").
> > > > > 
> > > > > > Doesn't folio_is_pci_p2pdma() also check for zone device?
> > > > > > I see[1] that it does:
> > > > > > 
> > > > > > static inline bool folio_is_pci_p2pdma(const struct folio *folio)
> > > > > > {
> > > > > >           return IS_ENABLED(CONFIG_PCI_P2PDMA) &&
> > > > > >                   folio_is_zone_device(folio) &&
> > > > > >                   folio->pgmap->type == MEMORY_DEVICE_PCI_P2PDMA;
> > > > > > }
> > > > > > 
> > > > > > I believe the problem arises due to the page_folio() call in
> > > > > > folio_is_pci_p2pdma(page_folio(page)); within is_pci_p2pdma_page().
> > > > > > page_folio() assumes it has a valid struct page to work with. For these
> > > > > > carveouts, that isn't true.
> > > > > > 
> > > > > > Potentially something like the following would stop the crash:
> > > > > > 
> > > > > > diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> > > > > > index e3c2ccf872a8..e47876021afa 100644
> > > > > > --- a/include/linux/memremap.h
> > > > > > +++ b/include/linux/memremap.h
> > > > > > @@ -197,7 +197,8 @@ static inline void folio_set_zone_device_data(struct folio *folio, void *data)
> > > > > > 
> > > > > >    static inline bool is_pci_p2pdma_page(const struct page *page)
> > > > > >    {
> > > > > > -       return IS_ENABLED(CONFIG_PCI_P2PDMA) &&
> > > > > > +       return IS_ENABLED(CONFIG_PCI_P2PDMA) && page &&
> > > > > > +               pfn_valid(page_to_pfn(page)) &&
> > > > > >                   folio_is_pci_p2pdma(page_folio(page));
> > > > > >    }
> > > > > > 
> > > > > Yes, this will also fix the crash.
> > > > > 
> > > > > > But my broader question is: why are we calling a page-based API like
> > > > > > is_pci_p2pdma_page() on non-struct-page memory in the first place?
> > > > > > Could we instead add a helper to verify if the sg_page() return value
> > > > > > is actually backed by a struct page? If it isn't, we should arguably
> > > > > > skip the P2PDMA logic entirely and fall back to a dma_map_phys style
> > > > > > path. Isn't handling these "pageless" physical ranges the primary reason
> > > > > > dma_map_phys exists?
> > > > > Thanks for the feedback, Pranjal.
> > > > > 
> > > > > To clarify: are you suggesting we handle non-page-backed mappings inside
> > > > > iommu_dma_map_sg (within dma-iommu), or that callers should detect
> > > > > non-page-backed memory and use dma_map_phys instead of dma_map_sg?
> > > > The latter one.
> > > > 
> > > Yup, I meant the latter.
> > > 
> > > > > Former approach sounds better so that existing iommu_dma_map_sg callers
> > > > > don't need changes, but I'd like to confirm your preference.
> > > > The bug is in callers which used wrong API, they need to be adapted.
> > > Yes, the thing is, if the caller already knows that the region to be
> > > mapped is NOT struct page-backed, then why does it use dma_map_sg
> > > variants?
> > Before dma_map_phys() was added, there was no reliable way to DMA‑map
> > such memory, and using dma_map_sg() was a workaround that happened to

Ack.

> > work. I'm not sure whether it worked by design or by accident, but the
> > correct approach now is to use dma_map_phys().
> 
> Thanks Leon and Pranjal for the detailed feedback. I'll update our callers
> to use
> dma_map_phys() for non-page-backed buffers.
> 
> One question: would it make sense to add a check in iommu_dma_map_sg to
> fail gracefully when non-page-backed buffers are passed, instead of crashing
> the kernel?

In my opinion, the answer is no, since this is almost like the "should
the kernel protect developers from themselves" debate.. we should be a
little dramatic to make sure the developer doesn't call the wrong API.
Sure, we could return a DMA_MAPPING_ERROR or something but a silent 
DMA_MAPPING_ERROR can be ignored by a lazy driver resulting in a much
harder-to-debug scenario than a straight-forward crash.

The question is, are we sure to use scatterlists to represent non-paged
memory? 

If no, then why are we even calling the dma_map_sg* API?
struct scatterlist has a field "page_link" [1] which is literally the
struct page with a few bits representing something else.

If yes, then we could maybe encode some information (similar to
SG_CHAIN) representing if the sg is backed by a struct page. And then in
the *sg_map APIs, we could fallback to the dma_phys API if it isn't
struct paged-backed. (This would be quite some re-work and not limited
to the DMA API alone).

But as Leon pointed out that the use of sg for non-paged memory started
as a "work-around" since there was no equivalent API to dma_map_phys
earlier. Since that's the status quo, I'm leaning towards no.

But I think this gives us a nice opportunity to discuss if we really
*need* to have scatterlists to represent non-paged memory. I remember
some similar discussion happened during tcp_devmem reviews [2].

Adding Jason for his thoughts as well..

Thanks,
Praan

[1] https://elixir.bootlin.com/linux/v6.19.3/source/include/linux/scatterlist.h#L12
[2] https://lore.kernel.org/netdev/20241115015912.GA559636@ziepe.ca/
