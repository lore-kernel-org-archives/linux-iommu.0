Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A82448D03
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784032008; cv=none; b=ahgv1YeUfChIvkHybyv5LugDvFUNb2rhNhWo9I4AQZUfde/i+Gn1cSRKu5LsWbHJi3AZNrCqVGr1fZC5n1fbQ8+m1JwdvDSxAcF/nRwXJ6g6SM9OWz1R+6hV/Chl7euSHMOkK5IPAoK0JtSnJ340gNewEJIJWg4hL7/dP3OcnJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784032008; c=relaxed/simple;
	bh=EyC6N0xAwYeQ07+jukS70K/lUL1qxajRoHTimoin/A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiExc3flOLoK33F71owPem4ZyDM12pPh9lSyfdnGn6AvTmJXOhjpCTo2Z3MRVW00gXYNT6dBV2jpdB/2oE/ytWfiCKsXLSQvyh+haP7Xp9iQxYVWhqLbDt66JREwrnYMpcrITJp4+W2U4CvG3xWf0OaQ6hdDbhqwPweIVHP5SvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=L0yA85kH; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="L0yA85kH"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8f18d92172aso12773556d6.2
        for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 05:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1784032000; x=1784636800; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AuDF+BU2wT5tVoACVa1l/BwLN4UR/axOeynKCGX6Iio=;
        b=L0yA85kHQF8+wkjsigpzExY4sdESVtijrkU3MU4WO/zUtiYbcb6mE2h9IIxVRY++BP
         3w/01FtRvxbseCKNxuxiS7gCdVIMUV82KEECbN8LpslqP/dw2Upku8Lg5EtxqGxJze+W
         dYad37BnH29imANUVOVQiVosB25zD3Tbug1xqfDHrDSHI8gSg7WoBN/Jkq2+PqTdVDFc
         QeLT5ECLisoWd/xmz/c2fnc6L+/4e+4Vw7WkLBsPduuZVoW95erELlzJm+zAhh5n+4mR
         tqBQlGVLUtN8A6mEN1zI/GkIXsKgSnQnUOMG7sx+TAR+AY/K2k4vEhuE9O0so2/mrC1E
         x+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784032000; x=1784636800;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AuDF+BU2wT5tVoACVa1l/BwLN4UR/axOeynKCGX6Iio=;
        b=Wb4Dh8J7j6dmFLKvaIc1tVfzgBVM8HJbSMA6wCIbJ0gkRNo/wdxVVrAsmg39WPLJWF
         aVo60CPP7Is30eH3LzVnr93Q+9BoZTaLq/wzDpnLDNONIKAAt64CUCOHltjc6Ds+oqDY
         EDJsdmzSoRHNy7MEEvn5XE1qibYWFC/EmIvwbrihcx+xaY0ozxhzdnJmmeTo3L4Cw2+U
         EFxj4PfLaruj/2AUfRH55n+A+XffcXUHG3K4XN9tgy7fklMJpgI458ecOsV4XB0qoXgl
         8aHtx/pMUhV5ZHYAQFcoAgjCv0hBXsBf2vwbTj5NVeCYHUCh9NJiFvmHp9si8aOfMtuo
         dfXg==
X-Gm-Message-State: AOJu0YwIhJ1YONX49sletYPx4aNuGKcKr6uwwJFsgHAQZ0pNqJsOJB+c
	PdKnbwD6xQnTcaYWn1ZSlgr8hoMw4aGWsb87YqetXqQXnL5UaGUKFGjJBMVrQMmDhfSIBWpg9i4
	1lLzu
X-Gm-Gg: AfdE7cmnW5bmdPzTAD+Q5JWx+9/aEa4hCk4TlGI+M9zSod3tZQfNrKSpYRf4J4TmYT7
	I10Ezz7DjtTy8CS9MnkxHJ1DMwGqjVZXklcGgLyQ+07L0ehrSF7RNmjkRwws3/DEYIowtGmkNze
	cXHK8bibv+sULR7ugsxYna5mUY4wi34QOOS7HoBCiqa2Q8jfuH3nkkrkajM1UK4NEewQAAg0Rif
	BucpZlQJJSA68zid5lHdzGO/FBUDNr/Ike3Hp2pDywhvvafS3cHE5ZoTtSrgS1iPgw9QBDFe/dr
	aGJcGVU4+hrfyVBz2y0H6oSit/MLvEQGB7afj0AF7k2ZU9YOBzrO+YeTGup9EH1kVCA7ox2+Sej
	Gzl+RkaqyjSTOZG13o2nDXLU/Tp96jT5o2uKQ2GGT0P30tzNul7hAI4P0jlP7
X-Received: by 2002:a05:6214:1cc6:b0:8e9:f5de:d629 with SMTP id 6a1803df08f44-9040423dcecmr141353846d6.56.1784032000167;
        Tue, 14 Jul 2026 05:26:40 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd7c1ec84sm168106996d6.29.2026.07.14.05.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 05:26:39 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjcDf-0000000FRvu-0Ugk;
	Tue, 14 Jul 2026 09:26:39 -0300
Date: Tue, 14 Jul 2026 09:26:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
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
Subject: Re: [PATCH v7 11/22] dma-pool: track decrypted atomic pools and
 select them via attrs
Message-ID: <20260714122639.GH3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-12-aneesh.kumar@kernel.org>
 <20260713184810.GM3133966@ziepe.ca>
 <yq5aqzl6mc00.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5aqzl6mc00.fsf@kernel.org>

On Tue, Jul 14, 2026 at 09:57:43AM +0530, Aneesh Kumar K.V wrote:
> >
> > But I don't view this as that important, the CC hypervisor is probably
> > going to use the S2 page table to force cachable on all system memory
> > so the non-cached pgprot is a NOP, but the extra vmap is wasteful and
> > it is confusing.. So maybe a little fixme is all that is needed here.
> >
> 
> Something like?

Yeah

Jason
