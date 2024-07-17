Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A66913ACC
	for <iommu@lists.linux.dev>; Wed, 17 Jul 2024 06:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721197230; cv=none; b=eoRyTOs7iqipEq+6nm9KmEyLr1jQlPcKU2Mgrf/sd0kRQAakg6T1EiMVFWCG/NIwjAYSPOIKfyEv64E/k8msQ8egPbBB6q7uSpt1CTKROSHznSfytZxgpTpzEJ4DlCMz9Zv2/zYQeCVIbbGUdn2NV52/7MEjGeEd+/LqTw7yA5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721197230; c=relaxed/simple;
	bh=fuYYqKnWe21P7S90TuWyp9Xh/ju0Zz5vCdGWuHFaPkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D5ECUQVW4FVMceD24UyhhO+Q/KsrCM3CK6oGebkR5sFQ3CvpYPqNXestm88By5qKh3kKzrEWtuJzXfmLmzPnqWpJhrHmhpCGV9wEwMbFSHmor/OLc75TUIOksHaZB54opfMejUSIDhNBjEUvUMg3as//y9kN0TpaSf86VDcxL7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PBqJ+lXS; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBqJ+lXS"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5c9fea3b566so249473eaf.0
        for <iommu@lists.linux.dev>; Tue, 16 Jul 2024 23:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721197228; x=1721802028; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eUk5AKTa+NgE29BVsgda2YODyyZi8Y6LkI23EVs0Pzk=;
        b=PBqJ+lXSxQV7UV5GXIcB8eHPrdWMNulPVGLD7cvsRrMN/GMoQ+Fp4p2asYNGnvY3Wu
         D0DJ4gyWwS5iFdVpcwuUgT7rJXoaXMLomqrVtq3XSAhSjeVB1Ysg/DFxwuTylZvwfhNA
         kWZaPMR6lXGWykj6wd54sH+clSQk4m9F4qgKTS4ZUpvvKaRisoiezi4M09i7fGYW9puw
         2/h04hbWVaMF8RheQCtmfLSyXlk9TAuqz0BjbFAAwqbHCeG5gnHuabsnaydAJJ6WDDCO
         MQiItoBMj44aRZayRw+H75JcR7TRZRUekbFnGP9gNoekLb9G1bEq/w9yAinUJZE4x65M
         1h6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721197228; x=1721802028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eUk5AKTa+NgE29BVsgda2YODyyZi8Y6LkI23EVs0Pzk=;
        b=rt9KGJgnmQjVcIQ9JAmGMiKpQGj/tU+txy9BAYyMk09ruJIki234/uz9t1XgRe01y+
         0V9vovJOlXSLXQcyhYNHlV3K1XMGDSNpf8j/rW8oEMSX632M/+F97dCWRJSEBIvTJIdq
         FXg3CXEG8ivLrkXPGS7HRJTdnWc+TqE2AYzLqoeqCyPMLzheWUtXy2dBIfF5avUqgeeq
         wj2eGVC3fJrsPIWuVSRvesZmlHCIRd0T4XfaNFrZWohGbjRcgtgqgTnfmpHr3V9Kn1T1
         k4PW3+sitEiX2soZwRyaHy/wWqV+iF4BdzzPR+ZEF1CLtvkDA3TkQC6KM/tISgiO4maR
         1x9w==
X-Forwarded-Encrypted: i=1; AJvYcCWbCLiRTmATMxUoEyrgXaLNCmvrmdaTiKUO01/tJKQglkdJIcjqprc5DzRbTVstKCcRb6IeLtDPG+d1CC+5oScRepYa9Ck=
X-Gm-Message-State: AOJu0Yx0UDUYmjh2FvQjeWgh8EjKwBOGNIQsmNLBkUEoB13JPFHjME0K
	2buGJ28ENFkX0JEYJwfLDlIOiahhjl+jo6af4PmZL7RvFILHELxv8RBgks2678KrjnBMkKnKZ4l
	gfKlgTSftOhCloy3sBbBK/etFJTQ=
X-Google-Smtp-Source: AGHT+IG8KWkl0N2UQKmtfWWcWEy/a800FkbA04TPkcjdkKhaQV/8fG76CRxtJXD9yF2rJJ3JdkTlpU7tKyR92wkfWVI=
X-Received: by 2002:a05:6870:d38a:b0:258:3455:4b2f with SMTP id
 586e51a60fabf-260d8b06f9dmr354259fac.17.1721197228357; Tue, 16 Jul 2024
 23:20:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240716125522.3690358-1-artem.chernyshev@red-soft.ru>
In-Reply-To: <20240716125522.3690358-1-artem.chernyshev@red-soft.ru>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Wed, 17 Jul 2024 14:19:51 +0800
Message-ID: <CAAfSe-s-x0igV_Zoz=sCXjBByjR49pxGcAQnkZEFobjOCGuVDA@mail.gmail.com>
Subject: Re: [PATCH] iommu: sprd: Avoid NULL deref in sprd_iommu_hw_en
To: Artem Chernyshev <artem.chernyshev@red-soft.ru>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 20:55, Artem Chernyshev
<artem.chernyshev@red-soft.ru> wrote:
>
> In sprd_iommu_cleanup() before calling function sprd_iommu_hw_en()
> dom->sdev is equal to NULL, which leads to null dereference.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 9afea57384d4 ("iommu/sprd: Release dma buffer to avoid memory leak")
> Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>

Thanks for fixing this.

Reviewed-by: Chunyan Zhang <zhang.lyra@gmail.com>

> ---
>  drivers/iommu/sprd-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
> index ba53571a8239..a2f4ffe6d949 100644
> --- a/drivers/iommu/sprd-iommu.c
> +++ b/drivers/iommu/sprd-iommu.c
> @@ -232,8 +232,8 @@ static void sprd_iommu_cleanup(struct sprd_iommu_domain *dom)
>
>         pgt_size = sprd_iommu_pgt_size(&dom->domain);
>         dma_free_coherent(dom->sdev->dev, pgt_size, dom->pgt_va, dom->pgt_pa);
> -       dom->sdev = NULL;
>         sprd_iommu_hw_en(dom->sdev, false);
> +       dom->sdev = NULL;
>  }
>
>  static void sprd_iommu_domain_free(struct iommu_domain *domain)
> --
> 2.44.0
>
