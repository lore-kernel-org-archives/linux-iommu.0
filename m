Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B69368D7D
	for <iommu@lists.linux.dev>; Fri, 19 Jun 2026 12:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781870595; cv=none; b=V425SsWk2gk1Upq4EkRbRlNC2WJ/4SILIA/IzfyaWIR94WwmaRmLGxZqWPEczpe20H86T01BtkOGGhG1v74/nqJ5sULRFxMsP5O4OjFW7pCvmPA8hBKLjJI57ifpatbz4wam4EikrIeZic7rTU75p76/ycWTPRdI2iQ6b9uGO6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781870595; c=relaxed/simple;
	bh=3CfcX4Be+5vi/NadGQc4bvpp+jHS4/eMDxItDtd8Qqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhcBSICwWXZH6XNuzU7MlKmeJ1B2zgIK4Xxtmjwa43lS4vmKLoW2lRGfsmPWxSDPEnS5NWrCBrwZ8svv1v9HYPI6tFld1Wcob+CXiGjgo3lcexZtZ0igbdnEcoe4Eeu80Rdr2xHyx+4+D4SPvYxUsG0ELltfBGLmv2J0Y8X3Yaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ovEEzDFd; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ovEEzDFd"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7296071d19fso905753137.1
        for <iommu@lists.linux.dev>; Fri, 19 Jun 2026 05:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781870592; x=1782475392; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=StlCUTUicQISJ/bWwbWkmSHhXapLgWFJJHXk0oHb5Ig=;
        b=ovEEzDFdmge1XBEPWD/OuNrmNkHwFKp80azqXIGH8HSziLhgMxCuDoCclDBwwgjdTN
         sjwFTARD+lgizP3oDOPAY8d64Re+vLflxTJ5RH7D2y64x86ashlgzOqVMc3/Bkg4Q58H
         DRkG+hQ4PvIKikm93izM2VoxkqPdLHIA3T13lMX06eKlN5GFaMnB1SOOipWv+OOH2FXl
         UCPE+VEIY1Pzp/qz1D3AQKlGgM5dcSrc/4pmBmN0dOyGiS7fg8+4pzLw3T2vTT7GTjeh
         hKuUuwnQR56M8mfbNTaLuwQV/Kf/tW3EWdoLPhA43KSmDpstFMmy1Os8YmFruH4XKMPs
         KhgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781870592; x=1782475392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=StlCUTUicQISJ/bWwbWkmSHhXapLgWFJJHXk0oHb5Ig=;
        b=IhvBwho8721IXKwPcvzsM7gAnPYMyId5nlVJF4apwvFujwIpmO8PZH+O1xkhDadfFI
         kHd8y10ww/U0u0Ta9xWc+KZsh+fava7/hlkK+00J5dsxsyGDN1D+P1yASaJJC9CCYWGT
         OpZUGuf/Qyst8DCgpCtfHUOKT0UukZU5Tuq/ADEoG4K/e6jA8CrOfzfxMmzVe+oA6jwk
         srkaRsPJqlfuwtbRF0JO3+PBjq1LVIavAF0ih6LWz25ME4RAqcne2GzdA83N6bBiWwvc
         5e4O5IZmsikj6KiX5kEa5fdGgw+pkYGIOWWrB4J9VCbrNmw6w37v6w5PogOdok2LqVP+
         OU6w==
X-Forwarded-Encrypted: i=1; AFNElJ+yKZtZEXtWt1ZuxrmQto6X0uKYEHSRUzntRKApJteRqZx4LrAqujSsO2vlUtEb3xjp3MMzGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyGMF812LToPiiG4uGoPvDOYUPREhchn/6FO9LkfdlSCxopPn3+
	FI0t9Gl87nVAy4vaZSyTZjCF96WjtdEl3dPbsQH4EY65kELPWC4WxjY+Pnpuqog0nC4=
X-Gm-Gg: AfdE7clSKQ6GOQ85I6VMZwvBYYUSc6ir9XZ2lykQdoJXVHV8r4RDFJ1LYV0Vww+tpHk
	o5PRA9PlQeKO7a4JSidBMfyGJrEO/08aF1MKt5LEx51/oDj5mlgQNXzzBXOmSx/w522uf/HpVY9
	7mYlNwXjoeMVgoMNO6m3FOrAOjRiWEa1DG+kp5ARbEj0ZLI8fJwrac69whaP7N208VlzpT2PtML
	7qLy0GaJAQh7h30qGXxSQMy1Th1RwLujxHJLA42pMVfZtsDy4u6pi+PrZE/sFVONcxtcr968PIs
	q6k+NJx5TjmcIAZzv3BDvBkJwohlC76WkqzOVXSWsJu0GZ1ketMVaCq2Aq/yLH6LvHS4drm2p7F
	L21OcTukEkQLA2eaTCS/6njljLyWejI7p6ZFLsCP1HZ8uuSpo1woPfTTXl8SqKF+v7BnZ9Bg4VL
	6uSACFFioxG1XLGMv1IOqcavb9tFpytD2u1CWBQYacbM+O9Nsyle5CREvRnRg5FFcRYg80QsFVQ
	aax/A==
X-Received: by 2002:a05:6102:c89:b0:729:213f:76ca with SMTP id ada2fe7eead31-72a20215eaamr1999509137.29.1781870591985;
        Fri, 19 Jun 2026 05:03:11 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-920a424f817sm215731985a.22.2026.06.19.05.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 05:03:10 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1waXwD-00000004SQK-4AfU;
	Fri, 19 Jun 2026 09:03:09 -0300
Date: Fri, 19 Jun 2026 09:03:09 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v6 00/20] dma-mapping: Use DMA_ATTR_CC_SHARED through
 direct, pool and swiotlb paths
Message-ID: <20260619120309.GI231643@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <aigYbK12D8uKQvJF@arm.com>
 <20260609144746.GL2764304@ziepe.ca>
 <2ecfa1a8-6202-4319-9692-a6ffeb5a3dbf@amd.com>
 <yq5aqzm4dz25.fsf@kernel.org>
 <20260618153705.GH231643@ziepe.ca>
 <d4ef9a9f-18d9-40e1-9d02-87aeb9cb6540@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4ef9a9f-18d9-40e1-9d02-87aeb9cb6540@amd.com>

On Fri, Jun 19, 2026 at 12:05:45PM +1000, Alexey Kardashevskiy wrote:

> > > > > IMHO that's an AMD issue, not with the design of this series..
> > > > > 
> > > > > The series is right, a device that is !force_dma_decrypted() must be
> > > > > considerd to be a trusted device and we must never place any DMA
> > > > > mappings for a trusted device into shared memory.
> > > > 
> > > > swiotlb=force forces swiotlb, not decryption.
> > 
> > If force_dma_decrypted() == true then swiotlb must allocate from a
> > decrypted memory pool. It is right there in the name!
> > 
> > The hypervisor environment should *never* set force_dma_decrypted()
> > because all devices can access all hypervisor memory, up to their IOVA
> > limits.
> 
> True. But we do not have encrypted swiotlb pool today, right?

"encrypted" is just normal struct page memory, that's the default for
swiotlb.

I think it was a big mistake for the AMD SME stuff to overload the
decrypted/encrypted CC stuff which should mean shared/private in a
guest context to also mean things about physical memory encryption in
the host. It is really confusing.

The SME side is just a bad arch choice, the real world doesn't work
well if you set high address bits in your dma_addr_t. I think AMD
needs to use those restricted swiotlb pool where it allocates this
very special "SME Disabled" memory that will have a low
dma_addr_t. Then alloc and bouncing will get memory with a suitable
dma_addr_t. This has nothing to do with force_dma_unencrypted() which
is only a CC guest concept and nothing else in the OS should ever
touch decrypted memory.

> > And this is more insane logic. The right fix is to allocate the
> > swiotlb bounce from the *encrypted* pools when running on the
> > hypervisor which requires undoing this abuse of force_dma_decrypted().
> 
> +1.
> 
> But how does the kernel decide if it is this swiotlb pool or just
> some page which happens to be below the IOVA limit?

You mean in swiotlb_tbl_unmap_single() ? It checks the address against
the pool's range?

> swiotlb can be for bouncing (with all these dma_sync_single_for_cpu)
> or, if dev->dma_io_tlb_mem->for_alloc = true, for coherent
> allocation (no need in dma_sync_single_for_cpu).
> 
> I am looking for a way to set up my "sev-guest" device such as when

Whats a "sev-guest" device?

> dma_alloc_attrs(snp_dev->dev,...) happens, it allocates a page from
> the shared swiotlb pool (with no actual bouncing) and there is no
> obvious way to trick the DMA layer into doing that.

Why do you need this?

Jason
