Return-Path: <SRS0=OQ2u=LU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEB6C49EA7
	for <iommu@archiver.kernel.org>; Sat, 26 Jun 2021 11:02:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB2936191E
	for <iommu@archiver.kernel.org>; Sat, 26 Jun 2021 11:02:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB2936191E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 56D8940186;
	Sat, 26 Jun 2021 11:02:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h03gHQYoR0tz; Sat, 26 Jun 2021 11:02:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C4054402F2;
	Sat, 26 Jun 2021 11:02:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF110C001A;
	Sat, 26 Jun 2021 11:02:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2EEE9C000E
 for <iommu@lists.linux-foundation.org>; Sat, 26 Jun 2021 11:02:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C458F60615
 for <iommu@lists.linux-foundation.org>; Sat, 26 Jun 2021 11:02:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UScxDwwv00R3 for <iommu@lists.linux-foundation.org>;
 Sat, 26 Jun 2021 11:02:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AD0646063E
 for <iommu@lists.linux-foundation.org>; Sat, 26 Jun 2021 11:02:14 +0000 (UTC)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GBrRG2D4hzXlHg;
 Sat, 26 Jun 2021 18:56:58 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 26 Jun 2021 19:02:12 +0800
Received: from thunder-town.china.huawei.com (10.174.179.0) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 26 Jun 2021 19:02:12 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, linux-arm-kernel
 <linux-arm-kernel@lists.infradead.org>, iommu
 <iommu@lists.linux-foundation.org>, linux-kernel
 <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC 8/8] iommu/arm-smmu-v3: Add support for less than one
 ECMDQ per core
Date: Sat, 26 Jun 2021 19:01:30 +0800
Message-ID: <20210626110130.2416-9-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210626110130.2416-1-thunder.leizhen@huawei.com>
References: <20210626110130.2416-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
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

Due to limited hardware resources, the number of ECMDQs may be less than
the number of cores. If the number of ECMDQs is greater than the number of
numa nodes, ensure that each node has at least one ECMDQ. This is because
ECMDQ queue memory is requested from the NUMA node where it resides, which
may result in better command filling and insertion performance.

The current ECMDQ implementation reuses the command insertion function
arm_smmu_cmdq_issue_cmdlist() of the normal CMDQ. This function already
supports multiple cores concurrent insertion commands.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 101 ++++++++++++++++++--
 1 file changed, 92 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a088f2479fc6223..55f651ce42e7a51 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3636,14 +3636,15 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 
 static int arm_smmu_ecmdq_layout(struct arm_smmu_device *smmu)
 {
-	int cpu;
-	struct arm_smmu_ecmdq *ecmdq;
+	int cpu, node, nr_remain, nr_nodes = 0;
+	int *nr_ecmdqs;
+	struct arm_smmu_ecmdq *ecmdq, **ecmdqs;
 
-	if (num_possible_cpus() <= smmu->nr_ecmdq) {
-		ecmdq = devm_alloc_percpu(smmu->dev, *ecmdq);
-		if (!ecmdq)
-			return -ENOMEM;
+	ecmdq = devm_alloc_percpu(smmu->dev, *ecmdq);
+	if (!ecmdq)
+		return -ENOMEM;
 
+	if (num_possible_cpus() <= smmu->nr_ecmdq) {
 		for_each_possible_cpu(cpu)
 			*per_cpu_ptr(smmu->ecmdq, cpu) = per_cpu_ptr(ecmdq, cpu);
 
@@ -3653,7 +3654,79 @@ static int arm_smmu_ecmdq_layout(struct arm_smmu_device *smmu)
 		return 0;
 	}
 
-	return -ENOSPC;
+	for_each_node(node)
+		if (nr_cpus_node(node))
+			nr_nodes++;
+
+	if (nr_nodes >= smmu->nr_ecmdq) {
+		dev_err(smmu->dev, "%d ECMDQs is less than %d nodes\n", smmu->nr_ecmdq, nr_nodes);
+		return -ENOSPC;
+	}
+
+	nr_ecmdqs = kcalloc(MAX_NUMNODES, sizeof(int), GFP_KERNEL);
+	if (!nr_ecmdqs)
+		return -ENOMEM;
+
+	ecmdqs = kcalloc(smmu->nr_ecmdq, sizeof(*ecmdqs), GFP_KERNEL);
+	if (!ecmdqs) {
+		kfree(nr_ecmdqs);
+		return -ENOMEM;
+	}
+
+	/* [1] Ensure that each node has at least one ECMDQ */
+	nr_remain = smmu->nr_ecmdq - nr_nodes;
+	for_each_node(node) {
+		/*
+		 * Calculate the number of ECMDQs to be allocated to this node.
+		 * NR_ECMDQS_PER_CPU = nr_remain / num_possible_cpus();
+		 * When nr_cpus_node(node) is not zero, less than one ECMDQ
+		 * may be left due to truncation rounding.
+		 */
+		nr_ecmdqs[node] = nr_cpus_node(node) * nr_remain / num_possible_cpus();
+		nr_remain -= nr_ecmdqs[node];
+	}
+
+	/* Divide the remaining ECMDQs */
+	while (nr_remain) {
+		for_each_node(node) {
+			if (!nr_remain)
+				break;
+
+			if (nr_ecmdqs[node] >= nr_cpus_node(node))
+				continue;
+
+			nr_ecmdqs[node]++;
+			nr_remain--;
+		}
+	}
+
+	for_each_node(node) {
+		int i, round, shared = 0;
+
+		if (!nr_cpus_node(node))
+			continue;
+
+		/* An ECMDQ has been reserved for each node at above [1] */
+		nr_ecmdqs[node]++;
+
+		if (nr_ecmdqs[node] < nr_cpus_node(node))
+			shared = 1;
+
+		i = 0;
+		for_each_cpu(cpu, cpumask_of_node(node)) {
+			round = i % nr_ecmdqs[node];
+			if (i++ < nr_ecmdqs[node]) {
+				ecmdqs[round] = per_cpu_ptr(ecmdq, cpu);
+				ecmdqs[round]->cmdq.shared = shared;
+			}
+			*per_cpu_ptr(smmu->ecmdq, cpu) = ecmdqs[round];
+		}
+	}
+
+	kfree(nr_ecmdqs);
+	kfree(ecmdqs);
+
+	return 0;
 }
 
 static int arm_smmu_ecmdq_probe(struct arm_smmu_device *smmu)
@@ -3718,10 +3791,20 @@ static int arm_smmu_ecmdq_probe(struct arm_smmu_device *smmu)
 		struct arm_smmu_queue *q;
 
 		ecmdq = *per_cpu_ptr(smmu->ecmdq, cpu);
-		ecmdq->base = cp_base + addr;
-
 		q = &ecmdq->cmdq.q;
 
+		/*
+		 * The boot option "maxcpus=" can limit the number of online
+		 * CPUs. The CPUs that are not selected are not showed in
+		 * cpumask_of_node(node), their 'ecmdq' may be NULL.
+		 *
+		 * (q->ecmdq_prod & ECMDQ_PROD_EN) indicates that the ECMDQ is
+		 * shared by multiple cores and has been initialized.
+		 */
+		if (!ecmdq || (q->ecmdq_prod & ECMDQ_PROD_EN))
+			continue;
+		ecmdq->base = cp_base + addr;
+
 		q->llq.max_n_shift = ECMDQ_MAX_SZ_SHIFT + shift_increment;
 		ret = arm_smmu_init_one_queue(smmu, q, ecmdq->base, ARM_SMMU_ECMDQ_PROD,
 				ARM_SMMU_ECMDQ_CONS, CMDQ_ENT_DWORDS, "ecmdq");
-- 
2.26.0.106.g9fadedd


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
