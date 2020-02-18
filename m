Return-Path: <SRS0=Yw80=4G=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7F7C34026
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 17:13:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 495FC208C4
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 17:13:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 495FC208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2EC3C204B1;
	Tue, 18 Feb 2020 17:13:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LyZyoQyd6MdT; Tue, 18 Feb 2020 17:13:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 8C473204C2;
	Tue, 18 Feb 2020 17:13:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71F41C08A0;
	Tue, 18 Feb 2020 17:13:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 496DCC013E
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 17:13:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 33ED085064
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 17:13:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W-z45ZiDPL-u for <iommu@lists.linux-foundation.org>;
 Tue, 18 Feb 2020 17:13:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 by whitealder.osuosl.org (Postfix) with ESMTPS id AC06586252
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 17:13:37 +0000 (UTC)
Received: by mail-ot1-f66.google.com with SMTP id 66so20235754otd.9
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 09:13:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=u8D2FPtNZ0VMBn5UkeqSg7CSDs/wZAjBSTTCQDmiSkY=;
 b=okkkIn1VA/r+YGhuiqqkgIAcb4k4YKXhAYHQNBUV6B51lulxH4kLvA7ORNzyqto1Ex
 J7ttTMNnhpiXTM9wFLqnF9jgMNwY7KiL31rjiEFHDlK+tFu+X99vn2fpriP7paXiZ/Jk
 6SvAvoXxIFtBwvext+GX9Zqqbvp7U8rnRbGrOmqsmfXdQLvcBsBkUd1tUI5hVN8vdV8Q
 dpfpKbOFFDem9Eq1RE1QZyqjDz3xwn6pF3dfKW7kWuGMRuP12he7FIWbDSvR/7EeaDhh
 iDvSyGLu6Bf2Ck4ue6scuNg/+2qUMxSl+H5gVHlt+GthXtDUpQZIJnWqc0W3S3Drum32
 q4yw==
X-Gm-Message-State: APjAAAWhOJoh8QoyR03H0Zp0r1RvTmi6uh+uH+mrldTFUEQxtkx3w10J
 pM8FZXN3F+CYqUHN38Jmdw==
X-Google-Smtp-Source: APXvYqw6TNQhn8784qV+7u3WFCDSuqFfYxpVsfN96SobcjyzzV4x9MxcI5ZxKLnqYBrEuZO3mSlkJg==
X-Received: by 2002:a9d:7386:: with SMTP id j6mr16115366otk.336.1582046016817; 
 Tue, 18 Feb 2020 09:13:36 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id y25sm1545755oto.27.2020.02.18.09.13.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 09:13:36 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 soc@kernel.org, Andre Przywara <andre.przywara@arm.com>,
 Robert Richter <rrichter@marvell.com>, Jon Loeliger <jdl@jdl.com>,
 Alexander Graf <graf@amazon.com>, Matthias Brugger <mbrugger@suse.com>,
 Mark Langsdorf <mlangsdo@redhat.com>
Subject: [RFC PATCH 08/11] clk: Remove Calxeda driver
Date: Tue, 18 Feb 2020 11:13:18 -0600
Message-Id: <20200218171321.30990-9-robh@kernel.org>
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

Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Do not apply yet.

 drivers/clk/Makefile       |   1 -
 drivers/clk/clk-highbank.c | 329 -------------------------------------
 2 files changed, 330 deletions(-)
 delete mode 100644 drivers/clk/clk-highbank.c

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index f4169cc2fd31..cb71dfaf1ac7 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -33,7 +33,6 @@ obj-$(CONFIG_COMMON_CLK_FSL_SAI)	+= clk-fsl-sai.o
 obj-$(CONFIG_COMMON_CLK_GEMINI)		+= clk-gemini.o
 obj-$(CONFIG_COMMON_CLK_ASPEED)		+= clk-aspeed.o
 obj-$(CONFIG_MACH_ASPEED_G6)		+= clk-ast2600.o
-obj-$(CONFIG_ARCH_HIGHBANK)		+= clk-highbank.o
 obj-$(CONFIG_CLK_HSDK)			+= clk-hsdk-pll.o
 obj-$(CONFIG_COMMON_CLK_LOCHNAGAR)	+= clk-lochnagar.o
 obj-$(CONFIG_COMMON_CLK_MAX77686)	+= clk-max77686.o
diff --git a/drivers/clk/clk-highbank.c b/drivers/clk/clk-highbank.c
deleted file mode 100644
index 2a0cea2946f9..000000000000
--- a/drivers/clk/clk-highbank.c
+++ /dev/null
@@ -1,329 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright 2011-2012 Calxeda, Inc.
- */
-
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/err.h>
-#include <linux/clk-provider.h>
-#include <linux/io.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-
-#define HB_PLL_LOCK_500		0x20000000
-#define HB_PLL_LOCK		0x10000000
-#define HB_PLL_DIVF_SHIFT	20
-#define HB_PLL_DIVF_MASK	0x0ff00000
-#define HB_PLL_DIVQ_SHIFT	16
-#define HB_PLL_DIVQ_MASK	0x00070000
-#define HB_PLL_DIVR_SHIFT	8
-#define HB_PLL_DIVR_MASK	0x00001f00
-#define HB_PLL_RANGE_SHIFT	4
-#define HB_PLL_RANGE_MASK	0x00000070
-#define HB_PLL_BYPASS		0x00000008
-#define HB_PLL_RESET		0x00000004
-#define HB_PLL_EXT_BYPASS	0x00000002
-#define HB_PLL_EXT_ENA		0x00000001
-
-#define HB_PLL_VCO_MIN_FREQ	2133000000
-#define HB_PLL_MAX_FREQ		HB_PLL_VCO_MIN_FREQ
-#define HB_PLL_MIN_FREQ		(HB_PLL_VCO_MIN_FREQ / 64)
-
-#define HB_A9_BCLK_DIV_MASK	0x00000006
-#define HB_A9_BCLK_DIV_SHIFT	1
-#define HB_A9_PCLK_DIV		0x00000001
-
-struct hb_clk {
-        struct clk_hw	hw;
-	void __iomem	*reg;
-	char *parent_name;
-};
-#define to_hb_clk(p) container_of(p, struct hb_clk, hw)
-
-static int clk_pll_prepare(struct clk_hw *hwclk)
-	{
-	struct hb_clk *hbclk = to_hb_clk(hwclk);
-	u32 reg;
-
-	reg = readl(hbclk->reg);
-	reg &= ~HB_PLL_RESET;
-	writel(reg, hbclk->reg);
-
-	while ((readl(hbclk->reg) & HB_PLL_LOCK) == 0)
-		;
-	while ((readl(hbclk->reg) & HB_PLL_LOCK_500) == 0)
-		;
-
-	return 0;
-}
-
-static void clk_pll_unprepare(struct clk_hw *hwclk)
-{
-	struct hb_clk *hbclk = to_hb_clk(hwclk);
-	u32 reg;
-
-	reg = readl(hbclk->reg);
-	reg |= HB_PLL_RESET;
-	writel(reg, hbclk->reg);
-}
-
-static int clk_pll_enable(struct clk_hw *hwclk)
-{
-	struct hb_clk *hbclk = to_hb_clk(hwclk);
-	u32 reg;
-
-	reg = readl(hbclk->reg);
-	reg |= HB_PLL_EXT_ENA;
-	writel(reg, hbclk->reg);
-
-	return 0;
-}
-
-static void clk_pll_disable(struct clk_hw *hwclk)
-{
-	struct hb_clk *hbclk = to_hb_clk(hwclk);
-	u32 reg;
-
-	reg = readl(hbclk->reg);
-	reg &= ~HB_PLL_EXT_ENA;
-	writel(reg, hbclk->reg);
-}
-
-static unsigned long clk_pll_recalc_rate(struct clk_hw *hwclk,
-					 unsigned long parent_rate)
-{
-	struct hb_clk *hbclk = to_hb_clk(hwclk);
-	unsigned long divf, divq, vco_freq, reg;
-
-	reg = readl(hbclk->reg);
-	if (reg & HB_PLL_EXT_BYPASS)
-		return parent_rate;
-
-	divf = (reg & HB_PLL_DIVF_MASK) >> HB_PLL_DIVF_SHIFT;
-	divq = (reg & HB_PLL_DIVQ_MASK) >> HB_PLL_DIVQ_SHIFT;
-	vco_freq = parent_rate * (divf + 1);
-
-	return vco_freq / (1 << divq);
-}
-
-static void clk_pll_calc(unsigned long rate, unsigned long ref_freq,
-			u32 *pdivq, u32 *pdivf)
-{
-	u32 divq, divf;
-	unsigned long vco_freq;
-
-	if (rate < HB_PLL_MIN_FREQ)
-		rate = HB_PLL_MIN_FREQ;
-	if (rate > HB_PLL_MAX_FREQ)
-		rate = HB_PLL_MAX_FREQ;
-
-	for (divq = 1; divq <= 6; divq++) {
-		if ((rate * (1 << divq)) >= HB_PLL_VCO_MIN_FREQ)
-			break;
-	}
-
-	vco_freq = rate * (1 << divq);
-	divf = (vco_freq + (ref_freq / 2)) / ref_freq;
-	divf--;
-
-	*pdivq = divq;
-	*pdivf = divf;
-}
-
-static long clk_pll_round_rate(struct clk_hw *hwclk, unsigned long rate,
-			       unsigned long *parent_rate)
-{
-	u32 divq, divf;
-	unsigned long ref_freq = *parent_rate;
-
-	clk_pll_calc(rate, ref_freq, &divq, &divf);
-
-	return (ref_freq * (divf + 1)) / (1 << divq);
-}
-
-static int clk_pll_set_rate(struct clk_hw *hwclk, unsigned long rate,
-			    unsigned long parent_rate)
-{
-	struct hb_clk *hbclk = to_hb_clk(hwclk);
-	u32 divq, divf;
-	u32 reg;
-
-	clk_pll_calc(rate, parent_rate, &divq, &divf);
-
-	reg = readl(hbclk->reg);
-	if (divf != ((reg & HB_PLL_DIVF_MASK) >> HB_PLL_DIVF_SHIFT)) {
-		/* Need to re-lock PLL, so put it into bypass mode */
-		reg |= HB_PLL_EXT_BYPASS;
-		writel(reg | HB_PLL_EXT_BYPASS, hbclk->reg);
-
-		writel(reg | HB_PLL_RESET, hbclk->reg);
-		reg &= ~(HB_PLL_DIVF_MASK | HB_PLL_DIVQ_MASK);
-		reg |= (divf << HB_PLL_DIVF_SHIFT) | (divq << HB_PLL_DIVQ_SHIFT);
-		writel(reg | HB_PLL_RESET, hbclk->reg);
-		writel(reg, hbclk->reg);
-
-		while ((readl(hbclk->reg) & HB_PLL_LOCK) == 0)
-			;
-		while ((readl(hbclk->reg) & HB_PLL_LOCK_500) == 0)
-			;
-		reg |= HB_PLL_EXT_ENA;
-		reg &= ~HB_PLL_EXT_BYPASS;
-	} else {
-		writel(reg | HB_PLL_EXT_BYPASS, hbclk->reg);
-		reg &= ~HB_PLL_DIVQ_MASK;
-		reg |= divq << HB_PLL_DIVQ_SHIFT;
-		writel(reg | HB_PLL_EXT_BYPASS, hbclk->reg);
-	}
-	writel(reg, hbclk->reg);
-
-	return 0;
-}
-
-static const struct clk_ops clk_pll_ops = {
-	.prepare = clk_pll_prepare,
-	.unprepare = clk_pll_unprepare,
-	.enable = clk_pll_enable,
-	.disable = clk_pll_disable,
-	.recalc_rate = clk_pll_recalc_rate,
-	.round_rate = clk_pll_round_rate,
-	.set_rate = clk_pll_set_rate,
-};
-
-static unsigned long clk_cpu_periphclk_recalc_rate(struct clk_hw *hwclk,
-						   unsigned long parent_rate)
-{
-	struct hb_clk *hbclk = to_hb_clk(hwclk);
-	u32 div = (readl(hbclk->reg) & HB_A9_PCLK_DIV) ? 8 : 4;
-	return parent_rate / div;
-}
-
-static const struct clk_ops a9periphclk_ops = {
-	.recalc_rate = clk_cpu_periphclk_recalc_rate,
-};
-
-static unsigned long clk_cpu_a9bclk_recalc_rate(struct clk_hw *hwclk,
-						unsigned long parent_rate)
-{
-	struct hb_clk *hbclk = to_hb_clk(hwclk);
-	u32 div = (readl(hbclk->reg) & HB_A9_BCLK_DIV_MASK) >> HB_A9_BCLK_DIV_SHIFT;
-
-	return parent_rate / (div + 2);
-}
-
-static const struct clk_ops a9bclk_ops = {
-	.recalc_rate = clk_cpu_a9bclk_recalc_rate,
-};
-
-static unsigned long clk_periclk_recalc_rate(struct clk_hw *hwclk,
-					     unsigned long parent_rate)
-{
-	struct hb_clk *hbclk = to_hb_clk(hwclk);
-	u32 div;
-
-	div = readl(hbclk->reg) & 0x1f;
-	div++;
-	div *= 2;
-
-	return parent_rate / div;
-}
-
-static long clk_periclk_round_rate(struct clk_hw *hwclk, unsigned long rate,
-				   unsigned long *parent_rate)
-{
-	u32 div;
-
-	div = *parent_rate / rate;
-	div++;
-	div &= ~0x1;
-
-	return *parent_rate / div;
-}
-
-static int clk_periclk_set_rate(struct clk_hw *hwclk, unsigned long rate,
-				unsigned long parent_rate)
-{
-	struct hb_clk *hbclk = to_hb_clk(hwclk);
-	u32 div;
-
-	div = parent_rate / rate;
-	if (div & 0x1)
-		return -EINVAL;
-
-	writel(div >> 1, hbclk->reg);
-	return 0;
-}
-
-static const struct clk_ops periclk_ops = {
-	.recalc_rate = clk_periclk_recalc_rate,
-	.round_rate = clk_periclk_round_rate,
-	.set_rate = clk_periclk_set_rate,
-};
-
-static void __init hb_clk_init(struct device_node *node, const struct clk_ops *ops, unsigned long clkflags)
-{
-	u32 reg;
-	struct hb_clk *hb_clk;
-	const char *clk_name = node->name;
-	const char *parent_name;
-	struct clk_init_data init;
-	struct device_node *srnp;
-	int rc;
-
-	rc = of_property_read_u32(node, "reg", &reg);
-	if (WARN_ON(rc))
-		return;
-
-	hb_clk = kzalloc(sizeof(*hb_clk), GFP_KERNEL);
-	if (WARN_ON(!hb_clk))
-		return;
-
-	/* Map system registers */
-	srnp = of_find_compatible_node(NULL, NULL, "calxeda,hb-sregs");
-	hb_clk->reg = of_iomap(srnp, 0);
-	of_node_put(srnp);
-	BUG_ON(!hb_clk->reg);
-	hb_clk->reg += reg;
-
-	of_property_read_string(node, "clock-output-names", &clk_name);
-
-	init.name = clk_name;
-	init.ops = ops;
-	init.flags = clkflags;
-	parent_name = of_clk_get_parent_name(node, 0);
-	init.parent_names = &parent_name;
-	init.num_parents = 1;
-
-	hb_clk->hw.init = &init;
-
-	rc = clk_hw_register(NULL, &hb_clk->hw);
-	if (WARN_ON(rc)) {
-		kfree(hb_clk);
-		return;
-	}
-	of_clk_add_hw_provider(node, of_clk_hw_simple_get, &hb_clk->hw);
-}
-
-static void __init hb_pll_init(struct device_node *node)
-{
-	hb_clk_init(node, &clk_pll_ops, 0);
-}
-CLK_OF_DECLARE(hb_pll, "calxeda,hb-pll-clock", hb_pll_init);
-
-static void __init hb_a9periph_init(struct device_node *node)
-{
-	hb_clk_init(node, &a9periphclk_ops, 0);
-}
-CLK_OF_DECLARE(hb_a9periph, "calxeda,hb-a9periph-clock", hb_a9periph_init);
-
-static void __init hb_a9bus_init(struct device_node *node)
-{
-	hb_clk_init(node, &a9bclk_ops, CLK_IS_CRITICAL);
-}
-CLK_OF_DECLARE(hb_a9bus, "calxeda,hb-a9bus-clock", hb_a9bus_init);
-
-static void __init hb_emmc_init(struct device_node *node)
-{
-	hb_clk_init(node, &periclk_ops, 0);
-}
-CLK_OF_DECLARE(hb_emmc, "calxeda,hb-emmc-clock", hb_emmc_init);
--
2.20.1
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
