Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A8A3BB48
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 14:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779202185; cv=none; b=NdrGnrLla2L0025NiFAiFqnR6/3hLJNOBy81Y14U1Mf3iLgv4sJoq9mnuLFPaRQTEZFLfyfjVriKAjgSkTmJdt9O2uJxg3cXtyxWHyfKV9Tc86UG0E/TH/6VE6lnPJX2ylJC1NdTpavEZLmLuhS32gG+9XPGWveXzZPyFdO/zM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779202185; c=relaxed/simple;
	bh=mf/OGUGuIRiuTTXYie0rUXZGqyUUzS6jn0J2l0v1FPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5Z8JYOsv6DuWZdqui3TdFuxW1K8JPtO/PoKpDWFsLhgrxSgNQtEWTKn4tAjJ1T+6G+JdnUoJjViLJUqOavGpnQqB3Ftt42qjrpXJnYutCQRwdzOkcLGQrjrPfoQJJTAY7hUfj9bOZbTNUGZdsNwTM7QNgb4NB/+TXEb1mdBjCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=JWo1lpzw; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JWo1lpzw"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-910bb291688so455560985a.1
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 07:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779202183; x=1779806983; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mf/OGUGuIRiuTTXYie0rUXZGqyUUzS6jn0J2l0v1FPs=;
        b=JWo1lpzwiYCVHyZ0UvWbT29Jd75eQ1vERIvj7BXnyQInTT9Ulw/kEPsXvN+ngtRrNf
         CnOZ5jenWwwTt9Dj7HDJjfwasL0haFfnVeb60t1D8EdU8qM6abc/tVFQb4n+HsHpEqKh
         7era4BBDZdMFB4AT01RYMDnm7yLOszWD0wgwuflfqPUUb5hq7l7HoyXWBF8L1Yw9saU1
         zHzdl9rKzTggG8TEPmLcaSPhsfz6IZGMDze3wOO/03COGTulNB8QAW+GZJRIUIS3QAD2
         mq/Po3hqTHBP5GMNYlqZw9SPfa56D3wG59prR7bFMKHLyuhlYt3aYp+J+ILyQiFNhjwu
         B95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779202183; x=1779806983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mf/OGUGuIRiuTTXYie0rUXZGqyUUzS6jn0J2l0v1FPs=;
        b=r9SIcwreIml89Y7jhv45KqOmejj9Gy4o/BnOsreex5fKc8hqfDb9ADxU87YuLl+Q5T
         TCpOxDYXSfPwVuK5JSblU1q8/019431Kl+ppLiD08Pa+hEQsCzTtonRi6pOpommqoCVg
         3pkXTrzDjHxOjOMbEW++/RhonTQGvaz6QbgRHf0kfdcgN1KHfYS50dmCflJky0Cqbzf9
         Q5fIvcC5ANjAvVtiaZsSwhST9pdc3jHoHqeriNdjeMCSSDEEjXJGGO+rQDD/tO5PHNYQ
         Zs/kyNVMsFd7o84wivk4zda/iCfQUoo37n1vjpo5OR++MWHEVbZIRL+guGaIF94rlwrH
         m8nw==
X-Forwarded-Encrypted: i=1; AFNElJ84/g2Fe+JICJFywWMt9r/tz14pg9+dIXH6cpFmYQIjNmWhmqYHPOiSAshkRNjdKUq6h/pzlg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxVDl4GkderEYIxuhn84LnPKpTuD4ZTn9NLHEEs70VAjVK4JLoY
	CZVm8oYU/kkrOzNxsg9uz20JwZJKpkl/pAH4b0wHV7a6stQbKl98Sty23OjOmCzc6DE=
X-Gm-Gg: Acq92OGK5TT8o63kbuHZsE2NbrGFv1unwQlu3QluqU0pemrjReHw8Znp6BGj2dE491T
	acQRk+gLTESDvk0l3D1wJIuVwTOQekYxcgT+v4UU5LVj6Xiqzl/hqthQvKc4zSPX3i7wbJDaEla
	nrDjV6YwxikrZiSnhVpmw3lA2Zq0y3arfuIUt1so0Ofy024B63Uo+z2+910VxTilsYXpUp7NP2U
	nBAWIOxSSSVqvTJNUm6EnF+oUTrL8g6meHB8VVzRbMLs2XWYUnFmOrkC0GmhzrvlL7B6WCV+UJh
	qkZmUjhmPu+Fw4KFHDS43fHvk9Qqr4Dm39ro+X6an3ZYl2Ikct9pJe9zVMlfuhmF+qJdfcm719Y
	xdnTIH7a5g0AZzgkwwU7uy13d90tdB9i9Ew2r03GZrFfbSM2P7opQfyFQ5wLYkq216jCR/XdCxO
	Gwc/HYOsfbFFdaIyGUNc5ZmW9aUerNSfZmQHkxQk9tvSE8YMXI1/TuXRPSmOgmeP0XxzpxrAk8a
	o4kRQ==
X-Received: by 2002:a05:620a:1a14:b0:911:411e:2e4b with SMTP id af79cd13be357-911cd46df94mr3109274985a.23.1779202183344;
        Tue, 19 May 2026 07:49:43 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba36e68csm1851459085a.10.2026.05.19.07.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:49:42 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPLlO-0000000F92G-1VL1;
	Tue, 19 May 2026 11:49:42 -0300
Date: Tue, 19 May 2026 11:49:42 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v4 04/13] dma: swiotlb: track pool encryption state and
 honor DMA_ATTR_CC_SHARED
Message-ID: <20260519144942.GJ7702@ziepe.ca>
References: <yq5ah5oaa63h.fsf@kernel.org>
 <agW5rhE9n2gDQ0w5@google.com>
 <yq5apl2y5f96.fsf@kernel.org>
 <agXaby-7L7yS3Vva@google.com>
 <yq5ah5oa59wy.fsf@kernel.org>
 <agxDxdxynp4KEovA@google.com>
 <20260519132911.GA7702@ziepe.ca>
 <agxolksC_1nfO34X@google.com>
 <20260519143529.GD7702@ziepe.ca>
 <agx3j6Oc8QivZ3RG@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agx3j6Oc8QivZ3RG@google.com>

On Tue, May 19, 2026 at 02:45:35PM +0000, Mostafa Saleh wrote:
> However, it should not alway use SWIOTLB? It can trigger decryption for
> any memory returned from __dma_direct_alloc_pages() which can come
> from alloc_pages_node().

The alloc coherent flow is seperate and different, these are not pages
'passed into the DMA API' but pages fully allocated internally and
owned by it.

Yes, it should cause decrypted *allocation*.

Jason
