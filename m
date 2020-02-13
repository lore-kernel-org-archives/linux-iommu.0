Return-Path: <SRS0=ZJ+1=4B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF7AC2BA83
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 16:40:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B154B24650
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 16:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOBGN7F6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B154B24650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7CC992152F;
	Thu, 13 Feb 2020 16:40:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2M6EYqzfKX0K; Thu, 13 Feb 2020 16:40:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 68CE921526;
	Thu, 13 Feb 2020 16:40:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 617E4C1D8E;
	Thu, 13 Feb 2020 16:40:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 232F0C0177
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 16:40:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1FC7E203F4
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 16:40:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FSVFu-6oKJxY for <iommu@lists.linux-foundation.org>;
 Thu, 13 Feb 2020 16:40:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 22DF821526
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 16:40:17 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id c9so7515443wrw.8
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 08:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OYWSVDDbY/UxSIzaZwoEm71Xw+c2/ceHjCKgkFAt7oc=;
 b=LOBGN7F6A+j/KSjmlfWKAL6xYBfzNY6jWq/aJt0gIVfRpWfAdpTomvbazv587FWCH4
 b/jLQO2aILx3cSL6MH6XlveVUiXrJp6WYV6aTNox5A5uYyXlqIVkutunXN7PdA6YJPOM
 i+aDHTC0xR7l5mJ/0q0uMx9lDOtuH3TWZHMCaoCbk66JMPp0T5lUh7rYwEluVoxipwhJ
 2pcEfBwmhfTLC0DSn6OjH7g5Bp4TdoXUJEIVC8r3n+XEZin08tulv6BagQSY7vXyS1TU
 JAKfqoLYunkSTGldInLrCBlTL/PXTyG92O15pRv6cFXwf8qlxemwTUTMZSDK0OTHSMuz
 D5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OYWSVDDbY/UxSIzaZwoEm71Xw+c2/ceHjCKgkFAt7oc=;
 b=LppCiBGHK80cpEQDAS2i2EvgbvkpCdT5rQUhpeFWIG10wD7wimTpHu3T3Fta0xk+2S
 MV5RLGfnBphukLVSgPy9lZdskGliEzUVbEvRyPJl8cMgJf4vgOiAMI24E3UTK39qH92G
 CWP0wVpb7nHKQkxzu1FLoqTaVbvY2KkiajSHz8dRt3TSjdU+i4XCRVpemKIXuPC7z6tu
 PxjfSAFnj9jKhaV3KdP/z+AGvIyMYtFzKBWXQmfobK0G/aLEadiX3oqHwqo062YJM8nT
 /lOttaWtLcwLhyhb5HjAHsDA7Thk0fOIY+TVE1/YmhghaM4sg+g7CnzbVDximueBWQZk
 T+4g==
X-Gm-Message-State: APjAAAWoWlm+kCl+Hgt1pYhjSj0EMQPJUsxlO5niajx+aihB1AgVlIOm
 wpoTQ4e/9HTJSQyok0hfBQs=
X-Google-Smtp-Source: APXvYqwcKc8OQOLbjhzBWeyXihMSClM0SSK/ywAQmwsvkxrLdQEL2WkFxm0wyd0LYcMkdI11IjjTZg==
X-Received: by 2002:a5d:6151:: with SMTP id y17mr22130398wrt.110.1581612015663; 
 Thu, 13 Feb 2020 08:40:15 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
 by smtp.gmail.com with ESMTPSA id o9sm592460wrw.20.2020.02.13.08.40.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 08:40:14 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 4/5] memory: tegra186: Register as memory controller
Date: Thu, 13 Feb 2020 17:39:58 +0100
Message-Id: <20200213163959.819733-5-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213163959.819733-1-thierry.reding@gmail.com>
References: <20200213163959.819733-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

Registering as memory controller allows other drivers to obtain a
reference to it. This is mostly useful as a way of ordering probe
between devices depending on one another.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/memory/tegra/tegra186.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
index 5d53f11ca7b6..8c43702340e8 100644
--- a/drivers/memory/tegra/tegra186.c
+++ b/drivers/memory/tegra/tegra186.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/io.h>
+#include <linux/memory-controller.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/of_device.h>
@@ -32,6 +33,7 @@ struct tegra186_mc_soc {
 };
 
 struct tegra186_mc {
+	struct memory_controller base;
 	struct device *dev;
 	void __iomem *regs;
 
@@ -1532,13 +1534,18 @@ static int tegra186_mc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	mc->soc = of_device_get_match_data(&pdev->dev);
+	mc->dev = &pdev->dev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	mc->regs = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(mc->regs))
 		return PTR_ERR(mc->regs);
 
-	mc->dev = &pdev->dev;
+	mc->base.dev = &pdev->dev;
+
+	err = memory_controller_register(&mc->base);
+	if (err < 0)
+		return err;
 
 	err = of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
 	if (err < 0)
-- 
2.24.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
