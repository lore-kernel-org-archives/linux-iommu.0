Return-Path: <SRS0=gU7u=JK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3E2C43600
	for <iommu@archiver.kernel.org>; Tue, 13 Apr 2021 08:55:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C60A60249
	for <iommu@archiver.kernel.org>; Tue, 13 Apr 2021 08:55:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C60A60249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 761AA60B66;
	Tue, 13 Apr 2021 08:55:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1vlowtNm_nXY; Tue, 13 Apr 2021 08:55:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id B2BF060BA4;
	Tue, 13 Apr 2021 08:55:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 366FAC001A;
	Tue, 13 Apr 2021 08:55:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E60E4C000A
 for <iommu@lists.linux-foundation.org>; Tue, 13 Apr 2021 08:55:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E1BB940657
 for <iommu@lists.linux-foundation.org>; Tue, 13 Apr 2021 08:55:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E7uDSq6O4ieD for <iommu@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 08:55:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A284140677
 for <iommu@lists.linux-foundation.org>; Tue, 13 Apr 2021 08:55:20 +0000 (UTC)
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FKK9k0VVxzPqkd;
 Tue, 13 Apr 2021 16:52:26 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.187.224) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 13 Apr 2021 16:55:08 +0800
From: Keqian Zhu <zhukeqian1@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <iommu@lists.linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>,
 "Will Deacon" <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, Yi Sun
 <yi.y.sun@linux.intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Tian Kevin
 <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 03/12] iommu: Add iommu_merge_page interface
Date: Tue, 13 Apr 2021 16:54:48 +0800
Message-ID: <20210413085457.25400-4-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20210413085457.25400-1-zhukeqian1@huawei.com>
References: <20210413085457.25400-1-zhukeqian1@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.187.224]
X-CFilter-Loop: Reflected
Cc: jiangkunkun@huawei.com, Cornelia Huck <cohuck@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, lushenming@huawei.com,
 Alex Williamson <alex.williamson@redhat.com>, wanghaibin.wang@huawei.com
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

If block(largepage) mappings are split during start dirty log, then
when stop dirty log, we need to recover them for better DMA performance.

This adds a new interface named iommu_merge_page in IOMMU base layer.
A specific IOMMU driver can invoke it during stop dirty log. If so, the
driver also need to realize the merge_page iommu ops.

We flush all iotlbs after the whole procedure is completed to ease the
pressure of iommu, as we will hanle a huge range of mapping in general.

Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
---
 drivers/iommu/iommu.c | 75 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h | 12 +++++++
 2 files changed, 87 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index bb413a927870..8f0d71bafb3a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2762,6 +2762,81 @@ int iommu_split_block(struct iommu_domain *domain, unsigned long iova,
 }
 EXPORT_SYMBOL_GPL(iommu_split_block);
 
+static int __iommu_merge_page(struct iommu_domain *domain,
+			      unsigned long iova, phys_addr_t paddr,
+			      size_t size, int prot)
+{
+	const struct iommu_ops *ops = domain->ops;
+	unsigned int min_pagesz;
+	size_t pgsize;
+	int ret = 0;
+
+	if (unlikely(!ops || !ops->merge_page))
+		return -ENODEV;
+
+	min_pagesz = 1 << __ffs(domain->pgsize_bitmap);
+	if (!IS_ALIGNED(iova | paddr | size, min_pagesz)) {
+		pr_err("unaligned: iova 0x%lx pa %pa size 0x%zx min_pagesz 0x%x\n",
+			iova, &paddr, size, min_pagesz);
+		return -EINVAL;
+	}
+
+	while (size) {
+		pgsize = iommu_pgsize(domain, iova | paddr, size);
+
+		ret = ops->merge_page(domain, iova, paddr, pgsize, prot);
+		if (ret)
+			break;
+
+		pr_debug("merge handled: iova 0x%lx pa %pa size 0x%zx\n",
+			 iova, &paddr, pgsize);
+
+		iova += pgsize;
+		paddr += pgsize;
+		size -= pgsize;
+	}
+
+	return ret;
+}
+
+int iommu_merge_page(struct iommu_domain *domain, unsigned long iova,
+		     size_t size, int prot)
+{
+	phys_addr_t phys;
+	dma_addr_t p, i;
+	size_t cont_size;
+	bool flush = false;
+	int ret = 0;
+
+	while (size) {
+		flush = true;
+
+		phys = iommu_iova_to_phys(domain, iova);
+		cont_size = PAGE_SIZE;
+		p = phys + cont_size;
+		i = iova + cont_size;
+
+		while (cont_size < size && p == iommu_iova_to_phys(domain, i)) {
+			p += PAGE_SIZE;
+			i += PAGE_SIZE;
+			cont_size += PAGE_SIZE;
+		}
+
+		ret = __iommu_merge_page(domain, iova, phys, cont_size, prot);
+		if (ret)
+			break;
+
+		iova += cont_size;
+		size -= cont_size;
+	}
+
+	if (flush)
+		iommu_flush_iotlb_all(domain);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_merge_page);
+
 int iommu_switch_dirty_log(struct iommu_domain *domain, bool enable,
 			   unsigned long iova, size_t size, int prot)
 {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c6c90ac069e3..fea3ecabff3d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -209,6 +209,7 @@ struct iommu_iotlb_gather {
  * @domain_get_attr: Query domain attributes
  * @domain_set_attr: Change domain attributes
  * @split_block: Split block mapping into page mapping
+ * @merge_page: Merge page mapping into block mapping
  * @switch_dirty_log: Perform actions to start|stop dirty log tracking
  * @sync_dirty_log: Sync dirty log from IOMMU into a dirty bitmap
  * @clear_dirty_log: Clear dirty log of IOMMU by a mask bitmap
@@ -270,6 +271,8 @@ struct iommu_ops {
 	/* Track dirty log */
 	int (*split_block)(struct iommu_domain *domain, unsigned long iova,
 			   size_t size);
+	int (*merge_page)(struct iommu_domain *domain, unsigned long iova,
+			  phys_addr_t phys, size_t size, int prot);
 	int (*switch_dirty_log)(struct iommu_domain *domain, bool enable,
 				unsigned long iova, size_t size, int prot);
 	int (*sync_dirty_log)(struct iommu_domain *domain,
@@ -534,6 +537,8 @@ extern int iommu_domain_set_attr(struct iommu_domain *domain, enum iommu_attr,
 				 void *data);
 extern int iommu_split_block(struct iommu_domain *domain, unsigned long iova,
 			     size_t size);
+extern int iommu_merge_page(struct iommu_domain *domain, unsigned long iova,
+			    size_t size, int prot);
 extern int iommu_switch_dirty_log(struct iommu_domain *domain, bool enable,
 				  unsigned long iova, size_t size, int prot);
 extern int iommu_sync_dirty_log(struct iommu_domain *domain, unsigned long iova,
@@ -940,6 +945,13 @@ static inline int iommu_split_block(struct iommu_domain *domain,
 	return -EINVAL;
 }
 
+static inline int iommu_merge_page(struct iommu_domain *domain,
+				   unsigned long iova, size_t size,
+				   int prot)
+{
+	return -EINVAL;
+}
+
 static inline int iommu_switch_dirty_log(struct iommu_domain *domain,
 					 bool enable, unsigned long iova,
 					 size_t size, int prot)
-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
