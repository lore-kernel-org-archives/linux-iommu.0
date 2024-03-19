Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6783A24B2F
	for <iommu@lists.linux.dev>; Tue, 19 Mar 2024 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710870870; cv=none; b=c55AwQ2qmWyLKsQPLfepNfjD7vDziNRij1RgFCumunmY2UAyjlWeClmCg48n2avrw9yUHIZEzgm0soUayJSvkGk+M+eLkRT/ShQVq7uaZ18He8pS/riD7fzessIaPnuyVg2Ks/ToxpaIk14IkX7VZ7CG4kEM5XfGT1UrZ0h6HAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710870870; c=relaxed/simple;
	bh=Ao9hwGJl4g/w2wap7dwa291kK0JPcDjzl89BAK46zVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlcqCx4Z6NjIOcR2RdkzbZwJaLmG/XKopeq+Auo9ht3wIKFSh6zed9sX9iR9pUeftQG9bWCvXObaTMxQWCaREHPUt8+Sd/q5I8324fgtKu+LHSdfrBcnTPYzr7HeRIecDfVwWoEkmVjPPKt5xU6WHHNVc2w6w9DbnB3MND4jTDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=eLuKUrl2; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eLuKUrl2"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c38f4e18eeso1113415b6e.1
        for <iommu@lists.linux.dev>; Tue, 19 Mar 2024 10:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1710870867; x=1711475667; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D7H3WfkclcieHpBg89GTkZxaS3r7II1qq9xezXi0hVM=;
        b=eLuKUrl2MDhZn6iiWvju5BbjqrDZSe8Q5y4eY+/v1I6YFIRpaJFWNpaTFTXScoEBo4
         1Swbw4M+S1hfUxBtj4Gvj1ydKHTXRCpYXJt8s32v5ESrqSHPXokI6dzAV/xrc48luvy8
         WMOgqR1mED6FGxgugI68/vtYHAFnVOvOGFHViaFMTzJUd/F/gXCUfFgI80WmMjryVjoe
         f14nQMpL0S9aXl2Ju6IW8hOqaWH1JGTALCwCYTC49CHegoS1c08LflWuxUzTyeBTxkJ5
         /t3Ix7+hHxLJVoEdsQVTx/EU3QsaYyc4/LJvwanpiG4HuOk4xtep/YRrfdRy6VNUWaIg
         YFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710870867; x=1711475667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7H3WfkclcieHpBg89GTkZxaS3r7II1qq9xezXi0hVM=;
        b=LTJQoR+vTQjgC3P36bOQxjFrifM4XXbWO7twtsgg9kHsn5pXPuClMCibv/uxyFuQhu
         HiItsckNaOGnTJ5P/OX4xaAzfxU7RagxliarPLa7bx7jve98KTLYN3loJxyM2zhFNgfj
         5RceYLBqUMtig1T3jMHquA1ele7Qg4BhrXhG+Ka88DrJsWQoqmoB/9b32o1dKl+/+hUN
         4roQbJtBIlqDAM5jlHCwQO12rVbOfUhzYnt6wPQ4euhfGf/BmpWHt8ebuDL0DB8ELCTR
         pPJjp9l7OFh8hHdrvdNunMECBlbF5D7vDiFMp7K39C9vqHpt7fMnjene4525wzFrvu5f
         lucA==
X-Forwarded-Encrypted: i=1; AJvYcCUH3IKqX/mUu019LHRvjvMSV+4a9GhGh1Sk/lx0CgqNbpbvy0Nyw7LYincZkCxyUl5kIx0g6pdirL0iZ46Y0VQkIUSdMnU=
X-Gm-Message-State: AOJu0YyAu06Qm9AipPF024qi8zKH5UYNX5Bx+2x4xX3fhakJPrr0LLGa
	DW/OkJ9g6T6YzpDC+RGCTlQJ4mAqLuKUHrNWCA2AmZoUgsETkeEt1gGkbnCLrWg=
X-Google-Smtp-Source: AGHT+IFEKHu8FJxVRb4YxsELWM46dNSxNuN3njm0tBeD+R+fEyp1j8c0yaDa2gTZMCaYT5fxKBzgBQ==
X-Received: by 2002:a05:6870:d20e:b0:222:99cb:2215 with SMTP id g14-20020a056870d20e00b0022299cb2215mr3580439oac.28.1710870867581;
        Tue, 19 Mar 2024 10:54:27 -0700 (PDT)
Received: from ziepe.ca ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id gh11-20020a056638698b00b00477716fcbb8sm2429986jab.40.2024.03.19.10.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 10:54:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rmbVk-001elO-4L;
	Tue, 19 Mar 2024 12:36:20 -0300
Date: Tue, 19 Mar 2024 12:36:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Cc: Leon Romanovsky <leon@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	kvm@vger.kernel.org, linux-mm@kvack.org,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Amir Goldstein <amir73il@gmail.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	Dan Williams <dan.j.williams@intel.com>,
	"jack@suse.com" <jack@suse.com>, Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [RFC RESEND 00/16] Split IOMMU DMA mapping operation to two steps
Message-ID: <20240319153620.GB66976@ziepe.ca>
References: <20240306154328.GM9225@ziepe.ca>
 <20240306162022.GB28427@lst.de>
 <20240306174456.GO9225@ziepe.ca>
 <20240306221400.GA8663@lst.de>
 <20240307000036.GP9225@ziepe.ca>
 <20240307150505.GA28978@lst.de>
 <20240307210116.GQ9225@ziepe.ca>
 <20240308164920.GA17991@lst.de>
 <20240308202342.GZ9225@ziepe.ca>
 <20240309161418.GA27113@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240309161418.GA27113@lst.de>

On Sat, Mar 09, 2024 at 05:14:18PM +0100, Christoph Hellwig wrote:
> On Fri, Mar 08, 2024 at 04:23:42PM -0400, Jason Gunthorpe wrote:
> > > The DMA API callers really need to know what is P2P or not for
> > > various reasons.  And they should generally have that information
> > > available, either from pin_user_pages that needs to special case
> > > it or from the in-kernel I/O submitter that build it from P2P and
> > > normal memory.
> > 
> > I think that is a BIO thing. RDMA just calls with FOLL_PCI_P2PDMA and
> > shoves the resulting page list into in a scattertable. It never checks
> > if any returned page is P2P - it has no reason to care. dma_map_sg()
> > does all the work.
> 
> Right now it does, but that's not really a good interface.  If we have
> a pin_user_pages variant that only pins until the next relevant P2P
> boundary and tells you about we can significantly simplify the overall
> interface.

Sorry for the delay, I was away..

I kind of understand your thinking on the DMA side, but I don't see
how this is good for users of the API beyond BIO.

How will this make RDMA better? We have one MR, the MR has pages, the
HW doesn't care about the SW distinction of p2p, swiotlb, direct,
encrypted, iommu, etc. It needs to create one HW page list for
whatever user VA range was given.

Or worse, whatever thing is inside a DMABUF from a DRM
driver. DMABUF's can have a (dynamic!) mixture of P2P and regular
AFAIK based on the GPU's migration behavior.

Or triple worse, ODP can dynamically change on a page by page basis
the type depending on what hmm_range_fault() returns.

So I take it as a requirement that RDMA MUST make single MR's out of a
hodgepodge of page types. RDMA MRs cannot be split. Multiple MR's are
not a functional replacement for a single MR.

Go back to the start of what are we trying to do here:
 1) Make a DMA API that can support hmm_range_fault() users in a
    sensible and performant way
 2) Make a DMA API that can support RDMA MR's backed by DMABUF's, and
    user VA's without restriction
 3) Allow to remove scatterlist from BIO paths
 4) Provide a DMABUF API that is not scatterlist that can feed into
    the new DMA API - again supporting DMABUF's hodgepodge of types.

I'd like to do all of these things. I know 3 is your highest priority,
but it is my lowest :)

So, if the new API can only do uniformity I immediately loose #1 -
hmm_range_fault() can't guarentee anything, so it looses the IOVA
optimization that Leon's patches illustrate.

For uniformity #2 probably needs multiple DMA API "transactions". This
is doable, but it is less performant than one "transaction".

#3 is perfectly happy because BIO already creates uniformity

#4 is like #2, there is not guarenteed uniformity inside DMABUF so
every DMABUF importer needs to take some complexity to deal with
it. There are many DMABUF importers so this feels like a poor API
abstraction if we force everyone there to take on complexity.

So I'm just not seeing why this would be better. I think Leon's series
shows the cost of non-uniformity support is actually pretty
small. Still, we could do better, if the caller can optionally
indicate it knows it has uniformity then that can be optimized futher.

I'd like to find something that works well for all of the above, and I
think abstracting non-uniformity at the API level is important for the
above reasons.

Can we tweak what Leon has done to keep the hmm_range_fault support
and non-uniformity for RDMA but add a uniformity optimized flow for
BIO?

Jason
