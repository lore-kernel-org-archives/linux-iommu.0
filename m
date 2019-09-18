Return-Path: <SRS0=JP6a=XN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA67AC4CEC9
	for <iommu@archiver.kernel.org>; Wed, 18 Sep 2019 15:32:57 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93006218AE
	for <iommu@archiver.kernel.org>; Wed, 18 Sep 2019 15:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hOIAcY9K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93006218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 61413CAD;
	Wed, 18 Sep 2019 15:32:57 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id F15D7AF7
	for <iommu@lists.linux-foundation.org>;
	Wed, 18 Sep 2019 15:32:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f68.google.com (mail-io1-f68.google.com
	[209.85.166.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BFF5883A
	for <iommu@lists.linux-foundation.org>;
	Wed, 18 Sep 2019 15:32:54 +0000 (UTC)
Received: by mail-io1-f68.google.com with SMTP id n197so132281iod.9
	for <iommu@lists.linux-foundation.org>;
	Wed, 18 Sep 2019 08:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=xJ/cS8LcWo36On2CRn3NQ8qNeTLdwfUQ9LdgXSyXFCI=;
	b=hOIAcY9Ksndwp9AC0VindSRz3r66JG/ms4yVbpBtr4zTBwwCAm1t5GAtaDvfp+ULhD
	J0i3UHDoxR9OxWh8GaBew41KFK6N6DB2SONhSJCHKrag8uZnWBTE1466IDR5Zc7HckLN
	46P4yhy7AjIC9487c2WAZqNswJJ5zbiLOocZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=xJ/cS8LcWo36On2CRn3NQ8qNeTLdwfUQ9LdgXSyXFCI=;
	b=dneAe/WRyhW5ihm2t4pvqcZ4BWLd2/MvpA6xH0PSlUG89urO8nezhF7NJ+Q7xoVyVj
	jreHikMHQF3kXkqkEOMEhL65mGrTdg95mnepxeH4OGNlMDTKHRjR3s0OEVr7abyWsMaD
	bl4qM4fo3y0xiJ2hQ0lur7dGl5PchJLzR3iCwpXBhJLwAuL6rzV2cpOAgVckfX6pgFRQ
	Xvu+WrmXaT3+kp/I2rVJii1Ahs976gAi5tRWHdmgMe+B/lFSY+PpMvKRIcJ+oDFq3qnU
	eoYxERMVEX1jTuT6+saCIBNH1pjHWA4VVDw8iFVbcf43WMRNdi0S5iG54JHGe8fyaK83
	9r7Q==
X-Gm-Message-State: APjAAAUjCfSdT6EVrzKpi0JnnyDoA7YrP3KYGbyRCcjv8AE6YR49MZAV
	VNSI6OALbeknHh73is+hv7HYf6OQ8+0=
X-Google-Smtp-Source: APXvYqyr32PWPIYgFOzbJGqK4QTSw22ySGcHeI9aDh9/bP0+dXzYM5HDu4N5cYDEvcgKHILSfTCbmg==
X-Received: by 2002:a6b:148b:: with SMTP id 133mr5609291iou.81.1568820773777; 
	Wed, 18 Sep 2019 08:32:53 -0700 (PDT)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com.
	[209.85.166.45]) by smtp.gmail.com with ESMTPSA id
	z16sm4492998iol.64.2019.09.18.08.32.52
	for <iommu@lists.linux-foundation.org>
	(version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
	Wed, 18 Sep 2019 08:32:52 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id b19so221614iob.4
	for <iommu@lists.linux-foundation.org>;
	Wed, 18 Sep 2019 08:32:52 -0700 (PDT)
X-Received: by 2002:a6b:b704:: with SMTP id h4mr4680779iof.218.1568820772456; 
	Wed, 18 Sep 2019 08:32:52 -0700 (PDT)
MIME-Version: 1.0
References: <4febe7a87a95ed607b4dc68ba96b15210df84e9e.1568731534.git.robin.murphy@arm.com>
In-Reply-To: <4febe7a87a95ed607b4dc68ba96b15210df84e9e.1568731534.git.robin.murphy@arm.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 18 Sep 2019 08:32:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W_kSWyWgGZvEpY3bnwEWdgnEWmkHf1qPSS2aQ9i0suJA@mail.gmail.com>
Message-ID: <CAD=FV=W_kSWyWgGZvEpY3bnwEWdgnEWmkHf1qPSS2aQ9i0suJA@mail.gmail.com>
Subject: Re: [PATCH v2] iommu/arm-smmu: Report USF more clearly
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
	Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi,

On Tue, Sep 17, 2019 at 7:45 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Although CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT is a welcome tool
> for smoking out inadequate firmware, the failure mode is non-obvious
> and can be confusing for end users. Add some special-case reporting of
> Unidentified Stream Faults to help clarify this particular symptom.
> Since we're adding yet another print to the mix, also break out an
> explicit ratelimit state to make sure everything stays together (and
> reduce the static storage footprint a little).
>
> CC: Douglas Anderson <dianders@chromium.org>

nit: Cc, not CC.


> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm-smmu.c | 21 ++++++++++++++++-----
>  drivers/iommu/arm-smmu.h |  2 ++
>  2 files changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index b7cf24402a94..b27020fd6c90 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -36,6 +36,7 @@
>  #include <linux/pci.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/ratelimit.h>
>  #include <linux/slab.h>
>
>  #include <linux/amba/bus.h>
> @@ -485,6 +486,8 @@ static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
>  {
>         u32 gfsr, gfsynr0, gfsynr1, gfsynr2;
>         struct arm_smmu_device *smmu = dev;
> +       static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
> +                                     DEFAULT_RATELIMIT_BURST);
>
>         gfsr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sGFSR);
>         gfsynr0 = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sGFSYNR0);
> @@ -494,11 +497,19 @@ static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
>         if (!gfsr)
>                 return IRQ_NONE;
>
> -       dev_err_ratelimited(smmu->dev,
> -               "Unexpected global fault, this could be serious\n");
> -       dev_err_ratelimited(smmu->dev,
> -               "\tGFSR 0x%08x, GFSYNR0 0x%08x, GFSYNR1 0x%08x, GFSYNR2 0x%08x\n",
> -               gfsr, gfsynr0, gfsynr1, gfsynr2);
> +       if (__ratelimit(&rs)) {
> +               if (IS_ENABLED(CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT) &&
> +                   (gfsr & sGFSR_USF))
> +                       dev_err(smmu->dev,
> +                               "Blocked unknown Stream ID 0x%hx; boot with \"arm-smmu.disable_bypass=0\" to allow, but this may have security implications\n",

optional nit: "%#hx" instead of "0x%hx"

Reviewed-by: Douglas Anderson <dianders@chromium.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
