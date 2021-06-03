Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2B2C47082
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 16:45:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77A5F613B1
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 16:45:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77A5F613B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 44BAD83F0D;
	Thu,  3 Jun 2021 16:45:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lSYdEy_mVQ1t; Thu,  3 Jun 2021 16:45:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7779984242;
	Thu,  3 Jun 2021 16:45:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4DD9BC000D;
	Thu,  3 Jun 2021 16:45:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A22A7C0001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 16:45:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8003860B58
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 16:45:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w2ooT7QvGQIs for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 16:45:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DBC50606C6
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 16:45:02 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id k7so10163610ejv.12
 for <iommu@lists.linux-foundation.org>; Thu, 03 Jun 2021 09:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Xzw2TUXY9p93oZxbwZKb0YQTzrG6r+scUnZo7x9ZCuU=;
 b=BLkLvFdApNPPc1q9dm6SyDGGREAVsuQgmtHybL+4Ju9BI2Ouw4EuFvuzh5TFfljaou
 rSdJmPTj7DJQs6BwlK35x8RuCodKVxouDgYyVI9FYSHyorPWgQAgDQ5F7HW4EzrXLvu+
 Ly6zoAVjCiGWNEMseWyo5jTpij6fj2skQMnRL69EqYkc/X/JLUeJkRkI7el1HsVFoMjd
 cs4MLhUVZrLxR1+BVMQvpMxPU8EZ4DP0ilgpqyQbZohdATLha6u0uQAOzKhnu4JSSKXv
 1mX+ILdrIkOayYuTPRONvrYaX/zjOaMqqkTo38mjcT3xFuhqtN5YshKcq0viUUS8CG4D
 bOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Xzw2TUXY9p93oZxbwZKb0YQTzrG6r+scUnZo7x9ZCuU=;
 b=rs0rP3ihF7aptzK+zqpDJLFXoPRZXdfQgMGH2UDDBp0QlRrPJF7JRxO3S9FjR1hVoB
 Apr43bpyQBFrjNISoK+nc17U+szxQU7Ld6DB27p9p/wj6bqrTGCmtgtFgwcnG2q0ntDd
 t+2TcdlyX2PrF1O/CMxmhnU6z66nq06WhS7/m+Sz/QbOo6dAm5+mn/sE1zp2wdwKQtwD
 m884Z1zFHhvxPhbS9Wbm2dLbPjRvgY9L7dXDnpPF1mYffbaWcF8376UBH0/hrWz2ei8L
 mGGR4ZZ28gQ4sSX75r6L724MVvYmMsY1X0sLDDxL3+GU/DDPGo7aAxg6//h/wau4AnNi
 DC4w==
X-Gm-Message-State: AOAM533GrAw1rLUVQGrQJay9PFM3vk8M1H1/pAv17len9iW56jdwNdoM
 pZ0sj/D/z6NPBUORDQhhe0U=
X-Google-Smtp-Source: ABdhPJxskXVbfgGBiwrxr5agPcu7F5QArOGLc64A8ytnD19xBd4ogTRNhjMOLdBL+Va4ArqBKjwpGw==
X-Received: by 2002:a17:906:5407:: with SMTP id
 q7mr302416ejo.158.1622738701180; 
 Thu, 03 Jun 2021 09:45:01 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id c19sm2079710edv.36.2021.06.03.09.44.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jun 2021 09:45:00 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v3 1/9] memory: tegra: Implement SID override programming
Date: Thu,  3 Jun 2021 18:46:24 +0200
Message-Id: <20210603164632.1000458-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210603164632.1000458-1-thierry.reding@gmail.com>
References: <20210603164632.1000458-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Jon Hunter <jonathanh@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, linux-tegra@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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
index 11b83de9361c..3c5aae7abf35 100644
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
index 1bd5aed81868..e19c2504a14b 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -180,6 +180,7 @@ struct tegra_mc_ops {
 	int (*suspend)(struct tegra_mc *mc);
 	int (*resume)(struct tegra_mc *mc);
 	irqreturn_t (*handle_irq)(int irq, void *data);
+	int (*probe_device)(struct tegra_mc *mc, struct device *dev);
 };
 
 struct tegra_mc_soc {
@@ -244,4 +245,6 @@ devm_tegra_memory_controller_get(struct device *dev)
 }
 #endif
 
+int tegra_mc_probe_device(struct tegra_mc *mc, struct device *dev);
+
 #endif /* __SOC_TEGRA_MC_H__ */
-- 
2.31.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
