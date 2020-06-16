Return-Path: <SRS0=6LHv=75=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D168CC433E4
	for <iommu@archiver.kernel.org>; Tue, 16 Jun 2020 06:13:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A63432074D
	for <iommu@archiver.kernel.org>; Tue, 16 Jun 2020 06:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HS2MKGAs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A63432074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7EFFC89533;
	Tue, 16 Jun 2020 06:13:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 18NQXh20X-1Q; Tue, 16 Jun 2020 06:13:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id BDEAA8952A;
	Tue, 16 Jun 2020 06:13:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92D27C0892;
	Tue, 16 Jun 2020 06:13:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45391C016E
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 06:13:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 27358876A3
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 06:13:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nnp_-Bq5-vWg for <iommu@lists.linux-foundation.org>;
 Tue, 16 Jun 2020 06:13:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
 [209.85.214.196])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6853D876A1
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 06:13:46 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id n2so7901375pld.13
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 23:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=M2uJULnvxDpfHs89lgaTRTB9rey6NHbhAifKB1x72gQ=;
 b=HS2MKGAsNdjUxJ+yy27jcpiH1bk7koug2OAXwLJHoTgucSozWnIJSObeAki8dM05am
 DLCS+qX0P1LSqKwIln1ckxouXz0KbXo3o0tpFiRBYmK+NPiqKE6pDzuqc9M+Woh0UQ59
 0qIqzR0HzmFta9njqekXv2RYydZQgrYMTxUNtcLireoA0iUhs07M+xTESQi6DDO/vBQo
 bSM6fZK5iqdLi0jpB6PQWvFyk1ti/AJVyzKrfiIVqCShGFceJ3mF8PFRVhuFFpNV+gJ8
 6/V4j3vwecDwCtqKeIWENohJF3zGujG5GiKGDkkY7rGGOJZOxBk/IL493YOcEiEuhVBI
 PAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=M2uJULnvxDpfHs89lgaTRTB9rey6NHbhAifKB1x72gQ=;
 b=M3YKHk7ZAndqvRP7loghwbH7OGjZBpy4lpaQox14o+lp0gXC6ATepLVCYCUTUuimao
 l1aifAdeEclM009+ZvQ95n9o8emajfPiMiJnp83VgXkXgZcAxfEkAClYDHiWB0ThyixE
 ZtQlY6s01u+MoaLN07OYrd8uGhdK1+uryBGYwd5jcGd3gz4uD+Si44VHCbmzzQZ9JLbt
 ZPPEdTmj4wXbIIbXaw8C3MwBB4ZqN+crTqC7xHfN3TAkNfNObuJysMAbhoXJJilhMBEZ
 sgbxcfV5n754oWb3EtdOUpi6w81kivt8hyruZ5ETYUXg9j4QstSxxeuQoHa2kLbD6Ysa
 3zLg==
X-Gm-Message-State: AOAM533DdfluPM5xVxmYoNg3LUj76uRB5OKG14HIjfedZH64GfbU67fH
 C8jU67Lg+vRXrsD3U1ym5E0EGw==
X-Google-Smtp-Source: ABdhPJw2m1e+LDbBPxO7NdX9TwT/7AlJxXRrPGMYRWdq75cFQWSCTf4uPSRnj0rAwyp+oCkFUZF2jQ==
X-Received: by 2002:a17:90b:238d:: with SMTP id
 mr13mr1308289pjb.19.1592288025969; 
 Mon, 15 Jun 2020 23:13:45 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
 by smtp.gmail.com with ESMTPSA id
 i26sm15642032pfo.0.2020.06.15.23.13.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2020 23:13:45 -0700 (PDT)
From: John Stultz <john.stultz@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH 3/5] irqchip: Allow QCOM_PDC to be loadable as a perment
 module
Date: Tue, 16 Jun 2020 06:13:36 +0000
Message-Id: <20200616061338.109499-4-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616061338.109499-1-john.stultz@linaro.org>
References: <20200616061338.109499-1-john.stultz@linaro.org>
Cc: Jason Cooper <jason@lakedaemon.net>, Saravana Kannan <saravanak@google.com>,
 Marc Zyngier <maz@kernel.org>, Lina Iyer <ilina@codeaurora.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, linux-gpio@vger.kernel.org,
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

Allows qcom-pdc driver to be loaded as a permenent module

Also, due to the fact that IRQCHIP_DECLARE becomes a no-op when
building as a module, we have to add the platform driver hooks
explicitly.

Thanks to Saravana for his help on pointing out the
IRQCHIP_DECLARE issue and guidance on a solution.

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Lina Iyer <ilina@codeaurora.org>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: iommu@lists.linux-foundation.org
Cc: linux-gpio@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/irqchip/Kconfig    |  2 +-
 drivers/irqchip/qcom-pdc.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 29fead208cad..12765bed08f9 100644
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
index 6ae9e1f0819d..98d74160afcd 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -11,7 +11,9 @@
 #include <linux/irqdomain.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_irq.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/soc/qcom/irq.h>
@@ -430,4 +432,32 @@ static int qcom_pdc_init(struct device_node *node, struct device_node *parent)
 	return ret;
 }
 
+#ifdef MODULE
+static int qcom_pdc_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *parent = of_irq_find_parent(np);
+
+	return qcom_pdc_init(np, parent);
+}
+
+static const struct of_device_id qcom_pdc_match_table[] = {
+	{ .compatible = "qcom,pdc" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, qcom_pdc_match_table);
+
+static struct platform_driver qcom_pdc_driver = {
+	.probe = qcom_pdc_probe,
+	.driver = {
+		.name = "qcom-pdc",
+		.of_match_table = qcom_pdc_match_table,
+	},
+};
+module_platform_driver(qcom_pdc_driver);
+#else
 IRQCHIP_DECLARE(qcom_pdc, "qcom,pdc", qcom_pdc_init);
+#endif
+
+MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Power Domain Controller");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
