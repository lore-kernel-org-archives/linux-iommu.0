Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4D919049A
	for <iommu@lists.linux.dev>; Wed,  4 Dec 2024 10:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733307152; cv=none; b=Q34dugwgYFbZIlE6b+XDhb1ltmLbwYw10cC4dp8PEtAEqqRAhuFo2h4zTF56Uo3Sjrr5U3CfAYzdaUhtiVsAE7Qx1kq/B+w3Z0ARg+jPaLx3QwDKCUGPhgmuaRCEshhiPtf/z4fdhOU5hsuoAzpiqKRQwjkzd0IOTqMee4AQDl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733307152; c=relaxed/simple;
	bh=+CVqRn85L5p9rsCZcm5sKLRDW42VUw0gAJKUmesM+q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TiUUBHw7xm6xsIqv1nM9PzltcwbQ8MtY6j7hOKOdoWv3By6fi/tfbhN89ylCFjLEjbwXlHEAxQ/TtndogoSP8O6j0fYGb7FAONH8vmBiIa8hzMdVyNl9BnnVYD37TlVFhEq9Q6hL4ZJD8IdCwP94tvCQ20Ocui3cpgcDIKQjpA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X9ZU28i3; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X9ZU28i3"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4349c7b6b0dso35615e9.1
        for <iommu@lists.linux.dev>; Wed, 04 Dec 2024 02:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733307149; x=1733911949; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qLs+MAjnlkioXfCJEobmWlFJttU5DMSqco9NCjVHPyc=;
        b=X9ZU28i3wcfoWT0TBmZ/cb43K2mcU6OpFKaZjhF/Vwws1BEbhTip1yYKrr0RT+B9Ab
         4UJysrxfTBvkcZp27uoMkvZ2S7dh8Xe6F5KBkWt4e7sbiqE5FTtk2Op9O/AUHqobvMYa
         OUYdskXufaf9Mcpbyu6kpuURSh22NiaM26Po7syPsgOFx+NjM4UrQvJr0Q1iTfQIU750
         0beSgZmX5y/D0j6zODnQtEsmKJW2pZrV+Px9/jSrA2EjO2CTL/OcsjZGCOU7v1UEbe4d
         WTaEMw0ReEQv/YzK6ZXSrZzKYzFoX/qlnbdkDdY5VsRxhceNGxelYBlpR/haK4M3bWyU
         2ZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733307149; x=1733911949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLs+MAjnlkioXfCJEobmWlFJttU5DMSqco9NCjVHPyc=;
        b=JyOncggo02B/S+S7DyGSTPLJqdYtPQ8UOp5XKVSdnyAy7ANnrlsK8F0uqS21WixGL9
         mKibjoDWhuluG7yyGWSPJZi5pvWscx/yVN9PP9slPCEdw0SPTeJ/X2riTGIOUbQ+5sQH
         rLkm6xIcNPj4YZ9PKsD4cky4Hjhqmto12umUd9ZY81JYo6JRkLEScfym8KdT+SW0PB/Z
         ZKXy8Gmi7vRAnozY/6x4/eoaGxTWgoJ/6Lpe6vKe/tH8utFoX5ZXVgN3NfWZTgfd5GrI
         60cWrw8fF1dIx4xZ+tgH2Hh1c+81GGFI4htKBZRu+HyPqeVoHFesKaOWlK2oWZ0ylTH8
         +g4w==
X-Gm-Message-State: AOJu0YyOVg+u5xtRDNNFQpLySn9R2km34kdb1T0CIEYZILl5nzFemVRe
	z2C//rR+pPftxWDm1/4fHguruPbtVA8cGbWW9cfBFyUkKY9wxwSgsVZSxrxX7Q==
X-Gm-Gg: ASbGncsdX2F7Te9m+yJFvUsCeT6/MTGI1B3oRVooHFXaVJUCYb4A9y8Kl2r0rsR1b+4
	hQoib1/Hl8iXKpTov298a9C8Wi5+Dhz5J/bj6p3s5eAtYH7dclekejD3oMbXUD2NnOOtB+MCUMB
	2XIucwCPn2Rz/YoYFiDxwhWxrpRlQ12DSjdnqBaTz0CGy9b7V+1PSurYxdjjiHnsXfFP0/tPVgA
	pkoPpIMh4aYnZQFlENlQITK5WuetmthqL0OpwL++HAXAQQoPndpIn/nwBZ2XWuBLOehODcIvDBL
	CJ8vNN4UqfIF
X-Google-Smtp-Source: AGHT+IF9rW/W/KKMO9BVSr/bLw+TLa/dGxJXo2KOIrSL7bT2KMLiMDQYkoQTQpYdu8So3eWOjlcV+w==
X-Received: by 2002:a05:600c:4a93:b0:42c:acd7:b59b with SMTP id 5b1f17b1804b1-434d4aab051mr1048795e9.6.1733307148736;
        Wed, 04 Dec 2024 02:12:28 -0800 (PST)
Received: from google.com (158.100.79.34.bc.googleusercontent.com. [34.79.100.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385eeb999f4sm9494986f8f.109.2024.12.04.02.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 02:12:28 -0800 (PST)
Date: Wed, 4 Dec 2024 10:12:24 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Rob Clark <robdclark@gmail.com>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Clark <robdclark@chromium.org>, Joerg Roedel <joro@8bytes.org>,
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 1/4] iommu/io-pgtable-arm: Make pgtable walker more
 generic
Message-ID: <Z1ArCCTGtJY9gxP3@google.com>
References: <20241028213146.238941-1-robdclark@gmail.com>
 <20241028213146.238941-2-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028213146.238941-2-robdclark@gmail.com>

Hi Rob,

On Mon, Oct 28, 2024 at 02:31:37PM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> We can re-use this basic pgtable walk logic in a few places.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Mostafa Saleh <smostafa@google.com>

> ---
>  drivers/iommu/io-pgtable-arm.c | 67 ++++++++++++++++++++++------------
>  1 file changed, 43 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 0e67f1721a3d..7e9c0f8ae138 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -749,33 +749,33 @@ static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
>  }
>  
>  struct io_pgtable_walk_data {
> -	struct iommu_dirty_bitmap	*dirty;
> +	struct io_pgtable		*iop;
> +	void				*data;
> +	int (*visit)(struct io_pgtable_walk_data *walk_data, int lvl,
> +		     arm_lpae_iopte *ptep, size_t size);
>  	unsigned long			flags;
>  	u64				addr;
>  	const u64			end;
>  };
>  
> -static int __arm_lpae_iopte_walk_dirty(struct arm_lpae_io_pgtable *data,
> -				       struct io_pgtable_walk_data *walk_data,
> -				       arm_lpae_iopte *ptep,
> -				       int lvl);
> +static int __arm_lpae_iopte_walk(struct arm_lpae_io_pgtable *data,
> +				 struct io_pgtable_walk_data *walk_data,
> +				 arm_lpae_iopte *ptep,
> +				 int lvl);
>  
> -static int io_pgtable_visit_dirty(struct arm_lpae_io_pgtable *data,
> -				  struct io_pgtable_walk_data *walk_data,
> -				  arm_lpae_iopte *ptep, int lvl)
> +static int io_pgtable_visit(struct arm_lpae_io_pgtable *data,
> +			    struct io_pgtable_walk_data *walk_data,
> +			    arm_lpae_iopte *ptep, int lvl)
>  {
>  	struct io_pgtable *iop = &data->iop;
>  	arm_lpae_iopte pte = READ_ONCE(*ptep);
>  
> -	if (iopte_leaf(pte, lvl, iop->fmt)) {
> -		size_t size = ARM_LPAE_BLOCK_SIZE(lvl, data);
> +	size_t size = ARM_LPAE_BLOCK_SIZE(lvl, data);
> +	int ret = walk_data->visit(walk_data, lvl, ptep, size);
> +	if (ret)
> +		return ret;
>  
> -		if (iopte_writeable_dirty(pte)) {
> -			iommu_dirty_bitmap_record(walk_data->dirty,
> -						  walk_data->addr, size);
> -			if (!(walk_data->flags & IOMMU_DIRTY_NO_CLEAR))
> -				iopte_set_writeable_clean(ptep);
> -		}
> +	if (iopte_leaf(pte, lvl, iop->fmt)) {
>  		walk_data->addr += size;
>  		return 0;
>  	}
> @@ -784,13 +784,13 @@ static int io_pgtable_visit_dirty(struct arm_lpae_io_pgtable *data,
>  		return -EINVAL;
>  
>  	ptep = iopte_deref(pte, data);
> -	return __arm_lpae_iopte_walk_dirty(data, walk_data, ptep, lvl + 1);
> +	return __arm_lpae_iopte_walk(data, walk_data, ptep, lvl + 1);
>  }
>  
> -static int __arm_lpae_iopte_walk_dirty(struct arm_lpae_io_pgtable *data,
> -				       struct io_pgtable_walk_data *walk_data,
> -				       arm_lpae_iopte *ptep,
> -				       int lvl)
> +static int __arm_lpae_iopte_walk(struct arm_lpae_io_pgtable *data,
> +				 struct io_pgtable_walk_data *walk_data,
> +				 arm_lpae_iopte *ptep,
> +				 int lvl)
>  {
>  	u32 idx;
>  	int max_entries, ret;
> @@ -805,7 +805,7 @@ static int __arm_lpae_iopte_walk_dirty(struct arm_lpae_io_pgtable *data,
>  
>  	for (idx = ARM_LPAE_LVL_IDX(walk_data->addr, lvl, data);
>  	     (idx < max_entries) && (walk_data->addr < walk_data->end); ++idx) {
> -		ret = io_pgtable_visit_dirty(data, walk_data, ptep + idx, lvl);
> +		ret = io_pgtable_visit(data, walk_data, ptep + idx, lvl);
>  		if (ret)
>  			return ret;
>  	}
> @@ -813,6 +813,23 @@ static int __arm_lpae_iopte_walk_dirty(struct arm_lpae_io_pgtable *data,
>  	return 0;
>  }
>  
> +static int visit_dirty(struct io_pgtable_walk_data *walk_data, int lvl,
> +		       arm_lpae_iopte *ptep, size_t size)
> +{
> +	struct iommu_dirty_bitmap *dirty = walk_data->data;
> +
> +	if (!iopte_leaf(*ptep, lvl, walk_data->iop->fmt))
> +		return 0;
> +
> +	if (iopte_writeable_dirty(*ptep)) {
> +		iommu_dirty_bitmap_record(dirty, walk_data->addr, size);
> +		if (!(walk_data->flags & IOMMU_DIRTY_NO_CLEAR))
> +			iopte_set_writeable_clean(ptep);
> +	}
> +
> +	return 0;
> +}
> +
>  static int arm_lpae_read_and_clear_dirty(struct io_pgtable_ops *ops,
>  					 unsigned long iova, size_t size,
>  					 unsigned long flags,
> @@ -821,7 +838,9 @@ static int arm_lpae_read_and_clear_dirty(struct io_pgtable_ops *ops,
>  	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
>  	struct io_pgtable_cfg *cfg = &data->iop.cfg;
>  	struct io_pgtable_walk_data walk_data = {
> -		.dirty = dirty,
> +		.iop = &data->iop,
> +		.data = dirty,
> +		.visit = visit_dirty,
>  		.flags = flags,
>  		.addr = iova,
>  		.end = iova + size,
> @@ -836,7 +855,7 @@ static int arm_lpae_read_and_clear_dirty(struct io_pgtable_ops *ops,
>  	if (data->iop.fmt != ARM_64_LPAE_S1)
>  		return -EINVAL;
>  
> -	return __arm_lpae_iopte_walk_dirty(data, &walk_data, ptep, lvl);
> +	return __arm_lpae_iopte_walk(data, &walk_data, ptep, lvl);
>  }
>  
>  static void arm_lpae_restrict_pgsizes(struct io_pgtable_cfg *cfg)
> -- 
> 2.47.0
> 
