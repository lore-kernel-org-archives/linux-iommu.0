Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4276544CF59;
	Thu, 17 Sep 2026 21:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789682181; cv=none; b=ZRf0sc6nKV0yRrg8XOa3QuMmpdBzBQX9ux052WA12uqiwRDjDzuentD9tBdnxiGPXKtMiBL7rzbOaRAEjTgh7H2wO/XmUk+u7LDABj8UMCD3EcebbI+B9uwu1k0L67LTdjRiWvVlASJVpMxw8TqsPAh3/auH9fcg0fC43d2+CxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789682181; c=relaxed/simple;
	bh=kZUPYRTkbOTsPkrA61kDMuU4eYK1fWe8yBTv3Q95tKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0jGipxRLmR0ioG9nbxOuc3DKlW0HiSIGNFgJp76pOze2ML7Z1UYfgrHhyj6Fz15rpsRwIAEJbVJ5nnpg1Cmxsbs5aBN4GYUP1VwxtjArmLwKTV7Dvq6joysBLqPMWQlFpsfNDrW6aeXFBhqhpC/7N8tNU+Gzs39v7508JhpmOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1Mdag9k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1Mdag9k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93FA41F000FF;
	Thu, 17 Sep 2026 21:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789682179;
	bh=5NhZ/y4a+dkUa7WaLlbHkeAQBTwZUNqbVt6sm8GoTkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L1Mdag9kmnPe+L2tPYHLcz67jASLAJHRTXbLRL6FwDWypq3Me5VmVOJNpahpirJUr
	 gEsrTsb4nt+eg05Kke9kTilWmPAyVnbXAZ2QqEIckXNOxU8Nc03uHomC6TOH25W/2K
	 z5l+kA7XR1hsKOVXM9nOrECRGVVSTOZ0fYqJJ4d/qsSPlA92WfCU5Jhz5VgBRKk640
	 b+F2H3fiHFKhDUNxqU1GLBt2Ks6ayctuMUVHHspuUBp72wI7bAIxxIjtCNIMAhHGB1
	 kVbr6OldOAOOfF9euNAChU/YRakT3Vou1QLZTXALxAI02xOX2wLGmDaBhTwt/LCZFD
	 fiZ6QpTX8Oq4A==
Date: Thu, 17 Sep 2026 16:56:18 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Wandun Chen <chenwandun1@gmail.com>
Cc: chenhuacai@kernel.org, linux-kernel@vger.kernel.org, rppt@kernel.org,
	m.szyprowski@samsung.com, x86@kernel.org, bp@alien8.de,
	iommu@lists.linux.dev, saravanak@kernel.org, pratyush@kernel.org,
	robin.murphy@arm.com, loongarch@lists.linux.dev,
	aou@eecs.berkeley.edu, palmer@dabbelt.com, will@kernel.org,
	akpm@linux-foundation.org, pasha.tatashin@soleen.com,
	mingo@redhat.com, pjw@kernel.org, kexec@lists.infradead.org,
	hpa@zytor.com, catalin.marinas@arm.com, devicetree@vger.kernel.org,
	baoquan.he@linux.dev, ruirui.yang@linux.dev, mark.rutland@arm.com,
	kernel@xen0n.name, linux-arm-kernel@lists.infradead.org,
	alex@ghiti.fr, linux-mm@kvack.org, linux-riscv@lists.infradead.org,
	tglx@kernel.org, dave.hansen@linux.intel.com
Subject: Re: [PATCH v6 07/10] of: reserved_mem: add dumpable flag to opt-in
 vmcore
Message-ID: <178968217748.3989713.7328577485527762154.robh@kernel.org>
References: <20260902073116.802752-1-chenwandun1@gmail.com>
 <20260902073116.802752-8-chenwandun1@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902073116.802752-8-chenwandun1@gmail.com>


On Wed, 02 Sep 2026 15:31:13 +0800, Wandun Chen wrote:
> From: Wandun Chen <chenwandun@lixiang.com>
> 
> Add a 'dumpable' flag to struct reserved_mem to decide whether a
> reserved area should be included in the kdump vmcore. Non-dumpable
> regions are later marked MEMBLOCK_NODUMP;the filtering itself happens
> in memblock, keeping the arch kdump code independent of the DT API.
> 
> Most reserved regions are owned by devices and do not contain data
> useful for kernel crash analysis, so dumpable default to false.
> Reusable CMA regions are different: their pages are handed back to the
> buddy allocator and may contain key data for crash analysis, so set
> dumpable to true in rmem_cma_setup().
> 
> The dumpable flag is also used to check /memreserve/ entries for overlap
> with other dumpable regions.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
> Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
> Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  include/linux/of_reserved_mem.h | 1 +
>  kernel/dma/contiguous.c         | 1 +
>  2 files changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

