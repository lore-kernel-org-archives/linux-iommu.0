Return-Path: <SRS0=5SFN=56=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADC2C54FC9
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 17:04:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EBAC206A2
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 17:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z/x8cPL2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EBAC206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1807721FAD;
	Tue, 14 Apr 2020 17:04:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eiW0X8bAy4ky; Tue, 14 Apr 2020 17:04:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 269E42156B;
	Tue, 14 Apr 2020 17:04:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15263C089E;
	Tue, 14 Apr 2020 17:04:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D0F9C0172
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 17:04:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5BE5086DE7
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 17:04:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OY6fVTFJU1rL for <iommu@lists.linux-foundation.org>;
 Tue, 14 Apr 2020 17:04:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D3CBA8681A
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 17:04:31 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id y24so14905206wma.4
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 10:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=erC/yZ4yqf+8sj3sT7z9RmtS2eJz/nnIlww3PMj9LNg=;
 b=Z/x8cPL2SESYSfgT7USIjcJ03j+yB0RlxWlgpL06IaYNqQQiDsvaIHSi8h1/6csvx5
 kK3IN5C+qcarpFXtn3clOaAiwcKXNvVa1EWM/usyv6coAE89GVxlq0y+++3RZEk606mS
 eK/EjQn6TUpXWOsA1a0nlNknOXuMZrhFMHmCmBAyiUyODyk/I0jtGaFPz3zFkgOjmMZf
 uD2X83kt/GQjoEZq/g3kTgLEpNi3zTYhvueIqbfhi3Y4uoytjUedxC4iTy6yeOtZC8Nv
 yQnYlRAUvzb6xUuSOOjFLyw5N5rMpXC5onjkVSQrucRWu0tMM59YEgFJOBJCzYIEWPgN
 8ZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=erC/yZ4yqf+8sj3sT7z9RmtS2eJz/nnIlww3PMj9LNg=;
 b=aPCWKSiyn0aTO6NYYlkpmITx3+CGf03P6e/1CDRtW7mwrnAD8u1TyNIfrxU5Atb8U3
 or/tgiqkcrKjUIW8xKjuFJrSIGYesTZIf1H9kW6mJTgNxoEKVdRm+d/kNK+DHnQt9msG
 0YwV9yvKFapvdCf6FG4JBzr1vMEFOm5TzptMjidQACM3i31zwLUr2INnHohkkP1ZyBzn
 NtGKUKvRAIYehvvg/CJECeDcKLtTrMLOCESNGrssz9Vo+0MMiyprrBqcimLG3nta6dGQ
 yhsQN4wNRzXuHBFwec0IRd/66YDsMEtVnpUgUxXyFTTKqKBsb3uSgWs1+Zh3QtXTchQ7
 wH4Q==
X-Gm-Message-State: AGi0PuaBSJveucyAFtmtYPwVHHQakd2yifOlP8TaMDpPgzggvqJ3KjJX
 KBES5Kdxg1WNGcaGxDxhMQ2hgpxaJHV8ww==
X-Google-Smtp-Source: APiQypII+WOd1DdLkhhXCc4VJ0kp8rxI4M4if6Dbn88/uuwISRQZtuLUUNyYcRkEY4LiB2fY33DLlA==
X-Received: by 2002:a7b:c313:: with SMTP id k19mr802495wmj.100.1586883870064; 
 Tue, 14 Apr 2020 10:04:30 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id x18sm19549147wrs.11.2020.04.14.10.04.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 10:04:29 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org
Subject: [PATCH v5 09/25] iommu/io-pgtable-arm: Move some definitions to a
 header
Date: Tue, 14 Apr 2020 19:02:37 +0200
Message-Id: <20200414170252.714402-10-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200414170252.714402-1-jean-philippe@linaro.org>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 catalin.marinas@arm.com, robin.murphy@arm.com, jgg@ziepe.ca,
 zhangfei.gao@linaro.org, will@kernel.org, christian.koenig@amd.com
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

Extract some of the most generic TCR defines, so they can be reused by
the page table sharing code.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/io-pgtable-arm.h | 30 ++++++++++++++++++++++++++++++
 drivers/iommu/io-pgtable-arm.c | 27 ++-------------------------
 2 files changed, 32 insertions(+), 25 deletions(-)
 create mode 100644 drivers/iommu/io-pgtable-arm.h

diff --git a/drivers/iommu/io-pgtable-arm.h b/drivers/iommu/io-pgtable-arm.h
new file mode 100644
index 0000000000000..ba7cfdf7afa03
--- /dev/null
+++ b/drivers/iommu/io-pgtable-arm.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef IO_PGTABLE_ARM_H_
+#define IO_PGTABLE_ARM_H_
+
+#define ARM_LPAE_TCR_TG0_4K		0
+#define ARM_LPAE_TCR_TG0_64K		1
+#define ARM_LPAE_TCR_TG0_16K		2
+
+#define ARM_LPAE_TCR_TG1_16K		1
+#define ARM_LPAE_TCR_TG1_4K		2
+#define ARM_LPAE_TCR_TG1_64K		3
+
+#define ARM_LPAE_TCR_SH_NS		0
+#define ARM_LPAE_TCR_SH_OS		2
+#define ARM_LPAE_TCR_SH_IS		3
+
+#define ARM_LPAE_TCR_RGN_NC		0
+#define ARM_LPAE_TCR_RGN_WBWA		1
+#define ARM_LPAE_TCR_RGN_WT		2
+#define ARM_LPAE_TCR_RGN_WB		3
+
+#define ARM_LPAE_TCR_PS_32_BIT		0x0ULL
+#define ARM_LPAE_TCR_PS_36_BIT		0x1ULL
+#define ARM_LPAE_TCR_PS_40_BIT		0x2ULL
+#define ARM_LPAE_TCR_PS_42_BIT		0x3ULL
+#define ARM_LPAE_TCR_PS_44_BIT		0x4ULL
+#define ARM_LPAE_TCR_PS_48_BIT		0x5ULL
+#define ARM_LPAE_TCR_PS_52_BIT		0x6ULL
+
+#endif /* IO_PGTABLE_ARM_H_ */
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 04fbd4bf0ff9f..f71a2eade04ab 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -20,6 +20,8 @@
 
 #include <asm/barrier.h>
 
+#include "io-pgtable-arm.h"
+
 #define ARM_LPAE_MAX_ADDR_BITS		52
 #define ARM_LPAE_S2_MAX_CONCAT_PAGES	16
 #define ARM_LPAE_MAX_LEVELS		4
@@ -100,23 +102,6 @@
 #define ARM_LPAE_PTE_MEMATTR_DEV	(((arm_lpae_iopte)0x1) << 2)
 
 /* Register bits */
-#define ARM_LPAE_TCR_TG0_4K		0
-#define ARM_LPAE_TCR_TG0_64K		1
-#define ARM_LPAE_TCR_TG0_16K		2
-
-#define ARM_LPAE_TCR_TG1_16K		1
-#define ARM_LPAE_TCR_TG1_4K		2
-#define ARM_LPAE_TCR_TG1_64K		3
-
-#define ARM_LPAE_TCR_SH_NS		0
-#define ARM_LPAE_TCR_SH_OS		2
-#define ARM_LPAE_TCR_SH_IS		3
-
-#define ARM_LPAE_TCR_RGN_NC		0
-#define ARM_LPAE_TCR_RGN_WBWA		1
-#define ARM_LPAE_TCR_RGN_WT		2
-#define ARM_LPAE_TCR_RGN_WB		3
-
 #define ARM_LPAE_VTCR_SL0_MASK		0x3
 
 #define ARM_LPAE_TCR_T0SZ_SHIFT		0
@@ -124,14 +109,6 @@
 #define ARM_LPAE_VTCR_PS_SHIFT		16
 #define ARM_LPAE_VTCR_PS_MASK		0x7
 
-#define ARM_LPAE_TCR_PS_32_BIT		0x0ULL
-#define ARM_LPAE_TCR_PS_36_BIT		0x1ULL
-#define ARM_LPAE_TCR_PS_40_BIT		0x2ULL
-#define ARM_LPAE_TCR_PS_42_BIT		0x3ULL
-#define ARM_LPAE_TCR_PS_44_BIT		0x4ULL
-#define ARM_LPAE_TCR_PS_48_BIT		0x5ULL
-#define ARM_LPAE_TCR_PS_52_BIT		0x6ULL
-
 #define ARM_LPAE_MAIR_ATTR_SHIFT(n)	((n) << 3)
 #define ARM_LPAE_MAIR_ATTR_MASK		0xff
 #define ARM_LPAE_MAIR_ATTR_DEVICE	0x04
-- 
2.26.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
