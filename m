Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2F420AF6C
	for <iommu@lists.linux.dev>; Wed, 19 Mar 2025 17:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742407124; cv=none; b=BA0OV6flTsN04B190GFxRkvEIdivbP1+tIKQVMKGHWqnTmtFLNu0LDegaMovTl2HGhAcJdqqV22v4kcq6NCXjnjK7LRXvW5GHEtXpVwtZGGBp4AwQJhULO8vhzBKm49AcyJsrhJgfsjstb1Cm0HjSa8tprsROlH5VXs5SkBYA6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742407124; c=relaxed/simple;
	bh=O1aeb0KFlrkj4Yiw1nWYiPzizeq56+6Mn3GDJKk7WrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqSCf9xEfppRrlgkAIbht10ur8YDrOCIp9gQdzD7GnCTG4kwCWlyFhDRi1bW2asPsGAJhi9A7DbZ+gvcGZZ4Mufru+nl5J/f8NscXBwBFI3up8f3d5d8alFvTzvmOApqnY/kxeFZIbd9BVqfor21hQfGziHpmqSZcW6in6Yv9B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=biLOm9iV; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="biLOm9iV"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c542ffec37so707132185a.2
        for <iommu@lists.linux.dev>; Wed, 19 Mar 2025 10:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1742407121; x=1743011921; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tk5ycb3N9meE73NCm46CD0AtZuFHAdivFMZfwt24RPU=;
        b=biLOm9iVf8ogjxm0VUfCCAqsYuRCHUDgPoNRBmfiXugz/YTcAlTYXI9x9mNFuBOSPx
         QHl3N8Al+p6a2XqSIoPtdjVKQKJCmjgdssagQ0vN6VzFaFj+HzX3J11T/SGVAKj2Iiay
         0hLNsFkEjC6pILi0YePcon0NppodC8JAYnuP4t57shOYb0NGsSa4rHDfEWbldOMtnkJB
         42ZtCLAvWh8ZtczOj4ZGroOfgWSPAoC3y+2dEEZy+D2zr1OJiYu+31Qwr2/QokAc9zbO
         Q25C1FhhHIHEJgan2Zq4+8B/dtcAkY+CYciOcLho6A7QUt/b3+3g/3gBkYPcfupgm/Uh
         7ToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742407121; x=1743011921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tk5ycb3N9meE73NCm46CD0AtZuFHAdivFMZfwt24RPU=;
        b=sybKz6rF+HzVue5j1LMEUJWDhP4yMLm2LpkmFHE2UNHrdx3I+gb1jHud1k6uRUHP3e
         9hAPHsPMGylWKHpHH2dN5CNb9TatHfG30Fcs5yLoo4/9OlinpYl/e+kvELOeo1EfjlRF
         lRNkw8yN2IeuExMCr1TmIdACqiMXSv4d11EmuaL1VhtWTLwpWXzXcxzyzhLOw9eF6aFF
         iA7IOTzKK5FB7MDIGwsboneoHG7HWPs/9KY4+0vQFKyTsLQuox6H/AwwajpZM7IJgVbG
         P/bnM8TGFDontszBjtPK+AkNyqVluH4QeN/JYzslHH1roMW7NIKyO/7Tr+wXGhW/dU6K
         ydcw==
X-Forwarded-Encrypted: i=1; AJvYcCXNQXewKfegkXwVbtvOccF5F9RbY82NMq4BoSS8VbMVyQbtlPufdfP0c192aHRdZlqIbuRMsA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+y6rc3KJw23SMnmC+TB99DhM8bNvcnLfSYKJPRrypKOdw7RJ/
	WtBSEIEPn7tiZ2ROSpPLx/4Ysuk3NcXrw9gOeMPH9fAtivxJrZDdJeQJXkpu5mg=
X-Gm-Gg: ASbGnct2Vn6b2VLOEaGTKjAbaYH2esH/Z82clNS+11jDu95cw+wML1BlMz8Yidzie2j
	jsjGDEJmdnPg2bBHXAjek9qgHOL7g8BVo250W7qfAJFkzDu5BHu1ZW4i08XbGhmHxaYqh3F9JP/
	+OaAcFbarUkXUCwG+omon38hTmxDKOQYrHeIFzMeXyVkOj6KzVktswBZ51yhnEynAHwed0ajqpK
	VIWAO/W1TGEK8pxCFkmFTjcLpX5xSLKU0HfmZV3zU+TdKyd5UsoK70DM2yPUoqK27DLTI6OqivR
	w+/CaiCeAFQvl0JXtUdoYPBWCD4wdWnbxFaL7HIfTxqwq1wYEWd9+mzzO3LIMF1fFMtUF8dCA2z
	/RKQHepXF8h6HaQzxaA==
X-Google-Smtp-Source: AGHT+IH//pIx1EBbRFqDU6QPhXC6odo+Ppd2dshOt/mNgQMR0e3nRHsssO7Vo2UonDgQd/fB3+YCbw==
X-Received: by 2002:a05:620a:3189:b0:7c5:5154:cb2 with SMTP id af79cd13be357-7c5a839688cmr568357985a.15.1742407121681;
        Wed, 19 Mar 2025 10:58:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573d8a62asm885096585a.96.2025.03.19.10.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 10:58:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tuxge-00000000Wns-1mXJ;
	Wed, 19 Mar 2025 14:58:40 -0300
Date: Wed, 19 Mar 2025 14:58:40 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Leon Romanovsky <leon@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v7 00/17] Provide a new two step DMA mapping API
Message-ID: <20250319175840.GG10600@ziepe.ca>
References: <cover.1738765879.git.leonro@nvidia.com>
 <20250220124827.GR53094@unreal>
 <CGME20250228195423eucas1p221736d964e9aeb1b055d3ee93a4d2648@eucas1p2.samsung.com>
 <1166a5f5-23cc-4cce-ba40-5e10ad2606de@arm.com>
 <d408b1c7-eabf-4a1e-861c-b2ddf8bf9f0e@samsung.com>
 <20250312193249.GI1322339@unreal>
 <adb63b87-d8f2-4ae6-90c4-125bde41dc29@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adb63b87-d8f2-4ae6-90c4-125bde41dc29@samsung.com>

On Fri, Mar 14, 2025 at 11:52:58AM +0100, Marek Szyprowski wrote:

> > The only way to do so is to use dma_map_sg_attrs(), which relies on SG
> > (the one that we want to remove) to map P2P pages.
> 
> That's something I don't get yet. How P2P pages can be used with 
> dma_map_sg_attrs(), but not with dma_map_page_attrs()? Both operate 
> internally on struct page pointer.

It is a bit subtle, I ran in to this when exploring enabling proper
P2P for dma_map_resource() too.

The API signatures are:

dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
		size_t offset, size_t size, enum dma_data_direction dir,
		unsigned long attrs);
void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
		enum dma_data_direction dir, unsigned long attrs);

The thing to notice immediately is that the unmap path does not get
passed a struct page.

So, lets think about the flow when the iommu is turned on. 

For normal struct page memory:

 - dma_map_page_attrs() allocates some IOVA and returns it in the
   dma_addr_t and then maps the struct page to the iommu page table

 - dma_unmap_page_attrs() frees the IOVA from the given dma_addr_t
 
If we think about P2P now:

 - dma_map_page_attrs() can inspect the struct page and determine it
   is P2P. It computes a bus address which is not an IOVA, and does
   not transit through the IOMMU. No IOVA allocation is performed. the
   bus address is returned as the dma_addr_t

 - dma_unmap_page_attrs() ... is impossible. We just get this
   dma_addr_t that doesn't have enough information to tell anymore if
   the address is a P2P bus address or not, so we can't tell if we
   should unmap an iova from the dma_addr_t :\

The sg path fixes this because it introduced a new flag in the
scatterlist, SG_DMA_BUS_ADDRESS, that allows the sg map path to record
the information for the unmap path so it can do the right thing.

Leon's approach fixes this by putting an overarching transaction state
around the DMA operation so that map and unmap operations can look in
the state and determine if this is a P2P or non P2P map and then know
how to unmap.

For some background here, Christoph gave me this idea back at LSF/MM
in Vancouver (two years ago now). At the time I was looking at
replacing scatterlist and giving new DMA API ops to operate on a
"scatterlist v2" structure.

Christoph's vision was to make a performance DMA API path that could
be used to implement any scatterlist-like data structure very
efficiently without having to teach the DMA API about all sorts of 
scatterlist-like things.

Jason
