Return-Path: <SRS0=SFHS=AY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECC7C433E5
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 09:35:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4D7F2068F
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 09:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Dc8HNhuT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4D7F2068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5AFFD873EF;
	Mon, 13 Jul 2020 09:35:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E3qRc2eE6KqQ; Mon, 13 Jul 2020 09:35:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E1CA28758A;
	Mon, 13 Jul 2020 09:35:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B88EFC0733;
	Mon, 13 Jul 2020 09:35:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D9CAC0733
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 09:12:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3810B86F45
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 09:12:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o-XOVvonLpJo for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jul 2020 09:12:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com
 [209.85.215.196])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9E33386F43
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 09:12:54 +0000 (UTC)
Received: by mail-pg1-f196.google.com with SMTP id j19so5746538pgm.11
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 02:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2pjchSlwME4GrTpEw7XTrDCwU1gG4HJg02FXR22Hkas=;
 b=Dc8HNhuThCDkktDS6B+WjGZyK0LdkXIxeRs+uY86mwkgQgeDrNeZBcgHv+dr/VgE8i
 99LjcelPnCB6GxqIqDnK+19HuhjUyqsLTqBZV76hoWI+PhdoeFHI4rolEPvfQ03OsjQj
 T0K19kPY3cx28Xa3O40GxC3+syA37DHUIx4xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2pjchSlwME4GrTpEw7XTrDCwU1gG4HJg02FXR22Hkas=;
 b=tEdiZE0Svju87uzOuMHJ+2rFS5+TmQkBk9xnqRajgi/hI+AKkh9yLLVS6h1lZV4ux0
 Ic7Ft9eR8oPgLObfYEL5yLmyz2IAsWziJ0hUsUNvqCgkBCHzdNfUVSNT/9KaGuOdpoHJ
 umuFkwo+l80dYe0WEvz0YgTvBcJcOEpmiO7rRFo7kjCt/2vXR8cNEMYaH7ClYoyb0qf9
 6uQ0dziTzdxHzUsqe2LWsOqG4xQEYJUkqbWoQVL/0DS3BfQE+V0rF5t2y3xB8GIYc35B
 GH1WM07Qi02wTxvhAoHloQ6Z3CXY0r5gsPZD6mLEtcuJjpzkNwGil89R63j3K95XlYvS
 R+Bw==
X-Gm-Message-State: AOAM5335I7mtC6Fz1YGuS9ONrqCVj8GC9F1k6smaQr3QJUO0rgSzQwMi
 Wi5LjbueQDp72MiWqSe3qOLsWw==
X-Google-Smtp-Source: ABdhPJzCBz1wXNm6srY4fV+QTPs1p1GBdSr9wd1N0xPtsZeiUu/632nKu46kLsgjWtntLiQYzALTzw==
X-Received: by 2002:a63:140a:: with SMTP id u10mr71073813pgl.238.1594631574223; 
 Mon, 13 Jul 2020 02:12:54 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:3e52:82ff:fe5e:cc9d])
 by smtp.gmail.com with ESMTPSA id kk6sm10887305pjb.1.2020.07.13.02.12.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 02:12:53 -0700 (PDT)
From: Claire Chang <tientzu@chromium.org>
To: robh+dt@kernel.org, frowand.list@gmail.com, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com
Subject: [PATCH 4/4] of: Add plumbing for bounced DMA pool
Date: Mon, 13 Jul 2020 17:12:11 +0800
Message-Id: <20200713091211.2183368-5-tientzu@chromium.org>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
In-Reply-To: <20200713091211.2183368-1-tientzu@chromium.org>
References: <20200713091211.2183368-1-tientzu@chromium.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 13 Jul 2020 09:35:23 +0000
Cc: devicetree@vger.kernel.org, heikki.krogerus@linux.intel.com,
 saravanak@google.com, suzuki.poulose@arm.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, bgolaszewski@baylibre.com,
 iommu@lists.linux-foundation.org, drinkcat@chromium.org,
 Claire Chang <tientzu@chromium.org>, dan.j.williams@intel.com,
 treding@nvidia.com
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

If a device is not behind an IOMMU, we look up the device node and set
up the bounced DMA when the bounced-dma property is presented. One can
specify two reserved-memory nodes in the device tree. One with
shared-dma-pool to handle the coherent DMA buffer allocation, and
another one with bounced-dma-pool for regular DMA to/from system memory,
which would be subject to bouncing.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 drivers/of/address.c    | 37 +++++++++++++++++++++++++++++++++++++
 drivers/of/device.c     |  3 +++
 drivers/of/of_private.h |  6 ++++++
 3 files changed, 46 insertions(+)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 8eea3f6e29a4..a767b80f8862 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -8,6 +8,7 @@
 #include <linux/logic_pio.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/pci.h>
 #include <linux/pci_regs.h>
 #include <linux/sizes.h>
@@ -1009,6 +1010,42 @@ int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *siz
 	return ret;
 }
 
+int of_dma_set_bounce_buffer(struct device *dev)
+{
+	int length, size, ret, i;
+	u32 idx[2];
+
+	if (!dev || !dev->of_node)
+		return -EINVAL;
+
+	if (!of_get_property(dev->of_node, "bounced-dma", &length))
+		return 0;
+
+	size = length / sizeof(idx[0]);
+	if (size > ARRAY_SIZE(idx)) {
+		dev_err(dev,
+			"bounced-dma expected less than or equal to 2 indexs, but got %d\n",
+			size);
+		return -EINVAL;
+	}
+
+	ret = of_property_read_u32_array(dev->of_node, "bounced-dma", idx,
+					 size);
+
+	for (i = 0; i < size; i++) {
+		ret = of_reserved_mem_device_init_by_idx(dev, dev->of_node,
+							 idx[i]);
+		if (ret) {
+			dev_err(dev,
+				"of_reserved_mem_device_init_by_idx() failed with %d\n",
+				ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 /**
  * of_dma_is_coherent - Check if device is coherent
  * @np:	device node
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 27203bfd0b22..238beef48a50 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -169,6 +169,9 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
 
 	arch_setup_dma_ops(dev, dma_addr, size, iommu, coherent);
 
+	if (!iommu)
+		return of_dma_set_bounce_buffer(dev);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_dma_configure);
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index edc682249c00..3d1b8cca1519 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -160,12 +160,18 @@ extern int of_bus_n_size_cells(struct device_node *np);
 #ifdef CONFIG_OF_ADDRESS
 extern int of_dma_get_range(struct device_node *np, u64 *dma_addr,
 			    u64 *paddr, u64 *size);
+extern int of_dma_set_bounce_buffer(struct device *dev);
 #else
 static inline int of_dma_get_range(struct device_node *np, u64 *dma_addr,
 				   u64 *paddr, u64 *size)
 {
 	return -ENODEV;
 }
+
+static inline int of_dma_get_bounce_buffer(struct device *dev)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* _LINUX_OF_PRIVATE_H */
-- 
2.27.0.383.g050319c2ae-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
