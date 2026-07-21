Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011006.outbound.protection.outlook.com [52.101.52.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7033471408
	for <iommu@lists.linux.dev>; Tue, 21 Jul 2026 19:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784663352; cv=fail; b=CJ8e0+9RaQ1Iq6V4H28LvrPEgGODciwTM/IMA1irkLL+4mEugp09+VzhzGLGrz1CDcbHiJ7tKg8JhrTCxI9HwmHM8sGjW3mRgzWjpdbQ38Q6IoMg3FNLA96O3lohGlkQ+AerAZDo4aBkSTVTfOhhYb3dspjCMCf+7Ff6FgJuZJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784663352; c=relaxed/simple;
	bh=K1oIJ5Mx4IfqRYlIZ6B4RuIkUxsl4HPT5t3Cck0Gs78=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u4x/L9nOhGu+kXGGOWHCpQVkBjsDrOpmVmQhm95dqJqIvnIluiWnNzmUeCzbb/Km/MYTd3tkoo1DDrCO0XeQES59xV1pJrCfuguu9AojhVZmUebWoGgRHk+NcV/X+W9GUJ6NlGTW0Wx95if/kWRXjnlAG5gAE3lwT3vBq/qbVYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j//NfzlV; arc=fail smtp.client-ip=52.101.52.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j//NfzlV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ww8EsJkXm4+8RHjvPfQJsZMqeZhT6wx8daq987JmO9g7TyvJeaXuFx5Y2qY5JzZOLwqTFkrJLsTk48g+O2x0WfIQksUQumhymZSJflavGgx6eu4OSH4alX8beL0RZ2vJV5p/gI1OXUwu5AhlAK1nbMne1mbEJTr7d3PFQDBmXFeSvTEVEEVRqCIspWjHMZXjBtYazDC1ztkyS6CMk7Et1FVBvQQVQbj45r2KbqfnPw17MojP5ejxMemMEZ+OjncuxGxgv07f23NIwb1+Pb8nyapvRxhaNWFiVWjFs0ek7DNHklogjTdBtZ324DZUzEgqFC9DGV9a+CpH3Sm4loHnlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzhcPOb0pIG0W5MZPxOMrEW/3mazbjsS9PybLOI1rVQ=;
 b=Vo+02QW2DOF815YAsZvL0RkZhpIKsL5he7AYFqhBRU7kAD4J3s5TzX37ZBSP8K00Glj7TgMNO04Tq3/Z65sqJQKgYMvY2u+madHLtsecX8HG4v5keFtdmupG9m576ceoF6aW9aXpBNAunynKLQySxOR0MzQavROHA2z+CnT7vyBNuSklPYLFze16PYRVE9gr8sJRt8DM737F0qc74pSHDS48eAMcEc5rzGPlvqBf8m+CM7QX23ffli+co1FkQq2xl3Dfr1IoFp9qRFwuzSrF8KztWksCirK/rp1ouxtIZAIVpW1Bw1HTx0mlA3elKhVyPEP1ZqoC3iumD78+RACilQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzhcPOb0pIG0W5MZPxOMrEW/3mazbjsS9PybLOI1rVQ=;
 b=j//NfzlV0zxFeg1ex9Ewnv5/TBEQGiU+lT94R2rjF9Wg66vmbQ4m2y5ULcpZtjpIaJBouUWqVQrUPy6bqUHkkZ/uF32El+DJG0f2vzi9ScJ8GmAHxiOLXcyVij9eoYon2nge35ffrm3b1mQxUQ2OTrzvHfyqL2xome+N+lxOmvsZAHBBLSTaCEf7OwC4x9+YJknF83iH+Hq4ku8GIMH/xqrFdV/20DClwMklq2dsIlVY5rilRmHP1e70g7T520ZtQ+eS6BYgtxk0+A7L5MCRhDxQtQYpqnBZQf35CuI+PWFSx3BGmsanWue3CtoTSBgrv5okUFGkCU3d+4Y/VXxhJg==
Received: from MW4PR03CA0028.namprd03.prod.outlook.com (2603:10b6:303:8f::33)
 by DS7PR12MB6120.namprd12.prod.outlook.com (2603:10b6:8:98::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.18; Tue, 21 Jul 2026 19:48:59 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:303:8f:cafe::af) by MW4PR03CA0028.outlook.office365.com
 (2603:10b6:303:8f::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 19:48:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.0 via Frontend Transport; Tue, 21 Jul 2026 19:48:58 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 21 Jul
 2026 12:48:37 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Jul
 2026 12:48:36 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 21 Jul 2026 12:48:36 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH v9 02/12] iommu/arm-smmu-v3: Skip EVTQ/PRIQ setup in kdump kernel
Date: Tue, 21 Jul 2026 12:48:11 -0700
Message-ID: <c59f44f2b6982e3e8bd4013395f895cccf9f4a53.1784663184.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1784663183.git.nicolinc@nvidia.com>
References: <cover.1784663183.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|DS7PR12MB6120:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b8c2a53-612d-4bd7-30d1-08dee7611b5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|56012099006|11063799006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	5iUDSUQY0gU6K5JLowL1CqK1l+UYdfZvAg4RdoI4CfaYY1TtAQhep4VysKkBEQGquICVB3SC9GpL2BAU9ycVx/o0GX8pef55TpNdYFP1Fj9lsrA5PCf0dD9eUhwTCyqMCMALqHt1/zd22ySQnwiYDZeoYZDM7e5qbV95HGSxHTnmj7amLvUlGmeGTvIPaYrIvAHX4CB2xeIdXFrMhHSZVHD/V3QVaq+KXvaFAUbbdsZVSrxusv/iK2m4yqaqfWrwYV9BkP68civ2ceUJuazpLfMNai1mmZiLTNbdXMJ7JZ3m4Hpra2tgq91AYg/V7pCsY5VeB9txOQrDDV9tUERNebPxCNIr07sVheHw4JleaUR3qKPa8DCQkt/JzFMV074sSxNfXLVkSTTey4LukK0sXYoYy47SUL1xu3TcMxvus6Eo33CvQYU1qdJFjMiovtNg4A0OGp+2Rjf/2kVbODwHcQiafl6n9bQN9DqofhM6RSPtVdB4mzDblKc7uX1iDJa26GUpWyMY62vlBBUVRYbXo7GOS/m9OIlyROlpSk4EUlacguu6CsvFVJdQz/JrqiJTLtdHvhEhtf0cFE2cir8fOBCey6YndhH6Q9koet+wV1l9XkRNDwNBf4r+szowpvmU6U2QS2mXqk6nfgQMtB2F7Bfn3/88mRGORPGPpBRC926VdUq7WcmCsWu0z7RnEwbjzIc/UX3mZI4sCIXyqGrVtw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	m2yQ5P8FsOdq0DfKNFpy7jnshBsvIfBfidfxwskd3AEefA7NfSYyvPAWoy3xOxth+vZurRRyM5myIaJvCOg27xmrb7DsEhYaGPGOxy1Fjinivl2eoINK4OG5xeUeqaqQX9x2ZUTmPrCjgPROEh+Xm7J1ufheQf40rO8IxedowN3/GmSXbXZ0vAyMipvkwCPtrR5j8IvWg0AIgMuPoOPOs2FQ/qmgUIstbaKlNThkEStgFLFhc0ZTeZnahQVTcbcrEdchoIIbpTWTvHR/L38GMRQkM5O5hDBnQDtC2znLGBKlXdpMrfiJnhv+bmFrfV8yF1Ubsv9reBfPU1c3wL5sFibPqIDpGoyyWtve9c3c813vQQv6JCIGAC/VnMcBtdNy4JMM00rADPPzMxYqAI6Q/58Cz36LFsAyWX9mnjWJRZOOzS7yE7kmv7p3ulCYBS+z
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 19:48:58.8569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b8c2a53-612d-4bd7-30d1-08dee7611b5a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6120

In kdump cases, the crashed kernel's CDs and page tables can be corrupted,
which could trigger event spamming. Also, we cannot serve page requests.

Skip the EVTQ/PRIQ setup entirely rather than enabling then disabling them.

Keep the queue allocations themselves, as their Q_MAX_SZ_SHIFT-capped sizes
are negligible against a crashkernel reservation.

Also add some inline comments explaining that.

Suggested-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 44 +++++++++++++--------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 404790d2c7210..132bee5fbb1d1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4821,21 +4821,36 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	arm_smmu_cmdq_issue_cmd_with_sync(
 		smmu, arm_smmu_make_cmd_op(CMDQ_OP_TLBI_NSNH_ALL));
 
-	/* Event queue */
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
+	/*
+	 * Event queue
+	 *
+	 * Do not enable in a kdump case, as the crashed kernel's CDs and page
+	 * tables may be corrupted, triggering event spamming. A disabled queue
+	 * simply discards new events, without raising any global error.
+	 */
+	if (!is_kdump_kernel()) {
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
 
-	/* PRI queue */
-	if (smmu->features & ARM_SMMU_FEAT_PRI) {
+	/*
+	 * PRI queue
+	 *
+	 * Do not enable in a kdump case, as we cannot serve page requests.
+	 */
+	if (!is_kdump_kernel() && (smmu->features & ARM_SMMU_FEAT_PRI)) {
 		writeq_relaxed(smmu->priq.q.q_base,
 			       smmu->base + ARM_SMMU_PRIQ_BASE);
 		writel_relaxed(smmu->priq.q.llq.prod,
@@ -4868,9 +4883,6 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 		return ret;
 	}
 
-	if (is_kdump_kernel())
-		enables &= ~(CR0_EVTQEN | CR0_PRIQEN);
-
 	/* Enable the SMMU interface */
 	enables |= CR0_SMMUEN;
 	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
-- 
2.43.0

