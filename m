Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E896C1EABA2
	for <iommu@lists.linux.dev>; Fri,  8 Nov 2024 15:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731078152; cv=none; b=eXoinIz/mG0r+4SQpEsr4UOaVXFQ/7CiBXEwFHLbtDjEThek/gbTq34jeYtT9ijn3v7pQDkluaFLhZ2OFatp9i28+s3iltLkx6i6m8/tSB6yqGstA0gOqaWNhsdLfA8feGK12PfmKepk2D2Sm2tXCU6BB9geDE0Dw2+9FJnHioY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731078152; c=relaxed/simple;
	bh=IxhOLucIOyD3NJcUrGUU7C5jfdypTBHb2lCNw7COT0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aD0BBVMkvFH4cCxdCHv7uZ9dwxP0zV0ifULusM61fLB4lR3JLcMijNJo5Q0FnYji5gDKAcREEb8brtqvLHSiMdTjJa05QqNh+1lT1mlypkULfxNTG3Mjb0E7A2NvstbQr+IxAYc1PRdbMyYhpcrEobJP1FcKdtzSB835UGLLNuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=e+nm/t8L; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="e+nm/t8L"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-460ad0440ddso12495211cf.3
        for <iommu@lists.linux.dev>; Fri, 08 Nov 2024 07:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1731078150; x=1731682950; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hubkZwx3K6QSYt4MPDN5HJUCdcIscdXdSF4J6blze28=;
        b=e+nm/t8LLO9WYo2Jd/egkADlJXH2thR66SQAMWfvnSZsy4HXIWSfZFBshbwv8SiTHl
         e8lt0hMhJp/F6NZ6nfv1dXFA4rgQyhBf/6nhdMtWCxGO18vXncz8vvDcgxL3Eex5YL3I
         YixBTyYIGNrJYY7GaigAy/SkjXVFWpXYwXHF3kTlFoca+UEf81o6+uQOK8ceaWAiDrC1
         ChNV/8HQjTAE9rJijFkxvR/60wLrLUL26u+jhfY117C3efDScvQ24xr0rvUPseQBOEgR
         pYZ3t2Omr5/Tud94c7xNHUj9MDDeieHAHq9jVW8j85tuKs0v5+MEMWQ4iyaiYQo+b9YB
         REig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731078150; x=1731682950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hubkZwx3K6QSYt4MPDN5HJUCdcIscdXdSF4J6blze28=;
        b=DlaUemMuRgV8/qWCVddbjNvtZh7o0j+s5PsR27Dt7HEnBMIHyTwOcfSOXki9/Dbspr
         CDFv/FAH/dsHxupfCDi/NTvlHkY96BCuyOtMLxEfpv4FPcxpDBumCq4VQZEEtKjle0On
         L+X6xAOrKYZMIAgJPF7zwofQFCv+qtBgfkll34vOOIPk7Eder+/BH8zN+w3/zFX+GPTk
         8W7kxF2dgCYdUmKcAPUkYkD0n69Hb6tj/jDA1p1cfllI7XUbBN+V/ES3JVksArIPX5o5
         sscPviZPw2ddUFOpO3BlJEOfRR/UDZ5xOzsuMBOD9iUqJXgiQox03pizLPDHCS1n+x0P
         Uwbw==
X-Forwarded-Encrypted: i=1; AJvYcCUzicv2iyh+fQye4ZuFidLPQxjGMGI/gNthI8l5Q006SwuKkoigC5JoqOGSPG/LQebBEjszDw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzbnGZkYX26BWozFNP4zX1kCCgMXa3DI82eloZ7bwzHYizklCmN
	Klk+vURL7YlMUGM+LwxG5xzyrzdI/dtp559xMeLNP3HFc6ANfKNQc5L57gVnwcs=
X-Google-Smtp-Source: AGHT+IHrKrTFhKn6qkYBk/Mpkl+n+kU6F5VUVqIGxdFUtkBdvXhYcgcHiG/stLr7VzGEyxS593kC3g==
X-Received: by 2002:a05:622a:1a92:b0:461:17e6:27af with SMTP id d75a77b69052e-463093698f2mr35032151cf.28.1731078149644;
        Fri, 08 Nov 2024 07:02:29 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff3df53fsm21177001cf.8.2024.11.08.07.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 07:02:28 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1t9QVG-00000002ZlF-2kIP;
	Fri, 08 Nov 2024 11:02:26 -0400
Date: Fri, 8 Nov 2024 11:02:26 -0400
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
Message-ID: <20241108150226.GM35848@ziepe.ca>
References: <cover.1730298502.git.leon@kernel.org>
 <3567312e-5942-4037-93dc-587f25f0778c@arm.com>
 <20241104095831.GA28751@lst.de>
 <20241105195357.GI35848@ziepe.ca>
 <20241107083256.GA9071@lst.de>
 <20241107132808.GK35848@ziepe.ca>
 <20241107135025.GA14996@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107135025.GA14996@lst.de>

On Thu, Nov 07, 2024 at 02:50:25PM +0100, Christoph Hellwig wrote:
> On Thu, Nov 07, 2024 at 09:28:08AM -0400, Jason Gunthorpe wrote:
> > Once we are freed from scatterlist we can explore a design that would
> > pass the P2P routing information directly. For instance imagine
> > something like:
> > 
> >    dma_map_p2p(dev, phys, p2p_provider);
> > 
> > Then dma_map_page(dev, page) could be something like
> > 
> >    if (is_pci_p2pdma_page(page))
> >       dev_map_p2p(dev, page_to_phys(page), page->pgmap->p2p_provider)
> 
> One thing that this series does is to move the P2P mapping decisions out
> of the low-level dma mapping helpers and into the caller (again) for
> the non-sg callers and moves the special switch based bus mapping into
> a routine that can be called directly.
> 
> Take a look at blk_rq_dma_map_iter_start, which now literally uses
> dma_map_page for the no-iommu, no-switch P2P case.  It also is a good
> use case for the proposed dma_map_phys.

It is fully OK? Can't dma_map_page() trigger swiotlb? It must not do
that for P2P. How does it know the difference if it just gets a phys?

Jason
