Return-Path: <SRS0=UGJ5=K3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DBCC47096
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 14:34:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5219A6136E
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 14:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5219A6136E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CDB85404B8;
	Tue,  1 Jun 2021 14:34:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UNYxwDr2Go-m; Tue,  1 Jun 2021 14:34:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 74202404BA;
	Tue,  1 Jun 2021 14:34:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5514FC000D;
	Tue,  1 Jun 2021 14:34:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C797C0024
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 14:34:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5E132402CB
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 14:34:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1Y6g_UK6oHMn for <iommu@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 14:34:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6914D4041B
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 14:34:23 +0000 (UTC)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FvZJ82DXRz6Q3pj;
 Tue,  1 Jun 2021 22:27:52 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 16:34:21 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 15:34:19 +0100
From: John Garry <john.garry@huawei.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
Subject: [PATCH v3 5/7] iova: Add init_iova_domain_ext()
Date: Tue, 1 Jun 2021 22:29:39 +0800
Message-ID: <1622557781-211697-6-git-send-email-john.garry@huawei.com>
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

Add extended version of init_iova_domain() which accepts an max opt
iova length argument, and use it to set the rcaches range.

This can be combined with the normal version later.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/iova.c | 31 ++++++++++++++++++++++++-------
 include/linux/iova.h |  9 +++++++++
 2 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 95892a0433cc..ae4901073a98 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -23,7 +23,7 @@ static bool iova_rcache_insert(struct iova_domain *iovad,
 static unsigned long iova_rcache_get(struct iova_domain *iovad,
 				     unsigned long size,
 				     unsigned long limit_pfn);
-static void init_iova_rcaches(struct iova_domain *iovad);
+static void init_iova_rcaches(struct iova_domain *iovad, unsigned long iova_len);
 static void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad);
 static void free_iova_rcaches(struct iova_domain *iovad);
 static void fq_destroy_all_entries(struct iova_domain *iovad);
@@ -46,9 +46,9 @@ static struct iova *to_iova(struct rb_node *node)
 	return rb_entry(node, struct iova, node);
 }
 
-void
-init_iova_domain(struct iova_domain *iovad, unsigned long granule,
-	unsigned long start_pfn)
+static void
+__init_iova_domain(struct iova_domain *iovad, unsigned long granule,
+	unsigned long start_pfn, unsigned long iova_len)
 {
 	/*
 	 * IOVA granularity will normally be equal to the smallest
@@ -71,7 +71,21 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	rb_link_node(&iovad->anchor.node, NULL, &iovad->rbroot.rb_node);
 	rb_insert_color(&iovad->anchor.node, &iovad->rbroot);
 	cpuhp_state_add_instance_nocalls(CPUHP_IOMMU_IOVA_DEAD, &iovad->cpuhp_dead);
-	init_iova_rcaches(iovad);
+	init_iova_rcaches(iovad, iova_len);
+}
+
+void
+init_iova_domain_ext(struct iova_domain *iovad, unsigned long granule,
+	unsigned long start_pfn, unsigned long iova_len)
+{
+	__init_iova_domain(iovad, granule, start_pfn, iova_len);
+}
+
+void
+init_iova_domain(struct iova_domain *iovad, unsigned long granule,
+	unsigned long start_pfn)
+{
+	__init_iova_domain(iovad, granule, start_pfn, 0);
 }
 EXPORT_SYMBOL_GPL(init_iova_domain);
 
@@ -883,14 +897,17 @@ bool iova_domain_len_is_cached(struct iova_domain *iovad, unsigned long iova_len
 	return iova_len_to_rcache_max(iova_len) == iovad->rcache_max_size;
 }
 
-static void init_iova_rcaches(struct iova_domain *iovad)
+static void init_iova_rcaches(struct iova_domain *iovad, unsigned long iova_len)
 {
 	struct iova_cpu_rcache *cpu_rcache;
 	struct iova_rcache *rcache;
 	unsigned int cpu;
 	int i;
 
-	iovad->rcache_max_size = IOVA_RANGE_CACHE_MAX_SIZE;
+	if (iova_len)
+		iovad->rcache_max_size = iova_len_to_rcache_max(iova_len);
+	else
+		iovad->rcache_max_size = IOVA_RANGE_CACHE_MAX_SIZE;
 
 	iovad->rcaches = kcalloc(iovad->rcache_max_size,
 				 sizeof(*iovad->rcaches), GFP_KERNEL);
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 04cc8eb6de38..cfe416b6a8c7 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -154,6 +154,8 @@ struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pfn_lo,
 	unsigned long pfn_hi);
 void init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	unsigned long start_pfn);
+void init_iova_domain_ext(struct iova_domain *iovad, unsigned long granule,
+	unsigned long start_pfn, unsigned long iova_len);
 int init_iova_flush_queue(struct iova_domain *iovad,
 			  iova_flush_cb flush_cb, iova_entry_dtor entry_dtor);
 struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn);
@@ -222,6 +224,13 @@ static inline void init_iova_domain(struct iova_domain *iovad,
 {
 }
 
+static inline void init_iova_domain_ext(struct iova_domain *iovad,
+				    unsigned long granule,
+				    unsigned long start_pfn,
+				    unsigned long iova_len)
+{
+}
+
 static inline int init_iova_flush_queue(struct iova_domain *iovad,
 					iova_flush_cb flush_cb,
 					iova_entry_dtor entry_dtor)
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
