Return-Path: <SRS0=4RPJ=Z7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307A8C43603
	for <iommu@archiver.kernel.org>; Mon,  9 Dec 2019 20:18:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E403E205C9
	for <iommu@archiver.kernel.org>; Mon,  9 Dec 2019 20:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMQVSBiO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E403E205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id CB29E2044A;
	Mon,  9 Dec 2019 20:18:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zBcgXeVKu89Q; Mon,  9 Dec 2019 20:18:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6B8532155D;
	Mon,  9 Dec 2019 20:18:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52EB0C1796;
	Mon,  9 Dec 2019 20:18:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8CF96C0881
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 20:18:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7A443868A8
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 20:18:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C-GCrlO-QNTw for <iommu@lists.linux-foundation.org>;
 Mon,  9 Dec 2019 20:18:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
 [209.85.208.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E1C1F8671B
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 20:18:05 +0000 (UTC)
Received: by mail-ed1-f68.google.com with SMTP id c26so13853579eds.8
 for <iommu@lists.linux-foundation.org>; Mon, 09 Dec 2019 12:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=h2yqKOxOZBGE0XueAD5uhzXamZSICOv0vTonYy2m++Q=;
 b=SMQVSBiO2u7Fb5SpKffbCQvDZoPGHmi8wphxbwhMj4d0exd0owRkFxjpbTAwhxstzL
 PcIqghdn1ODiO38nNuxtULQ7kFYYBtlB4UTyHkeimMxte1v13RifPXHF6Vz93hb0dFTw
 ACxTBwDk8OuONNYiGCvtzif1RaZYg6S7no/8ZJr5Rtc1NyHshQ5O/L2XC5w4rsN5cuOy
 UmKUxOyzzh5Jwd2hdRRUhb01wcNmbvrXenst78KwnqSGgdt5W+GEltl7u0owv/ScCOCc
 B4cTZ0FbsZYQyOxRmVL59rrJqlBH7ff3R9ppLQRI0qy+wMia4LChmaIREb9OZJijeQKk
 TtTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=h2yqKOxOZBGE0XueAD5uhzXamZSICOv0vTonYy2m++Q=;
 b=C36uxhFVRjO5BdjYElvmf7Y7jE5/DdNDknG+pZORecEVP+KEW/DEmC+JvU6o8/m8eI
 tU8X2Ya6XV8fs/hs3UXC5jaIk2mojHY3J01URO7WKou5n2kYg/8vNG5JAAKdtta8rOB8
 6iAWhjy4a75UPbFzi6k7QTldOTeiTfVnTTRIZ+ATGyReKoBLUhJIVtQnG66KCxUvgqXi
 wWjIk3cAl1mLMgvvxYFeIEPxEEKSXKuCCPlbBQZxQThGbrXNGupycPMow55smWopWt1H
 xlVhkPcqBu+WrcWKCBq/P0UZz3H3Qz2MwLRiBIq88abbYf0fv7DxuEqo65mRgyR+ufla
 jkcA==
X-Gm-Message-State: APjAAAW4hWrRS2ae7L+0sjeHRUAVkhI/dpKjEQY9FcSkXFahA17Of0af
 ohUgFxu6y8py/VE9Y+TyxwvXpvXlvVwnq7I6ba4=
X-Google-Smtp-Source: APXvYqxJoAfWGwg6T+oY0GTnfrw6XGw523tgFtibpXV6QP979ZIcnXwmJaPC+BaZ7VZ5Fotc0CennR+6m2o6cXTwAmY=
X-Received: by 2002:a17:906:34d7:: with SMTP id
 h23mr33858892ejb.90.1575922684081; 
 Mon, 09 Dec 2019 12:18:04 -0800 (PST)
MIME-Version: 1.0
References: <1574465484-7115-1-git-send-email-jcrouse@codeaurora.org>
 <0101016e95754ea7-d6414f4c-9e25-4bc4-a852-7116a783bf63-000000@us-west-2.amazonses.com>
In-Reply-To: <0101016e95754ea7-d6414f4c-9e25-4bc4-a852-7116a783bf63-000000@us-west-2.amazonses.com>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 9 Dec 2019 12:17:53 -0800
Message-ID: <CAF6AEGuchn7fa+8j45sCH7Sd2_dz5WokeeinR8RYr8xvY4Uq+g@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] drm/msm/a6xx: Support split pagetables
To: Jordan Crouse <jcrouse@codeaurora.org>
Cc: freedreno <freedreno@lists.freedesktop.org>,
 David Airlie <airlied@linux.ie>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Mamta Shukla <mamtashukla555@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>, Sean Paul <sean@poorly.run>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
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

On Fri, Nov 22, 2019 at 3:32 PM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> Attempt to enable split pagetables if the arm-smmu driver supports it.
> This will move the default address space from the default region to
> the address range assigned to TTBR1. The behavior should be transparent
> to the driver for now but it gets the default buffers out of the way
> when we want to start swapping TTBR0 for context-specific pagetables.
>
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
>
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 46 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 45 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 5dc0b2c..96b3b28 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -811,6 +811,50 @@ static unsigned long a6xx_gpu_busy(struct msm_gpu *gpu)
>         return (unsigned long)busy_time;
>  }
>
> +static struct msm_gem_address_space *
> +a6xx_create_address_space(struct msm_gpu *gpu, struct platform_device *pdev)
> +{
> +       struct iommu_domain *iommu = iommu_domain_alloc(&platform_bus_type);
> +       struct msm_gem_address_space *aspace;
> +       struct msm_mmu *mmu;
> +       u64 start, size;
> +       u32 val = 1;
> +       int ret;
> +
> +       if (!iommu)
> +               return ERR_PTR(-ENOMEM);
> +
> +       /* Try to request split pagetables */
> +       iommu_domain_set_attr(iommu, DOMAIN_ATTR_SPLIT_TABLES, &val);
> +
> +       mmu = msm_iommu_new(&pdev->dev, iommu);
> +       if (IS_ERR(mmu)) {
> +               iommu_domain_free(iommu);
> +               return ERR_CAST(mmu);
> +       }
> +
> +       /* Check to see if split pagetables were successful */
> +       ret = iommu_domain_get_attr(iommu, DOMAIN_ATTR_SPLIT_TABLES, &val);

I assume the split between this and iommu_domain_set_attr() is because
attach needs to happen in between?  At any rate, if it needs to be
like this, maybe a comment is in order.  As it is it looks like
something future-self would "cleanup"..

BR,
-R

> +       if (!ret && val) {
> +               /*
> +                * The aperture start will be at the beginning of the TTBR1
> +                * space so use that as a base
> +                */
> +               start = iommu->geometry.aperture_start;
> +               size = 0xffffffff;
> +       } else {
> +               /* Otherwise use the legacy 32 bit region */
> +               start = SZ_16M;
> +               size = 0xffffffff - SZ_16M;
> +       }
> +
> +       aspace = msm_gem_address_space_create(mmu, "gpu", start, size);
> +       if (IS_ERR(aspace))
> +               iommu_domain_free(iommu);
> +
> +       return aspace;
> +}
> +
>  static const struct adreno_gpu_funcs funcs = {
>         .base = {
>                 .get_param = adreno_get_param,
> @@ -832,7 +876,7 @@ static const struct adreno_gpu_funcs funcs = {
>  #if defined(CONFIG_DRM_MSM_GPU_STATE)
>                 .gpu_state_get = a6xx_gpu_state_get,
>                 .gpu_state_put = a6xx_gpu_state_put,
> -               .create_address_space = adreno_iommu_create_address_space,
> +               .create_address_space = a6xx_create_address_space,
>  #endif
>         },
>         .get_timestamp = a6xx_get_timestamp,
> --
> 2.7.4
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
