Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FB9235358
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 19:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783970018; cv=none; b=f3mpp8N88CXM9AVizRK8OMFdeBGV21rcgPljAHAduPZ80nyBc+5DWpDqZKRUqEhjMjeI4JNPGlPlWrVVUUxT33JFOWT1xulGSPm+cZ8GOrPLNJrCLkb599NegVUm6kHdq4NW6ET/fg69waQpuj+1aiOUAK01Qum6XV8t4VCH9DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783970018; c=relaxed/simple;
	bh=92pQU4Hi+MtUFsgN9vNGOKjNaZ7KSv66gg2PCC2d0mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnas2fHNOfC4lszn9/oLWH19XBUqEopy+jPdBE9XBkZ8Iwyh8lsGGNlIeOGD0KjLWGDhQEN7GSYMOvFgCGLmptViczBVIC+wFmwcQxoV+C/60HW6QUKs2JCxdejJCU33wEnkh5FL3RbmCd4Hszcg2CwH2LbnTy/a/I+DvRSHmkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bQoiSYHa; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bQoiSYHa"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92e67555e24so16745785a.3
        for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 12:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783970016; x=1784574816; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GfyQxZTxEaV2M3A7Wuj8sGJT6iMHPBQ3Q1zHUbuKZKY=;
        b=bQoiSYHaMtV2d3uba2eLTqAGDNOv2q6Hr6OL7ZFpGGYDBE9xOD+1je/udMxEhZkYTU
         SEHDF/cArQfuRrtJ7KmkJpoJyD/3E2ziON+98H/J5KQAn5n826t6tjkd1UUQ6jLg//dR
         Dq8bkR8fSqMyl0qtS06HqkEu0UtKFGZ9WyHauCc8xahsUl8yFwHX4AiE20p0hIk2cDN2
         zrYp9kpQexFdvmU0sC31PFn4UmT7v/MD9R4B4DAtrl3qhOEWJefUfHwMcHKBZUavXcl6
         ch/gMNIXo7OrnRocxRhGxfiALgC4pwcV5ZYExAsV81DXM7HzBJ5Pj3vpAgnp9Gx592Zf
         ZZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783970016; x=1784574816;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GfyQxZTxEaV2M3A7Wuj8sGJT6iMHPBQ3Q1zHUbuKZKY=;
        b=CJHmjQWlho1ZXWNLLAH7IgmJecbG2v5eWSr79x8W+bJ+9dkiq4G1MDET8CCumLIpUX
         eiY2IhbHUaHzFIXVOrLq+mr8Eu13toGLPZhHDKJoWG9xWcmL+NesCNng9sEAcJR85Opf
         VxVn9dWZNf2LxAJobsX2ady/jbnxK92/WhdBUN+of/1yV7CjZdfQ6TOrVITaREUL9h0J
         30xySX7m9MZ3Kr2bpi3JXz11gylFcWkcVyNnachZ3uweX78+Y7SWYeHW2Lqm0DccScP/
         72EzxEGy50xFiKchVKl46aq8zXHNgIzwSH+OXVWR50U+u0o3cPbRlxpBapYbr1AQeoV2
         Aq9Q==
X-Gm-Message-State: AOJu0YxyCpQWOSbOcr8Zbzr/H2om4pX7+gghEodnUCGtUkdjWCU8C4O6
	phKf7h1+ZJjgyEh/B7D1sBhNJk9ReuYdfO9YNa0SBV/rcMwp5mQtdOgoKMwJkbQDjzw=
X-Gm-Gg: AfdE7ck4sP0Fxe7UnGNIl3Bvzfou3nrueQijMRpJb6PG4K1FofCOqFuJ9csM83uN+aG
	SXXG7FZPr56BenhtJ5fbFnBXlu80nVPbwBv7VZpwiA96FNaqvT79X/WPbh+4TqHk8ieDyspjxqe
	G0qObURdrIv9eTIcjiFuWA3wG3T2TmSFE616fFOdC1WseboXnnePtTr4ntwhCDOqGE04eAAYQCP
	o4YP2br4AJC85n50/VnuLsTXGy+wa+Nno15UmnMrA8K+tIrSwtZpxz8+Q5eQi1UBXn4P/g/1paB
	YSyIU4vY08/t4cCK3IEtjUNs1YuwF4LR/C3Pxhk/Gjzuuess6omHtnT6RBiLWRsgjuL/6JRSnLN
	3pLG5NKzZC76qhW3eAPpYjGixnL87darEbq6jrtBcylVTLLaA+jZ9pPknvHwm
X-Received: by 2002:a05:620a:8908:b0:92b:6805:9198 with SMTP id af79cd13be357-92ef2c69c53mr1083302685a.64.1783970016442;
        Mon, 13 Jul 2026 12:13:36 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5bab293sm1169545085a.18.2026.07.13.12.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:13:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjM5v-0000000E4M5-1cBx;
	Mon, 13 Jul 2026 16:13:35 -0300
Date: Mon, 13 Jul 2026 16:13:35 -0300
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v7 09/22] dma-mapping: Add internal shared allocation
 attribute
Message-ID: <20260713191335.GP3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-10-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701054926.825925-10-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:13AM +0530, Aneesh Kumar K.V (Arm) wrote:
> DMA_ATTR_CC_SHARED describes an existing DMA mapping whose backing memory
> is already shared, or decrypted, for confidential computing. It is a
> mapping attribute: callers use it to request a shared DMA address encoding
> for memory that has already been prepared for shared DMA.
> 
> Allocation paths need a related but different state. Once the DMA core
> decides that an allocation must use shared backing pages, the lower-level
> allocation helpers need to select shared pools, decrypt newly allocated
> pages, derive the DMA address with the shared-memory translation and
> restore encryption on free. That state is internal to the DMA-mapping
> implementation and should not be passed by drivers to dma_alloc_attrs().
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  Documentation/core-api/dma-attributes.rst | 29 +++++++++++++++++++++++
>  include/linux/dma-mapping.h               |  8 +++++++
>  include/trace/events/dma.h                |  3 ++-
>  3 files changed, 39 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
