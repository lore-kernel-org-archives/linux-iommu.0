Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 597FCC433FE
	for <iommu@archiver.kernel.org>; Thu, 20 Jan 2022 20:42:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 21ABB415BD;
	Thu, 20 Jan 2022 20:42:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6n-t6bQVX9Cu; Thu, 20 Jan 2022 20:42:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0A41340215;
	Thu, 20 Jan 2022 20:42:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D495C0078;
	Thu, 20 Jan 2022 20:42:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45996C002F
 for <iommu@lists.linux-foundation.org>; Thu, 20 Jan 2022 20:20:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BEA4E414CD
 for <iommu@lists.linux-foundation.org>; Thu, 20 Jan 2022 20:20:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 40_1moFfYUBt for <iommu@lists.linux-foundation.org>;
 Thu, 20 Jan 2022 20:20:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 606EF41643
 for <iommu@lists.linux-foundation.org>; Thu, 20 Jan 2022 20:20:03 +0000 (UTC)
Received: by mail-lf1-x12a.google.com with SMTP id b14so26072373lff.3
 for <iommu@lists.linux-foundation.org>; Thu, 20 Jan 2022 12:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qHMBzi7x2OFj/PiKKy+8Sw+4QHkYBdO7GhGQ2rRzgfc=;
 b=gI7M7f4w9Ec64LvvhZiOGgyL7gfY6VYmyaDSqBfPbnnTqPNfKLfbtGYYcgPSGDu09O
 ngQL2ieRaz1PkOdds05NGuOilMz5knFBMJqinNGYh0MtKAocIS87ajzaXXHPl5Q5KgO3
 DCx3HRWdBYt4mxFiilHkTUFPomMpJADFOcWYnNu4rzg5ojF/ogLbU1TfKgNhtC2/reLp
 jWHR13SgrKtbuILwUCkCWAhfIZQVbhntEGczbf+POVCUb6J7Cx/157gD0grp9gvRLvwI
 1KLJnsljzfBKBnjCdmmwDP5fTU6CN/A0s/tp3lGG/vAyRVDPmAW/91krzC2KrLgXNm3m
 1VJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qHMBzi7x2OFj/PiKKy+8Sw+4QHkYBdO7GhGQ2rRzgfc=;
 b=qg0a8TZYsFaRn2HIATrFGcJer55Bw7Ew+Ohv9Ba9yFMf447rLF8RDlBfNDFNoLXGev
 WUA95ks2KE/yfmsg2uhLdFW8VhGOqlX0wEXeKiLhfTSdDn6SatT9oXurH8EwgItPKO/6
 HHBBjzq59Q//Xpc308v2Q2XrNa4it2c75SoAVuCBNcuup1Qw5AqCPRk/N/Y4lVWZ3CGk
 2SJKmhJ03tQJZXHRKx50o5zKulNTPQO/ifBgf0ySQZGaXQQ+WckIyK3+ey+8TF+ryTuP
 Cg3k2Yg7sfyXZSiA9QXEU1SzvJ9sm/YXPjRPccnSaXf0NVE6fVmlBbT5LQT5TscJXKfE
 NDzw==
X-Gm-Message-State: AOAM530H9M1T9iocwN7eJ5rH7DMwzIRMppq9/lDnhuNdeh8VH6EmyRmf
 jxBDHq6WgbU8yOxIIfsa571r8Q==
X-Google-Smtp-Source: ABdhPJz9MCqm4mf16pWvfozG0/iMnkcOzRIZ4U4OufHVSDiFa/AIkBn2S3ErqIBTk0WXuzurOufRsw==
X-Received: by 2002:ac2:58cc:: with SMTP id u12mr732654lfo.263.1642710001392; 
 Thu, 20 Jan 2022 12:20:01 -0800 (PST)
Received: from localhost ([31.134.121.151])
 by smtp.gmail.com with ESMTPSA id a12sm22620lfo.168.2022.01.20.12.20.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jan 2022 12:20:00 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [RFC 1/3] dt-bindings: iommu: Add bindings for samsung,sysmmu-v8
Date: Thu, 20 Jan 2022 22:19:56 +0200
Message-Id: <20220120201958.2649-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220120201958.2649-1-semen.protsenko@linaro.org>
References: <20220120201958.2649-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 20 Jan 2022 20:42:08 +0000
Cc: Janghyuck Kim <janghyuck.kim@samsung.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Carlos Llamas <cmllamas@google.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-samsung-soc@vger.kernel.org,
 Mark Salyzyn <salyzyn@google.com>, Jinkyu Yang <jinkyu1.yang@samsung.com>,
 Thierry Strudel <tstrudel@google.com>, Will McVicker <willmcvicker@google.com>,
 Cho KyongHo <pullip.cho@samsung.com>, linux-arm-kernel@lists.infradead.org,
 Jonglin Lee <jonglin@google.com>, "J . Avila" <elavila@google.com>,
 Alex <acnwigwe@google.com>, linux-kernel@vger.kernel.org,
 Hyesoo Yu <hyesoo.yu@samsung.com>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
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

Only example of usage and header for now.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 .../bindings/iommu/samsung,sysmmu-v8.txt      | 31 +++++++++++++
 include/dt-bindings/soc/samsung,sysmmu-v8.h   | 43 +++++++++++++++++++
 2 files changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/samsung,sysmmu-v8.txt
 create mode 100644 include/dt-bindings/soc/samsung,sysmmu-v8.h

diff --git a/Documentation/devicetree/bindings/iommu/samsung,sysmmu-v8.txt b/Documentation/devicetree/bindings/iommu/samsung,sysmmu-v8.txt
new file mode 100644
index 000000000000..d6004ea4a746
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/samsung,sysmmu-v8.txt
@@ -0,0 +1,31 @@
+Example (Exynos850, IOMMU for DPU usage):
+
+	#include <dt-bindings/soc/samsung,sysmmu-v8.h>
+
+	/* IOMMU group info */
+	iommu_group_dpu: iommu_group_dpu {
+		compatible = "samsung,sysmmu-group";
+	};
+
+	sysmmu_dpu: sysmmu@130c0000 {
+		compatible = "samsung,sysmmu-v8";
+		reg = <0x130c0000 0x9000>;
+		interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
+		qos = <15>;
+
+		clocks = <&cmu_dpu CLK_GOUT_DPU_SMMU_CLK>;
+		clock-names = "gate";
+
+		sysmmu,secure-irq;
+		sysmmu,secure_base = <0x130d0000>;
+		sysmmu,default_tlb = <TLB_CFG(BL1, PREFETCH_PREDICTION)>;
+		sysmmu,tlb_property =
+			<1 TLB_CFG(BL1, PREFETCH_PREDICTION) (DIR_READ | (1 << 16)) SYSMMU_ID_MASK(0x2, 0xF)>,
+			<2 TLB_CFG(BL1, PREFETCH_PREDICTION) (DIR_READ | (1 << 16)) SYSMMU_ID_MASK(0x4, 0xF)>,
+			<3 TLB_CFG(BL1, PREFETCH_PREDICTION) (DIR_READ | (1 << 16)) SYSMMU_ID_MASK(0x6, 0xF)>,
+			<4 TLB_CFG(BL1, PREFETCH_PREDICTION) (DIR_READ | (1 << 16)) SYSMMU_ID_MASK(0x8, 0xF)>;
+		port-name = "DPU";
+		#iommu-cells = <0>;
+		//power-domains = <&pd_dpu>;
+	};
diff --git a/include/dt-bindings/soc/samsung,sysmmu-v8.h b/include/dt-bindings/soc/samsung,sysmmu-v8.h
new file mode 100644
index 000000000000..2d422e05dae1
--- /dev/null
+++ b/include/dt-bindings/soc/samsung,sysmmu-v8.h
@@ -0,0 +1,43 @@
+/*
+ * Copyright (c) 2014 Samsung Electronics Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Device Tree binding constants for Exynos System MMU.
+ */
+
+#ifndef _DT_BINDINGS_SAMSUNG_SYSMMU_V8_H
+#define _DT_BINDINGS_SAMSUNG_SYSMMU_V8_H
+
+/* define for fetchsize in TLB_CFG */
+#define BL1			(0x0 << 5)
+#define BL2			(0x1 << 5)
+#define BL4			(0x2 << 5)
+#define BL8			(0x3 << 5)
+#define BL16			(0x4 << 5)
+#define BL32			(0x5 << 5)
+#define BL64			(0x6 << 5)
+
+/* define for prefetch in TLB_CFG */
+#define PREFETCH_NONE		(0x0 << 1)
+#define PREFETCH_DESCENDING	(0x1 << 1)
+#define PREFETCH_ASCENDING	(0x3 << 1)
+#define PREFETCH_PREDICTION	(0x5 << 1)
+
+/* combine fetchsize and prefetch */
+#define TLB_CFG(fetchsize, prefetch)	(fetchsize | prefetch)
+#define TLB_CFG_DEFAULT		0x0
+
+/* define for direction in TLB_MATCH_CFG */
+#define DIR_NONE		(0x0 << 8)
+#define DIR_READ		(0x1 << 8)
+#define DIR_WRITE		(0x2 << 8)
+#define DIR_RW			(0x3 << 8)
+
+/* define for TLB_MATCH_SID */
+#define SYSMMU_ID_MASK(id,mask)		((mask) << 16 | (id))
+#define SYSMMU_NOID			0
+
+#endif /* _DT_BINDINGS_SAMSUNG_SYSMMU_V8_H */
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
