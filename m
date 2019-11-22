Return-Path: <SRS0=Z7Xn=ZO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9E5C432C0
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 10:58:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA3572071C
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 10:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mCKz+BwS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA3572071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B7E9325D78;
	Fri, 22 Nov 2019 10:58:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dsDkC5zGZL84; Fri, 22 Nov 2019 10:58:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 58BEE21526;
	Fri, 22 Nov 2019 10:58:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53DF3C1DD8;
	Fri, 22 Nov 2019 10:58:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2AAB4C18DA
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 10:58:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1030588B4B
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 10:58:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wB7-KmIiqaem for <iommu@lists.linux-foundation.org>;
 Fri, 22 Nov 2019 10:58:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 192CF88B39
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 10:58:16 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id z3so8084758wru.3
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 02:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CtJV+Z/+/tbCQItMssO61Gtwu58uukk1EMY1cx5Lnrc=;
 b=mCKz+BwSiQij013yjrKfw6oVS8rZuOUhHnkYyeMuylQQuFFsn9XIbdgBHPAB3A8pdU
 cMUMBgkrvvyXzSZLc4JjMGoOSzDyj//LqR8hEsiytCRio7CzvsCfCntQef1cjjByIfQ+
 0DBqbuPYhmOF4UbwVb2bHkiMX1wUo68X/5aywzwjn2hqptbDdDMBAVskk51+xMBuyCTU
 0aOnmA88FRuITCJgViQafNz+hmtGYWMc11yYsyCe7/24XyqUneiJC1AQ84o9o8cla+Ey
 ATsb1Rzo34z2s9+ijfxeiOEUyGmCjwuFbjm2z5hrxBdndr6/6EsPwSvHM8DWWWBQjgAR
 RgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CtJV+Z/+/tbCQItMssO61Gtwu58uukk1EMY1cx5Lnrc=;
 b=e2WxxpW2jdtpigAY6eNorxAN9BFFnn6BsfCS9oxnezxG4cyB5XNblGKsNwoyRVZK6h
 s7ChNHbip2KYsJpYBetLtvOuu4AEpRQz9I4WJm0pMsWxqhm3PpLgkmjDyVsyLbEZQxpT
 gQfAFK8PE9E5LiI4KBZ8SHjEzYyzZEZkksVufNXhr7JK8HI3eGWSRM95nzBFCqIgM1Qh
 5phIX17yRpcNsAg8XjD2G3igQUSOvDuny/ccr8NU1TpiDA6klDMk4w2VCqYSCG3WUqE+
 ShVk9NAU5A77xxHYx+WMFA2WqAEDIjFvoKRsj5fOSGrPW1qJcN3JseVMlu8pZIaT0DO5
 0+lA==
X-Gm-Message-State: APjAAAW9DcFgHUcihUqBtbAtacX2hLoR4M3di62seOWW5IJw2ofK+BDX
 c4KUXEKMJQvcXKbYkFqpQlyDdg==
X-Google-Smtp-Source: APXvYqx7MG4bOlzFFisEZutGEcVZWtWFA9RVeyazzfivhpVCLuQP4wNiRtqWewtbovVtsPJwXnRjLg==
X-Received: by 2002:a5d:4a8c:: with SMTP id o12mr508171wrq.43.1574419860358;
 Fri, 22 Nov 2019 02:51:00 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-204-106.adslplus.ch.
 [188.155.204.106])
 by smtp.gmail.com with ESMTPSA id o133sm2088197wmb.4.2019.11.22.02.50.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2019 02:50:59 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org,
 virtualization@lists.linux-foundation.org, linux-pci@vger.kernel.org,
 virtio-dev@lists.oasis-open.org
Subject: [RFC 07/13] ACPI/IORT: Defer probe until virtio-iommu-pci has
 registered a fwnode
Date: Fri, 22 Nov 2019 11:49:54 +0100
Message-Id: <20191122105000.800410-8-jean-philippe@linaro.org>
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

When the IOMMU is PCI-based, IORT doesn't know the fwnode until the
driver has had a chance to register it. In addition to deferring the
probe until the IOMMU ops are set, also defer the probe until the fwspec
is available.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/acpi/iort.c | 54 ++++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/iort.c b/drivers/acpi/iort.c
index b517aa4e83ba..f08f72d8af78 100644
--- a/drivers/acpi/iort.c
+++ b/drivers/acpi/iort.c
@@ -61,6 +61,22 @@ static bool iort_type_matches(u8 type, enum iort_node_category category)
 	}
 }
 
+static inline bool iort_iommu_driver_enabled(u8 type)
+{
+	switch (type) {
+	case ACPI_IORT_NODE_SMMU_V3:
+		return IS_BUILTIN(CONFIG_ARM_SMMU_V3);
+	case ACPI_IORT_NODE_SMMU:
+		return IS_BUILTIN(CONFIG_ARM_SMMU);
+	case ACPI_VIOT_IORT_NODE_VIRTIO_MMIO_IOMMU:
+	case ACPI_VIOT_IORT_NODE_VIRTIO_PCI_IOMMU:
+		return IS_ENABLED(CONFIG_VIRTIO_IOMMU);
+	default:
+		pr_warn("IORT node type %u does not describe an IOMMU\n", type);
+		return false;
+	}
+}
+
 /**
  * iort_set_fwnode() - Create iort_fwnode and use it to register
  *		       iommu data in the iort_fwnode_list
@@ -102,9 +118,9 @@ static inline int iort_set_fwnode(struct acpi_iort_node *iort_node,
  *
  * Returns: fwnode_handle pointer on success, NULL on failure
  */
-static inline struct fwnode_handle *iort_get_fwnode(
-			struct acpi_iort_node *node)
+static inline struct fwnode_handle *iort_get_fwnode(struct acpi_iort_node *node)
 {
+	int err = -ENODEV;
 	struct iort_fwnode *curr;
 	struct fwnode_handle *fwnode = NULL;
 
@@ -112,12 +128,20 @@ static inline struct fwnode_handle *iort_get_fwnode(
 	list_for_each_entry(curr, &iort_fwnode_list, list) {
 		if (curr->iort_node == node) {
 			fwnode = curr->fwnode;
+			if (!fwnode && curr->pci_devid) {
+				/*
+				 * Postpone probe until virtio-iommu has
+				 * registered its fwnode.
+				 */
+				err = iort_iommu_driver_enabled(node->type) ?
+					-EPROBE_DEFER : -ENODEV;
+			}
 			break;
 		}
 	}
 	spin_unlock(&iort_fwnode_lock);
 
-	return fwnode;
+	return fwnode ?: ERR_PTR(err);
 }
 
 /**
@@ -874,22 +898,6 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
 	return (resv == its->its_count) ? resv : -ENODEV;
 }
 
-static inline bool iort_iommu_driver_enabled(u8 type)
-{
-	switch (type) {
-	case ACPI_IORT_NODE_SMMU_V3:
-		return IS_BUILTIN(CONFIG_ARM_SMMU_V3);
-	case ACPI_IORT_NODE_SMMU:
-		return IS_BUILTIN(CONFIG_ARM_SMMU);
-	case ACPI_VIOT_IORT_NODE_VIRTIO_MMIO_IOMMU:
-	case ACPI_VIOT_IORT_NODE_VIRTIO_PCI_IOMMU:
-		return IS_ENABLED(CONFIG_VIRTIO_IOMMU);
-	default:
-		pr_warn("IORT node type %u does not describe an IOMMU\n", type);
-		return false;
-	}
-}
-
 static int arm_smmu_iort_xlate(struct device *dev, u32 streamid,
 			       struct fwnode_handle *fwnode,
 			       const struct iommu_ops *ops)
@@ -920,8 +928,8 @@ static int iort_iommu_xlate(struct device *dev, struct acpi_iort_node *node,
 		return -ENODEV;
 
 	iort_fwnode = iort_get_fwnode(node);
-	if (!iort_fwnode)
-		return -ENODEV;
+	if (IS_ERR(iort_fwnode))
+		return PTR_ERR(iort_fwnode);
 
 	/*
 	 * If the ops look-up fails, this means that either
@@ -1618,8 +1626,8 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
 
 	fwnode = iort_get_fwnode(node);
 
-	if (!fwnode) {
-		ret = -ENODEV;
+	if (IS_ERR(fwnode)) {
+		ret = PTR_ERR(fwnode);
 		goto dev_put;
 	}
 
-- 
2.24.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
