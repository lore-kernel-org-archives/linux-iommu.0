Return-Path: <SRS0=4FG6=EM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9AFC2D0A3
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 04:27:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E8162075A
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 04:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="riyHAwyP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E8162075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id DA584870F6;
	Fri,  6 Nov 2020 04:27:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VWgyn7xSBHge; Fri,  6 Nov 2020 04:27:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 35A8987260;
	Fri,  6 Nov 2020 04:27:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 160ADC0893;
	Fri,  6 Nov 2020 04:27:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB96DC0889
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 04:27:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 995A384331
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 04:27:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mwasx5OYckUq for <iommu@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 04:27:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 099B18435A
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 04:27:16 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id c20so145472pfr.8
 for <iommu@lists.linux-foundation.org>; Thu, 05 Nov 2020 20:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6GAtoi0gVMYIKFbxsRQ9yjVpGK0SYChEDBpydmhHoW4=;
 b=riyHAwyPJJRJ3tCsc6zGAB3UC/1B1HExo9jctZcDGkiQmEILAD4mHJnvIqCCBXsvag
 jmfG8D9uSkGQY5+U2dsPWpj61pnEDFVn3HAkearWhUl2K5jBqcYRyV1sMGmx1oMDtfJF
 mZskj0bXc/q19E8VUxQVa9P99B87zbTMnHhmECAccREzO65Y0/1GcgzKjoQ28tFJ5VX7
 bvEwiRT2+RSKz3UmFe0PnrJYENQCJnTJFycA35xYumjVo2SSQxPr00KUvDDy374cBc/M
 aB+jrtSAyl9KqJF/B/rDyLrazqv8iK1yQu2v0qI3g+VlLpz3+kM6bTedAeO/xxSQ/6aG
 ZJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=6GAtoi0gVMYIKFbxsRQ9yjVpGK0SYChEDBpydmhHoW4=;
 b=Xn3BbS5tJak6vaoPBoXahiXuBnw+AFWDAtdBLRXtaQALANCxeV7TMYaqqgswqSW/Li
 4fTXLJNr1FvtlZogWoXvP5cyqrgDNkToxN8TpyLIt5jxauGX3S75CGkGJ1soOona4L3u
 3tHcjpCLyrPBscWCxpkMlgDUZTbgyfYWmUozN0NmKZRck4htCjfwSBtOfJFNvjQtjnwS
 CIzMGhEYuxg0f9ZfZbBN40iMZra7f8jq0uwHnOBFLU7MpirbvgPJ+Ot5O3sGYku/jHeF
 4ToDIWifnMiVvkGIHOc2vuCo7ycU3/OgDaT1c0koLVD9t7m90dEo8YIlj7j9XcuLPHBW
 QWOQ==
X-Gm-Message-State: AOAM533DPjfyOzfHn6XgKn3IEhTE7HJYrSX/3uoKXun1V17aspyHuOUc
 oWpQly5gZ+3oFegyF62hVKdXFg==
X-Google-Smtp-Source: ABdhPJwIfqzQs0Hz0ONJ2Cwc9narnnGapHKO01mr7EPFz2YXkckIhaGBz/VTvcX3yWfrD8ZnI2B/Lw==
X-Received: by 2002:a17:90b:602:: with SMTP id gb2mr387639pjb.12.1604636835693; 
 Thu, 05 Nov 2020 20:27:15 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
 by smtp.gmail.com with ESMTPSA id
 e24sm179864pfl.149.2020.11.05.20.27.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 20:27:15 -0800 (PST)
From: John Stultz <john.stultz@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 2/3] pinctrl: qcom: Allow pinctrl-msm code to be loadable
 as a module
Date: Fri,  6 Nov 2020 04:27:09 +0000
Message-Id: <20201106042710.55979-2-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201106042710.55979-1-john.stultz@linaro.org>
References: <20201106042710.55979-1-john.stultz@linaro.org>
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
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
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
v6:
* Split PINCTRL_MSM dependency bit out into its own patch
---
 drivers/pinctrl/qcom/Kconfig       | 3 ++-
 drivers/pinctrl/qcom/pinctrl-msm.c | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index c9bb2d9e49d47..8bb786ed152dd 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -2,7 +2,8 @@
 if (ARCH_QCOM || COMPILE_TEST)
 
 config PINCTRL_MSM
-	bool "Qualcomm core pin controller driver"
+	tristate "Qualcomm core pin controller driver"
+	depends on QCOM_SCM || !QCOM_SCM #if QCOM_SCM=m this can't be =y
 	select PINMUX
 	select PINCONF
 	select GENERIC_PINCONF
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
