Return-Path: <SRS0=gU7u=JK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B6FC43603
	for <iommu@archiver.kernel.org>; Tue, 13 Apr 2021 08:55:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 336AD613AE
	for <iommu@archiver.kernel.org>; Tue, 13 Apr 2021 08:55:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 336AD613AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1701D8433D;
	Tue, 13 Apr 2021 08:55:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qgw5vflgVCSa; Tue, 13 Apr 2021 08:55:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id E40A484349;
	Tue, 13 Apr 2021 08:55:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D01E9C000C;
	Tue, 13 Apr 2021 08:55:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0BA7C000C
 for <iommu@lists.linux-foundation.org>; Tue, 13 Apr 2021 08:55:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 62031842D1
 for <iommu@lists.linux-foundation.org>; Tue, 13 Apr 2021 08:55:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0WZa01WUB5fK for <iommu@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 08:55:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6EA3584158
 for <iommu@lists.linux-foundation.org>; Tue, 13 Apr 2021 08:55:22 +0000 (UTC)
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FKK9k0wc6zPqbY;
 Tue, 13 Apr 2021 16:52:26 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.187.224) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 13 Apr 2021 16:55:07 +0800
From: Keqian Zhu <zhukeqian1@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <iommu@lists.linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>,
 "Will Deacon" <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, Yi Sun
 <yi.y.sun@linux.intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Tian Kevin
 <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 02/12] iommu: Add iommu_split_block interface
Date: Tue, 13 Apr 2021 16:54:47 +0800
Message-ID: <20210413085457.25400-3-zhukeqian1@huawei.com>
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

Block(largepage) mapping is not a proper granule for dirty log tracking.
Take an extreme example, if DMA writes one byte, under 1G mapping, the
dirty amount reported is 1G, but under 4K mapping, the dirty amount is
just 4K.

This adds a new interface named iommu_split_block in IOMMU base layer.
A specific IOMMU driver can invoke it during start dirty log. If so, the
driver also need to realize the split_block iommu ops.

We flush all iotlbs after the whole procedure is completed to ease the
pressure of IOMMU, as we will hanle a huge range of mapping in general.

Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
---
 drivers/iommu/iommu.c | 41 +++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h | 11 +++++++++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 667b2d6d2fc0..bb413a927870 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2721,6 +2721,47 @@ int iommu_domain_set_attr(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_GPL(iommu_domain_set_attr);
 
+int iommu_split_block(struct iommu_domain *domain, unsigned long iova,
+		      size_t size)
+{
+	const struct iommu_ops *ops = domain->ops;
+	unsigned int min_pagesz;
+	size_t pgsize;
+	bool flush = false;
+	int ret = 0;
+
+	if (unlikely(!ops || !ops->split_block))
+		return -ENODEV;
+
+	min_pagesz = 1 << __ffs(domain->pgsize_bitmap);
+	if (!IS_ALIGNED(iova | size, min_pagesz)) {
+		pr_err("unaligned: iova 0x%lx size 0x%zx min_pagesz 0x%x\n",
+		       iova, size, min_pagesz);
+		return -EINVAL;
+	}
+
+	while (size) {
+		flush = true;
+
+		pgsize = iommu_pgsize(domain, iova, size);
+
+		ret = ops->split_block(domain, iova, pgsize);
+		if (ret)
+			break;
+
+		pr_debug("split handled: iova 0x%lx size 0x%zx\n", iova, pgsize);
+
+		iova += pgsize;
+		size -= pgsize;
+	}
+
+	if (flush)
+		iommu_flush_iotlb_all(domain);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_split_block);
+
 int iommu_switch_dirty_log(struct iommu_domain *domain, bool enable,
 			   unsigned long iova, size_t size, int prot)
 {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 7f9ed9f520e2..c6c90ac069e3 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -208,6 +208,7 @@ struct iommu_iotlb_gather {
  * @device_group: find iommu group for a particular device
  * @domain_get_attr: Query domain attributes
  * @domain_set_attr: Change domain attributes
+ * @split_block: Split block mapping into page mapping
  * @switch_dirty_log: Perform actions to start|stop dirty log tracking
  * @sync_dirty_log: Sync dirty log from IOMMU into a dirty bitmap
  * @clear_dirty_log: Clear dirty log of IOMMU by a mask bitmap
@@ -267,6 +268,8 @@ struct iommu_ops {
 			       enum iommu_attr attr, void *data);
 
 	/* Track dirty log */
+	int (*split_block)(struct iommu_domain *domain, unsigned long iova,
+			   size_t size);
 	int (*switch_dirty_log)(struct iommu_domain *domain, bool enable,
 				unsigned long iova, size_t size, int prot);
 	int (*sync_dirty_log)(struct iommu_domain *domain,
@@ -529,6 +532,8 @@ extern int iommu_domain_get_attr(struct iommu_domain *domain, enum iommu_attr,
 				 void *data);
 extern int iommu_domain_set_attr(struct iommu_domain *domain, enum iommu_attr,
 				 void *data);
+extern int iommu_split_block(struct iommu_domain *domain, unsigned long iova,
+			     size_t size);
 extern int iommu_switch_dirty_log(struct iommu_domain *domain, bool enable,
 				  unsigned long iova, size_t size, int prot);
 extern int iommu_sync_dirty_log(struct iommu_domain *domain, unsigned long iova,
@@ -929,6 +934,12 @@ static inline int iommu_domain_set_attr(struct iommu_domain *domain,
 	return -EINVAL;
 }
 
+static inline int iommu_split_block(struct iommu_domain *domain,
+				    unsigned long iova, size_t size)
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
