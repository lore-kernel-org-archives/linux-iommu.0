Return-Path: <SRS0=68Au=FS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7708FC4361B
	for <iommu@archiver.kernel.org>; Mon, 14 Dec 2020 12:52:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07541206C3
	for <iommu@archiver.kernel.org>; Mon, 14 Dec 2020 12:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07541206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 86196866C7;
	Mon, 14 Dec 2020 12:52:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5YIBxKftX7cy; Mon, 14 Dec 2020 12:52:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B2FB38667D;
	Mon, 14 Dec 2020 12:52:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96910C0893;
	Mon, 14 Dec 2020 12:52:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9633EC013B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Dec 2020 12:52:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 83F8986587
 for <iommu@lists.linux-foundation.org>; Mon, 14 Dec 2020 12:52:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cYy-0eTZ4pyP for <iommu@lists.linux-foundation.org>;
 Mon, 14 Dec 2020 12:52:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 20E7F8657C
 for <iommu@lists.linux-foundation.org>; Mon, 14 Dec 2020 12:52:03 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id c133so1535342wme.4
 for <iommu@lists.linux-foundation.org>; Mon, 14 Dec 2020 04:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=uA7Oxs/wyvYUE1Q5Z79HLkOoFQjgdYG73UpryFEtyeo=;
 b=A7JTYmymCT84foHfhEmNIHr/pEfSygaw0il7x05bSBXymRtmnEeQ9s8NImWZYvG1bR
 IJ7xCY9OfQNEa/YTNBx2CJk7Ipe6KY895wWjACUQcgcAwrrpE4Jqm8k7W/CzO6YM4aR/
 dscM1fFxsl/sItEgQ3EkazFzVcCs2S7RTUHBTYW31rZbDmyyz0X1ZLZMoXi3UKDQySQH
 gyixWe2v4wPss1+mh04uaNzSADC1nZCcohSWb/6SDx4QQlplS7Ew13lBe+/dE6xkGvdS
 aiKO2/ys+HAjPf1PsTGTiBKRnGpAosT6yCiq3CWjYQaTagjjvEcyO/TG5vcVPGXf3plk
 kSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=uA7Oxs/wyvYUE1Q5Z79HLkOoFQjgdYG73UpryFEtyeo=;
 b=m62iAF8hJ3JK4EGQIIxMcpHSDOqU9H9U+RuERK+DtggoR5bZZgheaTnLf5YuyY41Ez
 gUyT03Oq7wUTAE1DQ4S9hMFnVIadcvsrxTAvkZZ9PbE6KYVCAUaGtuQ8PGYV86F7YFaF
 ntCujMqPfjYsMRcwmd9dsCMBv6bIowzcx8OXeAqSXgPgaXfMvyoJbobw1FuMEeK9+6Oe
 JA8+Ezm76OUV4aD8/0KQzjx6wC7qTVwBJ8gphPZUUnIPmZ/NoeJFsadIaHay8yZdagwi
 nW4//W7dHGV5D95pnVjPBZ7CJXYJMhxla/xCdSOxXHVwoE3CkdAQ9vp/WtOLLfIflGVt
 o78g==
X-Gm-Message-State: AOAM531NcDqU6bTpbFh4IqD8c0PPQTUz3nScglnJbsRnKaj4iq4vo5DK
 zIp1X7nM3Oyh0cv34QEwNaeH+A==
X-Google-Smtp-Source: ABdhPJy7ckFB91jTR/PoEmgcekJEn+mvUgXVeEpBAXlu4Plmu8X+fq263Z3FizP3RlKSLXwiHojtUg==
X-Received: by 2002:a1c:b7d4:: with SMTP id h203mr27925588wmf.59.1607950321431; 
 Mon, 14 Dec 2020 04:52:01 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id j15sm31263649wrr.85.2020.12.14.04.51.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Dec 2020 04:52:00 -0800 (PST)
Date: Mon, 14 Dec 2020 13:51:41 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v8 4/9] of/iommu: Support dma-can-stall property
Message-ID: <X9dS9H9PrOZbND9E@myrica>
References: <20201112125519.3987595-1-jean-philippe@linaro.org>
 <20201112125519.3987595-5-jean-philippe@linaro.org>
 <d0a61d79-82fc-3af8-570e-e2ae3d485455@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d0a61d79-82fc-3af8-570e-e2ae3d485455@arm.com>
Cc: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, guohanjun@huawei.com, rjw@rjwysocki.net,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org, sudeep.holla@arm.com,
 bhelgaas@google.com, zhangfei.gao@linaro.org, vivek.gautam@arm.com,
 will@kernel.org, linux-arm-kernel@lists.infradead.org, lenb@kernel.org
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

On Thu, Nov 26, 2020 at 06:09:26PM +0000, Robin Murphy wrote:
> On 2020-11-12 12:55, Jean-Philippe Brucker wrote:
> > Copy the dma-can-stall property into the fwspec structure.
> 
> Can't we just handle this as a regular device property? It's not part of the
> actual IOMMU specifier, it doesn't need to be translated in any way, and
> AFAICS it's used a grand total of once, in a slow path. Simply treating it
> as the per-device property that it is should require zero additional code
> for DT, and a simple device_add_properties() call for IORT.
> 
> TBH that appears to be true of pasid-num-bits as well.

Right I think that's better, thanks for the pointer. I'll take care of
pasid-num-bits too. The Huawei quirk (fake PCIe supporting stall) is a
little worse this way, but it should work.

Thanks,
Jean

---
Diff untested on ACPI:

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e7b40e569488..ad5c55bc45b2 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -591,8 +591,6 @@ struct iommu_group *fsl_mc_device_group(struct device *dev);
 struct iommu_fwspec {
 	const struct iommu_ops	*ops;
 	struct fwnode_handle	*iommu_fwnode;
-	u32			num_pasid_bits;
-	bool			can_stall;
 	unsigned int		num_ids;
 	u32			ids[];
 };
diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index aa76e775bd6d..1582f6585741 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -960,16 +960,19 @@ static int iort_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
 static void iort_named_component_init(struct device *dev,
 				      struct acpi_iort_node *node)
 {
+	struct property_entry props[3] = {};
 	struct acpi_iort_named_component *nc;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-
-	if (!fwspec)
-		return;

 	nc = (struct acpi_iort_named_component *)node->node_data;
-	fwspec->num_pasid_bits = FIELD_GET(ACPI_IORT_NC_PASID_BITS,
-					   nc->node_flags);
-	fwspec->can_stall = (nc->node_flags & ACPI_IORT_NC_STALL_SUPPORTED);
+
+	props[0] = PROPERTY_ENTRY_U32("pasid-num-bits",
+				      FIELD_GET(ACPI_IORT_NC_PASID_BITS,
+						nc->node_flags));
+	if (nc->node_flags & ACPI_IORT_NC_STALL_SUPPORTED)
+		props[1] = PROPERTY_ENTRY_BOOL("dma-can-stall");
+
+	if (device_add_properties(dev, props))
+		dev_warn(dev, "Could not register device properties\n");
 }

 static int iort_nc_iommu_map(struct device *dev, struct acpi_iort_node *node)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 521ec7f0b2a0..571bd7c35a62 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2842,7 +2842,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 	if (ret)
 		goto err_free_master;

-	master->ssid_bits = min(smmu->ssid_bits, fwspec->num_pasid_bits);
+	device_property_read_u32(dev, "pasid-num-bits", &master->ssid_bits);
+	master->ssid_bits = min(smmu->ssid_bits, master->ssid_bits);

 	/*
 	 * Note that PASID must be enabled before, and disabled after ATS:
@@ -2858,7 +2859,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 		master->ssid_bits = min_t(u8, master->ssid_bits,
 					  CTXDESC_LINEAR_CDMAX);

-	if ((smmu->features & ARM_SMMU_FEAT_STALLS && fwspec->can_stall) ||
+	if ((smmu->features & ARM_SMMU_FEAT_STALLS &&
+	     device_property_read_bool(dev, "dma-can-stall")) ||
 	    smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
 		master->stall_enabled = true;

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index d6255ca823d8..a9d2df001149 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -210,14 +210,6 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 					     of_pci_iommu_init, &info);
 	} else {
 		err = of_iommu_configure_device(master_np, dev, id);
-
-		fwspec = dev_iommu_fwspec_get(dev);
-		if (!err && fwspec) {
-			of_property_read_u32(master_np, "pasid-num-bits",
-					     &fwspec->num_pasid_bits);
-			fwspec->can_stall = of_property_read_bool(master_np,
-								  "dma-can-stall");
-		}
 	}

 	/*
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 324dbe55836c..13a43a3d6347 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1828,12 +1828,17 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_HUAWEI, 0x1610, PCI_CLASS_BRIDGE_PCI

 static void quirk_huawei_pcie_sva(struct pci_dev *pdev)
 {
-	struct iommu_fwspec *fwspec;
+	struct property_entry properties[] = {
+		PROPERTY_ENTRY_BOOL("dma-can-stall"),
+		{},
+	};

 	pdev->eetlp_prefix_path = 1;
-	fwspec = dev_iommu_fwspec_get(&pdev->dev);
-	if (fwspec)
-		fwspec->can_stall = 1;
+
+	/* Device-tree can set the stall property */
+	if (!pdev->dev.of_node &&
+	    device_add_properties(&pdev->dev, properties))
+		pci_warn(pdev, "could not add stall property");
 }

 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa250, quirk_huawei_pcie_sva);


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
