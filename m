Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE647262A
	for <iommu@lists.linux.dev>; Sun, 10 May 2026 00:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778373381; cv=none; b=OGeBQ23ukqIdorlO8JvwoZLcVmLjbxS+fMNZhN4BGam0wPm7fXvtcEt4D+psZl7WRByUXoYquXytnqzAYm5wyMIk0rOCjhqn31EjaETpkD8TWEvbLrV7P9bcX7KBUcJnj1o+hK/sZruTTL8EY55Q9v5tT+ipkSyZTGAyRlupnlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778373381; c=relaxed/simple;
	bh=4dKt3nf1YTx0s1JbVwplYuh0SVf+Q7ODjqCngcJGATg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1TPh6CJhyl+8oF6ISs8Ej2FwgyzhlQ8FqZj2jzA++0QDpKORPlmhQaAQgABuRNHknG7d98lUClwd6lJpbm444FQicrEloXr+zkpA9OS8bctdIpeVqEJ6kegm7iQPP1Piakic4e54veJrFSfW3NhxlJ8CWj0i3fU+n1noIN3hrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=osz7m2Qp; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="osz7m2Qp"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50d880e6fbbso38017971cf.0
        for <iommu@lists.linux.dev>; Sat, 09 May 2026 17:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778373379; x=1778978179; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4dKt3nf1YTx0s1JbVwplYuh0SVf+Q7ODjqCngcJGATg=;
        b=osz7m2Qpr2T8ig2WskIYBTq4VRF+soEYNYcwCKVZkky9jRgaorfYbhPqP3UDbQ2gpm
         hu+H5l+aYgc2qjblD3yZx0Y9khWNeCLK6w2ZazcBPkbC8lN1pf3VpC7Wn5RUacwPd6De
         e4/x63RmEEQwZGNtwO/8LYdkgXYeAeI+ytjuBbAJ2Iy6be+bRGl/7J7aZRBzwuuyb+MI
         HmBZXSgKaNe0gTg0W43mp4RaAFycvNwLa/OARTeAcpY17oh7YohiPShbQVIHzMmACSPZ
         DgcAiF5nYLV5x7HKeuBfxatfkAPXPcHee3Jbpu5TwIbQwt8SDSNhGpTH1Xz5mtcEyDNI
         WfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778373379; x=1778978179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4dKt3nf1YTx0s1JbVwplYuh0SVf+Q7ODjqCngcJGATg=;
        b=tAf2LpgDQPbOHFb42K+7SFa7hXsn+3n8Wz4F4lXRji4qtwSA6fBh6ubJsHMAdxArhA
         tFBvYP/LEgCsCIH4PFrHJy3pyz1Nwec/kHfP3mgS8GzNV7nrvcrGD/nAeof/X6wdvsnD
         9sD05WksVjkLrnwNhADps3r5ks2DdaovtMcwhjwTGW8WsmCbecI6Gyh8lbLldMPA8Nox
         1YTaRe+Az6g/eaLj3oXZOzDNXNSkkAXZ9+Iz5yNk7PPcGAR2IJogkRKFSbpR5s0+xM9M
         lhqx+/F3Z9kz599VDd9dVG4PjUkAKmKWdcVT2ge6KBVdnoXY+jKBU17OsVr+urCxW5Ug
         a87A==
X-Forwarded-Encrypted: i=1; AFNElJ/EIDBxWnJWPwJ2XXgBqInz6XDb8LhNpwFG5vBINeJ6G4W+S97i/19ZgWVV2CaUGIXOUGW3qQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy0YlAEs6iNl3kvwnVCt+hPI7G7W+UnVwi+rVjQpf6vdjgMD+vZ
	tqe3o7Oq9naKJUW9Eo9JrLtVnWe5SKB/as6DPoKPriX2wGwSlwpXx6Ss2sd7U9pSWKI=
X-Gm-Gg: Acq92OHlE0/1QocZdtUTWnm+cGRLu7aOj4fWFyPiXD0TvzfaFzuP2dxE09Wg6aSvxzF
	wsRPgENPmH1ZgH1UQ1OcU17WgTunct7CD3gTSMZxWZQ6H9sgF/aqWot8D9UQErWPgLIePdko4hj
	8Im4TnLnkl7NfNa9BWuCVUQgax0yqCQ7GxmvPtJbVSYnlChkl8KnWQudnAi2r7toMv2mLHsuNTt
	y/IerZFS6K4kb0nj3yENaYhuscFek45Qa8ULD5sn2G7B+qyuIvDvOOCriApDzn7Q4Fro6eus72K
	5GdJ5QpEYyG9uAtLM6jdkLb+RB4uZbYdutRiYnFmWF4ir4yRUXsHKyEqyZpxlD+YqDd9UrcUTRw
	cPgoVMpk/qXqbktG408TnN9u1GgmGO7mWZIMhwnEVGqx0AFZ4ztmlyCMLwS73TRWzTTsczE/2wN
	7PVaBCbIQ4IBFvN5baIfsGQr8wkvSsouCtzjtu7H+OcyB1OCsbc3yhMwDr6cL1k1L68IWvZjY0W
	oIe+UXMg13AGCKa
X-Received: by 2002:ac8:590e:0:b0:50f:b61c:ec4c with SMTP id d75a77b69052e-51475b5a04emr163550921cf.7.1778373378744;
        Sat, 09 May 2026 17:36:18 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e656452sm60664161cf.7.2026.05.09.17.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 17:36:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wLs9Y-00000002W2B-2GSI;
	Sat, 09 May 2026 21:36:16 -0300
Date: Sat, 9 May 2026 21:36:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH v3 0/9] dma-mapping: Use DMA_ATTR_CC_SHARED through
 direct, pool and swiotlb paths
Message-ID: <20260510003616.GL9285@ziepe.ca>
References: <20260427055509.898190-1-aneesh.kumar@kernel.org>
 <af4dK-0HEsKdPAvM@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af4dK-0HEsKdPAvM@arm.com>

On Fri, May 08, 2026 at 06:28:11PM +0100, Catalin Marinas wrote:

> That said, does CC_ATTR_GUEST_MEM_ENCRYPT actually make more sense than
> CC_ATTR_MEM_ENCRYPT throughout this series? We'd need to change arm64
> realms as well to use this one.

It is often quite confusing in the DMA API and iommu what is guest
logic and what is host logic, so this does sound nice. AFAIK none of
this forced bouncing, T=1 or CC_SHARED logic applies to host in the
DMA API.

Jason
