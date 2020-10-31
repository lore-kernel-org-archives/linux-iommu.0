Return-Path: <SRS0=4X9E=EG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F026DC388F9
	for <iommu@archiver.kernel.org>; Sat, 31 Oct 2020 00:38:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BCC722249
	for <iommu@archiver.kernel.org>; Sat, 31 Oct 2020 00:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ps71XmrU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BCC722249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1318186FF8;
	Sat, 31 Oct 2020 00:38:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2c9L0qWVBKb6; Sat, 31 Oct 2020 00:38:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E71B686FEC;
	Sat, 31 Oct 2020 00:38:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DAAC3C088B;
	Sat, 31 Oct 2020 00:38:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF8C9C0051
 for <iommu@lists.linux-foundation.org>; Sat, 31 Oct 2020 00:38:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DDB9187128
 for <iommu@lists.linux-foundation.org>; Sat, 31 Oct 2020 00:38:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m_UwqnDB_5Zx for <iommu@lists.linux-foundation.org>;
 Sat, 31 Oct 2020 00:38:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com
 [209.85.214.195])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 72D6887122
 for <iommu@lists.linux-foundation.org>; Sat, 31 Oct 2020 00:38:48 +0000 (UTC)
Received: by mail-pl1-f195.google.com with SMTP id x23so3808218plr.6
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 17:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=fRP7cJ5L9qywDd+4VkqnGxZHnY4SVj+l7aHtmBT05eI=;
 b=ps71XmrUfzScD09MFXehuBKyrAHVIGcfSHpsj4eBRrsSt3EbKCi1tVtOkB2LN5CSaj
 t8sOvx6P7VsImudMQdX2uQEmwZpZ8gDZWeIO3KU+E+bCcH7mrpHPTxBYLzqanN2huhSM
 2BgijhwSZzkUNn+/1bL6rn/l09g+ztJn0gJokxzP5T5vWRKVEHZdIcr+mdsFZtT7DQHx
 hh1uTCbK8wnEO476xcAQ0piaTjaTw3AlXsrT1Tz4kvxQzgpscz55q8Bk7Ht/KyJ34iw6
 42/e6GQQkOyAeC0MI7NeXS/x0vqXoktgXQf7sSkALGFTEhFWfEMNlHdkxWyldnzMroIB
 zHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=fRP7cJ5L9qywDd+4VkqnGxZHnY4SVj+l7aHtmBT05eI=;
 b=J1NJX75XW/kAxxKMnWtR5eHgcqhndM5f0uYU5Nncn5Bc+yLeB82CAbd2rvaylFNn/e
 Yyx5GPVAWnTHqAr0XS8Lsx4oADgq7aJLkJV3A6Ad6Ol+SSgeQcGJZBPovFVJjUOHZ9Hz
 qrJQKsdG/QPaoGnl5SSSkhav0qHmKu6/GwtIvahVK/ZIfuHG5EvttoxkIUQ49vvi8grN
 c/2jOHhin/Rh/7aJvRH3vm43yrYzwyT2tjMHvGAw09ZhrJcS1cnTJqjAvSwf+HsgLOnT
 fmYTBi5gKAu1hwwKeKk6UPZKJsay5NZmzUHY8PWT5lBthomZOSdpKNM3D361l2InaboN
 O8ZA==
X-Gm-Message-State: AOAM530RZ4b5o0+8s554hl1kDEuOxUGRvPbpWMtue0BBP32X7V1H2KxN
 yrCuyp1Mu90U102wJfoP04boWA==
X-Google-Smtp-Source: ABdhPJwP8S5X6yFPDFdhknWzf+qZQTQUkPXuI9NISrUbISUo/+HgKSFyZB3hKhFYc2o4mlzXBjgn5g==
X-Received: by 2002:a17:902:c1d2:b029:d3:ea72:cdec with SMTP id
 c18-20020a170902c1d2b02900d3ea72cdecmr11482108plc.47.1604104728036; 
 Fri, 30 Oct 2020 17:38:48 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
 by smtp.gmail.com with ESMTPSA id
 z16sm7074509pfq.33.2020.10.30.17.38.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 17:38:47 -0700 (PDT)
From: John Stultz <john.stultz@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 1/2] pinctrl: qcom: Allow pinctrl-msm code to be loadable
 as a module
Date: Sat, 31 Oct 2020 00:38:44 +0000
Message-Id: <20201031003845.41137-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Cc: Maulik Shah <mkshah@codeaurora.org>, Jason Cooper <jason@lakedaemon.net>,
 Saravana Kannan <saravanak@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, iommu@lists.linux-foundation.org,
 Lina Iyer <ilina@codeaurora.org>, linux-gpio@vger.kernel.org,
 Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
 John Stultz <john.stultz@linaro.org>, Marc Zyngier <maz@kernel.org>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Tweaks to allow pinctrl-msm code to be loadable as a module.

This is needed in order to support having the qcom-scm driver,
which pinctrl-msm calls into, configured as a module.

This requires that we tweak Kconfigs selecting PINCTRL_MSM to
also depend on QCOM_SCM || QCOM_SCM=n so that we match the
module setting of QCOM_SCM.

Unlike the previous revision of this patch:
  https://lore.kernel.org/lkml/20200625001039.56174-5-john.stultz@linaro.org/
this version reworks PINCTRL_MSM to be a visible option and
instead of having the various SoC specific drivers select
PINCTRL_MSM, this switches those configs to depend on
PINCTRL_MSM. This avoids adding the oddish looking:
  "depend on QCOM_SCM || QCOM_SCM=n"
to every SoC specific driver, as that becomes a maintenance
headache.

We also add PINCTRL_MSM to the arm64 defconfig to avoid
surprises as otherwise PINCTRL_MSM/IPQ* options previously
enabled, will be off.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: Maulik Shah <mkshah@codeaurora.org>
Cc: Lina Iyer <ilina@codeaurora.org>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: iommu@lists.linux-foundation.org
Cc: linux-gpio@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v2:
* Module description and whitespace fixes suggested by Bjorn
* Added QCOM_SCM || QCOM_SCM=n bits on Kconfigs selecting
  PINCTRL_MSM. Reported by both Todd and Bjorn.
v3:
* Make sure the QCOM_SCM || QCOM_SCM=n trick is commented
v4:
* Rework "select PINCTRL_MSM" to "depends on PINCTRL_MSM"
  to consolidate the QCOM_SCM dependency.
v5:
* Add PINCTRL_MSM to arm64 defconfig
---
 arch/arm64/configs/defconfig       |  1 +
 drivers/pinctrl/qcom/Kconfig       | 49 +++++++++++++++---------------
 drivers/pinctrl/qcom/pinctrl-msm.c |  2 ++
 3 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 17a2df6a263e8..45768828fdb8e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -483,6 +483,7 @@ CONFIG_PINCTRL_IMX8MP=y
 CONFIG_PINCTRL_IMX8MQ=y
 CONFIG_PINCTRL_IMX8QXP=y
 CONFIG_PINCTRL_IMX8DXL=y
+CONFIG_PINCTRL_MSM=y
 CONFIG_PINCTRL_IPQ8074=y
 CONFIG_PINCTRL_IPQ6018=y
 CONFIG_PINCTRL_MSM8916=y
diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 5fe7b8aaf69d8..8bb786ed152dd 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -2,7 +2,8 @@
 if (ARCH_QCOM || COMPILE_TEST)
 
 config PINCTRL_MSM
-	bool
+	tristate "Qualcomm core pin controller driver"
+	depends on QCOM_SCM || !QCOM_SCM #if QCOM_SCM=m this can't be =y
 	select PINMUX
 	select PINCONF
 	select GENERIC_PINCONF
@@ -13,7 +14,7 @@ config PINCTRL_MSM
 config PINCTRL_APQ8064
 	tristate "Qualcomm APQ8064 pin controller driver"
 	depends on GPIOLIB && OF
-	select PINCTRL_MSM
+	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
 	  Qualcomm TLMM block found in the Qualcomm APQ8064 platform.
@@ -21,7 +22,7 @@ config PINCTRL_APQ8064
 config PINCTRL_APQ8084
 	tristate "Qualcomm APQ8084 pin controller driver"
 	depends on GPIOLIB && OF
-	select PINCTRL_MSM
+	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
 	  Qualcomm TLMM block found in the Qualcomm APQ8084 platform.
@@ -29,7 +30,7 @@ config PINCTRL_APQ8084
 config PINCTRL_IPQ4019
 	tristate "Qualcomm IPQ4019 pin controller driver"
 	depends on GPIOLIB && OF
-	select PINCTRL_MSM
+	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
 	  Qualcomm TLMM block found in the Qualcomm IPQ4019 platform.
@@ -37,7 +38,7 @@ config PINCTRL_IPQ4019
 config PINCTRL_IPQ8064
 	tristate "Qualcomm IPQ8064 pin controller driver"
 	depends on GPIOLIB && OF
-	select PINCTRL_MSM
+	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
 	  Qualcomm TLMM block found in the Qualcomm IPQ8064 platform.
@@ -45,7 +46,7 @@ config PINCTRL_IPQ8064
 config PINCTRL_IPQ8074
 	tristate "Qualcomm Technologies, Inc. IPQ8074 pin controller driver"
 	depends on GPIOLIB && OF
-	select PINCTRL_MSM
+	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for
 	  the Qualcomm Technologies Inc. TLMM block found on the
@@ -55,7 +56,7 @@ config PINCTRL_IPQ8074
 config PINCTRL_IPQ6018
 	tristate "Qualcomm Technologies, Inc. IPQ6018 pin controller driver"
 	depends on GPIOLIB && OF
-	select PINCTRL_MSM
+	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for
 	  the Qualcomm Technologies Inc. TLMM block found on the
@@ -65,7 +66,7 @@ config PINCTRL_IPQ6018
 config PINCTRL_MSM8226
 	tristate "Qualcomm 8226 pin controller driver"
 	depends on GPIOLIB && OF
-	select PINCTRL_MSM
+	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
 	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
@@ -74,7 +75,7 @@ config PINCTRL_MSM8226
 config PINCTRL_MSM8660
 	tristate "Qualcomm 8660 pin controller driver"
 	depends on GPIOLIB && OF
-	select PINCTRL_MSM
+	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
 	  Qualcomm TLMM block found in the Qualcomm 8660 platform.
@@ -82,7 +83,7 @@ config PINCTRL_MSM8660
 config PINCTRL_MSM8960
 	tristate "Qualcomm 8960 pin controller driver"
 	depends on GPIOLIB && OF
-	select PINCTRL_MSM
+	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
 	  Qualcomm TLMM block found in the Qualcomm 8960 platform.
@@ -90,7 +91,7 @@ config PINCTRL_MSM8960
 config PINCTRL_MDM9615
 	tristate "Qualcomm 9615 pin controller driver"
 	depends on GPIOLIB && OF
-	select PINCTRL_MSM
+	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
 	  Qualcomm TLMM block found in the Qualcomm 9615 platform.
@@ -98,7 +99,7 @@ config PINCTRL_MDM9615
 config PINCTRL_MSM8X74
 	tristate "Qualcomm 8x74 pin controller driver"
 	depends on GPIOLIB && OF
-	select PINCTRL_MSM
+	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
 	  Qualcomm TLMM block found in the Qualcomm 8974 platform.
@@ -106,7 +107,7 @@ config PINCTRL_MSM8X74
 config PINCTRL_MSM8916
 	tristate "Qualcomm 8916 pin controller driver"
 	depends on GPIOLIB && OF
-	select PINCTRL_MSM
+	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
 	  Qualcomm TLMM block found on the Qualcomm 8916 platform.
@@ -114,7 +115,7 @@ config PINCTRL_MSM8916
 config PINCTRL_MSM8976
 	tristate "Qualcomm 8976 pin controller driver"
 	depends on GPIOLIB && OF
-	select PINCTRL_MSM
+	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
 	  Qualcomm TLMM block found on the Qualcomm MSM8976 platform.
@@ -124,7 +125,7 @@ config PINCTRL_MSM8976
 config PINCTRL_MSM8994
 	tristate "Qualcomm 8994 pin controller driver"
 	depends on GPIOLIB && OF
-	select PINCTRL_MSM
+	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
 	  Qualcomm TLMM block found in the Qualcomm 8994 platform. The
@@ -133,7 +134,7 @@ config PINCTRL_MSM8994
 config PINCTRL_MSM8996
 	tristate "Qualcomm MSM8996 pin controller driver"
 	depends on GPIOLIB && OF
-	select PINCTRL_MSM
+	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
 	  Qualcomm TLMM block found in the Qualcomm MSM8996 platform.
@@ -141,7 +142,7 @@ config PINCTRL_MSM8996
 config PINCTRL_MSM8998
 	tristate "Qualcomm MSM8998 pin controller driver"
 	depends on GPIOLIB && OF
-	select PINCTRL_MSM
+	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
 	  Qualcomm TLMM block found in the Qualcomm MSM8998 platform.
@@ -149,7 +150,7 @@ config PINCTRL_MSM8998
 config PINCTRL_QCS404
 	tristate "Qualcomm QCS404 pin controller driver"
 	depends on GPIOLIB && OF
-	select PINCTRL_MSM
+	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
 	  TLMM block found in the Qualcomm QCS404 platform.
@@ -157,7 +158,7 @@ config PINCTRL_QCS404
 config PINCTRL_QDF2XXX
 	tristate "Qualcomm Technologies QDF2xxx pin controller driver"
 	depends on GPIOLIB && ACPI
-	select PINCTRL_MSM
+	depends on PINCTRL_MSM
 	help
 	  This is the GPIO driver for the TLMM block found on the
 	  Qualcomm Technologies QDF2xxx SOCs.
@@ -194,7 +195,7 @@ config PINCTRL_QCOM_SSBI_PMIC
 config PINCTRL_SC7180
 	tristate "Qualcomm Technologies Inc SC7180 pin controller driver"
 	depends on GPIOLIB && OF
-	select PINCTRL_MSM
+	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
 	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
@@ -203,7 +204,7 @@ config PINCTRL_SC7180
 config PINCTRL_SDM660
 	tristate "Qualcomm Technologies Inc SDM660 pin controller driver"
 	depends on GPIOLIB && OF
-	select PINCTRL_MSM
+	depends on PINCTRL_MSM
 	help
 	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
 	 Qualcomm Technologies Inc TLMM block found on the Qualcomm
@@ -212,7 +213,7 @@ config PINCTRL_SDM660
 config PINCTRL_SDM845
 	tristate "Qualcomm Technologies Inc SDM845 pin controller driver"
 	depends on GPIOLIB && (OF || ACPI)
-	select PINCTRL_MSM
+	depends on PINCTRL_MSM
 	help
 	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
 	 Qualcomm Technologies Inc TLMM block found on the Qualcomm
@@ -221,7 +222,7 @@ config PINCTRL_SDM845
 config PINCTRL_SM8150
 	tristate "Qualcomm Technologies Inc SM8150 pin controller driver"
 	depends on GPIOLIB && OF
-	select PINCTRL_MSM
+	depends on PINCTRL_MSM
 	help
 	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
 	 Qualcomm Technologies Inc TLMM block found on the Qualcomm
@@ -230,7 +231,7 @@ config PINCTRL_SM8150
 config PINCTRL_SM8250
 	tristate "Qualcomm Technologies Inc SM8250 pin controller driver"
 	depends on GPIOLIB && OF
-	select PINCTRL_MSM
+	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
 	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index c4bcda90aac4a..988343ac49b92 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -1443,3 +1443,5 @@ int msm_pinctrl_remove(struct platform_device *pdev)
 }
 EXPORT_SYMBOL(msm_pinctrl_remove);
 
+MODULE_DESCRIPTION("Qualcomm Technologies, Inc. TLMM driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
