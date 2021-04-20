Return-Path: <SRS0=gpU2=JR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB641C433ED
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 17:25:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5534F613C2
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 17:25:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5534F613C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4889D405D1;
	Tue, 20 Apr 2021 17:25:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8bKJ5CX2ndKY; Tue, 20 Apr 2021 17:25:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id B5E60405CE;
	Tue, 20 Apr 2021 17:25:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 891B5C000E;
	Tue, 20 Apr 2021 17:25:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9FC68C000B
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 17:25:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8182183C24
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 17:25:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dOiKRz1ln7fR for <iommu@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 17:25:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9719883C23
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 17:25:40 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id s15so46067566edd.4
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 10:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mZ//zvH1oExXC6NdRY4vaLjjFNQjXYZUU6cfp2n03+o=;
 b=rHn9GWVDRBb1kZKubWm/JU/UY+T8xtm4x/5LVGd5faKtfkrZhEfEP4rvxe2MqMin9v
 v2w7U8+WXW8blyIQeGUcjVJgLkFi4NVhZi/Y1mimDfeMR0/ObbChTQVhCx+OMx3z31kU
 U4cgANwhPcMKff756I/V12R33kXgPpsslVPfNB/QpZzLsefVnO7kVySL8d8SubfbMIWM
 mj9S7u353nPlriS36GbyeXDcUNfxijiXf0o9L8ZqIENmzwzAAQLCOXobKtjfXS+FeYfB
 +ePfSYBnRExFZ3/sLE5MyKSN6RyD3aE82mHQnRBe+Ad1TWOKi+xQNw7Kcdfp7tX1sajL
 feLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mZ//zvH1oExXC6NdRY4vaLjjFNQjXYZUU6cfp2n03+o=;
 b=WsgNv0tN+t5cT6HJicBoiRcxmhw/v23DqG6QZYCySOYnfAGfrNPqbWRKPZr4bz5gxt
 rKN0rp3x+ULCAPz7PQah5QpHoAsq+Blrha7po09S021j4LN+miRIdBwWlWjje/kkAzlw
 lLFmZAKF0VNTE1NXiukp10fuiC5NOUh8b4g4s0fRCAum3528RCBSxZ5aZex16Xz5Ccqf
 ShvxD6Y6AmPrP91l2iYPLOb/jv01nfkZFq3eN5IOzIJGlo+cJpTLYSXC6K9gMPT+qESb
 g/Or6pLgn6CJsqlwpNDOssaEUtRKioGrYObcr6iIMm+WfJS6sD8lgwlsjZRjmtEv2TgJ
 KY4w==
X-Gm-Message-State: AOAM533sjG7NZ+QrQEok25sCVwmoJw4RHPb0GL9lybWRdAE99vhy4+TR
 sQVEaH5mHxh0ktajgAKlp4M=
X-Google-Smtp-Source: ABdhPJxYnkX2BWyNbe8kR/8FB4ZlUdVx7Ru01wQwcu9ekn3l/FpJ+2uW7CZeNSw3bKZ9nEoitl9XXw==
X-Received: by 2002:a05:6402:cb3:: with SMTP id
 cn19mr25892145edb.206.1618939538855; 
 Tue, 20 Apr 2021 10:25:38 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id c12sm13436079eja.12.2021.04.20.10.25.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Apr 2021 10:25:37 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v2 01/10] memory: tegra: Implement SID override programming
Date: Tue, 20 Apr 2021 19:26:10 +0200
Message-Id: <20210420172619.3782831-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210420172619.3782831-1-thierry.reding@gmail.com>
References: <20210420172619.3782831-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Jon Hunter <jonathanh@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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

From: Thierry Reding <treding@nvidia.com>

Instead of programming all SID overrides during early boot, perform the
operation on-demand after the SMMU translations have been set up for a
device. This reuses data from device tree to match memory clients for a
device and programs the SID specified in device tree, which corresponds
to the SID used for the SMMU context banks for the device.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/memory/tegra/mc.c       |  9 +++++
 drivers/memory/tegra/tegra186.c | 72 +++++++++++++++++++++++++++++++++
 include/soc/tegra/mc.h          |  3 ++
 3 files changed, 84 insertions(+)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index c854639cf30c..bace5ecfe770 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -97,6 +97,15 @@ struct tegra_mc *devm_tegra_memory_controller_get(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(devm_tegra_memory_controller_get);
 
+int tegra_mc_probe_device(struct tegra_mc *mc, struct device *dev)
+{
+	if (mc->soc->ops && mc->soc->ops->probe_device)
+		return mc->soc->ops->probe_device(mc, dev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tegra_mc_probe_device);
+
 static int tegra_mc_block_dma_common(struct tegra_mc *mc,
 				     const struct tegra_mc_reset *rst)
 {
diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
index 1f87915ccd62..e65eac5764d4 100644
--- a/drivers/memory/tegra/tegra186.c
+++ b/drivers/memory/tegra/tegra186.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/io.h>
+#include <linux/iommu.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/of_device.h>
@@ -15,6 +16,10 @@
 #include <dt-bindings/memory/tegra186-mc.h>
 #endif
 
+#define MC_SID_STREAMID_OVERRIDE_MASK GENMASK(7, 0)
+#define MC_SID_STREAMID_SECURITY_WRITE_ACCESS_DISABLED BIT(16)
+#define MC_SID_STREAMID_SECURITY_OVERRIDE BIT(8)
+
 static void tegra186_mc_program_sid(struct tegra_mc *mc)
 {
 	unsigned int i;
@@ -66,10 +71,77 @@ static int tegra186_mc_resume(struct tegra_mc *mc)
 	return 0;
 }
 
+static void tegra186_mc_client_sid_override(struct tegra_mc *mc,
+					    const struct tegra_mc_client *client,
+					    unsigned int sid)
+{
+	u32 value, old;
+
+	value = readl(mc->regs + client->regs.sid.security);
+	if ((value & MC_SID_STREAMID_SECURITY_OVERRIDE) == 0) {
+		/*
+		 * If the secure firmware has locked this down the override
+		 * for this memory client, there's nothing we can do here.
+		 */
+		if (value & MC_SID_STREAMID_SECURITY_WRITE_ACCESS_DISABLED)
+			return;
+
+		/*
+		 * Otherwise, try to set the override itself. Typically the
+		 * secure firmware will never have set this configuration.
+		 * Instead, it will either have disabled write access to
+		 * this field, or it will already have set an explicit
+		 * override itself.
+		 */
+		WARN_ON((value & MC_SID_STREAMID_SECURITY_OVERRIDE) == 0);
+
+		value |= MC_SID_STREAMID_SECURITY_OVERRIDE;
+		writel(value, mc->regs + client->regs.sid.security);
+	}
+
+	value = readl(mc->regs + client->regs.sid.override);
+	old = value & MC_SID_STREAMID_OVERRIDE_MASK;
+
+	if (old != sid) {
+		dev_dbg(mc->dev, "overriding SID %x for %s with %x\n", old,
+			client->name, sid);
+		writel(sid, mc->regs + client->regs.sid.override);
+	}
+}
+
+static int tegra186_mc_probe_device(struct tegra_mc *mc, struct device *dev)
+{
+#if IS_ENABLED(CONFIG_IOMMU_API)
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct of_phandle_args args;
+	unsigned int i, index = 0;
+
+	while (!of_parse_phandle_with_args(dev->of_node, "interconnects", "#interconnect-cells",
+					   index, &args)) {
+		if (args.np == mc->dev->of_node && args.args_count != 0) {
+			for (i = 0; i < mc->soc->num_clients; i++) {
+				const struct tegra_mc_client *client = &mc->soc->clients[i];
+
+				if (client->id == args.args[0]) {
+					u32 sid = fwspec->ids[0] & MC_SID_STREAMID_OVERRIDE_MASK;
+
+					tegra186_mc_client_sid_override(mc, client, sid);
+				}
+			}
+		}
+
+		index++;
+	}
+#endif
+
+	return 0;
+}
+
 const struct tegra_mc_ops tegra186_mc_ops = {
 	.probe = tegra186_mc_probe,
 	.remove = tegra186_mc_remove,
 	.resume = tegra186_mc_resume,
+	.probe_device = tegra186_mc_probe_device,
 };
 
 #if defined(CONFIG_ARCH_TEGRA_186_SOC)
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index 1387747d574b..bbad6330008b 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -176,6 +176,7 @@ struct tegra_mc_ops {
 	int (*suspend)(struct tegra_mc *mc);
 	int (*resume)(struct tegra_mc *mc);
 	irqreturn_t (*handle_irq)(int irq, void *data);
+	int (*probe_device)(struct tegra_mc *mc, struct device *dev);
 };
 
 struct tegra_mc_soc {
@@ -240,4 +241,6 @@ devm_tegra_memory_controller_get(struct device *dev)
 }
 #endif
 
+int tegra_mc_probe_device(struct tegra_mc *mc, struct device *dev);
+
 #endif /* __SOC_TEGRA_MC_H__ */
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
