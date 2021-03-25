Return-Path: <SRS0=Fh/M=IX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_RED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1865C433E0
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 12:34:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9630261A13
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 12:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9630261A13
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6643740538;
	Thu, 25 Mar 2021 12:34:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f-1OWiPXajfA; Thu, 25 Mar 2021 12:34:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 29FB0401F2;
	Thu, 25 Mar 2021 12:34:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23CD9C0019;
	Thu, 25 Mar 2021 12:34:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 914F9C000A
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 12:34:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 739CA40E4E
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 12:34:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U8RpzuuGHVjp for <iommu@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 12:34:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6868B40EA5
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 12:34:20 +0000 (UTC)
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F5kxW0gkXzPlrw;
 Thu, 25 Mar 2021 20:31:43 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Thu, 25 Mar 2021 20:34:07 +0800
From: John Garry <john.garry@huawei.com>
To: <joro@8bytes.org>, <will@kernel.org>, <dwmw2@infradead.org>,
 <baolu.lu@linux.intel.com>, <robin.murphy@arm.com>
Subject: [PATCH v2 1/4] iova: Add CPU hotplug handler to flush rcaches
Date: Thu, 25 Mar 2021 20:29:58 +0800
Message-ID: <1616675401-151997-2-git-send-email-john.garry@huawei.com>
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

Like the Intel IOMMU driver already does, flush the per-IOVA domain
CPU rcache when a CPU goes offline - there's no point in keeping it.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/iova.c       | 30 +++++++++++++++++++++++++++++-
 include/linux/cpuhotplug.h |  1 +
 include/linux/iova.h       |  1 +
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index e6e2fa85271c..c78312560425 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -25,6 +25,17 @@ static void init_iova_rcaches(struct iova_domain *iovad);
 static void free_iova_rcaches(struct iova_domain *iovad);
 static void fq_destroy_all_entries(struct iova_domain *iovad);
 static void fq_flush_timeout(struct timer_list *t);
+
+static int iova_cpuhp_dead(unsigned int cpu, struct hlist_node *node)
+{
+	struct iova_domain *iovad;
+
+	iovad = hlist_entry_safe(node, struct iova_domain, cpuhp_dead);
+
+	free_cpu_cached_iovas(cpu, iovad);
+	return 0;
+}
+
 static void free_global_cached_iovas(struct iova_domain *iovad);
 
 void
@@ -51,6 +62,7 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	iovad->anchor.pfn_lo = iovad->anchor.pfn_hi = IOVA_ANCHOR;
 	rb_link_node(&iovad->anchor.node, NULL, &iovad->rbroot.rb_node);
 	rb_insert_color(&iovad->anchor.node, &iovad->rbroot);
+	cpuhp_state_add_instance_nocalls(CPUHP_IOMMU_IOVA_DEAD, &iovad->cpuhp_dead);
 	init_iova_rcaches(iovad);
 }
 EXPORT_SYMBOL_GPL(init_iova_domain);
@@ -257,10 +269,21 @@ int iova_cache_get(void)
 {
 	mutex_lock(&iova_cache_mutex);
 	if (!iova_cache_users) {
+		int ret;
+
+		ret = cpuhp_setup_state_multi(CPUHP_IOMMU_IOVA_DEAD, "iommu/iova:dead", NULL,
+					iova_cpuhp_dead);
+		if (ret) {
+			mutex_unlock(&iova_cache_mutex);
+			pr_err("Couldn't register cpuhp handler\n");
+			return ret;
+		}
+
 		iova_cache = kmem_cache_create(
 			"iommu_iova", sizeof(struct iova), 0,
 			SLAB_HWCACHE_ALIGN, NULL);
 		if (!iova_cache) {
+			cpuhp_remove_multi_state(CPUHP_IOMMU_IOVA_DEAD);
 			mutex_unlock(&iova_cache_mutex);
 			pr_err("Couldn't create iova cache\n");
 			return -ENOMEM;
@@ -282,8 +305,10 @@ void iova_cache_put(void)
 		return;
 	}
 	iova_cache_users--;
-	if (!iova_cache_users)
+	if (!iova_cache_users) {
+		cpuhp_remove_multi_state(CPUHP_IOMMU_IOVA_DEAD);
 		kmem_cache_destroy(iova_cache);
+	}
 	mutex_unlock(&iova_cache_mutex);
 }
 EXPORT_SYMBOL_GPL(iova_cache_put);
@@ -606,6 +631,9 @@ void put_iova_domain(struct iova_domain *iovad)
 {
 	struct iova *iova, *tmp;
 
+	cpuhp_state_remove_instance_nocalls(CPUHP_IOMMU_IOVA_DEAD,
+					    &iovad->cpuhp_dead);
+
 	free_iova_flush_queue(iovad);
 	free_iova_rcaches(iovad);
 	rbtree_postorder_for_each_entry_safe(iova, tmp, &iovad->rbroot, node)
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index f14adb882338..cedac9986557 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -58,6 +58,7 @@ enum cpuhp_state {
 	CPUHP_NET_DEV_DEAD,
 	CPUHP_PCI_XGENE_DEAD,
 	CPUHP_IOMMU_INTEL_DEAD,
+	CPUHP_IOMMU_IOVA_DEAD,
 	CPUHP_LUSTRE_CFS_DEAD,
 	CPUHP_AP_ARM_CACHE_B15_RAC_DEAD,
 	CPUHP_PADATA_DEAD,
diff --git a/include/linux/iova.h b/include/linux/iova.h
index c834c01c0a5b..4be6c0ab4997 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -95,6 +95,7 @@ struct iova_domain {
 						   flush-queues */
 	atomic_t fq_timer_on;			/* 1 when timer is active, 0
 						   when not */
+	struct hlist_node	cpuhp_dead;
 };
 
 static inline unsigned long iova_size(struct iova *iova)
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
