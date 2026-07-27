Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71CB3BE62B
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 04:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785126251; cv=none; b=duZo/Bcpjr7WxvyJsFjGXJHorqDK85fDbMJyxfUEwpYCM3AHQJOxdj2dU0w4t3le8uZToD1XNsM5jdSyPCAFhwljqmPRSfAhsxoaVo+eOp0E9tTq3b86VTSwA4zSTaDi2svlHC3sXpg/hOAus0jfI39McnoA54yYh4T8GyWSIFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785126251; c=relaxed/simple;
	bh=Yy8IISh+FV9cpGipg7vORYQVek5AJgkZkfEGn4HmLng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qB2KvbcD0BdSq/rtMqGMetu6sYB7gHxM3WRHVsHBMtAaW6HtgFkHmVBzNzH/djdN01s1D7C+XzPht5ACplU4Xx/msBfUcrL5hihhfnhwoCLRpJse5Ca2UHwbQhrFXDAMNXsF+QtzqbswFn4Sob7tfEmc7OH9WSNIKhq/GMAWLBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Pw1KYJHf; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Pw1KYJHf"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38759bcd877so1322243a91.2
        for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 21:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1785126249; x=1785731049; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Yy8IISh+FV9cpGipg7vORYQVek5AJgkZkfEGn4HmLng=;
        b=Pw1KYJHfdhuaa7Zzdw1pfCwXzNL/74j3UzwHZqbpJgtdJESbOeslLyun2Z5xrY66QP
         J9Fq+TDu8+f6sWdVdK+eWlZaEmJsJcl3xDGT8UMBE31j7BjhsUlRljZcJNYUwvJj/ZbV
         45ObXrjsRdzu9Bmtr0oebykxoXgtA1dQ3ZdIHVXrVd7FbwzLbG/LL+ldxfqaEEt9uyHJ
         sE0x6iHHr8u5pStPK9nqa/S1BdbZ5XE51MzkgZnZojzQ0LxSiBAdCW8VHSLQy48VTmtC
         yp9UCMt9QsDVrw6VKr42V4CSD1PHjJvXGOdiT7M14e4J3xXEzbXN/lmvn++cPWNZmwWu
         yVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785126249; x=1785731049;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yy8IISh+FV9cpGipg7vORYQVek5AJgkZkfEGn4HmLng=;
        b=Ppj7ZwqfBJIR5Jwm6JPax78s6wxsIRDt/rO00Q60W1CId7X9fJ77zAh0qRyfN1Az07
         o4cs2YcnG65DWyWVEXWQlhE8V5QfgWiTrzYF367/88M+xZaTkTVE3agkeBfqcBcqYhYG
         R9Lo5/dHdznHq37Yad2q0WvyFGOTPZfhVyUemO62h+IYXSzzitWIy4jRNsZzz5+5K07Y
         SySD3NaFAMYUp0TSEEhFVajD3ZklMmMkArhUbIJg0Gn/wmtdbfvxStUsrWviBT0PmXKX
         pQjCCGQNKnF8QDPqNBgmzxBPtkLywot80x88Fmc4ee7GJJHOyXGjHC6DD5e9ggLKse5W
         G7Ug==
X-Forwarded-Encrypted: i=1; AHgh+Rq05btmUJHoegOZfIM3C5Dxsbki+X+Roj9nKI+OZDBaoSNDn4BVH9OR3mXdRHuNEwkqhI45gQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx9dPw+UTxtDg9yfeafzTPyZ8C4WDfSOfJMd9wYHaGcHG8F/Y/4
	cF1aNy4AGby/2RhVfNCE5Wu/hbPyFndLQMJ6DsuNPBcpqgzEb12y/D6r6DEU1r2+WtU=
X-Gm-Gg: AR+sD10tgRKwPIFQ8ZCwrsLE+wpGMSnZBpNphLKYnCKwsB7v7FrToeoKetzhDQXqJix
	IN4LXQhPZ17CkG+oluhvN64AlsVumYsACffHgnvgkQN6NWLinK/5OQAhWCyWe85UGqpwYFh5Yvc
	S9UGvA9Wj7PZb5Q5hsLzkZ5pnA1L8kzQ11sTes74K4oi2hyAlrbikTAS2pK9aAQIBASs/fI/Ivl
	07bp0El/dbWi33qsRmp3UFghWY0KD5GLWUEExoHO7pMVcvQia9RWabBYLXdnm4aSp91Q9bJOYBi
	qWyLVpD6JXW86sWri1h4cdTidVqqxYRMR7sEwRSzBGKENMoH5ByWTsUnFftc29vKBDwcDFuaWjg
	FkNxJq2PXg33UL7hJh+XyVMaOhxgWbd7LPNgUrZsmPEp4osrNSUWgaxJ6IUn+mQ==
X-Received: by 2002:a17:90b:5350:b0:37f:be6c:f3f2 with SMTP id 98e67ed59e1d1-38f29399845mr6819950a91.2.1785126248497;
        Sun, 26 Jul 2026 21:24:08 -0700 (PDT)
Received: from ziepe.ca ([64.114.68.211])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f041b8be9sm4471929a91.14.2026.07.26.21.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 21:24:08 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1woCsf-0002Mt-Ls;
	Mon, 27 Jul 2026 01:23:57 -0300
Date: Mon, 27 Jul 2026 01:23:57 -0300
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
Message-ID: <ambdXXcfgK+cxqxa@ziepe.ca>
References: <20260717180442.110954-2-aneesh.kumar@kernel.org>
 <20260721115456.GI110966@unreal>
 <yq5atsps77c5.fsf@kernel.org>
 <20260721142921.GN110966@unreal>
 <yq5ao6g0750v.fsf@kernel.org>
 <20260721153321.GO110966@unreal>
 <amEhEKQW0_HJ9cLN@ziepe.ca>
 <20260723075704.GC110966@unreal>
 <amTJY_CdE-uDgoGG@ziepe.ca>
 <20260726081753.GD12003@unreal>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260726081753.GD12003@unreal>

On Sun, Jul 26, 2026 at 11:17:53AM +0300, Leon Romanovsky wrote:

> Currently, the phys type universally describes memory and can be
> reliably translated into any required representation. It is the most
> fundamental type we have.

You cannot go from phys to page reliably unless you make assumptions
about the phys, that's the whole issue here. If the callchain expects
and intends to use a page it should really stay in a page and not take
a side trip to phys.

I agree it would help to have some helpers that were more phys based
for the callchains that want that since we are mixing two fairly
different activities in these functions..

But making phys the only output out of the pool isn't going to be an
improvement.

BTW how does a struct page even work for decrypted memory? You can't
actually use it that way right? If you try to access it then you'll
get the wrong IPA and it should explode?

Maybe we should be blocking the struct page path entirely for CC
shared?

Jason
