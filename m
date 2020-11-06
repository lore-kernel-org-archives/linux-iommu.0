Return-Path: <SRS0=4FG6=EM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E68C388F7
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 02:57:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7ADC2068E
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 02:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zZ+0fRGP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7ADC2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 621122754C;
	Fri,  6 Nov 2020 02:57:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hPQx-kmJJO1y; Fri,  6 Nov 2020 02:57:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A94D42012F;
	Fri,  6 Nov 2020 02:57:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84735C0893;
	Fri,  6 Nov 2020 02:57:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0EEAEC0889
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 02:57:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id F04318607D
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 02:57:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 443FnUo543Dn for <iommu@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 02:57:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
 [209.85.210.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id EB5708600D
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 02:57:07 +0000 (UTC)
Received: by mail-ot1-f68.google.com with SMTP id b2so45510ots.5
 for <iommu@lists.linux-foundation.org>; Thu, 05 Nov 2020 18:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=aBjGvGWDZWDNyo0wXKsA/2ZZMFYSNHsXKMDpkJKmgg0=;
 b=zZ+0fRGPq3WO2ejFZUEmCEUBsFlpeNlYkAxZi6GoqqCzeKwBSQeoXJ0aAmF/yswZ8j
 s5ZIKGe52tJrTY6Jkg2S3uCxV1h2loryLM0M11WQSntPVRC1Zinr3Zlj6ot2t9eVikkQ
 oYUmS8KVd9Ctm0szZE+uJOX7ALFeHNzMt9O3Y8t8zTX4AusyZA5QT3fF7MQg2yO+iSvV
 snhVw/TU3UUmEG1Ap7uuHn237gmd1YHuYikDHfLrhuy64y06gA3GHgZs0Jax9XO/wWd3
 2jjURh5XyPKrTxVKVBSBFOBssJON6hFcgHZ19jXwrsRQmc6AVvsGHowwRH52pdGEiH3/
 N9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aBjGvGWDZWDNyo0wXKsA/2ZZMFYSNHsXKMDpkJKmgg0=;
 b=trYNKL1Pxj0uNF24vIs+QEq/17olBHug4Efwvf20QoxMaxo7x+gUiNs9EP/jLgTEeF
 /uK2y3GH9n9B/PmMhVA/I78cvJf/kf38lnUFVbCRVl8DVrJ2yMorw7e+GJFrCsgx4zxo
 B/IzbzvGOmr95nOjivKWAvcsfMM1kcrTcFRTs857BmdBnr8UuvCr+ATeaZGbB+86RGpE
 IVRrEMdmagU9f4dDL0Yrgrzz+NDQP0CjffTM+5590lXK7xM9YcSjV5SZOSZhKWgmmjKG
 Q2lTKVuN0lsgCboGTVdid8avE8Ej9eT7ZfcEEg+cUYjhdHfKDWLaNywE+CpMU8xyU829
 RcxQ==
X-Gm-Message-State: AOAM533BfMrqSMW5MZr03yrEQQSeEDT66lIEPQpoeKItLBJ6aoddsf7r
 D88L6dwFEvGkRpc4BIlArtzbgA==
X-Google-Smtp-Source: ABdhPJxcGSQ9Kri8+3YIvlJn2ZM1KijUrAuZbpqUWzJIJU6KH+C65BAHY6nKyb53S3c3QKPKHxgcOw==
X-Received: by 2002:a05:6830:232d:: with SMTP id
 q13mr3755223otg.324.1604631427166; 
 Thu, 05 Nov 2020 18:57:07 -0800 (PST)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net.
 [104.57.184.186])
 by smtp.gmail.com with ESMTPSA id e47sm12546ote.50.2020.11.05.18.57.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 18:57:06 -0800 (PST)
Date: Thu, 5 Nov 2020 20:57:03 -0600
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH v5 2/2] firmware: QCOM_SCM: Allow qcom_scm driver to be
 loadable as a permenent module
Message-ID: <20201106025703.GC807@yoga>
References: <20201031003845.41137-1-john.stultz@linaro.org>
 <20201031003845.41137-2-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201031003845.41137-2-john.stultz@linaro.org>
Cc: Maulik Shah <mkshah@codeaurora.org>, Jason Cooper <jason@lakedaemon.net>,
 Saravana Kannan <saravanak@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, lkml <linux-kernel@vger.kernel.org>,
 Lina Iyer <ilina@codeaurora.org>, iommu@lists.linux-foundation.org,
 Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
 linux-gpio@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 linux-arm-msm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Kalle Valo <kvalo@codeaurora.org>, Todd Kjos <tkjos@google.com>
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

On Fri 30 Oct 19:38 CDT 2020, John Stultz wrote:

> Allow the qcom_scm driver to be loadable as a permenent module.
> 
> This still uses the "depends on QCOM_SCM || !QCOM_SCM" bit to
> ensure that drivers that call into the qcom_scm driver are
> also built as modules. While not ideal in some cases its the
> only safe way I can find to avoid build errors without having
> those drivers select QCOM_SCM and have to force it on (as
> QCOM_SCM=n can be valid for those drivers).
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Cc: Maulik Shah <mkshah@codeaurora.org>
> Cc: Lina Iyer <ilina@codeaurora.org>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: iommu@lists.linux-foundation.org
> Cc: linux-gpio@vger.kernel.org
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: John Stultz <john.stultz@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

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
>  drivers/firmware/Kconfig                | 4 ++--
>  drivers/firmware/Makefile               | 3 ++-
>  drivers/firmware/qcom_scm.c             | 4 ++++
>  drivers/iommu/Kconfig                   | 2 ++
>  drivers/net/wireless/ath/ath10k/Kconfig | 1 +
>  5 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index 3315e3c215864..5e369928bc567 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -235,8 +235,8 @@ config INTEL_STRATIX10_RSU
>  	  Say Y here if you want Intel RSU support.
>  
>  config QCOM_SCM
> -	bool
> -	depends on ARM || ARM64
> +	tristate "Qcom SCM driver"
> +	depends on (ARM && HAVE_ARM_SMCCC) || ARM64
>  	select RESET_CONTROLLER
>  
>  config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
> diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
> index 5e013b6a3692e..523173cbff335 100644
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
> index 7be48c1bec96d..6f431b73e617d 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -1280,6 +1280,7 @@ static const struct of_device_id qcom_scm_dt_match[] = {
>  	{ .compatible = "qcom,scm" },
>  	{}
>  };
> +MODULE_DEVICE_TABLE(of, qcom_scm_dt_match);
>  
>  static struct platform_driver qcom_scm_driver = {
>  	.driver = {
> @@ -1295,3 +1296,6 @@ static int __init qcom_scm_init(void)
>  	return platform_driver_register(&qcom_scm_driver);
>  }
>  subsys_initcall(qcom_scm_init);
> +
> +MODULE_DESCRIPTION("Qualcomm Technologies, Inc. SCM driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 04878caf6da49..c64d7a2b65134 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -248,6 +248,7 @@ config SPAPR_TCE_IOMMU
>  config ARM_SMMU
>  	tristate "ARM Ltd. System MMU (SMMU) Support"
>  	depends on ARM64 || ARM || (COMPILE_TEST && !GENERIC_ATOMIC64)
> +	depends on QCOM_SCM || !QCOM_SCM #if QCOM_SCM=m this can't be =y
>  	select IOMMU_API
>  	select IOMMU_IO_PGTABLE_LPAE
>  	select ARM_DMA_USE_IOMMU if ARM
> @@ -375,6 +376,7 @@ config QCOM_IOMMU
>  	# Note: iommu drivers cannot (yet?) be built as modules
>  	bool "Qualcomm IOMMU Support"
>  	depends on ARCH_QCOM || (COMPILE_TEST && !GENERIC_ATOMIC64)
> +	depends on QCOM_SCM=y
>  	select IOMMU_API
>  	select IOMMU_IO_PGTABLE_LPAE
>  	select ARM_DMA_USE_IOMMU
> diff --git a/drivers/net/wireless/ath/ath10k/Kconfig b/drivers/net/wireless/ath/ath10k/Kconfig
> index 40f91bc8514d8..741289e385d59 100644
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
> 2.17.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
