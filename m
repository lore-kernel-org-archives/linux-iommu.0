Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296CD3E3D90
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 13:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284448; cv=none; b=N2Wg6821tS38PmhaRV/CiM2YH7EwxQVS1IBP3pcwe/Cy2H+3gwD71P1V0qne/iuxJ3Z6yyTMulnDs8HeszEL4+99/EBmnYm+DoaYW+8Ur3A7u8fFF0m9Y1X/6VqpQMfKfWqrssnBJ+9Li2P3EPvYdgCqCircqJjCfMs7dv0cbA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284448; c=relaxed/simple;
	bh=gECXMGpw9B7sH8oWBrgJbLY+YztieOR6VxnjmWmVTTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yv2sM/LfJMDFj/PXGVuDoEhwSKEYWfkvPDTPxfX5MVDBTFnsKDqNNvbyp51FX5NGq4SxgcnuSUQ64egbWbv+LZwukQinj+b1Faf6Xy/ckesGIe7fy9BMdah6e9+BnZFemzeQg22CDyi1e0pIcM6AzdND1Uf1gFQsiXpV/A2vpqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=h3IxkLwK; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="h3IxkLwK"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8b98482b253so79711626d6.1
        for <iommu@lists.linux.dev>; Wed, 20 May 2026 06:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779284441; x=1779889241; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W+SwQbDLFG0Y+rBu9pL52xRO2ueMe5MsHi84X45A//o=;
        b=h3IxkLwKWjyKUU7MSz9bokgAL4aEMcTyzldspbFFRqq2RbQP/VyTHFGDfvKshF+nAs
         gOgS8tVIRngvbGnJlo6WY4/W1Iw3q/cIBonaiGXSFJmGnO296OdvjiOWy/plNc5DmQ11
         xgP+nw0lpCqwoHiatRFik07mt5JkIhufk0A3K3O3H66mSTOK8PNM4ZVIFiF5cuaHgbUx
         0PI77OZuWEpaRDWLp11sIf2Pl6kFwG2S/H+PTk07G9t3rNhBhGLEfAegoctR0x81UDAN
         wfq1+5X4pRWrXGUcTHAVJJh2pzlfNA1DQUibjtrc4d90Vaf1grH/BDSjYSone8m6PwaE
         Ii8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779284441; x=1779889241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+SwQbDLFG0Y+rBu9pL52xRO2ueMe5MsHi84X45A//o=;
        b=VXhxfONjL68h77wcc0lWDPVhT5A2EQudvqdhQoFR7RD2bqmlcJKh3Tv5t0LoAhmMgS
         B0jjWYvur9oo4DwR+E96PPCLFo6ihSRLX/Zo8deZaS8HBR+KxUZ5GfURMTnuk8EE9avz
         kJ8izzm+X1HS7Kljyf4pHNwKMP0svuCQfIthY9QgY2rkZqb8S37qD/rLfX/iRNdaGujo
         3eYeWuNTB0NfUJt6mhuAWvu5x6oxn1LS5N/AiZ+GO15qmxWs2Kfp3c3QAXfW7xB39JyO
         IiQ6v59sTiedzPJgm+a06UWr9/ZGF8QF/IUY0autjj3cvmgD9MS/5BQaGuP65r12Vsq5
         J/8w==
X-Forwarded-Encrypted: i=1; AFNElJ+EOaRn6W6Khnz72lIAo9XdFCJJdD2tJbTMgtr/Wpq6gOBAdxvhXufL5qQCt2WOk8L/UfEw8A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxpa0/v3g745N7o/de7WAXBhSI1JKnGoX1wtB7JvNY+TJN8Clzc
	HZC9oNowDcCuygLk7xsOh0UP9DAh3h75xQ0OHknLCYNlnIAadM/sgBQvA4GMNhjE0QI=
X-Gm-Gg: Acq92OEjkqPW1OYKC+dFf9paeOedh4kVV0X4nydVazQmd0YOm+/eHTky6PooRZ+W5JL
	bLayNt8MUhIIqQkVndooGoe+9RgrtcKVdota6R2QFmH3fe6N7GMzmaeZ4S+Hx4HW64ATi9aOzvr
	cbTI2XA2xkTkwSFiSQJYbjFhal1F5+bPgDO8F1LNdYU/ixoJ4GN6KvgIIioxeeBPg4s5PXadWqZ
	G0iJlkiMsOGO/TgGPJ7Pg/UAZVeQC87zEUqZ0zK2+JzXXeePRsKuBCt0GR+HgWfjORkuZm/Xp0W
	sJOfl4uXHjwPdbIoVi+72jC96qnTlDViYStyyu1Jf5aXRD9UemNuPQ4Xj1KyYDuQFfecJH+tLs+
	M9RLr/cp0pmJjpJ2RFPZkgyB0gNfJE/t8WlXJNt5rlI2KYMaLumuLJXnEcCjROS1+rSPhyKnxY0
	GJBTQ4NpZgTbfIA+7oynr65NVCvFoxGFOHq1dWrU/fe/M8K0tukNqREzoGi0O7ecQ8rn+Bod+KK
	hUbr9bfip6clDEL
X-Received: by 2002:a05:6214:5c42:b0:8ca:16fd:7297 with SMTP id 6a1803df08f44-8ca16fd752cmr347910676d6.30.1779284440966;
        Wed, 20 May 2026 06:40:40 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca360ac735sm122405916d6.19.2026.05.20.06.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 06:40:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPhA7-0000000HB8S-389S;
	Wed, 20 May 2026 10:40:39 -0300
Date: Wed, 20 May 2026 10:40:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
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
Message-ID: <20260520134039.GT7702@ziepe.ca>
References: <yq5apl2y5f96.fsf@kernel.org>
 <agXaby-7L7yS3Vva@google.com>
 <yq5ah5oa59wy.fsf@kernel.org>
 <agxDxdxynp4KEovA@google.com>
 <yq5amrxvshxg.fsf@kernel.org>
 <yq5abjebsaid.fsf@kernel.org>
 <20260519152741.GM7702@ziepe.ca>
 <yq5a8q9fs7ud.fsf@kernel.org>
 <20260519161120.GO7702@ziepe.ca>
 <yq5a5x4ispg8.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5a5x4ispg8.fsf@kernel.org>

On Wed, May 20, 2026 at 09:27:27AM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@ziepe.ca> writes:
> 
> > On Tue, May 19, 2026 at 09:35:30PM +0530, Aneesh Kumar K.V wrote:
> >> Yes, that also resulted in simpler and cleaner code.
> >> 
> >> swiotlb_tbl_map_single
> >> 	/*
> >> 	 * If the physical address is encrypted but the device requires
> >> 	 * decrypted DMA, use a decrypted io_tlb_mem and update the
> >> 	 * attributes so the caller knows that a decrypted io_tlb_mem
> >> 	 * was used.
> >> 	 */
> >> 	if (!(*attrs & DMA_ATTR_CC_SHARED) && force_dma_unencrypted(dev))
> >> 		*attrs |= DMA_ATTR_CC_SHARED;
> >> 
> >> 	if (mem->unencrypted != !!(*attrs & DMA_ATTR_CC_SHARED))
> >> 		return (phys_addr_t)DMA_MAPPING_ERROR;
> >
> > Yeah, exactly that is so much clearer now that the mem->unecrypted is
> > tied directly.
> >
> > That logic is reversed though, the incoming ATTR_CC doesn't matter for
> > swiotlb, that is just the source of the memcpy.
> >
> > /* swiotlb pool is incorrect for this device */
> > if (mem->unencrypted != force_dma_unencrypted(dev))
> >     return (phys_addr_t)DMA_MAPPING_ERROR;
> >
> > /* Force attrs to match the kind of memory in the pool */
> > if (mem->unencrypted)
> >      *attrs |= DMA_ATTR_CC_SHARED;
> > else
> >      *attrs &= ~DMA_ATTR_CC_SHARED;
> >
> >
> > Attrs should be forced to whatever memory swiotlb selected.
> >
> 
> But that will not handle a T=1 device that wants to use swiotlb to
> bounce unencrypted memory. That is:
> 
> force_dma_unencrypted(dev) == 0  /* T=1 device */
> attrs = DMA_ATTR_CC_SHARED;
>
> In that case, it should use an unencrypted io_tlb_mem:
> mem->unencrypted == 1

No! The DMA_ATTR_CC_SHARED only states the nature of the source
memory, the DMA transfer will always happen under T=1

It is perfectly fine to memcpy from shared to private and do a T=1 DMA
from the private memory if we have to bounce.

Jason
