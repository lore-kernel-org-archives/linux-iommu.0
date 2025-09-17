Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591401FBEB9
	for <iommu@lists.linux.dev>; Wed, 17 Sep 2025 19:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758137902; cv=none; b=TgJBx2U2fszN6IVBHAWD1AvnId6PiuT+unnK1816eABtaKqjT+xGqljy1M2hkxoxpYfS5L5Qo3txQZEWKk7zI+Ss1ZCdXPdn6sKHcEcG9xGGxQaDdZcFhGwlW4iZg/DmLFfHS16u2QsOaqIZ2saTsihUJmfrjRvMNHXATmegwus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758137902; c=relaxed/simple;
	bh=GVy6Pfve9fhUKRVNJRlAnEGSUzecOkZpiquPMdRKjA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gl6qNMHFtaDVvypaQ/U7KlBlE8rNVBgkN5eINAbswksnkhC/J0MfGPjyBqsys+avukc5UDGD/LTL/VM6fUgyZA+1XrNipO8rFa3rP1Tp6HgxFB+tDS9DsC2flmGO04/v8C2D8sYLX6ix7h5+hpg15dpX3HaqbUiBKBZl+40Xijk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=QGpcvBSA; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QGpcvBSA"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-826311c1774so21132485a.2
        for <iommu@lists.linux.dev>; Wed, 17 Sep 2025 12:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758137899; x=1758742699; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zn0Is8eeOR4Gu6G7tdLKQq8N5ufCD33SLmEnkNniBDc=;
        b=QGpcvBSAM3rzEQgdPpbhY5Bq6B2mGred0VvfHM9SOmzVeLlEmJR8mlZecNIvyBUFR+
         qV4Fki654YY4AdA+K6ekmfcbmBgT9XqfBWso1pE5ZhpkXioen/p6QJUNm1gnVupH+YCC
         rD5KkAKq+2pw2ugA+MbcCvA9s8h5YKp5ge9B/Ut1Dh6CZlXIbWui4YxJYdq2KciN/PKc
         JMFBLbe4KNesQt6bQiwTcw/FSNTNZVBtf5IGHOZoHBLxh1e8kyDpKFoFqn52Rg9OQlRC
         hUGXxgbXitSYyq1rZOuezrb85KpyG8UqrpEzi5A0NhWjE36/pe+VSvQQP7O6Zf5fB1EL
         IAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758137899; x=1758742699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zn0Is8eeOR4Gu6G7tdLKQq8N5ufCD33SLmEnkNniBDc=;
        b=Q7Ny5uZDbIYs3+tQsH6aEJyBGfjYrxND6917qMR6fOokECi+oB0IKVJXb9v9hEHV0v
         FZ1X5g2c63Iy4UmHx4Nj8P/05QmC4Zox4QAluLNMbNyGV7rKFNK2JC1TML4i3o48E9LY
         fqG2RWLFPr4LTajeLyBzDJUPGb6tqm48d2aTRZu8yHGKQTzbyeiSHMHf8BvRVWs7S886
         ghqazqgKtc6XiH4bZ8XevYBeuvZ6LX/O2aLMlbqKcX4h3d5RyUrwdmYe4FRgtttn6TOZ
         L0VRo6YuLjoooze7GpxDOQAW6XNfYpSWUcZ6xOqqd8QsvgvBaXrbkUiNoXm7BnbJX8hq
         smTg==
X-Gm-Message-State: AOJu0Yx6acfHnHOHCygSDXrspnJ8RUaX+uHwuwPvE02UogVLtWrX5z7/
	5T4b17UidriwjpllQqfRSuKOkOKFggaPKm0zpEZaRAEJ+iiEj7hyoMRIH9S9ARCr1Ao=
X-Gm-Gg: ASbGnctngoiKua+NoOVn8QQ9pROUwztky8CtBS6fD5v1A4TDJrTYsGU6QKz6BdsKXzJ
	P6sfF8z5RL8sIzQC/tYNuGsUwNiA/b1A7n7CWZrbJJ9cp7qpgeoqfLlLC2cSWjtqmbS/AWCr9Kb
	azEmF4BgHjyuIlqdeGWhZu6VxhYMsZQQATAg0jl86iZoR/6Ys008dr1B11XLFaw93c94wkgQ9BH
	A46BprLpfzoh2w3G3Z7YjtmM+UQ1jjBq0e1bi7h3ZRRGsv8U8vZmVaCCTbLvk2bmfEOeD/w084P
	34ptyDbkA0MeGgtJGMzwUwF9oZc/XuXNt8K1nyv8y6eLCy81ufWe+j2wdF+xUdpvA+iYT5hkTg/
	ujsuphZf8YV0dnWqKxwZExOo/znNZNUuKxUSJf/QIPVy4Cvk4r65CjG6h0muvy9qyTt6i
X-Google-Smtp-Source: AGHT+IEijZbrq+i+0WS1CBxKV2AIyy3lPGfFcOI06YkWPNxuKICHcEdaLnL2uf7gK6Yw1m11T0+frw==
X-Received: by 2002:a05:620a:4406:b0:810:511f:3885 with SMTP id af79cd13be357-8310da0c6e3mr377680985a.33.1758137899133;
        Wed, 17 Sep 2025 12:38:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-836263ab0e4sm34559685a.11.2025.09.17.12.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 12:38:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uyxys-00000008n8R-0Qxu;
	Wed, 17 Sep 2025 16:38:18 -0300
Date: Wed, 17 Sep 2025 16:38:18 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, praan@google.com
Subject: Re: [PATCH v2 1/3] iommu/io-pgtable-arm: Move selftests to a
 separate file
Message-ID: <20250917193818.GK1326709@ziepe.ca>
References: <20250917191143.3847487-1-smostafa@google.com>
 <20250917191143.3847487-2-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917191143.3847487-2-smostafa@google.com>

On Wed, Sep 17, 2025 at 07:11:38PM +0000, Mostafa Saleh wrote:
> +static void __init arm_lpae_dump_ops(struct io_pgtable_ops *ops)
> +{
> +	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
> +	struct io_pgtable_cfg *cfg = &data->iop.cfg;

Can be:

       struct io_pgtable_cfg *cfg =
               &io_pgtable_ops_to_pgtable(pgtbl_ops)->cfg;

> +
> +	pr_err("cfg: pgsize_bitmap 0x%lx, ias %u-bit\n",
> +		cfg->pgsize_bitmap, cfg->ias);
> +	pr_err("data: %d levels, 0x%zx pgd_size, %u pg_shift, %u bits_per_level, pgd @ %p\n",
> +		ARM_LPAE_MAX_LEVELS - data->start_level, ARM_LPAE_PGD_SIZE(data),
> +		ilog2(ARM_LPAE_GRANULE(data)), data->bits_per_level, data->pgd);

The entire struct arm_lpae_io_pgtable is exposed to a public header
just for this one print.. Seems undesirable.

Drop the print? Honestly, I prefer this, given the maturity let's not
compromise modularity to print someting nobody will ever read..

Alternatively call a kunit-only exported function to do the print
directly from ops so. smmuv3 has an example how to do that

Either way a precursor patch to adjust it will allow this patch to
avoid publishing most stuff.

> +/*
> + * Calculate the right shift amount to get to the portion describing level l
> + * in a virtual address mapped by the pagetable in d.
> + */
> +#define ARM_LPAE_LVL_SHIFT(l,d)						\
> +	(((ARM_LPAE_MAX_LEVELS - (l)) * (d)->bits_per_level) +		\
> +	ilog2(sizeof(arm_lpae_iopte)))

Didn't see this being used?

> +#define ARM_LPAE_GRANULE(d)						\
> +	(sizeof(arm_lpae_iopte) << (d)->bits_per_level)

Only used by the above print

> +#define ARM_LPAE_PGD_SIZE(d)						\
> +	(sizeof(arm_lpae_iopte) << (d)->pgd_bits)

Only used by the above print

> +#define ARM_LPAE_PTES_PER_TABLE(d)					\
> +	(ARM_LPAE_GRANULE(d) >> ilog2(sizeof(arm_lpae_iopte)))

Didn't see this being used?

> +typedef u64 arm_lpae_iopte;

Only used by the defines and the above print.

Jason
