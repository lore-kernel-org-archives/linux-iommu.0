Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EE33EBF19
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 07:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784014645; cv=none; b=ogXgTASLeuJ9AFGbLlrVC9EvM0aoAZqv7PmjNZDWP+U6SCLtrDDQRO7BjgCjDFuEvB5gmbqYhjqLhx+AP5d83LU0IQFoDJpSlN07jNQMx99NWS+vFwif4OQohm8u2JXrrb88Uw+CmCCyDQOJpvRMmp7QgDk9tbO08U1ZrhJptwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784014645; c=relaxed/simple;
	bh=JNaplmwtLRxCCsPbnwvbEje4USEdmIzQ0+Jn+jtWBa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNg92gAWJQZLpzHHjgsX3PbJSGp8qs/oiCx5doSIvhC2OsFKMSD8eMgMIHyPR4tlp9+ngeE2+V3BUEbj0nBgc2yguFTmg8/HMTlxuPszqHTFKDcknnv5NAryi2fW991m2KxqBiAY2/Gm9ux0Nsv5Y2YjeJDpZLPfdmFTrc1ZVYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IjhWbSTR; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IjhWbSTR"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ccdf36f63dso88175ad.0
        for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 00:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784014643; x=1784619443; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qxPrq/QLaw64AHuPTEEH4v8WBZAurPWVIQauUM2RcxE=;
        b=IjhWbSTRVghFRwI9mWhMS/oC6ZBdxusV1n2ryllPKbi/Y8BOsWEI7mGm8w6S+NQc8H
         NgctqKSIXkxer0fjcAexNI2QrY7t9DrKyQeLE1Dt4Th+zi1190Y9T68abXXaboUlOZ9F
         YYnjuaNTBLo195wrDL9N92ovECttaKD+JefnUzNpOINWpmRyZOBgqgOrIHAmINmN9Too
         dcvjgpqC71bvBL5l3nrtTyamTsQRRwifTrbUP+xFCWN1+JUDNfvaZLOSML/vHzWNaRjD
         jzo0puATvbTcF1hU4V5+oVXI4Rd7q50yNmCZaG4ojA7J8lQXCxkbHRgNL4yCeZdDq53m
         vyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784014643; x=1784619443;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qxPrq/QLaw64AHuPTEEH4v8WBZAurPWVIQauUM2RcxE=;
        b=ioXFGeB9Ks2B3HvXOMtG7ffPzELujuL5XKwV3ZHhpjlEKOH43UBlUbT7+meKV/oRJd
         h9KkWXdvq1FdLOL9470jq4WAFdbJYVRZOgvUFMiP50u3cbuEfl+s85bNYrOd/19dLxn3
         F7ynHrYsAJldL3lXORHPgK4L842SY1Bo61H5qgmGlDLFatWDoBQ+P7rfLxbg5G94NLCv
         dfKJ54Ct08xm8RVhjNT6GZTNRXyTHmuYB/vaO1nSeGb/gNGeQraWWwq8xrl9DyL6hMwF
         SzhZ+duiTLpO7+xHMmIonA9TtTQBtXDnndA1pUr4ijm9r0XaH0z6VpjP19LZ3pI760PN
         GEqA==
X-Gm-Message-State: AOJu0YwDDZxQkJXx7TU/d0Z6E6pr4w+nB8j0IxFMZWcE6N3zR9LlKigY
	it9eOJi1Y6dDNjF5+8DwVc12eqvXQ9DE5eYeimRdqNpV5DBwdI4ZDdDLRUW4mZoAmg==
X-Gm-Gg: AfdE7cn2b+OkAmPETZYxeqn7T+56gIjC6zGPhPx0hg7IjWUjS966SjzmkCxMox//xVI
	8/a8AzRbs0NobHHb8WxIugPfX7Y4VPouXlmC+olqYl7nf8a6NSqXRns3sHSpWUFVuV2mItxc4kD
	4eeYNqC87lZPPcSj5HEkTQO/XgWi+Kib0yRDU13Ht4cgE+yJGVRhAm9umPzU69ezjbwzQWkaiCx
	FUuvfJWqJ31NpcoyWj1S5hTINCNR6WgdFQept4dW5aeN6N5HgWyuR48+1/7wj6Uf49oU8T5vUoh
	5dKUQF+nOevfYATsfO5+h2880v6h2M0Y7yyT7ftmqOgXCOY0ifUKam7ZxKznRRpR0auZfSZqJ5E
	f+y4gl0bf6pe8NU5YTbVuthOozSqXK6zBhJVvAT2eN/LBSifsMPkcUxPWIbgnzxJzr4+EJd7ee9
	MSj56o8011oury1Gosqoe5MBSaD81KJsHpy86bhoLogJP++tw=
X-Received: by 2002:a17:902:c952:b0:2bf:1000:d3ac with SMTP id d9443c01a7336-2cee16bf99fmr4874315ad.11.1784014642830;
        Tue, 14 Jul 2026 00:37:22 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f7dc7ffsm1022895b3a.40.2026.07.14.00.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 00:37:21 -0700 (PDT)
Date: Tue, 14 Jul 2026 07:37:15 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Christoph Hellwig <hch@lst.de>, Li RongQing <lirongqing@baidu.com>
Subject: Re: [PATCH] dma-direct: Improve readability of the
 dma_direct_map_sg() for P2PDMA case
Message-ID: <alXnK76_Bgf4DEks@google.com>
References: <CGME20260713083036eucas1p12b33a500ff4fef0b5d8db94f694bdb24@eucas1p1.samsung.com>
 <20260713083022.1110993-1-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713083022.1110993-1-m.szyprowski@samsung.com>

On Mon, Jul 13, 2026 at 10:30:22AM +0200, Marek Szyprowski wrote:
> Improve readability of the sg_dma_len assignment in the P2PDMA cases by
> removing duplicated code, which was a direct result of the d0d08f4bd7f6
> ("dma-direct: Fix missing sg_dma_len assignment in P2PDMA bus mappings")
> fix. No functional change.
> 
> Suggested-by: Leon Romanovsky <leon@kernel.org>
> Link: https://lore.kernel.org/all/20260604071856.GA245424@unreal/
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  kernel/dma/direct.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 4391b797d4db..d8219efe3273 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -486,15 +486,14 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
>  				goto out_unmap;
>  			}
>  			break;
>  		case PCI_P2PDMA_MAP_BUS_ADDR:
>  			sg->dma_address = pci_p2pdma_bus_addr_map(
>  				p2pdma_state.mem, sg_phys(sg));
> -			sg_dma_len(sg) = sg->length;
>  			sg_dma_mark_bus_address(sg);
> -			continue;
> +			break;
>  		default:
>  			ret = -EREMOTEIO;
>  			goto out_unmap;
>  		}
>  		sg_dma_len(sg) = sg->length;
>  	}

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
