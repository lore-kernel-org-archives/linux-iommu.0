Return-Path: <SRS0=Yw80=4G=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03E8C3404D
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 17:13:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAF2B2176D
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 17:13:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF2B2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 926CA204A5;
	Tue, 18 Feb 2020 17:13:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wf339sM+8CgO; Tue, 18 Feb 2020 17:13:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 85657204B8;
	Tue, 18 Feb 2020 17:13:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7DF1BC013E;
	Tue, 18 Feb 2020 17:13:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56FD2C013E
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 17:13:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4029E85064
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 17:13:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fTEz-yUkTEcC for <iommu@lists.linux-foundation.org>;
 Tue, 18 Feb 2020 17:13:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
 [209.85.210.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8695786092
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 17:13:29 +0000 (UTC)
Received: by mail-ot1-f65.google.com with SMTP id p8so20189821oth.10
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 09:13:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=W1u4wUo3NLYAMgXHhQ1JWTN6DImeyb7sdgcLty9LTVA=;
 b=f5bPq5uFjEYREj8IieTfchFGypBciV//WXlnk0d8PMfG/OUOW4J2JvFOSOpzXpbtsM
 4zvBWhgC7SzRfD0NA38PpWRS+jDpD80dUWpKUw3W4E2Jl+jGZl2O0UDb9FAxKPnQaxGY
 sFoqDG1tnBT0iKqs1s5mjWYXTiO3Eq0tZ47RtkW6HN6VyZ+P7jbtytScHpBUxVtWuADJ
 bJYHeQpuuuvGi02qlXM/2fm8Z4abwvSAO8rimPgOSy7qEH4E7+CNB87scFqDYMdWe/fC
 eWWcItIas+VBNTBVHBk748jrvkerKzFDTIbBmQC80X1Stab2bs7enDsKF/J522e9NUk+
 W9kA==
X-Gm-Message-State: APjAAAXwfzUO8mMHdVbgYvkpvhs1XrJjyQLktrpVqYJpiGo2561FSoU0
 H7MVR+rRGL/HdtoHCxpoVw==
X-Google-Smtp-Source: APXvYqz9vN5O196Hv3RX5j5QhodRWeWR1h2DBkM3xAqkcK92U7nZEFBLzVra3Zyy0nvATVFM6CGklA==
X-Received: by 2002:a9d:7a89:: with SMTP id l9mr15588431otn.228.1582046008709; 
 Tue, 18 Feb 2020 09:13:28 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id y25sm1545755oto.27.2020.02.18.09.13.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 09:13:28 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 soc@kernel.org, Andre Przywara <andre.przywara@arm.com>,
 Robert Richter <rrichter@marvell.com>, Jon Loeliger <jdl@jdl.com>,
 Alexander Graf <graf@amazon.com>, Matthias Brugger <mbrugger@suse.com>,
 Mark Langsdorf <mlangsdo@redhat.com>
Subject: [RFC PATCH 03/11] cpuidle: Remove Calxeda driver
Date: Tue, 18 Feb 2020 11:13:13 -0600
Message-Id: <20200218171321.30990-4-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200218171321.30990-1-robh@kernel.org>
References: <20200218171321.30990-1-robh@kernel.org>
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
 linux-ide@vger.kernel.org, Will Deacon <will@kernel.org>,
 linux-clk@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-edac@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, Tony Luck <tony.luck@intel.com>,
 Stephen Boyd <sboyd@kernel.org>, netdev@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 iommu@lists.linux-foundation.org, James Morse <james.morse@arm.com>,
 Robin Murphy <robin.murphy@arm.com>, "David S. Miller" <davem@davemloft.net>
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

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Do not apply yet.

 drivers/cpuidle/Kconfig.arm       |  7 ---
 drivers/cpuidle/Makefile          |  1 -
 drivers/cpuidle/cpuidle-calxeda.c | 72 -------------------------------
 3 files changed, 80 deletions(-)
 delete mode 100644 drivers/cpuidle/cpuidle-calxeda.c

diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 62272ecfa771..c2830d2ed44a 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -42,13 +42,6 @@ config ARM_CLPS711X_CPUIDLE
 	help
 	  Select this to enable cpuidle on Cirrus Logic CLPS711X SOCs.

-config ARM_HIGHBANK_CPUIDLE
-	bool "CPU Idle Driver for Calxeda processors"
-	depends on ARM_PSCI && !ARM64
-	select ARM_CPU_SUSPEND
-	help
-	  Select this to enable cpuidle on Calxeda processors.
-
 config ARM_KIRKWOOD_CPUIDLE
 	bool "CPU Idle Driver for Marvell Kirkwood SoCs"
 	depends on (MACH_KIRKWOOD || COMPILE_TEST) && !ARM64
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index cc8c769d7fa9..eee5f276edf7 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -14,7 +14,6 @@ obj-$(CONFIG_HALTPOLL_CPUIDLE)		  += cpuidle-haltpoll.o
 obj-$(CONFIG_ARM_MVEBU_V7_CPUIDLE) += cpuidle-mvebu-v7.o
 obj-$(CONFIG_ARM_BIG_LITTLE_CPUIDLE)	+= cpuidle-big_little.o
 obj-$(CONFIG_ARM_CLPS711X_CPUIDLE)	+= cpuidle-clps711x.o
-obj-$(CONFIG_ARM_HIGHBANK_CPUIDLE)	+= cpuidle-calxeda.o
 obj-$(CONFIG_ARM_KIRKWOOD_CPUIDLE)	+= cpuidle-kirkwood.o
 obj-$(CONFIG_ARM_ZYNQ_CPUIDLE)		+= cpuidle-zynq.o
 obj-$(CONFIG_ARM_U8500_CPUIDLE)         += cpuidle-ux500.o
diff --git a/drivers/cpuidle/cpuidle-calxeda.c b/drivers/cpuidle/cpuidle-calxeda.c
deleted file mode 100644
index b17d9a8418b0..000000000000
--- a/drivers/cpuidle/cpuidle-calxeda.c
+++ /dev/null
@@ -1,72 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright 2012 Calxeda, Inc.
- *
- * Based on arch/arm/plat-mxc/cpuidle.c: #v3.7
- * Copyright 2012 Freescale Semiconductor, Inc.
- * Copyright 2012 Linaro Ltd.
- *
- * Maintainer: Rob Herring <rob.herring@calxeda.com>
- */
-
-#include <linux/cpuidle.h>
-#include <linux/cpu_pm.h>
-#include <linux/init.h>
-#include <linux/mm.h>
-#include <linux/platform_device.h>
-#include <linux/psci.h>
-
-#include <asm/cpuidle.h>
-#include <asm/suspend.h>
-
-#include <uapi/linux/psci.h>
-
-#define CALXEDA_IDLE_PARAM \
-	((0 << PSCI_0_2_POWER_STATE_ID_SHIFT) | \
-	 (0 << PSCI_0_2_POWER_STATE_AFFL_SHIFT) | \
-	 (PSCI_POWER_STATE_TYPE_POWER_DOWN << PSCI_0_2_POWER_STATE_TYPE_SHIFT))
-
-static int calxeda_idle_finish(unsigned long val)
-{
-	return psci_ops.cpu_suspend(CALXEDA_IDLE_PARAM, __pa(cpu_resume));
-}
-
-static int calxeda_pwrdown_idle(struct cpuidle_device *dev,
-				struct cpuidle_driver *drv,
-				int index)
-{
-	cpu_pm_enter();
-	cpu_suspend(0, calxeda_idle_finish);
-	cpu_pm_exit();
-
-	return index;
-}
-
-static struct cpuidle_driver calxeda_idle_driver = {
-	.name = "calxeda_idle",
-	.states = {
-		ARM_CPUIDLE_WFI_STATE,
-		{
-			.name = "PG",
-			.desc = "Power Gate",
-			.exit_latency = 30,
-			.power_usage = 50,
-			.target_residency = 200,
-			.enter = calxeda_pwrdown_idle,
-		},
-	},
-	.state_count = 2,
-};
-
-static int calxeda_cpuidle_probe(struct platform_device *pdev)
-{
-	return cpuidle_register(&calxeda_idle_driver, NULL);
-}
-
-static struct platform_driver calxeda_cpuidle_plat_driver = {
-        .driver = {
-                .name = "cpuidle-calxeda",
-        },
-        .probe = calxeda_cpuidle_probe,
-};
-builtin_platform_driver(calxeda_cpuidle_plat_driver);
--
2.20.1
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
