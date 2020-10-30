Return-Path: <SRS0=LARK=EF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26330C56202
	for <iommu@archiver.kernel.org>; Fri, 30 Oct 2020 06:12:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9028F22203
	for <iommu@archiver.kernel.org>; Fri, 30 Oct 2020 06:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ucSFacNK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9028F22203
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 091A385B6F;
	Fri, 30 Oct 2020 06:12:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K+L+9KPzrL4A; Fri, 30 Oct 2020 06:12:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1C5F18472A;
	Fri, 30 Oct 2020 06:12:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 087FDC0859;
	Fri, 30 Oct 2020 06:12:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9361C0051
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 06:12:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A6EFB8472A
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 06:12:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7Rmgo7O5nyk0 for <iommu@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 06:12:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
 [209.85.210.195])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D0D3685B6F
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 06:12:50 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id x13so4350002pfa.9
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 23:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=XL8dlYsys8f0rEfjnC/wd7q6iLsC0pHXJKRnSKdn6W0=;
 b=ucSFacNKSmrbhaPRrbT06cNK4cn7SZCAXWRWXeTSC4eyKPhMAvV4sbRJURDUCvylhE
 dPNrSm6ZcTRFKgxhL9AOI5bQnJloDfjgSC/MS7Cul+7L99g94eSAHfonJqxcPlTiSz34
 9Dp8VD1Q80/06hvO/55VEt8eQwgOOUHaVf3jJnnuBC2f2BFklX1H+VKUj5/OPUvWq9pg
 3eTo6+ilJZeIMaRpinteFozW+tRqEQD3WpXsEx0MqVIvKIQ06+3SNLhcKMuwdX2drWSF
 rX8eMLB86Jaj6vbersTaCrpxcuk2Abxo8Nml5Y3QEuf4NrQorRCFQG3MuKdaerjxZOcG
 f33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=XL8dlYsys8f0rEfjnC/wd7q6iLsC0pHXJKRnSKdn6W0=;
 b=GkRHu7ZJxI4n+iDre3yKyy8cSLMCIHezm7K+xfFsU0hYnzct/0XxKTic78eukXbaA4
 TGI/8UxD8XOpUepq25haUwR9GzN8XbqgFz2ERhafwueXh9xumyXsKcFSy/NNa8V3yFwn
 76NTnvLr6UDutNleIHZWJYY2wqvjjZanZhB41sP0vU/RU5MEPBRmRjFYM/dF8Cd0i57s
 SWn/Gmm4RFrMvSUksPp8hq81fYsIZEk1nEQuEa6Rw6pxw7yL1/FBYevd7BoKcmSb297m
 aZKr/qFtAKzF4nJASfTCUWKqZ6KxvV5PruVqIvlBaAbQaltBOaJFl/HdFnO947xjgPEj
 BGEg==
X-Gm-Message-State: AOAM533smxOkPpWLtIH3LAVzNnPZ+FVdWB2KI/u13PUOyfJakHRKi5KT
 K+eNb7Zq2uREYwt0rmZBt9l+vA==
X-Google-Smtp-Source: ABdhPJyKJNlJnOp6EgkD/F2N0FG3RRqQHjvvRb+m5P60VJ9zj6tXMSeu/PtwAy/EU9rovtjIcG+cGg==
X-Received: by 2002:a17:90a:2c46:: with SMTP id
 p6mr988289pjm.166.1604038370505; 
 Thu, 29 Oct 2020 23:12:50 -0700 (PDT)
Received: from localhost.localdomain (c-67-170-172-113.hsd1.or.comcast.net.
 [67.170.172.113])
 by smtp.gmail.com with ESMTPSA id e2sm4461569pgd.27.2020.10.29.23.12.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 23:12:49 -0700 (PDT)
From: John Stultz <john.stultz@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/2] firmware: QCOM_SCM: Allow qcom_scm driver to be
 loadable as a permenent module
Date: Fri, 30 Oct 2020 06:12:42 +0000
Message-Id: <20201030061242.92510-2-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201030061242.92510-1-john.stultz@linaro.org>
References: <20201030061242.92510-1-john.stultz@linaro.org>
Cc: Maulik Shah <mkshah@codeaurora.org>, Jason Cooper <jason@lakedaemon.net>,
 Saravana Kannan <saravanak@google.com>, Marc Zyngier <maz@kernel.org>,
 Lina Iyer <ilina@codeaurora.org>, linux-gpio@vger.kernel.org,
 iommu@lists.linux-foundation.org, Andy Gross <agross@kernel.org>,
 John Stultz <john.stultz@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>,
 linux-arm-msm@vger.kernel.org, Todd Kjos <tkjos@google.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Allow the qcom_scm driver to be loadable as a permenent module.

This still uses the "depends on QCOM_SCM || !QCOM_SCM" bit to
ensure that drivers that call into the qcom_scm driver are
also built as modules. While not ideal in some cases its the
only safe way I can find to avoid build errors without having
those drivers select QCOM_SCM and have to force it on (as
QCOM_SCM=n can be valid for those drivers).

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Maulik Shah <mkshah@codeaurora.org>
Cc: Lina Iyer <ilina@codeaurora.org>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: iommu@lists.linux-foundation.org
Cc: linux-gpio@vger.kernel.org
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v3: Fix __arm_smccc_smc build issue reported by
    kernel test robot <lkp@intel.com>
v4: Add "depends on QCOM_SCM || !QCOM_SCM" bit to ath10k
    config that requires it.
---
 drivers/firmware/Kconfig                | 4 ++--
 drivers/firmware/Makefile               | 3 ++-
 drivers/firmware/qcom_scm.c             | 4 ++++
 drivers/iommu/Kconfig                   | 2 ++
 drivers/net/wireless/ath/ath10k/Kconfig | 1 +
 5 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 3315e3c215864..5e369928bc567 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -235,8 +235,8 @@ config INTEL_STRATIX10_RSU
 	  Say Y here if you want Intel RSU support.
 
 config QCOM_SCM
-	bool
-	depends on ARM || ARM64
+	tristate "Qcom SCM driver"
+	depends on (ARM && HAVE_ARM_SMCCC) || ARM64
 	select RESET_CONTROLLER
 
 config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 5e013b6a3692e..523173cbff335 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -17,7 +17,8 @@ obj-$(CONFIG_ISCSI_IBFT)	+= iscsi_ibft.o
 obj-$(CONFIG_FIRMWARE_MEMMAP)	+= memmap.o
 obj-$(CONFIG_RASPBERRYPI_FIRMWARE) += raspberrypi.o
 obj-$(CONFIG_FW_CFG_SYSFS)	+= qemu_fw_cfg.o
-obj-$(CONFIG_QCOM_SCM)		+= qcom_scm.o qcom_scm-smc.o qcom_scm-legacy.o
+obj-$(CONFIG_QCOM_SCM)		+= qcom-scm.o
+qcom-scm-objs += qcom_scm.o qcom_scm-smc.o qcom_scm-legacy.o
 obj-$(CONFIG_TI_SCI_PROTOCOL)	+= ti_sci.o
 obj-$(CONFIG_TRUSTED_FOUNDATIONS) += trusted_foundations.o
 obj-$(CONFIG_TURRIS_MOX_RWTM)	+= turris-mox-rwtm.o
diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 7be48c1bec96d..6f431b73e617d 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -1280,6 +1280,7 @@ static const struct of_device_id qcom_scm_dt_match[] = {
 	{ .compatible = "qcom,scm" },
 	{}
 };
+MODULE_DEVICE_TABLE(of, qcom_scm_dt_match);
 
 static struct platform_driver qcom_scm_driver = {
 	.driver = {
@@ -1295,3 +1296,6 @@ static int __init qcom_scm_init(void)
 	return platform_driver_register(&qcom_scm_driver);
 }
 subsys_initcall(qcom_scm_init);
+
+MODULE_DESCRIPTION("Qualcomm Technologies, Inc. SCM driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 04878caf6da49..c64d7a2b65134 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -248,6 +248,7 @@ config SPAPR_TCE_IOMMU
 config ARM_SMMU
 	tristate "ARM Ltd. System MMU (SMMU) Support"
 	depends on ARM64 || ARM || (COMPILE_TEST && !GENERIC_ATOMIC64)
+	depends on QCOM_SCM || !QCOM_SCM #if QCOM_SCM=m this can't be =y
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_LPAE
 	select ARM_DMA_USE_IOMMU if ARM
@@ -375,6 +376,7 @@ config QCOM_IOMMU
 	# Note: iommu drivers cannot (yet?) be built as modules
 	bool "Qualcomm IOMMU Support"
 	depends on ARCH_QCOM || (COMPILE_TEST && !GENERIC_ATOMIC64)
+	depends on QCOM_SCM=y
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_LPAE
 	select ARM_DMA_USE_IOMMU
diff --git a/drivers/net/wireless/ath/ath10k/Kconfig b/drivers/net/wireless/ath/ath10k/Kconfig
index 40f91bc8514d8..a490e78890017 100644
--- a/drivers/net/wireless/ath/ath10k/Kconfig
+++ b/drivers/net/wireless/ath/ath10k/Kconfig
@@ -44,6 +44,7 @@ config ATH10K_SNOC
 	tristate "Qualcomm ath10k SNOC support"
 	depends on ATH10K
 	depends on ARCH_QCOM || COMPILE_TEST
+	depends on QCOM_QCM || !QCOM_SCM #if QCOM_SCM=m this can't be =y
 	select QCOM_QMI_HELPERS
 	help
 	  This module adds support for integrated WCN3990 chip connected
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
