Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1C6353A63
	for <iommu@lists.linux.dev>; Thu,  2 Jul 2026 14:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783003653; cv=none; b=RlYq6kkHb9f9lewiWAnicsuHVu5im7ZjdV7hsgMY0vSFqpJA7av0tGfeH+NALrukygTc22K9WundqKl22bQE+nhOd+3zvf5R7etTiJwedx0+fTlgzwSBzsRx8WPyP+Bk0VlyEEnmHfACcCj908B2wrizWR0WMGQPtHJWd408uUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783003653; c=relaxed/simple;
	bh=wPrLPIkahV/48dLiq8gAC7HDusdQj1NNPVoCnuPpx5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzekqfTQ9zHkmlemHfF0YCcLZ1zTyiFgRU/1zH+5Bfoy41s2G8kMZNBpU00mFXUUEZJMJJ4Au7HUhUMSxpauQAfGTM+tIy+/h/sZ5aa6x5POCy4fGz2FCSDZ1W06Q7BHEG77PPFkBe1humUGp0Lb/PK8Mn6DtL3rg+hmV1J4JHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=e/anwoG3; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="e/anwoG3"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c16ac21acso11595301cf.0
        for <iommu@lists.linux.dev>; Thu, 02 Jul 2026 07:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783003651; x=1783608451; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VHZVkcI1dGlitqBERLzcSZUkSvuExam94MObbuJvLAQ=;
        b=e/anwoG31Hergg0KVEgIbZj5/SqaoWCwXRJNQWcBpbLJtvc7SL+7ktcXjj6+hxVPUW
         hzbx0lKe4w+pvCLT8cJsVaEtyBHnIdKLj20bxiRjlzDK7HVgVagjObGZ1uljB6ka9BGT
         hsoOSgBmdABYIe+ovbxAayzM5yHc+sEmJVzkK9t9RIC/inIdVXIxs1GZlb0UdaoEua3x
         LKaDvPe8d/ctF9vJTs2LhglylsJBRfi94e31fu07YgrbZMClPkYVx8BwbQPrFf2pFLn5
         /o3w0/q16qbRByvBQiSyGQZ+olveDhTGBZu0Bb89d/x1GGZQMCDiKFJukmHIbVftvt10
         jYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783003651; x=1783608451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VHZVkcI1dGlitqBERLzcSZUkSvuExam94MObbuJvLAQ=;
        b=GrHmiiNo2Iq7zUr189g4q8CD0Wefrd5Vs91XSL46XEWQhCmtN9bcYP1HvfAVb2ujJ7
         OseeXzx0eHeDMJXUQON4ZiZU30brwiTCEPiKA0CILgns2tCjHdTfbXcYOU4PoP+3pSrg
         0FD8D+tWaUaZXCU7GnlR/kurBZ3p29aHp/25lHkI/nvDDrjtxnXX5I7fCy+Y3SXD4Mg9
         o+P95L/F7pXUvVyiI3vpO8DU0lcI+D94xzbHw5bcAbkWlpcm4MdE0DIcBwcbYJonl9TT
         0wdsoPBE+nIkbEYm50Y3Wx81xR4zjeX7xuULt8Kn3Ev9ZbysXOH+/uSuz6Zs090LzBHq
         ommA==
X-Forwarded-Encrypted: i=1; AFNElJ9aaPZtPGHMDVhx9KE2uxbPst0Sz5qnkKNS0JqxD3+Zq8tuVvw105tOri3kD5jQW+8lm06SCg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw7hROpVyZsIMjSh8C1kAuEtKBxnH38U7AKSAZzfDAmX/v+4WrR
	Ub8L3KMNK7Amsi/bmqw2eYQsHpEUDyhlOQxCLK5Cp3GbzFXAWmlBNl3cZ/yVRvSIp6I=
X-Gm-Gg: AfdE7cnw8PR9xJg40njqqTwyNy4/P459AYuNUOBSTVMPof3fe33Sspf4fn9IX3/XMCF
	OcLXsBoK6ZQn0CJODJE0H1CK2kfNQzpPrBf1oof5UhgXQloXUhiVS9vlIOG3deHU6WXUKYZbP6T
	g/nIb/5QVtr3PBwouUYAxqqPY2kWQfOBCcwwdDW701WNajWjTQnh69tELPPE6lagB96HHMTTHN8
	V6MjANccNWTN0agKxASfmBOof7XcFwDVG+MxbkLoqRmO6lPDXGmISuxRdRFgeMy8DoTNu1UNha8
	S55+RVJIXYV9WAyKmotH4pRzJ3RQRr41HnZgiy8IAAn5F2DvxHoJfPoDYeVBe3mkfdgErCx4GWu
	0NT56eN0KFL9Y8/vf/2ny+klvsAPqU2kO/RqXoDPPc5XvImpbXX4Uz1wMg21d9nwpgK+bNLBHHo
	F+Mr4FHtDbhLdU16cd6aqp3bzflqmQJj9+mWhx7naT+FPMweyYrLMLBUevoZFJeQfh9ew=
X-Received: by 2002:a05:622a:1b92:b0:51c:1ec5:d0f with SMTP id d75a77b69052e-51c2aebaa70mr65534301cf.40.1783003650663;
        Thu, 02 Jul 2026 07:47:30 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c30c61857sm15516901cf.28.2026.07.02.07.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 07:47:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wfIhN-00000005tmX-0mNc;
	Thu, 02 Jul 2026 11:47:29 -0300
Date: Thu, 2 Jul 2026 11:47:29 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	Jiri Pirko <jiri@nvidia.com>, Michael Kelley <mhklinux@outlook.com>,
	"Cheloha, Scott" <Scott.Cheloha@amd.com>
Subject: Re: [PATCH v6 03/20] dma-direct: use DMA_ATTR_CC_SHARED in
 alloc/free paths
Message-ID: <20260702144729.GP7525@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <20260604083959.1265923-4-aneesh.kumar@kernel.org>
 <845d0c8a-6d51-47aa-8e0b-8381e733444a@amd.com>
 <20260617154101.GE3577091@ziepe.ca>
 <25155bd6-4348-4aa8-ba70-0a882fc84db9@amd.com>
 <20260630160242.GI7525@ziepe.ca>
 <98800d21-18f6-44d6-9ba0-da9b77567d85@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98800d21-18f6-44d6-9ba0-da9b77567d85@amd.com>

On Thu, Jul 02, 2026 at 10:25:16AM +1000, Alexey Kardashevskiy wrote:

> > > not externally available so I'll have to trick the DMA layer into
> > > using SWIOTLB (which is still all shared, right?) as I specifically
> > > want to skip page conversions. Setting low DMA mask won't guarantee
> > > that the DMA layer won't allocate a page outside of SWIOTLB and
> > > convert it. Manually do
> > 
> > Why so particular?
> 
> aahhh I missed "pre-". I need a way to get pre-shared pages for my
> sev-guest activities.

It sounds to me like you don't, what you are worried about is
optimizing the dma_alloc_coherent flow to avoid fragmentation and all
CC architetures require this optimization.

So I'm strongly against you trying to open code something in your
driver. Use the DMA API as-is. Propose general DMA API improvements to
reduce the fragmentation problem. It is a real problem.

Jason
