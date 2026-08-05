Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C3C3F65E7
	for <iommu@lists.linux.dev>; Wed,  5 Aug 2026 09:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785921026; cv=none; b=GLmx/WPbmcYGUvIe4PB7G2FYhpAvfow4E9hUjzCJbUH/dcjbSs97dchvnLYE1TTllkfTWJWEW2+kW4InLkSRdUXYyMT5Bx5tqG3je/qNQ2pbg9+4030GVm50Inldz/FHmPSaT/wi8Qg59cg9RdLDw5BMsNXaApZA7B+pima4szw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785921026; c=relaxed/simple;
	bh=gINDk3IoAOl14/uSe78s8gXta9IkyDgK1jiiLUqSSAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOWbiEs750pb4Sygw4bto6kdRw5/GF6+Wg48C93tgB9Qwl7VPp/3z/IqAFWVfyRHZOEnusUl/5T53XHhhMXNDM/MqJQmHvsy+9tABiIcVWu8Zn/ZnKvm/QUptWhCedXytO9tJAnKOXY3yuFYmgzcp9ONK2WHFOABUeK+Sq1OP+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BPQ2Zo3O; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BPQ2Zo3O"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4954d5d814fso46445e9.0
        for <iommu@lists.linux.dev>; Wed, 05 Aug 2026 02:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785921022; x=1786525822; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gc5m4+tIBvg0egjJhph4T+RN5CfIOJByD9/EsS70PrM=;
        b=BPQ2Zo3OzLwoxVY5DhXz2e398BXYvN4DBJLZXLpVDBZy3gurjiCcsPcHscumAAMOZY
         pgmqaRZXz0Q8nczIetfwWcFhUdS9iJnI5REpXa6tCvJ8O63dervHaM0yK+ugsNrtbPc7
         TOTsivvNqeGv0obR757FtAka2lQx6kIGRJeJCrHZwaKE6wTMwoxY/EiZxsr6f8kpsJ4p
         Fkv4YVhOhVDPtwPBQNZo4N1NkLIr0uCKI3ZSKwerzzHYYq3TR8pm3gei1w4jqzi3WuNm
         cQhmJoZCTaik6gRyVyj8o8at8MN69mwMsUvb1aB0TL8G3uyovWrHdi925JQNZ8K08Dd9
         eWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785921022; x=1786525822;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gc5m4+tIBvg0egjJhph4T+RN5CfIOJByD9/EsS70PrM=;
        b=kG55XDC1hSALw47fwxGs/L8Bz71BHP6iQanQTbH0TxX6VGelUk768SQBm8320mvlS6
         eWeFpQ41K7vK9TP+unvlipzJyzTy5fPijDxyLhcajy+wqOSCe3dQCtLghAmfdBdq295E
         qv1MGkXuQor5In6rjNvnHElqqKGSVgK97LwMNM4vY7eoAQLSd3hUIEW5rOoNOUUEQGrg
         FXnqFhrZ+sHZtTcAmaGS1KI8m0Kx0CTALKgzc2msI/CcAJjIjHBWy5ue64jAwKLdggjd
         x3nj2fo5OonHvTwg5ww+zTwbYZdecoK7j6Jrfvp12duAFv6EuqPY5K+aJL4GrfzMUacP
         4Vlw==
X-Forwarded-Encrypted: i=1; AHgh+Rqx7FrktJoyaTS8r4HEt0zZwXYOlv3Ff/s39XzYTOvko9N8/0QAnXQrgRNxUhaVYdBMReFqaA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5XQUdTtn/9DSevugfUQ5z0lcAi94j02DrPI7Y+xlN1gTXRbMb
	OgVm6PBf6OtOQfCD5HKSweYn+lKrTKL3B9hoC6MXmdvGvQaMjodytitruXiRlOkGhQ==
X-Gm-Gg: AR+sD10YGHTPz+/4sGczI2g3jDdS7+iuuELspa5u2vJjB0n3QXAvG+sReFydX0AQM9a
	T/rryaz4b/9oMzpj5xg7MysxMrVx3nDkU3j6kfT1nwv4abuFrQiGA+CyagYPF2xFurGn7Od6pgW
	KIhFbelfZ+70dJpthXgfsyvhRmoUsWxCVGe/I7UR4FPszECWVrzpLVit+5yHB7gbYOVEBs6gxDf
	tVL3EgQv93K2iM58SC8Hz/e4QlGzalqqNuG78X1HKB9aC5Z7Y5duUGPwZkUruDQpSelg/515XOe
	6e7Jj2NVnzsPz5LT8XVrtbfiiGqEPim73UHfJDt2hDFJhkeJiFDZ1mvtxiGfxlbQMazo38BwU/y
	FevxZW+Wi8x5nI1ds0lZ7KItjNs2k20iOMnb4kACaYG+EhEo/gB4lpSDUYSoUazRqU2NibefeUr
	TiI1A1cLDgE7PAbPwsb10s3A2J7vDgDR7vOEmB5fIw8Z7wt9hbtJD1XNB6ghUIZThANWkcFGdOs
	R/JJr9Kc0rbrjkw9h5qYhuA49KqNw==
X-Received: by 2002:a05:600c:630f:b0:495:4069:b0de with SMTP id 5b1f17b1804b1-4994f123620mr696915e9.9.1785921021836;
        Wed, 05 Aug 2026 02:10:21 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994dfda45asm92632815e9.4.2026.08.05.02.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 02:10:20 -0700 (PDT)
Date: Wed, 5 Aug 2026 09:10:16 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v8 12/23] dma: swiotlb: pass mapping attributes by
 reference
Message-ID: <anL9-OrDGqYQAWNV@google.com>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260717180442.110954-13-aneesh.kumar@kernel.org>
 <ami_mpd_1pF4Tmdu@google.com>
 <yq5a5x1ygo7z.fsf@kernel.org>
 <amnRB98ZZIysHuM3@google.com>
 <yq5acxw6dl1d.fsf@kernel.org>
 <20260804142032.GC27883@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804142032.GC27883@nvidia.com>

On Tue, Aug 04, 2026 at 11:20:32AM -0300, Jason Gunthorpe wrote:
> On Wed, Jul 29, 2026 at 06:12:38PM +0530, Aneesh Kumar K.V wrote:
> > There is a possibility that we may support io_tlb_mem with cc_shared =
> > false in the future. As a result, only swiotlb_map() knows which type of
> > bounce buffer was used, making it the only place where the attributes
> > can be updated correctly.
> 
> Yeah, +1, the attribute should be changed at the same effective place
> the source memory is changed away from what the DMA API user
> provided. Only the thing providing the new memory (eg swiotlb) should
> know its properties.

I will keep the conversation here instead of 2 threads.

That seems like a big leap, I'd be worried about devices that operate
on confidential data that should not be shared/decrypted.

One example for this which exists in pKVM (this part is not
upstream yet) is non coherent devices that require bouncing but they
still want to keep the data private. In that case ideally they get
an encrypted SWIOTLB pool, but it's always better to fail than to use
a decrypted pool behind it's back.

I have not been following the work on T=1/T=0 devices, but IIRC, they
required some complexity to handle their stage-2 as these modes will
be emulated differently (for CCA, RMM vs untrusted host).
I was thinking that it might be easier to represent those to the
guest kernel as 2 separate devices (bounded to different groups...)
where one is trusted and the other is not, and that way the DMA-API
can have strict rules about memory sharing.

Otherwise, SWIOTLB does not seem like the right place to me, as it
does not understand the context the device is operating in, and the
DMA-API should deduce that from the flags passed.

Thanks,
Mostafa

> 
> Jason
