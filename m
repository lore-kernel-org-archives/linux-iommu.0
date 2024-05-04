Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53841097B
	for <iommu@lists.linux.dev>; Sat,  4 May 2024 14:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714832487; cv=none; b=rxvOIdGovtlqpQbt/6M9nRzQnKa+RmbItxFdYh4nmGNATK+xB/PZFbNiPZIsOtJ7tuMp4blDJdxOvR7jOajMxmnJ+drcHIqVimqaYmMIpcGG6bZ8fmmlc+WsIWUJzzAtu8YvQNdxFMSX5kuuN5A7mkbQLu2Jl2LsmUhBgkmfHwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714832487; c=relaxed/simple;
	bh=tZu4VAW+NmqBXU5r4goND28T7QWYa9IZfkx6cN9W5dE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vnglkts0PyD4xRgwtEsDmFH5Ufok+I5Yxo6U4EjXUHNw5YpuGtK0ph1Bbr7FybobPMoyh1AAhox3lH499Un16Salx+LXoOExBHodVlFF1mgVkXIixfsTLeKA4Mf2sM5YYW1G9WPduDDm0ZcceXS1h1jxYGFGVz5dd1V0VXohbyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qpP+AUvH; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qpP+AUvH"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-61b2218ab6fso3320717b3.1
        for <iommu@lists.linux.dev>; Sat, 04 May 2024 07:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714832484; x=1715437284; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+DBwwe+wkuA82m8rFDFGoJDAYtRKQ5906Wlgt6oZaBY=;
        b=qpP+AUvH5XakqyEIqRAOZX6oBLEbatEcb4KGEBP9KflVMGDF++aoyqTzFAa6sp1uhS
         XaMP7uoVYbO9FKpVx64428q6Ksl9Z0td2Zt8KtuGn0aiySYMGll8PDUpQpy/Yf4q27dM
         LtsFrb+2KRpRAIcmCxt1tMQMVpWn0lYmnfLZApA7dLRKOiLnsnvJkXXYRc2CO/us1q9r
         qUZ+EcLffC80uEXSioP3iF1K/AQGNhzCMY9A7eFL9z3AjT3EEua4HSN5W26sxXqRbElD
         tBK8NgOuwnX9uYYZ3Q7u5CIw32dfTzgKHF688uMzAy1GmRpECnQHHnzxzRs83Z8EHR03
         pVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714832484; x=1715437284;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+DBwwe+wkuA82m8rFDFGoJDAYtRKQ5906Wlgt6oZaBY=;
        b=u49YGpVhiYUVoEv5qlgUDZH4nQn488+WVEcjaxmYJmPq2Pasj9FEeS0j4jtEiycvWZ
         vK/oWisGnVrqRoYWTnnd0e1hFK5zcOfQcILlQg1AHKo+hBgv9w5Hwb+fFC06IygKQ9dU
         /nFAmWOcvUAYIaGLKOIEoWNQE0ahIoLtYer5OzJhFQMW/Soj8zFJfgGPEVdJ8FEq8KF+
         rWj2Zy/6U3ib3ImRo+JFhsrSPYd7OxRIJKCpVMcLHxJ9Xf7bl2lrKFkI1h+iYNkh5GvD
         JZKNVJRMvG9BjngOu6VS5Cv+oWlT5e1h0Km4czZoPl05Vqcwx1BvQic6FYTT1LgqaANb
         WucA==
X-Forwarded-Encrypted: i=1; AJvYcCWcMnj3C6XHm9kXHAsqgG+rH58+Q1SU5MmC0IQc3cTd3yO0qjoLayMxvpTNX8rVkbAYgY4MbfPtorfrvlSkoHZphjim3AU=
X-Gm-Message-State: AOJu0YxKu9urrBs3i1xwsrpXp1fInHCDIvSDH8MxlLD0MNfhWYs3gN2C
	Ur+2SPTWc9hJdYkjk9OmuY7Dds6744580SoMqRdO9oL/HyqK9VPExu7GlOui/8OeemEthQGbQMH
	an0wo1RBNf2sahOxstiD3cqbZT0b6iu+H0v30WA==
X-Google-Smtp-Source: AGHT+IGipg9+a+iXpJEkj7L1mkHMjRUAjAegfTWpPckFuHuUyiARO8KmICQzHZAXcI6OSuYcv0DQce9NznhiDnOgw/4=
X-Received: by 2002:a81:a18f:0:b0:61b:3356:c59f with SMTP id
 y137-20020a81a18f000000b0061b3356c59fmr5546845ywg.35.1714832484671; Sat, 04
 May 2024 07:21:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <d4cc20cbb0c45175e98dd76bf187e2ad6421296d.1714472573.git.robin.murphy@arm.com>
In-Reply-To: <d4cc20cbb0c45175e98dd76bf187e2ad6421296d.1714472573.git.robin.murphy@arm.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 4 May 2024 17:21:12 +0300
Message-ID: <CAA8EJpqcCpiuqeU9Bktev9vSa6Gdw1jTn+VAk+xbu9kKPTrjEg@mail.gmail.com>
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


Just wanted to ping regarding the patch. It's still not a part of
linux-net, Is it going to be picked up for 6.10?

-- 
With best wishes
Dmitry
