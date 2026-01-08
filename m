Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293664946E2
	for <iommu@lists.linux.dev>; Thu,  8 Jan 2026 10:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767869434; cv=none; b=sAt43jA1JxqUbb6X3dh824AliRtpoKMCP7aOgW3zlA1sPz/T88mo7mzg7l9WGVJxVA1zVPaWjPLEjpn+yr5F/4872J74Fsf/xmR/EuNbZCKWfuyBBvq5dqTDWAoFZz2Yt0blCSaQOvJCWKHwEGJ2eZdiGRpc/okuz9vNHqrcsYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767869434; c=relaxed/simple;
	bh=tgHbk0aowxCUpZ9S3mbPiMAFM02hlYHW5kmEaXEwbH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nq4YH0cIFydyht0oikk1S1qtIGqQyfAW5iunTJGR0YgCpF3sPnDJf1fgf2nyW0VVQ0AtFpZeQ+IXRQQacSck5w70UJLOFjw9NzHyytxOQOOAKhAKGjRA8vAbp81q0i1HwIbEo1hX8Ps++3hUyKwyGkg6TcI1XUSaYVlHH/eJe/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1DCB497;
	Thu,  8 Jan 2026 02:50:21 -0800 (PST)
Received: from [10.57.47.193] (unknown [10.57.47.193])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 293BA3F5A1;
	Thu,  8 Jan 2026 02:50:26 -0800 (PST)
Message-ID: <9cbe49ae-6612-491d-8ac6-6a99a08d73e2@arm.com>
Date: Thu, 8 Jan 2026 10:50:23 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-direct: Skip cache prep for HighMem coherent
 allocations
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Matthew Wilcox <willy@infradead.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
References: <20260102155118.2551804-1-aneesh.kumar@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260102155118.2551804-1-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-01-02 3:51 pm, Aneesh Kumar K.V (Arm) wrote:
> dma_direct_alloc() calls arch_dma_prep_coherent() to clean any dirty
> cache lines from the kernel linear alias before creating a coherent
> remapping.
> 
> HighMem pages have no kernel alias mapping, so there are no alias cache
> lines to clean. Skip arch_dma_prep_coherent() for HighMem allocations.

This is assuming that caches are always cleaned when unmapping highmem, 
and no still-mapped highmem pages are dirty - how is that guaranteed? 
The fact that they're not in the linear map doesn't mean they don't 
necessarily have kernel aliases in either vmalloc pagetables or caches.

Thanks,
Robin.

> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>   kernel/dma/direct.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 50c3fe2a1d55..ffa267020a1e 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -272,7 +272,8 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>   			prot = pgprot_decrypted(prot);
>   
>   		/* remove any dirty cache lines on the kernel alias */
> -		arch_dma_prep_coherent(page, size);
> +		if (!PageHighMem(page))
> +			arch_dma_prep_coherent(page, size);
>   
>   		/* create a coherent mapping */
>   		ret = dma_common_contiguous_remap(page, size, prot,

