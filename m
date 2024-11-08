Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6BE21A704
	for <iommu@lists.linux.dev>; Fri,  8 Nov 2024 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731080330; cv=none; b=eBCk2Fi1bf5SNMXt5cAh9kOBks84tBAkliF/lH7/iDQeTk3jwAUqkQIZC92ZpMqMuykbAbcgx3SEPFJqtfoO4bbQD+pJxlpclTRqfdr0Tx2yMyV6U4wOpzUw/XtnMBoUgqh5FNHcXZPIOeBcsmJU1yHQtCzGoAdZKtSKtKyTuwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731080330; c=relaxed/simple;
	bh=OaBx3Fh/Km3ELqbio7v031NeuRfzJ9+4kTiWipNjW34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDT/TYddYnpiUsz+FE/ykWlkYRcra4SQAjUaPIQWVWsB6pCPWsszwxVTYADEKT5p4cdNx8WkXxClmPclNSiTHwod497QiISQiMSg5KRmOF49Zm4JoR9/+5Dle3LODNwA4cTHhTCmfc4iJ+3QgJzzRC3CWwR4C48bcZZp9ReaS0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=E+Pa4y07; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="E+Pa4y07"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b15d330ce1so154657085a.1
        for <iommu@lists.linux.dev>; Fri, 08 Nov 2024 07:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1731080328; x=1731685128; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7sMW5Kuv5sIzIjhBbBygI9fJdJpSk6eqM7+xgs0I9dY=;
        b=E+Pa4y07muZEedtk+Cknih/R0hj9nSVHTRq+dINtf7V1/UaTrzgKcUEachYrPEsXv+
         b5Yooxvep0qeyc6F6woH10//qFru2QUz+/lhjMuWb+oUUvbHr+5rwmmTiXAdPITIcLMu
         HSvcV6+Y1gu2MunRm/aC2Io1D+zoQVsbU+rjlAKs51gqpDxt18ZZOK3S4Bjqt7gc+Dhi
         3sXCqpYJSJm6+aIxsQJoYI9z6AeqrER09wJdgiUfaLSTl0InnlV3NcK76P/ORINpH1PV
         bqUe+PDJSk9VVF9b7DQPUHmDg9p79gATvl4rD+iV0FzI+bXUFJLqkt0Btm2irDoLFc5V
         L8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731080328; x=1731685128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7sMW5Kuv5sIzIjhBbBygI9fJdJpSk6eqM7+xgs0I9dY=;
        b=sw/ZGn2isO7g3sTkmFHYvj1iEeT0V3872uY0kVwhxrUVfSvt9U3nN3yq2AX3SWt68O
         Qg3cm7DeJ3Y2xo9eLojFxaiyzlU/3v0661gi5vTWpsZYDDonSwMVjG51DJNRejeSqiXS
         ryFZGklB0hhfxYxCpb+rkoGmE/qFjLNt4WegvA+Vd2v0hIf4ZqB4qJFYfgQ/AafJN4kQ
         g6tR+iuE9a/2PSfEbYFp8d1wETCvof62yFWU/UGelcVrpudg+LHKJi9fSPCTBJYaz/YR
         4ELERCjzo5d4dF9xmz+HHCzkyMlYjcn66TzxeXmTd86i1S2cHfRtCO4EIXJNq52M1tA2
         oloA==
X-Forwarded-Encrypted: i=1; AJvYcCVrM+lQot3APzpg/guebPHJHaYMu0iqG9oq8HeoFibMpKGPWo3gRd2iBUloA4ht5S4t3agHrg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyLhDfcLEK5m7F0b2UH8irevaVrJubZ0xYxhFFwLu/Wo/z74Pp+
	XMh1D3bxJ5G8li+ZAP/np/baoR5eHzxhT2XNP4biGqFad/X2ihb7/BC5hgynVHA=
X-Google-Smtp-Source: AGHT+IHfTg/iLCK5GxrqZ9aoCzAZ7JH1FinF3HAR4KRwwnugOPp1CtA3KrYQyOs3W/lc98NgBjpBFQ==
X-Received: by 2002:a05:620a:1a21:b0:7ac:bb00:cd42 with SMTP id af79cd13be357-7b331dd2d55mr406755285a.27.1731080327649;
        Fri, 08 Nov 2024 07:38:47 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32ac2dd1fsm170869085a.15.2024.11.08.07.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 07:38:47 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1t9R4Q-00000002a9N-29Xq;
	Fri, 08 Nov 2024 11:38:46 -0400
Date: Fri, 8 Nov 2024 11:38:46 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, Leon Romanovsky <leon@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org, matthew.brost@intel.com,
	Thomas.Hellstrom@linux.intel.com, brian.welty@intel.com,
	himal.prasad.ghimiray@intel.com, krishnaiah.bommu@intel.com,
	niranjana.vishwanathapura@intel.com
Subject: Re: [PATCH v1 00/17] Provide a new two step DMA mapping API
Message-ID: <20241108153846.GO35848@ziepe.ca>
References: <3567312e-5942-4037-93dc-587f25f0778c@arm.com>
 <20241104095831.GA28751@lst.de>
 <20241105195357.GI35848@ziepe.ca>
 <20241107083256.GA9071@lst.de>
 <20241107132808.GK35848@ziepe.ca>
 <20241107135025.GA14996@lst.de>
 <20241108150226.GM35848@ziepe.ca>
 <20241108150500.GA10102@lst.de>
 <20241108152537.GN35848@ziepe.ca>
 <20241108152956.GA12130@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108152956.GA12130@lst.de>

On Fri, Nov 08, 2024 at 04:29:56PM +0100, Christoph Hellwig wrote:
> On Fri, Nov 08, 2024 at 11:25:37AM -0400, Jason Gunthorpe wrote:
> > I'm asking how it will work if you change the struct page argument to
> > physical, because today dma_direct_map_page() has:
> > 
> > 		if (is_pci_p2pdma_page(page))
> > 			return DMA_MAPPING_ERROR;
> > 
> > Which is exactly the sorts of things I'm looking at when when I say to
> > get rid of struct page.
> 
> It will have to look up the page from the physical address obviously.
> But at least only in the error path.

I'm thinking we can largely avoid searching on physical, or at least
we can optimize this so there is only one search on physical at the
start of the DMA mapping. (since we are now saying all pages are the
same type)

> > What I'm thinking about is replacing code like the above with something like:
> > 
> > 		if (p2p_provider)
> > 			return DMA_MAPPING_ERROR;
> > 
> > And the caller is the one that would have done is_pci_p2pdma_page()
> > and either passes p2p_provider=NULL or page->pgmap->p2p_provider.
> 
> And where do you get that one from?

Which one?

The caller must know the p2p properties of what it is doing because it
is driving all the P2P logic around what APIs to call.

Either because it is already working with struct page and gets it out
of the pgmap.

Or it is working with non-struct page memory and has a (MMIO address,
p2p_provider) tuple that it got from the original driver that gave it
the MMIO address.

Or it really does have a naked phys_addr_t and it did the search on
physical, but only once.

Jason
