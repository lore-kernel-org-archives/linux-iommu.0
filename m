Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9FF4570D8
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 22:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789423830; cv=none; b=WUjLaCS/zF4d0xNHDit4IaU2+UZTKKeutiMPZzFLHwTFvCyK4rzFJlGZLmTiNDFF0ySU7/BlkvH0LjB8Klk1EN3RX2prqzevp4qek9BX+I1sWT6somke62UTQhYCAkXppAcVK5mcciXjrBl2r+evRmTcFZOiJFeTLdub2cs8n5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789423830; c=relaxed/simple;
	bh=gLzjztUBh8eUXFB5ZGRmFKOT+KaN6m6lVeXdcVVl7OY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPRwnPO/chCb21Qxw6FmrNO2vZl9QXIJcmRZKth1jcHSZGyANVaiRcOpBLl54+iKQ6sIJiYyCjZpPUcfSxeCq4LppggkzBlWYH+aXdmUJ92WOLejuhB4bTlHQIMlyzQ5RP7D7r6awuoX1eBL6sZ67RoHEy/Oec6s6imAXwJWR5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=VC1YUGO9; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VC1YUGO9"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-90e8e70fa02so49599266d6.3
        for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 15:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1789423827; x=1790028627; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=J3XZNUGEs58um27ogp+l/DHH3zgdwh/5Gz7nOI7x+eE=;
        b=VC1YUGO9oNaUXEMWpWMU81zBVKRtn4JnMRzFAzoxBsR/H7LkCmQGFroDqFNtOB+JAb
         wKWVtpb4IO8n7q6pJP2hVdRFknVxfdjvZtxtctO8FK8cyaWuJ1FYFtlVhNZIeK9C0JzV
         C+icPEa1kvN0RgYsM0z9UMrKojxMYzjY6wimX+JoZW2PFv6UhTndzAyJgdT5Tg+zo4TF
         Vb1Uv/sL9dSnK3rnmSIntf2wdIC86WuekOIfKHW7rZboDSyLPHOg47tRHIdlXkXV/4/W
         IM4YazLBZrTWIPCSlmx0YuFiOGNDUbne0gr+48vBJLq5x6R0p+3m6ROyQix7gr7pUYtN
         oqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789423827; x=1790028627;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=J3XZNUGEs58um27ogp+l/DHH3zgdwh/5Gz7nOI7x+eE=;
        b=KqJdX26+h3DE7CFTI85MWtHSqH7/L8wLCvk/rSWdruwTI35x514oa/GVcKvf9k42a/
         NxEMY7qcOrecGM8TgMoHTYBltp+Ok5yilTkqWauSFmDz1xpoPrqTggq653JgpS2/gt36
         Ia6ZB8zbon5Nc3HI5IJ5YgcMsHSVOQdM+qWtpa41cVxCb/2ExAayaxpURv1psVzKDuCt
         +QD5xi8PdMqBcY81JaQrcScDPPDL/Qc4kvxS1yriolBohifTCxSWhfRkoN35CGjd6kfG
         XqCx9XZl8bgp2fD5jJN/2lJ55Tfc7UzXsqcIEiSXzrHT9sWDoaYGhH2KTMr2QyQ+jPMH
         kLkQ==
X-Forwarded-Encrypted: i=1; AKwUvBz21l0pMaRgT8zpJUveKZrQPP/8Hh1gCqYFuYm4iUhq64RvPuevI8J7JoLp5rfJ4wH2G9JG7g==@lists.linux.dev
X-Gm-Message-State: AFuF++lLcUAzP1jRDWsJkVT9eCIYyqYmwqO/JmhWvYtqe9OYjc3wpOtE
	B7euGt6FMuegcBBHM8hm9TTS7/3+NzeJ7csI41FdnAbPU0wmFxN3X7oJfq9jkjRDmp8=
X-Gm-Gg: AYBFou1Xzy/N2DUk447vk47hnkUt3tR0/bQaTpUa3WoE7hUztH6ER9DKBIra6xabIBb
	cQ80kOGF9NiXTdfScsNYY+jPVO9Bvwhj2HGQ34O47hbjsfGbcL4OpLMR1OJFKl4fx3yzQdpmqwj
	31J9K2tgEvRJMveW0HqLZWEXSfGDevQHN8dhPC6gE2Xj6GQwWCPQVKbW5A/qaImwlPeo700CS9L
	0ZM+nz7Q0PKLDcVtpZPBrMaij4oIo7wnC1ToL17i1E4mnGgzmv8mlH2rnkRVbR9V/u1Y4Oj1A7d
	4Reed4EW+o+kJmLN6kKUNDJ+MgMGmiDCtki5YB5AuZO17SxsqncGJseYlHbqubZvyi5gF4GkKg9
	EwhADFhu1RMewU3DCeoFxCC0DlRl/ivnZ65pn/ILSI28x9u7BoGIT3don2a+PoEfdJsCd61yqyN
	H52rSuF5Fmku0ByVnTRnacNaUg4NGOtJhkEoSyFj1P5AsOgVHlMg56QUF0mkUVYG02SsQAjiJP+
	kdUzj5A29AvemUcShLzsq9zxdce92ZLOnvgep47FgBbub+u9DqnalJtHdnjAYWIJEo=
X-Received: by 2002:a05:6214:2243:b0:90e:9ac5:bfc6 with SMTP id 6a1803df08f44-9122e52dcdamr78819906d6.24.1789423827222;
        Mon, 14 Sep 2026 15:10:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f45ab7csm105588756d6.15.2026.09.14.15.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 15:10:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x6Esb-00000002Idd-3vnk;
	Mon, 14 Sep 2026 19:10:25 -0300
Date: Mon, 14 Sep 2026 19:10:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sumit Semwal <sumit.semwal@linaro.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	iommu@lists.linux.dev, Tushar Dave <tdave@nvidia.com>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-rdma@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH v6 17/18] dma-buf: Let importers ask how peer-to-peer
 traffic is routed
Message-ID: <20260914221025.GA3196566@ziepe.ca>
References: <20260914-fix-p2p-acs-v4-0-v6-0-5ef07ec9ef06@nvidia.com>
 <20260914-fix-p2p-acs-v4-0-v6-17-5ef07ec9ef06@nvidia.com>
 <d3fb7ea0-019f-4311-bf0f-00d25bdebda0@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3fb7ea0-019f-4311-bf0f-00d25bdebda0@amd.com>

On Mon, Sep 14, 2026 at 04:27:00PM +0200, Christian König wrote:

> > +enum pci_p2pdma_map_type
> > +dma_buf_p2pdma_map_type(struct dma_buf_attachment *attach,
> > +			unsigned int tlp_flags)
> > +{
> > +	struct dma_buf *dmabuf = attach->dmabuf;
> > +	struct p2pdma_provider *provider;
> > +
> > +	if (!dmabuf->ops->p2pdma_provider)
> > +		return PCI_P2PDMA_MAP_NONE;
> > +
> > +	provider = dmabuf->ops->p2pdma_provider(dmabuf);
> > +	if (!provider)
> > +		return PCI_P2PDMA_MAP_NONE;
> > +
> > +	return pci_p2pdma_map_type_tlp(provider, attach->dev, tlp_flags);
> 
> Calling PCI subsystem functions from dma-buf is a hard NO-GO.

This is why I had the mapping type arrangement able to know if a PCI
path was involved so it could activate PCI support for that path. In
an extendable way so other interconnects could also provide their
unique knowledge too.

> I shouldn't have allowed the mapping functions to be added to
> DMA-buf in the first place, all of this belongs either into the DMA
> layer or the exporter.

DMA layer is not the place to form dmabuf's corrupted
scatterlist. This must only be done in dmabuf.

We don't want to open code this common logic in every exporter, it
needs a helper. If you have a better place where to put the thing that
makes the dmabuf unique broken scatterlist, then I'm open :) HCH isn't
going to accept anything like that outside stuff hard wired to dmabuf.

> We should probably have a single callback the exporter provides to
> fill in a structure with PCI specific information for a mapping.

Yeah, that is where I was going.

I'm really sorry I haven't been able to come back to that mapping type
series. Were you feeling positive about that? Maybe Leon or someone
can pick it up from me. I was optimistic about scaling back to just
the maping type negotiation as a first step

Jason
