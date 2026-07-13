Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A07145B11
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 19:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783970705; cv=none; b=dHuoE6gm2qVHp9vDrfJg8w2/5TACUF9brEfpVhedB0AURCOCk4bZOfDDs31JsDsDAFHBSQv6/9wlPeo7+M76aYkqlLBCSxLaDT0FmNblKTByBQobEHcPp9JmSrcBDtu9dl7PZNb5j3T547z5gswd22xD/FxEHsBuEXK2jeM5K9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783970705; c=relaxed/simple;
	bh=kHNC6GKxK3Oa0yY2t9YDWJJoMMfSAWNNMKsiuCwI/8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJmMY7gO8lUKyW8vZ9qEOhcmZZjGnPelzpf9lrNVEZ3A/JAKAu9YQ843UYJyXtk9kXls/uoZGMxaWWYbqOpaqGIvu8x+Uw0pG88TdRgams0DEUka9SQ8IUwMvTqQJ+v+3MkgKFxGZf4dTj/cFpf3v9zD4egYY+F9nTVj6sPquP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jLNxWQYA; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jLNxWQYA"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8eeadbc5e21so1552206d6.3
        for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 12:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783970704; x=1784575504; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2kWy2240zOoLDDzwtKisgk31mZ51kjxw8fZyoUW4j0E=;
        b=jLNxWQYAKhcwZh4bKXPk/cHss0xSLS1DUNtpr05kzfApJ5tb06I0+VtAnLWXlDuXRg
         j6jFWR2G8NWmHxJY+4vy7pvXcxw/TWR8TISAAKuL8Wm5/5hYo5FJuvhhPRZihW5hnQev
         7ffUilvUIYZXoMLljHV5wt9ITNPpfzxmlXWsvssEn1QwHiOgHYkwfjPoHnpM5NOenFNj
         KTzI2Gvl2SKSRVR1wrL97DvpdfsRYg01zhR7MX+DVEHve9QaojnL1HYA3ZDsPFehHb5i
         ycGqhZLZ31m3PgmX4Ul8Y6naRkG0H9aUcAZkvslEVSZbx+ANWrPTvBvQ6H/HOxC7N3yi
         /LQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783970704; x=1784575504;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2kWy2240zOoLDDzwtKisgk31mZ51kjxw8fZyoUW4j0E=;
        b=h0DB4IwDMtNFHUCyHR5l4KjIvXJ84sj9Guv5pru8C/b4KAtv8bhu7diI5B91puCUZL
         E0KKmzzBUjlaDpDuQdp/eheje54t/ZvSbbUKqSlUZ4Jmzu7mUlVNLa2PIPrltuOaMaiq
         T0wpPF/ykqQs7Qklts3gqMOCj85tqw7tF0llrIEQiY5HeRxsgDurPD3j9XPnprLCepbV
         8TxZ7q6PUOPh1fHjDdvcTXVr9Nac1mebZv+G/XPlfO3P1PaBuyXOUuEPI8uSK1rYTsvv
         ItqWl1WxI4Bm7A8L2z+txH6UsbP8cyke7ZkUIXmNHZ8a2GHro9LF2FanfLXS11lV6p4V
         YJFA==
X-Gm-Message-State: AOJu0Yzd7VQQrU5SZp8j/oSrSGjraCQyz4GVmPtcyT7iKrhfQ8qgassw
	zvChBP0/1mWTBS9cciN9L7xyxZJ+grz2rvbcL2eY4T2zGd+lxb5UKKQhvauzNDffB6g=
X-Gm-Gg: AfdE7cnFwMZhzFfuc7X76NHRp6l54t4uvf4cjZTyIztl2s5H+HHUhJaZipXa44jfuBq
	lHNf0fqfFN9c3fhyrcJv+iFFPttLxG5AkeOodVuKbJpPCrZXvwOrz7J4yqoqnmijGz7DhXDs8fb
	zaoN8nnBy/DPEgJWDbyQOw2/R+l/LLvg4vsVHjrG9I5wox9jVMFyx57mjjwW1QK014trndH5oUs
	sSZ0qko1OfJ/GhGpfvBAf0tlQHHmcPiMkijaLz/unPYkbTSeWrpLSZo38gKvyPZmC+XSkzMZlhI
	VaOUE2/a4oGxH/STzQku+i47M3wKeV2BS2yJXSI3gpt1AXjVkwgkZhDTFoHIGEm647/9sbVaL6U
	N22ZiM0unjNi49Qc45v4djhvckcA6cvyAP7F59XIHIqZkqmD2YuxCjhjhHy1t
X-Received: by 2002:a05:6214:2f8d:b0:8ef:76c:cb18 with SMTP id 6a1803df08f44-903fe450e81mr122377626d6.11.1783970703547;
        Mon, 13 Jul 2026 12:25:03 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd7c1da1bsm137170026d6.30.2026.07.13.12.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:25:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjMH0-0000000E5NW-1O3S;
	Mon, 13 Jul 2026 16:25:02 -0300
Date: Mon, 13 Jul 2026 16:25:02 -0300
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
Subject: Re: [PATCH v7 13/22] dma: swiotlb: track pool encryption state and
 honor DMA_ATTR_CC_SHARED
Message-ID: <20260713192502.GS3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-14-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701054926.825925-14-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:17AM +0530, Aneesh Kumar K.V (Arm) wrote:
> Teach swiotlb to distinguish between encrypted and decrypted bounce
> buffer pools, and make allocation and mapping paths select a pool whose
> state matches the requested DMA attributes.
> 
> Add a cc_shared flag to io_tlb_mem, initialize it for the default and
> restricted pools, and propagate __DMA_ATTR_ALLOC_CC_SHARED into swiotlb
> pool allocation. Reject swiotlb alloc/map requests when the selected pool
> does not match the required encrypted/decrypted state.
> 
> Also return DMA addresses with the matching phys_to_dma_{encrypted,
> unencrypted} helper so the DMA address encoding stays consistent with the
> chosen pool.
> 
> Tested-by: Jiri Pirko <jiri@nvidia.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  include/linux/dma-direct.h |  10 +++
>  include/linux/swiotlb.h    |  10 ++-
>  kernel/dma/direct.c        |  13 ++-
>  kernel/dma/swiotlb.c       | 177 ++++++++++++++++++++++++++++---------
>  4 files changed, 162 insertions(+), 48 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
