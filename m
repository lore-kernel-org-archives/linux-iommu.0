Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012052.outbound.protection.outlook.com [40.107.200.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF024D956C
	for <iommu@lists.linux.dev>; Mon,  5 Oct 2026 19:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791228703; cv=fail; b=eSZv0LNus5mddvAdV1/55P1JNKL2yGmtbhIXK9RSY5HUJiBE3Bvl28N3aMdYkeQNvMhBHtOL+/lweWVL8cKqYDW3OYinJ6yTc/MlpgfcxqyEHYIu+SAKNh7pyrs3prmkHfIpK4uSUGJY6S+H+GBQdZeXijCDRHcaWrnPLKe0/+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791228703; c=relaxed/simple;
	bh=IB4d9H+h9NIev9Xo3kdZd8jK/QivKc/yIejdX9MtIzg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cRj+GL0d8bl/2JdoHoSL/knRkfyOpRT4HcahPOdjgoWRo1OdX6gBW1HZeFaemGB5ncc4iLelS8iIzBowc1k3klT4h1gUeJ4UNr+xhrNJGo4nu9sFpNBUC908hrI17Meb1NS1aOohrJLw8KFu+CoA24kAKnwJK4eR4wZP8tYkYE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WRYijT6A; arc=fail smtp.client-ip=40.107.200.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WRYijT6A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RnMlLgacbLXp9UYscuwvKyu6ExuEl5F6IEVA3iEHrQyebXomTjZMKJrR7AI9lFimw2s0BApRY3jbEB7+sZ3s6HHuWi3JLjKpNBkuzLlQTc/B08yizq0qdBGLSWZOISJO7n+B9db3hk9fsoAyTtjCVZgRR7mTqtdfb5jLDFF37jFp1pnyWR78b8OhFhsvLuIj8/L8atVyeePasf+maOqONFK8V0PhfD1pXkoD21FsuIUQWKOxTEjvSQBNtmlEyr8p3Fn/FjzV7xR8odtS7xpFPGXCdTEVl3CAB+IzHTPKtIlwjZ+xt83Ph+Cj13YSftY3P2ZcCDA61+yMovu4wTgB+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfgAtP6TczgKcSSbfDwRAWDiIfr1mBbSN1U6QjPteVs=;
 b=Cz1HMbFMgVHaZWqeCoZshBvYHBKCqKt5CMTMoRwnIfjKGc/zDPgHvRWk8gEZhGXkTFh91RsToU8D5hentL5O0PMQqmAbl+D1CyTobOnFAGhROAvwVkdNOkTeN951/9AFrgrV2/a+xc5XglBtb+VJkSIvaMhvD9oRO/D/itzAGi/cqCWGW6H1dMOwzfHcpOVMLX0kFqwyjpyVlszY9keOmmfFAIRNjKi1A5MzS5rE/HFDPLtWrEV72FhI/efWm5s/hvviLtgr75Lr6T9uUF3bHq0uXRkcCq+b6DCAcddKgkf+h5R7+CNtb0/WbDaihTeXMemrqS03pqsvtEqpiqIzhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfgAtP6TczgKcSSbfDwRAWDiIfr1mBbSN1U6QjPteVs=;
 b=WRYijT6Ab/PvH3AB05khQDBtqXc+d5vP2FN0evTEXuIgAkLpKjKHCdJD91jgoksfYzT0JLkGQq6HRv+FmohEfVnrNh/maoyyx/tdMD3j+4Lp8wglTnQCyRuK1BGOuXo5Khs3/v6qbP6JG1OXvmBuYkoHCO8eRpHfGMX1GmoVXtOiSJ50u/iR1regnuDdgbo4q1XzAufZI4frI0vvLVrmadJdJMQP9n7CElIBKZGptb8WBXCJxNYfbfX8qf2A5MV9tAGkmYTJNOpMdoeoPc1Zm6qqKgIhjbCH49LyvFG4wQJ2+3m1K+svx9ppcLetBmUjzq0McfntBL0hgKYcAVrnEg==
Received: from BLAPR05CA0005.namprd05.prod.outlook.com (2603:10b6:208:36e::14)
 by MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 19:31:36 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:208:36e:cafe::a7) by BLAPR05CA0005.outlook.office365.com
 (2603:10b6:208:36e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 5
 Oct 2026 19:31:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Mon, 5 Oct 2026 19:31:34 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 12:31:04 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 12:31:03 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 5 Oct 2026 12:31:03 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<praan@google.com>, <kevin.tian@intel.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <jamien@nvidia.com>, <kas@kernel.org>,
	Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>
Subject: [PATCH v11 04/11] iommu/arm-smmu-v3: Add ARM_SMMU_FEAT_EVTQ for the event queue
Date: Mon, 5 Oct 2026 12:30:47 -0700
Message-ID: <250a57bbdd232bbb1e3511b7768a1c9ae3d204e6.1791226953.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791226953.git.nicolinc@nvidia.com>
References: <cover.1791226953.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|MW4PR12MB6873:EE_
X-MS-Office365-Filtering-Correlation-Id: 80399533-cab1-4d01-673b-08df231744b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|36860700016|1800799024|82310400026|10067099003|56012099006|5023799004|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	gmi+dGMwRnU4ioISKaaCBkYghvbSoLAIA5WaFiiNwEizVVw5CZS1zmMT7QNOEWLoEiED87/kUpgG3oUJdikGMH+sBExzLGKs7HLo0HW4+R+TtBliR89c5yAgVeGk0u1X2rUC5sNB7OnISoIjW3kzy9eJPNpszOsRk7LJS8eSx4UszbunnhaVscq/MCqm4e4QGGaqNWd8jF/hy7WhMDc2TRCqol4Oof1TBBo1oWx/H04vd5PdJrZKQLOGjWHvUviWAiqOlkXdNmvCbpojsfAQuqRBwcdGvGUm18h/QresfSRwMGQeQzPDUI32A+ubT4Ofw7UNyBwL+sMWyBktWhGsv7QJcpL3r8dzGSmm3rvmqHD7nSU+K145nYZTfUORV6KUWvUK+t8tlcY2hJNdcb7si/smxeGnfyymQPTQtbGExpuUR9C2wxokeQMRxLJeB+s7cdLIPeU+ER2R1vXYxbgBsHqKeulMy4x/ZL6Jx4G3FlyTJcEGL2zJS3TpTl1o7QXr16RZkq38oz09fQl0MaLscjnS2e2x+of9aKMVTHyplQfYK+WH4u5UlBpXDqiQUXtRxDPbhV+0UH5v5ZeJhOoNEqTrlZ6ER7YHVgknOCwQjAXnNDjps3PvYYgezJc58OmZKNDcgRU4F/aU5WW3zJK1IivxHn3CH6LQwrMXNWgzPLk3MrwcqpPXrBvm59nS1S4rh4bVv6K5pEg941kfwnJBcw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(36860700016)(1800799024)(82310400026)(10067099003)(56012099006)(5023799004)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZG7JeeoIFigPrOS/oYSOOSmbS/Wz0gEeCQYA3jf9nGcZt3qrJn5vQNUf9ioAq/0GUm9BsjEBQ64D77aTd9JDSaiomAkwyQGMUCVe+BUHj1OQQR2iIy/vLR2HPNGGG5cAvWbZR/eWZ3Qp+poHVMewuV9TV61aujvRelkIQFhaOkDMFxFbSwiyA2bNmJ6HmDeCnxttpUcHjK3YNGVL8oUbXzrfcERGz3Ll/Uo8W0dRXSUfzkdElZVzW6l8LT9l0uiKtRhJnvF2ZvBklt41++uOjZQ2ItzJFmJvVxCrBVp2W9DO9Unt/3oztmX0csiMz9qzEZdId+JIgBOXFu4buCcuo+5dU+SSk+wAf6EV8zRg3o8fbKK7FkESOBqw9dzJ3jBZ7ZB5VKTsYILzVi5KDaWT7Ixfy0zhGtAUk3318wFxea+jgqlcXJ2lJ2doHe2fjfqx
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 19:31:34.9935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80399533-cab1-4d01-673b-08df231744b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6873

The driver programs and enables the event queue unconditionally, while the
PRI queue has an ARM_SMMU_FEAT_PRI gating each of its touch points. Yet a
kdump kernel wants to leave both of the queues alone, which would take an
is_kdump_kernel() test at every one of those places.

Add an ARM_SMMU_FEAT_EVTQ that the probe always sets, as the event queue is
architecturally mandatory, and gate the queue's allocation, its interrupt,
its MSI vector, and its CR0 and IRQ_CTRL enables on it. A subsequent change
will turn the queue off in a single place.

No functional change intended.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Suggested-by: Robin Murphy <robin.murphy@arm.com>
Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Tested-by: Breno Leitao <leitao@kernel.org>
Tested-by: Cristian Prundeanu <cpru@amazon.com>
Assisted-by: LLM
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 89 ++++++++++++++-------
 2 files changed, 61 insertions(+), 29 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 8f2c0b1cc4a8d..559bfa8cbc5e0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -972,6 +972,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_BBML2		(1 << 24)
 #define ARM_SMMU_FEAT_HAFT		(1 << 25)
 #define ARM_SMMU_FEAT_DS		(1 << 26)
+#define ARM_SMMU_FEAT_EVTQ		(1 << 27)
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 6ff61565f7583..756825e004774 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2381,7 +2381,8 @@ static irqreturn_t arm_smmu_combined_irq_thread(int irq, void *dev)
 {
 	struct arm_smmu_device *smmu = dev;
 
-	arm_smmu_evtq_thread(irq, dev);
+	if (smmu->features & ARM_SMMU_FEAT_EVTQ)
+		arm_smmu_evtq_thread(irq, dev);
 	if (smmu->features & ARM_SMMU_FEAT_PRI)
 		arm_smmu_priq_thread(irq, dev);
 
@@ -2390,7 +2391,12 @@ static irqreturn_t arm_smmu_combined_irq_thread(int irq, void *dev)
 
 static irqreturn_t arm_smmu_combined_irq_handler(int irq, void *dev)
 {
-	arm_smmu_gerror_handler(irq, dev);
+	struct arm_smmu_device *smmu = dev;
+	irqreturn_t ret = arm_smmu_gerror_handler(irq, dev);
+
+	/* Without either queue, the thread would have nothing to drain */
+	if (!(smmu->features & (ARM_SMMU_FEAT_EVTQ | ARM_SMMU_FEAT_PRI)))
+		return ret;
 	return IRQ_WAKE_THREAD;
 }
 
@@ -4763,11 +4769,14 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 		return ret;
 
 	/* evtq */
-	ret = arm_smmu_init_one_queue(smmu, &smmu->evtq.q, smmu->page1,
-				      ARM_SMMU_EVTQ_PROD, ARM_SMMU_EVTQ_CONS,
-				      EVTQ_ENT_DWORDS, "evtq");
-	if (ret)
-		return ret;
+	if (smmu->features & ARM_SMMU_FEAT_EVTQ) {
+		ret = arm_smmu_init_one_queue(smmu, &smmu->evtq.q, smmu->page1,
+					      ARM_SMMU_EVTQ_PROD,
+					      ARM_SMMU_EVTQ_CONS,
+					      EVTQ_ENT_DWORDS, "evtq");
+		if (ret)
+			return ret;
+	}
 
 	if ((smmu->features & ARM_SMMU_FEAT_SVA) &&
 	    (smmu->features & ARM_SMMU_FEAT_STALLS)) {
@@ -4950,7 +4959,15 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
 
 	/* Clear the MSI address regs */
 	writeq_relaxed(0, smmu->base + ARM_SMMU_GERROR_IRQ_CFG0);
-	writeq_relaxed(0, smmu->base + ARM_SMMU_EVTQ_IRQ_CFG0);
+
+	/* PRIQ's vector needs EVTQ's to be kept */
+	WARN_ON_ONCE(!(smmu->features & ARM_SMMU_FEAT_EVTQ) &&
+		     (smmu->features & ARM_SMMU_FEAT_PRI));
+
+	if (smmu->features & ARM_SMMU_FEAT_EVTQ)
+		writeq_relaxed(0, smmu->base + ARM_SMMU_EVTQ_IRQ_CFG0);
+	else
+		nvec--;
 
 	if (smmu->features & ARM_SMMU_FEAT_PRI)
 		writeq_relaxed(0, smmu->base + ARM_SMMU_PRIQ_IRQ_CFG0);
@@ -4987,16 +5004,20 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
 	arm_smmu_setup_msis(smmu);
 
 	/* Request interrupt lines */
-	irq = smmu->evtq.q.irq;
-	if (irq) {
-		ret = devm_request_threaded_irq(smmu->dev, irq, NULL,
-						arm_smmu_evtq_thread,
-						IRQF_ONESHOT,
-						"arm-smmu-v3-evtq", smmu);
-		if (ret < 0)
-			dev_warn(smmu->dev, "failed to enable evtq irq\n");
-	} else {
-		dev_warn(smmu->dev, "no evtq irq - events will not be reported!\n");
+	if (smmu->features & ARM_SMMU_FEAT_EVTQ) {
+		irq = smmu->evtq.q.irq;
+		if (irq) {
+			ret = devm_request_threaded_irq(smmu->dev, irq, NULL,
+							arm_smmu_evtq_thread,
+							IRQF_ONESHOT,
+							"arm-smmu-v3-evtq", smmu);
+			if (ret < 0)
+				dev_warn(smmu->dev,
+					 "failed to enable evtq irq\n");
+		} else {
+			dev_warn(smmu->dev,
+				 "no evtq irq - events will not be reported!\n");
+		}
 	}
 
 	irq = smmu->gerr_irq;
@@ -5029,7 +5050,7 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
 static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 {
 	int ret, irq;
-	u32 irqen_flags = IRQ_CTRL_EVTQ_IRQEN | IRQ_CTRL_GERROR_IRQEN;
+	u32 irqen_flags = IRQ_CTRL_GERROR_IRQEN;
 
 	/* Disable IRQs first */
 	ret = arm_smmu_write_reg_sync(smmu, 0, ARM_SMMU_IRQ_CTRL,
@@ -5055,6 +5076,8 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 	} else
 		arm_smmu_setup_unique_irqs(smmu);
 
+	if (smmu->features & ARM_SMMU_FEAT_EVTQ)
+		irqen_flags |= IRQ_CTRL_EVTQ_IRQEN;
 	if (smmu->features & ARM_SMMU_FEAT_PRI)
 		irqen_flags |= IRQ_CTRL_PRIQ_IRQEN;
 
@@ -5173,16 +5196,21 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 		smmu, arm_smmu_make_cmd_op(CMDQ_OP_TLBI_NSNH_ALL));
 
 	/* Event queue */
-	writeq_relaxed(smmu->evtq.q.q_base, smmu->base + ARM_SMMU_EVTQ_BASE);
-	writel_relaxed(smmu->evtq.q.llq.prod, smmu->page1 + ARM_SMMU_EVTQ_PROD);
-	writel_relaxed(smmu->evtq.q.llq.cons, smmu->page1 + ARM_SMMU_EVTQ_CONS);
-
-	enables |= CR0_EVTQEN;
-	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
-				      ARM_SMMU_CR0ACK);
-	if (ret) {
-		dev_err(smmu->dev, "failed to enable event queue\n");
-		return ret;
+	if (smmu->features & ARM_SMMU_FEAT_EVTQ) {
+		writeq_relaxed(smmu->evtq.q.q_base,
+			       smmu->base + ARM_SMMU_EVTQ_BASE);
+		writel_relaxed(smmu->evtq.q.llq.prod,
+			       smmu->page1 + ARM_SMMU_EVTQ_PROD);
+		writel_relaxed(smmu->evtq.q.llq.cons,
+			       smmu->page1 + ARM_SMMU_EVTQ_CONS);
+
+		enables |= CR0_EVTQEN;
+		ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
+					      ARM_SMMU_CR0ACK);
+		if (ret) {
+			dev_err(smmu->dev, "failed to enable event queue\n");
+			return ret;
+		}
 	}
 
 	/* PRI queue */
@@ -5330,6 +5358,9 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 	u32 reg;
 	bool coherent = smmu->features & ARM_SMMU_FEAT_COHERENCY;
 
+	/* The event queue is architecturally mandatory, unlike the PRI queue */
+	smmu->features |= ARM_SMMU_FEAT_EVTQ;
+
 	/* IDR0 */
 	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR0);
 
-- 
2.43.0

