Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5842080C3
	for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 10:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294791; cv=none; b=T+hA5XicJ10OudXt6dihtMVJofuWPMZmaiwu0OzX8iVOVw4i5icbNUE0EijIG+tjaf+OQXivClpu1co4ljFsKzGxXlsjGhSoY7MFBcNfPZS6zEMdG0YLqWA6VaHhkbfadKtp9KyP4exiHtVlraXvl6DbAQZBKfyLrEDCTZgjnfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294791; c=relaxed/simple;
	bh=BH/02l/7jfK62esHmL2nQqidEObr1IPIfhlBILiTzRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asqMa1JobQNettePzTQHO5OqgDBkxpOILxPUtK4pLCGfUnvaB4RPFmigAiJSCsxH4t1/vAmEAtwN98oqo4lhuyaGFXSS9OTHvQODl+425nVCCw/HX9ykSQpDSCjuo3zWS32tH9OaybEVj6/FKEblyeY4RBc1d/5giNc/tUTV+J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MXe/Cxhg; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MXe/Cxhg"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-438d9c391fcso44715e9.0
        for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 03:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742294784; x=1742899584; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/+Q9jlO5xuM+dGNN5vOy/zKLThOd0aux5Q2kg9METOQ=;
        b=MXe/CxhgR4YPfXnkNhk2z1cK8G0CgjsERaz3ggQJR5D2FaqIqvXWsvhlq7E/6DNwvA
         2+ZxFFk8DQ5cHnp+wakfRu6aYQ872X0ek9Z5uNkyTUwnlKuaTM+4nIugNOw0f4u0B81/
         iq4JIFDWZM0sx6kE4pIcVmmXuyOUcPIiIgtfCAsw7AxD7SYST9J681V6497UfSJj4BIa
         24Xz91uTgLT+AlyNTYqWYFQgap9ggxyie0F+8lesgl99E3OTpbSnszc4Xl+vv+2UyqY/
         qpZxRd4qJJv1kTZ2XZ4P4Gs8GOorU5QrO8pWVbJsNcTYABRcrTWHSm0bP2uGcN/A7rom
         MC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742294784; x=1742899584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+Q9jlO5xuM+dGNN5vOy/zKLThOd0aux5Q2kg9METOQ=;
        b=srJqHxMYN1QNSAkkw+oKQHNXS6VncO8H0UF36ubFIHAnn88VuaejUqb5eKibUFddqZ
         dstuNGstzSDKuavxwjc8xDmHtVlsuUZrUo2Eb0956dQyMO+zXUunBCUx/KdfpgO7WUqT
         tM9AsRQZRcnAXD1p3cmcU/0kkf50iB066ahW5UPchWYYhGXRKWu+CCPEvCiUS0jZoozH
         2imer3Nz6qL3+MfD93/tfQUiA5AArktajoboFMDJQ503nHnbBbk7Si6YxWnRXfI7Lw+c
         tbtPjMZUhr6KaEw5Ihgzyfz4aEHTSMkFd+XkHgIAIlqXc9x+TEke/ZsyN0dILk/rx/oJ
         pkfw==
X-Forwarded-Encrypted: i=1; AJvYcCVX0WRqMLeWnZFd3/sOFa7XrregQIYHaNNCTLTj+TeQRK23fSNuRbvqquXTpwyXf/CFdlrAAw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwaeM/4Ft0WffKjYY4fMzgryMikCngMT2u6XfR5edd5XCQx2J32
	HzVipwKDR50yboVX+FldUXUbuwcEs0WHYy+TtTYjQXH9HEHBGbw08pxdZP3CaQ==
X-Gm-Gg: ASbGncvGtJorLB5quoIc6ZeXcEdMPHuSvmayh6bN/FxBhsWYrCODJTKX3QuLxpHMBAK
	wV/X7sPKk1wjXPPPxD/EEw4rYtCwMYHftOv4KiYelK5xLGbWQ42R4oYnOMLDv8u41KcjxfrhZ1w
	wQh9CYVShqLbAOpPrAizuoH3+gGAXz/0ior1wV+lRVipLYrDJjs6FJAt+E/kXptOoOJBMLt/AhD
	CFF7XFyvcVeuAT9g4PTT02/zCmsxnaP/XCRawkKyts8qF9Mk+WS2gdT6J96Mt2LGoO05cQqSD8v
	l6UgRj43Mhx5JlrdVo4rZaS5HbtSsJSY85UQyrbodLZcuUcSnDk3xo0WeVTzLwx9hehk8uBUvCn
	lWPT0
X-Google-Smtp-Source: AGHT+IHJJJKc86lCeSfkPHpB/CtXXs0Prp3Nz9+7FXSfTlHmKZ30/6jEnzkR0iwoq3j3jwsYbn5hfA==
X-Received: by 2002:a05:600c:1d20:b0:439:4a76:c246 with SMTP id 5b1f17b1804b1-43d3e14f871mr474575e9.6.1742294783884;
        Tue, 18 Mar 2025 03:46:23 -0700 (PDT)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffbcf00sm129988595e9.10.2025.03.18.03.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 03:46:23 -0700 (PDT)
Date: Tue, 18 Mar 2025 10:46:18 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Albert Ou <aou@eecs.berkeley.edu>, asahi@lists.linux.dev,
	Lu Baolu <baolu.lu@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Heiko Stuebner <heiko@sntech.de>, iommu@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Joerg Roedel <joro@8bytes.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Hector Martin <marcan@marcan.st>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Holland <samuel@sholland.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Sven Peter <sven@svenpeter.dev>,
	Thierry Reding <thierry.reding@gmail.com>,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Krishna Reddy <vdumpa@nvidia.com>, Chen-Yu Tsai <wens@csie.org>,
	Will Deacon <will@kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>,
	Joerg Roedel <jroedel@suse.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	David Rientjes <rientjes@google.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 20/23] iommu: Update various drivers to pass in lg2sz
 instead of order to iommu pages
Message-ID: <Z9lO-viudk9YGakl@google.com>
References: <0-v3-e797f4dc6918+93057-iommu_pages_jgg@nvidia.com>
 <20-v3-e797f4dc6918+93057-iommu_pages_jgg@nvidia.com>
 <Z9GFFBvUFg7a9WEg@google.com>
 <20250317133500.GC9311@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317133500.GC9311@nvidia.com>

On Mon, Mar 17, 2025 at 10:35:00AM -0300, Jason Gunthorpe wrote:
> On Wed, Mar 12, 2025 at 12:59:00PM +0000, Mostafa Saleh wrote:
> > > --- a/drivers/iommu/io-pgtable-arm.c
> > > +++ b/drivers/iommu/io-pgtable-arm.c
> > > @@ -263,14 +263,13 @@ static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
> > >  				    void *cookie)
> > >  {
> > >  	struct device *dev = cfg->iommu_dev;
> > > -	int order = get_order(size);
> > >  	dma_addr_t dma;
> > >  	void *pages;
> > >  
> > >  	if (cfg->alloc)
> > >  		pages = cfg->alloc(cookie, size, gfp);
> > >  	else
> > > -		pages = iommu_alloc_pages_node(dev_to_node(dev), gfp, order);
> > > +		pages = iommu_alloc_pages_node_sz(dev_to_node(dev), gfp, size);
> > 
> > Although, the current implementation of iommu_alloc_pages_node_sz() would round
> > the size to order, but this is not correct according to the API definition
> > "The returned allocation is round_up_pow_two(size) big, and is physically aligned
> > to its size."
> 
> Yes.. The current implementation is limited to full PAGE_SIZE only,
> the documentation imagines a future where it is not. Drivers should
> ideally not assume the PAGE_SIZE limit during this conversion.
> 
> > I'd say we can align the size or use min with 64 bytes before calling the
> > function would be enough (or change the API to state that allocations
> > are rounded to order)
> 
> OK, like this:
> 
> 	if (cfg->alloc) {
> 		pages = cfg->alloc(cookie, size, gfp);
> 	} else {
> 		/*
> 		 * For very small starting-level translation tables the HW
> 		 * requires a minimum alignment of at least 64 to cover all
> 		 * cases.
> 		 */
> 		pages = iommu_alloc_pages_node_sz(dev_to_node(dev), gfp,
> 						  max(size, 64));
> 	}

Yes, that looks good.

Thanks,
Mostafa

> 
> Thanks,
> Jason
