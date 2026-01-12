Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6043A357A5D
	for <iommu@lists.linux.dev>; Mon, 12 Jan 2026 13:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768224782; cv=none; b=OqS7+kSnEY+G2YdmOntBq8OMiy51QedzVZCv+sfH0iis9b7nf69T7ou/P3R4xZ2sAWOVFU0z13imuX7kYsCMi9Jx1knYZ/uj7fhR4oi+yXD7vWM18d6PXkpCnD1Lp7lgkm1euJjkpZ2Js1ZK+wRwpDV4MunM8XKRj/8zZJ27cNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768224782; c=relaxed/simple;
	bh=spIsHBCK0TroQP2RO6KacsvLhnr36XzfF5LeCNxh2qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQpi15uBmqc91obqdnMysrzE3Ajl7J+l9vsRNO7nesfoL94wCDqkNmGlessQFbbQkBTHvE+uMohbDCWznb5mof6WiWLFs/BpIKDBUNx4npULjGLtGNNgoM3W2eRp5EGMlAssx0KjduR9dno/5XprjL7Uja8xX/4UZooEBSRwyBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AlZCsYAc; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AlZCsYAc"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ee257e56aaso58456061cf.0
        for <iommu@lists.linux.dev>; Mon, 12 Jan 2026 05:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768224778; x=1768829578; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/3OlMjXUkwUyc3rlyrTigWpD2j2oxQCnKlM2MHwQt6I=;
        b=AlZCsYAcgHDAoQi0eAm7VObj0PTho/2bzTXeu/ezd2iQDFil4BSRsSc5v+wRCaMWNA
         2MvQr3Y/8EP4JKCOIC2aqhVCyX9xUmMmfJkPuHbYCvxkHH7T0itLNDbjmXTER5lr8Z/f
         LowI0s3IGE52p06ixpIW1jkx9nBw9MW/qj7iOMmOaW7YGsNg0+YMOpEWylJc6jHfwTdJ
         KV6KnXyL5hTVWJaXcKWek18xQVMmiKSZtFFYzrHDg9GDnT5QE/iRnY0Mu1NpyxnBD10E
         6DlokSrUnr41Qb1amKcCbkB7XENrxjqadtTzzYRAqetGNpudMVZTMcYdOjaxJbvGzJmA
         g1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768224778; x=1768829578;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/3OlMjXUkwUyc3rlyrTigWpD2j2oxQCnKlM2MHwQt6I=;
        b=P7Zvk9aev1lm6uxT6gqVeOjzBFVhzYGHF33HIfy8bHpkGWZMMcfDhGNphzthGE6sOo
         qUGCbQXyDXDxQzuQWoMCNz6Mlv69VjKisz/G5MzFA3/PPl/NH5NyhnurrKSbvWp979xR
         TZYx6qRWx5S6w0vTFjgagmkLxHHgLHgf5toLVhJIy6Gppq4WmcMd2QtKNYLmGUAbeDmD
         lwGrFDWbAuhTs8BI7/9P15ElH1lWe3PQnIgdJqAG606iS48j/zRmrOBUJYmdd17/ki7k
         6vIMyYG0CcRl8FYA7ff94WGrefk1r2ngwjuy+j2Ajwufsgv7Iw4EMyXAPezfgAROlSp4
         GWpQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3/7I5P5DFtySm1ZDqbc41qpRBv6uABbt/FV3Ua7UA+YLzOoydkluQOpvHCoFnfDJyuaGoZw==@lists.linux.dev
X-Gm-Message-State: AOJu0YywgN4JFTlSYGaeznFeBTLo8Kas1WS3htt7P+92fueisr2eR8ia
	oNL1bwPy77F+Ti64yDR0kdVrgn7lWsJQ2vPJuSz4FFg5bkPoaL3ufagxVsjFEqD4MyEVAuDIN/p
	EFO/c
X-Gm-Gg: AY/fxX4NPTvR4OWTvfUlrXK9CppBP0QmmyOLPfM8W36AoojYO2u5IrKLhcaleGXbEr2
	inTQEB8W6F4NYz54G17+23y+E6Z98WTqIXZu07WqvU/pA9BX6uSqf3xFgxpTQB1AirmGpS/3x/H
	joAWAYCF4Omfgs6r/rAMTC8oH/jmBzLE4tz4PBL+7/QWlcZQ2ftLISi59NhZ5x26x2EHdYJEP5U
	4CnLj7lEuik+I+wBfAUpql5zJldkrB87xnVtkq1XfWUx2VIPREUdeOqkMZZgmsNxMhhMHB1ilyx
	JAXn4jA0eAE7CTf/U7MEMIR9nNT9b9ynHYHs9DcLIMq0j3ich2bvmK5cOIU8ggAXK9CDqL+JBgd
	ka6UIMncFEYSrpczuvXWRvTuHe5GFAcK5Ij6r2vthWX3gbiJl7v2eDrEEkZkzNaJ8xZ6Ie/WbhT
	U3by8SgFF2fWAxZOzKTBeU+oOPh5OtL3xfVICwTDgHWkKwU4h2cPtm4IxymAkzdkVfzssesOJyf
	w2KsA==
X-Google-Smtp-Source: AGHT+IH4Dcu7h+OOktsvfMPjqqK1/8N0YWz6dlKvurnb+htQMqLWJDpjuBE6cizrKIHyOmLaaemzrw==
X-Received: by 2002:ac8:7592:0:b0:4ff:beb1:cb9f with SMTP id d75a77b69052e-4ffbeb1cbd3mr144089361cf.40.1768224778294;
        Mon, 12 Jan 2026 05:32:58 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffaac486efsm127185781cf.27.2026.01.12.05.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 05:32:57 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vfI2S-00000003Pwo-2w95;
	Mon, 12 Jan 2026 09:32:56 -0400
Date: Mon, 12 Jan 2026 09:32:56 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, corbet@lwn.net, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, akpm@linux-foundation.org,
	vbabka@suse.cz, surenb@google.com, mhocko@suse.com,
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, rppt@kernel.org, xiaqinxin@huawei.com,
	baolu.lu@linux.intel.com, rdunlap@infradead.org,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH v6 3/4] iommu: debug-pagealloc: Track IOMMU pages
Message-ID: <20260112133256.GB745888@ziepe.ca>
References: <20260109171805.901995-1-smostafa@google.com>
 <20260109171805.901995-4-smostafa@google.com>
 <20260109195111.GQ545276@ziepe.ca>
 <CAFgf54r_au6isA10Nrve=MHL455X=tKhNsSwH1ej-TX08J3xLA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFgf54r_au6isA10Nrve=MHL455X=tKhNsSwH1ej-TX08J3xLA@mail.gmail.com>

On Mon, Jan 12, 2026 at 10:20:14AM +0000, Mostafa Saleh wrote:
> On Fri, Jan 9, 2026 at 7:51 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Fri, Jan 09, 2026 at 05:18:04PM +0000, Mostafa Saleh wrote:
> > > +static struct page_ext *get_iommu_page_ext(phys_addr_t phys)
> > > +{
> > > +     struct page *page = phys_to_page(phys);
> > > +     struct page_ext *page_ext = page_ext_get(page);
> > > +
> > > +     return page_ext;
> > > +}
> > > +
> > > +static struct iommu_debug_metadata *get_iommu_data(struct page_ext *page_ext)
> > > +{
> > > +     return page_ext_data(page_ext, &page_iommu_debug_ops);
> > > +}
> > > +
> > > +static void iommu_debug_inc_page(phys_addr_t phys)
> > > +{
> > > +     struct page_ext *page_ext = get_iommu_page_ext(phys);
> > > +     struct iommu_debug_metadata *d = get_iommu_data(page_ext);
> >
> > You cannot do this - phys_to_page() can only be called if we already
> > know that phys is a struct page backed item and by the time you get
> > here that information is lost.
> >
> > Probably the only way to resolve this is to somehow pass in an iommu
> > prot flag that can tell the difference between struct page and
> > non-struct page addresses.
> >
> > But I have to NAK this approach of blindly calling phys_to_page().
>
> The callers to this, first will check "pfn_valid", which is the right
> check AFAICT (looking at similar patterns in page_owner for example).

I'm not sure pfn_valid really works in all cases, it has a number of
exclusions that can be relevant when phys_addr_t can be a MMIO
address..

So far we haven't been using it in the DMA paths at all, I'm not so
keen to see that start..

Jason
