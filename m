Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312EA3F58F7
	for <iommu@lists.linux.dev>; Wed, 22 Jul 2026 19:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784750355; cv=none; b=FRugZWsEeNAR87SbwLslm6nT1sZ8MIRhxLofVkmBCW/jl1PI5yRcR7QFrbQuYNmq3LZ/2Gfciu9YmAavg7c4JNEqWOSUbfxqLens5L7VvXacn7PkglIIhpJf3AhO7eR4w/Gt0ZtWmJQ4QzD+agU+G9SgDG0ymhQ0V/yi2s6rIr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784750355; c=relaxed/simple;
	bh=QzKGPAMMMcYp8C3yznRY+b0+buzB7XKjOZxs2Zi0vAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OmKpyGPOTGdNKz5Z1OsX1vJNvlHvIjUbxC6bXoAn9P9o0Gq8Wwm2oO9CTOkhO2HE4P+IHBw2BCoYCKV7Mx5Qi7bvqsH7VzFY3pkyX/mLEwOCCb8by98C0z2UKj2wHh5yFXphsmhJui9X3LE6+7sBM0nkmmGs5EcZfe0koaw2MY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=H9csLC28; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="H9csLC28"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38e041ea211so10836898a91.0
        for <iommu@lists.linux.dev>; Wed, 22 Jul 2026 12:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1784750353; x=1785355153; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EEIQnXJI41GVGpHCEj7IDcqZ+AmiiYPwRk5ZlYk7rZE=;
        b=H9csLC28/ZAPe6vHxt6my0W1xxhJkcjL4Ozd9cBAbgcLB78XyoiSwW1KCYRKAf+RgD
         3iHymI41ISFHPnlIhSr36J8mJ7BJRGnhse4QRr+7iUYAYSEGe4ylZn9fJW4RnI58VnHh
         iOIjGnTf+Acwq1R0Y6YYkrYy/SDFQM1KQBvwvvuu5p1cHy2rZVo88D+zuiPxRcda3w5G
         vPhMn76VRUhE0HL+l3TUTYfq6iSS3CF0oWyZ2Ma5K9P9SJ67AQubJcY8sttQs/UzssWo
         V6dviVfc8prPyNdvi/L5wOhO+vlmCNlJ1vtaox2c+4t/QpHSEoQ5wwfOqgrzK9cBz8cy
         NUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784750353; x=1785355153;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EEIQnXJI41GVGpHCEj7IDcqZ+AmiiYPwRk5ZlYk7rZE=;
        b=VrbeNdaV4bWdO3BmKV2/wrqztRMK2pPCqB+KL3IsoOLC2dtrnlsmhSsAz3VHgUR/Bx
         icsJaeBUEf37KorisizJcJwj8L9KTg5MeDpNu0xMbu1qjsOMc7FsKzM46qG6K0Rf66Jz
         kU9sJUBgWV7FQ9wQ/H1Lf+pNRz7HUPnB+eVOcCiH97sDeW0gQrWY9n1ILmPypQi2AykL
         n/AkUiQ4tLUx/2hkFFBH/m1SzioEPxEEGytGPTBrSN6XwnVvm4t+7hnzpNNff0mQIEY0
         5rQ90yVFEpPil+3vca0VQ1rF4ZFWY/0rwvh2OebtHpM1yjjMSBfkuAcbiJ736ag1Nf9B
         bvkw==
X-Forwarded-Encrypted: i=1; AHgh+RpAfNgqWZdxvbPqoq45rqqUmXdLjvin7EevaiQ2mSJs4vKpad68a/fB2MXSPLhQ1LOeDd7DPg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy3fq5+kPWqH2j/0OJceKlTyAKgJcJNx1oMfwJpMkzdKsY4/4pr
	o0g4oLsozuBw06NV4NhMQHOEt48IwKFXfQv8Fgr2R7pWD5tOjnnl8XLyeV7CwsIsPsA=
X-Gm-Gg: AR+sD117PAnJq8/Peho/07qFWmX85aG+e9BN1Nq2TNQfq8QRBELRnShcXnmmWy7RKrG
	vtwjuQS3/NE8KnMbSCL0eZdtHxfxjqkB1qK4HcJtfZ4n/tOUKdeJ+UkpMp1Zd4NpPEm5hjEwKIp
	XmfPDAMkGRSSLAfwN8K2HBJCbrnUG5lduAup0w+gWbtd+/BAIJgUhrWPeHTzTFgLXGqHX0CKSs4
	PHL+y2AlY3yf6qR/tbLlTruUPItqr7OHBBNeTfEzZ1KebF5D5Rf07jR8dd42AOfJvRjz1qqurF8
	yy3m+1r0rFMeXq4l27Jrbd6aHbr9RmDrxKkVkRRatKHnQYAtroiaMxCYfrulzVnUHsx5/teaMrW
	tSBgcX9xLm+xu5knuN7vUwyb76U4uuGjGptwE59DpkexHHCX2AULg
X-Received: by 2002:a17:90b:28c5:b0:38e:7080:b4c0 with SMTP id 98e67ed59e1d1-38ec6979bc6mr98413a91.10.1784750353408;
        Wed, 22 Jul 2026 12:59:13 -0700 (PDT)
Received: from ziepe.ca ([216.228.115.8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d13003f12sm14809771c88.2.2026.07.22.12.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 12:59:12 -0700 (PDT)
Received: from jgg by NV-9X0Z6D3.localdomain with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wmd60-000000002O0-1hvF;
	Wed, 22 Jul 2026 16:59:12 -0300
Date: Wed, 22 Jul 2026 16:59:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
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
	stable@vger.kernel.org, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v8 01/23] dma-direct: return struct page from
 dma_direct_alloc_from_pool()
Message-ID: <amEhEKQW0_HJ9cLN@ziepe.ca>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260717180442.110954-2-aneesh.kumar@kernel.org>
 <20260721115456.GI110966@unreal>
 <yq5atsps77c5.fsf@kernel.org>
 <20260721142921.GN110966@unreal>
 <yq5ao6g0750v.fsf@kernel.org>
 <20260721153321.GO110966@unreal>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721153321.GO110966@unreal>

On Tue, Jul 21, 2026 at 06:33:21PM +0300, Leon Romanovsky wrote:

> Something like, but probably void* needs to be phys_addr_t:
> 
> static inline struct page *dma_phys_to_page(void *addr)
> {
> #ifdef CONFIG_DMA_DIRECT_REMAP
> 	return vmalloc_to_page(addr);
> #else
> 	return virt_to_page(addr);
> #endif
> }

I don't like this, we don't know for sure the addr will be in a vmap
and this will fail if it isn't.

Jason
