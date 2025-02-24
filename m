Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F9524BC14
	for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 10:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740391218; cv=none; b=UiMCY9VuWwnLOvp6puN69f2KAemh6i30JxZoAlk/dFFBB6qBOolbY02kQWGrBfX8FH5iyOy04/qxOXBYjJSZzpSQMOgCgftK7Nz4qc0xIBg9rjF7xEFBptXK53c0FapawTmQvaSbcETrrpIjcSxsV1bgCYYYZ+4D+EHNgWQz21E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740391218; c=relaxed/simple;
	bh=L1CsTylPKpbe7mHhb0x/X+ZtkC9C5FKlAWnDYpGi04Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CII8MKg7mB3ZKFXk0fmTlvqcA4zwkdhQKY7h1MafIfMkgXerLbIJ3OrM7AVGVMGXJJ7fWd61Y0NifkmHcOLwbCXTzNOSYNUnHzkmzxJOKAC/vI7ZDe51qbh9lAq6sQCSG/gX0pXRUEcbI+8/M8GreMuSz86NqC2Dn3VB5rFpYn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=scqWB5Ol; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="scqWB5Ol"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30a2f240156so41655841fa.3
        for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 02:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740391215; x=1740996015; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e/af6Nf4pYTXjW+k5FHuuUBRQ1ISjrcs1BZad7L7cbM=;
        b=scqWB5OlRSmjND5eLfzVUN/4Yh2++g72fn8mnlIu7H1hTxFiNRit8lgldtnlwL0uuS
         aEcfb8UkJOrBclDG6wfLJ9KFDkjddx1I1rRt4F0LlMaLdeO5UIlSk64BNN4z5z9ZzENB
         CD9m2GVb/nIqUEnOL6lZl+DA/IuVvo4TU/6TBLAzJENXCFvnr8468ELvc4loWPhV8YfH
         81Qt5a1WaS77Yco9XF055ZvqockxHPRVgpNLbByAmg4+jA8EiC9wJx5z57w+slAlCZlN
         Gxz1ZasXcG6l5bjHkI9S6F261nmdppZnsP0oEukJlzcYiAzJeuBpz4ul3xrfPUa7X7WX
         s25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740391215; x=1740996015;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e/af6Nf4pYTXjW+k5FHuuUBRQ1ISjrcs1BZad7L7cbM=;
        b=q23T4FU37bvJLWiOLFS8UcVGO0sCoPRCPTPOCkrZlmHZOmxItuaWYQmoGoIH5bjaK1
         XQkZFYAMXLl2oCVDuB0oB2XRUvUmBM0e30xCrjhBIztk9JSF3wsPV07RHBw2/pDPSCyP
         gkPUb13A3EH8idZaN9CAtK17/S2HUB6cINUFLdETLMMA0rwaQsBcKuD6QlQ413PN7+IT
         3jpL+f3DnpidLaj2Myya+m6O/fqkqc/FvyIv03W29HhUKNHs+ZIG4kgr8Q+U2BlPcnNx
         2fqweg8Iy8RTSGzuz1aypSO8ogy+747CQJFrUQY+3eZKSUkTa/4uhfIIoYYNxIwE8/8K
         +xZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUoPi2YRzS0dwP9SoJf3wGcfwutfZSGN0fl+0r9SH7DEz1QmsUnhh9oVcf90qu3jTIZayDPg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2QFvYGrKA3QzvpNxTKcof+/UoZQ2RMp5ujpC4hrlTCDnZ2zO1
	PiWQ7xdObw/AK+Bwz/taM+4jYPSbiZsrje1fNj50iSpSFFix3bYk89GqHmRIekUDoEX81Hvw0Vx
	4HMBzhF6+nBTg8sJ+vJUD64XRTnQI8IxC+h2Mow==
X-Gm-Gg: ASbGnct+KapIMOqmh6d9QfxypkRffRVrsR3TAaJOlpslhKxUTTaLrORM29kheoImjFy
	E1ThQQmzus4Cl7P3B87jzT5Os46qdmdd+6VtPmW7iKLrLhrqUvRfwhsLNhZHqbsovyk3go0dz1R
	xfpMvKVlY=
X-Google-Smtp-Source: AGHT+IFvhQ2d0kjawpOA6ae+ZD8D05Wtfz/zZq525EqV3G+li0jFar6Ns4sZTBNcqdZ5o6Ta+CQUR8CvSaROXGWj1Ug=
X-Received: by 2002:a2e:9098:0:b0:308:ec25:9004 with SMTP id
 38308e7fff4ca-30a59994167mr42426711fa.35.1740391215090; Mon, 24 Feb 2025
 02:00:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250224051627.2956304-1-baolu.lu@linux.intel.com> <20250224051627.2956304-11-baolu.lu@linux.intel.com>
In-Reply-To: <20250224051627.2956304-11-baolu.lu@linux.intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Mon, 24 Feb 2025 18:00:03 +0800
X-Gm-Features: AWEUYZm_Vmy5gXLhP7OjFIo5QaYCXcBq4-MGlly3CV5_Yb7KKQuhKpAi4xpH3T0
Message-ID: <CABQgh9E2N35pJ5Ehmhq0JydKjWqswypOH9qepu+9QmHmVzdvBw@mail.gmail.com>
Subject: Re: [PATCH v2 10/12] uacce: Remove unnecessary IOMMU_DEV_FEAT_IOPF
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
	Fenghua Yu <fenghuay@nvidia.com>, Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Feb 2025 at 13:16, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> None of the drivers implement anything for IOMMU_DEV_FEAT_IOPF anymore,
> remove it to avoid dead code.
>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Acked-by: Zhangfei Gao <zhangfei.gao@linaro.org>

> ---
>  drivers/misc/uacce/uacce.c | 31 -------------------------------
>  1 file changed, 31 deletions(-)
>
> diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
> index 2a1db2abeeca..42e7d2a2a90c 100644
> --- a/drivers/misc/uacce/uacce.c
> +++ b/drivers/misc/uacce/uacce.c
> @@ -465,31 +465,6 @@ static void uacce_release(struct device *dev)
>         kfree(uacce);
>  }
>
> -static unsigned int uacce_enable_sva(struct device *parent, unsigned int flags)
> -{
> -       int ret;
> -
> -       if (!(flags & UACCE_DEV_SVA))
> -               return flags;
> -
> -       flags &= ~UACCE_DEV_SVA;
> -
> -       ret = iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_IOPF);
> -       if (ret) {
> -               dev_err(parent, "failed to enable IOPF feature! ret = %pe\n", ERR_PTR(ret));
> -               return flags;
> -       }
> -       return flags | UACCE_DEV_SVA;
> -}
> -
> -static void uacce_disable_sva(struct uacce_device *uacce)
> -{
> -       if (!(uacce->flags & UACCE_DEV_SVA))
> -               return;
> -
> -       iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_IOPF);
> -}
> -
>  /**
>   * uacce_alloc() - alloc an accelerator
>   * @parent: pointer of uacce parent device
> @@ -509,8 +484,6 @@ struct uacce_device *uacce_alloc(struct device *parent,
>         if (!uacce)
>                 return ERR_PTR(-ENOMEM);
>
> -       flags = uacce_enable_sva(parent, flags);
> -
>         uacce->parent = parent;
>         uacce->flags = flags;
>         uacce->ops = interface->ops;
> @@ -533,7 +506,6 @@ struct uacce_device *uacce_alloc(struct device *parent,
>         return uacce;
>
>  err_with_uacce:
> -       uacce_disable_sva(uacce);
>         kfree(uacce);
>         return ERR_PTR(ret);
>  }
> @@ -596,9 +568,6 @@ void uacce_remove(struct uacce_device *uacce)
>                 unmap_mapping_range(q->mapping, 0, 0, 1);
>         }
>
> -       /* disable sva now since no opened queues */
> -       uacce_disable_sva(uacce);
> -
>         if (uacce->cdev)
>                 cdev_device_del(uacce->cdev, &uacce->dev);
>         xa_erase(&uacce_xa, uacce->dev_id);
> --
> 2.43.0
>
