Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175C12F3F
	for <iommu@lists.linux.dev>; Fri, 11 Nov 2022 12:48:30 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id 130so4810460pfu.8
        for <iommu@lists.linux.dev>; Fri, 11 Nov 2022 04:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4PpE7Q5f5bvtpLJ/b9REabVXXBhrphdzGDXXrX+228E=;
        b=lnqya06q8SxpiNiyTObscWjOCgipaybNtUHPgkBfY6/cxGij/KkV8NjH1LVDpZnQdF
         Ooya33qPMF0QGqSWvIL+NH+aXm6V1sVWmmDQIQTl4AJiUAO9b/0puj40k6lqH+T2FRIC
         kfIoX81VLr0ofEKTlMHER5t1jIvIN1uWze53b1xLlIqGSrmkwBHk5f4hzzVO3i1mESPq
         5bzm8wrv1HjK9M9EdDOxtBns5wpuxGYYuucxCVlvJxYTBEDxgImUHlZsavzOQdk3qwRJ
         dKCYZzyLyKH1SdUC6cE3aE/PjU1bCTIfTLiJSdCQi03MrH85cvU4cIzyOkXabtagPEWg
         93BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4PpE7Q5f5bvtpLJ/b9REabVXXBhrphdzGDXXrX+228E=;
        b=kaKdKT2mygjcpo+3UH4moyXvmDsNyhmI6G+NtuAfJgKZwHlKZ34YyTcwQOmLTQUlJy
         mVAiuU5ezt6nJmqd3ZIWitVV4+EBSHHgqGSxMy4buJESRpYbInq4spxEKezHteJkE+qO
         H5Xfp/HvUeAkSxTEA6Ntf3ZH8iVu0Ctl435u9TOdMNH0vMlHp7IZh5ONMnXXIa/1vZ8I
         MpSZEpqD5u8EdjwbM+Nlmo2jfvhzU3XJXsPRGJ3sfaztu1lpncE1NK6duD24eKaoKzm5
         7Q3zCqmvUjGVO2DA37O5LcQ+TMcbSLv63EJfkJVrpTThvvbr6ZNEhQpkdxUNRXl1rQNJ
         lHFw==
X-Gm-Message-State: ANoB5plip2+t1yDwY08HAoD6+gEFQpOrF1ise2mM7IhaNbtQiNxRuPuX
	d8lcKDWGgL/Zi6lqQDpq55vjMzRkmKRK6qyAu5IHRg==
X-Google-Smtp-Source: AA0mqf7HRYt0+EuJGsxK9ElnJj+/eHkmT2ZJVA90wah6LD67x1i/m5vKjZkYjDoojKjAk4frpM1L55k/W4KghZALTko=
X-Received: by 2002:a63:4d1c:0:b0:462:e0d0:2582 with SMTP id
 a28-20020a634d1c000000b00462e0d02582mr1552736pgb.48.1668170910453; Fri, 11
 Nov 2022 04:48:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CGME20221110154412eucas1p26182a3d691584b577ddced9a1287df60@eucas1p2.samsung.com>
 <20221110154407.26531-1-m.szyprowski@samsung.com>
In-Reply-To: <20221110154407.26531-1-m.szyprowski@samsung.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 11 Nov 2022 13:48:18 +0100
Message-ID: <CAPLW+4=T5h+gs-1Sw=XpXL_NtCRQUtU_97mu4ThaKaaMecZ8Dg@mail.gmail.com>
Subject: Re: [PATCH v2] iommu/exynos: Fix driver initialization sequence
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux.dev, linux-samsung-soc@vger.kernel.org, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 10 Nov 2022 at 16:44, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> Registering a SYSMMU platform driver might directly trigger initializing
> IOMMU domains and performing the initial mappings. Also the IOMMU core
> might use the IOMMU hardware once it has been registered with
> iommu_device_register() function. Ensure that all driver resources are
> allocated and initialized before the driver advertise its presence to the
> platform bus and the IOMMU subsystem.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/iommu/exynos-iommu.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 45fd4850bacb..b0cde2211987 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -708,10 +708,6 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
>         if (ret)
>                 return ret;
>
> -       ret = iommu_device_register(&data->iommu, &exynos_iommu_ops, dev);
> -       if (ret)
> -               goto err_iommu_register;
> -
>         platform_set_drvdata(pdev, data);
>
>         if (PG_ENT_SHIFT < 0) {
> @@ -743,11 +739,13 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
>
>         pm_runtime_enable(dev);
>
> +       ret = iommu_device_register(&data->iommu, &exynos_iommu_ops, dev);
> +       if (ret)
> +               goto err_dma_set_mask;
> +
>         return 0;
>
>  err_dma_set_mask:
> -       iommu_device_unregister(&data->iommu);
> -err_iommu_register:
>         iommu_device_sysfs_remove(&data->iommu);
>         return ret;
>  }
> @@ -1432,12 +1430,6 @@ static int __init exynos_iommu_init(void)
>                 return -ENOMEM;
>         }
>
> -       ret = platform_driver_register(&exynos_sysmmu_driver);
> -       if (ret) {
> -               pr_err("%s: Failed to register driver\n", __func__);
> -               goto err_reg_driver;
> -       }
> -
>         zero_lv2_table = kmem_cache_zalloc(lv2table_kmem_cache, GFP_KERNEL);
>         if (zero_lv2_table == NULL) {
>                 pr_err("%s: Failed to allocate zero level2 page table\n",
> @@ -1446,10 +1438,16 @@ static int __init exynos_iommu_init(void)
>                 goto err_zero_lv2;
>         }
>
> +       ret = platform_driver_register(&exynos_sysmmu_driver);
> +       if (ret) {
> +               pr_err("%s: Failed to register driver\n", __func__);
> +               goto err_reg_driver;
> +       }
> +
>         return 0;
> -err_zero_lv2:
> -       platform_driver_unregister(&exynos_sysmmu_driver);
>  err_reg_driver:
> +       platform_driver_unregister(&exynos_sysmmu_driver);
> +err_zero_lv2:
>         kmem_cache_destroy(lv2table_kmem_cache);
>         return ret;
>  }
> --
> 2.17.1
>
