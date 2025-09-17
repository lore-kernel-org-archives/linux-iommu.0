Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADEA24678A
	for <iommu@lists.linux.dev>; Wed, 17 Sep 2025 20:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758140421; cv=none; b=Dc5ewkZzpybv/mrznJVAEOIY5AjVWi9WGoyTQy9S8ltOXdN4mLrN61BAJvfrQifrFEFCMWRPsB/UAa0VNlzv2n/z5OZgzKpeLIoQeNS6c4EUJEBTGPzIZPRfcDdOFr/+i7Ejb2wV30lGLWop1cx8/L2LGUxLoNskmXoAft6NEx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758140421; c=relaxed/simple;
	bh=4omv285GFnETMoPBdlr9gFLdRl2gv0X9eXz/X1i159w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I032InVS/33Pm3s8uDcvBB/0v8rTaKCRfUXBEJfygfXyhABchLu7Cumzxem/yj8BpXyoRNhqdTGLppH/cNUuCEOmh5K0yM2leoqnZK+cO1C1azjqI+VnBaZ5l5YPMpZ3Wosgu/fP3LxXsjHcxiPLjPCqI4j2XcbUVoNTgMFgC04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IIFLcyMk; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IIFLcyMk"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45f30011eceso4545e9.1
        for <iommu@lists.linux.dev>; Wed, 17 Sep 2025 13:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758140418; x=1758745218; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XoUhSQnd7IfUTabpSDtGCH3l3cdjv1ByOw0labXn8P4=;
        b=IIFLcyMkulcT/owQPzgjcwyEAieBuemyh3ktp/lPEQxMSwkBOt3/YvAKhjAzMWgAq1
         W4B0KTNtORgD4mooO11f/JC07conojBzeW4V4hITE/wwJGkpcufyTdeVfIpkguNV65Rv
         sLEHWdKjsdqf/enIVdg3zt/L7wubfQnZG4iHgMgY5HhxbkMbH+5uAc0ejZnnWK47l2Nw
         7r33qIjRxu7ElpvrxFI9ivBXUawDUqzpxTHRkjFGngux0LdwtAxjvB9AguxERavaFHhr
         6Uks/0LZcdPns3CUc6kALE3ycAY6VxiKWkaz+zGbwyKsXlfUZgrzrjI0IVJkDSM+K8rT
         X0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758140418; x=1758745218;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XoUhSQnd7IfUTabpSDtGCH3l3cdjv1ByOw0labXn8P4=;
        b=tsouzMA0ECitdK3wqJsxVccj3zr68KUl/WCQ6ua8mmZ7A1TQrCL0YT237OmnkR1K5Z
         A+/Noiseu4a+whbmCkVAVYTgjNL6GrYwXTMuoMkHZnPiJFEOO/69k9eg84axdmltf/JH
         XF1ndmLXG8oXVTeIiTw4Wkyst7LEaqdFNYrvFl6U2vmBzvGo/JrspfNFmKGEOfgcAUlf
         xGUIcv3y6A4VX4/zGG6dLCZeunfK/kMRNnKj5M3M+5/TKPe39y6koYyCou6GiR29Yojj
         b9DkpxFRnWaODiYovpYI9h6QZC5gwyMYAmoiaOcCHXoOe9Kv7NGQXJZcDrF1TEJYZudR
         ac1w==
X-Gm-Message-State: AOJu0Yx7xYL2I9lUe+YJ6dVb107kBg7oRfoY9Z0ss4zNw0yY8k39ySqb
	bXe2LXzZgKzji1V9Sw2urpCx9UAiZTRgcu7HPlJs7gdfumFoFFj35m9ulqWhoCbOpQ==
X-Gm-Gg: ASbGncvziXmrrQRFLmA0GwH5FxlyI+LIduww6tGygtjby/vMuVdge1rUT7ezebZjp1u
	roytkzgxn7wFX/Ggo+YzmvG2VC2RApAtUqz7cRmbnNIx6yir4tIPmqbBBwKeMA3xL/0KYj88BlL
	CW6DE79+CO8hvVjkfr+L4OgTkrFoEwQl2Zq0eyzCXa6EwRENzvLrRm2ByrSUQff9WGIfdEBBO1K
	vUbnBsxRjXx10QT6yJ05m1meq+ORlk2HGoUEH7TIEO3Ob7An3/ot7wqW4UThSaEmVPtvaG2OYhE
	cNehpJ0WJYN+TFwIHD345zbOp9Y5ToO1LdEdqDgvJAR/CGeA7GKJ1psEihVsVL3fOA27GyCBYKh
	dZU6byvuiU6TgUGEM/0AlJHlKOImPolJrtZ2q6of4Pw7ws+OpS7noFjhILEgxrvBi7WO0H/lmk4
	zsDEP6NL6yzWgO
X-Google-Smtp-Source: AGHT+IGL88nN+OqGfm1HaJnu3LWbX2CcWRBICMmdu5JCioCD/g1gYZjfAdwJ3rB3P8WH9nqDGiZ/5Q==
X-Received: by 2002:a05:600c:a404:b0:45b:9bcb:205 with SMTP id 5b1f17b1804b1-461e37283d8mr1338655e9.5.1758140417528;
        Wed, 17 Sep 2025 13:20:17 -0700 (PDT)
Received: from google.com (157.24.148.146.bc.googleusercontent.com. [146.148.24.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f0aac271sm9659905e9.3.2025.09.17.13.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 13:20:16 -0700 (PDT)
Date: Wed, 17 Sep 2025 20:20:12 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, praan@google.com
Subject: Re: [PATCH v2 1/3] iommu/io-pgtable-arm: Move selftests to a
 separate file
Message-ID: <aMsX_HafW3rLs5dQ@google.com>
References: <20250917191143.3847487-1-smostafa@google.com>
 <20250917191143.3847487-2-smostafa@google.com>
 <20250917193818.GK1326709@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250917193818.GK1326709@ziepe.ca>

On Wed, Sep 17, 2025 at 04:38:18PM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 17, 2025 at 07:11:38PM +0000, Mostafa Saleh wrote:
> > +static void __init arm_lpae_dump_ops(struct io_pgtable_ops *ops)
> > +{
> > +	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
> > +	struct io_pgtable_cfg *cfg = &data->iop.cfg;
> 
> Can be:
> 
>        struct io_pgtable_cfg *cfg =
>                &io_pgtable_ops_to_pgtable(pgtbl_ops)->cfg;

There are a bunch of other formatting issues here also, but I wanted to
move the code as is, so with “--color-moved” you can see the exact
difference, otherwise, it’s harder to review.

I can add a patch before to fix those + the printing as you suggested
next.

> 
> > +
> > +	pr_err("cfg: pgsize_bitmap 0x%lx, ias %u-bit\n",
> > +		cfg->pgsize_bitmap, cfg->ias);
> > +	pr_err("data: %d levels, 0x%zx pgd_size, %u pg_shift, %u bits_per_level, pgd @ %p\n",
> > +		ARM_LPAE_MAX_LEVELS - data->start_level, ARM_LPAE_PGD_SIZE(data),
> > +		ilog2(ARM_LPAE_GRANULE(data)), data->bits_per_level, data->pgd);
> 
> The entire struct arm_lpae_io_pgtable is exposed to a public header
> just for this one print.. Seems undesirable.
> 
> Drop the print? Honestly, I prefer this, given the maturity let's not
> compromise modularity to print someting nobody will ever read..
> 
> Alternatively call a kunit-only exported function to do the print
> directly from ops so. smmuv3 has an example how to do that
> 
> Either way a precursor patch to adjust it will allow this patch to
> avoid publishing most stuff.

I don’t have a strong opinion about this, but I am more inclined to
keep the prints considering it’s a low-level test for the page table,
and such parameters would be useful to understand the failures.

Moving arm_lpae_dump_ops() to the core library will leak the kunit
struct, but we can drop the kunit_err and rely on pr_err().

I know this is not relevant to this series, but the KVM driver will
need to expose arm_lpae_io_pgtable anyway.

>
> > +/*
> > + * Calculate the right shift amount to get to the portion describing level l
> > + * in a virtual address mapped by the pagetable in d.
> > + */
> > +#define ARM_LPAE_LVL_SHIFT(l,d)						\
> > +	(((ARM_LPAE_MAX_LEVELS - (l)) * (d)->bits_per_level) +		\
> > +	ilog2(sizeof(arm_lpae_iopte)))
> 
> Didn't see this being used?

Yes, my bad, I will move it and the other one back.

Thanks,
Mostafa

> 
> > +#define ARM_LPAE_GRANULE(d)						\
> > +	(sizeof(arm_lpae_iopte) << (d)->bits_per_level)
> 
> Only used by the above print
> 
> > +#define ARM_LPAE_PGD_SIZE(d)						\
> > +	(sizeof(arm_lpae_iopte) << (d)->pgd_bits)
> 
> Only used by the above print
> 
> > +#define ARM_LPAE_PTES_PER_TABLE(d)					\
> > +	(ARM_LPAE_GRANULE(d) >> ilog2(sizeof(arm_lpae_iopte)))
> 
> Didn't see this being used?
> 
> > +typedef u64 arm_lpae_iopte;
> 
> Only used by the defines and the above print.
> 
> Jason
