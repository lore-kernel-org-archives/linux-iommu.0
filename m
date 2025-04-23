Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCB2223DC0
	for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 23:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745451219; cv=none; b=JdCwOpKAfmNNWSr1lqf/5uwK8PNmPFNwAeme4CBDyBr/yI6+4R6eBRjYSGhBPFebECLImfjRmMQXGI9aJaDKHjBNFWB768wJAlWu2CP0MHJaIg5kZzt4VwMC/Lzhbi4qJDyNWN5olFXWVtiGJz+eyw5JJOVDX+YnbIvvTrjHDLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745451219; c=relaxed/simple;
	bh=El3tntKet6XFP5tu5jRccRiIHcbcsNXplDjGS1RgqqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHg28Z0gQdRgUfsZj78uaevs7a+SQ3SrmMRmDUD9VLH3X0zMuTjzu0oXX3l9ErUFJ0edlcH+WAEs8K5mSwUBZicTMNBHre26m4qudb8tF/8BVSIazgmq/muj749+4HXeCepGVK67a+9PzmlY7l1K/YGnF0FnveFFLv2os1Azyu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=lI//r8XI; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lI//r8XI"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-47688ae873fso4464951cf.0
        for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 16:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745451216; x=1746056016; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L7oRP2YqJwVB6GeEu4BqvXzZqclhisHpp0fN6LY14JQ=;
        b=lI//r8XIk5Id32jnqr131a0knxutJbYtRsV3gvW7Qf1Gm4cykmeOlfE8ltR6f/dYPR
         1vy03Vtrjvcruc1rc3ybNqmvK8Xc0k+Ghl5HJ7xy8RVYVe2t5hTwW9DwEZSMFU6b79zb
         RgKR/He5DGoVAAxV9Kv5XS90H/Wdv6ykdJGwgm/HXRKnJ/Q+vkcLqW/zu2r31MojNcHF
         vVF9wft1N/8Lu6VCDfh9q8s+WenEpnqXgMVut/98JeRFVDIMh8Bg+VtunYtNnvzIgesb
         MSU38b21LU1dzyCAdZScFiUrKjoAd9qK4Ipu/RDfFzvE9M2+F/pmazvnWQ19555rpin2
         bAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745451216; x=1746056016;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L7oRP2YqJwVB6GeEu4BqvXzZqclhisHpp0fN6LY14JQ=;
        b=FTgSNkORs2WPqv3O/U/Rfmp2Yj1LTHWLfnRl4AVvQzqSQf1GPIoA/2FXGSaLm17V8X
         fm15SDlQ0er+oqACNiUHyt5EMVUKu5NjiQi/nP77swvhtOebYvsBUe6yvyT5EtH/8d/t
         6Dziw8QGWhhUbdYZCmA6NfWkAvh6RnuBqsgWmav3Bvo9bCa0u9YFgeHGq90A7NkjfBjG
         Q+EBDjJu8HoTg3PGiS/tgWA30CVMRBJirNBp46e5Snyb7JeZQO7f+nzcfFGK8qgfY3+R
         a3m818pkSi4xKUexY2D9YMBCeEMsyp0uiBrnfOyhlF/6iQg/ZV/tGdPkiLDWqloAqdLo
         DTIg==
X-Forwarded-Encrypted: i=1; AJvYcCW/8u6eYZZjnh8z0UrWcN0w/dXM3EH6MHijjRx8WMNgmsyH0zhnSxAOlq0Gf2MovWaI4TNfLw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywvoa5lBIrGqrw4URdOxcIlzU4t/rvw9uoBd6nxVIgT8So5UJ7q
	l8CgyyjBuISiN4E6284R3525/Kx+f+PtijmlCfzeqfHy0a3boL1T+8bvtkj9lh8=
X-Gm-Gg: ASbGncuAtwzWRVgftEIEgJTPHggv0xU3Ki1sYeQzvAezToLZSN3hjp6R8+RkpMu0pSm
	fWCWQOppBCZ+bdCbeNAt5+j8+067Nk89dJxeFne2Bc4rvP4C5PKF/i4JOoeAoc2tbK6lboAHiXf
	2HPox6bFmNdEPnzsfBN1rO4Dudg6S4C4nwrUVV1h8IY7q30Hi5mBVJYGP9u1f0BMFsfZDoUbQAI
	qdF4WUI39UYx5ao38zbtDm+SrPO08op8NF0MBZinc7Cli1qdfB8QywNn0MtCBNO03w8rX56G7Zj
	815nPWNuCuouYLOU0CHHMI8wpywTIV3q0G7+d8Ma24q9s0G54RXqHVNFA60lzJK7togHYehUTT0
	U71ksU6w07I26Z/D312g=
X-Google-Smtp-Source: AGHT+IHp4LWhqR/rJc6pqFU95w2BqdqjYtJ4SAe1Mvc/v+Ufccgyj7hWc7Mm96oBr3hzP4lBlnfnCQ==
X-Received: by 2002:a05:622a:388:b0:476:b783:c94d with SMTP id d75a77b69052e-47eb4fbb928mr6490361cf.35.1745451216599;
        Wed, 23 Apr 2025 16:33:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ea1ba154asm2538601cf.67.2025.04.23.16.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 16:33:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7jax-00000007PKl-19Zx;
	Wed, 23 Apr 2025 20:33:35 -0300
Date: Wed, 23 Apr 2025 20:33:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mika =?utf-8?B?UGVudHRpbMOk?= <mpenttil@redhat.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v9 10/24] mm/hmm: let users to tag specific PFN with DMA
 mapped bit
Message-ID: <20250423233335.GW1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <0a7c1e06269eee12ff8912fe0da4b7692081fcde.1745394536.git.leon@kernel.org>
 <7185c055-fc9e-4510-a9bf-6245673f2f92@redhat.com>
 <20250423181706.GT1213339@ziepe.ca>
 <36891b0e-d5fa-4cf8-a181-599a20af1da3@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36891b0e-d5fa-4cf8-a181-599a20af1da3@redhat.com>

On Wed, Apr 23, 2025 at 09:37:24PM +0300, Mika Penttilä wrote:
> 
> On 4/23/25 21:17, Jason Gunthorpe wrote:
> > On Wed, Apr 23, 2025 at 08:54:05PM +0300, Mika Penttilä wrote:
> >>> @@ -36,6 +38,13 @@ enum hmm_pfn_flags {
> >>>  	HMM_PFN_VALID = 1UL << (BITS_PER_LONG - 1),
> >>>  	HMM_PFN_WRITE = 1UL << (BITS_PER_LONG - 2),
> >>>  	HMM_PFN_ERROR = 1UL << (BITS_PER_LONG - 3),
> >>> +
> >>> +	/*
> >>> +	 * Sticky flags, carried from input to output,
> >>> +	 * don't forget to update HMM_PFN_INOUT_FLAGS
> >>> +	 */
> >>> +	HMM_PFN_DMA_MAPPED = 1UL << (BITS_PER_LONG - 7),
> >>> +
> >> How is this playing together with the mapped order usage?
> > Order shift starts at bit 8, DMA_MAPPED is at bit 7
> 
> hmm bits are the high bits, and order is 5 bits starting from
> (BITS_PER_LONG - 8)

I see, so yes order occupies 5 bits [-4,-5,-6,-7,-8] and the
DMA_MAPPED overlaps, it should be 9 not 7 because of the backwardness.

Probably testing didn't hit this because the usual 2M order of 9 only
sets bits -4 and -8 .. The way the order works it doesn't clear the
0 bits, which I wonder if is a little bug..

Jason
