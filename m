Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BF7408013
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 15:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779204465; cv=none; b=rNPnieIju0gdkmnLwecDxJwcLI8c7J5AWhAz3Q0l2k7x1zcv7U3mKFn/k41/W7aPIBhU7o2sxB8/PzmjDKlMbWo/GHsAR4CvVvSM1hPlM1fg7qJTGfo2vP9tpzwvWaA7xAVjQ0uJo1en8q6o4n3S0mtwcyOwFenuZDABSMfL7bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779204465; c=relaxed/simple;
	bh=uW4Yk0igRBmfLaBkig6+ozw+XI5e0m0/JIVGZ2INarE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpO9ZScOuQSuLwkr77Iuv5VnrD3BURYsiXa9DFF9dGjto/ClvOyLafqFiXCtHYYOMxwzYvU/tL4c4tiVaNXAs4kFHWMLGmjgoKxc3xSGqffBgKo9ijNGlS73A003Xy3EXGY8aelTcky+2QmYtT0fqzbnyi7bhpMmCW9157yVClc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ewDS4UPq; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ewDS4UPq"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-902deb2412fso474735085a.3
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 08:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779204463; x=1779809263; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kt+hX5KDw0Kh9RBmOyjzabH+WBL9dObDUAkuMZR7Klg=;
        b=ewDS4UPqLuAkKDvpdMv78yHUZSMMPt4qyIg2941bTPu81ULvSFjQGyB029B0iH9ock
         lmUaGbou3PxMuHQiCNWjAf7d+Jd/xTn1HytIvJtBSwMgGXRnPVrRodl5l+heuzO5tqAP
         ZBEGA8ZUhWHwA0WMgpf6v1aTsYUIYQ6kamPcJHMTjK6w7+ypBctYf8GYd3zaXshJK//R
         LvDw/MWU9JIIEMOkWcfpx7RZtow5Iz/0ies4F8AJW1Jlk6AVvy+xYzKfRkK6+LwACDOV
         0TP5vbEvAdQRTt8JyMF/vtu7HJjtbbEX1M8he+9iCp9qlwieyFTNQYbkO4ppX8FObq+Q
         pr2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779204463; x=1779809263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kt+hX5KDw0Kh9RBmOyjzabH+WBL9dObDUAkuMZR7Klg=;
        b=PWsxj1lu9op5cBNRaE8soV4mG3rkXs7qPqUpdxzLoQ9fHEz7takc7fT661Qlnvb0K0
         WhRE9LWVrk5EwDwC9gLIW6c6UZ1EpMrpbitzUJP6Y5YvUobge0lnOfDisu3VSoMnTMjN
         HTi0tV7VS2BWAqmKtqxnXiECr28txuMhl507/P6DAtVVdqtS4tsySRPhgA+6GgulqZb7
         eenOV3En7RafsCoAeLhdJ6lwk7ZKgB8K9fXA6gP7ewLccBfopKxAnX4C6BIw6psK6tBW
         6gK0yjkA193VYyMuVX1b8r0OP08XuWbTfteQSB7LFVNMP4rYG7n0NBpAa3FUIt+JrnGK
         WpNg==
X-Forwarded-Encrypted: i=1; AFNElJ/Y1YknBHy1mEdYD9yCUsjEBMxW/Mm9oufjAefMchxqMjsCx681n0gFFCFBfncaRw41qQykUA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw6G446ivldWW59Mk6Z9zYdG/+veaLIeULlV8I//YYvd2Lqwicx
	85QoZc5i97f2i/FBwGOne39WjWBVHhaDTR0yxG6PeiMax12N1zbfQ2Q+8GqEAxsIRgE=
X-Gm-Gg: Acq92OHsA4P7dLiNK4or/vwxBBTCjGGRa+RbK+6H8nxk728kK8SVojKGfozH5moJ2+q
	4rmGpznFctxh6i96DKFFVrpOu0p/p+4aEtzSDpmADoVH6Wji8wEQ8ioxhjwQyJCqLqz/4qwgiw7
	5O9Zb8TiFTa0d8pX3fuWfZ7wLqTW/+HMGR9uckGhYiFIFbXDDbjeQpMn62JykU6aldc1CsSsbE/
	3o1yW8tcWlyQrqZTcHU2uvGHeTeF1MHLHu20miI6BSFJqPzRKC97XisSnckDuoVCDKAo1rUXzyi
	avNjQonATg7QFWV2ltuyykUtjtt2dnLYSr8suSrhDAPmk1jOCnkJ2m/KWl24Hq2wrhesMzKvL6e
	IEKBqgtaua50HN3aUiyiCkQPrjom+Iw+Ml5kk6C5amhSErAr6bAPJ3hVTCb2WdSVEF7L2Vq4KKI
	wVifB5qc+sSKDvmGmKtXtPVhZKZvXBjr79mCvvARPy10v3vuWTybzSIsbJTtrhOPJgbW+1CVcd/
	X5YlmWYKqHA9tSk
X-Received: by 2002:a05:620a:45a5:b0:912:671b:d098 with SMTP id af79cd13be357-912671bd4e8mr2727065785a.51.1779204462879;
        Tue, 19 May 2026 08:27:42 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba943761sm1881906785a.11.2026.05.19.08.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:27:42 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPMM9-0000000FCKQ-2JCd;
	Tue, 19 May 2026 12:27:41 -0300
Date: Tue, 19 May 2026 12:27:41 -0300
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
Message-ID: <20260519152741.GM7702@ziepe.ca>
References: <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <agSKQrSIhizCXKwx@google.com>
 <yq5ah5oaa63h.fsf@kernel.org>
 <agW5rhE9n2gDQ0w5@google.com>
 <yq5apl2y5f96.fsf@kernel.org>
 <agXaby-7L7yS3Vva@google.com>
 <yq5ah5oa59wy.fsf@kernel.org>
 <agxDxdxynp4KEovA@google.com>
 <yq5amrxvshxg.fsf@kernel.org>
 <yq5abjebsaid.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5abjebsaid.fsf@kernel.org>

On Tue, May 19, 2026 at 08:37:54PM +0530, Aneesh Kumar K.V wrote:

> if we get force_dma_unencrypted(dev) correct, we won't need the above.
> 
> for dma_direct_alloc and dma_direct_alloc_pages() we have
> 
> 	if (force_dma_unencrypted(dev))
> 		attrs |= DMA_ATTR_CC_SHARED;
> 
> 
> for dma_direct_map_phys(), if we have swiotlb bouncing forced,
> 
> swiotlb_tbl_map_single():
> 
> 	if ((attrs & DMA_ATTR_CC_SHARED) || force_dma_unencrypted(dev))
> 		require_decrypted = true;

IMHO I really do prefer the DMA_ATTR_CC_SHARED flows closer to the
thing that did the decryption. While the above is possibly sound it is
very obtuse to be guessing what kind of memory swiotlb decided to
return..

Can we pass a pointer to the attrs into the swiotlb stuff and it can
update it based on the kind of memory it has allocated?

Jason
