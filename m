Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FA81FC0E6;
	Wed, 30 Jul 2025 22:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753915308; cv=none; b=JViWLpY4uYZSjSQI0ghI/4fXrun9J8dPHS3d5XaLffALgxTQQS7Y6TOn1Z9+4X/XuizzuaW94rJ0dH3o9dniYlnB78MNN2LGTupzk/abuz73K3k0LUYmKR6ItJmKrsLWxc1tk43/gI9cUlUcPHOqRgW00ONGnV0zSqFwdKx8IPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753915308; c=relaxed/simple;
	bh=GWaDf3adn+wN1fKBXt2Ts7vvMaetMJXms4RCI3IHYUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iy3QTVLVgd1fuv5RJfFEzTwBZO9T2/vq74wOIXxbLDvf/OQUZOL/1wDxIo0lPCcSiofpUF2yKjziDgJ5rj2oAYZmCOLqfSBzGIK1nlGmQBzaGT8ym1CEKgiVL+PsAjVdUJ3GQSW6nmrcOJC4Xk5ogqWiUIOtGLL/juOUTf1SANw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOE1BIb5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOE1BIb5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F87C4CEE3;
	Wed, 30 Jul 2025 22:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753915308;
	bh=GWaDf3adn+wN1fKBXt2Ts7vvMaetMJXms4RCI3IHYUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YOE1BIb5RrLaijIXCXMec2ww8/iSXQlF6La+cvZddui90k9ts4RBQQumjPHBWBXlS
	 BWZ86NRIu4gm5jY9SFjsA7AVcVGDjoX6/LthdzMfFnlGkU5uUH55arGrQUTff5sFG8
	 dGD4UBgUJPQXadeXI3mId8fpOfopeeXo1xKdklYRA7Lf9Vdy89TDMKP4Rps32VZySc
	 65jy32t2vOx14v2qsycq/eSzCmm4UXC3eYNukHBVdxjH74HKuaAnKRDJoMIowdd6xz
	 8wpB++/EXaykQMx1a3DgCnuYdg6EeWN3/7UUT5v1/iWFh/Mg7ZN/XUgmqiJsCEuRwQ
	 TkbUrgeXdkRFw==
Date: Wed, 30 Jul 2025 17:41:42 -0500
From: Rob Herring <robh@kernel.org>
To: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
Cc: m.szyprowski@samsung.com, robin.murphy@arm.com, saravanak@google.com,
	quic_obabatun@quicinc.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	william.zhang@broadcom.com, kernel@oss.qualcomm.com,
	will@kernel.org, djakov@kernel.org
Subject: Re: [PATCH v3] of: reserved_mem: Restructure call site for
 dma_contiguous_early_fixup()
Message-ID: <20250730224132.GA1822233-robh@kernel.org>
References: <20250730002956.1812694-1-oreoluwa.babatunde@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730002956.1812694-1-oreoluwa.babatunde@oss.qualcomm.com>

On Tue, Jul 29, 2025 at 05:29:56PM -0700, Oreoluwa Babatunde wrote:
> Restructure the call site for dma_contiguous_early_fixup() to
> where the reserved_mem nodes are being parsed from the DT so that
> dma_mmu_remap[] is populated before dma_contiguous_remap() is called.
> 
> Fixes: 8a6e02d0c00e ("of: reserved_mem: Restructure how the reserved memory regions are processed")
> Signed-off-by: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
> Tested-by: William Zhang <william.zhang@broadcom.com>
> ---
> v3: Wrap the call to dma_contiguous_early_fixup() with a check for
>     CONFIG_DMA_CMA to fix compile error seen on x86. The __weak function
>     definition introduced in v2 was not sufficient to prevent the issue,
>     so remove that as well.
>     Also add Tested-by tag from William Zhang.
> 
> v2: Add a check for the "reusable" property to narrow things down to
>     only cma regions.
>     Also add __weak function definition for dma_contiguous_early_fixup()
>     to avoid compile errors on architectures that do not define the
>     function.
> 
>  drivers/of/of_reserved_mem.c | 20 ++++++++++++++++----
>  kernel/dma/contiguous.c      |  2 --
>  2 files changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 77016c0cc296..cfffecb91c3a 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -25,6 +25,7 @@
>  #include <linux/memblock.h>
>  #include <linux/kmemleak.h>
>  #include <linux/cma.h>
> +#include <linux/dma-map-ops.h>
>  
>  #include "of_private.h"
>  
> @@ -175,13 +176,19 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
>  		base = dt_mem_next_cell(dt_root_addr_cells, &prop);
>  		size = dt_mem_next_cell(dt_root_size_cells, &prop);
>  
> -		if (size &&
> -		    early_init_dt_reserve_memory(base, size, nomap) == 0)
> +		if (size && early_init_dt_reserve_memory(base, size, nomap) == 0) {
> +			/* Architecture specific contiguous memory fixup. */
> +#ifdef CONFIG_DMA_CMA
> +			if (of_flat_dt_is_compatible(node, "shared-dma-pool") &&
> +			    of_get_flat_dt_prop(node, "reusable", NULL))
> +				dma_contiguous_early_fixup(base, size);
> +#endif

Add a static inline for dma_contiguous_early_fixup() instead of having 
an #ifdef.

>  			pr_debug("Reserved memory: reserved region for node '%s': base %pa, size %lu MiB\n",
>  				uname, &base, (unsigned long)(size / SZ_1M));
> -		else
> +		} else {
>  			pr_err("Reserved memory: failed to reserve memory for node '%s': base %pa, size %lu MiB\n",
>  			       uname, &base, (unsigned long)(size / SZ_1M));
> +		}
>  
>  		len -= t_len;
>  	}
> @@ -472,7 +479,12 @@ static int __init __reserved_mem_alloc_size(unsigned long node, const char *unam
>  		       uname, (unsigned long)(size / SZ_1M));
>  		return -ENOMEM;
>  	}
> -
> +#ifdef CONFIG_DMA_CMA
> +	/* Architecture specific contiguous memory fixup. */
> +	if (of_flat_dt_is_compatible(node, "shared-dma-pool") &&
> +	    of_get_flat_dt_prop(node, "reusable", NULL))
> +		dma_contiguous_early_fixup(base, size);
> +#endif
>  	/* Save region in the reserved_mem array */
>  	fdt_reserved_mem_save_node(node, uname, base, size);
>  	return 0;
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index 67af8a55185d..d9b9dcba6ff7 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -483,8 +483,6 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
>  		pr_err("Reserved memory: unable to setup CMA region\n");
>  		return err;
>  	}
> -	/* Architecture specific contiguous memory fixup. */
> -	dma_contiguous_early_fixup(rmem->base, rmem->size);
>  
>  	if (default_cma)
>  		dma_contiguous_default_area = cma;
> -- 
> 2.34.1
> 
