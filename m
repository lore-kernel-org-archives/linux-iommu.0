Return-Path: <SRS0=Q5U9=VI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A77C74A5B
	for <iommu@archiver.kernel.org>; Thu, 11 Jul 2019 17:30:44 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE41420863
	for <iommu@archiver.kernel.org>; Thu, 11 Jul 2019 17:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGZdDG0p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE41420863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8ECA254AB;
	Thu, 11 Jul 2019 17:28:58 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9D07B547D
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Jul 2019 17:20:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2CBE689A
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Jul 2019 17:20:37 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
	[217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id AC01E21670;
	Thu, 11 Jul 2019 17:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562865637;
	bh=6rzbag6zIaeztEGZ2WrSp3f+TIX1xWJH4ZyL/fbwlnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GGZdDG0pFkc/xxe6amKuM6bUd4XZuYbPfkxpKq6615wQVV2WW0GMTpxGOA+w51bk+
	uBXY4TYK205m5SUBgAZx//0eXeFkoWLRpaLnzk0MIwqi2xPkL+C8q5TN0/xN3wFe+g
	lUqSL3ZIJ+tVrGez8CCw8hSApSwz55CBKygdiLYo=
From: Will Deacon <will@kernel.org>
To: iommu@lists.linux-foundation.org
Subject: [RFC PATCH v2 19/19] iommu/arm-smmu-v3: Defer TLB invalidation until
	->iotlb_sync()
Date: Thu, 11 Jul 2019 18:19:27 +0100
Message-Id: <20190711171927.28803-20-will@kernel.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190711171927.28803-1-will@kernel.org>
References: <20190711171927.28803-1-will@kernel.org>
Cc: Vijay Kilary <vkilari@codeaurora.org>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	Will Deacon <will@kernel.org>, Jan Glauber <jglauber@marvell.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
	Jon Masters <jcm@redhat.com>, Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Update the iommu_iotlb_gather structure passed to ->tlb_add_page() and
use this information to defer all TLB invalidation until ->iotlb_sync().
This drastically reduces contention on the command queue, since we can
insert our commands in batches rather than one-by-one.

Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/arm-smmu-v3.c | 71 +++++++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 29 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 5ee2c6389df3..b71ab839db3d 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -303,6 +303,13 @@
 
 #define CMDQ_PROD_OWNED_FLAG		Q_OVERFLOW_FLAG
 
+/*
+ * This is used to size the command queue and therefore must be at least
+ * BITS_PER_LONG so that the valid_map works correctly (it relies on the
+ * total number of queue entries being a multiple of BITS_PER_LONG).
+ */
+#define CMDQ_BATCH_ENTRIES		BITS_PER_LONG
+
 #define CMDQ_0_OP			GENMASK_ULL(7, 0)
 #define CMDQ_0_SSV			(1UL << 11)
 
@@ -1930,15 +1937,17 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 	arm_smmu_cmdq_issue_sync(smmu);
 }
 
-static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
-					  size_t granule, bool leaf, void *cookie)
+static void arm_smmu_tlb_inv_range(unsigned long iova, size_t size,
+				   size_t granule, bool leaf,
+				   struct arm_smmu_domain *smmu_domain)
 {
-	struct arm_smmu_domain *smmu_domain = cookie;
+	u64 cmds[CMDQ_BATCH_ENTRIES * CMDQ_ENT_DWORDS];
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	unsigned long end = iova + size;
+	int i = 0;
 	struct arm_smmu_cmdq_ent cmd = {
 		.tlbi = {
 			.leaf	= leaf,
-			.addr	= iova,
 		},
 	};
 
@@ -1950,37 +1959,41 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
 	}
 
-	do {
-		arm_smmu_cmdq_issue_cmd(smmu, &cmd);
-		cmd.tlbi.addr += granule;
-	} while (size -= granule);
+	while (iova < end) {
+		if (i == CMDQ_BATCH_ENTRIES) {
+			arm_smmu_cmdq_issue_cmdlist(smmu, cmds, i, false);
+			i = 0;
+		}
+
+		cmd.tlbi.addr = iova;
+		arm_smmu_cmdq_build_cmd(&cmds[i * CMDQ_ENT_DWORDS], &cmd);
+		iova += granule;
+		i++;
+	}
+
+	arm_smmu_cmdq_issue_cmdlist(smmu, cmds, i, true);
 }
 
 static void arm_smmu_tlb_inv_page_nosync(struct iommu_iotlb_gather *gather,
 					 unsigned long iova, size_t granule,
 					 void *cookie)
 {
-	arm_smmu_tlb_inv_range_nosync(iova, granule, granule, true, cookie);
+	struct arm_smmu_domain *smmu_domain = cookie;
+	struct iommu_domain *domain = &smmu_domain->domain;
+
+	iommu_iotlb_gather_add_page(domain, gather, iova, granule);
 }
 
 static void arm_smmu_tlb_inv_walk(unsigned long iova, size_t size,
 				  size_t granule, void *cookie)
 {
-	struct arm_smmu_domain *smmu_domain = cookie;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
-
-	arm_smmu_tlb_inv_range_nosync(iova, size, granule, false, cookie);
-	arm_smmu_cmdq_issue_sync(smmu);
+	arm_smmu_tlb_inv_range(iova, size, granule, false, cookie);
 }
 
 static void arm_smmu_tlb_inv_leaf(unsigned long iova, size_t size,
 				  size_t granule, void *cookie)
 {
-	struct arm_smmu_domain *smmu_domain = cookie;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
-
-	arm_smmu_tlb_inv_range_nosync(iova, size, granule, true, cookie);
-	arm_smmu_cmdq_issue_sync(smmu);
+	arm_smmu_tlb_inv_range(iova, size, granule, true, cookie);
 }
 
 static const struct iommu_flush_ops arm_smmu_flush_ops = {
@@ -2391,10 +2404,10 @@ static void arm_smmu_flush_iotlb_all(struct iommu_domain *domain)
 static void arm_smmu_iotlb_sync(struct iommu_domain *domain,
 				struct iommu_iotlb_gather *gather)
 {
-	struct arm_smmu_device *smmu = to_smmu_domain(domain)->smmu;
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 
-	if (smmu)
-		arm_smmu_cmdq_issue_sync(smmu);
+	arm_smmu_tlb_inv_range(gather->start, gather->end - gather->start,
+			       gather->pgsize, true, smmu_domain);
 }
 
 static phys_addr_t
@@ -3321,15 +3334,15 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 	/* Queue sizes, capped to ensure natural alignment */
 	smmu->cmdq.q.llq.max_n_shift = min_t(u32, CMDQ_MAX_SZ_SHIFT,
 					     FIELD_GET(IDR1_CMDQS, reg));
-	if (smmu->cmdq.q.llq.max_n_shift < ilog2(BITS_PER_LONG)) {
+	if (smmu->cmdq.q.llq.max_n_shift <= ilog2(CMDQ_BATCH_ENTRIES)) {
 		/*
-		 * The cmdq valid_map relies on the total number of entries
-		 * being a multiple of BITS_PER_LONG. There's also no way
-		 * we can handle the weird alignment restrictions on the
-		 * base pointer for a unit-length queue.
+		 * We don't support splitting up batches, so one batch of
+		 * commands plus an extra sync needs to fit inside the command
+		 * queue. There's also no way we can handle the weird alignment
+		 * restrictions on the base pointer for a unit-length queue.
 		 */
-		dev_err(smmu->dev, "command queue size < %d entries not supported\n",
-			BITS_PER_LONG);
+		dev_err(smmu->dev, "command queue size <= %d entries not supported\n",
+			CMDQ_BATCH_ENTRIES);
 		return -ENXIO;
 	}
 
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
