Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29DC79B8E
	for <iommu@lists.linux.dev>; Mon, 29 Jul 2024 11:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722253539; cv=none; b=JELDM8Lijb7vrPEGRrTwsXEbhPzl8F8g4LtlT5Qk0r3V4qdTO/C8F5kBrEpk1QG/0zAeW3N/cPGDp8aisoeXzuSo9mK41Img2KJIjp0TpkTS52c/Jc68iHboPmEb4iDeLawZCxfXVHZhNIk21Tbfxr8IVXKdmpDKCTnnpMMZVrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722253539; c=relaxed/simple;
	bh=A10ZdrRPrnXJf2K8fH9tF/ys9uEanUwC8oG0ctp3CtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkCWO7o8L0bgL+hxXIDlnWulympVornWXwRy9DAhzMg2uEKMiPWJWq4wzKkIHIpsf9xJfMBcYrMsrhYza+U6+f0LEGs+I8PLP8/EQhUvfC9zzfeYuWme2RzmAI3xKsBhuJ5OaHbQuBLo5r9OfLWorQRMqmlojl5wXY7cBJxS+sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G7LsiOHl; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G7LsiOHl"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42807cb6afdso54215e9.1
        for <iommu@lists.linux.dev>; Mon, 29 Jul 2024 04:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722253535; x=1722858335; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Po1n89LJvram5HEqYwMALsMwnThZhO0DVQ6rc50fxBE=;
        b=G7LsiOHlapBni1gKI5DrxQXQ9bLBEpaYW/WGID/xlAfZwZUhS4hCMmkL5WcLNa19qZ
         aQat0SX15ZZMTzORmxYf4Feo5re8CWMo+kizquNjpMS1MfQ0Fe3Szyh969LEYurS/voz
         lYkehFP6z49vuVoN6k/YGYdcCO+9rdfAdLX5kQRWSIGOuQnCd+Xlq8XggzoySjbqcJ83
         GHNUYFMIWkFaizi0XnuiTAxZR90trCN86p7nE6Y1bOa1PgcR1BJaR//WeQ5kSD/FnYGT
         hUPXdJ6l3sXX69my3/2H2VhZJ5Gt3AWRmb4IkzwhfahNDrGb6u6bRIAe95aHlFeFpDdD
         VGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722253535; x=1722858335;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Po1n89LJvram5HEqYwMALsMwnThZhO0DVQ6rc50fxBE=;
        b=WC5KtczAaUFZ3biCibryQIoMcphKOMjZXYc9naHQhBNNqQ2SxlQbMlJguySCX1NSHD
         wFfI+rgnvG/8xetIpYbhBn6oQ5RsN2mc3pZdlgt8b7GqbzKZhjzlEDfzum0nMUwDdY2m
         kwGXIFlGWT+S5jbUdYgBcZiTBdT4S5tLf33Qpr0KQ62289+6Aiz9GFjufEk8OZsCVGEO
         rT10fFLiccxQAXDlRS+IxBxy4gZ4+lyf45Twx6Yyu0xO6qBRomDIEmeAHglDlqjk5dOb
         aBXeZGjF0ItqKMccjP22i801yrEXUOFMlZQNcHlr/FLGLTql7RFNzpjFAhd2POcmrXbE
         L7Wg==
X-Forwarded-Encrypted: i=1; AJvYcCXRgHZ20dPDR//PicByPHS06HgBsnBfAVxBVL0GpsNrmmoMpbNYMMB+aBbUAmfG7eptG6RARPVR8mavd0OMRNEK4lY8ya4=
X-Gm-Message-State: AOJu0Yx0yLD6wmXL9KLYmcM+oMeNq63HmwN0RMzg4vJVfqsLaisAgYRN
	7pzlc3Tw8UBdgI1aUadpOwT0ToJmfHupPrItfw2PoUDkaSTxdXNjqH6ua+j7vQ==
X-Google-Smtp-Source: AGHT+IF9lmrrr4mU6SQTATPg4BGae20+2RN2oYvd82uqtDRGSOWYN9hk+RN/G33dubnGu66mSB8E8A==
X-Received: by 2002:a05:600c:3c96:b0:426:8ee5:3e9c with SMTP id 5b1f17b1804b1-4280b142f23mr4818455e9.6.1722253534535;
        Mon, 29 Jul 2024 04:45:34 -0700 (PDT)
Received: from google.com (180.232.140.34.bc.googleusercontent.com. [34.140.232.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280574003bsm171998655e9.17.2024.07.29.04.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 04:45:34 -0700 (PDT)
Date: Mon, 29 Jul 2024 11:45:30 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, iommu@lists.linux.dev,
	Will Deacon <will@kernel.org>, Rob Clark <robdclark@chromium.org>,
	Joerg Roedel <jroedel@suse.de>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 1/2] iommu/io-pgtable-arm: Add way to debug pgtable
 walk
Message-ID: <ZqeA2tq5Nw4zvqwD@google.com>
References: <20240717163627.43423-1-robdclark@gmail.com>
 <20240717163627.43423-2-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240717163627.43423-2-robdclark@gmail.com>

Hi Rob,

On Wed, Jul 17, 2024 at 09:36:21AM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Add an io-pgtable method to walk the pgtable returning the raw PTEs that
> would be traversed for a given iova access.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> Acked-by: Joerg Roedel <jroedel@suse.de>
> 
> ---
>  drivers/iommu/io-pgtable-arm.c | 36 +++++++++++++++++++++++++---------
>  include/linux/io-pgtable.h     | 17 ++++++++++++++++
>  2 files changed, 44 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 3d23b924cec1..e70803940b46 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -690,9 +690,11 @@ static size_t arm_lpae_unmap_pages(struct io_pgtable_ops *ops, unsigned long iov
>  				data->start_level, ptep);
>  }
>  
> -static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
> -					 unsigned long iova)
> +static int arm_lpae_pgtable_walk(struct io_pgtable_ops *ops,
> +				 unsigned long iova,
> +				 void *_wd)
>  {
> +	struct arm_lpae_io_pgtable_walk_data *wd = _wd;
>  	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
>  	arm_lpae_iopte pte, *ptep = data->pgd;
>  	int lvl = data->start_level;
> @@ -700,7 +702,7 @@ static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
>  	do {
>  		/* Valid IOPTE pointer? */
>  		if (!ptep)
> -			return 0;
> +			return -ENOENT;
>  
>  		/* Grab the IOPTE we're interested in */
>  		ptep += ARM_LPAE_LVL_IDX(iova, lvl, data);
> @@ -708,22 +710,37 @@ static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
>  
>  		/* Valid entry? */
>  		if (!pte)
> -			return 0;
> +			return -ENOENT;
>  
> -		/* Leaf entry? */
> +		wd->ptes[wd->level++] = pte;
> +
> +		/* Leaf entry?  If so, we've found the translation */
>  		if (iopte_leaf(pte, lvl, data->iop.fmt))
> -			goto found_translation;
> +			return 0;
>  
>  		/* Take it to the next level */
>  		ptep = iopte_deref(pte, data);
>  	} while (++lvl < ARM_LPAE_MAX_LEVELS);
>  
>  	/* Ran out of page tables to walk */
> -	return 0;
> +	return -ENOENT;
> +}
> +
> +static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
> +					 unsigned long iova)
> +{
> +	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
> +	struct arm_lpae_io_pgtable_walk_data wd = {};
> +	int ret, lvl;
> +
> +	ret = arm_lpae_pgtable_walk(ops, iova, &wd);
> +	if (ret)
> +		return 0;
> +
> +	lvl = wd.level + data->start_level;
>  
> -found_translation:
>  	iova &= (ARM_LPAE_BLOCK_SIZE(lvl, data) - 1);
> -	return iopte_to_paddr(pte, data) | iova;
> +	return iopte_to_paddr(wd.ptes[wd.level - 1], data) | iova;
>  }
>  
>  static void arm_lpae_restrict_pgsizes(struct io_pgtable_cfg *cfg)
> @@ -804,6 +821,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
>  		.map_pages	= arm_lpae_map_pages,
>  		.unmap_pages	= arm_lpae_unmap_pages,
>  		.iova_to_phys	= arm_lpae_iova_to_phys,
> +		.pgtable_walk	= arm_lpae_pgtable_walk,
>  	};
>  
>  	return data;
> diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> index 86cf1f7ae389..df6f6e58310c 100644
> --- a/include/linux/io-pgtable.h
> +++ b/include/linux/io-pgtable.h
> @@ -171,12 +171,28 @@ struct io_pgtable_cfg {
>  	};
>  };
>  
> +/**
> + * struct arm_lpae_io_pgtable_walk_data - information from a pgtable walk
> + *
> + * @ptes:     The recorded PTE values from the walk
> + * @level:    The level of the last PTE
> + *
> + * @level also specifies the last valid index in @ptes
> + */
> +struct arm_lpae_io_pgtable_walk_data {
> +	u64 ptes[4];

I don’t see a reason to save the whole walk for iova_to_phys,
I see that the DRM driver uses those next, but I am worried that
won’t scale, a callback mechanism sounds better.

Also, there is a page table walker recently added to io-pagtable-arm,
for dirty bit tracking:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/iommu/io-pgtable-arm.c?id=4fe88fd8b4aecb7f9680bf898811db76b94095a9

I’d suggest consolidating those into one walker where each caller
has its own logic in a callback.

Thanks,
Mostafa

> +	int level;
> +};
> +
>  /**
>   * struct io_pgtable_ops - Page table manipulation API for IOMMU drivers.
>   *
>   * @map_pages:    Map a physically contiguous range of pages of the same size.
>   * @unmap_pages:  Unmap a range of virtually contiguous pages of the same size.
>   * @iova_to_phys: Translate iova to physical address.
> + * @pgtable_walk: (optional) Perform a page table walk for a given iova.  The
> + *                type for the wd parameter is specific to pgtable type, as
> + *                the PTE size and number of levels differs per pgtable type.
>   *
>   * These functions map directly onto the iommu_ops member functions with
>   * the same names.
> @@ -190,6 +206,7 @@ struct io_pgtable_ops {
>  			      struct iommu_iotlb_gather *gather);
>  	phys_addr_t (*iova_to_phys)(struct io_pgtable_ops *ops,
>  				    unsigned long iova);
> +	int (*pgtable_walk)(struct io_pgtable_ops *ops, unsigned long iova, void *wd);
>  	int (*read_and_clear_dirty)(struct io_pgtable_ops *ops,
>  				    unsigned long iova, size_t size,
>  				    unsigned long flags,
> -- 
> 2.45.2
> 
