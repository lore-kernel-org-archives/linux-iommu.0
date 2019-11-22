Return-Path: <SRS0=Z7Xn=ZO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDEDC432C0
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 10:57:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 791742073F
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 10:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KE4FZyVJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 791742073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 528BB261D5;
	Fri, 22 Nov 2019 10:57:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q2oH62drp4Lr; Fri, 22 Nov 2019 10:57:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 4581825D78;
	Fri, 22 Nov 2019 10:57:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C244C1DD8;
	Fri, 22 Nov 2019 10:57:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9431C18DA
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 10:57:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A55DA87CCB
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 10:57:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mOAhSxBjAeV0 for <iommu@lists.linux-foundation.org>;
 Fri, 22 Nov 2019 10:57:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C233B87E3F
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 10:57:26 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id y11so4964063wrt.6
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 02:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=O8FVNRvH5irJ2zDaBsxloUo7UX0pFrVUzjUZiLfKvwU=;
 b=KE4FZyVJ7oTMaqEmjpbPlG5DZcuerskPQmr4Oz+oBjjiJHvGL6H8exZ0GXrlPmDu4L
 fjock0LX/ANKXLc2tQLf8axKFLTKAmNc1cOarXAmF0mUTryD4ji2KpaeIUDw6KdwzCw2
 MxmVyNC6Z760rlRWN+O0jtt5nJoCB5GWkiGoJq9XOXrGI1Q2/py21NNS6EZZJTYshlH1
 dixx5JojDpj/FfGb3I7ZZgOUrdLQ8kn2WEIgbTcnNR0ah1Bdppb6CTCz4NURwPA8aLfS
 EJmBtSrx3Y1mMzNCGoqbw/42Xt3due4SSZ7dusRabMT5A8dSeghZrBgyRs8JtWKzrXen
 CdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=O8FVNRvH5irJ2zDaBsxloUo7UX0pFrVUzjUZiLfKvwU=;
 b=p8HDVrcm1EWjeVlB/O3MqR7jMaoT7wYc0Qw04QgwF9CWH4aOPmrD/1e/o5kLfUwgk6
 HEzaDb9Fzj8e6eeJmMc6mwu2WZUUralK4UEMfpOZmo+xk9/fBvE3KxY4MPv2+TN7ZZ8R
 2gpokoxG+HRnIriSj7FHfMd4r1rW2SGGOeXSdV8Lc65pDgi3BpM4V3TVfvo5+XWixUE9
 loPG2qRMhNZ+zAOTx2PSbwK45aUdqAXHXHuxv4pDKdiTkEkEXQem8NXOrhGWAakmGLWU
 CyuXi/Txa3lYmBmXEDYJga9HmtKZwpa+IXqrYwGpSYm6Nls8PYggb41o732T/+Km16uA
 ECYA==
X-Gm-Message-State: APjAAAWHd0B2z0RrYsTdzgTD6O3f+sakkBUOltHzk6QBmfENuq5Waxse
 sUAxofwOjCmpJqBs+05NhWp4kA==
X-Google-Smtp-Source: APXvYqxupzAk9/+hAGuqo2zCmryiXsqWB8zdfYtdzuCH8fYncJHID5ipVvqg0xilqWNq9KeWUZb/LQ==
X-Received: by 2002:adf:de0a:: with SMTP id b10mr17179236wrm.268.1574419862914; 
 Fri, 22 Nov 2019 02:51:02 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-204-106.adslplus.ch.
 [188.155.204.106])
 by smtp.gmail.com with ESMTPSA id o133sm2088197wmb.4.2019.11.22.02.51.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2019 02:51:02 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org,
 virtualization@lists.linux-foundation.org, linux-pci@vger.kernel.org,
 virtio-dev@lists.oasis-open.org
Subject: [RFC 09/13] iommu/virtio: Create fwnode if necessary
Date: Fri, 22 Nov 2019 11:49:56 +0100
Message-Id: <20191122105000.800410-10-jean-philippe@linaro.org>
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

The presence of a fwnode on a PCI device depends on the platform. QEMU
q35, for example, creates an ACPI description for each PCI slot, but
QEMU virt (aarch64) doesn't. Since the IOMMU subsystem relies heavily on
fwnode to discover the DMA topology, create a fwnode for the
virtio-iommu if necessary, using the software_node framework.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/virtio-iommu.c | 56 ++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 3ea9d7682999..8efa368134c0 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -966,6 +966,48 @@ static struct iommu_ops viommu_ops = {
 	.of_xlate		= viommu_of_xlate,
 };
 
+static int viommu_set_fwnode(struct viommu_dev *viommu)
+{
+	/*
+	 * viommu->dev is the virtio device, its parent is the associated
+	 * transport device.
+	 */
+	struct device *dev = viommu->dev->parent;
+
+	/*
+	 * With device tree a fwnode is always present. With ACPI, on some
+	 * platforms a PCI device has a DSDT node describing the slot. On other
+	 * platforms, no fwnode is created and we have to do it ourselves.
+	 */
+	if (!dev->fwnode) {
+		struct fwnode_handle *fwnode;
+
+		fwnode = fwnode_create_software_node(NULL, NULL);
+		if (IS_ERR(fwnode))
+			return PTR_ERR(fwnode);
+
+		set_primary_fwnode(dev, fwnode);
+	}
+
+	iommu_device_set_fwnode(&viommu->iommu, dev->fwnode);
+	return 0;
+}
+
+static void viommu_clear_fwnode(struct viommu_dev *viommu)
+{
+	struct device *dev = viommu->dev->parent;
+
+	if (!dev->fwnode)
+		return;
+
+	if (is_software_node(dev->fwnode)) {
+		struct fwnode_handle *fwnode = dev->fwnode;
+
+		set_primary_fwnode(dev, NULL);
+		fwnode_remove_software_node(fwnode);
+	}
+}
+
 static int viommu_init_vqs(struct viommu_dev *viommu)
 {
 	struct virtio_device *vdev = dev_to_virtio(viommu->dev);
@@ -1004,7 +1046,6 @@ static int viommu_fill_evtq(struct viommu_dev *viommu)
 
 static int viommu_probe(struct virtio_device *vdev)
 {
-	struct device *parent_dev = vdev->dev.parent;
 	struct viommu_dev *viommu = NULL;
 	struct device *dev = &vdev->dev;
 	u64 input_start = 0;
@@ -1084,9 +1125,11 @@ static int viommu_probe(struct virtio_device *vdev)
 	if (ret)
 		goto err_free_vqs;
 
-	iommu_device_set_ops(&viommu->iommu, &viommu_ops);
-	iommu_device_set_fwnode(&viommu->iommu, parent_dev->fwnode);
+	ret = viommu_set_fwnode(viommu);
+	if (ret)
+		goto err_sysfs_remove;
 
+	iommu_device_set_ops(&viommu->iommu, &viommu_ops);
 	iommu_device_register(&viommu->iommu);
 
 #ifdef CONFIG_PCI
@@ -1119,8 +1162,10 @@ static int viommu_probe(struct virtio_device *vdev)
 	return 0;
 
 err_unregister:
-	iommu_device_sysfs_remove(&viommu->iommu);
 	iommu_device_unregister(&viommu->iommu);
+	viommu_clear_fwnode(viommu);
+err_sysfs_remove:
+	iommu_device_sysfs_remove(&viommu->iommu);
 err_free_vqs:
 	vdev->config->del_vqs(vdev);
 
@@ -1131,8 +1176,9 @@ static void viommu_remove(struct virtio_device *vdev)
 {
 	struct viommu_dev *viommu = vdev->priv;
 
-	iommu_device_sysfs_remove(&viommu->iommu);
 	iommu_device_unregister(&viommu->iommu);
+	viommu_clear_fwnode(viommu);
+	iommu_device_sysfs_remove(&viommu->iommu);
 
 	/* Stop all virtqueues */
 	vdev->config->reset(vdev);
-- 
2.24.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
