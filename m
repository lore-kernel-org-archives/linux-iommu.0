Return-Path: <SRS0=NT7l=KQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F8DC433B4
	for <iommu@archiver.kernel.org>; Fri, 21 May 2021 03:03:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AAA561244
	for <iommu@archiver.kernel.org>; Fri, 21 May 2021 03:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AAA561244
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D7E4D8452B;
	Fri, 21 May 2021 03:03:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MT2ai1Ywj4bN; Fri, 21 May 2021 03:03:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id BC4D784512;
	Fri, 21 May 2021 03:03:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E6EEC000E;
	Fri, 21 May 2021 03:03:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48A24C0001
 for <iommu@lists.linux-foundation.org>; Fri, 21 May 2021 03:03:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 361AA40FAD
 for <iommu@lists.linux-foundation.org>; Fri, 21 May 2021 03:03:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kGLTTlzsNZin for <iommu@lists.linux-foundation.org>;
 Fri, 21 May 2021 03:03:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D57F840FAB
 for <iommu@lists.linux-foundation.org>; Fri, 21 May 2021 03:03:35 +0000 (UTC)
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.58])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FmWZy32CnzmWcc;
 Fri, 21 May 2021 11:01:14 +0800 (CST)
Received: from dggpemm500009.china.huawei.com (7.185.36.225) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 21 May 2021 11:03:31 +0800
Received: from huawei.com (10.174.185.226) by dggpemm500009.china.huawei.com
 (7.185.36.225) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 21 May
 2021 11:03:30 +0800
From: Wang Xingang <wangxingang5@huawei.com>
To: <robh@kernel.org>, <will@kernel.org>, <joro@8bytes.org>,
 <helgaas@kernel.org>
Subject: [PATCH v4] iommu/of: Fix pci_request_acs() before enumerating PCI
 devices
Date: Fri, 21 May 2021 03:03:24 +0000
Message-ID: <1621566204-37456-1-git-send-email-wangxingang5@huawei.com>
X-Mailer: git-send-email 2.6.4.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.185.226]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
Cc: xieyingtai@huawei.com, wangxingang5@huawei.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, linux-pci@vger.kernel.org
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
 drivers/iommu/of_iommu.c | 1 -
 drivers/pci/of.c         | 8 +++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

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
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index da5b414d585a..2313c3f848b0 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -581,9 +581,15 @@ static int pci_parse_request_of_pci_ranges(struct device *dev,
 
 int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge)
 {
-	if (!dev->of_node)
+	struct device_node *node = dev->of_node;
+
+	if (!node)
 		return 0;
 
+	/* Detect IOMMU and make sure ACS will be enabled */
+	if (of_property_read_bool(node, "iommu-map"))
+		pci_request_acs();
+
 	bridge->swizzle_irq = pci_common_swizzle;
 	bridge->map_irq = of_irq_parse_and_map_pci;
 
-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
