Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A76CC43334
	for <iommu@archiver.kernel.org>; Thu,  9 Jun 2022 07:12:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3790F401A3;
	Thu,  9 Jun 2022 07:12:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1mjte8GJdNkM; Thu,  9 Jun 2022 07:12:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1C1544000B;
	Thu,  9 Jun 2022 07:12:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF9E5C0039;
	Thu,  9 Jun 2022 07:12:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93A33C002D
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 07:12:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 748D341C0F
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 07:12:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j9e4TJL4WSw0 for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 07:12:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 789EB41BD8
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 07:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1654758722; x=1686294722;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=MNKNlIuk3axrY6pT0co0OKRj9pPd3/hD+LEqaqLSDWM=;
 b=nmGjo3AtPG61s+XdHgWH9I5f45zafZs9L9k5dwk9k7Xkm+dqNFRZ4yHS
 apxe6xNY01OxOsTJIYjJfCyskavX7XG+qKxTH/nZbljdiAW4x45zBRgHe
 ZuPJ+MnjZEC/z6X0ZPo9LzN5rI4CSRXFcIhK3MwXHXReJjNsFEgPPc65x
 8754mBY2iQEAM2LjJl2JsWbqhIk/ryfrJSdThMTFmMJRI1HcfCtrE6/CA
 Qc8PRH4i07Nv9uKloHoz+WwBrswo2/ZVckPempV7+gT4uiSnbzKS4ofyH
 ZkDDS1oOov3m5fNSuX+pYaUMmb1OcyggbzaNjkL0jQcxeArevZBVtJQUz A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="302546232"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; d="scan'208";a="302546232"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2022 00:12:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; d="scan'208";a="580445904"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by orsmga007.jf.intel.com with ESMTP; 09 Jun 2022 00:11:58 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>,
 Will Deacon <will@kernel.org>, Joao Martins <joao.m.martins@oracle.com>
Subject: [RFC PATCHES 1/2] iommu: Add RCU-protected page free support
Date: Thu,  9 Jun 2022 15:08:10 +0800
Message-Id: <20220609070811.902868-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

The IOMMU page tables are updated using iommu_map/unmap() interfaces.
Currently, there is no mandatory requirement for drivers to use locks
to ensure concurrent updates to page tables, because it's assumed that
overlapping IOVA ranges do not have concurrent updates. Therefore the
IOMMU drivers only need to take care of concurrent updates to level
page table entries.

But enabling new features challenges this assumption. For example, the
hardware assisted dirty page tracking feature requires scanning page
tables in interfaces other than mapping and unmapping. This might result
in a use-after-free scenario in which a level page table has been freed
by the unmap() interface, while another thread is scanning the next level
page table.

This adds RCU-protected page free support so that the pages are really
freed and reused after a RCU grace period. Hence, the page tables are
safe for scanning within a rcu_read_lock critical region. Considering
that scanning the page table is a rare case, this also adds a domain
flag and the RCU-protected page free is only used when this flat is set.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h |  9 +++++++++
 drivers/iommu/iommu.c | 23 +++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 5e1afe169549..6f68eabb8567 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -95,6 +95,7 @@ struct iommu_domain {
 	void *handler_token;
 	struct iommu_domain_geometry geometry;
 	struct iommu_dma_cookie *iova_cookie;
+	unsigned long concurrent_traversal:1;
 };
 
 static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
@@ -657,6 +658,12 @@ static inline void dev_iommu_priv_set(struct device *dev, void *priv)
 	dev->iommu->priv = priv;
 }
 
+static inline void domain_set_concurrent_traversal(struct iommu_domain *domain,
+						   bool value)
+{
+	domain->concurrent_traversal = value;
+}
+
 int iommu_probe_device(struct device *dev);
 void iommu_release_device(struct device *dev);
 
@@ -677,6 +684,8 @@ int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner);
 void iommu_group_release_dma_owner(struct iommu_group *group);
 bool iommu_group_dma_owner_claimed(struct iommu_group *group);
 
+void iommu_free_pgtbl_pages(struct iommu_domain *domain,
+			    struct list_head *pages);
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 847ad47a2dfd..ceeb97ebe3e2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3252,3 +3252,26 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group)
 	return user;
 }
 EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
+
+static void pgtble_page_free_rcu(struct rcu_head *rcu)
+{
+	struct page *page = container_of(rcu, struct page, rcu_head);
+
+	__free_pages(page, 0);
+}
+
+void iommu_free_pgtbl_pages(struct iommu_domain *domain,
+			    struct list_head *pages)
+{
+	struct page *page, *next;
+
+	if (!domain->concurrent_traversal) {
+		put_pages_list(pages);
+		return;
+	}
+
+	list_for_each_entry_safe(page, next, pages, lru) {
+		list_del(&page->lru);
+		call_rcu(&page->rcu_head, pgtble_page_free_rcu);
+	}
+}
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
