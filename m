Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59246254869
	for <iommu@lists.linux.dev>; Fri,  2 May 2025 13:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746191495; cv=none; b=YSokjXsax2H/zCOWb2NCIhi5mk72g0rOsGOkq2UjLEHFrQHyok1yPilfrn45/eOW7r2VR/u+/aa4yiZJiFtGxjNgfYzOrYVtRnI8pEQZSZ2ccrUJjG4n1kH3X+Su8ADUSlj1UaK7gMkdh2zMI+u2nopJuXhKpYvA43sTjvLZSTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746191495; c=relaxed/simple;
	bh=TWNx/9PXkgLLuyLmpT398Pb4C9LdkncPESDk5m9mSzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UB1Jpz4JOxdE1nMBN+kzNGlk2NYfX0XI8FISe5PERFIn/HK1WzeJH5zIZRUQ2sjyvqabn62n3m132ISjFGtk4PQAdCq+uw6sy+VgEafjJ5O3jjmCa8ZwW5cHKxrz25c4uG7B+nRmMTyYouWOUiG7YSYLFgs2ZEbFbmiIaZgJAt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 013131688;
	Fri,  2 May 2025 06:11:22 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A5333F66E;
	Fri,  2 May 2025 06:11:25 -0700 (PDT)
Message-ID: <43e85d6a-ef99-4d61-910e-1d62814fd9ed@arm.com>
Date: Fri, 2 May 2025 14:11:02 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 10/14] dma-contiguous: export
 dma_contiguous_default_area
To: Jens Wiklander <jens.wiklander@linaro.org>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, op-tee@lists.trustedfirmware.org,
 linux-arm-kernel@lists.infradead.org
Cc: Olivier Masse <olivier.masse@nxp.com>,
 Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 "T . J . Mercier" <tjmercier@google.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sumit Garg <sumit.garg@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>,
 Daniel Stone <daniel@fooishbar.org>,
 Rouven Czerwinski <rouven.czerwinski@linaro.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev
References: <20250502100049.1746335-1-jens.wiklander@linaro.org>
 <20250502100049.1746335-11-jens.wiklander@linaro.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250502100049.1746335-11-jens.wiklander@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/05/2025 10:59 am, Jens Wiklander wrote:
> Export the global variable dma_contiguous_default_area so
> dev_get_cma_area() can be called a module.

What dma_map_ops implementation is in a module? Without any other 
context, I can't help thinking this smells of something sketchy.

Thanks,
Robin.

> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: iommu@lists.linux.dev
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>   kernel/dma/contiguous.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index 8df0dfaaca18..eb361794a9c5 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -53,6 +53,7 @@
>   #endif
>   
>   struct cma *dma_contiguous_default_area;
> +EXPORT_SYMBOL(dma_contiguous_default_area);
>   
>   /*
>    * Default global CMA area size can be defined in kernel's .config.
