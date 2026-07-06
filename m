Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F43636C9C2
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783349150; cv=none; b=Xpi4gurlFUffZcrFxWOzvFrKHmcH7OhgAjsF5TqcQD22iEcF769e92A07dHhUeM/SXk0fYrlFesPTMFvZeMEM2oLMPELNck/kxbIAZ2OadfMxxR9r5gyafbPZpH7XgP8Xdjzt/l/xInR2loFuQo298hSWcOb7oqJ/nBiS4dvz1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783349150; c=relaxed/simple;
	bh=GEmwnbo5c01HyyyzuH8OU56k0hHaHfD4fV/rszJ3/QQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYisfrNQwa9+sOTjFwj9F+F8L2aYUshrFW3YCatnSWYh9XlOKZVdmsuNy3wj+OoCQGBZEnN8D7Uic3uF9dorVtG4HdSp0AiAfdeu3AN/+hugjzQa6+rWnsfa6Dctnanxpw+Kng1qX4cL18RwvII9ek1L2szA2o/u5Ee9p7DQ5Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=SH/F/fFb; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SH/F/fFb"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e622cc874so160245285a.0
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 07:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783349148; x=1783953948; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RchAVTABW35/nVIIB7DpmvWo5jCT1UuX99uA5TkjSRU=;
        b=SH/F/fFb5ly1NCjQ72yQFY4LqnKHd7iWoQ8URI5sEmnVf+uHUT6yaacK2ogEx3qybX
         y8Igns55w257wEZHRnHTlK63hspSK70BTL0qB6gast8np1eXj9HHq7TNl8WHL8MJc7/j
         6j97XQdw3t/aJYuL+Jk1ufGOiooGCo3p9rjmrpdiq+R3ssji8vstxbaru+ltYKolXnF1
         1KOvP4oq1ByLfQEQjT2oHIIywR5VoYbTO2xxEA95r8lokQAnhOHzBr3ZjH/eCrie2/1r
         abBRm/4jpOQ/AYujCrylMFiidykEScJ7makO2btuy+iz8SxSZpX9Cp/09xWxGzjDxLwq
         lbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783349148; x=1783953948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RchAVTABW35/nVIIB7DpmvWo5jCT1UuX99uA5TkjSRU=;
        b=nyv+Tl54UYz40q4M5Sh6eUOdyiVTDjtMDYmB+v6Q+iIpEXZCn+DK79qF02a63uOq2E
         Aa66vB5mbvl5/JHckysr/khGQ7p1J1JE6qsDUAeBUvqPBf79jtYUK5TQ2utvWfLE3bsP
         YYFswo+oCnJjpdLvbSGZ986sUMKFK2fRydEEm0pra0Clcg15zcHIis26XbvWvf9iaxRb
         UGo9JcDHge8BNJjLE8nErcBL8TfBmRrQ14jbPdgayDIgStuNrh7TxjB5mElqJgliQZJ/
         7zWVPX0aZ1V3EbB3pjT0H1pmhD9UqMQ3+q6AUNYoF1z1gGPwE4LKgcoG7uPLCjUWLkzg
         nrFA==
X-Forwarded-Encrypted: i=1; AHgh+RpxlqwZ0+KAgjkHUQkmaT5YYteSj656XhQZJ5T/oCsB/ZjZ8YFOD4zZRgt/k4hgo1SGS22fKA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxVRi4pWUPfr3oMj34A2SlHujni6RDyA4eQLEPuB9ZMhDm18LNa
	FdvTVBURGbAa5/m+AapKMjnUlDEsL1Z4XAD+Vu3AlZgHBka+MvbKipbPok6LpURkOqg=
X-Gm-Gg: AfdE7cnU4pvagCUiNaDh0EUjhCnLhdtDLOfox0UWQilAQbzMvEB2ekrL4dJQjOIax8A
	p9E6kUBRUyLAsKMSvyRY1yeXUOqVeScim+ySwX4H/qVsv/VQ/NmMW4ChRQx6Nm7pKWqiij8Varg
	/pg+PTAQtiThPE6pgRTcodBO1QLp35TrN0ePTrfCNJsnMkLV4vr28OnSz+v7oRQOb1iePpZe32d
	IS7nAz3Qi56knWJ650Z706Itgtb3Such4mkI0fVmVn6vzITTOrNYCBTSRfU+1wBxhSyU4Nh0pgA
	1OXmQm4Xt8ue+mAYkU1etANaHTDnCOZVvo0AzFzefeUEtxDPTa45r1yUMCLcwCTicCfIh+GJOhj
	LJsgv0bB/ZDQ9bG2ZMKIpbbqp/d33/fpzvk2jGAbSeGvdUKjdM5mAp6J1iv+4
X-Received: by 2002:a05:620a:8390:b0:92e:8fa8:829b with SMTP id af79cd13be357-92ebb4ef994mr126892085a.24.1783349147658;
        Mon, 06 Jul 2026 07:45:47 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90ba4209sm1003534685a.12.2026.07.06.07.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 07:45:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wgkZu-00000000UJc-23xW;
	Mon, 06 Jul 2026 11:45:46 -0300
Date: Mon, 6 Jul 2026 11:45:46 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Krzysztof Karas <krzysztof.karas@intel.com>,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev, Andi Shyti <andi.shyti@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	=?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>,
	Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
	Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
	Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v2 3/3] drivers/iommu: Catch scatterlist length overflows
Message-ID: <20260706144546.GE107792@ziepe.ca>
References: <20260701104437.236979-1-krzysztof.karas@intel.com>
 <20260701104437.236979-4-krzysztof.karas@intel.com>
 <20260703162236.GX7525@ziepe.ca>
 <90558ba3-44e6-4d5e-9c72-ed8817d372be@arm.com>
 <20260703203502.GC1978949@ziepe.ca>
 <a381d265-e7a4-4fe7-9421-3553706d41c1@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a381d265-e7a4-4fe7-9421-3553706d41c1@arm.com>

On Mon, Jul 06, 2026 at 02:08:14PM +0100, Robin Murphy wrote:

> modern use-cases anyway, and is being replaced, so limitations of a "legacy"
> API that don't have any meaningful impact to its existing users are hardly
> something to panic about. If DRM does want to be able to *reliably* map
> massive amounts of RAM then it can adopt the new IOMMU API, for this and all
> the other reasons that that new API was promised to be "better".

Yes the new API does solve these issues, and it avoids padding
destroying the iova contiguity.

> > So I wouldn't be quite so dismissive that this is not something a real
> > user can hit.
> 
> I'm not being dismissive - clearly it can be hit. My point is that anyone
> who *does* hit it can only expect it to fail (as indeed this particular IGT
> test seems to), because it has never worked.

Today you can allocate memory from hugetlbfs and map it through
RDMA. The user can set 1G hugetlbfs page size and allocate 16G of
memory, and RDMA map it. Databases and HPC, for example, love to do
work loads like this.

So there is an unlucky hugetlbfs FD that has an internal memory layout
that will build a scatterlist that cannot be mapped by the iommu.

The user's application that normally works will fail randomly and
infrequently for no fault of their own. This isn't "can only expect it
to fail".

> So yes, limiting any individual segment to <=2GB would end up avoiding both
> those conditions, but it would also impact plenty of cases that *do*
> currently work fine, e.g. 1GB+3GB+3GB. The limitation is really that you
> can't have two consecutive segments where the first starts exactly on a 4GB
> boundary and the sum of both their sizes >=4GB.

Yeah, but that's hard to express.

My feeling was supporting >2GB without a split is not really so
important. You are (righly) arguing these huge sizes are usually rare.
Places like RDMA where they are not rare people already added
re-assembly logic to join SGLs so HW optimizations for >= 4G mappings
can be used, so smaller splitting doesn't really matter.

> > API wise I expect any arbitary input to sg_alloc_table_from_pages() to
> > result in a scatterlist that iommu_dma_map_sg() will map. This
> > patch highlights there are cornere cases where that isn't true, it
> > should be fixed..
> 
> Technically sg_alloc_table_from_pages() carries no such assumption,
> only

There are lots of callers that just do sg_alloc_table_from_pages()
then dma_map_sg(). Callers can use this simplified API when they don't
need any segmentation logic in the DMA API.

> sg_alloc_table_from_pages_segment() (or __sg_alloc_table_from_pages()) with
> the correct dma_seg_boundary value for the given device. 

_segment is the segment size, not boundary. The sg_alloc_table
functions don't support the seg_boundary limitation.

So, how about instead of failing we just don't do any padding? Ie
ignore dma_seg_boundary, and hope the device is modern and doesn't
need it?

Alternatively, can we request to disable dma_seg_boundary somehow in
the driver and stick with the WARN_ON?

Jason
