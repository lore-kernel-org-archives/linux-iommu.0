Return-Path: <SRS0=Yw80=4G=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952EAC34026
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 17:13:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 742612467D
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 17:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 742612467D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4EDC7204A5;
	Tue, 18 Feb 2020 17:13:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lmQNxp-O1qsh; Tue, 18 Feb 2020 17:13:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id CD78620489;
	Tue, 18 Feb 2020 17:13:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC996C08A0;
	Tue, 18 Feb 2020 17:13:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18AD0C013E
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 17:13:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 11E2686C3A
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 17:13:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MuYC9tBLS+b8 for <iommu@lists.linux-foundation.org>;
 Tue, 18 Feb 2020 17:13:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3A15686727
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 17:13:31 +0000 (UTC)
Received: by mail-ot1-f66.google.com with SMTP id r27so20205892otc.8
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 09:13:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JusgAl5N6MihYqm5uluXtGjWepTJgZcRc57DbXhWS1c=;
 b=uI49IAsGN57KAVWI9cFyNZyFMrsOvm0Fr1CwklgzLU+X8Ea9l2BCxHokI2IgAvY8md
 m+tv4pLc6VFn9PZyps0a7dSJFnYINxdBvsPyDOzQwK9tirLRT7ueVJr20FVMDEswHefS
 LBIrbwG6ZT8w5GMokojotN2fyVx95tfdc3cg82e6nJV7qMhkT2aqoEx4WaTPjZsvC3wg
 wUqO5seov6DRAEcH3TzYxq0zxeiO5ePFpEdwI3hukXKIkOnszOADymAu4vBrcGZpMGgc
 Jr4KjXmCCwedP5xKd2DxCimS7tefm9O1tAvtCLSsetelcd0mfyI8hWR3aZ+0l6m0Cfaj
 v0bw==
X-Gm-Message-State: APjAAAX8eoSZDi/l+V2RhyDOErwd2SzBgUwS8CyNkz32cEY4P4Hr1BAa
 vMWUYQz4SN/M6l/zRAU2Zw==
X-Google-Smtp-Source: APXvYqxtfwdO5ZrwB57qMGPOEsnz4rhk/PhIK9UqQ1I24Sd3few+yqThLV3He9kZDSP4GnJqg66xxQ==
X-Received: by 2002:a05:6830:1042:: with SMTP id
 b2mr16287928otp.306.1582046010353; 
 Tue, 18 Feb 2020 09:13:30 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id y25sm1545755oto.27.2020.02.18.09.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 09:13:29 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 soc@kernel.org, Andre Przywara <andre.przywara@arm.com>,
 Robert Richter <rrichter@marvell.com>, Jon Loeliger <jdl@jdl.com>,
 Alexander Graf <graf@amazon.com>, Matthias Brugger <mbrugger@suse.com>,
 Mark Langsdorf <mlangsdo@redhat.com>
Subject: [RFC PATCH 04/11] cpufreq: Remove Calxeda driver
Date: Tue, 18 Feb 2020 11:13:14 -0600
Message-Id: <20200218171321.30990-5-robh@kernel.org>
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
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Do not apply yet.

 drivers/cpufreq/Kconfig.arm          |  10 ---
 drivers/cpufreq/Makefile             |   3 +-
 drivers/cpufreq/cpufreq-dt-platdev.c |   3 -
 drivers/cpufreq/highbank-cpufreq.c   | 106 ---------------------------
 4 files changed, 1 insertion(+), 121 deletions(-)
 delete mode 100644 drivers/cpufreq/highbank-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 3858d86cf409..27fdd5ac21da 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -79,16 +79,6 @@ config ARM_BRCMSTB_AVS_CPUFREQ

 	  Say Y, if you have a Broadcom SoC with AVS support for DFS or DVFS.

-config ARM_HIGHBANK_CPUFREQ
-	tristate "Calxeda Highbank-based"
-	depends on ARCH_HIGHBANK && CPUFREQ_DT && REGULATOR
-	default m
-	help
-	  This adds the CPUFreq driver for Calxeda Highbank SoC
-	  based boards.
-
-	  If in doubt, say N.
-
 config ARM_IMX6Q_CPUFREQ
 	tristate "Freescale i.MX6 cpufreq support"
 	depends on ARCH_MXC
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index f6670c4abbb0..47d773b9312a 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -5,7 +5,7 @@ obj-$(CONFIG_CPU_FREQ)			+= cpufreq.o freq_table.o
 # CPUfreq stats
 obj-$(CONFIG_CPU_FREQ_STAT)             += cpufreq_stats.o

-# CPUfreq governors
+# CPUfreq governors
 obj-$(CONFIG_CPU_FREQ_GOV_PERFORMANCE)	+= cpufreq_performance.o
 obj-$(CONFIG_CPU_FREQ_GOV_POWERSAVE)	+= cpufreq_powersave.o
 obj-$(CONFIG_CPU_FREQ_GOV_USERSPACE)	+= cpufreq_userspace.o
@@ -52,7 +52,6 @@ obj-$(CONFIG_ARM_ARMADA_8K_CPUFREQ)	+= armada-8k-cpufreq.o
 obj-$(CONFIG_ARM_BRCMSTB_AVS_CPUFREQ)	+= brcmstb-avs-cpufreq.o
 obj-$(CONFIG_ACPI_CPPC_CPUFREQ)		+= cppc_cpufreq.o
 obj-$(CONFIG_ARCH_DAVINCI)		+= davinci-cpufreq.o
-obj-$(CONFIG_ARM_HIGHBANK_CPUFREQ)	+= highbank-cpufreq.o
 obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)		+= imx6q-cpufreq.o
 obj-$(CONFIG_ARM_IMX_CPUFREQ_DT)	+= imx-cpufreq-dt.o
 obj-$(CONFIG_ARM_KIRKWOOD_CPUFREQ)	+= kirkwood-cpufreq.o
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index f2ae9cd455c1..274294f83e7c 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -102,9 +102,6 @@ static const struct of_device_id whitelist[] __initconst = {
 static const struct of_device_id blacklist[] __initconst = {
 	{ .compatible = "allwinner,sun50i-h6", },

-	{ .compatible = "calxeda,highbank", },
-	{ .compatible = "calxeda,ecx-2000", },
-
 	{ .compatible = "fsl,imx7d", },
 	{ .compatible = "fsl,imx8mq", },
 	{ .compatible = "fsl,imx8mm", },
diff --git a/drivers/cpufreq/highbank-cpufreq.c b/drivers/cpufreq/highbank-cpufreq.c
deleted file mode 100644
index 5a7f6dafcddb..000000000000
--- a/drivers/cpufreq/highbank-cpufreq.c
+++ /dev/null
@@ -1,106 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2012 Calxeda, Inc.
- *
- * This driver provides the clk notifier callbacks that are used when
- * the cpufreq-dt driver changes to frequency to alert the highbank
- * EnergyCore Management Engine (ECME) about the need to change
- * voltage. The ECME interfaces with the actual voltage regulators.
- */
-
-#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/clk.h>
-#include <linux/cpu.h>
-#include <linux/err.h>
-#include <linux/of.h>
-#include <linux/pl320-ipc.h>
-#include <linux/platform_device.h>
-
-#define HB_CPUFREQ_CHANGE_NOTE	0x80000001
-#define HB_CPUFREQ_IPC_LEN	7
-#define HB_CPUFREQ_VOLT_RETRIES	15
-
-static int hb_voltage_change(unsigned int freq)
-{
-	u32 msg[HB_CPUFREQ_IPC_LEN] = {HB_CPUFREQ_CHANGE_NOTE, freq / 1000000};
-
-	return pl320_ipc_transmit(msg);
-}
-
-static int hb_cpufreq_clk_notify(struct notifier_block *nb,
-				unsigned long action, void *hclk)
-{
-	struct clk_notifier_data *clk_data = hclk;
-	int i = 0;
-
-	if (action == PRE_RATE_CHANGE) {
-		if (clk_data->new_rate > clk_data->old_rate)
-			while (hb_voltage_change(clk_data->new_rate))
-				if (i++ > HB_CPUFREQ_VOLT_RETRIES)
-					return NOTIFY_BAD;
-	} else if (action == POST_RATE_CHANGE) {
-		if (clk_data->new_rate < clk_data->old_rate)
-			while (hb_voltage_change(clk_data->new_rate))
-				if (i++ > HB_CPUFREQ_VOLT_RETRIES)
-					return NOTIFY_BAD;
-	}
-
-	return NOTIFY_DONE;
-}
-
-static struct notifier_block hb_cpufreq_clk_nb = {
-	.notifier_call = hb_cpufreq_clk_notify,
-};
-
-static int hb_cpufreq_driver_init(void)
-{
-	struct platform_device_info devinfo = { .name = "cpufreq-dt", };
-	struct device *cpu_dev;
-	struct clk *cpu_clk;
-	struct device_node *np;
-	int ret;
-
-	if ((!of_machine_is_compatible("calxeda,highbank")) &&
-		(!of_machine_is_compatible("calxeda,ecx-2000")))
-		return -ENODEV;
-
-	cpu_dev = get_cpu_device(0);
-	if (!cpu_dev) {
-		pr_err("failed to get highbank cpufreq device\n");
-		return -ENODEV;
-	}
-
-	np = of_node_get(cpu_dev->of_node);
-	if (!np) {
-		pr_err("failed to find highbank cpufreq node\n");
-		return -ENOENT;
-	}
-
-	cpu_clk = clk_get(cpu_dev, NULL);
-	if (IS_ERR(cpu_clk)) {
-		ret = PTR_ERR(cpu_clk);
-		pr_err("failed to get cpu0 clock: %d\n", ret);
-		goto out_put_node;
-	}
-
-	ret = clk_notifier_register(cpu_clk, &hb_cpufreq_clk_nb);
-	if (ret) {
-		pr_err("failed to register clk notifier: %d\n", ret);
-		goto out_put_node;
-	}
-
-	/* Instantiate cpufreq-dt */
-	platform_device_register_full(&devinfo);
-
-out_put_node:
-	of_node_put(np);
-	return ret;
-}
-module_init(hb_cpufreq_driver_init);
-
-MODULE_AUTHOR("Mark Langsdorf <mark.langsdorf@calxeda.com>");
-MODULE_DESCRIPTION("Calxeda Highbank cpufreq driver");
-MODULE_LICENSE("GPL");
--
2.20.1
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
