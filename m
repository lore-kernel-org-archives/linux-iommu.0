Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1D037F8A4
	for <iommu@lists.linux.dev>; Wed,  9 Sep 2026 09:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946192; cv=none; b=e+1yI4xFzC+TacHBi2NV8MiWKdu67N/Al4FsLzwsV/93dsTh4VIW64mIRWO/DKcaeGvrOqJdpnMUeTDPtlH6PmktxK0FutETW2qaXU6du9Pk/pQCJM5b7exr2aiQrLW+73CzN2scMQam/8xPo0HzgpuBPtreaw1va8zzhwveshg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946192; c=relaxed/simple;
	bh=WmqknmXOa3htBxa5JgdgxRU3H8UZeW31hfcsndjwUiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=uvoXOjp2jDFFwXdYmh79uWrap/mZT+5QBT6Bc5e5w05zGYZV9pF3HfDtISh8OhM1efb+JOhxa+rrEC1oWZMiWKF3hIdPLl7cEvVZDvGVjDFZOmvoEF1f7M/pFAMYYUQBCdoSYruf3i2uCDKzPrDiVpvv211MYNZkZ/Gy2i9snA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=l1f7NXyS; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="l1f7NXyS"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260909092932euoutp023a5ad0ec278628f7ed44acdffe148b9d~TnRDXv7hE0891008910euoutp029
	for <iommu@lists.linux.dev>; Wed,  9 Sep 2026 09:29:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260909092932euoutp023a5ad0ec278628f7ed44acdffe148b9d~TnRDXv7hE0891008910euoutp029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1788946172;
	bh=AvCVoTcFv09OSmnOhTviu6CzkkZAHrdDwoUk19+MOkw=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=l1f7NXyS9z5pLwa7iy4HuECv/LXXBTT/waZgNWc2ma7UStHoHRWO2KbNqhjYJkriE
	 aUcTTGNp7sez08ceiZOsRBOuSPPuzQsrpgqlcluFtxhxfYDHrPIa0Ha6vcD0NtnZys
	 7hzRVD8ZCqWDQmLpNJZLJE7AwsG5x/Cc/HQFlXaQ=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260909092932eucas1p12e652b155548553a3fb3860adaf88d99~TnRDE5LTl2633426334eucas1p1u;
	Wed,  9 Sep 2026 09:29:32 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260909092931eusmtip2fb751ca7efb9f29d5549d7ea01817133~TnRClZNqT2607926079eusmtip2o;
	Wed,  9 Sep 2026 09:29:31 +0000 (GMT)
Message-ID: <fb39c105-db6c-4820-aee6-e423bf612cc7@samsung.com>
Date: Wed, 9 Sep 2026 11:29:31 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] dma-coherent: report a failed reserved memory
 assignment
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Andrew Morton
	<akpm@linux-foundation.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260905074727.108029-1-donggeunyoo.kernel@gmail.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260909092932eucas1p12e652b155548553a3fb3860adaf88d99
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260905074735eucas1p235b2a9129bc0bb01b5725d57149ed5f5
X-EPHeader: CA
X-CMS-RootMailID: 20260905074735eucas1p235b2a9129bc0bb01b5725d57149ed5f5
References: <CGME20260905074735eucas1p235b2a9129bc0bb01b5725d57149ed5f5@eucas1p2.samsung.com>
	<20260905074727.108029-1-donggeunyoo.kernel@gmail.com>

On 05.09.2026 09:47, Donggeun Yoo wrote:
> rmem_dma_device_init() drops the return value of
> dma_assign_coherent_memory() and always reports success. That call fails
> with -EBUSY when the device already has a coherent pool, and the file
> allows only "*one* such region of memory" per device.
>
> of_reserved_mem_device_init_by_idx() reads the zero as success. It logs
> "assigned reserved memory node" for a region that was not assigned and
> records the pairing, so of_reserved_mem_device_release() later runs
> rmem_dma_device_release() for it. That clears dev->dma_mem without
> looking at which region it was called for, dropping the pool the device
> did get and leaving it on ordinary memory.
>
> dma_declare_coherent_memory() checks the same call and releases the
> memory on failure, and rmem_swiotlb_device_init() propagates its own
> errors. Return the error here as well, so a device tree that assigns two
> pools to one device fails the probe instead of half working.
>
> Fixes: 7bfa5ab6fa1b ("drivers: dma-coherent: add initialization from device tree")
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

Applied to dma-mapping-fixes, thanks!

> ---
> Compile-tested only, with CONFIG_DMA_DECLARE_COHERENT=y and
> CONFIG_OF_RESERVED_MEM=y. I do not have a board that assigns two
> shared-dma-pool regions to one device; the release path was traced
> through of_reserved_mem_device_release() and rmem_dma_device_release()
> rather than observed.
>
>  kernel/dma/coherent.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
> index 45bbae947f4b..4d0266893bcc 100644
> --- a/kernel/dma/coherent.c
> +++ b/kernel/dma/coherent.c
> @@ -352,8 +352,7 @@ static int rmem_dma_device_init(struct reserved_mem *rmem, struct device *dev)
>  	    min_not_zero(dev->coherent_dma_mask, dev->bus_dma_limit))
>  		dev_warn(dev, "reserved memory is beyond device's set DMA address range\n");
>  
> -	dma_assign_coherent_memory(dev, mem);
> -	return 0;
> +	return dma_assign_coherent_memory(dev, mem);
>  }
>  
>  static void rmem_dma_device_release(struct reserved_mem *rmem,

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

