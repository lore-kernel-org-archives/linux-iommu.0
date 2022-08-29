Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CBB3D65
	for <iommu@lists.linux.dev>; Mon, 29 Aug 2022 13:37:07 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id p16so12614472ejb.9
        for <iommu@lists.linux.dev>; Mon, 29 Aug 2022 06:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=k+DKFLD2tIanA4ZTaYBtCwu+QQVmzIDfYP98THogbsQ=;
        b=MrV/LDxVHuOzJiNHjMDREAmyKseMQ/X1Jbqdn5j03ZzghdfGS3ek6JxLi5+KfAX7jX
         77ZoaKbYwKlIBbU1FNGaqanw2vE49543wIQZA6Fi62XpGC17YExqVFCfqOR2xIgf/lxs
         0EQLS6UGD3x0wXlzei6yiIODxrEcfPEvSNPlSWkK05HC+k1nViuF6NShWdMbKlxuLN5N
         PQyAxp2yyRHorSI8uBICii/z37nFTehFl1NoHAmTpGIocLRpKBNkzx5EhLlnCABZopul
         LBJr5w9/0mDJ++Sl65xNx2dGoby+mvO70btsEKayO3PpVJHArt84tR/EwK2hy2nP5RUh
         koKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=k+DKFLD2tIanA4ZTaYBtCwu+QQVmzIDfYP98THogbsQ=;
        b=NTBQalzAeH6YqD1qw6/qPtXd39vcNxc5m1T4FySi/xsOvo54yKruNOVViXWN0SficM
         XoL1dbw6W2JZQ58vZxX1bsLjO0zDKtjIyolt6Fa4wigB1OFpZl1mBdinz7qOpVhs5wqH
         7CKlirK3dJ6y13vPIacXQFQXOCtYpqvOwmLlURmUhCymUSTPBoH+MKlTFTJw3LzJe9A8
         u6dSgrFr8j8EfGtwjCqTNPDt/HgIc3taILUIKtgsWygNqipD0P4jU0bCczGMr6kcj2/u
         jtTl4aZnIBVaMrzFEgGONtu9VnpIJVnq0KRANw61GszzumG5ZDBmts65ZuhYgurcGHVY
         z52A==
X-Gm-Message-State: ACgBeo1VBpT8YKFw4xOWp4jgqA9BRLKXqWIyLvyutScf92waaj5sRSYZ
	MWsIU3aRMiu86kvBTHOeBDDgu7WQvYFslVIZjgvPjw==
X-Google-Smtp-Source: AA6agR43tBWNduUYA8jUPnevcGAAIEjAZKMEUdbVbdeN2T09HWwHyBIgepDdGKJF1v62JtVi9SCrtp/FST9QXsAFlqg=
X-Received: by 2002:a17:907:7d91:b0:731:7ecb:1e5b with SMTP id
 oz17-20020a1709077d9100b007317ecb1e5bmr13665749ejc.78.1661780225769; Mon, 29
 Aug 2022 06:37:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <edbd6c95873c51853c4f645ee1ed81a3522a5864.1660657745.git.robin.murphy@arm.com>
In-Reply-To: <edbd6c95873c51853c4f645ee1ed81a3522a5864.1660657745.git.robin.murphy@arm.com>
From: Robert Foss <robert.foss@linaro.org>
Date: Mon, 29 Aug 2022 15:36:54 +0200
Message-ID: <CAG3jFyvO5CD7tqspgM5c=qF3CX=EVN=qcUsRBC6yEfXBYkbiXw@mail.gmail.com>
Subject: Re: [PATCH] media: qcom: Clean up Kconfig dependencies
To: Robin Murphy <robin.murphy@arm.com>
Cc: todor.too@gmail.com, mchehab@kernel.org, stanimir.varbanov@linaro.org, 
	linux-media@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Robin,

On Tue, 16 Aug 2022 at 15:49, Robin Murphy <robin.murphy@arm.com> wrote:
>
> Depending on IOMMU_DMA is suspicious, since the low-level DMA ops
> internals and MSI helpers is provides are not of interest to general
> drivers. In practice it mostly seems to be serving as a dependency on
> ARM64 here, so do that properly. The venus driver looks like it won't
> actually be useful at runtime without the IOMMU API, so add that too.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/media/platform/qcom/camss/Kconfig | 2 +-
>  drivers/media/platform/qcom/venus/Kconfig | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/camss/Kconfig b/drivers/media/platform/qcom/camss/Kconfig
> index 4eda48cb1adf..575f42377c12 100644
> --- a/drivers/media/platform/qcom/camss/Kconfig
> +++ b/drivers/media/platform/qcom/camss/Kconfig
> @@ -2,7 +2,7 @@ config VIDEO_QCOM_CAMSS
>         tristate "Qualcomm V4L2 Camera Subsystem driver"
>         depends on V4L_PLATFORM_DRIVERS
>         depends on VIDEO_DEV
> -       depends on (ARCH_QCOM && IOMMU_DMA) || COMPILE_TEST
> +       depends on (ARCH_QCOM && ARM64) || COMPILE_TEST
>         select MEDIA_CONTROLLER
>         select VIDEO_V4L2_SUBDEV_API
>         select VIDEOBUF2_DMA_SG
> diff --git a/drivers/media/platform/qcom/venus/Kconfig b/drivers/media/platform/qcom/venus/Kconfig
> index bfd50e8f3421..f04b45720bca 100644
> --- a/drivers/media/platform/qcom/venus/Kconfig
> +++ b/drivers/media/platform/qcom/venus/Kconfig
> @@ -2,7 +2,7 @@ config VIDEO_QCOM_VENUS
>         tristate "Qualcomm Venus V4L2 encoder/decoder driver"
>         depends on V4L_MEM2MEM_DRIVERS
>         depends on VIDEO_DEV && QCOM_SMEM
> -       depends on (ARCH_QCOM && IOMMU_DMA) || COMPILE_TEST
> +       depends on (ARCH_QCOM && ARM64 && IOMMU_API) || COMPILE_TEST
>         select QCOM_MDT_LOADER if ARCH_QCOM
>         select QCOM_SCM
>         select VIDEOBUF2_DMA_CONTIG
> --
> 2.36.1.dirty
>

Both parts look good to me and build just fine.

Reviewed-by: Robert Foss <robert.foss@linaro.org>
