Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99744EB0F
	for <iommu@lists.linux.dev>; Thu,  5 Jan 2023 18:06:46 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id 36so25008929pgp.10
        for <iommu@lists.linux.dev>; Thu, 05 Jan 2023 10:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mc/7VUEGk3DXTVO68IbWilfesz8TNRLC/2uUgWIo0Cw=;
        b=knT2sBXM8+bseyvKS+AxxxUDHFN6rXGYXAs0bxnAmUGBXUxEwpfGvuTKnVAOESkp6q
         pAREYRJ15r1aRkMTWXU1RtT0HpDRvvfE15l1Ja39oe3aOa/L1YEN5pZVRVM8RBtpevd5
         oZQzH0PS1SZiIQUm6/NVHO6IqxabFqds1/opr6L5KHjgcJRdRk4CO3HZmORDlhF7OgKg
         aPYsEh0QcEIa1Cen7jvhaanxyZxKEyAYuhcWF3+F5YFLq5vvSXNrFdK2qG6lMffF8MLi
         I9r6Xml9yh/3Y/sXC3hz9n/BxxGC9mnYsZPiLrJDjlVcRdw6FkG9ogIXqvBoO9Ngx5WV
         zyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mc/7VUEGk3DXTVO68IbWilfesz8TNRLC/2uUgWIo0Cw=;
        b=UKkfu74mEKAvv32QEh916gPNC/+0+c3kYleKwsLChMDspuq3qN41kmmEHiNafedlwv
         q3jCJwcfCQXdOrJwspRZmUQMFxlCkFvv5tz4dqOXWYs1GNEh5TKl60LeJJUnKvD0xhGW
         grsyTqcWUua007qr1RNO+V/NNdH8ShVNWa0TI/4P2dAUGMWgl4FnOHYz8BW7b0vFEFKy
         jwt8IipnUefsMEXQXsLtNJRfKGJEM9XblAjoa31xqXRn2p9YaWadYKD53vJOlWPf01ov
         qe+zIvGS/K+JDH5Q1CuuIQf783xw2A9f75MlMQWs0qpxpSYKUxLHDRr9UBCImploscLS
         WgLQ==
X-Gm-Message-State: AFqh2kpS8KkN+9og6qRD2WTtweepQ3B5j2Ai6O0fTNT6FQoTawGUUNuz
	PdM1xU42WlP1mE+1mqM2xZc3wHM7cU+him3MVQd6/A==
X-Google-Smtp-Source: AMrXdXvo69j9YoPEoO2lldH79hHn+c58oW4FRh9Wp+zEyjV9ZZP+lufBeNlYfqep7QRkeVVzM/Ex1QTu1p1SvtAO16g=
X-Received: by 2002:a05:6a00:a1a:b0:580:8b92:ecff with SMTP id
 p26-20020a056a000a1a00b005808b92ecffmr3298706pfh.4.1672942006019; Thu, 05 Jan
 2023 10:06:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230104095702.2591122-1-yangyingliang@huawei.com>
In-Reply-To: <20230104095702.2591122-1-yangyingliang@huawei.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 5 Jan 2023 12:06:34 -0600
Message-ID: <CAPLW+4=eE=YXSSEMRPJ2g_FK68PO2h9By-FGZOtDG4jyFWLq2w@mail.gmail.com>
Subject: Re: [PATCH] iommu/exynos: fix error handling in exynos_iommu_init()
To: Yang Yingliang <yangyingliang@huawei.com>
Cc: iommu@lists.linux.dev, linux-samsung-soc@vger.kernel.org, 
	m.szyprowski@samsung.com, jroedel@suse.de
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Jan 2023 at 03:38, Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> If platform_driver_register() fails, it don't need unregister and call
> kmem_cache_free() to free the memory allocated before calling register.
>
> Fixes: bbc4d205d93f ("iommu/exynos: Fix driver initialization sequence")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/iommu/exynos-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index b0cde2211987..c1d579c24740 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -1446,7 +1446,7 @@ static int __init exynos_iommu_init(void)
>
>         return 0;
>  err_reg_driver:
> -       platform_driver_unregister(&exynos_sysmmu_driver);
> +       kmem_cache_free(lv2table_kmem_cache, zero_lv2_table);
>  err_zero_lv2:
>         kmem_cache_destroy(lv2table_kmem_cache);
>         return ret;
> --
> 2.25.1
>
