Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC5245349C
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 14:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779200885; cv=none; b=HClnqRepGvvlmNjWOKlED7UL+a8etjU0L7jKF8+Et7zzollN+KxmFTBfcs33tx+6wgtD6tTlHzwbYU62lPZHaUB6sXerWIQYeQEqDgqFHSx7OJ64Ugh/5OzBE9bNRckN0KydpH+jPVmmR1rXln92m/PVZSD5N5n2ZSp54pDmD6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779200885; c=relaxed/simple;
	bh=vYkb+jBu+S0QIeav6yEnzsOxadQSbJKsWMAoA5G/wvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKBHC11uuHbrTHp71aqCuowN6A97HoR9A+1s/d6W5qUI4xjmfA7bYUxp4IQEaZmNr0zIv1vJeSMdNZd+R0SOK69fhoG5y4r9k2PY54S9ON+W6P9wBynOA+qv2BoHoG7ggc+PxVTr9o18sTky2azrBFgmGPQHvJweEN4vbZhvnDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q/ekQ49Y; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q/ekQ49Y"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-515548f390fso7071cf.0
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 07:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779200883; x=1779805683; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FTIuQdBXtpQH67pVdVz1Fjrx/oRpQ8R86tVZsSSuQBc=;
        b=Q/ekQ49YE/odHoCNYJ8ORxBpDvoTEL7tk8mH6iY5RTRQmPrFwnoRPDCOy5tx95VUl0
         jJyyZcxbvBuQKa5z/x91Hj+sNo/LHgpGBWJ4YF0MuIR/EuhLOPCAql6LbMB45UZTPh2s
         HAxEYkfmNvoV+S+ZTH5bndmFFbrhRt1Ei9GUMuz0L26oFoTBcyj2xK2K8YebIUUDEoOU
         99TnWX5ZbTjHShpK4kD1wFMjGxEdqSo0KLHQcXju10Zvf3x5DGRufxo3nn2qvZKpxh3U
         23yZdmGzvjih7qHeJzZrV7HdO+OeAMMBuAQaUSgkpzX56835krPNL0ssIY0xTTP2ggQE
         VyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779200883; x=1779805683;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FTIuQdBXtpQH67pVdVz1Fjrx/oRpQ8R86tVZsSSuQBc=;
        b=oATapR52y82DXNSD2iBF1U6b9pGmQVTqMvPOUCrVUXYWUrzWSAy5K2GfHjhNFk/QbT
         +dpkyaHUvElADh1qjsOVGqWaoHKhkZqPah5SsWNHLT1N523E7Uk4YhFpXqLz4j6o+dVp
         COp5LQC8wJF1v0COE7mRaeDWQ2zXOkmWzxGalT4hUufSHyfG+Pic2ynjnmXkkNganV9D
         WP0uwRYFdhYWO4BX3M5++KgWf5Qn0OGst9cCDdrS8JpkSAHCFtLVmwRyins1sbYJEi5Z
         LyshKFWkumf3hpab5lCGvkh8D3eunhvMbi9rEOP6aTbYa7GxTVloINamDW+zwJMgKJYD
         4j2Q==
X-Forwarded-Encrypted: i=1; AFNElJ+3mpO1XthA9BlS90R9SfrlJV1C+GcJ3mbjKocSgxd6Q//vJYp7awW29NWAxHuCtcX5V+3m+A==@lists.linux.dev
X-Gm-Message-State: AOJu0YykzsWzSA+sww14V6i9Rb4oBLWmGkR4cfwwXpmcjPM/uvcMnpy2
	9vFmfVwsbLSqcCyQb5DXBoUJL/CpCUbu+nQAmeTcWrpTbqHZQ0zmTDe1wMNzsWVphQ==
X-Gm-Gg: Acq92OHg6UJAOGXVoBokvJ/xf/NoyyxTOGISL+IQGFfMm7rVaHF7AiQyDu/5Sq+RRAo
	MzgkpVHFsbA9mFvhchNqyfxiYPrUVk34vfiJyTfVz0Y1hKtDUdDAyEJtzPfacwdjYJtelzlPXAE
	GDKlCQEybR75uMJbNk3Iy84XpekEr6NMBOH+TUwND5xPDGYoybmxr1OVRjNFDHnnk0ymyieBngF
	YGm7wGpGK9SUTB2372ZySEMx7Q+rxlvHKP/l7u9Fwjc8enRowcYpISnTkhGleY1BrUdt59TkS77
	21QY+4sfiamc5A8fWcSHjyuVkwVkzad0EZVZSQn/Eg/NEtrjNCZo8TuEXxwYJYMsYBrtPVaTpUD
	jqAH4EYjjMshi+qbcLgXo1Twb98jgpIYVoC1r1ZIqqjxtI/pkHD/2lG++MmtHF7g3n198rHYWT0
	cVDiPOwZWQGk+JMmNyccWOk/NeSQbzv5JEzkSWFN5wb1aYOusXuc89c31EAE+7tnXp/vGDdAej1
	gKZ
X-Received: by 2002:ac8:5cd0:0:b0:516:4f62:85ee with SMTP id d75a77b69052e-5167b6a87a6mr33333931cf.19.1779200882847;
        Tue, 19 May 2026 07:28:02 -0700 (PDT)
Received: from google.com (136.41.155.104.bc.googleusercontent.com. [104.155.41.136])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc9cbb0404sm37077347b3.42.2026.05.19.07.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:28:02 -0700 (PDT)
Date: Tue, 19 May 2026 14:27:54 +0000
From: Mostafa Saleh <smostafa@google.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v4 04/13] dma: swiotlb: track pool encryption state and
 honor DMA_ATTR_CC_SHARED
Message-ID: <agxzanDBmIP54hUz@google.com>
References: <agW5rhE9n2gDQ0w5@google.com>
 <yq5apl2y5f96.fsf@kernel.org>
 <agXaby-7L7yS3Vva@google.com>
 <yq5ah5oa59wy.fsf@kernel.org>
 <agxDxdxynp4KEovA@google.com>
 <20260519132911.GA7702@ziepe.ca>
 <agxolksC_1nfO34X@google.com>
 <yq5ah5o3sdn3.fsf@kernel.org>
 <agxt7SFGT7OLMIah@google.com>
 <yq5aecj7sctv.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq5aecj7sctv.fsf@kernel.org>

On Tue, May 19, 2026 at 07:47:48PM +0530, Aneesh Kumar K.V wrote:
> Mostafa Saleh <smostafa@google.com> writes:
> 
> > On Tue, May 19, 2026 at 07:30:16PM +0530, Aneesh Kumar K.V wrote:
> >> Mostafa Saleh <smostafa@google.com> writes:
> >> 
> >> >> > 
> >> >> > I am still running more tests, but looking more into it. Setting
> >> >> > force_dma_unencrypted() to true for pKVM guests is wrong, as the
> >> >> > guest shouldn’t try to decrypt arbitrary memory as it can include
> >> >> > sensitive information (for example in case of virtio sub-page
> >> >> > allocation) and should strictly rely on the restricted-dma-pool
> >> >> > for that.
> >> >> 
> >> >> ??
> >> >> 
> >> >> Where does force_dma_unencrypted() cause arbitary memory passed into
> >> >> the DMA API to be decrypted? That should never happen???
> >> >
> >> > Sorry, maybe arbitrary is not the right expression again :)
> >> > I mean that, with emulated devices that use the DMA-API under pKVM,
> >> > they will map memory coming from other layers (VFS, net) through
> >> > vitrio-block, virtio-net... These can be smaller than a page, and
> >> >
> >> 
> >> Don't we PAGE_ALIGN these requests?
> >> 
> >> dma_direct_alloc
> >> 	size = PAGE_ALIGN(size);
> >> 
> >> iommu_dma_alloc_pages
> >> 	size_t alloc_size = PAGE_ALIGN(size);
> >> 
> >> 
> >
> > For allocation, yes, and that's fine because we bring memory from
> > the pool.
> > But not for mapping, as dma_direct_map_phys(), where the memory is
> > allocated from the driver or other parts in the kernel and the page
> > may be shared with other kernel components.
> >
> 
> But if we are using restricted-dma-pool, we also have:
> 
> mem->force_bounce = true;
> mem->for_alloc = true;
> 
> So, will we use the swiotlb buffers for mapping and copy only the shared
> content into those swiotlb buffers?

True, that's why under pKVM, force_dma_unencrypted() should never
cause any memory to be decrypted and so we set it to false.
As in case of any bugs, the guest does not leak any information,
similar to what just happened initially here due to missing attrs.

However, as I mentioned to Jason, I think with some tweaks to
force_dma_unencrypted() we can make it work under pKVM for aligned
memory which eliminates some of the bouncing.
I am currently investigating that.

Thanks,
Mostafa

> 
> -aneesh
