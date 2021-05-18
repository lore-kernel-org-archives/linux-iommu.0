Return-Path: <SRS0=LVl/=KN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713E8C43460
	for <iommu@archiver.kernel.org>; Tue, 18 May 2021 21:19:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05FE96135D
	for <iommu@archiver.kernel.org>; Tue, 18 May 2021 21:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05FE96135D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BC42A40545;
	Tue, 18 May 2021 21:19:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XpVMihKk0u-9; Tue, 18 May 2021 21:19:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4198440343;
	Tue, 18 May 2021 21:19:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28E7AC000D;
	Tue, 18 May 2021 21:19:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE274C0001
 for <iommu@lists.linux-foundation.org>; Tue, 18 May 2021 21:19:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B1927403A3
 for <iommu@lists.linux-foundation.org>; Tue, 18 May 2021 21:19:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g0I1nRoGvImZ for <iommu@lists.linux-foundation.org>;
 Tue, 18 May 2021 21:19:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 842F440343
 for <iommu@lists.linux-foundation.org>; Tue, 18 May 2021 21:19:27 +0000 (UTC)
Received: by mail-pf1-x436.google.com with SMTP id c17so8380696pfn.6
 for <iommu@lists.linux-foundation.org>; Tue, 18 May 2021 14:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=x0WkbtRSug5KygkEOcSY00slsWucZ8pGUhHWfcZvJLw=;
 b=XoJTI+h6COw5nb4jNXCTBjTFUxOWTdZPBsDhW1Vf5td+5titolSU5hwv0P5QyvJ36G
 +86v7ei0+4gD2Gm6e36pye7sr3DWPDnoF+3e57cxlVxRb/ij4tTdNGoGQcoHR0VmQmFB
 tTRcMD7Qxn4jPS6/sUFRfoDJc2iYEUEGZboioaT5lVKyiMrACIGwlYDlCzlynSbEEvMc
 bGKqmeGo/ICR02ASBae5INu4+FrYCZ4tw1xSz2W8DZtry+lL/4gCZBAqb8CAaRD+feb7
 /asuJN5NVOjHTir3u8XDI0jW0ewNgV8zxqTKWm+RCha+SxkufsoiuCeD9LIfeLnDMaEE
 YjQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=x0WkbtRSug5KygkEOcSY00slsWucZ8pGUhHWfcZvJLw=;
 b=MNZ8zf4/vfGAO2oiGg0G7M3B8tU8himsxDI1toagiAjFzIuXlBMQ+KdcomiRVq3RE4
 SeCvd08fZqyDuPUae0JgKCdWwkNU5qrC39adyiMvp1wFnSMCIfMFTBihyOUCxoJRBPIG
 iX8XUKCu2jRwWggVOV91oF7PwaFlTN5tb3Lhcsfb8RD7Pfx7/nwRnvIHzh6kHlZNGZHc
 AQoobt51YTen7x9pgSMGajTIBD3ZpFymRk0nEJPG/2q1p+OjwnU1vzInf95ORaKrNt+C
 //7m3A0JnZWsPw08OtRIb1y3kuU1SpCyv0O1qF8j7k/ihOw3QHhFnV/2pfJD+QUYWbER
 zcsA==
X-Gm-Message-State: AOAM531QeXzvWdsn5L8o1YAwEbbbVyM4XeUw55SkPxTCpm6GyZnvZfiR
 kI5xKn9ZCiHrOZ9CN/1TsMCqzQ==
X-Google-Smtp-Source: ABdhPJxHzgg/sDP+AXuLGVUb+sszrOlNtS/1ESyTlJlqL+kEGm+M9oruAN8GSnqVJZjl79LXwnDIqg==
X-Received: by 2002:a63:f40e:: with SMTP id g14mr7070371pgi.402.1621372766908; 
 Tue, 18 May 2021 14:19:26 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
 by smtp.gmail.com with ESMTPSA id
 g89sm2587199pjg.30.2021.05.18.14.19.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 May 2021 14:19:26 -0700 (PDT)
From: John Stultz <john.stultz@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] irqchip/qcom-pdc: Switch to IRQCHIP_PLATFORM_DRIVER and
 allow as a module
Date: Tue, 18 May 2021 21:19:21 +0000
Message-Id: <20210518211922.3474368-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Saravana Kannan <saravanak@google.com>

This patch revives changes from Saravana Kannan to switch the
qcom-pdc driver to use IRQCHIP_PLATFORM_DRIVER helper macros,
and allows qcom-pdc driver to be loaded as a permanent module.

Earlier attempts at this ran into trouble with loading
dependencies, but with Saravana's fw_devlink=on set by default
now we should avoid those.

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
Signed-off-by: Saravana Kannan <saravanak@google.com>
[jstultz: Folded in with my changes to allow the driver to be
 loadable as a permenent module]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/irqchip/Kconfig    | 2 +-
 drivers/irqchip/qcom-pdc.c | 8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index b90e825df7e14..d4a0b4964ccc5 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -415,7 +415,7 @@ config GOLDFISH_PIC
          for Goldfish based virtual platforms.
 
 config QCOM_PDC
-	bool "QCOM PDC"
+	tristate "QCOM PDC"
 	depends on ARCH_QCOM
 	select IRQ_DOMAIN_HIERARCHY
 	help
diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index 5dc63c20b67ea..32d59202d408d 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -11,9 +11,11 @@
 #include <linux/irqdomain.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
+#include <linux/of_irq.h>
 #include <linux/soc/qcom/irq.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
@@ -459,4 +461,8 @@ static int qcom_pdc_init(struct device_node *node, struct device_node *parent)
 	return ret;
 }
 
-IRQCHIP_DECLARE(qcom_pdc, "qcom,pdc", qcom_pdc_init);
+IRQCHIP_PLATFORM_DRIVER_BEGIN(qcom_pdc)
+IRQCHIP_MATCH("qcom,pdc", qcom_pdc_init)
+IRQCHIP_PLATFORM_DRIVER_END(qcom_pdc)
+MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Power Domain Controller");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
