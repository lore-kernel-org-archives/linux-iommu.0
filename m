Return-Path: <SRS0=OQ2u=LU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CC3C49EA5
	for <iommu@archiver.kernel.org>; Sat, 26 Jun 2021 11:02:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B58A16145E
	for <iommu@archiver.kernel.org>; Sat, 26 Jun 2021 11:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B58A16145E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 39CF6606C9;
	Sat, 26 Jun 2021 11:02:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dO1DuVB0YKsP; Sat, 26 Jun 2021 11:02:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C70E2606B0;
	Sat, 26 Jun 2021 11:02:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D721C001F;
	Sat, 26 Jun 2021 11:02:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C984C002E
 for <iommu@lists.linux-foundation.org>; Sat, 26 Jun 2021 11:02:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CE62F403B2
 for <iommu@lists.linux-foundation.org>; Sat, 26 Jun 2021 11:02:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TODFjCTaD-FZ for <iommu@lists.linux-foundation.org>;
 Sat, 26 Jun 2021 11:02:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 28F664039B
 for <iommu@lists.linux-foundation.org>; Sat, 26 Jun 2021 11:02:13 +0000 (UTC)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GBrTT0M1Dz73Wx;
 Sat, 26 Jun 2021 18:58:53 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 26 Jun 2021 19:02:11 +0800
Received: from thunder-town.china.huawei.com (10.174.179.0) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 26 Jun 2021 19:02:10 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, linux-arm-kernel
 <linux-arm-kernel@lists.infradead.org>, iommu
 <iommu@lists.linux-foundation.org>, linux-kernel
 <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC 5/8] iommu/arm-smmu-v3: Add support for ECMDQ register mode
Date: Sat, 26 Jun 2021 19:01:27 +0800
Message-ID: <20210626110130.2416-6-thunder.leizhen@huawei.com>
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

Ensure that each core exclusively occupies an ECMDQ and all of them are
enabled during initialization. During this initialization process, any
errors will result in a fallback to using normal CMDQ.

When GERROR is triggered by ECMDQ, all ECMDQs need to be traversed: the
ECMDQs with errors will be processed and the ECMDQs without errors will
be skipped directly.

Compared with register SMMU_CMDQ_PROD, register SMMU_ECMDQ_PROD has one
more 'EN' bit and one more 'ERRACK' bit. Therefore, an extra member
'ecmdq_prod' is added to record the values of these two bits. Each time
register SMMU_ECMDQ_PROD is updated, the value of 'ecmdq_prod' is ORed.
After the error indicated by SMMU_GERROR.CMDQP_ERR is fixed, the 'ERRACK'
bit needs to be toggled to resume the corresponding ECMDQ. Therefore, a
rwlock is used to protect the write operation to bit 'ERRACK' during error
handling and the read operation to bit 'ERRACK' during command insertion.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 210 +++++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  36 ++++
 2 files changed, 245 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 62b2742daab3257..d7b590e911a879d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -337,6 +337,14 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 
 static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu)
 {
+	if (smmu->ecmdq_enabled) {
+		struct arm_smmu_ecmdq *ecmdq;
+
+		ecmdq = *this_cpu_ptr(smmu->ecmdq);
+
+		return &ecmdq->cmdq;
+	}
+
 	return &smmu->cmdq;
 }
 
@@ -421,6 +429,38 @@ static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
 	__arm_smmu_cmdq_skip_err(smmu, &smmu->cmdq.q);
 }
 
+static void arm_smmu_ecmdq_skip_err(struct arm_smmu_device *smmu)
+{
+	int i;
+	u32 prod, cons;
+	struct arm_smmu_queue *q;
+	struct arm_smmu_ecmdq *ecmdq;
+
+	for (i = 0; i < smmu->nr_ecmdq; i++) {
+		unsigned long flags;
+
+		ecmdq = *per_cpu_ptr(smmu->ecmdq, i);
+		q = &ecmdq->cmdq.q;
+
+		prod = readl_relaxed(q->prod_reg);
+		cons = readl_relaxed(q->cons_reg);
+		if (((prod ^ cons) & ECMDQ_CONS_ERR) == 0)
+			continue;
+
+		__arm_smmu_cmdq_skip_err(smmu, q);
+
+		write_lock_irqsave(&q->ecmdq_lock, flags);
+		q->ecmdq_prod &= ~ECMDQ_PROD_ERRACK;
+		q->ecmdq_prod |= cons & ECMDQ_CONS_ERR;
+
+		prod = readl_relaxed(q->prod_reg);
+		prod &= ~ECMDQ_PROD_ERRACK;
+		prod |= cons & ECMDQ_CONS_ERR;
+		writel(prod, q->prod_reg);
+		write_unlock_irqrestore(&q->ecmdq_lock, flags);
+	}
+}
+
 /*
  * Command queue locking.
  * This is a form of bastardised rwlock with the following major changes:
@@ -817,7 +857,13 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 		 * d. Advance the hardware prod pointer
 		 * Control dependency ordering from the entries becoming valid.
 		 */
-		writel_relaxed(prod, cmdq->q.prod_reg);
+		if (smmu->ecmdq_enabled) {
+			read_lock(&cmdq->q.ecmdq_lock);
+			writel_relaxed(prod | cmdq->q.ecmdq_prod, cmdq->q.prod_reg);
+			read_unlock(&cmdq->q.ecmdq_lock);
+		} else {
+			writel_relaxed(prod, cmdq->q.prod_reg);
+		}
 
 		/*
 		 * e. Tell the next owner we're done
@@ -1675,6 +1721,9 @@ static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
 	if (active & GERROR_CMDQ_ERR)
 		arm_smmu_cmdq_skip_err(smmu);
 
+	if (active & GERROR_CMDQP_ERR)
+		arm_smmu_ecmdq_skip_err(smmu);
+
 	writel(gerror, smmu->base + ARM_SMMU_GERRORN);
 	return IRQ_HANDLED;
 }
@@ -2941,6 +2990,20 @@ static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu)
 	return ret;
 }
 
+static int arm_smmu_ecmdq_init(struct arm_smmu_cmdq *cmdq)
+{
+	unsigned int nents = 1 << cmdq->q.llq.max_n_shift;
+
+	atomic_set(&cmdq->owner_prod, 0);
+	atomic_set(&cmdq->lock, 0);
+
+	cmdq->valid_map = (atomic_long_t *)bitmap_zalloc(nents, GFP_KERNEL);
+	if (!cmdq->valid_map)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 {
 	int ret;
@@ -3304,6 +3367,7 @@ static int arm_smmu_device_disable(struct arm_smmu_device *smmu)
 
 static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 {
+	int i;
 	int ret;
 	u32 reg, enables;
 	struct arm_smmu_cmdq_ent cmd;
@@ -3348,6 +3412,28 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 	writel_relaxed(smmu->cmdq.q.llq.prod, smmu->base + ARM_SMMU_CMDQ_PROD);
 	writel_relaxed(smmu->cmdq.q.llq.cons, smmu->base + ARM_SMMU_CMDQ_CONS);
 
+	for (i = 0; i < smmu->nr_ecmdq; i++) {
+		struct arm_smmu_ecmdq *ecmdq;
+		struct arm_smmu_queue *q;
+
+		ecmdq = *per_cpu_ptr(smmu->ecmdq, i);
+		q = &ecmdq->cmdq.q;
+
+		writeq_relaxed(q->q_base, ecmdq->base + ARM_SMMU_ECMDQ_BASE);
+		writel_relaxed(q->llq.prod, ecmdq->base + ARM_SMMU_ECMDQ_PROD);
+		writel_relaxed(q->llq.cons, ecmdq->base + ARM_SMMU_ECMDQ_CONS);
+
+		/* enable ecmdq */
+		writel(ECMDQ_PROD_EN, q->prod_reg);
+		ret = readl_relaxed_poll_timeout(q->cons_reg, reg, reg & ECMDQ_CONS_ENACK,
+					  1, ARM_SMMU_POLL_TIMEOUT_US);
+		if (ret) {
+			dev_err(smmu->dev, "ecmdq[%d] enable failed\n", i);
+			smmu->ecmdq_enabled = 0;
+			break;
+		}
+	}
+
 	enables = CR0_CMDQEN;
 	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
 				      ARM_SMMU_CR0ACK);
@@ -3437,6 +3523,115 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 	return 0;
 }
 
+static int arm_smmu_ecmdq_layout(struct arm_smmu_device *smmu)
+{
+	int cpu;
+	struct arm_smmu_ecmdq *ecmdq;
+
+	if (num_possible_cpus() <= smmu->nr_ecmdq) {
+		ecmdq = devm_alloc_percpu(smmu->dev, *ecmdq);
+		if (!ecmdq)
+			return -ENOMEM;
+
+		for_each_possible_cpu(cpu)
+			*per_cpu_ptr(smmu->ecmdq, cpu) = per_cpu_ptr(ecmdq, cpu);
+
+		/* A core requires at most one ECMDQ */
+		smmu->nr_ecmdq = num_possible_cpus();
+
+		return 0;
+	}
+
+	return -ENOSPC;
+}
+
+static int arm_smmu_ecmdq_probe(struct arm_smmu_device *smmu)
+{
+	int ret, cpu;
+	u32 i, nump, numq, gap;
+	u32 reg, shift_increment;
+	u64 addr, smmu_dma_base;
+	void __iomem *cp_regs, *cp_base;
+
+	/* IDR6 */
+	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR6);
+	nump = 1 << FIELD_GET(IDR6_LOG2NUMP, reg);
+	numq = 1 << FIELD_GET(IDR6_LOG2NUMQ, reg);
+	smmu->nr_ecmdq = nump * numq;
+	gap = ECMDQ_CP_RRESET_SIZE >> FIELD_GET(IDR6_LOG2NUMQ, reg);
+
+	smmu_dma_base = (vmalloc_to_pfn(smmu->base) << PAGE_SHIFT);
+	cp_regs = ioremap(smmu_dma_base + ARM_SMMU_ECMDQ_CP_BASE, PAGE_SIZE);
+	if (!cp_regs)
+		return -ENOMEM;
+
+	for (i = 0; i < nump; i++) {
+		u64 val, pre_addr;
+
+		val = readq_relaxed(cp_regs + 32 * i);
+		if (!(val & ECMDQ_CP_PRESET)) {
+			iounmap(cp_regs);
+			dev_err(smmu->dev, "ecmdq control page %u is memory mode\n", i);
+			return -EFAULT;
+		}
+
+		if (i && ((val & ECMDQ_CP_ADDR) != (pre_addr + ECMDQ_CP_RRESET_SIZE))) {
+			iounmap(cp_regs);
+			dev_err(smmu->dev, "ecmdq_cp memory region is not contiguous\n");
+			return -EFAULT;
+		}
+
+		pre_addr = val & ECMDQ_CP_ADDR;
+	}
+
+	addr = readl_relaxed(cp_regs) & ECMDQ_CP_ADDR;
+	iounmap(cp_regs);
+
+	cp_base = devm_ioremap(smmu->dev, smmu_dma_base + addr, ECMDQ_CP_RRESET_SIZE * nump);
+	if (!cp_base)
+		return -ENOMEM;
+
+	smmu->ecmdq = devm_alloc_percpu(smmu->dev, struct arm_smmu_ecmdq *);
+	if (!smmu->ecmdq)
+		return -ENOMEM;
+
+	ret = arm_smmu_ecmdq_layout(smmu);
+	if (ret)
+		return ret;
+
+	shift_increment = order_base_2(num_possible_cpus() / smmu->nr_ecmdq);
+
+	addr = 0;
+	for_each_possible_cpu(cpu) {
+		struct arm_smmu_ecmdq *ecmdq;
+		struct arm_smmu_queue *q;
+
+		ecmdq = *per_cpu_ptr(smmu->ecmdq, cpu);
+		ecmdq->base = cp_base + addr;
+
+		q = &ecmdq->cmdq.q;
+
+		q->llq.max_n_shift = ECMDQ_MAX_SZ_SHIFT + shift_increment;
+		ret = arm_smmu_init_one_queue(smmu, q, ecmdq->base, ARM_SMMU_ECMDQ_PROD,
+				ARM_SMMU_ECMDQ_CONS, CMDQ_ENT_DWORDS, "ecmdq");
+		if (ret)
+			return ret;
+
+		q->ecmdq_prod = ECMDQ_PROD_EN;
+		rwlock_init(&q->ecmdq_lock);
+
+		ret = arm_smmu_ecmdq_init(&ecmdq->cmdq);
+		if (ret) {
+			dev_err(smmu->dev, "ecmdq[%d] init failed\n", i);
+			return ret;
+		}
+
+		addr += gap;
+	}
+
+	return 0;
+}
+
 static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 {
 	u32 reg;
@@ -3547,6 +3742,9 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 		return -ENXIO;
 	}
 
+	if (reg & IDR1_ECMDQ)
+		smmu->features |= ARM_SMMU_FEAT_ECMDQ;
+
 	/* Queue sizes, capped to ensure natural alignment */
 	smmu->cmdq.q.llq.max_n_shift = min_t(u32, CMDQ_MAX_SZ_SHIFT,
 					     FIELD_GET(IDR1_CMDQS, reg));
@@ -3647,6 +3845,16 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 
 	dev_info(smmu->dev, "ias %lu-bit, oas %lu-bit (features 0x%08x)\n",
 		 smmu->ias, smmu->oas, smmu->features);
+
+	if (smmu->features & ARM_SMMU_FEAT_ECMDQ) {
+		int err;
+
+		err = arm_smmu_ecmdq_probe(smmu);
+		if (err) {
+			dev_err(smmu->dev, "suppress ecmdq feature, errno=%d\n", err);
+			smmu->ecmdq_enabled = 0;
+		}
+	}
 	return 0;
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 4cb136f07914e83..3f3a867a4626fcd 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -41,6 +41,7 @@
 #define IDR0_S2P			(1 << 0)
 
 #define ARM_SMMU_IDR1			0x4
+#define IDR1_ECMDQ			(1 << 31)
 #define IDR1_TABLES_PRESET		(1 << 30)
 #define IDR1_QUEUES_PRESET		(1 << 29)
 #define IDR1_REL			(1 << 28)
@@ -107,6 +108,7 @@
 #define ARM_SMMU_IRQ_CTRLACK		0x54
 
 #define ARM_SMMU_GERROR			0x60
+#define GERROR_CMDQP_ERR		(1 << 9)
 #define GERROR_SFM_ERR			(1 << 8)
 #define GERROR_MSI_GERROR_ABT_ERR	(1 << 7)
 #define GERROR_MSI_PRIQ_ABT_ERR		(1 << 6)
@@ -152,6 +154,26 @@
 #define ARM_SMMU_PRIQ_IRQ_CFG1		0xd8
 #define ARM_SMMU_PRIQ_IRQ_CFG2		0xdc
 
+#define ARM_SMMU_IDR6			0x190
+#define IDR6_LOG2NUMP			GENMASK(27, 24)
+#define IDR6_LOG2NUMQ			GENMASK(19, 16)
+#define IDR6_BA_DOORBELLS		GENMASK(9, 0)
+
+#define ARM_SMMU_ECMDQ_BASE		0x00
+#define ARM_SMMU_ECMDQ_PROD		0x08
+#define ARM_SMMU_ECMDQ_CONS		0x0c
+#define ECMDQ_MAX_SZ_SHIFT		8
+#define ECMDQ_PROD_EN			(1 << 31)
+#define ECMDQ_CONS_ENACK		(1 << 31)
+#define ECMDQ_CONS_ERR			(1 << 23)
+#define ECMDQ_PROD_ERRACK		(1 << 23)
+
+#define ARM_SMMU_ECMDQ_CP_BASE		0x4000
+#define ECMDQ_CP_ADDR			GENMASK_ULL(51, 12)
+#define ECMDQ_CP_CMDQGS			GENMASK_ULL(2, 1)
+#define ECMDQ_CP_PRESET			(1UL << 0)
+#define ECMDQ_CP_RRESET_SIZE		0x10000
+
 #define ARM_SMMU_REG_SZ			0xe00
 
 /* Common MSI config fields */
@@ -522,6 +544,8 @@ struct arm_smmu_ll_queue {
 struct arm_smmu_queue {
 	struct arm_smmu_ll_queue	llq;
 	int				irq; /* Wired interrupt */
+	u32				ecmdq_prod;
+	rwlock_t			ecmdq_lock;
 
 	__le64				*base;
 	dma_addr_t			base_dma;
@@ -547,6 +571,11 @@ struct arm_smmu_cmdq {
 	atomic_t			lock;
 };
 
+struct arm_smmu_ecmdq {
+	struct arm_smmu_cmdq		cmdq;
+	void __iomem			*base;
+};
+
 struct arm_smmu_cmdq_batch {
 	u64				cmds[CMDQ_BATCH_ENTRIES * CMDQ_ENT_DWORDS];
 	int				num;
@@ -640,6 +669,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_BTM		(1 << 16)
 #define ARM_SMMU_FEAT_SVA		(1 << 17)
 #define ARM_SMMU_FEAT_E2H		(1 << 18)
+#define ARM_SMMU_FEAT_ECMDQ		(1 << 19)
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
@@ -647,6 +677,12 @@ struct arm_smmu_device {
 #define ARM_SMMU_OPT_MSIPOLL		(1 << 2)
 	u32				options;
 
+	union {
+		u32			nr_ecmdq;
+		u32			ecmdq_enabled;
+	};
+	struct arm_smmu_ecmdq *__percpu	*ecmdq;
+
 	struct arm_smmu_cmdq		cmdq;
 	struct arm_smmu_evtq		evtq;
 	struct arm_smmu_priq		priq;
-- 
2.26.0.106.g9fadedd


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
