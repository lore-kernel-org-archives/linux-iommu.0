Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0AC146D7F
	for <iommu@lists.linux.dev>; Wed,  4 Sep 2024 07:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725434975; cv=none; b=GvYJPIjhR9n/35dwiPl1zXyPiilLkjVpqLg6z7NfVMH5Kc5A1kkBgtZ7WlQ/nKOB0VvURUPq9IZOXFnJXXu8Tl32Afw2bG7ZPLr8iQVyelGj9BZyTPiwn3hQNIluYB/0oCgqJJZeITn5nvhyTWoIdwT+oB9zyBP+o9TEJWVuQIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725434975; c=relaxed/simple;
	bh=pRN7+oax/Nx7fvJN49hPQ3AHM2UQgGliWcqGdCj8pt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezs3MTc83+iDzv+JSZ91EW0DACI86r9CfgXqrsngqFrmbQc+dqKFzomZ2+XIy94qr17276wz1xlpUecPK7wxsFTcDOY5gVPHEAdWXYeOc0Rn2sLDxAQaCEtXy7JyelhP6LuKNUQxXJ5hihJotPri+qGTH3OmDu4aNHBznhzIbiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M5LvlQN6; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M5LvlQN6"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3780c8d689aso42793f8f.0
        for <iommu@lists.linux.dev>; Wed, 04 Sep 2024 00:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725434972; x=1726039772; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fxPvC9OW9Ktpk2Avz/xTd0h7tOPJO4rWjfU5sl7IhvM=;
        b=M5LvlQN6KBcsHIFTUIQ149djFfOQ0tZet0DuhB8n7tO6RN3mKqUUlI3MyOGgFbbqR3
         nKkBCraS5p4s32+PzOHlPHxc4Ifss8QhsOFquJH7L6deCa7LbYSBCpH4jvmx2jk1BvfP
         +dkQ8wpyjSY7vRWJCPQ7Uy9VR9IpGy15Lw+09E9TVLmUKoeaEsPOEc9raTZGWKoAFtzx
         8KaZhIt6Llby4VVFOjIGFdRah8U74ftD8JhdfuYGQ/KSIkjJHuxX465aZnn7WKxAGDiN
         quXQff+BITF4UG1iFc9e8B/BpT1b7xsQVm9WLuvatIFnKdf8677SgdwqETVg/CtZq5Rx
         h6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725434972; x=1726039772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxPvC9OW9Ktpk2Avz/xTd0h7tOPJO4rWjfU5sl7IhvM=;
        b=J/G7ATAqyGWT0FhlZOrgjcyxxwIspfkUdcMjA7zTLEczKrNzoTxSLoP0UHThDIf1Ix
         zi3dSVMOsbA0Q88doDey4t8j66bF4lmieSQ0Yr73l7z1S7IMu4TE2Rvg1s4A4pBLQtlc
         PXUYYypOVtjhRW/WwxHndAHdZaBy2jzm9iQ1gN9/IYGVOpkdr6kPke+wzqv1pSYZElhH
         2TQ78L7sjludCbh2IL82bPZo372ngb4YH022+wy/bAnp/HH43FI1+O1wzha8E5TkmNhw
         OKpZa24eQXFompk0r630fwgRAOCtxIFU4E7fMSo/lCEeEwAtYScTJ4S/If08cfm7ESIV
         +3Uw==
X-Forwarded-Encrypted: i=1; AJvYcCVwCprtAEGiNvxUXfyPwtPGZbVcvi9hjR7qUg/gb/b1LavGNro+misd5vpqwIUUqdtJi4vApw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4MFn1JzrtBB5tD6eZjBxu9rnCeTYtGr4rIfCyQIb+ndFwmMeY
	gGxkto773sGm6sZHOnv5DrJapuNZBogjdHwFlcU+POmjwFcj9vuGW7Kr4dYy2wo=
X-Google-Smtp-Source: AGHT+IHS2N4DM93OxlN4GCTiko29IiTesLd3W6cV51JphfgkdKeiGc8BCj/MKUEwKpW7mkvvyUK9wA==
X-Received: by 2002:a5d:514c:0:b0:374:bdd7:f848 with SMTP id ffacd0b85a97d-376df0055acmr2155949f8f.59.1725434971515;
        Wed, 04 Sep 2024 00:29:31 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba639671dsm232317455e9.5.2024.09.04.00.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 00:29:31 -0700 (PDT)
Date: Wed, 4 Sep 2024 10:29:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jgg@nvidia.com,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v14 08/10] iommu/arm-smmu-v3: Add in-kernel support for
 NVIDIA Tegra241 (Grace) CMDQV
Message-ID: <38b6ed33-886f-4ec7-9196-1728f1d8c1b3@stanley.mountain>
References: <cover.1724970714.git.nicolinc@nvidia.com>
 <dce50490b2c10b7254fb36aa73ed7ffd812b283a.1724970714.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dce50490b2c10b7254fb36aa73ed7ffd812b283a.1724970714.git.nicolinc@nvidia.com>

I was reviewing Smatch warnings:

    drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c:616 tegra241_cmdqv_init_vintf()
    error: Calling ida_alloc_max() with a 'max' argument which is a power of 2. -1 missing?

The problem is that we're calling ida_alloc_max() where max is always zero.

> +static int tegra241_cmdqv_init_vintf(struct tegra241_cmdqv *cmdqv, u16 max_idx,
> +				     struct tegra241_vintf *vintf)
> +{
> +
> +	u16 idx;
> +	int ret;
> +
> +	ret = ida_alloc_max(&cmdqv->vintf_ids, max_idx, GFP_KERNEL);
> +	if (ret < 0)
> +		return ret;
> +	idx = ret;

max_idx is always zero so idx is always zero.

> +
> +	vintf->idx = idx;
> +	vintf->cmdqv = cmdqv;
> +	vintf->base = cmdqv->base + TEGRA241_VINTF(idx);
> +
> +	vintf->lvcmdqs = kcalloc(cmdqv->num_lvcmdqs_per_vintf,
> +				 sizeof(*vintf->lvcmdqs), GFP_KERNEL);
> +	if (!vintf->lvcmdqs) {
> +		ida_free(&cmdqv->vintf_ids, idx);
> +		return -ENOMEM;
> +	}
> +
> +	cmdqv->vintfs[idx] = vintf;

We only use the first element of this array.

> +	return ret;
> +}

We could get rid of the ida_ stuff and change the cmdqv->vintfs[] array to a
pointer.  It would simplify the code.

regards,
dan carpenter

