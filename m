Return-Path: <SRS0=Mf8z=KM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43700C433ED
	for <iommu@archiver.kernel.org>; Mon, 17 May 2021 13:17:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9478611BE
	for <iommu@archiver.kernel.org>; Mon, 17 May 2021 13:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9478611BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A056A403C6;
	Mon, 17 May 2021 13:17:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5efTyzXcyQOm; Mon, 17 May 2021 13:17:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 71E6C40379;
	Mon, 17 May 2021 13:17:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55BE6C000E;
	Mon, 17 May 2021 13:17:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 085ACC0001
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 13:17:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DCBB840103
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 13:17:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j2sG54jqbpJ5 for <iommu@lists.linux-foundation.org>;
 Mon, 17 May 2021 13:17:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F3DEF402F2
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 13:17:17 +0000 (UTC)
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FkKMY25FrzQnvD;
 Mon, 17 May 2021 21:13:45 +0800 (CST)
Received: from dggpemm500009.china.huawei.com (7.185.36.225) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 17 May 2021 21:17:13 +0800
Received: from huawei.com (10.174.185.226) by dggpemm500009.china.huawei.com
 (7.185.36.225) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 17 May
 2021 21:17:12 +0800
From: Wang Xingang <wangxingang5@huawei.com>
To: <will@kernel.org>, <joro@8bytes.org>, <robh+dt@kernel.org>,
 <frowand.list@gmail.com>
Subject: [PATCH v2] iommu/of: Fix pci_request_acs() before enumerating PCI
 devices
Date: Mon, 17 May 2021 13:17:05 +0000
Message-ID: <1621257425-37856-1-git-send-email-wangxingang5@huawei.com>
X-Mailer: git-send-email 2.6.4.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.185.226]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
Cc: xieyingtai@huawei.com, devicetree@vger.kernel.org, wangxingang5@huawei.com,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, helgaas@kernel.org,
 linux-pci@vger.kernel.org
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
enabled. This patch add check for IOMMU in of_core_init(), and call
pci_request_acs() when iommu is detected, making sure that the ACS will
be enabled.

Fixes: 6bf6c24720d33 ("iommu/of: Request ACS from the PCI core when
configuring IOMMU linkage")
Signed-off-by: Xingang Wang <wangxingang5@huawei.com>
---
 drivers/iommu/of_iommu.c | 1 -
 drivers/of/base.c        | 9 ++++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

Change log:
v1->v2:
 - remove pci_request_acs() in of_iommu_configure
 - check and call pci_request_acs() in of_core_init()

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
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 48e941f99558..95cd8f0e5435 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -24,6 +24,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_graph.h>
+#include <linux/pci.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
 #include <linux/string.h>
@@ -166,7 +167,7 @@ void __of_phandle_cache_inv_entry(phandle handle)
 void __init of_core_init(void)
 {
 	struct device_node *np;
-
+	bool of_iommu_detect = false;
 
 	/* Create the kset, and register existing nodes */
 	mutex_lock(&of_mutex);
@@ -180,6 +181,12 @@ void __init of_core_init(void)
 		__of_attach_node_sysfs(np);
 		if (np->phandle && !phandle_cache[of_phandle_cache_hash(np->phandle)])
 			phandle_cache[of_phandle_cache_hash(np->phandle)] = np;
+
+		/* Detect IOMMU and make sure ACS will be enabled */
+		if (!of_iommu_detect && of_get_property(np, "iommu-map", NULL)) {
+			of_iommu_detect = true;
+			pci_request_acs();
+		}
 	}
 	mutex_unlock(&of_mutex);
 
-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
