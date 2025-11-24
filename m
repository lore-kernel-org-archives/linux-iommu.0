Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1032701CC
	for <iommu@lists.linux.dev>; Mon, 24 Nov 2025 12:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763987860; cv=none; b=Axe0LI6oKS3Hn0pCpPVlfgn4eztwZka/TzTY0sYJ5sBqRMy7aaAaws2STBtj3JhRO2+Sjg+QEAvgsjAFUSJjoYuholh9QoON9Z5aH/tONLqxgnFr6QD6GFjTrUVD8vs1K4Cu9uJmBpnH+EH82F/jbY+TSgRAUfBCtxTQxXQgGmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763987860; c=relaxed/simple;
	bh=xjDttXRS5ImqH6z/aDM7WnkLGLiQh07Ud/MtlyMPsCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLBBapNTyBeB18xRg1bdRHOauaaPHhIPfSprzgzEkYwOmFVoHWJgsRBA1vJTbfVdUuQlS1EON+YhTmGqSfM0ugh1Ytbmk6fLDyXbFyQAYQNqncd5GjWfFvlNt622oLgT4X0Ox2hN/+mCtcV2YnnHVpA0QkCUjuJ8KaH3voCITMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YcrwWjVi; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YcrwWjVi"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4779e2ac121so99835e9.1
        for <iommu@lists.linux.dev>; Mon, 24 Nov 2025 04:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763987856; x=1764592656; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FbelAFcOsYSEHJr61jVue9qL8RZ/6OY7KUqEPYnfD10=;
        b=YcrwWjViy2UkF+DcAwYxu/Zv2HDDjOPiFTBsb5bcVH/wZuyWA1Tul8r32MjRRNEKJV
         0GNH55foMGvmUW57zkU+wpZye8VKIP32beTZzfdyIgUMSNq0BbfRjZa+WzWFXUeylB9s
         ZuUm2Y1sX4oSboeKqwP4OExsdP+QXd6lprb9dSyOiSeaLIzchZ60MukoZLTmt+23UD4C
         bYjuml8MgkM4hUKdTv6CF0iWgRbzqeN9LSzvOJcXU4gB6ZMJ6HNXGWdYbt4dg+r0s5s5
         S4Tl6ijH9iCN21HK3hAgHB9XpfsToDGaijKkcsjiiwsA77MF8sE8S9NmKHfoETCXROxH
         ATuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763987856; x=1764592656;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FbelAFcOsYSEHJr61jVue9qL8RZ/6OY7KUqEPYnfD10=;
        b=SFjMO/qaibLDoGT+QYSZ7aw4sXCCzNrFT7EvuIH/BJNZjaqfAdDlwhnePsFUTSyoCK
         mdmrbHLXUJsHHFY5MFQqzhKAjbljMm7UqCKqF1oYlWHp5OiVFtr0AZLWHHYibp0mRcsz
         ppXaS4OHj+pl+pRqQiiclap/JcQsEfpUPn0oW6nst3eXw1/zOOFzUBTUMCwOrIBiYBhY
         J+KRFojvE0OfzbadADtmRaGzbsTHJTPjhPqcnRq5aYRLpTEo9ZB/m7ilxb2E0omAPyGI
         wlPsHh/G1SvBQfcMQxFNZ2uIk0SwcNiw8yrAeBMtrGrKWZLNst67ayfxF9lOGqbseSGI
         XMYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkJoJkd586R0cwNJhq438ZGV1EOga4dV5kuk7M5v4En/l+PgaMJLAcjpVWdI7tVNWCgt+BPA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywj5J8mvLves4oc5McdK7isT/A0njd4YxtpdRm1nLz7c+FX9mcG
	3FHH6rj5+ThbRC9nOBH2BEZ58rcgMN8fGlmP0Od8StAYqhgHmY50b9u2rgf2J9a1sQ==
X-Gm-Gg: ASbGnctpWO0bVPucj31RiOJqA82APHf6CWAy4PcnMWQPD8YOHKvuYYcMB5EygaWprno
	+OZBO2qHFYKbBGaXv5TlY4VtQ7xZaEPfk7Du4FklpzrkGLMnoGN3YxIhD2cBviLv1yMaENPRiTm
	qat0ir+giacQLJakx32QNqDZ7Fz/0wdCLtOgK1cbkkuui8KPPL3MihY/CkDLquvZYd6Oq2i31Nk
	RzsxRQHsyEnAmvyby1sD1NAuYvV9fc0JFy724CzyPiiKkF6CVsbyIgwaotSkt/q/GuMqTEdDiqG
	otxYMg+67VnBy2gtNkXdei4LpjnysPYnFHAtX3UTajqZ7C21TlRywWkQPzd8dB5A4xl+Oddo2qS
	MpXfgoUrPH4a5hZAN4EFF4LrZdG1gET30kuDFGyDRsPKVKPjbDCSBwXKub3J94UvWirVAMEpPUH
	InbU7nMAyy/iteqbplsUTalnC9pcZanBNqaassLK+X5nYT+MbACrZ2MzsscK57
X-Google-Smtp-Source: AGHT+IEZ1AffknXuVGP8AlyImRjsSfE4J4xB0sAqNDM7r0AApBCqrRJbKEvqzMG4cEc/7c+Lw03Hxw==
X-Received: by 2002:a05:600c:c114:b0:477:86fd:fb18 with SMTP id 5b1f17b1804b1-477c5e09081mr1789195e9.8.1763987855511;
        Mon, 24 Nov 2025 04:37:35 -0800 (PST)
Received: from google.com (54.140.140.34.bc.googleusercontent.com. [34.140.140.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf1e868bsm188617465e9.4.2025.11.24.04.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 04:37:35 -0800 (PST)
Date: Mon, 24 Nov 2025 12:37:31 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Will Deacon <will@kernel.org>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, corbet@lwn.net, joro@8bytes.org,
	robin.murphy@arm.com, akpm@linux-foundation.org, vbabka@suse.cz,
	surenb@google.com, mhocko@suse.com, jackmanb@google.com,
	hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	rppt@kernel.org, Qinxin Xia <xiaqinxin@huawei.com>
Subject: Re: [PATCH v2 3/4] drivers/iommu-debug-pagealloc: Track IOMMU pages
Message-ID: <aSRRizzS39jI3BjH@google.com>
References: <20251106163953.1971067-1-smostafa@google.com>
 <20251106163953.1971067-4-smostafa@google.com>
 <aRW6Tf_G2ObR__vE@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aRW6Tf_G2ObR__vE@willie-the-truck>

On Thu, Nov 13, 2025 at 11:00:29AM +0000, Will Deacon wrote:
> On Thu, Nov 06, 2025 at 04:39:52PM +0000, Mostafa Saleh wrote:
> > Using the new calls, use an atomic refcount to track how many times
> > a page is mapped in any of the IOMMUs.
> > 
> > For unmap we need to use iova_to_phys() to get the physical address
> > of the pages.
> > 
> > We use the smallest supported page size as the granularity of tracking
> > per domain.
> > This is important as it possible to map pages and unmap them with
> > larger sizes (as in map_sg()) cases.
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > Tested-by: Qinxin Xia <xiaqinxin@huawei.com>
> > ---
> >  drivers/iommu/iommu-debug-pagealloc.c | 74 +++++++++++++++++++++++++++
> >  1 file changed, 74 insertions(+)
> > 
> > diff --git a/drivers/iommu/iommu-debug-pagealloc.c b/drivers/iommu/iommu-debug-pagealloc.c
> > index a6a2f844b09d..0e14104b971c 100644
> > --- a/drivers/iommu/iommu-debug-pagealloc.c
> > +++ b/drivers/iommu/iommu-debug-pagealloc.c
> > @@ -27,16 +27,90 @@ struct page_ext_operations page_iommu_debug_ops = {
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
> > +static struct iommu_debug_metadate *get_iommu_data(struct page_ext *page_ext)
> > +{
> > +	return page_ext_data(page_ext, &page_iommu_debug_ops);
> > +}
> > +
> > +static void iommu_debug_inc_page(phys_addr_t phys)
> > +{
> > +	struct page_ext *page_ext = get_iommu_page_ext(phys);
> > +	struct iommu_debug_metadate *d = get_iommu_data(page_ext);
> > +
> > +	WARN_ON(atomic_inc_return(&d->ref) <= 0);
> 
> Is it worth dumping some information about the page in addition to the
> WARN_ON()? That way, you might be able to benefit from other debug
> options (e.g. PAGE_OWNER) if they are enabled.

These WARN_ON are for overflows, which should never happen.
I initially thought about using the refcount_t, but it didn’t seem
suitable as refcount_add() expects that the refcount is already “1”
indicating that an object was already created which doesn’t fit
in the semantics of what this is. Similar for refcount_dec().

In the next patch there is a WARN_ON for the refcount check
to capture the mis-behaving context, I will add a debug print with
the leaked physical address in that case as this is the important one.

> 
> > +	page_ext_put(page_ext);
> > +}
> > +
> > +static void iommu_debug_dec_page(phys_addr_t phys)
> > +{
> > +	struct page_ext *page_ext = get_iommu_page_ext(phys);
> > +	struct iommu_debug_metadate *d = get_iommu_data(page_ext);
> > +
> > +	WARN_ON(atomic_dec_return(&d->ref) < 0);
> 
> nit: I can't see why you need memory ordering guarantees for the refcount,
> so you could use the relaxed variants for the inc/dec operations.

Will do.

> 
> > +	page_ext_put(page_ext);
> > +}
> > +
> > +/*
> > + * IOMMU page size might not match the CPU page size, in that case, we use
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
> > +	size_t off;
> > +	size_t page_size = iommu_debug_page_size(domain);
> 
> Since this is a debug feature, is it worth checking other properties of
> the arguments too? For example, that phys is non-zero and that phys +
> size doesn't overflow?
> 

Makes sense, I will add some more checks.

> > +	for (off = 0 ; off < size ; off += page_size) {
> > +		if (!pfn_valid(__phys_to_pfn(phys + off)))
> > +			continue;
> > +		iommu_debug_inc_page(phys + off);
> > +	}
> >  }
> >  
> >  void __iommu_debug_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
> >  {
> > +	size_t off;
> > +	size_t page_size = iommu_debug_page_size(domain);
> > +
> > +	for (off = 0 ; off < size ; off += page_size) {
> > +		phys_addr_t phys = iommu_iova_to_phys(domain, iova + off);
> > +
> > +		if (!phys || !pfn_valid(__phys_to_pfn(phys + off)))
> > +			continue;
> 
> Hmm, it looks weird to add 'off' to both 'iova' _and_ the resulting
> physical address. Is that correct?
> 

Yes, that's a bug, I will fix it.

> > +		iommu_debug_dec_page(phys);
> > +	}
> >  }
> >  
> >  void __iommu_debug_remap(struct iommu_domain *domain, unsigned long iova, size_t size)
> >  {
> > +	size_t off;
> > +	size_t page_size = iommu_debug_page_size(domain);
> > +
> > +	for (off = 0 ; off < size ; off += page_size) {
> > +		phys_addr_t phys = iommu_iova_to_phys(domain, iova + off);
> > +
> > +		if (!phys || !pfn_valid(__phys_to_pfn(phys + off)))
> > +			continue;
> > +
> > +		iommu_debug_inc_page(phys);
> > +	}
> 
> You can make the bulk of this code common with the unmap function.

Will do.

Thank,
Mostafa

> 
> Will
