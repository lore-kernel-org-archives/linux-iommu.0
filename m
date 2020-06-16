Return-Path: <SRS0=6LHv=75=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B520C433E0
	for <iommu@archiver.kernel.org>; Tue, 16 Jun 2020 07:55:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 364FC2074D
	for <iommu@archiver.kernel.org>; Tue, 16 Jun 2020 07:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkI/+np2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 364FC2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 04E73894F5;
	Tue, 16 Jun 2020 07:55:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fKJ2bxTKWcmu; Tue, 16 Jun 2020 07:55:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id CF130890B0;
	Tue, 16 Jun 2020 07:55:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1FF4C0888;
	Tue, 16 Jun 2020 07:55:09 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67C08C016E
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 07:55:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 51A1424C93
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 07:55:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YZbqgCMiOwOf for <iommu@lists.linux-foundation.org>;
 Tue, 16 Jun 2020 07:55:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 3FBBE220DD
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 07:55:07 +0000 (UTC)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E2B13206D7;
 Tue, 16 Jun 2020 07:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592294107;
 bh=8FPZO3O3J5yEXOHRALaLJwubp6h2AwWSBchtYuoch88=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=MkI/+np2dDimaPbgKZ2S6bxxT/H0/5Kcu+KB+40UE7gA4X81MXbwvAb+4UIfSw+i+
 YJF+ofTwhDTe1xdbZsK8RIVHZdjUn6mBzG7VFvqL0uOFjsRtQJzSC+taURiTbC9zbn
 QZdzj2cHtUF8b4PLo98a8+0YvyaMtPAqmhmdgVbI=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jl6Qz-003LKN-Dg; Tue, 16 Jun 2020 08:55:05 +0100
MIME-Version: 1.0
Date: Tue, 16 Jun 2020 08:55:05 +0100
From: Marc Zyngier <maz@kernel.org>
To: John Stultz <john.stultz@linaro.org>
Subject: Re: [RFC][PATCH 5/5] firmware: QCOM_SCM: Allow qcom_scm driver to be
 loadable as a permenent module
In-Reply-To: <20200616061338.109499-6-john.stultz@linaro.org>
References: <20200616061338.109499-1-john.stultz@linaro.org>
 <20200616061338.109499-6-john.stultz@linaro.org>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <0be86735238a0f8b0c25934e2ed39eee@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: john.stultz@linaro.org, linux-kernel@vger.kernel.org,
 agross@kernel.org, bjorn.andersson@linaro.org, joro@8bytes.org,
 tglx@linutronix.de, jason@lakedaemon.net, linus.walleij@linaro.org,
 ilina@codeaurora.org, saravanak@google.com, tkjos@google.com,
 gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-gpio@vger.kernel.org, will@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Jason Cooper <jason@lakedaemon.net>, Saravana Kannan <saravanak@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 lkml <linux-kernel@vger.kernel.org>, Lina Iyer <ilina@codeaurora.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, linux-gpio@vger.kernel.org,
 iommu@lists.linux-foundation.org, Andy Gross <agross@kernel.org>,
 linux-arm-msm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 will@kernel.org, Linus Walleij <linus.walleij@linaro.org>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi John,

+Will for the SMMU part.

On 2020-06-16 07:13, John Stultz wrote:
> Allow the qcom_scm driver to be loadable as a
> permenent module.
> 
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Lina Iyer <ilina@codeaurora.org>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: iommu@lists.linux-foundation.org
> Cc: linux-gpio@vger.kernel.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  drivers/firmware/Kconfig    | 2 +-
>  drivers/firmware/Makefile   | 3 ++-
>  drivers/firmware/qcom_scm.c | 4 ++++
>  drivers/iommu/Kconfig       | 2 ++
>  4 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index fbd785dd0513..9e533a462bf4 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -236,7 +236,7 @@ config INTEL_STRATIX10_RSU
>  	  Say Y here if you want Intel RSU support.
> 
>  config QCOM_SCM
> -	bool
> +	tristate "Qcom SCM driver"
>  	depends on ARM || ARM64
>  	select RESET_CONTROLLER
> 
> diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
> index 99510be9f5ed..cf24d674216b 100644
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
> index 0e7233a20f34..b5e88bf66975 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -1155,6 +1155,7 @@ static const struct of_device_id 
> qcom_scm_dt_match[] = {
>  	{ .compatible = "qcom,scm" },
>  	{}
>  };
> +MODULE_DEVICE_TABLE(of, qcom_scm_dt_match);
> 
>  static struct platform_driver qcom_scm_driver = {
>  	.driver = {
> @@ -1170,3 +1171,6 @@ static int __init qcom_scm_init(void)
>  	return platform_driver_register(&qcom_scm_driver);
>  }
>  subsys_initcall(qcom_scm_init);
> +
> +MODULE_DESCRIPTION("Qualcomm Technologies, Inc. SCM driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index b510f67dfa49..714893535dd2 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -381,6 +381,7 @@ config SPAPR_TCE_IOMMU
>  config ARM_SMMU
>  	tristate "ARM Ltd. System MMU (SMMU) Support"
>  	depends on (ARM64 || ARM || (COMPILE_TEST && !GENERIC_ATOMIC64)) && 
> MMU
> +	depends on QCOM_SCM || !QCOM_SCM #if QCOM_SCM=m this can't be =y

This looks a bit ugly. Could you explain why we need this at the SMMU 
level? I'd have expected the dependency to flow the other way around...

>  	select IOMMU_API
>  	select IOMMU_IO_PGTABLE_LPAE
>  	select ARM_DMA_USE_IOMMU if ARM
> @@ -500,6 +501,7 @@ config QCOM_IOMMU
>  	# Note: iommu drivers cannot (yet?) be built as modules
>  	bool "Qualcomm IOMMU Support"
>  	depends on ARCH_QCOM || (COMPILE_TEST && !GENERIC_ATOMIC64)
> +	depends on QCOM_SCM=y
>  	select IOMMU_API
>  	select IOMMU_IO_PGTABLE_LPAE
>  	select ARM_DMA_USE_IOMMU

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
