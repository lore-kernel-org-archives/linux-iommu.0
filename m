Return-Path: <SRS0=Qw1r=KC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425DEC433B4
	for <iommu@archiver.kernel.org>; Fri,  7 May 2021 10:22:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE0186145D
	for <iommu@archiver.kernel.org>; Fri,  7 May 2021 10:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE0186145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A2BE6406AD;
	Fri,  7 May 2021 10:22:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hW3iOP-GgV3K; Fri,  7 May 2021 10:22:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 853CF4069C;
	Fri,  7 May 2021 10:22:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6BDC0C000D;
	Fri,  7 May 2021 10:22:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46028C0027
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 10:22:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 35DC960E2C
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 10:22:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b2x7mamA9C5E for <iommu@lists.linux-foundation.org>;
 Fri,  7 May 2021 10:22:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1A8E260E59
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 10:22:51 +0000 (UTC)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Fc5zw50PwzCr7b;
 Fri,  7 May 2021 18:20:12 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.187.224) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Fri, 7 May 2021 18:22:39 +0800
From: Keqian Zhu <zhukeqian1@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <iommu@lists.linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>,
 "Will Deacon" <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 "Jean-Philippe Brucker" <jean-philippe@linaro.org>, Lu Baolu
 <baolu.lu@linux.intel.com>, "Yi Sun" <yi.y.sun@linux.intel.com>, Tian Kevin
 <kevin.tian@intel.com>
Subject: [RFC PATCH v4 10/13] iommu/arm-smmu-v3: Realize switch_dirty_log
 iommu ops
Date: Fri, 7 May 2021 18:22:08 +0800
Message-ID: <20210507102211.8836-11-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20210507102211.8836-1-zhukeqian1@huawei.com>
References: <20210507102211.8836-1-zhukeqian1@huawei.com>
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

From: Kunkun Jiang <jiangkunkun@huawei.com>

This realizes switch_dirty_log. In order to get finer dirty
granule, it invokes arm_smmu_split_block when start dirty
log, and invokes arm_smmu_merge_page() to recover block
mapping when stop dirty log.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 142 ++++++++++++++++++++
 drivers/iommu/iommu.c                       |   5 +-
 include/linux/iommu.h                       |   2 +
 3 files changed, 147 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 3a2dc3177180..6de81d6ab652 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2580,6 +2580,147 @@ static int arm_smmu_enable_nesting(struct iommu_domain *domain)
 	return ret;
 }
 
+static int arm_smmu_split_block(struct iommu_domain *domain,
+				unsigned long iova, size_t size)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
+	size_t handled_size;
+
+	if (!(smmu->features & (ARM_SMMU_FEAT_BBML1 | ARM_SMMU_FEAT_BBML2))) {
+		dev_err(smmu->dev, "don't support BBML1/2, can't split block\n");
+		return -ENODEV;
+	}
+	if (!ops || !ops->split_block) {
+		pr_err("io-pgtable don't realize split block\n");
+		return -ENODEV;
+	}
+
+	handled_size = ops->split_block(ops, iova, size);
+	if (handled_size != size) {
+		pr_err("split block failed\n");
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int __arm_smmu_merge_page(struct iommu_domain *domain,
+				 unsigned long iova, phys_addr_t paddr,
+				 size_t size, int prot)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
+	size_t handled_size;
+
+	if (!ops || !ops->merge_page) {
+		pr_err("io-pgtable don't realize merge page\n");
+		return -ENODEV;
+	}
+
+	while (size) {
+		size_t pgsize = iommu_pgsize(domain, iova | paddr, size);
+
+		handled_size = ops->merge_page(ops, iova, paddr, pgsize, prot);
+		if (handled_size != pgsize) {
+			pr_err("merge page failed\n");
+			return -EFAULT;
+		}
+
+		pr_debug("merge handled: iova 0x%lx pa %pa size 0x%zx\n",
+			 iova, &paddr, pgsize);
+
+		iova += pgsize;
+		paddr += pgsize;
+		size -= pgsize;
+	}
+
+	return 0;
+}
+
+static int arm_smmu_merge_page(struct iommu_domain *domain, unsigned long iova,
+			       size_t size, int prot)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
+	phys_addr_t phys;
+	dma_addr_t p, i;
+	size_t cont_size;
+	int ret = 0;
+
+	if (!(smmu->features & (ARM_SMMU_FEAT_BBML1 | ARM_SMMU_FEAT_BBML2))) {
+		dev_err(smmu->dev, "don't support BBML1/2, can't merge page\n");
+		return -ENODEV;
+	}
+
+	if (!ops || !ops->iova_to_phys)
+		return -ENODEV;
+
+	while (size) {
+		phys = ops->iova_to_phys(ops, iova);
+		cont_size = PAGE_SIZE;
+		p = phys + cont_size;
+		i = iova + cont_size;
+
+		while (cont_size < size && p == ops->iova_to_phys(ops, i)) {
+			p += PAGE_SIZE;
+			i += PAGE_SIZE;
+			cont_size += PAGE_SIZE;
+		}
+
+		if (cont_size != PAGE_SIZE) {
+			ret = __arm_smmu_merge_page(domain, iova, phys,
+						    cont_size, prot);
+			if (ret)
+				break;
+		}
+
+		iova += cont_size;
+		size -= cont_size;
+	}
+
+	return ret;
+}
+
+static int arm_smmu_switch_dirty_log(struct iommu_domain *domain, bool enable,
+				     unsigned long iova, size_t size, int prot)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+
+	if (!(smmu->features & ARM_SMMU_FEAT_HD))
+		return -ENODEV;
+	if (smmu_domain->stage != ARM_SMMU_DOMAIN_S1)
+		return -EINVAL;
+
+	if (enable) {
+		/*
+		 * For SMMU, the hardware dirty management is always enabled if
+		 * hardware supports HTTU HD. The action to start dirty log is
+		 * spliting block mapping.
+		 *
+		 * We don't return error even if the split operation fail, as we
+		 * can still track dirty at block granule, which is still a much
+		 * better choice compared to full dirty policy.
+		 */
+		arm_smmu_split_block(domain, iova, size);
+	} else {
+		/*
+		 * For SMMU, the hardware dirty management is always enabled if
+		 * hardware supports HTTU HD. The action to stop dirty log is
+		 * merging page mapping.
+		 *
+		 * We don't return error even if the merge operation fail, as it
+		 * just effects performace of DMA transaction.
+		 */
+		arm_smmu_merge_page(domain, iova, size, prot);
+	}
+
+	return 0;
+}
+
 static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
 {
 	return iommu_fwspec_add_ids(dev, args->args, 1);
@@ -2678,6 +2819,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.release_device		= arm_smmu_release_device,
 	.device_group		= arm_smmu_device_group,
 	.enable_nesting		= arm_smmu_enable_nesting,
+	.switch_dirty_log	= arm_smmu_switch_dirty_log,
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.put_resv_regions	= generic_iommu_put_resv_regions,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0d15620d1e90..bb19df2317ed 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2375,8 +2375,8 @@ phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
 }
 EXPORT_SYMBOL_GPL(iommu_iova_to_phys);
 
-static size_t iommu_pgsize(struct iommu_domain *domain,
-			   unsigned long addr_merge, size_t size)
+size_t iommu_pgsize(struct iommu_domain *domain,
+		    unsigned long addr_merge, size_t size)
 {
 	unsigned int pgsize_idx;
 	size_t pgsize;
@@ -2406,6 +2406,7 @@ static size_t iommu_pgsize(struct iommu_domain *domain,
 
 	return pgsize;
 }
+EXPORT_SYMBOL_GPL(iommu_pgsize);
 
 static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
 		       phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e0e40dda974d..0a77db4f397f 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -427,6 +427,8 @@ extern int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
 				   struct device *dev, ioasid_t pasid);
 extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
 extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
+extern size_t iommu_pgsize(struct iommu_domain *domain,
+			   unsigned long addr_merge, size_t size);
 extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
 		     phys_addr_t paddr, size_t size, int prot);
 extern int iommu_map_atomic(struct iommu_domain *domain, unsigned long iova,
-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
