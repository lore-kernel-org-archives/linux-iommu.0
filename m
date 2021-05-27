Return-Path: <SRS0=nChL=KW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CA6C47089
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 19:37:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF83961222
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 19:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF83961222
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8896D40178;
	Thu, 27 May 2021 19:37:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rFMwo6n3h2lC; Thu, 27 May 2021 19:37:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6C16340103;
	Thu, 27 May 2021 19:37:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4BF01C000D;
	Thu, 27 May 2021 19:37:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80AB6C0001
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 19:37:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6713160C06
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 19:37:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zU0zmN6tjkF4 for <iommu@lists.linux-foundation.org>;
 Thu, 27 May 2021 19:37:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com
 [209.85.210.46])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9AAA4607DA
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 19:37:13 +0000 (UTC)
Received: by mail-ot1-f46.google.com with SMTP id
 i23-20020a9d68d70000b02902dc19ed4c15so1352143oto.0
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 12:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bM7teNdrWGeeKeqjqgBnHJlc51CGMA8O85N2k47LNWU=;
 b=PoATwADsoPbKTfPrYrc/SyuZrSWyMjiQCbIkZrSfOf3HFRq6cjJ6D/D4Tt4gCb4Y7X
 3DhyvKxWj+hLXoFn9YXziGFbAGKZ0PO6tPL5WwXAYLo+p+jaIKJuOVzK6xwfqYvuPPaN
 hS8XGaaNZbQ6+6ItGVajd9fa5OOOgEITA0Z4dfx6PYPe5onOSFOXEFTblhKM3nRsZJ/x
 QUGU1F2YOU+LY+tKb5bRTGjUdaNYHOW8MAYlBjEOP4/5mCoi34Y0BufjEZlNWT+DK1FR
 1HmnnfyjvjRMXXZBlBfCGTeg1wpsaO0IxQRl8Y4tJvT11bhpgaHicLxoAcC8wVXZsX+I
 uapg==
X-Gm-Message-State: AOAM533S+KvU6BgJytmLyhT7y5uC/Pbasry1EMvgxJ1QRNC58sj9KXVb
 pcxEWACa86E7yQVFfOXDNw==
X-Google-Smtp-Source: ABdhPJx2rk5aR8F+8SGi4lpbgHbvMF3hS2pg2ZQp9GUKOHBvp00wBGsABpF8lvv25hTCyEwBuONAig==
X-Received: by 2002:a05:6830:1e54:: with SMTP id
 e20mr4116083otj.227.1622144232461; 
 Thu, 27 May 2021 12:37:12 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id v19sm686961otk.22.2021.05.27.12.37.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 May 2021 12:37:11 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 1/2] iommu: Remove unused of_get_dma_window()
Date: Thu, 27 May 2021 14:37:09 -0500
Message-Id: <20210527193710.1281746-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, iommu@lists.linux-foundation.org,
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

of_get_dma_window() was added in 2012 and removed in 2014 in commit
891846516317 ("memory: Add NVIDIA Tegra memory controller support").
Remove it and simplify the header to use forward declarations for
structs rather than includes.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: iommu@lists.linux-foundation.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/iommu/of_iommu.c | 68 ----------------------------------------
 include/linux/of_iommu.h | 17 ++--------
 2 files changed, 3 insertions(+), 82 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index a9d2df001149..5696314ae69e 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -19,74 +19,6 @@
 
 #define NO_IOMMU	1
 
-/**
- * of_get_dma_window - Parse *dma-window property and returns 0 if found.
- *
- * @dn: device node
- * @prefix: prefix for property name if any
- * @index: index to start to parse
- * @busno: Returns busno if supported. Otherwise pass NULL
- * @addr: Returns address that DMA starts
- * @size: Returns the range that DMA can handle
- *
- * This supports different formats flexibly. "prefix" can be
- * configured if any. "busno" and "index" are optionally
- * specified. Set 0(or NULL) if not used.
- */
-int of_get_dma_window(struct device_node *dn, const char *prefix, int index,
-		      unsigned long *busno, dma_addr_t *addr, size_t *size)
-{
-	const __be32 *dma_window, *end;
-	int bytes, cur_index = 0;
-	char propname[NAME_MAX], addrname[NAME_MAX], sizename[NAME_MAX];
-
-	if (!dn || !addr || !size)
-		return -EINVAL;
-
-	if (!prefix)
-		prefix = "";
-
-	snprintf(propname, sizeof(propname), "%sdma-window", prefix);
-	snprintf(addrname, sizeof(addrname), "%s#dma-address-cells", prefix);
-	snprintf(sizename, sizeof(sizename), "%s#dma-size-cells", prefix);
-
-	dma_window = of_get_property(dn, propname, &bytes);
-	if (!dma_window)
-		return -ENODEV;
-	end = dma_window + bytes / sizeof(*dma_window);
-
-	while (dma_window < end) {
-		u32 cells;
-		const void *prop;
-
-		/* busno is one cell if supported */
-		if (busno)
-			*busno = be32_to_cpup(dma_window++);
-
-		prop = of_get_property(dn, addrname, NULL);
-		if (!prop)
-			prop = of_get_property(dn, "#address-cells", NULL);
-
-		cells = prop ? be32_to_cpup(prop) : of_n_addr_cells(dn);
-		if (!cells)
-			return -EINVAL;
-		*addr = of_read_number(dma_window, cells);
-		dma_window += cells;
-
-		prop = of_get_property(dn, sizename, NULL);
-		cells = prop ? be32_to_cpup(prop) : of_n_size_cells(dn);
-		if (!cells)
-			return -EINVAL;
-		*size = of_read_number(dma_window, cells);
-		dma_window += cells;
-
-		if (cur_index++ == index)
-			break;
-	}
-	return 0;
-}
-EXPORT_SYMBOL_GPL(of_get_dma_window);
-
 static int of_iommu_xlate(struct device *dev,
 			  struct of_phandle_args *iommu_spec)
 {
diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
index 16f4b3e87f20..55c1eb300a86 100644
--- a/include/linux/of_iommu.h
+++ b/include/linux/of_iommu.h
@@ -2,29 +2,18 @@
 #ifndef __OF_IOMMU_H
 #define __OF_IOMMU_H
 
-#include <linux/device.h>
-#include <linux/iommu.h>
-#include <linux/of.h>
+struct device;
+struct device_node;
+struct iommu_ops;
 
 #ifdef CONFIG_OF_IOMMU
 
-extern int of_get_dma_window(struct device_node *dn, const char *prefix,
-			     int index, unsigned long *busno, dma_addr_t *addr,
-			     size_t *size);
-
 extern const struct iommu_ops *of_iommu_configure(struct device *dev,
 					struct device_node *master_np,
 					const u32 *id);
 
 #else
 
-static inline int of_get_dma_window(struct device_node *dn, const char *prefix,
-			    int index, unsigned long *busno, dma_addr_t *addr,
-			    size_t *size)
-{
-	return -EINVAL;
-}
-
 static inline const struct iommu_ops *of_iommu_configure(struct device *dev,
 					 struct device_node *master_np,
 					 const u32 *id)
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
