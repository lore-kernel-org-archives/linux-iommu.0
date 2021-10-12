Return-Path: <SRS0=nyYM=PA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A5FC433FE
	for <iommu@archiver.kernel.org>; Tue, 12 Oct 2021 03:11:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49DDA608FE
	for <iommu@archiver.kernel.org>; Tue, 12 Oct 2021 03:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 49DDA608FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 03EB9402A8;
	Tue, 12 Oct 2021 03:11:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RwkMEMxqdfqk; Tue, 12 Oct 2021 03:11:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 769CB402A4;
	Tue, 12 Oct 2021 03:11:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C8C2C000F;
	Tue, 12 Oct 2021 03:11:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7635C000D
 for <iommu@lists.linux-foundation.org>; Tue, 12 Oct 2021 03:11:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9716F401AE
 for <iommu@lists.linux-foundation.org>; Tue, 12 Oct 2021 03:11:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vZuv0S3JwZek for <iommu@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 03:11:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 353C940172
 for <iommu@lists.linux-foundation.org>; Tue, 12 Oct 2021 03:11:35 +0000 (UTC)
Received: by mail-lf1-x12c.google.com with SMTP id x27so81823494lfu.5
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 20:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=w2FJM5xq0hHLOwYkxQq9HjtkvFRksFK+c9CUBnhMlUA=;
 b=ECxgpBAgFN57M9Muv6HgPW+2gsbKzFTgbdkbk/wcoXHhkLozGpRLLlOMDYegVvygHN
 2py0lXASeUR5ykVbr81UL/hPafzHt+NJHhyIvmIYcmytMQ6GdAJ8dUABYBTqcJvXUoDk
 df377gxkJR4hl2XnoHq6H5fg1PhPosrjlO+vw06vz95++L7FV4HiYbwq2J1WFfNnN/jf
 Mx2ogkRKfRgA5smJ82Ca1+NvpsHAbDGCT+LpTXs64ymH6okmPAuVxvDsTmmJO9KVLgUG
 pZxdks765lI2PhK8KGoyJxBi3yRR/GHoeDDoq3qeWcq50tyooD3LpiVGlx8t8P9OlzUu
 Hbhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=w2FJM5xq0hHLOwYkxQq9HjtkvFRksFK+c9CUBnhMlUA=;
 b=UmdRd8gyjwAGuE0yOJRYZUWoBgBO2L6VkHulfUuLfRfjYxqrVC9Yv/8WDGcm+Tgwyc
 W29iVi9uR6S1CQlh7zu7v03OAOyCa0+mOtMgtyJNe18owITrRkmMZOBTFQVJW9joIiBd
 ULbBxeubfHZOjjOZYy5zQniVavEJa6n8V6s/ativl2bShClvqMS9w5aB7BOI+Xd0/MBD
 HWQVIJ2/pbyHMn3MPUr7JP7WqfT/oMFXIRl9/vo/aCxocoaIYy6eCx5r3g9Cho+3gDHO
 io2OsorOM8q8IBAOq9qnNej7zLaoDXTp5GfkeStZOmq2HYoPK8D6bc9b6PHb0I3WWg37
 DR9w==
X-Gm-Message-State: AOAM533WsEGs/oRKWrqqgOGnvPGsJWHzo6TNR4qA6KMxCJCMpC6lDb0O
 0hcWW+DjCkhjOtlX7/Ukyy4wcL0GgUWFzQkjcobrYA==
X-Google-Smtp-Source: ABdhPJyrNsMKS3+CiKmx5Tie0/Y10h5OgwLQcjWxqMC9cxgYiRdOXIj2B1esdvuIxFjjlUZ3q1gGQg9rDQ/7FbCROq4=
X-Received: by 2002:a05:651c:b21:: with SMTP id
 b33mr25766490ljr.515.1634008293091; 
 Mon, 11 Oct 2021 20:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <20211007151010.333516-1-arnd@kernel.org>
 <20211007151010.333516-2-arnd@kernel.org>
In-Reply-To: <20211007151010.333516-2-arnd@kernel.org>
From: John Stultz <john.stultz@linaro.org>
Date: Mon, 11 Oct 2021 20:11:20 -0700
Message-ID: <CALAqxLVVEi67HQbjCSvfDPmfjeeZ4ROvqa8yfYMnRmeyi34Ddw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] qcom_scm: hide Kconfig symbol
To: Arnd Bergmann <arnd@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Amit Pundir <amit.pundir@linaro.org>, linux-wireless@vger.kernel.org,
 Caleb Connolly <caleb.connolly@linaro.org>, linux-ia64@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, linux-parisc@vger.kernel.org,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>, Alex Elder <elder@linaro.org>,
 linux-mmc <linux-mmc@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, linux-mips@vger.kernel.org,
 Kalle Valo <kvalo@codeaurora.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 ath10k <ath10k@lists.infradead.org>,
 Network Development <netdev@vger.kernel.org>, linux-riscv@lists.infradead.org,
 "open list:DRM DRIVER FOR MSM ADRENO GPU" <freedreno@lists.freedesktop.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-media <linux-media@vger.kernel.org>
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

On Thu, Oct 7, 2021 at 8:10 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Now that SCM can be a loadable module, we have to add another
> dependency to avoid link failures when ipa or adreno-gpu are
> built-in:
>
> aarch64-linux-ld: drivers/net/ipa/ipa_main.o: in function `ipa_probe':
> ipa_main.c:(.text+0xfc4): undefined reference to `qcom_scm_is_available'
>
> ld.lld: error: undefined symbol: qcom_scm_is_available
> >>> referenced by adreno_gpu.c
> >>>               gpu/drm/msm/adreno/adreno_gpu.o:(adreno_zap_shader_load) in archive drivers/built-in.a
>
> This can happen when CONFIG_ARCH_QCOM is disabled and we don't select
> QCOM_MDT_LOADER, but some other module selects QCOM_SCM. Ideally we'd
> use a similar dependency here to what we have for QCOM_RPROC_COMMON,
> but that causes dependency loops from other things selecting QCOM_SCM.
>
> This appears to be an endless problem, so try something different this
> time:
>
>  - CONFIG_QCOM_SCM becomes a hidden symbol that nothing 'depends on'
>    but that is simply selected by all of its users
>
>  - All the stubs in include/linux/qcom_scm.h can go away
>
>  - arm-smccc.h needs to provide a stub for __arm_smccc_smc() to
>    allow compile-testing QCOM_SCM on all architectures.
>
>  - To avoid a circular dependency chain involving RESET_CONTROLLER
>    and PINCTRL_SUNXI, drop the 'select RESET_CONTROLLER' statement.
>    According to my testing this still builds fine, and the QCOM
>    platform selects this symbol already.
>
> Acked-by: Kalle Valo <kvalo@codeaurora.org>
> Acked-by: Alex Elder <elder@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Changes in v2:
> - fix the iommu dependencies

Hey Arnd,
   Thanks again so much for working out these details. Also my
apologies, as Bjorn asked for me to test this patch, but I wasn't able
to get to it before it landed.  Unfortunately I've hit an issue that
is keeping the db845c from booting with this.

> diff --git a/drivers/iommu/arm/arm-smmu/Makefile b/drivers/iommu/arm/arm-smmu/Makefile
> index e240a7bcf310..b0cc01aa20c9 100644
> --- a/drivers/iommu/arm/arm-smmu/Makefile
> +++ b/drivers/iommu/arm/arm-smmu/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_QCOM_IOMMU) += qcom_iommu.o
>  obj-$(CONFIG_ARM_SMMU) += arm_smmu.o
> -arm_smmu-objs += arm-smmu.o arm-smmu-impl.o arm-smmu-nvidia.o arm-smmu-qcom.o
> +arm_smmu-objs += arm-smmu.o arm-smmu-impl.o arm-smmu-nvidia.o
> +arm_smmu-$(CONFIG_ARM_SMMU_QCOM) += arm-smmu-qcom.o
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
> index 9f465e146799..2c25cce38060 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
> @@ -215,7 +215,8 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
>             of_device_is_compatible(np, "nvidia,tegra186-smmu"))
>                 return nvidia_smmu_impl_init(smmu);
>
> -       smmu = qcom_smmu_impl_init(smmu);
> +       if (IS_ENABLED(CONFIG_ARM_SMMU_QCOM))
> +               smmu = qcom_smmu_impl_init(smmu);
>
>         if (of_device_is_compatible(np, "marvell,ap806-smmu-500"))
>                 smmu->impl = &mrvl_mmu500_impl;


The problem with these two chunks is that there is currently no
CONFIG_ARM_SMMU_QCOM option. :)

Was that something you intended to add in the patch?

I'm working up a Kconfig patch to do so, so I'll send that out in a
second here, but let me know if you already have that somewhere (I
suspect you implemented it and just forgot to add the change to the
commit), as I'm sure your Kconfig help text will be better than mine.
:)

Again, I'm so sorry I didn't get over to testing your patch before
seeing this here!

thanks
-john
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
