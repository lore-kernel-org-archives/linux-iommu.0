Return-Path: <SRS0=ynGH=LB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AA8C4743D
	for <iommu@archiver.kernel.org>; Mon,  7 Jun 2021 02:47:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D02C611C2
	for <iommu@archiver.kernel.org>; Mon,  7 Jun 2021 02:47:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D02C611C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 073A040345;
	Mon,  7 Jun 2021 02:47:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AiDEVkEr2sRE; Mon,  7 Jun 2021 02:47:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7D9D84034A;
	Mon,  7 Jun 2021 02:47:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7CDD6C000E;
	Mon,  7 Jun 2021 02:47:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 337C6C0001
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 02:47:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 021A9834BA
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 02:47:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 65nTlIHD2rvN for <iommu@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 02:47:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EDACF83474
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 02:47:36 +0000 (UTC)
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.55])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FyyQ53jNSzYrZQ;
 Mon,  7 Jun 2021 10:44:45 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 7 Jun 2021 10:47:33 +0800
From: chenxiang <chenxiang66@hisilicon.com>
To: <robin.murphy@arm.com>, <will@kernel.org>, <joro@8bytes.org>
Subject: [PATCH 1/4] iommu/iova: add a function to free all rcached iovas and
 export it
Date: Mon, 7 Jun 2021 10:42:59 +0800
Message-ID: <1623033782-57907-2-git-send-email-chenxiang66@hisilicon.com>
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

Add a function to free all rcached iovas including cpu rcache iovas and
global rcache iovas, and export it.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
---
 drivers/iommu/iova.c | 11 +++++++++++
 include/linux/iova.h |  5 +++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index b7ecd5b..f595867 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -1077,5 +1077,16 @@ static void free_global_cached_iovas(struct iova_domain *iovad)
 		spin_unlock_irqrestore(&rcache->lock, flags);
 	}
 }
+
+void free_rcache_cached_iovas(struct iova_domain *iovad)
+{
+	unsigned int cpu;
+
+	for_each_online_cpu(cpu)
+		free_cpu_cached_iovas(cpu, iovad);
+	free_global_cached_iovas(iovad);
+}
+EXPORT_SYMBOL_GPL(free_rcache_cached_iovas);
+
 MODULE_AUTHOR("Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 71d8a2d..7006d9f 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -157,6 +157,7 @@ int init_iova_flush_queue(struct iova_domain *iovad,
 			  iova_flush_cb flush_cb, iova_entry_dtor entry_dtor);
 struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn);
 void put_iova_domain(struct iova_domain *iovad);
+void free_rcache_cached_iovas(struct iova_domain *iovad);
 #else
 static inline int iova_cache_get(void)
 {
@@ -233,6 +234,10 @@ static inline void put_iova_domain(struct iova_domain *iovad)
 {
 }
 
+static inline void free_rcache_cached_iovas(struct iova_domain *iovad)
+{
+}
+
 #endif
 
 #endif
-- 
2.8.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
