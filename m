Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1231815E8B
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 17:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778261298; cv=none; b=OEZwZ5b2S9IGu7+XPlnXo4dm7dorHSDGdHR8TdzX9extgwV/kJmRFFzS/HBG4ywsp1yZzV3n72qr0Myvve1cS4ZzXZK9bqPUERDJfxzCAiuzdVgtf1NqeEQ/ZBF4gmTMT0efiRipnGZyYwdkD2ZcWMfptgBISn2GTPCSY9ImBUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778261298; c=relaxed/simple;
	bh=Iikru55NoURSx6J2SyL9jJPQp5D8hOPJCa6JZG2NuSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tL40iuHdeybNtby6PTrxsgPCSB5FN6PFFzEtbvWtXUnT7P2ReGEgid42P6hALqqTpzrsT1d2NLuquOFjB6MHCYDW89a0Ir+FBW+6IIQHNWfraroT/QMv3nAL2808ZOkvYKGBJwB6VeZ1AKU+u8DcUdJCUK1WXshkZvKiuc4AERc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=sobmFfYq; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="sobmFfYq"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 198BB1AC1;
	Fri,  8 May 2026 10:28:11 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E36593F836;
	Fri,  8 May 2026 10:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778261296; bh=Iikru55NoURSx6J2SyL9jJPQp5D8hOPJCa6JZG2NuSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sobmFfYqPXXAfIvtR4YIYpBTVa984BNVuwyjtpIRyrgoihtxxscsfBZwrJyx809j4
	 KrtKs9EyXfpJBazNvSmz6Ylpw/IqYnGGq+MUyCQn/9aiCBmvlnY6TZ55lBGAzY4Zlg
	 Q5ybprDJY/85PR9ieeIbMgDpkY/vRRWgzAKXEwgA=
Date: Fri, 8 May 2026 18:28:11 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH v3 0/9] dma-mapping: Use DMA_ATTR_CC_SHARED through
 direct, pool and swiotlb paths
Message-ID: <af4dK-0HEsKdPAvM@arm.com>
References: <20260427055509.898190-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427055509.898190-1-aneesh.kumar@kernel.org>

On Mon, Apr 27, 2026 at 11:25:00AM +0530, Aneesh Kumar K.V (Arm) wrote:
> This series propagates DMA_ATTR_CC_SHARED through the dma-direct,
> dma-pool, and swiotlb paths so that encrypted and decrypted DMA buffers
> are handled consistently.

I think this series makes sense, using DMA_ATTR_CC_SHARED throughout the
DMA API, either for alloc or for streaming to decide/check what bouncing
does. Sashiko has a few interesting reports, it probably breaks s390 as
well (it might be similar to the pKVM case).

I don't think it addresses earlier Mostafa's issues with pKVM, although
I'd rather base additional pKVM related fixes on top of this series.
With pKVM, cc_platform_has(CC_ATTR_MEM_ENCRYPT) returns false, as does
force_dma_unencrypted(). I think we should update protected guests to
return true for these if they need shared buffers (the whole
decrypted/shared terminology is messy but in most places it just means
buffer not private to the protected guest, whether encryption is
available or not).

That said, does CC_ATTR_GUEST_MEM_ENCRYPT actually make more sense than
CC_ATTR_MEM_ENCRYPT throughout this series? We'd need to change arm64
realms as well to use this one.

-- 
Catalin
