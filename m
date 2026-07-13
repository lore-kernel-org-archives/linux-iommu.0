Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0681733F8B7
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 19:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783969931; cv=none; b=fTazRM/imqHR7Zrtn81UB4OzjEZHw1K7aIO4evqwyIDAxm7AmTb8B4Gb2WFIyZ//nKVUCQJbCqdnLDP04V3JNDE2PpeViZUMQ7bRiGuyBieCYZ3FhYS3qB1hIvzfsog0QYNflZ6QoeeHZRJvFiKvtBb5ci6Iaz/j7NqeEZUyQzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783969931; c=relaxed/simple;
	bh=zQwwTTQgdWMUuBKytoq9EwDKG6Cm405oXwoG7/OyDFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYxlYIRIuWdPoqOqTznIpjP5V1U4fosd+P13BNPOWceyKDpKES/r+gCG0H+pkt3tCPRYJdUI8k7OPmJp1lsQN2eG1C7DZvWvqWzk30uukV2aFMz+W/5Qbs6k+TdeWrjljZRrOcuRscjmNAlCzTtTYNlMorsUakOxz2TuX2XHqVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=FTYUqOpe; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FTYUqOpe"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c08df8513so1559031cf.3
        for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 12:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783969929; x=1784574729; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/NxveP/pyfIFv71kVfPTlg3b5XZeJTUOET5rnvr6kHo=;
        b=FTYUqOpe8D1xKOGrFQ/CM2+g4sCo45Oq+MhB9F9vx+Yd5+InjZqJZFbxhFW8N8flw8
         TKvLz7IHOhvuVv/VCoU1efR9wIaRFEn9QVu2kY1kpE5L4arDxPTpE7iuOdH1rqfUBkAp
         YyeQh7PhutMCT5p6i+XCPx7t/tQ56hW3XHzwNj8vqGWI+rBCPRWuS2Teok+fb0tRjLjH
         Wyi1PToLkU0h9XguSoMfxKfuf3tr41VqfgBOOrXTTJbu2AfwMMCAw1y9I2nnbW+J9UbS
         GajC8Tna76zVNOgGHZwPXCPQzKpLvPDXRkW/fnS1ZiKKWudUi4/LeRQtcQ7yN4NkZwaB
         kDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783969929; x=1784574729;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/NxveP/pyfIFv71kVfPTlg3b5XZeJTUOET5rnvr6kHo=;
        b=S1+SbkNglOat2QBDs4gElPr5K7SXaH641Iij1UdY1HLdYNcS7M3aPjbV50pkdqlWkE
         LCDwyg1fXvCWlNdcnmOLFOxy8HbCKDLMDo3PnBgjerhERfMqHqDWjBTbNNnIbP21rocJ
         P5YD3wHsYgt3iu9rPltqxBkMEN2jrMHmdAATrmSyGEEjs0yawuxI1b/9O/AE733rk3Rx
         OvpMWc4ux13gKvjGKttImMDLz3zB3Cr0UjrHOglr1mQiQQgFnnTk6ljjMClQWmAv4Rwe
         Iwbg911ooQU22pOEJJQzngZzsA0jkw7Sh7rO+2KQrJyRcCs2d8Ihb+SzwR3HETTtwpos
         wM4Q==
X-Gm-Message-State: AOJu0YzMgWZKOi+9dmCTtsQHkZmIkgJoaLVKy+pPFHJ8BZpBysvlRwgl
	5xsWKLHGdiZEwnCcSxFGfDyhB8Dyr6bNTjwX1V7iNURqfkvvarP+mLcELmzWvPE6RoE=
X-Gm-Gg: AfdE7cnSZwE15DXlt0VBcWXBkHcrnlqqCQeeJ+Kn0UmS6VcyiGinYU9WwyCTj4NsNJ/
	tUeM3oBZHLqAd0o0uJwbdpoTs94dE8fKvUQsudELyzhn+K+LCST5ALTcmfKvochn+AnMPkeTn3V
	/Ewd0IE75j02Wtj1R271sqFNwLN2Oxs11NY3gX0TwrHeU1hQQSfPFmvCZx1Z/1ypbel8bPnfMip
	8Gf4aGzYPtVUYM95yK3Umz1AD8EjtMzTYRJxQDQgar9dniysgu/YMiFUtCR0/4zTb8je6Ay6lNw
	m6IWBrLFPyv3AhDUVxh7SyjoBXkaHotOzqUAo2LiEmpvMGW1POFfG2vT4Mu4BFzVon1UOZT12wO
	Nm7ImdGo2n1iXF8XIoz9HVpu6VIRujq9Scc3/gVZaoywS1gS5sbgiENUY9q0+
X-Received: by 2002:a05:622a:551a:b0:51b:f217:539f with SMTP id d75a77b69052e-51cbf0569bbmr98856591cf.17.1783969928867;
        Mon, 13 Jul 2026 12:12:08 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caacad30asm88764001cf.9.2026.07.13.12.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:12:08 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjM4V-0000000E4Bs-31V7;
	Mon, 13 Jul 2026 16:12:07 -0300
Date: Mon, 13 Jul 2026 16:12:07 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	Jiri Pirko <jiri@nvidia.com>, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v7 07/22] dma-direct: swiotlb: handle swiotlb alloc/free
 outside __dma_direct_alloc_pages
Message-ID: <20260713191207.GO3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-8-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701054926.825925-8-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:11AM +0530, Aneesh Kumar K.V (Arm) wrote:
> Move swiotlb allocation out of __dma_direct_alloc_pages() and handle it in
> dma_direct_alloc() / dma_direct_alloc_pages().
> 
> This is needed for follow-up changes that simplify the handling of
> memory encryption/decryption based on the DMA attribute flags.
> 
> swiotlb backing pages are already mapped decrypted by
> swiotlb_update_mem_attributes() and rmem_swiotlb_device_init(), so
> dma-direct should not call dma_set_decrypted() on allocation nor
> dma_set_encrypted() on free for swiotlb-backed memory.
> 
> Update alloc/free paths to detect swiotlb-backed pages and skip
> encrypt/decrypt transitions for those paths. Keep the existing highmem
> rejection in dma_direct_alloc_pages() for swiotlb allocations.
> 
> Only for "restricted-dma-pool", we currently set `for_alloc = true`, while
> rmem_swiotlb_device_init() decrypts the whole pool up front. This pool is
> typically used together with "shared-dma-pool", where the shared region is
> accessed after remap/ioremap and the returned address is suitable for
> decrypted memory access. So existing code paths remain valid.
> 
> Tested-by: Jiri Pirko <jiri@nvidia.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  include/linux/swiotlb.h |  6 ++++
>  kernel/dma/direct.c     | 71 ++++++++++++++++++++++++++++++-----------
>  kernel/dma/swiotlb.c    |  6 ++++
>  3 files changed, 65 insertions(+), 18 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
