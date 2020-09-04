Return-Path: <SRS0=mVMG=CN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C62FC433E2
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 13:00:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14AFB2074A
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 13:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgwp/mA5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14AFB2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E43DE87492;
	Fri,  4 Sep 2020 13:00:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eJUIbPoesqwj; Fri,  4 Sep 2020 13:00:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4ACB487459;
	Fri,  4 Sep 2020 13:00:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 315F6C07FF;
	Fri,  4 Sep 2020 13:00:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 540B7C0051
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:00:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4382085EF1
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:00:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7rk8noxd5Hta for <iommu@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 13:00:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
 [209.85.208.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9EF1D86C2C
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:00:09 +0000 (UTC)
Received: by mail-ed1-f65.google.com with SMTP id c10so5998927edk.6
 for <iommu@lists.linux-foundation.org>; Fri, 04 Sep 2020 06:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=G9XAHY9UguV3G7jomJ5XYwGLvO68uan6NVKz952gLlo=;
 b=fgwp/mA58GAYNA2+ofJOwDzpeN5xpHm7FGQCxsRmTpFiRg2hX328bdkJpVtclMBDL7
 EuVuqJKOHRB+Ct8ZHVRtM/yI4LAIzIGVV1jJuMsMWThbs/K4R3FRsREajruyYmGfo4dQ
 3jB//KFbIHXb3JftKf1vp+x2gONESXQlMWOnmLP2ELza9oQ1A36BZWxNZlGMKz9Ufy7p
 qRC9+GQH+JTk3ey9ggNDVAOt8q5BGYTDP538/P+hx5skahkufxqPHDBue7DshC+r3SSO
 gYuB9HRTDGzRBvHu9SlhIeWKruFWeNApN6trpxe6bkWZ+QKWOd8fdFgojPFWw+Jx49EB
 ZS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=G9XAHY9UguV3G7jomJ5XYwGLvO68uan6NVKz952gLlo=;
 b=ZqSvttt95MMm7R4qP2OlfuFUdytEWAJQeIvdFq3XTf5dkwcqatF5YLW/iyRSBtIldT
 eZ6772WmO9GJZhA7CSJIymrnzxBY0zDLl5Cph2WB49EzpMiqvSEG2/1QC0BFXmw+n9+Y
 Bp9C1MWdsTgGfyhs74DtcScNzQTLwneD6T5SWE+BOpcKCTim/pDocWhQeemDhv/9N0tb
 oAekDTjeocEeyk3B1HNuyfmSKPlVam1TjeVtGidG05Kjwtwr7TknEkYiGrhZR3VDIQEP
 dNHncBz5ts8oniZP2LQ7lk1k3tLTSQ7NF6Gn28boMRoZIcjDDTdUx6HvwZlSxngbgOBf
 AGIA==
X-Gm-Message-State: AOAM5315EcMrfxTePd2ChF7Gd8XSz4govUqqMgKmgGZnEIQxQoC4jZ/9
 xW0fKeJn3gWAkmWpDcMTPRc=
X-Google-Smtp-Source: ABdhPJwW0xIV+SxAIUlqnh145u1thzUzxQUReTdrcL9vZWI+gc6ajlJuqZ60q3zXkGj4A76V7oAETQ==
X-Received: by 2002:a50:f197:: with SMTP id x23mr8731973edl.367.1599224408121; 
 Fri, 04 Sep 2020 06:00:08 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id v23sm5990766ejh.84.2020.09.04.06.00.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 06:00:07 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 2/4] iommu: Implement of_iommu_get_resv_regions()
Date: Fri,  4 Sep 2020 14:59:58 +0200
Message-Id: <20200904130000.691933-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200904130000.691933-1-thierry.reding@gmail.com>
References: <20200904130000.691933-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Will Deacon <will@kernel.org>
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
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Hi Rob,

you had previously reviewed this patch, but I haven't included that here
because there's a new property now that you might not be okay with.

Thierry

Changes in v2:
- use "active" property to determine whether direct mapping are needed

 drivers/iommu/of_iommu.c | 49 ++++++++++++++++++++++++++++++++++++++++
 include/linux/of_iommu.h |  8 +++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index e505b9130a1c..3341d27fbbba 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/msi.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_iommu.h>
 #include <linux/of_pci.h>
 #include <linux/pci.h>
@@ -245,3 +246,51 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 
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
+		/*
+		 * Active memory regions are expected to be accessed by
+		 * hardware during boot and must therefore have an identity
+		 * mapping created prior to the driver taking control of the
+		 * hardware. This ensures that non-quiescent hardware doesn't
+		 * cause IOMMU faults during boot.
+		 */
+		if (!of_property_read_bool(it.node, "active"))
+			continue;
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
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
