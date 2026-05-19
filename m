Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37B0348C71
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 13:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779197957; cv=none; b=evXuh//gs6is8tUpdmZBw3DnrYdLNvYfzsKeCjsYCYx2GOv9atwGs9LZwGc2fiUI2QzrYf+evgHT5mKzAlpnLPZOhkt8eXO9hN+jdgRZr/ocLllpoTKeIDBPwDwrbfAwwWxSXcF1UbR5Tg922eVdiA8Urtf/0BCPt05hdQUR1x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779197957; c=relaxed/simple;
	bh=pRQYtCnb87pUz8VrW1rjYy01bwyg5a1R8WEHmalGJNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qn2Gxl7e0SLLtIkrJnKsZ+h36oWsd3XZWoXmKkWp/PuLf7AaKFWyFQ3hUeCie/jE5Gjw4EW0+UsgQclGIC00+i0M3/MByVtjHSR/9BRHUYPQ1O5IGZvfPuOwT9AHkmYYvFuPCnX9ldCSiuuNjUKpOmF3B267+SrqJ8/1IjZ5ePE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=a0rlJe5K; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="a0rlJe5K"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50e5bea4045so27466201cf.3
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 06:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779197955; x=1779802755; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2jBYQyB5cOJsBc04yDDPLVV700aJQU8UB+xEqw7DWQ=;
        b=a0rlJe5KxmeP2RSwbm0TqChNKSCfa2/LLVBns4A7fRRGpcQIjTU3XayEF3vunj68RJ
         tQusSr7yOcIYUWZltQ+yyeHXZ8Ea5F17lTkJvER+xUR24FVM/lmdkqi9OrklPoDISiDS
         kLOZQTtLazpwhP1SsnRNMT/RWFfrs2zCryUf0zvmIyBTq2oKSOw1Y8rhklkfJne6z7JC
         5dYf7zo5CpA3KvS21XkHNM0uilXG/SRatzGNoJ4mjcgeyDB5w5X+4IdkWpdXsgZ63xUH
         iUeViRNj77QtJ8yzX1DktIABoTdh+YADCsvFZeKB/Lj7hMnq/jphkeXTLpdO7xlYY6d1
         vu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779197955; x=1779802755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2jBYQyB5cOJsBc04yDDPLVV700aJQU8UB+xEqw7DWQ=;
        b=OZmSBw2mSHAtFyWxyiSF5b1ItzZrDVlnorJC7/yv+Fj8rCV1ltMFUv8R/BVGYK+3h2
         NXty6rDBvflW7dyDqZDmZHimo179TG2Nut91rMat5AIK10jJ7dI4/7jryw0BOfLmP4mQ
         Or5rQb3PqQIFS9sEdo4Zd5KMX5YpdmGVxXtPmIeAyw6vHgiluqjw77luvsqJkkGSbJOa
         hGpmmTwRQJ0StwZ0MDWqO6znU/Is76cdF7+Zp8IQmXtdKKvpzFMJQ7riTYcmGGp3x47q
         cGIRKzlqAr1TAUMrjU1bO1+Gx+Plc6yFGqtQhX2i78vQBLWyezcYcvIlxIwF3sQXTnv4
         9ATw==
X-Forwarded-Encrypted: i=1; AFNElJ/XrbLido5mJqZn9N0k2VpHq2nMkyf83ODONG9APpMuf8FWiaVcz2RKjBSYg9ShiyatoivQew==@lists.linux.dev
X-Gm-Message-State: AOJu0YyMpflWXBy+bjvBmU33LtIAYiaQG1Ja4QW8UH3MLuILeQ3y73ir
	cPZ/r+oEdPtX+3PeKNUH5D9wjutQoaB10+JTM0S2M9OObKrxiiXTzgnN2Mt0hpfnjL0=
X-Gm-Gg: Acq92OGo4CHic9MT7aCf4dmMTuqxq6fnI/ZzKkjswbMqD+qlBs0dyZRHR7m7+2mbvSm
	d9c92n+5cjpOPa5zPa2LCgAi3Jk5fhJ4gpeomyaGuv+dyQK2V+0JWu9YHwqPcdjlNAgTWYtJZau
	AW9VBuar6OvBpBQ7H1PCd+wBJmPK5Xj8yaQ/dmRZVg0rtCq4273mALAXm+nlIFuXTlyz6nKv/DF
	xzAkhAMW/Ly0h6ieB9d20EmMwg/AIlhE5FGY5/4DdjoKm8JQRBCq0EmGdTQ9Ujp7r6QWR3tVhMD
	QZuOfgXKCYuTVnAoFKdTtE96MmObnphBwmJbVVOR78wKEQKXDuhq1Ouxx3vJgn/fekF62YbwrEp
	9B34rAzi5Ctjq4xYXX/6/KJptlNYi0WYzqQYwrkMv4PUOi0JpnGjuh80HT9o9zFGMyTGZ17iTzu
	ObsC/uRj4hjQ9BSLMmy3KPLIszNlBDqvJtFxjSkvcI2cXYHPhB8XRDfuzoqT0grP5KXl8CkoTB9
	nGmuA==
X-Received: by 2002:a05:622a:50f:b0:50d:a6e3:ae1 with SMTP id d75a77b69052e-5165a03ee67mr270655651cf.17.1779197954757;
        Tue, 19 May 2026 06:39:14 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516514e0b91sm152289551cf.15.2026.05.19.06.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 06:39:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPKfB-0000000Evg5-382Z;
	Tue, 19 May 2026 10:39:13 -0300
Date: Tue, 19 May 2026 10:39:13 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
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
Message-ID: <20260519133913.GB7702@ziepe.ca>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <agSKQrSIhizCXKwx@google.com>
 <20260513172450.GR7702@ziepe.ca>
 <agW2lzJI-20DyJVe@google.com>
 <20260514123529.GZ7702@ziepe.ca>
 <agXfm3mS_M3fvRrN@google.com>
 <20260515225113.GN7702@ziepe.ca>
 <agxETC1rXBUSkWYg@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agxETC1rXBUSkWYg@google.com>

On Tue, May 19, 2026 at 11:06:52AM +0000, Mostafa Saleh wrote:

> > > One other interesting case for device-passthrough is non-coherent
> > > devices which then require private pools for bouncing.
> > 
> > Why does shared/private matter for bouncing? Why do you need to bounce
> > at all? Do cmo's not work in pkvm guests?
> 
> At the moment, in iommu_dma_map_phys(), if a non coherent device
> tries to map an unaligned address or size it will be bounced.

Sure, that's fine.

> In pKVM, dma-iommu is used for assigned devices which operate on
> private memory, so bouncing that through the SWIOTLB would leak
> information from the guest as the SWIOTLB is decrypted.

Yes, a device that can do private access should not be using a shared
SWIOTLB, that should be part of the selection logic inside the SWIOTLB
stuff..

Jason
