Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375E412B176
	for <iommu@lists.linux.dev>; Tue, 30 Apr 2024 10:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714473157; cv=none; b=UGkz0mRW8Ge/XM3gKa8gC4dVV1IZH60QEZcVdqn6TndKpYHKE/bRN9LWE9OcrvwBvzqTRNCn5VFQd7+fW2Xah7oJ3NHk0ChHMj2xM8YCuN9t2fE1NeEQQRJoWdVFV8FZWPD7jOqSj3jOD6PGCqpygpMqteBIaaPWODfWK8zr3Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714473157; c=relaxed/simple;
	bh=oJyE2cCy2Ugf+MARYBl41yzLpScuwUWGty3Veedj6dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BCLVIF6gVvIFgj10BnZyhmZWf961FJQpErgj1umIJagiqGe+b1GxFQO072IUJVYc0JiMTHFV+CbC1E8RZB0dIBF1ZJwbCWQR9FsT7r5aAF4BcosTJPFZJrBwaJmJgap7/WbKr1ZfO9qcufmdlyq2sh7dtqqoyHygzAtlQSfetMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B9UQtOe9; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B9UQtOe9"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-61816fc256dso55478417b3.0
        for <iommu@lists.linux.dev>; Tue, 30 Apr 2024 03:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714473155; x=1715077955; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f1cH0tbXUx1Qz6fZrqdeyqXu4BSangVVEOn/F3cJJkc=;
        b=B9UQtOe9LEDEbkxDwPebliUO3yVTSSjW6YpEtzbvT/RyQ30eS9jR5q08CKRLTN+w4e
         o4l1YfPGSa+IDx9RIiFV+v5wuTkEkPa2G4sXU/tcVAtkFWVUD1cXXnfLR0Y+y4pO7DyE
         eGSrG+7NZncOEbkeS6CvzBcl2KON2I2tZxmgaaE0JUgu5ggbjVUcSTe3uZJIj0Fg+gm4
         MRFj2NwBqO20xvtouZsq14PUnoAatQpP0rnZlATDXxnPrtRGel9COcXSu3RWtPhXPDst
         yM4u6jnbNrH47U9qaSWq0qg/idN5lj7oj3epIUXuJcv8mfeEk39WstqLVjQTZAG5drdS
         sQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714473155; x=1715077955;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f1cH0tbXUx1Qz6fZrqdeyqXu4BSangVVEOn/F3cJJkc=;
        b=V+5cBAY/cXXnPY3QdPkA4YC51qJuT2zODyVOq4eFlDZS0OuUlb7i0xt/0MyaQ95Wqa
         sFLxqq5eK1gBiQv8xsWntLqCq4apCtWPTZZd8pno3x3sf1rhlpM/Z6x2YiJtER3L6YNJ
         VShMYUfW60HBqItea4EwliOxx3/0EFgwxQvj0Nw4Po3B4cj7XRhVRknXjPvhJr5Q4DBd
         MfCnm5U0rk85wEwcZ7wfsr78FaVvPPYn6JxQmrQS5uaFnTNLRE7wTI9+UBk9uxMJztt3
         tVMgYkLUINFdATcVZHhQ16Pb7NSzO7PWQTi8INNWDsxM1Ds0r8xUahhtA1ftfDrnPb4H
         WfUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVu+IJ+qiGf3qFOHJG8Shxc4ETetVcZrgxTSTH93a4EE3ppMXITwGP7oMDHCgkAnHopxbePfn/N8ePKkD8BjZX2ultpZOM=
X-Gm-Message-State: AOJu0YyqZOuv+NtQy6pmHC86VhAgjBl7QK/TJ9U354LOpeUROXKdqR0x
	WCO6vK/mnFqshs0sE5zNbBYwRfDH1O1KWaDeETov0qObuZdWCFzmj6od92Qy5pBnpMtP9sC7ZyA
	swbIA+uYz/HGf5mADZvTEwoQNIQUVT+1ltxMSAg==
X-Google-Smtp-Source: AGHT+IGubxNeRVkEzJXtQlLUkz5yI+iLk1dQ7JPJSXDLCtG2VVJK5AG1D5Gh/7jGoDbNaqoz7y+O2FmfDWvuSBrZjv8=
X-Received: by 2002:a25:b298:0:b0:dcd:aa73:e349 with SMTP id
 k24-20020a25b298000000b00dcdaa73e349mr2094537ybj.12.1714473154883; Tue, 30
 Apr 2024 03:32:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <d4cc20cbb0c45175e98dd76bf187e2ad6421296d.1714472573.git.robin.murphy@arm.com>
In-Reply-To: <d4cc20cbb0c45175e98dd76bf187e2ad6421296d.1714472573.git.robin.murphy@arm.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 30 Apr 2024 13:32:24 +0300
Message-ID: <CAA8EJprv9At9t-C+EzUt60F1_ke30F78zpGr=vLFBB9Mk1zv+w@mail.gmail.com>
Subject: Re: [PATCH] arm64: Properly clean up iommu-dma remnants
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, catalin.marinas@arm.com, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Apr 2024 at 13:23, Robin Murphy <robin.murphy@arm.com> wrote:
>
> Thanks to the somewhat asymmetrical nature, while removing
> iommu_setup_dma_ops() from the arch_setup_dma_ops() flow, I managed to
> forget that arm64's teardown path was also specific to iommu-dma. Clean
> that up to match, otherwise probe deferral will lead to the arch code
> erroneously removing DMA ops set elsewhere.
>
> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Link: https://lore.kernel.org/linux-iommu/Zi_LV28TR-P-PzXi@eriador.lumag.spb.ru/
> Fixes: b67483b3c44e ("iommu/dma: Centralise iommu_setup_dma_ops()")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  arch/arm64/Kconfig          | 1 -
>  arch/arm64/mm/dma-mapping.c | 8 --------
>  2 files changed, 9 deletions(-)


Thanks!

Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
