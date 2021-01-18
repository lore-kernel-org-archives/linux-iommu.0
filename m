Return-Path: <SRS0=rNTl=GV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3491CC433E0
	for <iommu@archiver.kernel.org>; Mon, 18 Jan 2021 21:13:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1CAA229C6
	for <iommu@archiver.kernel.org>; Mon, 18 Jan 2021 21:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1CAA229C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 98004852E9;
	Mon, 18 Jan 2021 21:13:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bta-oDKEB3Rf; Mon, 18 Jan 2021 21:13:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1EA1B851CB;
	Mon, 18 Jan 2021 21:13:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA596C08A1;
	Mon, 18 Jan 2021 21:13:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD43BC013A
 for <iommu@lists.linux-foundation.org>; Mon, 18 Jan 2021 21:13:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 93BE886FBB
 for <iommu@lists.linux-foundation.org>; Mon, 18 Jan 2021 21:13:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sNu60rumpCfE for <iommu@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 21:13:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C775386FB6
 for <iommu@lists.linux-foundation.org>; Mon, 18 Jan 2021 21:13:40 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id c5so17763476wrp.6
 for <iommu@lists.linux-foundation.org>; Mon, 18 Jan 2021 13:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DfnA+OcAFtcFxr40jr50iORRAFqvfHPsv5cZyKe+q38=;
 b=kf4hcAQVI7z5D5nCKKuzsC9xlBGTr6pcXf2bXzpyb9Vg1yxZryQb5rVAczfXwwMB/O
 w0ytaMNItFQpH5QEcHdBCppcQke40xV9cTnVyaHzfHjcHarRkwFiEP5Tg0hCZN3V5m1m
 hbtVC7T0YMhs5T9rBfF2JUVrVYnmCHr0rjxgHghCN7O6NS/5TrsBOkizPTEi1+37Cbrh
 XUuHWX31En/fpzPOC0+UuoE2twEcws7bG8pylBQMEz5ix+tDoxoHFCdXD3QTCEokX9Xi
 1MjI3jMzZ3VLADyM9sMKKPpt46Xl7bnNgjwTwI3GBEQDnNfNX2YYNfeoa6YS3ii/CkPU
 2adQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DfnA+OcAFtcFxr40jr50iORRAFqvfHPsv5cZyKe+q38=;
 b=TB5QmHoRJf7ORZZfcxO3eqtFSLg7rOZav5HsfjAURq5RnDAyP8PXMxHQlxPuJIe7DO
 uWXRxjucW0OETUi8tHdCyaBBCx/JcYC2ZcKRoWbhZmZ0cQwebEDWw8U56uXfDzvAU5vl
 b4YZh3ZfZdIrcfPG6FE+Z32X6CEccL5Rc/fXwyeI4pjCzHEKjnIqUaX07NVQDkNn9ZLM
 EmJTyEPuvJSgaXWUTsyb3WyZESloyJLTMNBiGNqpud/ugy11/Cu+O2YbJ1JebG+A6lEd
 ZLY1slOR475up/RI0a1pX2vFaNlpyt7FzReND3vna3tFwZzq8/urntsnnpDF5rZW+tVf
 nhpQ==
X-Gm-Message-State: AOAM532RphLLbDNqt7yA2t4896cpx7KWPf0NRj1PizfE0ap2TTaAZikr
 2Z9OJEqef0n74PHhjxf7y4gq4ePPNUhrqNfL50c=
X-Google-Smtp-Source: ABdhPJwNOfYdNWJWdIYge61E+UF9gSVsMDMzVfyui5Xghpvq/H1vicFDjuRCKS1ARBjA6DEcTHQinCCBWD3lyiMeF/o=
X-Received: by 2002:a5d:6909:: with SMTP id t9mr1174197wru.327.1611004419225; 
 Mon, 18 Jan 2021 13:13:39 -0800 (PST)
MIME-Version: 1.0
References: <1608597876-32367-1-git-send-email-isaacm@codeaurora.org>
 <1608597876-32367-6-git-send-email-isaacm@codeaurora.org>
In-Reply-To: <1608597876-32367-6-git-send-email-isaacm@codeaurora.org>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 18 Jan 2021 13:16:03 -0800
Message-ID: <CAF6AEGunsv5r_DmNsMbYwa4KQxRmK9J+5Bd12LYG4pQ=hrCe4Q@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] drm/msm: Add dependency on io-pgtable-arm format
 module
To: "Isaac J. Manjarres" <isaacm@codeaurora.org>
Cc: Android Kernel Team <kernel-team@android.com>,
 Will Deacon <will@kernel.org>, pdaly@codeaurora.org,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Pratik Patel <pratikp@codeaurora.org>,
 freedreno <freedreno@lists.freedesktop.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>
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

On Mon, Dec 21, 2020 at 4:44 PM Isaac J. Manjarres
<isaacm@codeaurora.org> wrote:
>
> The MSM DRM driver depends on the availability of the ARM LPAE io-pgtable
> format code to work properly. In preparation for having the io-pgtable
> formats as modules, add a "pre" dependency with MODULE_SOFTDEP() to
> ensure that the io-pgtable-arm format module is loaded before loading
> the MSM DRM driver module.
>
> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>

Thanks, I've queued this up locally

BR,
-R

> ---
>  drivers/gpu/drm/msm/msm_drv.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index 535a026..8be3506 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -1369,3 +1369,4 @@ module_exit(msm_drm_unregister);
>  MODULE_AUTHOR("Rob Clark <robdclark@gmail.com");
>  MODULE_DESCRIPTION("MSM DRM Driver");
>  MODULE_LICENSE("GPL");
> +MODULE_SOFTDEP("pre: io-pgtable-arm");
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
