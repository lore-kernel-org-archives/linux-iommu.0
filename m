Return-Path: <SRS0=eHMU=2G=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3026FC43603
	for <iommu@archiver.kernel.org>; Mon, 16 Dec 2019 17:44:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE0C720700
	for <iommu@archiver.kernel.org>; Mon, 16 Dec 2019 17:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuMhWcCB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0C720700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id CEA258772F;
	Mon, 16 Dec 2019 17:44:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Axh137SV4bhS; Mon, 16 Dec 2019 17:44:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 29B9C86D2F;
	Mon, 16 Dec 2019 17:44:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5AA9C1AE8;
	Mon, 16 Dec 2019 17:44:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD3D2C077D
 for <iommu@lists.linux-foundation.org>; Mon, 16 Dec 2019 17:44:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B518688262
 for <iommu@lists.linux-foundation.org>; Mon, 16 Dec 2019 17:44:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iFpsr0mRMpi5 for <iommu@lists.linux-foundation.org>;
 Mon, 16 Dec 2019 17:44:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
 [209.85.208.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CA22E881E9
 for <iommu@lists.linux-foundation.org>; Mon, 16 Dec 2019 17:44:07 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id cy15so5753722edb.4
 for <iommu@lists.linux-foundation.org>; Mon, 16 Dec 2019 09:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dotsp4hlrRRgAJ8KtDm+ECaZ4Cv3RzpcnEOHjwNyGY4=;
 b=XuMhWcCBF/5Ytd0QFb2aWT2ZjIhuShrmxVGkMOWEHF4GTXo/JJO3tpKzaYezLulgtb
 ymJn6D9SihsyvAj/EkVlj+aj0p9Ywx+4WTU8EuNhn01x+niEpzjpq4vjuYeRmoNeByn4
 PJZ0QlMrGdlv1Ma6updVH0Q6orL1dTU2clAJaH8wkau3kwvAj6eTD5Tpe4oSrym6hJ9Q
 7eNQp6O33KdXkmOj224psFuq5lGg+mHv/9oIs69Uqb+zT1cnAuC1Iuw/itukC1gfD577
 fUSzQTCBMpZ6lVtgzcUx0NJlloH5c2qOEvZWhWWlxw7dbGyvfsGEpCpyfTXO1vkLURHr
 uZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dotsp4hlrRRgAJ8KtDm+ECaZ4Cv3RzpcnEOHjwNyGY4=;
 b=qii1gsj6/hlCloN+j9bXijOFmpz/38VWP53XAtmCTlbP8mumohcwiQdssYGTpGyzjs
 i9apPAjE436iHCD1w/+LDzJL1n+dUXSsKLWV7Kg7xn16Nn7GbP9DQ7l1RcnatRvLPBAC
 ao1tJrHjNnXvb6/nLwcy5vscSaKYFyr12vNM4SyqpyWAUJimd0DFVR+XaN/bRLMjrDv/
 vL+zpvGriivvfKPkog4HykqeKjz6p/NUEyfSwg9u4pvW+ZQsvQyhHb9kHhfgQZ2+eKwZ
 9NbtJPAWJtzwmAWTIYKI1TxuZ0fCTxts+B7xkbIh+dsDEYC4ChYEapQSsda7K/qe2+Pn
 Hh9Q==
X-Gm-Message-State: APjAAAVATJOLrppMnL/lFQkNNcvPwSd8oT6Mch2BAccsCJPMVEdu6Hqj
 jTOZes7zXfeQsTNNckE4fgWLakeWVlvomLixWx4=
X-Google-Smtp-Source: APXvYqzMZmKG4O0FupZLieU7MkUuk6V2ElDf+PeLMM9q5q0SW8+Pb9iyDBHD9J+QeQV1ICnDIpyJSoUw51ELTZ5J+Xk=
X-Received: by 2002:aa7:d6d1:: with SMTP id x17mr365496edr.57.1576518246192;
 Mon, 16 Dec 2019 09:44:06 -0800 (PST)
MIME-Version: 1.0
References: <1576514271-15687-1-git-send-email-jcrouse@codeaurora.org>
 <1576514271-15687-6-git-send-email-jcrouse@codeaurora.org>
In-Reply-To: <1576514271-15687-6-git-send-email-jcrouse@codeaurora.org>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 16 Dec 2019 09:43:55 -0800
Message-ID: <CAF6AEGsWAjgcsqMQEtCfUn9smqfVyOcf-Nn1+eJGrMuLkjgwRA@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] drm/msm/a6xx: Support split pagetables
To: Jordan Crouse <jcrouse@codeaurora.org>
Cc: freedreno <freedreno@lists.freedesktop.org>,
 David Airlie <airlied@linux.ie>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Sean Paul <sean@poorly.run>,
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

On Mon, Dec 16, 2019 at 8:38 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> Attempt to enable split pagetables if the arm-smmu driver supports it.
> This will move the default address space from the default region to
> the address range assigned to TTBR1. The behavior should be transparent
> to the driver for now but it gets the default buffers out of the way
> when we want to start swapping TTBR0 for context-specific pagetables.
>
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>

Reviewed-by: Rob Clark <robdclark@gmail.com>

(my previous r-b's on the other patches from v2 carries over to v3)

> ---
>
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 52 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 51 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 5dc0b2c..1c6da93 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -811,6 +811,56 @@ static unsigned long a6xx_gpu_busy(struct msm_gpu *gpu)
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
> +       /*
> +        * Try to request split pagetables - the request has to be made before
> +        * the domian is attached
> +        */
> +       iommu_domain_set_attr(iommu, DOMAIN_ATTR_SPLIT_TABLES, &val);
> +
> +       mmu = msm_iommu_new(&pdev->dev, iommu);
> +       if (IS_ERR(mmu)) {
> +               iommu_domain_free(iommu);
> +               return ERR_CAST(mmu);
> +       }
> +
> +       /*
> +        * After the domain is attached, see if the split tables were actually
> +        * successful.
> +        */
> +       ret = iommu_domain_get_attr(iommu, DOMAIN_ATTR_SPLIT_TABLES, &val);
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
> @@ -832,7 +882,7 @@ static const struct adreno_gpu_funcs funcs = {
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
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
