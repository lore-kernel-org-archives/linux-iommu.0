Return-Path: <SRS0=nChL=KW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0446FC4707F
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 19:37:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5A606124C
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 19:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5A606124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 74B50607DA;
	Thu, 27 May 2021 19:37:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 18YZCs6vDtwN; Thu, 27 May 2021 19:37:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id C684160C0E;
	Thu, 27 May 2021 19:37:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C280C000D;
	Thu, 27 May 2021 19:37:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 982C9C0001
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 19:37:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7A0F340178
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 19:37:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VQKq5eDrgem5 for <iommu@lists.linux-foundation.org>;
 Thu, 27 May 2021 19:37:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com
 [209.85.210.42])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EAF1740157
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 19:37:17 +0000 (UTC)
Received: by mail-ot1-f42.google.com with SMTP id
 r26-20020a056830121ab02902a5ff1c9b81so1281954otp.11
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 12:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ydVf7ZObUZ9d00EfB5ZI51TsSKUWLoqndzojvJxksJI=;
 b=OUAAu3el5QKvwGcMy0nqEzPuTNhk4KWuFEX3yeYT1f13l/noM4H4cAl+wLkjwVViL9
 JWt78L2aZm30EH2+ry1A8FzHYf/cAVsZECMLBl/D4fZwQC3tA4Cgip/zRSdplmTGxE+g
 /qYj40RAOU3qmAFUg0dFXIf3rzyX+R/DIkz5foTd5BKRvcUbVjHgp8bTy0s+MJ5kSajJ
 bmI3cB6yTjYWppyBVscz8l9te8QaGBt/Q1hv7lBlaSQ4LsSvgoTjxju+KHogGvmyBu7Y
 vrgTHytFvCX284jaa2Fsju3P8p3FczKq+4rq9yOYNJUpkUj/RbRCv3Jo38CtOmbL0Ig1
 4wAg==
X-Gm-Message-State: AOAM533bNa/QfkBHiNy9asBleD9mggj+CsZDoiUfsdjlUVHSA6nB4DB4
 P+U5t9LB7iHEj332oKIPrg==
X-Google-Smtp-Source: ABdhPJzervBtcn0XaaGl+UgFIm39GPEoGp6MshHYI+rdKb4tJQcdTUZxXJdmW/wWTN9+7JUtZ1wG6Q==
X-Received: by 2002:a9d:12d6:: with SMTP id g80mr4036707otg.107.1622144237034; 
 Thu, 27 May 2021 12:37:17 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id v19sm686961otk.22.2021.05.27.12.37.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 May 2021 12:37:13 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 2/2] iommu: Drop unnecessary of_iommu.h includes
Date: Thu, 27 May 2021 14:37:10 -0500
Message-Id: <20210527193710.1281746-2-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210527193710.1281746-1-robh@kernel.org>
References: <20210527193710.1281746-1-robh@kernel.org>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Frank Rowand <frowand.list@gmail.com>, linux-arm-kernel@lists.infradead.org
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

The only place of_iommu.h is needed is in drivers/of/device.c. Remove it
from everywhere else.

Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Yong Wu <yong.wu@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: iommu@lists.linux-foundation.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 -
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 1 -
 drivers/iommu/arm/arm-smmu/qcom_iommu.c     | 1 -
 drivers/iommu/exynos-iommu.c                | 1 -
 drivers/iommu/ipmmu-vmsa.c                  | 1 -
 drivers/iommu/msm_iommu.c                   | 1 -
 drivers/iommu/mtk_iommu.c                   | 1 -
 drivers/iommu/mtk_iommu_v1.c                | 1 -
 drivers/iommu/omap-iommu.c                  | 1 -
 drivers/iommu/rockchip-iommu.c              | 1 -
 drivers/iommu/virtio-iommu.c                | 1 -
 drivers/of/platform.c                       | 1 -
 12 files changed, 12 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 54b2f27b81d4..2ddc3cd5a7d1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -23,7 +23,6 @@
 #include <linux/msi.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_iommu.h>
 #include <linux/of_platform.h>
 #include <linux/pci.h>
 #include <linux/pci-ats.h>
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 6f72c4d208ca..dba15f312cbd 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -31,7 +31,6 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
-#include <linux/of_iommu.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 4294abe389b2..021cf8f65ffc 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -25,7 +25,6 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
-#include <linux/of_iommu.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 7623d8c371f5..d0fbf1d10e18 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -17,7 +17,6 @@
 #include <linux/kmemleak.h>
 #include <linux/list.h>
 #include <linux/of.h>
-#include <linux/of_iommu.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index aaa6a4d59057..51ea6f00db2f 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -19,7 +19,6 @@
 #include <linux/iommu.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/of_iommu.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/sizes.h>
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 7880f307cb2d..3a38352b603f 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -18,7 +18,6 @@
 #include <linux/iommu.h>
 #include <linux/clk.h>
 #include <linux/err.h>
-#include <linux/of_iommu.h>
 
 #include <asm/cacheflush.h>
 #include <linux/sizes.h>
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index e06b8a0e2b56..6f7c69688ce2 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -19,7 +19,6 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
-#include <linux/of_iommu.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 5915d7b38211..778e66f5f1aa 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -22,7 +22,6 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
-#include <linux/of_iommu.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 26e517eb0dd3..91749654fd49 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -22,7 +22,6 @@
 #include <linux/io.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
-#include <linux/of_iommu.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/regmap.h>
diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 7a2932772fdf..bb50e015b1d5 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -21,7 +21,6 @@
 #include <linux/mm.h>
 #include <linux/init.h>
 #include <linux/of.h>
-#include <linux/of_iommu.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 7c02481a81b4..d9f46f2c3058 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -14,7 +14,6 @@
 #include <linux/interval_tree.h>
 #include <linux/iommu.h>
 #include <linux/module.h>
-#include <linux/of_iommu.h>
 #include <linux/of_platform.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 25d448f5af91..74afbb7a4f5e 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -17,7 +17,6 @@
 #include <linux/slab.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
-#include <linux/of_iommu.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
