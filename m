Return-Path: <SRS0=Fh/M=IX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_RED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06367C433C1
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 13:03:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D4FE61A1B
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 13:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D4FE61A1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 61DC884A0F;
	Thu, 25 Mar 2021 13:03:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UY9LxgTd0Kic; Thu, 25 Mar 2021 13:03:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D7AD84A0E;
	Thu, 25 Mar 2021 13:03:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 364E3C000D;
	Thu, 25 Mar 2021 13:03:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B15ADC000A
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 13:03:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9F9B2401B8
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 13:03:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LVcwFvHxGUjR for <iommu@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 13:03:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C2D20401F2
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 13:03:31 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id x7so2183023wrw.10
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 06:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bM4o41o0uKiCCdNc1xklJaXj4qpc+jHNYM7w+kQ4+qg=;
 b=U4V0FXpRhge+rQbpMnsw738aWFzOHoH9nKRQ4RFXGn0nboWX18kWT6XdIPwWm1vL6q
 atFtWWgo1paCfmqEG0tnLm0g4piD2/1VUCz+GW7iovm7yRT7Q11Sc2V+K1OqXSzFUojn
 vRh3CKFcVmUPtowChih/rZQvQnTFW/CLGtk4NISdm4rQMbi5t3wSdyjZaHne2bbFzJDX
 P5InDuLpPvf39kC28YMzmLianBflz3MRCbgb4Vi3lOEf0GvLXlpmj+8ALL2i4Igm7Pgq
 Jj+p7FirkxXuleA9m/OCJflpckBYjrdLw48EPsH0dcnlbPJKEbPPPobnFYhDDOGZHlbS
 AeNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bM4o41o0uKiCCdNc1xklJaXj4qpc+jHNYM7w+kQ4+qg=;
 b=lLLa1AIk8nFvrj/sLUJXKnbnNqTBlB3DtPUA2wVsvINsn05SyuE4PdYkQEa3iYCzRq
 MUtNeqWVT4mFAIC/5Vha7fGz3oB9OY4me7ASwLRKtT3m5/xiAf1iotfJf6oYsKVfObKL
 aIwXRsjUOeMbo1y2slJm+jFwPcUd7fxq7oCrEnO6qKONjaUltiAQ9mfw7nBl9fEhxUNL
 yPaKhf+SpZBa20VW+gLqfw664y1xUkGjHpju9yB4eC9PCql5k0uMfVXkAKeqmBbaFtkv
 tIzcNRFdajp1bsIfrcCyphzUxojVRSl/7Ico/BbO85Pa2Yvu1jL9hZL8eVuNBm8AoSH4
 +PlQ==
X-Gm-Message-State: AOAM533OLpH1qK99j1Ml563hESwihTfvYQTa8TElzNrAfFitfp4Pgvp3
 rRYhodOZWe1D09tDNiMSVh8=
X-Google-Smtp-Source: ABdhPJx67P1LH5jgle7JqCerP8+RaNQGzDrk4nvFL4I+tYklmaeH1WswkVYp3xtEYZECCBUpdUTJUw==
X-Received: by 2002:adf:ce8a:: with SMTP id r10mr8907889wrn.17.1616677410043; 
 Thu, 25 Mar 2021 06:03:30 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id h25sm6904366wml.32.2021.03.25.06.03.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Mar 2021 06:03:28 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 3/9] memory: tegra: Implement SID override programming
Date: Thu, 25 Mar 2021 14:03:26 +0100
Message-Id: <20210325130332.778208-4-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210325130332.778208-1-thierry.reding@gmail.com>
References: <20210325130332.778208-1-thierry.reding@gmail.com>
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
 drivers/memory/tegra/tegra186.c | 70 +++++++++++++++++++++++++++++++++
 include/soc/tegra/mc.h          | 10 +++++
 2 files changed, 80 insertions(+)

diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
index efa922d51d83..a89e8e40d875 100644
--- a/drivers/memory/tegra/tegra186.c
+++ b/drivers/memory/tegra/tegra186.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/io.h>
+#include <linux/iommu.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/of_device.h>
@@ -19,6 +20,10 @@
 #include <dt-bindings/memory/tegra194-mc.h>
 #endif
 
+#define MC_SID_STREAMID_OVERRIDE_MASK GENMASK(7, 0)
+#define MC_SID_STREAMID_SECURITY_WRITE_ACCESS_DISABLED BIT(16)
+#define MC_SID_STREAMID_SECURITY_OVERRIDE BIT(8)
+
 struct tegra186_mc_client {
 	const char *name;
 	unsigned int id;
@@ -1808,6 +1813,71 @@ static struct platform_driver tegra186_mc_driver = {
 };
 module_platform_driver(tegra186_mc_driver);
 
+static void tegra186_mc_client_sid_override(struct tegra_mc *mc,
+					    const struct tegra186_mc_client *client,
+					    unsigned int sid)
+{
+	u32 value, old;
+
+	value = readl(mc->regs + client->regs.security);
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
+		writel(value, mc->regs + client->regs.security);
+	}
+
+	value = readl(mc->regs + client->regs.override);
+	old = value & MC_SID_STREAMID_OVERRIDE_MASK;
+
+	if (old != sid) {
+		dev_dbg(mc->dev, "overriding SID %x for %s with %x\n", old,
+			client->name, sid);
+		writel(sid, mc->regs + client->regs.override);
+	}
+}
+
+int tegra186_mc_probe_device(struct tegra_mc *mc, struct device *dev)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct of_phandle_args args;
+	unsigned int i, index = 0;
+
+	while (!of_parse_phandle_with_args(dev->of_node, "interconnects", "#interconnect-cells",
+					   index, &args)) {
+		if (args.np == mc->dev->of_node && args.args_count != 0) {
+			for (i = 0; i < mc->soc->num_clients; i++) {
+				const struct tegra186_mc_client *client = &mc->soc->clients[i];
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
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tegra186_mc_probe_device);
+
 MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
 MODULE_DESCRIPTION("NVIDIA Tegra186 Memory Controller driver");
 MODULE_LICENSE("GPL v2");
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index 7be8441c6e9e..73d5ecf0e76a 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -168,4 +168,14 @@ devm_tegra_memory_controller_get(struct device *dev)
 }
 #endif
 
+#if IS_ENABLED(CONFIG_ARCH_TEGRA_186_SOC) || \
+    IS_ENABLED(CONFIG_ARCH_TEGRA_194_SOC)
+int tegra186_mc_probe_device(struct tegra_mc *mc, struct device *dev);
+#else
+static inline int tegra186_mc_probe_device(struct tegra_mc *mc, struct device *dev)
+{
+	return 0;
+}
+#endif
+
 #endif /* __SOC_TEGRA_MC_H__ */
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
