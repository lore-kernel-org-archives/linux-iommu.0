Return-Path: <SRS0=C6HT=CX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960D0C2BBD1
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 21:04:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2836C215A4
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 21:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QIZLLxWu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2836C215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A6967864B2;
	Mon, 14 Sep 2020 21:04:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w-sO-LGp4+zx; Mon, 14 Sep 2020 21:04:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D227786489;
	Mon, 14 Sep 2020 21:04:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99833C0864;
	Mon, 14 Sep 2020 21:04:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9FD94C0051
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 21:04:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8D12A864A0
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 21:04:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c6ozTIwUfrra for <iommu@lists.linux-foundation.org>;
 Mon, 14 Sep 2020 21:04:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
 [209.85.214.196])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BD66786489
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 21:04:35 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id j7so122844plk.11
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 14:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=B+yZcshbsoNrjw9/GyoZ6sfB8u3DeY+uiG54+fPG2CA=;
 b=QIZLLxWuhPfcEVva2nJ767qbObasCjM9V8Jb31/dgJYJjdusHNi8YJsv5gLnNFQ7Yc
 rLHu37Wddk1sIpLHa0uP3I2h9zA71vHPOqj0TBgvBDuJtNcIpUFN3mpmixq4QM8rTCJd
 5RQ6lPaeIlVGNC4K+e1WheYhHnFTvAshW+15lTv/zvbez9g3zYXzhh8MmXmOP/82L8EE
 Kf9PqYHd0cb8gb3Y/GDOZ4tGCV6XOqLSlkPmMblYk+Rl4KQkPGqxbCFqXTzaLci5PVLj
 WJx4XXmmmHz8fepTSyu12BiVF7duEd/kPijfysMl56mAUi9m8XaYBKLjFDMSCx0duFR3
 9e9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=B+yZcshbsoNrjw9/GyoZ6sfB8u3DeY+uiG54+fPG2CA=;
 b=P+9/NjOAyrAU2cM/Ha4zRNqdFmd2rGck6EVpe//tFJskjmrYQWZlQ521wY+FXKtn0/
 ghTOy1iq1WfpuBVmaCAZBj6YhE0dIqMl47oJ9vTgS/YNns0Zf+iwHmbQ0/eOHzO0Ijg4
 aA24SgFqrAhRze0Nh2LC97DapyNoX78Y5I9EzzwPamfPlMW8SujvCaigDW7RKoiOIii2
 pyJkN8SA7bkmQDSOlvDKS6Tu/h628xBrL9SNxfIdPiURxY3f5yPkogmXm7wPW6DvZhnp
 8rvPoSdDxzLPt4Ylpoq1xsmIh84ALSFRbboh+DxZgLPW9Gs6Ed2QHio7qvbev2YQMn2G
 CGdQ==
X-Gm-Message-State: AOAM5303dTWjnXOZi461iGkFTrZU9RVHUybJKj92JzkX7S2TRX+zIdKC
 yMHsqWlVLDD90BA5IBH9lLfnnw==
X-Google-Smtp-Source: ABdhPJw4meDLhT1GWDTqYGlWuh5s5sZygb+syXL21fk3JYEchsaLbg8+bnuLLk7x6vlu2XvHtk24cQ==
X-Received: by 2002:a17:90a:e513:: with SMTP id
 t19mr1080297pjy.137.1600117475340; 
 Mon, 14 Sep 2020 14:04:35 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
 by smtp.gmail.com with ESMTPSA id
 n9sm11222480pfu.163.2020.09.14.14.04.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 14:04:34 -0700 (PDT)
From: John Stultz <john.stultz@linaro.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] irqchip/qcom-pdc: Allow QCOM_PDC to be loadable as a
 permanent module
Date: Mon, 14 Sep 2020 21:04:23 +0000
Message-Id: <20200914210423.67579-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200912125148.1271481-7-maz@kernel.org>
References: <20200912125148.1271481-7-maz@kernel.org>
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

Allows qcom-pdc driver to be loaded as a permanent module.

An earlier version of this patch was merged in a larger patchset
but was reverted entirely when issues were found with other
drivers, so now that Marc has provided a better solution in his
Hybrid probing patch set, I wanted to re-submit this change.

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
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/irqchip/Kconfig    | 2 +-
 drivers/irqchip/qcom-pdc.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index bfc9719dbcdc..bb70b7177f94 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -425,7 +425,7 @@ config GOLDFISH_PIC
          for Goldfish based virtual platforms.
 
 config QCOM_PDC
-	bool "QCOM PDC"
+	tristate "QCOM PDC"
 	depends on ARCH_QCOM
 	select IRQ_DOMAIN_HIERARCHY
 	help
diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index 8543fa23da10..59eb3c8473b0 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -433,3 +433,5 @@ static int qcom_pdc_init(struct device_node *node, struct device_node *parent)
 IRQCHIP_HYBRID_DRIVER_BEGIN(qcom_pdc)
 IRQCHIP_MATCH("qcom,pdc", qcom_pdc_init)
 IRQCHIP_HYBRID_DRIVER_END(qcom_pdc)
+MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Power Domain Controller");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
