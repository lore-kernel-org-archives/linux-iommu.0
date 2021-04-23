Return-Path: <SRS0=1bbG=JU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD13C43617
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 16:32:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A891E611C1
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 16:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A891E611C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C8D1843C5;
	Fri, 23 Apr 2021 16:32:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LiluVDIvjoZK; Fri, 23 Apr 2021 16:31:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4FEBE842A9;
	Fri, 23 Apr 2021 16:31:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2BBE7C000E;
	Fri, 23 Apr 2021 16:31:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31440C000B
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 16:31:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 13D8B842A9
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 16:31:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WqqXKxaGTkPp for <iommu@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 16:31:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3EEB583CB9
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 16:31:56 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id g17so57428696edm.6
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 09:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1VY28Z37MPEV6Kt+8joC6jx+HXlldXYlWb0gBBnzDC4=;
 b=qaMHOop5F7+0YNk9A67uQMd5OE8PSCE5QOa1iBh/LMr8E0Tirdwp4pfUQTzGPFHHb5
 9bsEnUCvZY5Y8Qo0pV/pygqnNN1/sag+yxO3r1g0lov6l3mMMNzoaruSt++Df5nsdPPw
 skv0XyQLzKEbtmwLdyJEATdfSAoPjBkP3U7MiVA9wg1VasGe90XASNogAm4F/Q54MYKh
 pxgKoNTtZ4r0V2tLFZOmmGE75xGga+rz0c7muJb4efXBojyTkyGhDMxdJXEXJFfi8IMc
 XollAZMEqOSb9XuxvCCCgpETuygTlrPB5JQIeAxXSQ/Dhr3B1m7eFZ9j1SIF8IeevaCi
 GVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1VY28Z37MPEV6Kt+8joC6jx+HXlldXYlWb0gBBnzDC4=;
 b=NZLrbZBceMC1dN9V5GH4QOLvKaBN6LW1KZEhth/vZDMyGUHr7Im/Oztzpthb9757y0
 viJcbZPupkpcvKs0eqMl+OZgEEnYC107Lehoby+k396MQsF0rFrwCgfUjlrYer4an5ju
 n/sJBMk+vf51JASy6MYOIXGPC69qGTPV1/K5vxrjws2+Aeculw/c++ZzU4LpvG3QBRJS
 roRDxpsbcOCfminxLkQQ7CFAAVJBjyaJ0e0AQbWNAZvuN2rJfA7E3TXDP40C27Gx4MD/
 /7vJXKW6WG667O3G3XTEMbLCmuhKsDctef/Wme5iQknn3Ao7oH00g2Fv8waUDtFEcIsh
 yXHg==
X-Gm-Message-State: AOAM533E+8r6G9RWJaMSdQdTYM2TDSYDYgyha0JSbKXUhzLPdKFxnuXN
 D/hn6NymSh2VENspk70kSAI=
X-Google-Smtp-Source: ABdhPJx6kev8Evs6lQORshsQLF8RGAF8MELC3qxbd+9sES40NAGXlFm/g7VleXHaG/jO3m87mjyTYg==
X-Received: by 2002:a05:6402:54f:: with SMTP id
 i15mr5535218edx.365.1619195514456; 
 Fri, 23 Apr 2021 09:31:54 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id o9sm4333335ejg.56.2021.04.23.09.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Apr 2021 09:31:53 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 2/5] iommu: Implement of_iommu_get_resv_regions()
Date: Fri, 23 Apr 2021 18:32:31 +0200
Message-Id: <20210423163234.3651547-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210423163234.3651547-1-thierry.reding@gmail.com>
References: <20210423163234.3651547-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, Nicolin Chen <nicolinc@nvidia.com>,
 linux-tegra@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
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
bindings to find the regions associated with a given device. If these
regions are marked accordingly, identity mappings will be created for
them in the IOMMU domain that the devices will be attached to.

Cc: Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v3:
- change "active" property to identity mapping flag that is part of the
  memory region specifier (as defined by #memory-region-cells) to allow
  per-reference flags to be used

Changes in v2:
- use "active" property to determine whether direct mappings are needed
---
 drivers/iommu/of_iommu.c | 54 ++++++++++++++++++++++++++++++++++++++++
 include/linux/of_iommu.h |  8 ++++++
 2 files changed, 62 insertions(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index a9d2df001149..321ebd5fdaba 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -11,12 +11,15 @@
 #include <linux/module.h>
 #include <linux/msi.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_iommu.h>
 #include <linux/of_pci.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/fsl/mc.h>
 
+#include <dt-bindings/reserved-memory.h>
+
 #define NO_IOMMU	1
 
 /**
@@ -240,3 +243,54 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 
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
+	of_for_each_phandle(&it, err, dev->of_node, "memory-region", "#memory-region-cells", 0) {
+		struct iommu_resv_region *region;
+		struct of_phandle_args args;
+		struct resource res;
+
+		args.args_count = of_phandle_iterator_args(&it, args.args, MAX_PHANDLE_ARGS);
+
+		err = of_address_to_resource(it.node, 0, &res);
+		if (err < 0) {
+			dev_err(dev, "failed to parse memory region %pOF: %d\n",
+				it.node, err);
+			continue;
+		}
+
+		if (args.args_count > 0) {
+			/*
+			 * Active memory regions are expected to be accessed by hardware during
+			 * boot and must therefore have an identity mapping created prior to the
+			 * driver taking control of the hardware. This ensures that non-quiescent
+			 * hardware doesn't cause IOMMU faults during boot.
+			 */
+			if (args.args[0] & MEMORY_REGION_IDENTITY_MAPPING) {
+				region = iommu_alloc_resv_region(res.start, resource_size(&res),
+								 IOMMU_READ | IOMMU_WRITE,
+								 IOMMU_RESV_DIRECT_RELAXABLE);
+				if (!region)
+					continue;
+
+				list_add_tail(&region->list, list);
+			}
+		}
+	}
+}
+EXPORT_SYMBOL(of_iommu_get_resv_regions);
diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
index 16f4b3e87f20..8412437acaac 100644
--- a/include/linux/of_iommu.h
+++ b/include/linux/of_iommu.h
@@ -16,6 +16,9 @@ extern const struct iommu_ops *of_iommu_configure(struct device *dev,
 					struct device_node *master_np,
 					const u32 *id);
 
+extern void of_iommu_get_resv_regions(struct device *dev,
+				      struct list_head *list);
+
 #else
 
 static inline int of_get_dma_window(struct device_node *dn, const char *prefix,
@@ -32,6 +35,11 @@ static inline const struct iommu_ops *of_iommu_configure(struct device *dev,
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
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
