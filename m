Return-Path: <SRS0=VFJV=IA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60828C433DB
	for <iommu@archiver.kernel.org>; Tue,  2 Mar 2021 09:35:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC5B764F1B
	for <iommu@archiver.kernel.org>; Tue,  2 Mar 2021 09:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC5B764F1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7A6ED4F136;
	Tue,  2 Mar 2021 09:35:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NSzru4BZyT9b; Tue,  2 Mar 2021 09:35:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 178324F10E;
	Tue,  2 Mar 2021 09:35:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B452FC0013;
	Tue,  2 Mar 2021 09:35:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20A2FC0001
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 09:35:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1082D43096
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 09:35:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z3TYKwkBeOEs for <iommu@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 09:35:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3C9D643069
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 09:35:34 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id u14so19099678wri.3
 for <iommu@lists.linux-foundation.org>; Tue, 02 Mar 2021 01:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YldRYT03xwkqqahy3TqrWZQZDsJFb2h5IF4zYpZYWmw=;
 b=w+rdPO0JHTT2L2/3tw009CCOXkBgpshsEaSpLWqdi7dX1sjMwtm1fFiJW6+EEJQZ0/
 oTCzvgEeKGnexhDYqAt+R0PaePsYyfx4xa4qp1EbQjyfp1WdpU2KfIh1Hv21rjyBxEK5
 uVaxBEa5yUxPB6jniFP+zmwSkbcxCCn1zRO+dHx2VNs3Rw/mNyK6Z+UmWHb3LRNfxIxo
 DYyRLXTQM+UWRBu5/+17pOKch8qRZj4/f15wdaLKYkI4zxvA1jPlzRczVQd0ZmKt3tFM
 Lc3GCSZdScNztMRGazdmWgK+fDLXvxC8e0QBiOYXZoxo1WqmLJ3Oe5ZhjjcNX9rFDos/
 Ob2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YldRYT03xwkqqahy3TqrWZQZDsJFb2h5IF4zYpZYWmw=;
 b=WMqPKtfLFvVGlr7H3n2wvXKT8aopiRFHka6hmWqVh9UjfIRv2wAWbLs7CU1V1e5Zc1
 Xc68E43Nz8Ybn+XPtE16du0GQnDEc8c0kLF8V4hIzJOD/P5m48CwdnHn27J+H2tVHv/l
 PxB3ptbplPSXhp/l2D8viXL330kRLbEJxfYW/KrRuXzWdRrM9qksptyxjWD4taEeooZi
 cN2C5BQUi2f+dLEzMmK/CbiIacZF7EQ8YMOLndXru12FdMbpEk69KW9BPYkLGvLIvVhz
 naHu22cs1I8y0hSwhqdo7bgu9RcmLpZA9UAnqXaStq/s45tbChBUFUrf3PNFfx6Whjo2
 7Ngw==
X-Gm-Message-State: AOAM533XwoFk5aptm8rZjqsY6gh+jcCJRVsq8VyygWagvY9EAhX8tWA4
 s+TH8nvC/RceW5uzraQ+15rbTw==
X-Google-Smtp-Source: ABdhPJziUR7m/6sWv8w2q6YqohX5h02MqXZ7Bt3V5/veYoCEwom/Pgu7ispfA5hf1cn38y3xw7HAGg==
X-Received: by 2002:a5d:6a86:: with SMTP id s6mr7586863wru.307.1614677732520; 
 Tue, 02 Mar 2021 01:35:32 -0800 (PST)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id w131sm1963818wmb.8.2021.03.02.01.35.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Mar 2021 01:35:32 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v13 02/10] iommu/arm-smmu-v3: Use device properties for
 pasid-num-bits
Date: Tue,  2 Mar 2021 10:26:38 +0100
Message-Id: <20210302092644.2553014-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302092644.2553014-1-jean-philippe@linaro.org>
References: <20210302092644.2553014-1-jean-philippe@linaro.org>
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
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/linux/iommu.h                       |  2 --
 drivers/acpi/arm64/iort.c                   | 13 +++++++------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  3 ++-
 drivers/iommu/of_iommu.c                    |  5 -----
 4 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 1d422bf722a1..16ce75693d83 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -572,7 +572,6 @@ struct iommu_group *fsl_mc_device_group(struct device *dev);
  * @ops: ops for this device's IOMMU
  * @iommu_fwnode: firmware handle for this device's IOMMU
  * @flags: IOMMU_FWSPEC_* flags
- * @num_pasid_bits: number of PASID bits supported by this device
  * @num_ids: number of associated device IDs
  * @ids: IDs which this device may present to the IOMMU
  */
@@ -580,7 +579,6 @@ struct iommu_fwspec {
 	const struct iommu_ops	*ops;
 	struct fwnode_handle	*iommu_fwnode;
 	u32			flags;
-	u32			num_pasid_bits;
 	unsigned int		num_ids;
 	u32			ids[];
 };
diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 2494138a6905..3912a1f6058e 100644
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
index 8594b4a83043..7edce914c45e 100644
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
2.30.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
