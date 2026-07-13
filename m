Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5DE34CFCA
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 17:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783965437; cv=none; b=G3GBysW1i1Ub8A5PAN2ypN7eWP6TPW3CTmKH6pklOz2GHyQCHZTvxT0dtg0/mrDKNT7MLZWooHsWBSXNhmoXKQ8/+0cHuEIH9+yBrxXsArJU+OuH3/y115IQ+ZaT3J5PjdLMjdivim/PdRTsrFsI2rKSK223zzyeU4ZmohsTbSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783965437; c=relaxed/simple;
	bh=/p42+HpNsjMWY1GT2uoeKq2/f492YfHBxuTyaBrOVBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=anl4wqmmAfp0rRNI67xNYprbz3WBNhmD5PGXLcELnled5ip07/6jiFGmfSEof43NuED+Ih3Zm45Vatqe7kFE7c3kanhVFew4k/zM9YmMFEWWpWI1cwMtMM16667gggZMxFhEkhK1ajJvSQMMFiL4SagpeGJp0eKBq480wwCuuSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=I+Cuhhju; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="I+Cuhhju"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8eeb4508f29so31624676d6.0
        for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 10:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783965435; x=1784570235; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YGHI47Uk7ivYjDw6pJp4pRueuEDSB7hHUc7Dm7encu0=;
        b=I+CuhhjuSut3ClHSlGiigjumBzWgdtf46YboWyMwZYEFaBkYhfLLKEmsub6rwrYDUg
         +NIsRGod6ULM3cqjeLhvTfHB2HJDF/EZNnoLOuEDaqU+ia+tonQoOQlmtxGpEGQoARsR
         Sfh5NZ3P0gjvKP3Lu8vnyJpkTV4hoUkRyERtLZq1OdOH8XQ22nPBHvMZwR4SnhmLc2QT
         SjgDEQb4FsGHZ5FMrhXbRIrO9lrK+PrHxnzRucJj2upZpFH7FVwqmo25TAbCap5lyu5R
         izyhgDyaXjUFkmaT+PBHYuieW2TeCn84GW4xgLoH50Lp6lI/snvl1A0ynX4890wOinDf
         S18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783965435; x=1784570235;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YGHI47Uk7ivYjDw6pJp4pRueuEDSB7hHUc7Dm7encu0=;
        b=TsWLy96ixG2j9y0w3qlKI8dHSojxvEMc35jF44sPFM8vLsIy/50YMpqhdAIIeOFr4I
         zJUvP2ldBXSV+qQfJvAqHY+2CDKIwuXmQZ4UNNItMwGhl448a+Q3dC+bedD3BdEGoKrL
         iYyFb1aSxR6k7gR+uk9PV+FfEyUmcBIihef4HB5qPeS5ec0s6Iaz95EUbCP1SPU3y9zZ
         uLmcmjSpndBvsco8HZE9iyQpwNC/B3OxKaQ1XrZNUpKj8ATyShUw62wWEb9tBa4DiM2l
         KXPmWEcwyGXlPYuIJDC4Y1yL6jAt71IIhwsUGqpRQXYheqZpZsWg8oiXxgaavgR849E3
         ptDg==
X-Gm-Message-State: AOJu0YxkdOENIGNH0SIQGpBuYmi/xBwcGzb1OFhHm3ZSTADThJYNIszY
	+dk+vkJZGgV/75fJZy6YMTdu7IfVQsvwespK/xFVR+CAH+7f/zVx0sgK9hM2/FD95qw=
X-Gm-Gg: AfdE7cnqp/rTtv54jBHKGqjFFdYz38bWeRP9F90CFzPRZHhniqa4H7B+Hg7OE73kB84
	EWra1LkjIzbfsIeEx6Wl6cU8r6VgjZoazMnkGh04NKsn5jiTyckf4CwMCZeoZiCTtRlVgso2neW
	Rujia7W2H1dJRGgPyNMgOY3KxBxaGZDRhmQM10DPvoD+4VG0qMA38hvPQDJLeZNy0jmh/gQ+V2X
	8NWHtVoRVSHzcHNupfpJPy0boEZVKXquggzNSarXK7qXlCcA6qYrWIcGs+YjS0gaMcPJGvFd0jB
	/WdYhezTCXf5uh6rDmTy5W3dzzpuiUmLjPoTbp1ESFDvjdUNag+Vj5mQ0GdmJNEJsWg/1fDOn5i
	RzZdTzAd8+Otpj1aYlDO+WRPKX3HiUsnH7WO2oQtXmVw7oNttrvEiZyxqflsd
X-Received: by 2002:a05:6214:5012:b0:8ff:60cd:8174 with SMTP id 6a1803df08f44-904053d8c92mr120238636d6.60.1783965434905;
        Mon, 13 Jul 2026 10:57:14 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd50e082csm149305496d6.5.2026.07.13.10.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 10:57:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjKu1-0000000DxAz-2t49;
	Mon, 13 Jul 2026 14:57:13 -0300
Date: Mon, 13 Jul 2026 14:57:13 -0300
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
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v7 03/22] iommu/dma: Check atomic pool allocation result
 directly
Message-ID: <20260713175713.GK3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-4-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701054926.825925-4-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:07AM +0530, Aneesh Kumar K.V (Arm) wrote:
> The non-blocking, non-coherent allocation path uses dma_alloc_from_pool(),
> which returns the allocated page and fills cpu_addr only on success.
> 
> Do not rely on cpu_addr to detect allocation failure in this path. Check
> the returned page directly before using it for the IOMMU mapping.
> 
> Fixes: 9420139f516d ("dma-pool: fix coherent pool allocations for IOMMU mappings")
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Reviewed-by: Petr Tesarik <ptesarik@suse.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  drivers/iommu/dma-iommu.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
