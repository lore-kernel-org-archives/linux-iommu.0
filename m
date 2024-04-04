Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BB112882C
	for <iommu@lists.linux.dev>; Thu,  4 Apr 2024 13:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712239015; cv=none; b=F19bW+f3ay9yfl3K8D/3XZNhBh1qIhLly5MVP5wzMoSc8pKJAVD6wBhNCYyNC1as6F8TBbbVB9fP063G4QUc9MajJY+I0ooLIDXYserqq4s5czw6zV/T7O/9FGkx1IIqKT6Zpmhtw3zbsAID6sEuI6V+XBAIToGjUg+bwQsh/OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712239015; c=relaxed/simple;
	bh=dyJ8/jg3OEVZu3rV6eRPJgBUaaPW7kEy4ZucbMmQDWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lEsES9l8vBYtcu7ClOmEiJu20MmonR4DHN29tQs5m476vo4O03ZpGtYVdC8mqFXHYKtk2kFmnV2YzYMJdnyiIObodNoH7dTapMgmum417eCheszbBsmvFYiThNZpuQznaapG2+y/Li3+pcM6LruM5TWQNxWBjz3z3kTK7yH5nuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=jYm83+u7; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="jYm83+u7"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-43446959b33so3811491cf.3
        for <iommu@lists.linux.dev>; Thu, 04 Apr 2024 06:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1712239013; x=1712843813; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=msc9tQgMq343nFV4/DBdPcJS7hGm3uD+5fv8GwkMOjA=;
        b=jYm83+u7HGiOkoYkwajiJQUcNJ94ZYBpTdIhzUPrnuVl6UgDzbUy3QDR6FLVX+zg7w
         MIUIH+gFCxoXtiAFg6GCnewPevAgFbqayxKUBh9C0SLDDo786vlTZEXkxfjq3dch6O6q
         +bbMxkdrm1d1gRIikYwkbBrQg513V/J4Jf8ZAZCaT9H1poTGMm5f6XIDHkADgiuiva9G
         0DP0oRjUMbY4Zp91S5xP9m2sVV7Tpo3BIlXp0Nj2hgQGHkU7XTYhejFL1dFk98XWlwKp
         vbckTWkD2sfRxJO0qJa9qU1ll7M7uW8bA57Nfbak7sHfu/zERxDjdmqhUbxOps8E8rFl
         6owA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712239013; x=1712843813;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=msc9tQgMq343nFV4/DBdPcJS7hGm3uD+5fv8GwkMOjA=;
        b=THg8ON8L24uQ2fiIReCAlvz8e7E0oEr5txny4wEYcmbJbX8Z+vi1sviusg3ghwQXTC
         hsudvwx0jvo4evSVVZsgkzaOoCcQKjZduVTG/0rXrj9FliuGMGh+I4bf/vpb2bdYWbGW
         VCnmC8NJ9mAQ/M+0VjMunKtOdoVQEvLQch7mYNUCNDkBH+5Jz/wu9XTzrpHuZ2dLtB9S
         PTjODhFtHI9smMr7nWSzJgYr3Mwd1qzQcThnp74SjDdLzdTpup8ajc5XNRiFqzVuoPqS
         UeKMJ4G9EoMiSa5EI1WRC/pQARMssGrasGM7R1jQzCGsBW6msgbkOODtPK9vnIrdCtKH
         W3Kg==
X-Forwarded-Encrypted: i=1; AJvYcCVXWeBieV55U95nupuLdTVBtbIEGGwqRE8uDpu52dUjcxD6jncf2E6pWVt8LG/UQZbjFw5nuj39Oy84ggJGN2Ty+6/kiTQ=
X-Gm-Message-State: AOJu0YxzDo9Bbl/TcVnKLLK6q8y5DAdWKyjObHUe6NMtvtJodFvOjjZa
	GZQ35YaKKZ+soyasqr+Gib8TuOhUxW4+OUZnGGCnIgPGs9OCV6P0Mk697dl+UdXGa9ciCVL6g3D
	DWf+T4HOeZlXj3lZnIYBxDZQMkkMvQb6RLmbByw==
X-Google-Smtp-Source: AGHT+IH9S7DU2DIf+z4/lTa3f7DcyJz1Y9kNOGjz2IQr7tohPqSHHhqayAGWHjuk7zhrLKiTZ6wb5Cu4ZzpulPIDrg0=
X-Received: by 2002:a05:622a:2:b0:431:378d:afa with SMTP id
 x2-20020a05622a000200b00431378d0afamr2733138qtw.34.1712239013126; Thu, 04 Apr
 2024 06:56:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240222173942.1481394-1-pasha.tatashin@soleen.com>
 <20240222173942.1481394-2-pasha.tatashin@soleen.com> <20240404121625.GB102637@hyd1403.caveonetworks.com>
In-Reply-To: <20240404121625.GB102637@hyd1403.caveonetworks.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 4 Apr 2024 09:56:16 -0400
Message-ID: <CA+CK2bDmya+768tOvF0N-BYq8E+RwBw4xS8vC+MmbU9eoOv_3g@mail.gmail.com>
Subject: Re: [PATCH v5 01/11] iommu/vt-d: add wrapper functions for page allocations
To: Linu Cherian <lcherian@marvell.com>
Cc: akpm@linux-foundation.org, alim.akhtar@samsung.com, alyssa@rosenzweig.io, 
	asahi@lists.linux.dev, baolu.lu@linux.intel.com, bhelgaas@google.com, 
	cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com, 
	dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de, 
	iommu@lists.linux.dev, jernej.skrabec@gmail.com, jonathanh@nvidia.com, 
	joro@8bytes.org, krzysztof.kozlowski@linaro.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, lizefan.x@bytedance.com, marcan@marcan.st, 
	mhiramat@kernel.org, m.szyprowski@samsung.com, paulmck@kernel.org, 
	rdunlap@infradead.org, robin.murphy@arm.com, samuel@sholland.org, 
	suravee.suthikulpanit@amd.com, sven@svenpeter.dev, thierry.reding@gmail.com, 
	tj@kernel.org, tomas.mudrunka@gmail.com, vdumpa@nvidia.com, wens@csie.org, 
	will@kernel.org, yu-cheng.yu@intel.com, rientjes@google.com, 
	bagasdotme@gmail.com, mkoutny@suse.com
Content-Type: text/plain; charset="UTF-8"

> Few minor nits.

Hi Linu,

Thank you for taking a look at this patch, my replies below.

> > +/*
> > + * All page allocations that should be reported to as "iommu-pagetables" to
> > + * userspace must use on of the functions below.  This includes allocations of
> > + * page-tables and other per-iommu_domain configuration structures.
>
> /s/use on/use one/?

I will correct in the next version (if there is going to be one).

> > + *
> > + * This is necessary for the proper accounting as IOMMU state can be rather
> > + * large, i.e. multiple gigabytes in size.
> > + */
> > +
> > +/**
> > + * __iommu_alloc_pages - allocate a zeroed page of a given order.
> > + * @gfp: buddy allocator flags
>
> Shall we keep the comments generic here(avoid reference to allocator
> algo)  ?

There are no references to allocator algorithm. I specify the zero
page because this function adds __GFP_ZERO. The order and gfp
arguments are provided by the caller, therefore, should be mentioned.

> > + * @order: page order
> > + *
> > + * returns the head struct page of the allocated page.
> > + */
> > +static inline struct page *__iommu_alloc_pages(gfp_t gfp, int order)
> > +{
> > +     struct page *page;
> > +
> > +     page = alloc_pages(gfp | __GFP_ZERO, order);
> > +     if (unlikely(!page))
> > +             return NULL;
> > +
> > +     return page;
> > +}
> > +
> > +/**
> > + * __iommu_free_pages - free page of a given order
> > + * @page: head struct page of the page
> > + * @order: page order
> > + */
> > +static inline void __iommu_free_pages(struct page *page, int order)
> > +{
> > +     if (!page)
> > +             return;
> > +
> > +     __free_pages(page, order);
> > +}
> > +
> > +/**
> > + * iommu_alloc_pages_node - allocate a zeroed page of a given order from
> > + * specific NUMA node.
> > + * @nid: memory NUMA node id
> > + * @gfp: buddy allocator flags
>
> Same here for this one and other references below.

ditto.

Thank you,
Pasha
