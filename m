Return-Path: <SRS0=UGJ5=K3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF786C47093
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 14:34:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89836613DB
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 14:34:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89836613DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 555E8839E6;
	Tue,  1 Jun 2021 14:34:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7AXWPr2tTAR8; Tue,  1 Jun 2021 14:34:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E4EF83653;
	Tue,  1 Jun 2021 14:34:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2A307C000D;
	Tue,  1 Jun 2021 14:34:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23111C0001
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 14:34:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9390B6081B
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 14:34:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3WP39RuUysEH for <iommu@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 14:34:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DB049607AD
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 14:34:20 +0000 (UTC)
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FvZ9K3J1qz6M4Mn;
 Tue,  1 Jun 2021 22:21:57 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 16:34:19 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 15:34:16 +0100
From: John Garry <john.garry@huawei.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
Subject: [PATCH v3 4/7] iova: Add iova_domain_len_is_cached()
Date: Tue, 1 Jun 2021 22:29:38 +0800
Message-ID: <1622557781-211697-5-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1622557781-211697-1-git-send-email-john.garry@huawei.com>
References: <1622557781-211697-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: iommu@lists.linux-foundation.org, linuxarm@huawei.com,
 linux-kernel@vger.kernel.org
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

Add a function to check whether an IOVA domain currently caches a given
upper IOVA len exactly.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/iova.c | 11 +++++++++++
 include/linux/iova.h |  8 +++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 0e4c0e55178a..95892a0433cc 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -872,6 +872,17 @@ static void iova_magazine_push(struct iova_magazine *mag, unsigned long pfn)
 	mag->pfns[mag->size++] = pfn;
 }
 
+static unsigned long iova_len_to_rcache_max(unsigned long iova_len)
+{
+	return order_base_2(iova_len) + 1;
+}
+
+/* Test if iova_len range cached upper limit matches that of IOVA domain */
+bool iova_domain_len_is_cached(struct iova_domain *iovad, unsigned long iova_len)
+{
+	return iova_len_to_rcache_max(iova_len) == iovad->rcache_max_size;
+}
+
 static void init_iova_rcaches(struct iova_domain *iovad)
 {
 	struct iova_cpu_rcache *cpu_rcache;
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 9974e1d3e2bc..04cc8eb6de38 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -136,7 +136,8 @@ static inline unsigned long iova_pfn(struct iova_domain *iovad, dma_addr_t iova)
 #if IS_ENABLED(CONFIG_IOMMU_IOVA)
 int iova_cache_get(void);
 void iova_cache_put(void);
-
+bool iova_domain_len_is_cached(struct iova_domain *iovad,
+			       unsigned long iova_len);
 void free_iova(struct iova_domain *iovad, unsigned long pfn);
 void __free_iova(struct iova_domain *iovad, struct iova *iova);
 struct iova *alloc_iova(struct iova_domain *iovad, unsigned long size,
@@ -158,6 +159,11 @@ int init_iova_flush_queue(struct iova_domain *iovad,
 struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn);
 void put_iova_domain(struct iova_domain *iovad);
 #else
+static inline bool iova_domain_len_is_cached(struct iova_domain *iovad,
+					     unsigned long iova_len)
+{
+	return false;
+}
 static inline int iova_cache_get(void)
 {
 	return -ENOTSUPP;
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
