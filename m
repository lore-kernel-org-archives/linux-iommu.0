Return-Path: <SRS0=ynGH=LB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8C9C4743E
	for <iommu@archiver.kernel.org>; Mon,  7 Jun 2021 02:47:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D33960FDB
	for <iommu@archiver.kernel.org>; Mon,  7 Jun 2021 02:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D33960FDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1866C4034C;
	Mon,  7 Jun 2021 02:47:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XsTtV89WYsRd; Mon,  7 Jun 2021 02:47:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id CC97A4034D;
	Mon,  7 Jun 2021 02:47:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB245C000E;
	Mon,  7 Jun 2021 02:47:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B097C0022
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 02:47:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0C19B401D8
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 02:47:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UwweKN8mqUfQ for <iommu@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 02:47:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EDC6F40015
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 02:47:36 +0000 (UTC)
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.57])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4FyyMn1VkKz1BJl4;
 Mon,  7 Jun 2021 10:42:45 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 7 Jun 2021 10:47:33 +0800
From: chenxiang <chenxiang66@hisilicon.com>
To: <robin.murphy@arm.com>, <will@kernel.org>, <joro@8bytes.org>
Subject: [PATCH 4/4] iommu: free cached iovas when rmmod the driver of the
 last device in the group
Date: Mon, 7 Jun 2021 10:43:02 +0800
Message-ID: <1623033782-57907-5-git-send-email-chenxiang66@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1623033782-57907-1-git-send-email-chenxiang66@hisilicon.com>
References: <1623033782-57907-1-git-send-email-chenxiang66@hisilicon.com>
MIME-Version: 1.0
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
Cc: iommu@lists.linux-foundation.org, linuxarm@openeuler.org,
 linuxarm@huawei.com
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

From: Xiang Chen <chenxiang66@hisilicon.com>

When rmmod the driver of the last device in the domain, cached iovas are
not used and it is better to free them to save memories.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
---
 drivers/iommu/iommu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 808ab70..d318d80 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -9,6 +9,7 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/bug.h>
+#include <linux/dma-iommu.h>
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/export.h>
@@ -16,6 +17,7 @@
 #include <linux/errno.h>
 #include <linux/iommu.h>
 #include <linux/idr.h>
+#include <linux/iova.h>
 #include <linux/notifier.h>
 #include <linux/err.h>
 #include <linux/pci.h>
@@ -1667,6 +1669,11 @@ static int iommu_bus_notifier(struct notifier_block *nb,
 		group_action = IOMMU_GROUP_NOTIFY_UNBIND_DRIVER;
 		break;
 	case BUS_NOTIFY_UNBOUND_DRIVER:
+		if (iommu_group_device_count(group) == 1) {
+			struct iommu_domain *domain = group->domain;
+
+			free_rcache_cached_iovas(iommu_domain_to_iova(domain));
+		}
 		group_action = IOMMU_GROUP_NOTIFY_UNBOUND_DRIVER;
 		break;
 	}
-- 
2.8.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
