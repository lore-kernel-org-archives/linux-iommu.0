Return-Path: <SRS0=ss7l=MJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C091C636CA
	for <iommu@archiver.kernel.org>; Sat, 17 Jul 2021 05:01:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE098613E3
	for <iommu@archiver.kernel.org>; Sat, 17 Jul 2021 05:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE098613E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E3028441E;
	Sat, 17 Jul 2021 05:01:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gN9UxyYUxlL4; Sat, 17 Jul 2021 05:01:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 482F7843AB;
	Sat, 17 Jul 2021 05:01:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23499C0010;
	Sat, 17 Jul 2021 05:01:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 921ADC000E
 for <iommu@lists.linux-foundation.org>; Sat, 17 Jul 2021 05:01:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7C66E40143
 for <iommu@lists.linux-foundation.org>; Sat, 17 Jul 2021 05:01:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a1FFEHFOK7ok for <iommu@lists.linux-foundation.org>;
 Sat, 17 Jul 2021 05:01:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3801340015
 for <iommu@lists.linux-foundation.org>; Sat, 17 Jul 2021 05:01:16 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id u15so13582638oiw.3
 for <iommu@lists.linux-foundation.org>; Fri, 16 Jul 2021 22:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=tO7v/jiDZA9pK4soZtcjDfack9qaYbeOrYeQ+83PgxA=;
 b=oM7cTlTGTfCnTxR3IIxviM8SUDiKRxATrVQXYlVMXangvFPozYcwG8YfkQy2saViPI
 Si7McqcD/vJkVCcD/PnnsjHSNZTTGsYb31R7/+Rs+J1i847qF99Ku978nol0AwInhmWo
 xwrYSnywp2OUORrjgxUkaMJ74gL0X0ArkqEA/Cpx3dGNQrN66CFs1/yB7MCiF9CU/cCv
 njdZJ6EtmJUCrf5fXyOKuGEHs67mhtESvA5//D0wpCEhlIndRyNtGfYjDeA+Q4x8aaMn
 VWKUcuEyXQcQy9HbI3kjW6lxlTNB1V8Itl/0CQ+nkVV/4OefU07nzBsoGV0qS0f6QDQM
 NOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tO7v/jiDZA9pK4soZtcjDfack9qaYbeOrYeQ+83PgxA=;
 b=oVZlX9qHnSwNGw+ExS+gyBv580OmHomYtRJF6i0nEEuWmEOjKnfb7nFZMnY8C157KV
 z4rtlzyR9ywWCGwOr/CX5NGeOqH/iym4XYDm3Q7p/JOK4Dwq5oSR3QF3GzqSIDgL1b/K
 fP9zhWBVdOImI94yOwwwVMJyWLBlPvAb718ZJw19ALj3NABzpAeNCcPXViUtcsF+bK66
 WIms0uVfL//UHI4661V+li2Y9vb4PjV82q0R73wME4pr4Vpr4wezxU6U3KKOWOFcPUwq
 01ch+aSrym8Ecz2PEcifsnGhaC4VcXkScTTb9KOqPqx2JDch6G7Vv6TljL0Pj3+UTH6g
 B+8w==
X-Gm-Message-State: AOAM533/i7fEbHxlibd1lKMSJn2ByDS1d77NHFe0ISs0qanZUsUJ7+Z6
 y4+eoPwzTpXblkBONCdPjtXzSA==
X-Google-Smtp-Source: ABdhPJxyXgA295NXV3VbckZ0LIjmGP+mh2GywCT72CDbvBkp+4fh3bZsPvxv4L3arGMbPAFRKD10Vg==
X-Received: by 2002:a05:6808:14c8:: with SMTP id
 f8mr10427694oiw.7.1626498074588; 
 Fri, 16 Jul 2021 22:01:14 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net.
 [104.57.184.186])
 by smtp.gmail.com with ESMTPSA id s16sm2404675otg.51.2021.07.16.22.01.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jul 2021 22:01:14 -0700 (PDT)
Date: Sat, 17 Jul 2021 00:01:11 -0500
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH] firmware: QCOM_SCM: Allow qcom_scm driver to be loadable
 as a permenent module
Message-ID: <YPJkF21ItYlKODyq@yoga>
References: <20210707045320.529186-1-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210707045320.529186-1-john.stultz@linaro.org>
Cc: Maulik Shah <mkshah@codeaurora.org>, Saravana Kannan <saravanak@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, lkml <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, linux-gpio@vger.kernel.org,
 Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
 Marc Zyngier <maz@kernel.org>, linux-arm-msm@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Kalle Valo <kvalo@codeaurora.org>,
 Todd Kjos <tkjos@google.com>
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

On Tue 06 Jul 23:53 CDT 2021, John Stultz wrote:

> Allow the qcom_scm driver to be loadable as a permenent module.
> 
> This still uses the "depends on QCOM_SCM || !QCOM_SCM" bit to
> ensure that drivers that call into the qcom_scm driver are
> also built as modules. While not ideal in some cases its the
> only safe way I can find to avoid build errors without having
> those drivers select QCOM_SCM and have to force it on (as
> QCOM_SCM=n can be valid for those drivers).
> 
> Reviving this now that Saravana's fw_devlink defaults to on,
> which should avoid loading troubles seen before.
> 

Are you (in this last paragraph) saying that all those who have been
burnt by fw_devlink during the last months and therefor run with it
disabled will have a less fun experience once this is merged?


(I'm picking this up, but I don't fancy the idea that some people are
turning the boot process into a lottery)

Regards,
Bjorn

> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Cc: Maulik Shah <mkshah@codeaurora.org>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: iommu@lists.linux-foundation.org
> Cc: linux-gpio@vger.kernel.org
> Acked-by: Kalle Valo <kvalo@codeaurora.org>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Will Deacon <will@kernel.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
> v3:
> * Fix __arm_smccc_smc build issue reported by
>   kernel test robot <lkp@intel.com>
> v4:
> * Add "depends on QCOM_SCM || !QCOM_SCM" bit to ath10k
>   config that requires it.
> v5:
> * Fix QCOM_QCM typo in Kconfig, it should be QCOM_SCM
> ---
>  drivers/firmware/Kconfig                | 2 +-
>  drivers/firmware/Makefile               | 3 ++-
>  drivers/firmware/qcom_scm.c             | 4 ++++
>  drivers/iommu/Kconfig                   | 2 ++
>  drivers/net/wireless/ath/ath10k/Kconfig | 1 +
>  5 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index db0ea2d2d75a..af53778edc7e 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -235,7 +235,7 @@ config INTEL_STRATIX10_RSU
>  	  Say Y here if you want Intel RSU support.
>  
>  config QCOM_SCM
> -	bool
> +	tristate "Qcom SCM driver"
>  	depends on ARM || ARM64
>  	depends on HAVE_ARM_SMCCC
>  	select RESET_CONTROLLER
> diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
> index 5e013b6a3692..523173cbff33 100644
> --- a/drivers/firmware/Makefile
> +++ b/drivers/firmware/Makefile
> @@ -17,7 +17,8 @@ obj-$(CONFIG_ISCSI_IBFT)	+= iscsi_ibft.o
>  obj-$(CONFIG_FIRMWARE_MEMMAP)	+= memmap.o
>  obj-$(CONFIG_RASPBERRYPI_FIRMWARE) += raspberrypi.o
>  obj-$(CONFIG_FW_CFG_SYSFS)	+= qemu_fw_cfg.o
> -obj-$(CONFIG_QCOM_SCM)		+= qcom_scm.o qcom_scm-smc.o qcom_scm-legacy.o
> +obj-$(CONFIG_QCOM_SCM)		+= qcom-scm.o
> +qcom-scm-objs += qcom_scm.o qcom_scm-smc.o qcom_scm-legacy.o
>  obj-$(CONFIG_TI_SCI_PROTOCOL)	+= ti_sci.o
>  obj-$(CONFIG_TRUSTED_FOUNDATIONS) += trusted_foundations.o
>  obj-$(CONFIG_TURRIS_MOX_RWTM)	+= turris-mox-rwtm.o
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index ee9cb545e73b..bb9ce3f92931 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -1296,6 +1296,7 @@ static const struct of_device_id qcom_scm_dt_match[] = {
>  	{ .compatible = "qcom,scm" },
>  	{}
>  };
> +MODULE_DEVICE_TABLE(of, qcom_scm_dt_match);
>  
>  static struct platform_driver qcom_scm_driver = {
>  	.driver = {
> @@ -1312,3 +1313,6 @@ static int __init qcom_scm_init(void)
>  	return platform_driver_register(&qcom_scm_driver);
>  }
>  subsys_initcall(qcom_scm_init);
> +
> +MODULE_DESCRIPTION("Qualcomm Technologies, Inc. SCM driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 07b7c25cbed8..f61516c17589 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -253,6 +253,7 @@ config SPAPR_TCE_IOMMU
>  config ARM_SMMU
>  	tristate "ARM Ltd. System MMU (SMMU) Support"
>  	depends on ARM64 || ARM || (COMPILE_TEST && !GENERIC_ATOMIC64)
> +	depends on QCOM_SCM || !QCOM_SCM #if QCOM_SCM=m this can't be =y
>  	select IOMMU_API
>  	select IOMMU_IO_PGTABLE_LPAE
>  	select ARM_DMA_USE_IOMMU if ARM
> @@ -382,6 +383,7 @@ config QCOM_IOMMU
>  	# Note: iommu drivers cannot (yet?) be built as modules
>  	bool "Qualcomm IOMMU Support"
>  	depends on ARCH_QCOM || (COMPILE_TEST && !GENERIC_ATOMIC64)
> +	depends on QCOM_SCM=y
>  	select IOMMU_API
>  	select IOMMU_IO_PGTABLE_LPAE
>  	select ARM_DMA_USE_IOMMU
> diff --git a/drivers/net/wireless/ath/ath10k/Kconfig b/drivers/net/wireless/ath/ath10k/Kconfig
> index 40f91bc8514d..741289e385d5 100644
> --- a/drivers/net/wireless/ath/ath10k/Kconfig
> +++ b/drivers/net/wireless/ath/ath10k/Kconfig
> @@ -44,6 +44,7 @@ config ATH10K_SNOC
>  	tristate "Qualcomm ath10k SNOC support"
>  	depends on ATH10K
>  	depends on ARCH_QCOM || COMPILE_TEST
> +	depends on QCOM_SCM || !QCOM_SCM #if QCOM_SCM=m this can't be =y
>  	select QCOM_QMI_HELPERS
>  	help
>  	  This module adds support for integrated WCN3990 chip connected
> -- 
> 2.25.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
