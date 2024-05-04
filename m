Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE5BCA7D
	for <iommu@lists.linux.dev>; Sat,  4 May 2024 08:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714812805; cv=none; b=bYmvVTvAqeTwV0aQU4vRIDjVws71Lff6sZ+hXp1DiGOJpKM3ilk1wUKzguMXrdbatMkT4VkFa1aZExtuTtOavd3/keOsRaOEx7OwdYHso3Ryd8kzUBBhbDj1nI2im4ldV7eotHYrS6km0PyDfvCPV2NAQIldCmxBIVqk/iE+RJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714812805; c=relaxed/simple;
	bh=F9WZ+7ipilzLdMlYfhOYLZqygvVOA423pQDFbzl/QuU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fo4esOfhzvBwAoczoPFCy/k233EtjYOTwlBnypJq77exaxqOWZldJrvSAnaYeTDPnzSG1Hg+1gD8T3or6Cqw4dE8pydI1gVAngDb+E4YcCB0I2fHY5VNX6hU2/WiUosnUq96RpskCAMz2Jl5edz3s4vTbA1ihyePJVpfshXAWas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=degN7I7+; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="degN7I7+"
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 31E2C1BA6F4;
	Sat,  4 May 2024 10:53:20 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1714812800; bh=r8mY2kiUlttRaIUpK7q7YlOxdcrNiVnu7avba+IRVxI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=degN7I7+pspwb3mLYxb0ogmlx8ejRLy7D2Ev0bUul/M+eylJC6YK2M56xK6FjEBU2
	 wW6sEyvDaglmZHeggAAVR52WAMwIgekdTDY/SO0Diz/Q2oOk4FLWbY9Uhhr+OlziSe
	 04W0X3GVEM/bu/Ys/86JeMrIulIQP9QR8MWQ++foPGmb2iG7+vokqGGmNzdpr0GfVN
	 UJP1tWZTr9ILXWzkO+b4dE+ZWr6liB8m81ZyY05k/nZ8Z2ABwanwNvosupQ4+Bx+Lc
	 cDJuPLXvBVnVwvpp1nRoY5oSdMwr1IjMWBSHk64PfSDn/DT7tRqSXeyoKfNb2EuOmZ
	 uieRPXRj+i8UQ==
Date: Sat, 4 May 2024 10:53:19 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Christoph Hellwig <hch@lst.de>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>,
 isaacmanjarres@google.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-direct: Set SG_DMA_SWIOTLB flag for dma-direct
Message-ID: <20240504105319.75eec54a@meshulam.tesarici.cz>
In-Reply-To: <20240503183713.1557480-1-tjmercier@google.com>
References: <20240503183713.1557480-1-tjmercier@google.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  3 May 2024 18:37:12 +0000
"T.J. Mercier" <tjmercier@google.com> wrote:

> As of commit 861370f49ce4 ("iommu/dma: force bouncing if the size is
> not cacheline-aligned") sg_dma_mark_swiotlb is called when
> dma_map_sgtable takes the IOMMU path and uses SWIOTLB for some portion
> of a scatterlist. It is never set for the direct path, so drivers
> cannot always rely on sg_dma_is_swiotlb to return correctly after
> calling dma_map_sgtable. Fix this by calling sg_dma_mark_swiotlb in the
> direct path like it is in the IOMMU path.
> 
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> ---
>  kernel/dma/direct.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 4d543b1e9d57..52f0dcb25ca2 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -12,7 +12,7 @@
>  #include <linux/pfn.h>
>  #include <linux/vmalloc.h>
>  #include <linux/set_memory.h>
> -#include <linux/slab.h>
> +#include <linux/swiotlb.h>
>  #include "direct.h"
>  
>  /*
> @@ -497,6 +497,8 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
>  			goto out_unmap;
>  		}
>  		sg_dma_len(sg) = sg->length;
> +		if (is_swiotlb_buffer(dev, dma_to_phys(dev, sg->dma_address)))
> +			sg_dma_mark_swiotlb(sg);
>  	}
>  
>  	return nents;

I'm not sure this does the right thing. IIUC when the scatterlist flags
include SG_DMA_SWIOTLB, iommu_dma_sync_sg_for_*() will call
iommu_dma_sync_single_for_*(), which in turn translates the DMA address
to a physical address using iommu_iova_to_phys(). It seems to me that
this function may not work correctly if there is no IOMMU, but it also
seems to me that the scatterlist may contain such non-IOMMU addresses.

I'm no expert, so correct DMA-to-physical translation might in fact be
somehow implicitly guaranteed. If that's the case, could you explain it
in the commit message, please?

Petr T
