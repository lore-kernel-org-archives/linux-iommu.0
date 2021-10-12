Return-Path: <SRS0=nyYM=PA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75047C433F5
	for <iommu@archiver.kernel.org>; Tue, 12 Oct 2021 03:36:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1832E6101D
	for <iommu@archiver.kernel.org>; Tue, 12 Oct 2021 03:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1832E6101D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D28434043A;
	Tue, 12 Oct 2021 03:36:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tIIl9l_y3sRD; Tue, 12 Oct 2021 03:36:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 976BD40370;
	Tue, 12 Oct 2021 03:36:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68426C000F;
	Tue, 12 Oct 2021 03:36:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0791C000D
 for <iommu@lists.linux-foundation.org>; Tue, 12 Oct 2021 03:36:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D206D6070D
 for <iommu@lists.linux-foundation.org>; Tue, 12 Oct 2021 03:36:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6JjSjzX_85sV for <iommu@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 03:36:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1F49260672
 for <iommu@lists.linux-foundation.org>; Tue, 12 Oct 2021 03:36:04 +0000 (UTC)
Received: by mail-qv1-xf2d.google.com with SMTP id d20so12157508qvm.8
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 20:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PuQBYQiE0//qwdR0lx7ufC/zx2o6SBXy6e/jdiWZvrU=;
 b=os/NuwEqCmcu0BrOeQfB4+n7QKmw1s47pBPDW8YOBVogWBAmvvbRsvbsJA46s5un4n
 eIzjs6xSLG8TCx9TycSaw6F9URHG/10SY7z/h9OBcxjvvNVWs0F15ZI/fMSyHTaGiGY/
 gjLYecaGaHCYDEEtMUERWa8As1PEiyzLLFvGQWUqhPHcMJ4RlG1LXh1MpyV7a8nJ/ubX
 6rVk6jca+FTiUatOC3sYtLC3jRs4hxLAIT2mkIWF4khFzpcSUdeY1xsGIxbnPai9Ckwd
 03jBu5odwiHeSOV9gnYJJTuDUSG6gnsbQVRAYkV3ADgfGRa0UaoyWB5ysNN0imlQWFsq
 ipvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PuQBYQiE0//qwdR0lx7ufC/zx2o6SBXy6e/jdiWZvrU=;
 b=35m7z0MExWq6nAR6BDlsVYACKxovdsYWyTkKAG1Jhcl1oRzUUDKYurU1zfEjUBsBXe
 4t5eo9ky1u6ULcidhWNKVgpoyIUL+hbPgiY+dngrS4ZJpJ5JP0lN+uUhxdNOrBFdBnmw
 wepFmnoM6WQgo+GojcWuwxd4+jumd5ngeCtgYXdL52ECnM/AEpUlD8lPbMXPRIdCuT/J
 Ya1UeiBQra626olbhNDYaqa+ej+W/Bacb7sxlH+KrfjscjOAPUH/b+R+B2a6R8UNPoeV
 xPeYf4u0H5+F7drzA9zH4CBzLp7FU+2pDoTJe4WuFPzpQlziIf+XppodGQkmk4fuw6j6
 NQAA==
X-Gm-Message-State: AOAM5326nlxXyheYVc1hGwfTzqAAU8q5JCbKoOin865/T1DBbu3w0FAy
 RG+JACiYLM5J9RctyNCn3OpCrdgosHvHE/m5GPnw7w==
X-Google-Smtp-Source: ABdhPJxlbpmzun2i5ifUkeHpsWQA8qd+5ZG5Cd31eOgNJQa6VTEb8HUSywYsLuVpWrVbDUjc6Uz4EsHBYXxFEF/i6bg=
X-Received: by 2002:a0c:fad0:: with SMTP id p16mr255245qvo.3.1634009763022;
 Mon, 11 Oct 2021 20:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20211010023350.978638-1-dmitry.baryshkov@linaro.org>
 <YWJpJnaQ2Nr4PUwr@yoga>
 <CAK8P3a3irqEVH2e9wCK4MSSBKRW-n8pFSzYBks9ri-hepewkUw@mail.gmail.com>
In-Reply-To: <CAK8P3a3irqEVH2e9wCK4MSSBKRW-n8pFSzYBks9ri-hepewkUw@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 12 Oct 2021 06:35:51 +0300
Message-ID: <CAA8EJpo7kg2h3dJEW+ZCrRhqZ4rvNrs_7WRiX+-adGXXAtu=BA@mail.gmail.com>
Subject: Re: [PATCH] iommu: fix ARM_SMMU vs QCOM_SCM compilation
To: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Andy Gross <agross@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Thierry Reding <treding@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
 Kalle Valo <kvalo@codeaurora.org>
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

On Sun, 10 Oct 2021 at 20:42, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sun, Oct 10, 2021 at 6:17 AM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > On Sat 09 Oct 21:33 CDT 2021, Dmitry Baryshkov wrote:
> >
> > > After commit 424953cf3c66 ("qcom_scm: hide Kconfig symbol") arm-smmu got
> > > qcom_smmu_impl_init() call guarded by IS_ENABLED(CONFIG_ARM_SMMU_QCOM).
> > > However the CONFIG_ARM_SMMU_QCOM Kconfig entry does not exist, so the
> > > qcom_smmu_impl_init() is never called.
> > >
> > > So, let's fix this by always calling qcom_smmu_impl_init(). It does not
> > > touch the smmu passed unless the device is a non-Qualcomm one. Make
> > > ARM_SMMU select QCOM_SCM for ARCH_QCOM.
>
> Sorry about this bug. I was sure I had it working, but I lost part of the commit
> during a rebase, and my randconfig builds still succeeded without it, so I
> sent a wrong version.
>
> > Arnd's intention was to not force QCOM_SCM to be built on non-Qualcomm
> > devices. But as Daniel experienced, attempting to boot most Qualcomm
> > boards without this results in a instant reboot.
> >
> > I think it's okay if we tinker with CONFIG_ARM_SMMU_QCOM for v5.16, but
> > we're getting late in v5.15 so I would prefer if we make sure this works
> > out of the box.
>
> Yes, makes sense. For reference, see below for how I would fix this properly,
> this is what I had intended to have in the patch. Feel free to pick
> either version
> as the immediate bugfix. I'll give the below a little more randconfig testing
> overnight though. The pasted version of the patch is probably
> whitespace-damaged,
> let me know if you would like me to send it as a proper patch.
>
>        Arnd
>
> 8<-----
> Subject: iommu: fix ARM_SMMU_QCOM compilation
>
> My previous bugfix ended up making things worse for the QCOM IOMMU
> driver when it forgot to add the Kconfig symbol that is getting used to
> control the compilation of the SMMU implementation specific code
> for Qualcomm.
>
> Fixes: 424953cf3c66 ("qcom_scm: hide Kconfig symbol")
> Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Let's get either of them in.

> ----
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index c5c71b7ab7e8..2dfe744ddd97 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -311,6 +311,7 @@ config ARM_SMMU
>         select IOMMU_API
>         select IOMMU_IO_PGTABLE_LPAE
>         select ARM_DMA_USE_IOMMU if ARM
> +       select QCOM_SCM if ARM_SMMU_QCOM
>         help
>           Support for implementations of the ARM System MMU architecture
>           versions 1 and 2.
> @@ -355,6 +356,13 @@ config ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT
>           'arm-smmu.disable_bypass' will continue to override this
>           config.
>
> +config ARM_SMMU_QCOM
> +       def_bool y
> +       depends on ARM_SMMU && ARCH_QCOM
> +       help
> +         When running on a Qualcomm platform that has the custom variant
> +         of the ARM SMMU, this needs to be built into the SMMU driver.
> +
>  config ARM_SMMU_V3
>         tristate "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
>         depends on ARM64



-- 
With best wishes
Dmitry
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
