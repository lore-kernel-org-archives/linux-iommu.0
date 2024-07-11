Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A9142AB5;
	Thu, 11 Jul 2024 17:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720718839; cv=none; b=VgD/T+lPjnDByxqYhHpH/efX1ad20D7sR0iMCkdWJ1fJ7441YcJ/9RWpoObthFNlPtM6tjUD871BJzYaw6RwhiQSS2hHEJHP8LEz7AXv3zdT+tuR3NTMh9igiwhLlF2wEYaI1IA4hD+ojih332V0qTKHl4wIifVeFrY5aFE+v4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720718839; c=relaxed/simple;
	bh=M4ZqeXBMxCYAveIw6xehZg0LpC1GClfx6iMeK2x2qeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcOOR46fB62MrIGX0SRAZWe5kvyohCNMUPJq6bpXQsehy5JB2NatQiPpjjURgYKRgbsazuAEvTUIrTe941ZQRDYhD64vsu/PqWEC7KL5ymQmds9zKZMgKP72emXH0CEV+dA0fXQRR5N9pJ8mBfpzfRH4VZSFVO8Cc1+AeO/M/l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAh+Fmg2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAh+Fmg2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128B2C116B1;
	Thu, 11 Jul 2024 17:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720718838;
	bh=M4ZqeXBMxCYAveIw6xehZg0LpC1GClfx6iMeK2x2qeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OAh+Fmg2zPYlww53BEiLu3bLEeQd7BKi8ggeoiINMlu3wpWI+YRtUuavbfHC3oZS4
	 jxgMpDEQxC2QMwMtG7gKJOifFZ4se5VyguzqXAEUip6NXdpMu0HohEh0FeUcbj2w4Y
	 s59c/PGgJAF6cmh7lonhGcY3V1B4HFQiL0uKs+galKUePOddPeGIyYKNiG/Q7igNRx
	 dxz9juTaKGS+pLnHCkroh0EwIn7BkMVgaM3fr4NtPcPE6xTWMy+Ivx/YxvAVlvqCn5
	 GAEIJFiEEdRX14sDAtm0DBtHIc3r8SVVPsxvMFZROLCWKUHmDtY7ubob9qCUtvsgmF
	 xaLlm+HFI1jNA==
Date: Thu, 11 Jul 2024 20:27:13 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH 2/2] dma: Add IOMMU static calls with clear default ops
Message-ID: <20240711172713.GA1815706@unreal>
References: <98d1821780028434ff55b5d2f1feea287409fbc4.1720693745.git.leon@kernel.org>
 <f2b699aea8fff5589a674da2a567fd593ed2d386.1720693745.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2b699aea8fff5589a674da2a567fd593ed2d386.1720693745.git.leon@kernel.org>

On Thu, Jul 11, 2024 at 01:38:55PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Most of the IOMMU drivers are using the same DMA operations, which are
> default ones implemented in drivers/iomem/dma-iomem.c. So it makes sense
> to properly set them as a default with direct call without need to
> perform function pointer dereference.
> 
> During system initialization, the IOMMU driver can set its own DMA and
> in such case, the default DMA operations will be overridden.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  MAINTAINERS               |  1 +
>  drivers/iommu/dma-iommu.c | 24 +++++++-------
>  include/linux/iommu-dma.h | 50 +++++++++++++++++++++++++++++
>  kernel/dma/iommu.h        | 67 +++++++++++++++++++++++++++++++++++++++
>  kernel/dma/mapping.c      |  9 +++---
>  5 files changed, 134 insertions(+), 17 deletions(-)
>  create mode 100644 include/linux/iommu-dma.h
>  create mode 100644 kernel/dma/iommu.h

<...>

> +++ b/include/linux/iommu-dma.h
> @@ -0,0 +1,50 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES. All rights reserved
> + *
> + * DMA operations that map physical memory through IOMMU.
> + */
> +#ifndef _LINUX_IOMMU_DMA_H
> +#define _LINUX_IOMMU_DMA_H
> +
> +#include <linux/dma-direction.h>
> +
> +#ifdef CONFIG_IOMMU_API

This should be CONFIG_IOMMU_DMA.

diff --git a/include/linux/iommu-dma.h b/include/linux/iommu-dma.h
index b42487bf8f8e..bfdcc9d65daf 100644
--- a/include/linux/iommu-dma.h
+++ b/include/linux/iommu-dma.h
@@ -9,7 +9,7 @@

 #include <linux/dma-direction.h>

-#ifdef CONFIG_IOMMU_API
+#ifdef CONFIG_IOMMU_DMA
 dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
                              unsigned long offset, size_t size,
                              enum dma_data_direction dir, unsigned long attrs);
@@ -46,5 +46,5 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
                               unsigned long attrs)
 {
 }
-#endif /* CONFIG_IOMMU_API */
+#endif /* CONFIG_IOMMU_DMA */
 #endif /* _LINUX_IOMMU_DMA_H */

Thanks
