Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07620352021
	for <iommu@lists.linux.dev>; Mon,  8 Jun 2026 17:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780941233; cv=none; b=LcoxAJ9B4cIL07nSHOHE0lTVYQE3y6OCO70F779umBDN+g9n2x8641nhkziA1llg89JhzjURpBhbmb0rSC4NRx8Hq/gWUfC7E2/rd3ZVJKAD/K1bVsCbhnfwBfRi0IZV7A+lr8g0K2uyi5slvKJre9oH0xBLP9Y+wR0ADzrchWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780941233; c=relaxed/simple;
	bh=wjx7h6/LhfgVxFR0HSIvfScSOwxHs//v8YEIn3jJqUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7BFiBE4V9Hc9etAifnE1ZyKHrgbHA4qCA7YnBdUNz6TT2anTgjbaIjlrT1G6ekDIKAaHpMJ4nO2uIfEv8oNGc8yF7G4Z9yHl+2PjpdM3R1QsS43fI2GjgcE4nm3XHpunvKdnrpCq0yLjBFrZSUzTfmKkeY9vRH1gqzlM+F0rVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HF5d0Nfr; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HF5d0Nfr"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-133362c30cfso32319c88.0
        for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 10:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780941231; x=1781546031; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HKaJq/FqOrnnsfhBbbAGAUYIrDaTZV/8Gb9XfRMpf40=;
        b=HF5d0Nfry3uFm5n1CLPJ2eOOAzWRKqjsxnwZGwUNdMg9gqffy9KxCwjn0N4a6zz5qj
         9zEpAsubTX+nov8lHaMn/T6JJ/fWLwBigGm4qvtBuXD9NBD5moxUavmT3RTYE73pUYi9
         6T8R4rWhPgkDTmaYqgKtbNtb/HIsM40/YjtwywNzEPch8LW9pg+qi8kKBsaDgV9zDegh
         Xd/XXzas4cY/ypAimm8ok7Q1prDAjIkDNXScBSmKnbLAyV2LRLinptvwqYpwtaiybZa6
         A4B0BM0ohAzZd6a4BCPOXm7tQWBnU3mQNEkSfN8WeMr++M40tP4ZTGUj0B+OBd1dIivc
         RxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780941231; x=1781546031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HKaJq/FqOrnnsfhBbbAGAUYIrDaTZV/8Gb9XfRMpf40=;
        b=hYM7MviJ5N2BGmuQvQz3aV+cf/O2GJt68gU4+W6l+E3lhcDdqu31UeCiWrrM9m77Gx
         S640Vp76/I6PmMtK8EOA8pbulunn3QfahDSc2lPZk8GKrZnlhTNWR9rxpvLyPnqC8w/r
         Hv6TLJ+7gmAeYNX3mSm7fRPd38XttisuH90RPptbX4DwcKLEangQFUGOXY7/CbU/1TFT
         vmWd0FD8Il6IdQx7mfAbLT7RhVMkj/gtvbOu89oSrSstsa+oXjOH0zLEf4LRanmMhZzL
         PHpbUYZfUyppz8u2dWTCOjqzW9OzjVfmNQwWGHXMMdq4eqrdPdzbtufQ94kFYP8lgWxF
         VfbA==
X-Forwarded-Encrypted: i=1; AFNElJ9LwVMn/sFPXvqkkBGdy9UBDJBsgYM3GIIPqQ2jBIz8yv8BsNnzFjQ9Tj5cpNBUGNToXpAl1w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy28+LBnHykClMyVr5jCSGlFWU2GTrH3lQkLI+IrT8KoI+muXuS
	EyZA+Km4PTK+kbctzlJ1pag6qtxXb2UYaR7bvJRCVNox1wQ6U6AyraNvISHu9G4MUA==
X-Gm-Gg: Acq92OGZnoHebHLfnzqO8WJlWHEwtS6al3EkV/lPGhlDXbCrvZkdn7ZurhJz4KByBVq
	CnURmkmJCu0tDB8ktOVzOjfZfoh5P2CPM+cFIYBvFT2FmCAoEtJyEAM78UebnhwFVWyZux13vDz
	hWWCZ8R0Cwb52Wp30qW3UQ9EZ8ObKF6uBYBKGf4PLC2JyQpmS/KzuOQP6L30W/GD3tEa2bxGqxC
	y9/tHcyBcl6rQU4S/uHwO7AF+mZra+cC+8WGKVXmbSlAyvviW2i51cd0ec626GE+0frB3/nYozz
	qm6P79XV42LssYWvq7Ed86BWj2E3EqZMXaffyNwFDlNIvmooQ+PRI+aKyyrX827ELEN7z0fSEq0
	psrsMwuOTVkApfYDHsGg0m7Z4KTg/dUcbxuZD7W9/BOa84/CVJx+sjhZmZYUezqxYJ/z3dVbc4u
	dp52yhqG4Sx6/xOin4KyYRKephEDrr4roL1k7YL+gJvzABqG7kV9qDMOd6RKxKSiIw7fw1c08=
X-Received: by 2002:a05:7022:48f:b0:137:ead9:4608 with SMTP id a92af1059eb24-13807cbdceamr310348c88.17.1780941230355;
        Mon, 08 Jun 2026 10:53:50 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db528dcsm21257291eec.3.2026.06.08.10.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 10:53:49 -0700 (PDT)
Date: Mon, 8 Jun 2026 17:53:43 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [RFC PATCH 1/4] dma: Add DMA allocation preservation KHO ABI
Message-ID: <aicBp4tSyzyYBnzn@google.com>
References: <20260505002737.2213734-1-skhawaja@google.com>
 <20260505002737.2213734-2-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505002737.2213734-2-skhawaja@google.com>

On Tue, May 05, 2026 at 12:27:34AM +0000, Samiullah Khawaja wrote:
> The DMA allocations can be backed by a variety of allocators. Add KHO
> ABI for the preservation of contiguous allocations that are done through
> dma-direct.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  include/linux/kho/abi/dma_alloc.h | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 include/linux/kho/abi/dma_alloc.h
> 
> diff --git a/include/linux/kho/abi/dma_alloc.h b/include/linux/kho/abi/dma_alloc.h
> new file mode 100644
> index 000000000000..46e61db81abe
> --- /dev/null
> +++ b/include/linux/kho/abi/dma_alloc.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_KHO_ABI_DMA_ALLOC_H
> +#define _LINUX_KHO_ABI_DMA_ALLOC_H
> +
> +#include <linux/types.h>
> +
> +/**
> + * DOC: DMA Alloc ABI
> + *
> + * This header defines the structures used to serialize the state of DMA
> + * allocations, done by device driver, across a Live Update.
> + *
> + * Only DMA allocations done through dma-direct that are contiguous and
> + * allocated using alloc_page are supported.
> + */
> +
> +/**
> + * struct dma_alloc_ser - Serialized state of a single DMA allocation
> + * @page_phys: Physical address of the preserved pages
> + * @size: Size of the DMA allocation
> + * @force_decrypted: Whether the memory is force decrypted in previous kernel
> + */
> +struct dma_alloc_ser {
> +	u64 page_phys;
> +	u64 size;
> +	u8 force_decrypted;

Should we also stope attrs in this ser state here? There might be flags
like DMA_ATTR_NO_KERNEL_MAPPING which would need to be preserved across
a kexec? 

> +	u8 padding[7];
> +} __packed;
> +
> +#endif /* _LINUX_KHO_ABI_DMA_ALLOC_H */
> -- 
> 2.54.0.545.g6539524ca2-goog
> 

Thanks,
Praan
