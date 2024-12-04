Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988D21A7AC7
	for <iommu@lists.linux.dev>; Wed,  4 Dec 2024 10:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733307252; cv=none; b=V8z4v8WE7xp9JvP5wpQFFdw+pxGa9r9HPIc405jcJqJgubPoIZeAyBFXMqiP3bbGDmPnAa2F9seUL3CfxteVuyLFUlvgMXsCkHmDB1TPm4bpXRJJ2HkckX/xpjL5WD4TmJEfZgJ6xHdIHcAQTLjAhzh1s+Hpp3/7eiOotUAxt98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733307252; c=relaxed/simple;
	bh=Pb5PvvE+iVrNyh93aC+zFTPSNXVqukPP+d4ZZTW9AUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I53dQV8vKj5rIItKFNecfed5rxN1hVcEr0+sPDPVOndyBPC29YLOd0+sLkI9SDVUbQlWbpidKTDZU9xg9qmEmtjdBOJPz0gIzqUjAXA3AZXjOzP0imXOH0oIT6NeaXjhaM2zznGJube9nVwnCg/Nq/xhcl1aZfRvXenQxWEdxMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U+U5S83w; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U+U5S83w"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4349c7b6b0dso35745e9.1
        for <iommu@lists.linux.dev>; Wed, 04 Dec 2024 02:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733307249; x=1733912049; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BMGnNPxPYgtjLytE4uW9hhJz+Jg05BhCFp2UIgwDwC0=;
        b=U+U5S83woAbss8/Ut8l1C4bIvKefl4X0OKoxlvvzFIN3n4KfvB8z2mmVpk6t89ydPU
         n6qJ/XkzTJyTH/cknYQQ1nOBjKfCcxtV01j3opxjLNHyg/o1pGhBY21fmpNAGhZiovIv
         hhGN70BWDzUyS2GsDlJBtL/4B3cDkuwEMiMbZhzAku1GLKufX/IdimcFHTWGE4TB5kIY
         nryLOURKNFyZQrtnnPImrB0dfcQwEzBqduSWfRewPCck6RKGP+1NHgyxcNW+JQpjXVdx
         Rvz/lYPhTgj+cMLZcZPGBh3/sOexENCbCz3vlFalvOhUN+288X6JorlV39Vx+8hOFp2q
         n/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733307249; x=1733912049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BMGnNPxPYgtjLytE4uW9hhJz+Jg05BhCFp2UIgwDwC0=;
        b=c+QCt05bFOWINgS4+j58UsH/Cto9Ae+7VnZRB9Xfk5UIfY8kRPLvJ4km2f/jhMZqYB
         DqxVHblgQGmycz8uOWei6eIaS7ZKSAzTVXWh4YWvHrC2i+m2G9EMPgH7gS6ZnJ03pAiq
         qrVChAkx50hvCxVvOEv4F2jkpJ6qo2zE1mJ1tkcmyiLAalDSEu4MGynPXmpnC1BhCl+t
         sgyZRod1J7P2vodSHyspH95xOsMNkKFlExuawDu5XirTQKJcJ72slVll+xQNBcY3opGx
         6T67u/PF84QEvEVHaclUp+6m8yK/3BMf7VpwIKeRe18sJH3NQRqaRICZ1ZZPyZJeNo2z
         fo4w==
X-Gm-Message-State: AOJu0Yxh30RHhZa4FR8AFN9WqxBRr0EXl+CmJp+M8WYLgkWqEYGut6yL
	MlfJa5ZpdIiVuAKD6i6eL76TzlyQ4mnF5kEXOhYk9tnv4lPO32863XyZpp6O8g==
X-Gm-Gg: ASbGnctzk8YqBim0CH0WHTT2dwvm0kuso+l/6S0i546tw3tmwCzIDPQVkPxPsa3Vop8
	OYLQnvnNKiUR0OMl7VUdv8DvDAI1qNOVPHASLn5TpOncvNdsElD8Hmj+8nVmsaPN+WAcerYUlNH
	Wj1+6cFR/nHDUDmVpsiU5+oTms9UULZ0wgQlYTKsqwjXNHoKzP6C+9hs5FfOeAPQAfiUfp+G+UP
	Fs+rbFQbtd9lX0cauVQGCFDoLQtv0FnlEjnp0ToLm6xa/KQkdltVkfFIKo5ALnroXCGr+SsifoS
	qImVuAKNIbHt
X-Google-Smtp-Source: AGHT+IEI5ovyp1RCIv/DEgpLwXFNydHyjD9DBddbq5V/1dJpcQ7kJme1DtYiR17VJHUI0rTtCpgyHQ==
X-Received: by 2002:a7b:ca4d:0:b0:434:9ff3:8ffc with SMTP id 5b1f17b1804b1-434d4aaada7mr918595e9.4.1733307248895;
        Wed, 04 Dec 2024 02:14:08 -0800 (PST)
Received: from google.com (158.100.79.34.bc.googleusercontent.com. [34.79.100.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e4617a61sm12383645f8f.3.2024.12.04.02.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 02:14:08 -0800 (PST)
Date: Wed, 4 Dec 2024 10:14:04 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Rob Clark <robdclark@gmail.com>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Clark <robdclark@chromium.org>, Joerg Roedel <joro@8bytes.org>,
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 2/4] iommu/io-pgtable-arm: Re-use the pgtable walk
 for iova_to_phys
Message-ID: <Z1ArbJbqAnD-Qn52@google.com>
References: <20241028213146.238941-1-robdclark@gmail.com>
 <20241028213146.238941-3-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028213146.238941-3-robdclark@gmail.com>

Hi Rob,

On Mon, Oct 28, 2024 at 02:31:38PM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Re-use the generic pgtable walk path.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

> ---
>  drivers/iommu/io-pgtable-arm.c | 74 +++++++++++++++++-----------------
>  1 file changed, 37 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 7e9c0f8ae138..88b128c77893 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -712,42 +712,6 @@ static size_t arm_lpae_unmap_pages(struct io_pgtable_ops *ops, unsigned long iov
>  				data->start_level, ptep);
>  }
>  
> -static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
> -					 unsigned long iova)
> -{
> -	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
> -	arm_lpae_iopte pte, *ptep = data->pgd;
> -	int lvl = data->start_level;
> -
> -	do {
> -		/* Valid IOPTE pointer? */
> -		if (!ptep)
> -			return 0;
> -
> -		/* Grab the IOPTE we're interested in */
> -		ptep += ARM_LPAE_LVL_IDX(iova, lvl, data);
> -		pte = READ_ONCE(*ptep);
> -
> -		/* Valid entry? */
> -		if (!pte)
> -			return 0;
> -
> -		/* Leaf entry? */
> -		if (iopte_leaf(pte, lvl, data->iop.fmt))
> -			goto found_translation;
> -
> -		/* Take it to the next level */
> -		ptep = iopte_deref(pte, data);
> -	} while (++lvl < ARM_LPAE_MAX_LEVELS);
> -
> -	/* Ran out of page tables to walk */
> -	return 0;
> -
> -found_translation:
> -	iova &= (ARM_LPAE_BLOCK_SIZE(lvl, data) - 1);
> -	return iopte_to_paddr(pte, data) | iova;
> -}
> -
>  struct io_pgtable_walk_data {
>  	struct io_pgtable		*iop;
>  	void				*data;
> @@ -763,6 +727,41 @@ static int __arm_lpae_iopte_walk(struct arm_lpae_io_pgtable *data,
>  				 arm_lpae_iopte *ptep,
>  				 int lvl);
>  
> +struct iova_to_phys_data {
> +	arm_lpae_iopte pte;
> +	int lvl;
> +};
> +
> +static int visit_iova_to_phys(struct io_pgtable_walk_data *walk_data, int lvl,
> +			      arm_lpae_iopte *ptep, size_t size)
> +{
> +	struct iova_to_phys_data *data = walk_data->data;
> +	data->pte = *ptep;
> +	data->lvl = lvl;
> +	return 0;
> +}
> +
> +static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
> +					 unsigned long iova)
> +{
> +	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
> +	struct iova_to_phys_data d;
> +	struct io_pgtable_walk_data walk_data = {
> +		.data = &d,
> +		.visit = visit_iova_to_phys,
> +		.addr = iova,
> +		.end = iova + 1,
> +	};
> +	int ret;
> +
> +	ret = __arm_lpae_iopte_walk(data, &walk_data, data->pgd, data->start_level);
> +	if (ret)
> +		return 0;
> +
> +	iova &= (ARM_LPAE_BLOCK_SIZE(d.lvl, data) - 1);
> +	return iopte_to_paddr(d.pte, data) | iova;
> +}
> +
>  static int io_pgtable_visit(struct arm_lpae_io_pgtable *data,
>  			    struct io_pgtable_walk_data *walk_data,
>  			    arm_lpae_iopte *ptep, int lvl)
> @@ -780,8 +779,9 @@ static int io_pgtable_visit(struct arm_lpae_io_pgtable *data,
>  		return 0;
>  	}
>  
> -	if (WARN_ON(!iopte_table(pte, lvl)))
> +	if (!iopte_table(pte, lvl)) {
>  		return -EINVAL;
> +	}
>  
>  	ptep = iopte_deref(pte, data);
>  	return __arm_lpae_iopte_walk(data, walk_data, ptep, lvl + 1);
> -- 
> 2.47.0
> 
