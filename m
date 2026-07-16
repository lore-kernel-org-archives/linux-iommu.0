Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F117938F65C
	for <iommu@lists.linux.dev>; Thu, 16 Jul 2026 14:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784213575; cv=none; b=LxrXeDQhr8v3lpvLCeV6lHWkVE7xEo8WtcxZAa9+lRpitCUJGfn42yspxuJMuMqr9EU1w3Afp2oy+7e8Z9WLNSRzB/ClQ6NPHqa9qCTXO6OnmYxHmR0H1rDuZgd4mQsYENUJKXJ31pQikt9ivbXu1nogurICXqe73cdkaZnsNRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784213575; c=relaxed/simple;
	bh=Kt8BJTiDI+f7OuSjZH0CFB0i0A4B8tJakd1pImozOd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVuUA87Zfu2jFI82lZnLmnEAA2oH9k2Fpw/yEestg6MrNzMVA3MM5b9trR1HKGFrgD/6yvh9RDUs8b2ETmHBoHS76Wa57A0W2ckvswwMPFOiYr2eaVZ8OAi0qcLjezjcEm7Jt/mkhiaHKr9UA8NN5CSIdGMUowt20TO9hpV5jgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fd33zY9+; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fd33zY9+"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c05dcdf49so72956951cf.0
        for <iommu@lists.linux.dev>; Thu, 16 Jul 2026 07:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1784213573; x=1784818373; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M86Ir7wes1y7r8ERYu4z2fhecNCYpHaDZuovfA+lIDI=;
        b=fd33zY9+Qs7CAdcEII5iSAMKpFhJVOkSL2vKe7n6wTo6XZpTdEMwBSUOV+EjPkg0l3
         rIEzoRac/6nfrp7xFODPAk6Gw6MkD+8VBGtqvqE6ZYwu4TWsDWi9alPq1YKqisaLHsd3
         DAsl1gFPbbtklwWTNEUe8vubJwWrGC91Ze2B0Af5J6T21I1O6xY2sA6LI7qm27ksiDe5
         Llt+qcl5J5gD5Q1tf5pENNenAiWOgH/6cBzl8Oeq2Jn1X5b88x9O9Inr4FH/zY1Hd/Wh
         X7nblgJl7z3z/B7GwhZQqJAnK03EBUfVfItRPrVQRNWL+JuIZ+0ACFOizd60e1wT1X6w
         LNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784213573; x=1784818373;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M86Ir7wes1y7r8ERYu4z2fhecNCYpHaDZuovfA+lIDI=;
        b=OQjZ3m0gJcmtTFGdzj/A4oG4p53q/AnfomNKef/LR5zgWSpMb9CpnepZGklNEeTbQg
         fMsYOy7Ef+1NOICZmVg+dmd4RrJFpvOAnr6syjKBEQ+w0kfyAX2vRAX5qO9JhIcNaIra
         xYCi4POgv2fTTtn8D6+HBbm5QhO24EQI1QTsQ2u19gMPl6a6BHUFF5ALBvR62MbIqBBC
         +1iPRBtHsu5bW/qPuhhUyY239t9g9ni8BjE69woPg5870E4l9LEdpdfTXg4jAk+jEug2
         UlnoVsM3HNVnMFBY1bfBY3JRDhSCSbkUy7odNEGBexIRa1N8nVLMJwVf0WBE66QDlLAI
         /OWw==
X-Forwarded-Encrypted: i=1; AHgh+RoKfOikl8z/+uobi8QiYHYCf+VNNNiUb/P4AVVe1/5sDRRUsFmlukSTqHXQNqrS5QSVBUcAww==@lists.linux.dev
X-Gm-Message-State: AOJu0YxXu+/rFJ5DaS2SPytMMuXCQJrOZPMDQfuCYHfs3Rr5Azc3AbbV
	pAZEfgtuZNgo7upd1uoHJNoSsL9VykeT73Crk9q1fknPHMK00DaiPJgQIPQ9UYojHKo=
X-Gm-Gg: AfdE7cmKYLRbUh7MmvbKvSI6VTPXI/Cf+cMdzC7KsP9ZViSUMeX/gxaeyX9gcY2sdc2
	setIR8jfyp4H/wEwVtMCUk+Ygl40Gom5LcUBc8lfm3CouV+ercQmn6JmDm/3C0Q+fgfZsbkf/OP
	9HR3BMIAo7oOU7Mt8WLQUaTyerXzLYMpkxUL5fTQ9t2vvvfIpBwr62y+CWPRO+rdv18fc7MnfbO
	Sw+JY0ClgTNdipVOjLQ5ZRQXq8x3N9tlt93LSb5USdwgSHoJL1Mw7ivu6+pZ9TtpbKjOSkuNnKB
	eHyEAyILgtDhcwgXVOcdAg4DlxxO5kUCNeegQEigSna/zT6BmGu4d7izyeRDylmh33MuBHqaW/A
	XvTlcqkQ0G5ZF8jjuCheBxHY1/K9MiEt+F0pumntg9+whYvBTOw==
X-Received: by 2002:a05:622a:1b88:b0:51c:1811:6eae with SMTP id d75a77b69052e-51e4f0a757dmr78823321cf.47.1784213572745;
        Thu, 16 Jul 2026 07:52:52 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51ec9fef211sm28849141cf.0.2026.07.16.07.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 07:52:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wkNSF-00000002ZDm-0DPq;
	Thu, 16 Jul 2026 11:52:51 -0300
Date: Thu, 16 Jul 2026 11:52:51 -0300
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	Jiri Pirko <jiri@nvidia.com>, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v7 16/22] dma-direct: make dma_direct_map_phys() honor
 DMA_ATTR_CC_SHARED
Message-ID: <20260716145251.GE210048@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-17-aneesh.kumar@kernel.org>
 <ak42F240d-53QeFN@arm.com>
 <yq5apl0xgy89.fsf@kernel.org>
 <9d83ec13-3b1e-4c1b-8bab-16ea057cfba0@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d83ec13-3b1e-4c1b-8bab-16ea057cfba0@amd.com>

On Thu, Jul 16, 2026 at 11:55:20AM +1000, Alexey Kardashevskiy wrote:
> > > For AMD/SME, on host with memory encryption we now end up setting the C
> > > bit for DMA_ATTR_MMIO. This is fine for RAM but not sure whether
> > > some other MMIO bus understands this attribute. Maybe we should stick to
> > > something like __phys_to_dma() for the !CC_SHARED && MMIO path. Or,
> > > since this is not universally defined, just use the old dma_addr = phys
> > > if MMIO and ignore any unlikely DMA offsets.
> > > 
> > 
> > Considering for AMD/SME system an unencrypted dma addr is one without C
> > bit, will this be good?
> 
> Normally both encrypted and unencrypted DMA addresses do not have
> Cbit, with the only exception of "iommu=pt" (which is not the
> default afaik). And in this case, having Cbit in DMA handles only
> makes sense if p2p trafic goes via the root port (== IOMMU in
> passthrough mode, and I am not sure even about if the root port will
> convert this Cbit to T=1 MMIO in this mode) but if it goes via some
> PCI bridge - then Cbit won't mean encryption for sure. But I do not
> know much about p2p (never touched). But in any case
> force_dma_unencrypted() seems to make no sense here.

True p2p through a switch does not call the DMA API at all, it
directly stuffs the physical MMIO BAR address of the target into the
dma_addr_t - which won't have a C bit.

The DMA API is only involved if the p2p will transit through the root
port, so adding the C bit is correct.

AFAICT it is iommu=!pt that doesn't work at all since the AMD IOMMU
driver always does __sme_set() even for MMIO when forming the IOPTE,
which I guess is wrong for MMIO.

Jason
