Return-Path: <SRS0=mWFx=7O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52ADC433E0
	for <iommu@archiver.kernel.org>; Mon,  1 Jun 2020 11:33:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E93D20738
	for <iommu@archiver.kernel.org>; Mon,  1 Jun 2020 11:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E93D20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7935784F5C;
	Mon,  1 Jun 2020 11:33:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V+VRaS-8v5H4; Mon,  1 Jun 2020 11:33:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8B7A385A90;
	Mon,  1 Jun 2020 11:33:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 747D6C0178;
	Mon,  1 Jun 2020 11:33:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17123C0176
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 11:33:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CCC211FF59
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 11:33:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wZkT1iA64ax5 for <iommu@lists.linux-foundation.org>;
 Mon,  1 Jun 2020 11:33:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by silver.osuosl.org (Postfix) with ESMTPS id 89E7D20035
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 11:33:29 +0000 (UTC)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id C7A55737A7AB0965E261;
 Mon,  1 Jun 2020 19:33:24 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.200.163) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Mon, 1 Jun 2020 19:33:14 +0800
From: Barry Song <song.bao.hua@hisilicon.com>
To: <hch@lst.de>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
 <will@kernel.org>
Subject: [PATCH] iommu/arm-smmu-v3: allocate the memory of queues in local
 numa node
Date: Mon, 1 Jun 2020 23:31:41 +1200
Message-ID: <20200601113141.69488-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.126.200.163]
X-CFilter-Loop: Reflected
Cc: iommu@lists.linux-foundation.org, linuxarm@huawei.com,
 linux-arm-kernel@lists.infradead.org
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

dmam_alloc_coherent() will usually allocate memory from the default CMA. For
a common arm64 defconfig without reserved memory in device tree, there is only
one CMA close to address 0.
dma_alloc_contiguous() will allocate memory without any idea of  NUMA and smmu
has no customized per-numa cma_area.
struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
{
        size_t count = size >> PAGE_SHIFT;
        struct page *page = NULL;
        struct cma *cma = NULL;

        if (dev && dev->cma_area)
                cma = dev->cma_area;
        else if (count > 1)
                cma = dma_contiguous_default_area;

	...
        return page;
}

if there are N numa nodes, N-1 nodes will put command/evt queues etc in a
remote node the default CMA belongs to,probably node 0. Tests show, after
sending CMD_SYNC in an empty command queue,
on Node2, without this patch, it takes 550ns to wait for the completion
of CMD_SYNC; with this patch, it takes 250ns to wait for the completion
of CMD_SYNC.

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 drivers/iommu/arm-smmu-v3.c | 63 ++++++++++++++++++++++++++++---------
 1 file changed, 48 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 82508730feb7..58295423e1d7 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -3157,21 +3157,23 @@ static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 				   size_t dwords, const char *name)
 {
 	size_t qsz;
+	struct page *page;
 
-	do {
-		qsz = ((1 << q->llq.max_n_shift) * dwords) << 3;
-		q->base = dmam_alloc_coherent(smmu->dev, qsz, &q->base_dma,
-					      GFP_KERNEL);
-		if (q->base || qsz < PAGE_SIZE)
-			break;
-
-		q->llq.max_n_shift--;
-	} while (1);
+	qsz = ((1 << q->llq.max_n_shift) * dwords) << 3;
+	page = alloc_pages_node(dev_to_node(smmu->dev), GFP_KERNEL,
+				get_order(qsz));
+	if (!page) {
+		dev_err(smmu->dev,
+				"failed to allocate queue (0x%zx bytes) for %s\n",
+				qsz, name);
+		return -ENOMEM;
+	}
 
-	if (!q->base) {
+	q->base = page_address(page);
+	q->base_dma = dma_map_single(smmu->dev, q->base, qsz, DMA_BIDIRECTIONAL);
+	if (dma_mapping_error(smmu->dev, q->base_dma)) {
 		dev_err(smmu->dev,
-			"failed to allocate queue (0x%zx bytes) for %s\n",
-			qsz, name);
+				"failed to dma map for %s\n", name);
 		return -ENOMEM;
 	}
 
@@ -3192,6 +3194,18 @@ static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 	return 0;
 }
 
+static int arm_smmu_deinit_one_queue(struct arm_smmu_device *smmu,
+				   struct arm_smmu_queue *q,
+				   size_t dwords)
+{
+	size_t qsz = ((1 << q->llq.max_n_shift) * dwords) << 3;
+
+	dma_unmap_single(smmu->dev, q->base_dma, qsz, DMA_BIDIRECTIONAL);
+	free_page((unsigned long)q->base);
+
+	return 0;
+}
+
 static void arm_smmu_cmdq_free_bitmap(void *data)
 {
 	unsigned long *bitmap = data;
@@ -3233,22 +3247,40 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 
 	ret = arm_smmu_cmdq_init(smmu);
 	if (ret)
-		return ret;
+		goto deinit_cmdq;
 
 	/* evtq */
 	ret = arm_smmu_init_one_queue(smmu, &smmu->evtq.q, ARM_SMMU_EVTQ_PROD,
 				      ARM_SMMU_EVTQ_CONS, EVTQ_ENT_DWORDS,
 				      "evtq");
 	if (ret)
-		return ret;
+		goto deinit_cmdq;
 
 	/* priq */
 	if (!(smmu->features & ARM_SMMU_FEAT_PRI))
 		return 0;
 
-	return arm_smmu_init_one_queue(smmu, &smmu->priq.q, ARM_SMMU_PRIQ_PROD,
+	ret = arm_smmu_init_one_queue(smmu, &smmu->priq.q, ARM_SMMU_PRIQ_PROD,
 				       ARM_SMMU_PRIQ_CONS, PRIQ_ENT_DWORDS,
 				       "priq");
+	if (ret)
+		goto deinit_evtq;
+
+	return 0;
+
+deinit_evtq:
+	arm_smmu_deinit_one_queue(smmu, &smmu->evtq.q, EVTQ_ENT_DWORDS);
+deinit_cmdq:
+	arm_smmu_deinit_one_queue(smmu, &smmu->cmdq.q, CMDQ_ENT_DWORDS);
+	return ret;
+}
+
+static void arm_smmu_deinit_queues(struct arm_smmu_device *smmu)
+{
+	arm_smmu_deinit_one_queue(smmu, &smmu->cmdq.q, CMDQ_ENT_DWORDS);
+	arm_smmu_deinit_one_queue(smmu, &smmu->evtq.q, EVTQ_ENT_DWORDS);
+	if (smmu->features & ARM_SMMU_FEAT_PRI)
+		arm_smmu_deinit_one_queue(smmu, &smmu->priq.q, PRIQ_ENT_DWORDS);
 }
 
 static int arm_smmu_init_l1_strtab(struct arm_smmu_device *smmu)
@@ -4121,6 +4153,7 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 	arm_smmu_set_bus_ops(NULL);
 	iommu_device_unregister(&smmu->iommu);
 	iommu_device_sysfs_remove(&smmu->iommu);
+	arm_smmu_deinit_queues(smmu);
 	arm_smmu_device_disable(smmu);
 
 	return 0;
-- 
2.23.0


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
