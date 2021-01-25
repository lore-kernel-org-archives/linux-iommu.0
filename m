Return-Path: <SRS0=REuq=G4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21586C433E6
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 11:08:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B46FE229C7
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 11:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B46FE229C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8BA6F867CD;
	Mon, 25 Jan 2021 11:08:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EkfGA8NUsLQ4; Mon, 25 Jan 2021 11:08:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7F1F48671F;
	Mon, 25 Jan 2021 11:08:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64874C1E6F;
	Mon, 25 Jan 2021 11:08:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7DAF4C013A
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 11:08:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 76D4086762
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 11:08:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lNOcLDgIbgWT for <iommu@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 11:08:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C0589866F7
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 11:08:45 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id f16so1362036wmq.5
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 03:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=D32J+akdetMmA5Myd4Zx5B3eWdLb4pZJ7wlpCkerL8M=;
 b=sIgFUy1B4NVZTMdif41pOLYx/+zRTjX1CmBp28JOvA9dBq+ncegVdQKTKx6zFKpMA0
 RLrBDORpb4Wopov1wmsqCNwtxU/OTA+4T/HidEMzrcX/l10yuWmh2vn1tHVSCMf1WGwn
 k/I3+x++pEPyRk48uxdzw2k8HGR8Ad4NRGsrzffLFLL0/IVqTdb8ajx4Lw+x49oM0mb+
 iPBIL+SI8d3oTuaFhQanBe3jnURITn3n3J5wb8bR46LkJ/HFRCz+dKaO+UEi+7Murd4i
 KSPMi9rgFEX2zKXtfEEoY7s4DzLcaxbp9ooMwRJIcrA/HFyS6BmTyiujmteB8sgRLdFG
 CK3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=D32J+akdetMmA5Myd4Zx5B3eWdLb4pZJ7wlpCkerL8M=;
 b=jNrkp7IrnXzbhE5UQztHTy3kg+iBan10dc9oiGy2wc3rlHIhHaQRM63YM0MVJQWRHI
 IfpAk4SmnTRfe+2sOtGKrKyUbn22bdl98uB0g5DjL/n+KEEe7xyUKcZe592Zjw0+LB+9
 wlp+J3+BEZsUj1obvn7zK4QN7GQ/+/TT0x/bH3Gz0TWGgDSdixWuJYGyD3Cjm5/YWwoE
 jeUktNEHBDnWv9H5/FlJIo2YXyjUgc64ILNzta+pRPn0EX048PJWNz27MzZb/0PwadKo
 aiiN+piNNS6EdpXJqBxm4EITPgS2qzmRaVvgT+yMWUvBH2IGaLwru7jRJ1W+gE+rC60o
 oydQ==
X-Gm-Message-State: AOAM530UJkM0vnz3/CypITz86qompcczYfVVSPZ+NHbFF7X4GBmBdJ0R
 vfHUzy98TztMjzldYOoN458Ftw==
X-Google-Smtp-Source: ABdhPJwWUAbaa+u9PhjGecAC0HvYf8RfDHP6EKMUj3KGOJ93rmXeB4FDwvfcCPo+QdcrgOx8578F9Q==
X-Received: by 2002:a05:600c:4ed3:: with SMTP id
 g19mr579133wmq.95.1611572924335; 
 Mon, 25 Jan 2021 03:08:44 -0800 (PST)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id u6sm16636014wro.75.2021.01.25.03.08.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Jan 2021 03:08:43 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v11 02/10] iommu/arm-smmu-v3: Use device properties for
 pasid-num-bits
Date: Mon, 25 Jan 2021 12:06:43 +0100
Message-Id: <20210125110650.3232195-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210125110650.3232195-1-jean-philippe@linaro.org>
References: <20210125110650.3232195-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: vivek.gautam@arm.com, guohanjun@huawei.com,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, linux-acpi@vger.kernel.org,
 zhangfei.gao@linaro.org, lenb@kernel.org, devicetree@vger.kernel.org,
 kevin.tian@intel.com, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 rjw@rjwysocki.net, iommu@lists.linux-foundation.org, sudeep.holla@arm.com,
 robin.murphy@arm.com, linux-accelerators@lists.ozlabs.org
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

The pasid-num-bits property shouldn't need a dedicated fwspec field,
it's a job for device properties. Add properties for IORT, and access
the number of PASID bits using device_property_read_u32().

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/linux/iommu.h                       |  2 --
 drivers/acpi/arm64/iort.c                   | 13 +++++++------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  3 ++-
 drivers/iommu/of_iommu.c                    |  5 -----
 4 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index bdf3f34a4457..b7ea11fc1a93 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -571,7 +571,6 @@ struct iommu_group *fsl_mc_device_group(struct device *dev);
  * @ops: ops for this device's IOMMU
  * @iommu_fwnode: firmware handle for this device's IOMMU
  * @flags: IOMMU_FWSPEC_* flags
- * @num_pasid_bits: number of PASID bits supported by this device
  * @num_ids: number of associated device IDs
  * @ids: IDs which this device may present to the IOMMU
  */
@@ -579,7 +578,6 @@ struct iommu_fwspec {
 	const struct iommu_ops	*ops;
 	struct fwnode_handle	*iommu_fwnode;
 	u32			flags;
-	u32			num_pasid_bits;
 	unsigned int		num_ids;
 	u32			ids[];
 };
diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index d4eac6d7e9fb..c9a8bbb74b09 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -968,15 +968,16 @@ static int iort_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
 static void iort_named_component_init(struct device *dev,
 				      struct acpi_iort_node *node)
 {
+	struct property_entry props[2] = {};
 	struct acpi_iort_named_component *nc;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-
-	if (!fwspec)
-		return;
 
 	nc = (struct acpi_iort_named_component *)node->node_data;
-	fwspec->num_pasid_bits = FIELD_GET(ACPI_IORT_NC_PASID_BITS,
-					   nc->node_flags);
+	props[0] = PROPERTY_ENTRY_U32("pasid-num-bits",
+				      FIELD_GET(ACPI_IORT_NC_PASID_BITS,
+						nc->node_flags));
+
+	if (device_add_properties(dev, props))
+		dev_warn(dev, "Could not add device properties\n");
 }
 
 static int iort_nc_iommu_map(struct device *dev, struct acpi_iort_node *node)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index baebaac34a83..88dd9feb32f4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2392,7 +2392,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 		}
 	}
 
-	master->ssid_bits = min(smmu->ssid_bits, fwspec->num_pasid_bits);
+	device_property_read_u32(dev, "pasid-num-bits", &master->ssid_bits);
+	master->ssid_bits = min(smmu->ssid_bits, master->ssid_bits);
 
 	/*
 	 * Note that PASID must be enabled before, and disabled after ATS:
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index e505b9130a1c..a9d2df001149 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -210,11 +210,6 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 					     of_pci_iommu_init, &info);
 	} else {
 		err = of_iommu_configure_device(master_np, dev, id);
-
-		fwspec = dev_iommu_fwspec_get(dev);
-		if (!err && fwspec)
-			of_property_read_u32(master_np, "pasid-num-bits",
-					     &fwspec->num_pasid_bits);
 	}
 
 	/*
-- 
2.30.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
