Return-Path: <SRS0=ObaZ=KP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CE9C433B4
	for <iommu@archiver.kernel.org>; Thu, 20 May 2021 07:28:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 625BF601FC
	for <iommu@archiver.kernel.org>; Thu, 20 May 2021 07:28:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 625BF601FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2AF6B40EE3;
	Thu, 20 May 2021 07:28:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ty1VTHG9HnBY; Thu, 20 May 2021 07:28:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id D069240EA3;
	Thu, 20 May 2021 07:28:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE399C000E;
	Thu, 20 May 2021 07:28:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7936C0001
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 07:28:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 89C4E6061D
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 07:28:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rxi1CLx-GteO for <iommu@lists.linux-foundation.org>;
 Thu, 20 May 2021 07:28:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C3751605D9
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 07:28:39 +0000 (UTC)
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.60])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fm1Vh1qPSz16PlL;
 Thu, 20 May 2021 15:25:48 +0800 (CST)
Received: from dggpemm500009.china.huawei.com (7.185.36.225) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 15:28:34 +0800
Received: from huawei.com (10.174.185.226) by dggpemm500009.china.huawei.com
 (7.185.36.225) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 20 May
 2021 15:28:34 +0800
From: Wang Xingang <wangxingang5@huawei.com>
To: <robh@kernel.org>, <will@kernel.org>, <joro@8bytes.org>,
 <lorenzo.pieralisi@arm.com>, <frowand.list@gmail.com>
Subject: [PATCH v3] iommu/of: Fix pci_request_acs() before enumerating PCI
 devices
Date: Thu, 20 May 2021 07:28:28 +0000
Message-ID: <1621495708-40364-1-git-send-email-wangxingang5@huawei.com>
X-Mailer: git-send-email 2.6.4.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.185.226]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
Cc: xieyingtai@huawei.com, wangxingang5@huawei.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, helgaas@kernel.org, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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

From: Xingang Wang <wangxingang5@huawei.com>

When booting with devicetree, the pci_request_acs() is called after the
enumeration and initialization of PCI devices, thus the ACS is not
enabled. And ACS should be enabled when IOMMU is detected for the
PCI host bridge, so add check for IOMMU before probe of PCI host and call
pci_request_acs() to make sure ACS will be enabled when enumerating PCI
devices.

Fixes: 6bf6c24720d33 ("iommu/of: Request ACS from the PCI core when
configuring IOMMU linkage")
Signed-off-by: Xingang Wang <wangxingang5@huawei.com>
---
 drivers/iommu/of_iommu.c                 |  1 -
 drivers/pci/controller/pci-host-common.c | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index a9d2df001149..54a14da242cc 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -205,7 +205,6 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 			.np = master_np,
 		};
 
-		pci_request_acs();
 		err = pci_for_each_dma_alias(to_pci_dev(dev),
 					     of_pci_iommu_init, &info);
 	} else {
diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index d3924a44db02..5904ad0bd9ae 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -49,6 +49,21 @@ static struct pci_config_window *gen_pci_init(struct device *dev,
 	return cfg;
 }
 
+static void pci_host_enable_acs(struct pci_host_bridge *bridge)
+{
+	struct device_node *np = bridge->dev.parent->of_node;
+	static bool acs_enabled;
+
+	if (!np || acs_enabled)
+		return;
+
+	/* Detect IOMMU and make sure ACS will be enabled */
+	if (of_property_read_bool(np, "iommu-map")) {
+		acs_enabled = true;
+		pci_request_acs();
+	}
+}
+
 int pci_host_common_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -81,6 +96,8 @@ int pci_host_common_probe(struct platform_device *pdev)
 	bridge->ops = (struct pci_ops *)&ops->pci_ops;
 	bridge->msi_domain = true;
 
+	pci_host_enable_acs(bridge);
+
 	return pci_host_probe(bridge);
 }
 EXPORT_SYMBOL_GPL(pci_host_common_probe);
-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
