Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658BB38A736
	for <iommu@lists.linux.dev>; Tue, 17 Mar 2026 20:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773781150; cv=none; b=Rq5FkV391I/M/vplzh/5XeSDXB+/FCV+FRlP0tPSfwadrEjLaVwkpmqUndLowg/AEk4D1OaUF41mzcCxEsFyaKR05rzBqRUndkhTMhs/Ka6dPZcFdUKgdhgOFy08bKkcbAkdJTGdiYttTpFPgqAZ6RGHc1lW7w06pqxexaOtkFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773781150; c=relaxed/simple;
	bh=Gg0x70YeYeS/hvsK6d03WDxTrHh/HV8HIwkK82kwBL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uv0yJ5Li5XCEh6jGIYSRnlDGD1WwZWqhhx884OQrGsa3jak8m42QXRuUt6dGpdl5CmADlCWpRa5wlnWsz5Oi4Cj6RPnHt3Btq9rKjR6AAcWFae7QTyVTgfmj3z8IfpsOQ8SAXMZZrRAB4SVpbiWdjgugzzXQ9OpEm1COh8A6MK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SohEy1Ti; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SohEy1Ti"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b052ec7176so8985ad.1
        for <iommu@lists.linux.dev>; Tue, 17 Mar 2026 13:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773781149; x=1774385949; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XXz7CkkQTRz+WIdQ5aQKBGXyXXsdoAFd36PRskCjU8s=;
        b=SohEy1TiWAs/OoE/RuqgJj/BpmrYdwTptfot/qLId9jfqrWTamhm+MDAlo4v8ZI6Uf
         gr10+qBnOWyV1VNwjM5Vc7cEh533xPemOazxdYrSA2lfCdDh8gNEcqdfI1td7+iBP+gs
         KZl0DM8w/1ujMBsG6C59/Amg8IewG5za/H4rb74qvCDmV3CZz4EgSGaAsPIl30LYFjxo
         Sqd/QiOBCrM9mdxnV/XllDSRgRhECx1DWB1alFTbZaQ34yxhffscH0XbVsj6WcYS3IUN
         IgbPtaZaeQ/LyMlb0SEvB/nXYwNK60a5Hlzfq/26AzZjx1h2g48eyataGCLE/WT3Y7+x
         jrhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773781149; x=1774385949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XXz7CkkQTRz+WIdQ5aQKBGXyXXsdoAFd36PRskCjU8s=;
        b=oOJZez5A+CuNd6gmNLDgSFxTLslYn4kBw+/SdTU5J9oQA+9IT8UdzRr4542rE3jdz8
         6cdCC8pChEvRnpodSz6D+rTyXA2mdN0TQCOR3Z5BfoElrixs1DX7+xrXvbALgMZkPWeW
         99XELjPX5o0yHJBRxtpBqSz6tcG3Q7az6yq0yfzSqx4y+T/cMU+0zdAUaiVb5Tjwx6/5
         nlmKAjUyYLe47tn6wsZ7pRjgRoVvp8RNSo77EmdnCG2ajuBm0Q7S5/b6zfjOUs6FN/au
         iIg/qpljOW8ecP5RDEfjww1LqHx+ezeFseEiyeHPRaXFJ4OCPn8HRhNoAgNJSFLt0wj/
         HxAg==
X-Forwarded-Encrypted: i=1; AJvYcCXKk8dE9uAO6aK7W3KW6VzBJyV0qF+Sq2kdtAH04RkkaS50pZANIAEIHs0164U46f+COB/6cA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx09rEVL2Z9b9gYzIoJ8Rerae9gJIFl0G18TDQugA5nn8aOffoz
	PQv7PsWHTiifhjEjoKPZndcGscaVqmD7Mu/1m2WwSbW3gLmcclJYr4DhwzdNoEBANg==
X-Gm-Gg: ATEYQzwZ/855vJfciR88++3nK6x2reLeGwKo7InLOXdWnVK82IIqHflClYkNiFLN/fe
	9F+OEy3hVBIiaaj17a4fcvTH4k4L3pEIjzjKwYDFTKUCT44lg9XjRz7po4+Y/yXB4d+GrwvWBNO
	9uzxCTlKdTV12jZevwnqtwAC9dzkTdPzwFHewx9OhlD5+EIhIZtG6wqlotmeSzj5Go1c2q+5lvA
	BVLdQwFLkwuNlLFGFVrIT5CVRvNtewfJSjcYnOfd0nfeVb0DVrjSCsBQK7XxcLymR8Ww7nl0rZ9
	4rrscETPkXiGUhOmmrHI/E/7KlQB0x2mkzoXg1UTer/KVamwM9j2WZVMM9M16hjvQkL2gxhJiNC
	8m4embBIiuLu5yggVaVlR0CyvHSZdvdkAxkT80xb8RnBJ1p9faPygOlWiA0Fpa+VlhY6WdxOLK2
	MUJWnD3aCvysus/BainRHetTnas2vyVqC1X9vzK6Fvo+l8C0lpUqCfDnShzQ==
X-Received: by 2002:a17:903:184:b0:2ad:6f9b:3b2e with SMTP id d9443c01a7336-2b06f8b55c8mr253645ad.23.1773781148322;
        Tue, 17 Mar 2026 13:59:08 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bee9a14sm357119b3a.53.2026.03.17.13.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 13:59:07 -0700 (PDT)
Date: Tue, 17 Mar 2026 13:59:03 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 04/14] iommu/pages: Add APIs to
 preserve/unpreserve/restore iommu pages
Message-ID: <20260317202925.GA2582517.vipinsh@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-5-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203220948.2176157-5-skhawaja@google.com>

On Tue, Feb 03, 2026 at 10:09:38PM +0000, Samiullah Khawaja wrote:
> +
> +void iommu_unpreserve_pages(struct iommu_pages_list *list, int count)
> +{
> +	struct ioptdesc *iopt;
> +
> +	if (!count)
> +		return;
> +
> +	/* If less than zero then unpreserve all pages. */
> +	if (count < 0)
> +		count = 0;
> +
> +	list_for_each_entry(iopt, &list->pages, iopt_freelist_elm) {
> +		kho_unpreserve_folio(ioptdesc_folio(iopt));
> +		if (count > 0 && --count ==  0)
> +			break;
> +	}
> +}

I see you are trying to have common function for error handling in
iommu_preserve_pages() down and unpreserving in the next patch with
overloaded meaning of count. 

 < 0 means unpreserve all of the pages
 = 0 means do nothing
 > 0 unpreserve these many pages.

It seems non-intuitive to me and code also end up having multiple ifs. I
will recommend to just have this function go through all of the pages
without passing count argument. In iommu_preserve_pages() function down,
handle the error case with a "goto err" statement. If this is the way
things happen in iommu codebase feel free to ignore this suggestion.

> +EXPORT_SYMBOL_GPL(iommu_unpreserve_pages);
> +
> +void iommu_restore_page(u64 phys)
> +{
> +	struct ioptdesc *iopt;
> +	struct folio *folio;
> +	unsigned long pgcnt;
> +	unsigned int order;
> +
> +	folio = kho_restore_folio(phys);
> +	BUG_ON(!folio);
> +
> +	iopt = folio_ioptdesc(folio);
> +
> +	order = folio_order(folio);
> +	pgcnt = 1UL << order;
> +	mod_node_page_state(folio_pgdat(folio), NR_IOMMU_PAGES, pgcnt);
> +	lruvec_stat_mod_folio(folio, NR_SECONDARY_PAGETABLE, pgcnt);

Above two functions are also used in other two places in this file, lets
create a common function for these two operations.

> +}
> +EXPORT_SYMBOL_GPL(iommu_restore_page);
> +
