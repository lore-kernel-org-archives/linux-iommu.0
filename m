Return-Path: <SRS0=Z7Xn=ZO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C8FC432C0
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 10:58:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA28020721
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 10:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YNEi/CQb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA28020721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BC0C587646;
	Fri, 22 Nov 2019 10:58:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yoJtnLhovl1r; Fri, 22 Nov 2019 10:58:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1EC9986B6B;
	Fri, 22 Nov 2019 10:58:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14ED6C1DD8;
	Fri, 22 Nov 2019 10:58:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60E79C18DA
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 10:58:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 47D1725D78
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 10:58:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BhJB07lthz97 for <iommu@lists.linux-foundation.org>;
 Fri, 22 Nov 2019 10:58:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by silver.osuosl.org (Postfix) with ESMTPS id 28A4921526
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 10:58:35 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id 4so4754902wro.7
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 02:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qRDncnEv4s95CgSa1yvYrULV0iuYi2jZhVWKJTRAVu0=;
 b=YNEi/CQbRXtkAwf0pPEyl5prqRn8u5HZ5xYtYrRJWWkt3EHX92cjZa+ZJIy6EgzQMY
 JomcQEQZ9aHxpyPv5xUr8gzpIvqxnMSJDzlZzKuglBou7QBJ8izCjPyAp5gagAMgiSTy
 8/Tp82wscT0Sev3YneHxCoFu66z2uQW1GImKYPrOPHwBJ+eCbINzD7/G0fD3TYBod7yi
 cXSfkjUy19kRIUpzuBATTRkMQ1lFky+4zyrQkjA9B+Fb+7/32I9fa7POnzm7YS7U86Ce
 NYiXSZoHwEnBnTVK2qCqhRV3tiLJKL/mgFahWAwg2v9n6ttfmUegZHJDqNkVa8wtqyzH
 PvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qRDncnEv4s95CgSa1yvYrULV0iuYi2jZhVWKJTRAVu0=;
 b=UPh3eZ3q5ow9rUsJMTeEWYT02Yn6IfWSXGg6s8TIL+XSbcdHaxQFKKNwuRSEFaBXWz
 QMgHTmXx1qXYTS6mlpVCeZ5RUa3KkyKFeY1oLzR0+9uH5mMytGtmNZXB28pdLQTkHq+W
 iVYsKmmo/WnqgjHeU0SwKrd/GnHJwufi5NGWmBv+p1KydHEuYwOGqGTXNuPvsuXVBusZ
 EET8DNJlRAbbGzKPOiz+6DaXgT72lVIvbcMwEGBEvbH9wSy+hRXG1SbusqY/m3wUg1vy
 Fct7+oLcSUSsFZJPyefZrYeLEZwZDdWI3g+tKRm74h7spdhJwl2Ikvy1Xv0iC3FDyDeL
 yhKg==
X-Gm-Message-State: APjAAAU1rkLQ/JuTUFd2cPOxqHjqVB5u5WoX0S5Gq6oUplQv62/Ihx9U
 l2DsjBKALhiWKG0M3njHo+lfLA==
X-Google-Smtp-Source: APXvYqzXiSDh39VIufdE8cTUkRB2hfptRNr1/jdFpr07MvIngTSRR794NgxmfjDCLcPXZDKMLSVPnQ==
X-Received: by 2002:a5d:49c4:: with SMTP id t4mr10152262wrs.226.1574419857729; 
 Fri, 22 Nov 2019 02:50:57 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-204-106.adslplus.ch.
 [188.155.204.106])
 by smtp.gmail.com with ESMTPSA id o133sm2088197wmb.4.2019.11.22.02.50.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2019 02:50:57 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org,
 virtualization@lists.linux-foundation.org, linux-pci@vger.kernel.org,
 virtio-dev@lists.oasis-open.org
Subject: [RFC 05/13] ACPI/IORT: Support VIOT virtio-mmio node
Date: Fri, 22 Nov 2019 11:49:52 +0100
Message-Id: <20191122105000.800410-6-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122105000.800410-1-jean-philippe@linaro.org>
References: <20191122105000.800410-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: kevin.tian@intel.com, mst@redhat.com, gregkh@linuxfoundation.org,
 sudeep.holla@arm.com, rjw@rjwysocki.net, sebastien.boeuf@intel.com,
 jacob.jun.pan@intel.com, guohanjun@huawei.com, bhelgaas@google.com,
 jasowang@redhat.com, lenb@kernel.org
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

Add a new type of node to the IORT driver, that describes a virtio-iommu
device based on the virtio-mmio transport. The node is only available
when the IORT is a sub-table of the VIOT.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/acpi/iort.c | 66 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/iort.c b/drivers/acpi/iort.c
index 1d43fbc0001f..adc5953fffa5 100644
--- a/drivers/acpi/iort.c
+++ b/drivers/acpi/iort.c
@@ -43,7 +43,8 @@ static bool iort_type_matches(u8 type, enum iort_node_category category)
 	switch (category) {
 	case IORT_IOMMU_TYPE:
 		return type == ACPI_IORT_NODE_SMMU ||
-		       type == ACPI_IORT_NODE_SMMU_V3;
+		       type == ACPI_IORT_NODE_SMMU_V3 ||
+		       type == ACPI_VIOT_IORT_NODE_VIRTIO_MMIO_IOMMU;
 	case IORT_MSI_TYPE:
 		return type == ACPI_IORT_NODE_ITS_GROUP;
 	default:
@@ -868,8 +869,10 @@ static inline bool iort_iommu_driver_enabled(u8 type)
 		return IS_BUILTIN(CONFIG_ARM_SMMU_V3);
 	case ACPI_IORT_NODE_SMMU:
 		return IS_BUILTIN(CONFIG_ARM_SMMU);
+	case ACPI_VIOT_IORT_NODE_VIRTIO_MMIO_IOMMU:
+		return IS_ENABLED(CONFIG_VIRTIO_IOMMU);
 	default:
-		pr_warn("IORT node type %u does not describe an SMMU\n", type);
+		pr_warn("IORT node type %u does not describe an IOMMU\n", type);
 		return false;
 	}
 }
@@ -1408,6 +1411,46 @@ static int __init arm_smmu_v3_pmcg_add_platdata(struct platform_device *pdev)
 	return platform_device_add_data(pdev, &model, sizeof(model));
 }
 
+static int __init viommu_mmio_count_resources(struct acpi_iort_node *node)
+{
+	/* Mem + IRQ */
+	return 2;
+}
+
+static void __init viommu_mmio_init_resources(struct resource *res,
+					   struct acpi_iort_node *node)
+{
+	int hw_irq, trigger;
+	struct acpi_viot_iort_virtio_mmio_iommu *viommu;
+
+	viommu = (struct acpi_viot_iort_virtio_mmio_iommu *)node->node_data;
+
+	res[0].start = viommu->base_address;
+	res[0].end = viommu->base_address + viommu->span - 1;
+	res[0].flags = IORESOURCE_MEM;
+
+	hw_irq = IORT_IRQ_MASK(viommu->interrupt);
+	trigger = IORT_IRQ_TRIGGER_MASK(viommu->interrupt);
+	acpi_iort_register_irq(hw_irq, "viommu", trigger, res + 1);
+}
+
+static void __init viommu_mmio_dma_configure(struct device *dev,
+					  struct acpi_iort_node *node)
+{
+	enum dev_dma_attr attr;
+	struct acpi_viot_iort_virtio_mmio_iommu *viommu;
+
+	viommu = (struct acpi_viot_iort_virtio_mmio_iommu *)node->node_data;
+
+	attr = (viommu->flags & ACPI_VIOT_IORT_VIRTIO_MMIO_IOMMU_CACHE_COHERENT) ?
+		DEV_DMA_COHERENT : DEV_DMA_NON_COHERENT;
+
+	dev->dma_mask = &dev->coherent_dma_mask;
+
+	/* Configure DMA for the page table walker */
+	acpi_dma_configure(dev, attr);
+}
+
 struct iort_dev_config {
 	const char *name;
 	int (*dev_init)(struct acpi_iort_node *node);
@@ -1443,6 +1486,14 @@ static const struct iort_dev_config iort_arm_smmu_v3_pmcg_cfg __initconst = {
 	.dev_add_platdata = arm_smmu_v3_pmcg_add_platdata,
 };
 
+static const struct iort_dev_config iort_viommu_mmio_cfg __initconst = {
+	/* Probe with the generic virtio-mmio driver */
+	.name = "virtio-mmio",
+	.dev_dma_configure = viommu_mmio_dma_configure,
+	.dev_count_resources = viommu_mmio_count_resources,
+	.dev_init_resources = viommu_mmio_init_resources,
+};
+
 static __init const struct iort_dev_config *iort_get_dev_cfg(
 			struct acpi_iort_node *node)
 {
@@ -1453,9 +1504,16 @@ static __init const struct iort_dev_config *iort_get_dev_cfg(
 		return &iort_arm_smmu_cfg;
 	case ACPI_IORT_NODE_PMCG:
 		return &iort_arm_smmu_v3_pmcg_cfg;
-	default:
-		return NULL;
 	}
+
+	if (iort_table_source == IORT_SOURCE_VIOT) {
+		switch (node->type) {
+		case ACPI_VIOT_IORT_NODE_VIRTIO_MMIO_IOMMU:
+			return &iort_viommu_mmio_cfg;
+		}
+	}
+
+	return NULL;
 }
 
 /**
-- 
2.24.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
