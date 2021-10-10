Return-Path: <SRS0=jhW9=O6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E51AC433EF
	for <iommu@archiver.kernel.org>; Sun, 10 Oct 2021 04:16:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 171AC61076
	for <iommu@archiver.kernel.org>; Sun, 10 Oct 2021 04:16:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 171AC61076
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B1BCD404C0;
	Sun, 10 Oct 2021 04:16:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VReFxMCSUrYh; Sun, 10 Oct 2021 04:16:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 61BE540436;
	Sun, 10 Oct 2021 04:16:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16936C0011;
	Sun, 10 Oct 2021 04:16:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 895F0C000D
 for <iommu@lists.linux-foundation.org>; Sun, 10 Oct 2021 04:16:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 64582404C0
 for <iommu@lists.linux-foundation.org>; Sun, 10 Oct 2021 04:16:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 41PDURqQ-yRJ for <iommu@lists.linux-foundation.org>;
 Sun, 10 Oct 2021 04:16:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8DAFE40436
 for <iommu@lists.linux-foundation.org>; Sun, 10 Oct 2021 04:16:42 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id y207so16350038oia.11
 for <iommu@lists.linux-foundation.org>; Sat, 09 Oct 2021 21:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=9dKksHyZGIoBAPrBU/GqwD12Fnz5BhKh8zQvkAEnzwI=;
 b=iCjZiCxoSer6nwXKtggrDTz0n8s8SkVXF46eVVf+dAXR7iAWmg2pOFnaz+uVwYkvcR
 8r/6AvZwj+EfCRbp3HGARx5fYbAxihUt6E+Frj2tjhGXpfgMKKn5CZMd1RxmMpW9QdVt
 dXTbLisBUVmNM6Wdyhbgny2tJnO6R5EF4qqH5xTBbfvGCr6FIHoUwiISBgEWodBNl+Mb
 //n8m5+LA2xS9jwEkiXTxHsVZtLeeYM1OanjAvYd1xRdnlcA7HvDjCQH2IyTvcMCUCBt
 q3SDVuwNDLKDrfRJmpBg+F5Ety22YhHWZsbkgTfcKBe1FD8ZYqLbziAGwiT2warMuoMO
 7L8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9dKksHyZGIoBAPrBU/GqwD12Fnz5BhKh8zQvkAEnzwI=;
 b=CKQ0nz0owsdtu4jQvY0EBTJsoi+tLLMdGqU4ugeUL0cVUyBKc0IoRO3CSRWS9zADb2
 kDR2nRbFtxe4clZejbjPFaqm6nqUpkNf/yy2cu40/nb0XJkvFl5U1lPrL+jOx4/zxdh4
 hhZuow5yzP7hS2nVV5KR3+HgnA0/JTgDOLN3GREFZbOm6+FXlwC0dn5/TwPCk16Ofp+F
 V8424n0Mnb7ePyuYDaezSdEPtqvHN47amYcrJ4A7mJZJ2S2ntnXLILNotHrWC5u2KDXh
 Ro/hKWlO7u3IQP1q89KwKWEHLopGGc2433cQpRLG/pmZbPS5u9CI8MnfREBSWjcH2yez
 y5gg==
X-Gm-Message-State: AOAM532vHHPyBRtW1UG0oQikzzsRhoRVhKQE39v6x/Chpbq2v65pd3xm
 3w8iHdm5NO9om7dQUo0Uv8mK+g==
X-Google-Smtp-Source: ABdhPJxnOE3APNnnhnQmDWVAu7V3BvKoUVtdoeSGZ4XRGgWVmuQ54HqxcfsBWYHkiC1jZ4YcsSvprA==
X-Received: by 2002:a05:6808:1816:: with SMTP id
 bh22mr13248863oib.69.1633839401460; 
 Sat, 09 Oct 2021 21:16:41 -0700 (PDT)
Received: from yoga ([2600:1700:a0:3dc8:c84c:8eff:fe1e:256f])
 by smtp.gmail.com with ESMTPSA id 38sm907603oti.13.2021.10.09.21.16.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Oct 2021 21:16:40 -0700 (PDT)
Date: Sat, 9 Oct 2021 23:16:38 -0500
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH] iommu: fix ARM_SMMU vs QCOM_SCM compilation
Message-ID: <YWJpJnaQ2Nr4PUwr@yoga>
References: <20211010023350.978638-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211010023350.978638-1-dmitry.baryshkov@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Andy Gross <agross@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
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

On Sat 09 Oct 21:33 CDT 2021, Dmitry Baryshkov wrote:

> After commit 424953cf3c66 ("qcom_scm: hide Kconfig symbol") arm-smmu got
> qcom_smmu_impl_init() call guarded by IS_ENABLED(CONFIG_ARM_SMMU_QCOM).
> However the CONFIG_ARM_SMMU_QCOM Kconfig entry does not exist, so the
> qcom_smmu_impl_init() is never called.
> 
> So, let's fix this by always calling qcom_smmu_impl_init(). It does not
> touch the smmu passed unless the device is a non-Qualcomm one. Make
> ARM_SMMU select QCOM_SCM for ARCH_QCOM.
> 

Arnd's intention was to not force QCOM_SCM to be built on non-Qualcomm
devices. But as Daniel experienced, attempting to boot most Qualcomm
boards without this results in a instant reboot.

I think it's okay if we tinker with CONFIG_ARM_SMMU_QCOM for v5.16, but
we're getting late in v5.15 so I would prefer if we make sure this works
out of the box.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Fixes: 424953cf3c66 ("qcom_scm: hide Kconfig symbol")
> Cc: Arnd Bergmann <arnd@arndb.de>
> Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/iommu/Kconfig                      | 1 +
>  drivers/iommu/arm/arm-smmu/Makefile        | 3 +--
>  drivers/iommu/arm/arm-smmu/arm-smmu-impl.c | 9 +++++++--
>  3 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index c5c71b7ab7e8..a4593e53fe7d 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -309,6 +309,7 @@ config ARM_SMMU
>  	tristate "ARM Ltd. System MMU (SMMU) Support"
>  	depends on ARM64 || ARM || (COMPILE_TEST && !GENERIC_ATOMIC64)
>  	select IOMMU_API
> +	select QCOM_SCM
>  	select IOMMU_IO_PGTABLE_LPAE
>  	select ARM_DMA_USE_IOMMU if ARM
>  	help
> diff --git a/drivers/iommu/arm/arm-smmu/Makefile b/drivers/iommu/arm/arm-smmu/Makefile
> index b0cc01aa20c9..e240a7bcf310 100644
> --- a/drivers/iommu/arm/arm-smmu/Makefile
> +++ b/drivers/iommu/arm/arm-smmu/Makefile
> @@ -1,5 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_QCOM_IOMMU) += qcom_iommu.o
>  obj-$(CONFIG_ARM_SMMU) += arm_smmu.o
> -arm_smmu-objs += arm-smmu.o arm-smmu-impl.o arm-smmu-nvidia.o
> -arm_smmu-$(CONFIG_ARM_SMMU_QCOM) += arm-smmu-qcom.o
> +arm_smmu-objs += arm-smmu.o arm-smmu-impl.o arm-smmu-nvidia.o arm-smmu-qcom.o
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
> index 2c25cce38060..8199185dd262 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
> @@ -215,8 +215,13 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
>  	    of_device_is_compatible(np, "nvidia,tegra186-smmu"))
>  		return nvidia_smmu_impl_init(smmu);
>  
> -	if (IS_ENABLED(CONFIG_ARM_SMMU_QCOM))
> -		smmu = qcom_smmu_impl_init(smmu);
> +	/*
> +	 * qcom_smmu_impl_init() will not touch smmu if the device is not
> +	 * a Qualcomm one.
> +	 */
> +	smmu = qcom_smmu_impl_init(smmu);
> +	if (IS_ERR(smmu))
> +		return smmu;
>  
>  	if (of_device_is_compatible(np, "marvell,ap806-smmu-500"))
>  		smmu->impl = &mrvl_mmu500_impl;
> -- 
> 2.30.2
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
