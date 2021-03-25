Return-Path: <SRS0=Fh/M=IX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C51EC433DB
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 12:34:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AEC861A13
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 12:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AEC861A13
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 74A1B4053B;
	Thu, 25 Mar 2021 12:34:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i4nBKmKzJR3e; Thu, 25 Mar 2021 12:34:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4C513401CB;
	Thu, 25 Mar 2021 12:34:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DCB5EC0014;
	Thu, 25 Mar 2021 12:34:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF82AC000E
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 12:34:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E8A3040F31
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 12:34:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B4BdLXYJnBGS for <iommu@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 12:34:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 51EE040E4E
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 12:34:20 +0000 (UTC)
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F5kxW0PL9zPllv;
 Thu, 25 Mar 2021 20:31:43 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Thu, 25 Mar 2021 20:34:07 +0800
From: John Garry <john.garry@huawei.com>
To: <joro@8bytes.org>, <will@kernel.org>, <dwmw2@infradead.org>,
 <baolu.lu@linux.intel.com>, <robin.murphy@arm.com>
Subject: [PATCH v2 3/4] iommu: Delete iommu_dma_free_cpu_cached_iovas()
Date: Thu, 25 Mar 2021 20:30:00 +0800
Message-ID: <1616675401-151997-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1616675401-151997-1-git-send-email-john.garry@huawei.com>
References: <1616675401-151997-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
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

Function iommu_dma_free_cpu_cached_iovas() no longer has any caller, so
delete it.

With that, function free_cpu_cached_iovas() may be made static.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/dma-iommu.c | 9 ---------
 drivers/iommu/iova.c      | 3 ++-
 include/linux/dma-iommu.h | 8 --------
 include/linux/iova.h      | 5 -----
 4 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index af765c813cc8..9da7e9901bec 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -53,15 +53,6 @@ struct iommu_dma_cookie {
 
 static DEFINE_STATIC_KEY_FALSE(iommu_deferred_attach_enabled);
 
-void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
-		struct iommu_domain *domain)
-{
-	struct iommu_dma_cookie *cookie = domain->iova_cookie;
-	struct iova_domain *iovad = &cookie->iovad;
-
-	free_cpu_cached_iovas(cpu, iovad);
-}
-
 static void iommu_dma_entry_dtor(unsigned long data)
 {
 	struct page *freelist = (struct page *)data;
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index c78312560425..8a493ee92c79 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -22,6 +22,7 @@ static unsigned long iova_rcache_get(struct iova_domain *iovad,
 				     unsigned long size,
 				     unsigned long limit_pfn);
 static void init_iova_rcaches(struct iova_domain *iovad);
+static void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad);
 static void free_iova_rcaches(struct iova_domain *iovad);
 static void fq_destroy_all_entries(struct iova_domain *iovad);
 static void fq_flush_timeout(struct timer_list *t);
@@ -998,7 +999,7 @@ static void free_iova_rcaches(struct iova_domain *iovad)
 /*
  * free all the IOVA ranges cached by a cpu (used when cpu is unplugged)
  */
-void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad)
+static void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad)
 {
 	struct iova_cpu_rcache *cpu_rcache;
 	struct iova_rcache *rcache;
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 706b68d1359b..2112f21f73d8 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -37,9 +37,6 @@ void iommu_dma_compose_msi_msg(struct msi_desc *desc,
 
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
 
-void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
-		struct iommu_domain *domain);
-
 #else /* CONFIG_IOMMU_DMA */
 
 struct iommu_domain;
@@ -81,10 +78,5 @@ static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_he
 {
 }
 
-static inline void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
-		struct iommu_domain *domain)
-{
-}
-
 #endif	/* CONFIG_IOMMU_DMA */
 #endif	/* __DMA_IOMMU_H */
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 4be6c0ab4997..71d8a2de6635 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -157,7 +157,6 @@ int init_iova_flush_queue(struct iova_domain *iovad,
 			  iova_flush_cb flush_cb, iova_entry_dtor entry_dtor);
 struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn);
 void put_iova_domain(struct iova_domain *iovad);
-void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad);
 #else
 static inline int iova_cache_get(void)
 {
@@ -234,10 +233,6 @@ static inline void put_iova_domain(struct iova_domain *iovad)
 {
 }
 
-static inline void free_cpu_cached_iovas(unsigned int cpu,
-					 struct iova_domain *iovad)
-{
-}
 #endif
 
 #endif
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
