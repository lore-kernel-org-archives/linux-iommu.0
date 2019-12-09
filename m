Return-Path: <SRS0=4RPJ=Z7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8287CC2BD09
	for <iommu@archiver.kernel.org>; Mon,  9 Dec 2019 14:43:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 550EE207FD
	for <iommu@archiver.kernel.org>; Mon,  9 Dec 2019 14:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FO+mu1DF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 550EE207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 15F3E87598;
	Mon,  9 Dec 2019 14:43:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eFS46OhrQmQY; Mon,  9 Dec 2019 14:43:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6BB38862BC;
	Mon,  9 Dec 2019 14:43:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2AAA2C1796;
	Mon,  9 Dec 2019 14:43:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6008BC0881
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 14:43:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5A3B520336
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 14:43:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6dpDd6hC2qnP for <iommu@lists.linux-foundation.org>;
 Mon,  9 Dec 2019 14:43:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by silver.osuosl.org (Postfix) with ESMTPS id C5FDE203B4
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 14:43:00 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id t14so15191016wmi.5
 for <iommu@lists.linux-foundation.org>; Mon, 09 Dec 2019 06:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=R4K9ORFcKjOfhf7UVMWZdsJH8837cw9ZvD+EXPO6074=;
 b=FO+mu1DFbkNK4xBPEIcCtnOc9X0v+yOEp1bS+0oyVGZ28lmpMspr3NxrIU1xKiGtDy
 hQnhfV8LkSCAYKPheAcx9a3opmzZM8DPtsnF/rWNS/Sx7uuPiNK3PGKs0RgMmCotAfGf
 6fQ26e3wjpMTIPYtw8fO5Xpv79nwr8uV/XmselPkYcbEW2tgINBdGHJlLAa7IjePPhAm
 QrP+/4VZhM+UHZ+RN+z/MRF+3mo6BLj7Ec2y7SS0GlZDzZwqbLMfOc9ugc0KO6dTNlcI
 eN6OAR230oaoMxd5Lr5uCGOsvBqMNu5ktni53TI2dy7vTD8vvAxXU2e3cK5TNM3Jda52
 Kizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=R4K9ORFcKjOfhf7UVMWZdsJH8837cw9ZvD+EXPO6074=;
 b=YouYjDjC2Cl2q8XovML1s581U3uU7UwZTEe81BPeJsM6Op4cXgIPKS1MMGdmNeqWXW
 0A+Omh+L5wJ3F45K8FoNqaBxlZlZOzIZeG/OQR7xcYjlWW6dBD3PSGPeI2nyo+/Gp7XA
 p9zQ4MVsxVV5lHWx34THs6ytL5xqyKFBJhWQp3qADiH5JgYckCpJ1YIdVOLHVzhm0PvX
 VtgAkc4UNDp+Qll3j04kz+RfV1bjrZ0Tn8Pi+MEYnMWmxo/BCViLPyUzuS11Y6sns9kx
 0/jxPQSpwcds2skjLedwhsAO9twUcfsWuq3ONTf6uxLqyXPQU6zQIYKdoA3tYX2zxnL8
 xi6Q==
X-Gm-Message-State: APjAAAUYiTqi6L5orbkhOl/tFcFHXBDaI+0qHzQu4NQWz72b4g3+VSDx
 Xp5Swq3J978PyCNWl1N4y6E=
X-Google-Smtp-Source: APXvYqxPxr/O9qW6OPFOFKePg95mm5+7sPweVyKnhAjNAhhX8Rnn0avW5NyNIitXIcpT4UFiXbAYQg==
X-Received: by 2002:a05:600c:1108:: with SMTP id
 b8mr23503536wma.17.1575902579092; 
 Mon, 09 Dec 2019 06:42:59 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
 by smtp.gmail.com with ESMTPSA id u22sm30326898wru.30.2019.12.09.06.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2019 06:42:58 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 1/2] iommu: Implement of_iommu_get_resv_regions()
Date: Mon,  9 Dec 2019 15:42:55 +0100
Message-Id: <20191209144256.2396808-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>
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

This is an implementation that IOMMU drivers can use to obtain reserved
memory regions from a device tree node. It uses the reserved-memory DT
bindings to find the regions associated with a given device. These
regions will be used to create 1:1 mappings in the IOMMU domain that
the devices will be attached to.

Cc: Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/of_iommu.c | 39 +++++++++++++++++++++++++++++++++++++++
 include/linux/of_iommu.h |  8 ++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 026ad2b29dcd..d6b14fbef64a 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -11,6 +11,7 @@
 #include <linux/pci.h>
 #include <linux/msi.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_iommu.h>
 #include <linux/of_pci.h>
 #include <linux/slab.h>
@@ -227,3 +228,41 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 
 	return ops;
 }
+
+/**
+ * of_iommu_get_resv_regions - reserved region driver helper for device tree
+ * @dev: device for which to get reserved regions
+ * @list: reserved region list
+ *
+ * IOMMU drivers can use this to implement their .get_resv_regions() callback
+ * for memory regions attached to a device tree node. See the reserved-memory
+ * device tree bindings on how to use these:
+ *
+ *   Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
+ */
+void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
+{
+	struct of_phandle_iterator it;
+	int err;
+
+	of_for_each_phandle(&it, err, dev->of_node, "memory-region", NULL, 0) {
+		struct iommu_resv_region *region;
+		struct resource res;
+
+		err = of_address_to_resource(it.node, 0, &res);
+		if (err < 0) {
+			dev_err(dev, "failed to parse memory region %pOF: %d\n",
+				it.node, err);
+			continue;
+		}
+
+		region = iommu_alloc_resv_region(res.start, resource_size(&res),
+						 IOMMU_READ | IOMMU_WRITE,
+						 IOMMU_RESV_DIRECT_RELAXABLE);
+		if (!region)
+			continue;
+
+		list_add_tail(&region->list, list);
+	}
+}
+EXPORT_SYMBOL(of_iommu_get_resv_regions);
diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
index f3d40dd7bb66..fa16b26f55bc 100644
--- a/include/linux/of_iommu.h
+++ b/include/linux/of_iommu.h
@@ -15,6 +15,9 @@ extern int of_get_dma_window(struct device_node *dn, const char *prefix,
 extern const struct iommu_ops *of_iommu_configure(struct device *dev,
 					struct device_node *master_np);
 
+extern void of_iommu_get_resv_regions(struct device *dev,
+				      struct list_head *list);
+
 #else
 
 static inline int of_get_dma_window(struct device_node *dn, const char *prefix,
@@ -30,6 +33,11 @@ static inline const struct iommu_ops *of_iommu_configure(struct device *dev,
 	return NULL;
 }
 
+static inline void of_iommu_get_resv_regions(struct device *dev,
+					     struct list_head *list)
+{
+}
+
 #endif	/* CONFIG_OF_IOMMU */
 
 #endif /* __OF_IOMMU_H */
-- 
2.23.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
