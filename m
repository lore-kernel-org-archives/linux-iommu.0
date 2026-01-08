Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297B54AC793
	for <iommu@lists.linux.dev>; Thu,  8 Jan 2026 11:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767870412; cv=none; b=BAKLo0XdJaV+pk4Mgb15Izr4HytuDG3PVGTqqUvjS1rljlGRUnprFFaJavxWjRfVPEyVUZchYSDOIZUuP3ZgkRxmY5lvtOKkXA4oCnSRC++8u4FGn6TbUDjhKWPAVVJRiTDOH0Ds9XwSJYTeKi/JUIm43KUvn55xOoM1/S0p+1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767870412; c=relaxed/simple;
	bh=oYBs/GGWm01SqZamHpXLamRey53S8oU31qmPYAJ9YR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJrn60mVrt+UPueJ6WKGIfTtCZW5xX3LPcLBeDnYdbHnQkQzSn/kukcsm2KrOiSq/Qq2JVAiYHksXAndK76ZJlMH1RFWQ1/hJD9EKB54f+UlLeInBQ3IGiJUwpPN4O7Q/g2uuzrEqA1dp3RxAcdqYmc9YQFD77MxzpY1QrsmWg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h3s/hf3J; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h3s/hf3J"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4779a4fb9bfso119975e9.0
        for <iommu@lists.linux.dev>; Thu, 08 Jan 2026 03:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767870400; x=1768475200; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bRRthK53UX6LOkjCTrjT1p312kfkJFJyixNlmbYAffA=;
        b=h3s/hf3J9N8vlNaub9PjRpBOZeXuI3QPPSE0410sMt56EAmckA8Vy4o8qJov4C2lZz
         wpmJQ0/Xv3cGimAwVSUCXnUY2IOSQBesru73KnHTxE3AQcerwQbhvC1GRWwYzF4/y1YU
         v9eXErPYR2rXulWhh5nnHvhGi9xyHNBh/niKOd+Q5DUCfARZ4x0rwaRtmwf8qg5wwivS
         cNY57Tt541LK4uS3kZ74bZv66CSR6Rel0sH5bgEJGss7o6nzcnQrOZ0YlC2rUNAuoPpk
         MzbXX/ohJ8rQDn3mph91ghcvm5NgojZeU8VGGlq6+/nf35Le/rozn5Z9ExdaDtjii8ux
         2FAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767870400; x=1768475200;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bRRthK53UX6LOkjCTrjT1p312kfkJFJyixNlmbYAffA=;
        b=uC7jHK26PujXskEdhKFDRtnHnj1VVvrGx2icTJxisVh8QCBZpGeDp5HZQ1c3h3yv6k
         y+13Jwc//HCTiVss+Fa6TfvP9tr8t/1MdibvaL4b0m/YVnlmPpdwRuJN71OF8res0EVP
         M/Q7CszZSVi21OVCgxdrRU4ON3zgzx6ZO0wZDZGcJz3frcHZkQ5EWnW5EFZtb6Z9v17O
         TZQrG6e95SdBxOstLLZJggV3xerY7jh+owQfLAgCOD6pr8GTxNKG0E8mXVTGQ6ILsYf5
         4HXXel+zH3kmKaAv1Lh1BFSbgAwjVDt1Kl7gWsC79vF5wr51A2yWMbfG0/Q7+eAZ4K0m
         nT6A==
X-Forwarded-Encrypted: i=1; AJvYcCUuDsVor1tvh0D/GrAoCw7JtU5n579jJR6ScO56140gXaOQbLs2EERF7siWDGfx2I7HyF5RZw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzLziOXsL5SM42EFcREeBOTuteZselLNpIY/gUtTlcbFPA5hYAB
	jZgy3EGj/fcJG+05Ch0PgqGrtMMRFPA4Yw8dEzkCQgEvD1qkzSInIWdUve9c4S7xBQ==
X-Gm-Gg: AY/fxX6uWMlBRb+pyOIfJKaX5zPqR+bj0xz8O6yMS2Oqqd7jtdt+eq56SAjmdureVja
	/EY2bTkwDIrkxhhcv5MsC1ZTYr34FGXinor88YQaBxUlHbyXmf3Xw5JXVBNN8112BCjvhuW+vvv
	tNZm8uP/VWzMIQv330uYk+FIYvZD5BUdBVC3N/7/dMbQs3at5evA+RbbZ7GFulZtaOgPl5LiMEr
	Rmq/Qz7JpBOT24MenA/wDIihqxu5fbg6K/LLQRVSUO4lcRi0e7kvF6NEyjgZmD4CDEIOhwgzVZP
	Hnj05uA7v08+b1cWgxIGMgBRL+mSLl4xHtxBs071d3uqxgkebYjcdMMVW6EJhYPR+ZLY4+WBaGh
	quPsQ6cT1e2tFIa4J5RvNFfC8rbnjjvZNJ3AFX/ervPPz6LltlXUHO4MX23BFMbcv2fNHKl7d2I
	IcnoaoUZstow1+GDqY0LC5Ij3lDwYLQlvyRhwJ1Q13EziFPJ9TwauEioRQN4EBprE=
X-Received: by 2002:a7b:c003:0:b0:477:95a8:2563 with SMTP id 5b1f17b1804b1-47d8ac3e453mr325285e9.14.1767870400033;
        Thu, 08 Jan 2026 03:06:40 -0800 (PST)
Received: from google.com (171.85.155.104.bc.googleusercontent.com. [104.155.85.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5df9afsm17122474f8f.24.2026.01.08.03.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 03:06:39 -0800 (PST)
Date: Thu, 8 Jan 2026 11:06:36 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, corbet@lwn.net, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, akpm@linux-foundation.org,
	vbabka@suse.cz, surenb@google.com, mhocko@suse.com,
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, rppt@kernel.org, xiaqinxin@huawei.com,
	baolu.lu@linux.intel.com, rdunlap@infradead.org
Subject: Re: [PATCH v5 3/4] iommu: debug-pagealloc: Track IOMMU pages
Message-ID: <aV-PvBqQ0Ktiha8e@google.com>
References: <20260106162200.2223655-1-smostafa@google.com>
 <20260106162200.2223655-4-smostafa@google.com>
 <aV56BWisUQTMK2Gk@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aV56BWisUQTMK2Gk@google.com>

On Wed, Jan 07, 2026 at 03:21:41PM +0000, Pranjal Shrivastava wrote:
> On Tue, Jan 06, 2026 at 04:21:59PM +0000, Mostafa Saleh wrote:
> > Using the new calls, use an atomic refcount to track how many times
> > a page is mapped in any of the IOMMUs.
> > 
> > For unmap we need to use iova_to_phys() to get the physical address
> > of the pages.
> > 
> > We use the smallest supported page size as the granularity of tracking
> > per domain.
> > This is important as it is possible to map pages and unmap them with
> > larger sizes (as in map_sg()) cases.
> > 
> > Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  drivers/iommu/iommu-debug-pagealloc.c | 91 +++++++++++++++++++++++++++
> >  1 file changed, 91 insertions(+)
> > 
> > diff --git a/drivers/iommu/iommu-debug-pagealloc.c b/drivers/iommu/iommu-debug-pagealloc.c
> > index 1d343421da98..86ccb310a4a8 100644
> > --- a/drivers/iommu/iommu-debug-pagealloc.c
> > +++ b/drivers/iommu/iommu-debug-pagealloc.c
> > @@ -29,19 +29,110 @@ struct page_ext_operations page_iommu_debug_ops = {
> >  	.need = need_iommu_debug,
> >  };
> >  
> > +static struct page_ext *get_iommu_page_ext(phys_addr_t phys)
> > +{
> > +	struct page *page = phys_to_page(phys);
> > +	struct page_ext *page_ext = page_ext_get(page);
> > +
> > +	return page_ext;
> > +}
> > +
> > +static struct iommu_debug_metadata *get_iommu_data(struct page_ext *page_ext)
> > +{
> > +	return page_ext_data(page_ext, &page_iommu_debug_ops);
> > +}
> > +
> > +static void iommu_debug_inc_page(phys_addr_t phys)
> > +{
> > +	struct page_ext *page_ext = get_iommu_page_ext(phys);
> > +	struct iommu_debug_metadata *d = get_iommu_data(page_ext);
> > +
> > +	WARN_ON(atomic_inc_return_relaxed(&d->ref) <= 0);
> > +	page_ext_put(page_ext);
> > +}
> > +
> > +static void iommu_debug_dec_page(phys_addr_t phys)
> > +{
> > +	struct page_ext *page_ext = get_iommu_page_ext(phys);
> > +	struct iommu_debug_metadata *d = get_iommu_data(page_ext);
> > +
> > +	WARN_ON(atomic_dec_return_relaxed(&d->ref) < 0);
> > +	page_ext_put(page_ext);
> > +}
> > +
> > +/*
> > + * IOMMU page size doesn't have to match the CPU page size. So, we use
> > + * the smallest IOMMU page size to refcount the pages in the vmemmap.
> > + * That is important as both map and unmap has to use the same page size
> > + * to update the refcount to avoid double counting the same page.
> > + * And as we can't know from iommu_unmap() what was the original page size
> > + * used for map, we just use the minimum supported one for both.
> > + */
> > +static size_t iommu_debug_page_size(struct iommu_domain *domain)
> > +{
> > +	return 1UL << __ffs(domain->pgsize_bitmap);
> > +}
> > +
> >  void __iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys, size_t size)
> >  {
> > +	size_t off, end;
> > +	size_t page_size = iommu_debug_page_size(domain);
> > +
> > +	if (WARN_ON(!phys || check_add_overflow(phys, size, &end)))
> > +		return;
> > +
> > +	for (off = 0 ; off < size ; off += page_size) {
> > +		if (!pfn_valid(__phys_to_pfn(phys + off)))
> > +			continue;
> > +		iommu_debug_inc_page(phys + off);
> > +	}
> > +}
> > +
> > +static void __iommu_debug_update_iova(struct iommu_domain *domain,
> > +				      unsigned long iova, size_t size, bool inc)
> > +{
> > +	size_t off, end;
> > +	size_t page_size = iommu_debug_page_size(domain);
> > +
> > +	if (WARN_ON(check_add_overflow(iova, size, &end)))
> > +		return;
> > +
> > +	for (off = 0 ; off < size ; off += page_size) {
> > +		phys_addr_t phys = iommu_iova_to_phys(domain, iova + off);
> > +
> > +		if (!phys || !pfn_valid(__phys_to_pfn(phys)))
> > +			continue;
> > +
> > +		if (inc)
> > +			iommu_debug_inc_page(phys);
> > +		else
> > +			iommu_debug_dec_page(phys);
> > +	}
> 
> This might loop for too long when we're unmapping a big buffer (say 1GB)
> which is backed by multiple 4K mappings (i.e. not mapped using large
> mappings) it may hold the CPU for too long, per the above example:
> 
> 1,073,741,824 / 4096 = 262,144 iterations each with an iova_to_phys walk
> in a tight loop, could hold the CPU for a little too long and could
> potentially result in soft lockups (painful to see in a debug kernel).
> Since, iommu_unmap can be called in atomic contexts (i.e. interrupts,
> spinlocks with pre-emption disabled) we cannot simply add cond_resched()
> here as well.
> 
> Maybe we can cross that bridge once we get there, but if we can't solve
> the latency now, it'd be nice to explicitly document this risk
> (potential soft lockups on large unmaps) in the Kconfig or cmdline help text?
> 

Yes, I am not sure how bad that would be, looking at the code, the closest
pattern I see in that path is for SWIOTLB, when it’s enabled it will do a
lot of per-page operations on unmap.
There is a disclaimer already in dmesg and the Kconfig about the performance
overhead, and you would need to enable a config + cmdline to get this, so
I’d expect someone enabling it to have some expectations of what they are
doing. But I can add more info to Kconfig if that makes sense.

> >  }
> >  
> >  void __iommu_debug_unmap_begin(struct iommu_domain *domain,
> >  			       unsigned long iova, size_t size)
> >  {
> > +	__iommu_debug_update_iova(domain, iova, size, false);
> >  }
> >  
> >  void __iommu_debug_unmap_end(struct iommu_domain *domain,
> >  			     unsigned long iova, size_t size,
> >  			     size_t unmapped)
> >  {
> > +	if (unmapped == size)
> > +		return;
> > +
> > +	/*
> > +	 * If unmap failed, re-increment the refcount, but if it unmapped
> > +	 * larger size, decrement the extra part.
> > +	 */
> > +	if (unmapped < size)
> > +		__iommu_debug_update_iova(domain, iova + unmapped,
> > +					  size - unmapped, true);
> > +	else
> > +		__iommu_debug_update_iova(domain, iova + size,
> > +					  unmapped - size, false);
> >  }
> 
> I'm a little concerned about this part, when we unmap more than requested,
> the __iommu_debug_update_iova relies on 
> iommu_iova_to_phys(domain, iova + off) to find the physical page to
> decrement. However, since __iommu_debug_unmap_end is called *after* the
> IOMMU driver has removed the mapping (in __iommu_unmap). Thus, the
> iommu_iova_to_phys return 0 (fail) causing the loop in update_iova:
> `if (!phys ...)` to silently continue.
> 
> Since the refcounts for the physical pages in the range:
> [iova + size, iova + unmapped] are never decremented. Won't this result
> in false positives (warnings about page leaks) when those pages are
> eventually freed?
> 
> For example:
> 
> - A driver maps a 2MB region (512 x 4KB). All 512 pgs have refcount = 1.
> 
> - A driver / IOMMU-client calls iommu_unmap(iova, 4KB)
> 
> - unmap_begin(4KB) calls iova_to_phys, succeeds, and decrements the
>   refcount for the 1st page to 0.
> 
> - __iommu_unmap calls the IOMMU driver. The driver (unable to split the
>   block) zaps the entire 2MB range and returns unmapped = 2MB.
> 
> - unmap_end(size=4KB, unmapped=2MB) sees that more was unmapped than
>   requested & attempts to decrement refcounts for the remaining 511 pgs
> 
> - __iommu_debug_update_iova is called for the remaining range, which
>   ends up calling iommu_iova_to_phys. Since the mapping was destroyed,
>   iova_to_phys returns 0.
> 
> - The loop skips the decrement causing the remaining 511 pages to leak
>   with refcount = 1.
> 

Agh, yes, iova_to_phys will always return zero, so the
__iommu_debug_update_iova() will do nothing in that case.

I am not aware which drivers are doing this, I added this logic
because I saw the IOMMU core allow it. I vaguely remember that
had something about splitting blocks which might be related to VFIO,
but I don't think that is needed anymore.

I am happy just to drop it or even preemptively warn in that case, as
it is impossible to retrieve the old addresses.

And maybe, that's a chance to re-evaluate we allow this behviour.

Thanks,
Mostafa

> Thanks,
> Praan
