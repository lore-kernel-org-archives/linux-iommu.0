Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC86ACCA47C
	for <iommu@archiver.kernel.org>; Thu, 23 Jun 2022 12:25:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 478F660AEF;
	Thu, 23 Jun 2022 12:25:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 478F660AEF
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=HRnHuDpU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rLuK1bJtP3Lk; Thu, 23 Jun 2022 12:25:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0DC3A613E9;
	Thu, 23 Jun 2022 12:25:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0DC3A613E9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1D37C0032;
	Thu, 23 Jun 2022 12:25:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84471C002D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 12:25:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5048C424D9
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 12:25:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5048C424D9
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=HRnHuDpU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5R99NvS_CI-2 for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 12:25:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1C222424D3
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1C222424D3
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 12:25:24 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id z11so22115856edp.9
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 05:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MZX8fvspGt+LtHf7gEGCk2W/SOrNo7rRR2lPEfFjYT4=;
 b=HRnHuDpUPpi75BV/4x+QAr71ZWTc6YBUanqHvk/hlPqG2B9hZ9GUCCllUSuTSSBWLP
 N1FbAzmsqFiL5HBeegRUHvT9uqty7wQvH5L1sZo8+Z6sbfIQ4dq7LEmTjtfq4RaRlwJi
 gtAlzb1rJoO4aqn4U7fqzo2L2hJFuXSi7NCSJEShYM5KDV3UmTr63pDwO/61AerH2eUx
 Yxm05O8xxZI3hixgEIS0QKQfqQ/Lw5i9zTXrMR3tG+MzYDZxCaikrLVkG/xCV17X/4Mt
 5E/k7V4zoAzWTKSdflKbL8whe4vnygRDptVx1LemRmonwavjA1MIDssjVZuNwf5PdZya
 ezdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MZX8fvspGt+LtHf7gEGCk2W/SOrNo7rRR2lPEfFjYT4=;
 b=liOcDvqOYT4O2hIHKFvFSpuz0VIQAVNBWa63nuuip2x4Gj/0+7dUnBvfwSJGGNqKlS
 C8O2D95NkokbyNOHFCvP5J8S421LMJe/3nQeHl4fSKA59Stb7SkNn/HnVUjOndQMQ7g+
 Ql/aEPljjC50d1su7qtjSFI8gofgTbR3/+prwUxIMcnqy9lZy+fxFJGbNYBJ/mxRIMVe
 z8vc7CfK1WA+N+abmqiGEFhdsPivvvAA7ico0x8zJWXVVPixwEu1Inje+sww9cChZNtH
 KExiuj0QVyXz0Kuqhwol7fFrTeHEuFynqmvCHaNigWayk2DwIlj4K75LgDRj6IpUUAX9
 Llbw==
X-Gm-Message-State: AJIora/7E9Ge3vHxOPXTsHn11qn7BmOhNJcHuHqHHgsNvzJ3u/u5Iktk
 2gxQnCJrCOEsDuloXeFpB2//N1cNLLPHTQTiiLfv2g==
X-Google-Smtp-Source: AGRyM1ueoNAn/6UpZzXtWy0ZUh7onypqkpiS+P5CnmQom0So4UY6jwS0/RR6+03SjNQnbCnUydc3U6IYa25HrO1rd9I=
X-Received: by 2002:a05:6402:5192:b0:435:b3c3:af89 with SMTP id
 q18-20020a056402519200b00435b3c3af89mr8878880edd.390.1655987122261; Thu, 23
 Jun 2022 05:25:22 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20220623093641eucas1p11732bf2c875960f7a2bb1d6fe053bc81@eucas1p1.samsung.com>
 <20220623093629.32178-1-m.szyprowski@samsung.com>
In-Reply-To: <20220623093629.32178-1-m.szyprowski@samsung.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 23 Jun 2022 15:25:11 +0300
Message-ID: <CAPLW+4=RRsgizoV4yS2qGvUbiU011W-9J=OTQP6Xm4hMjYgVvQ@mail.gmail.com>
Subject: Re: [PATCH] iommu/exynos: Make driver independent of the system page
 size
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Marek,

On Thu, 23 Jun 2022 at 12:36, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> PAGE_{SIZE,SHIFT} macros depend on the configured kernel's page size, but
> the driver expects values calculated as for 4KB pages. Fix this.
>
> Reported-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

with one note: SPAGE_SIZE and SPAGE_ORDER could be used instead of
SZ_4K. But that's just a matter of taste, I'm ok with that as is,
hence R-b tag.

Thanks!

> Untested, because Exynos based boards I have doesn't boot with non-4KB
> page size for other reasons.
> ---
>  drivers/iommu/exynos-iommu.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 71f2018e23fe..9c060505a46e 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -340,8 +340,7 @@ static void __sysmmu_set_ptbase(struct sysmmu_drvdata *data, phys_addr_t pgd)
>         if (MMU_MAJ_VER(data->version) < 5)
>                 writel(pgd, data->sfrbase + REG_PT_BASE_ADDR);
>         else
> -               writel(pgd >> PAGE_SHIFT,
> -                            data->sfrbase + REG_V5_PT_BASE_PFN);
> +               writel(pgd / SZ_4K, data->sfrbase + REG_V5_PT_BASE_PFN);
>
>         __sysmmu_tlb_invalidate(data);
>  }
> @@ -551,7 +550,7 @@ static void sysmmu_tlb_invalidate_entry(struct sysmmu_drvdata *data,
>                  * 64KB page can be one of 16 consecutive sets.
>                  */
>                 if (MMU_MAJ_VER(data->version) == 2)
> -                       num_inv = min_t(unsigned int, size / PAGE_SIZE, 64);
> +                       num_inv = min_t(unsigned int, size / SZ_4K, 64);
>
>                 if (sysmmu_block(data)) {
>                         __sysmmu_tlb_invalidate_entry(data, iova, num_inv);
> --
> 2.17.1
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
