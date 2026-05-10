Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010029.outbound.protection.outlook.com [52.101.46.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D37833F8A2
	for <iommu@lists.linux.dev>; Sun, 10 May 2026 21:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778448212; cv=fail; b=tfBv0XX1mBxT6ClEVkByXMpzvVACyYvhSMJ+5hGt7sLHTWbXQny6WyHqMaqjIwvHlo+IzT76z+6uzMV/wNl1PLyqmkLLXa8PJAOd2BDW3qquh1mILUDrrN9wnatElli2Pi/eE7EncSqMLTIGqudcB3LmurhkuSTrdEHC7Xnb1QU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778448212; c=relaxed/simple;
	bh=rc7P+XgU9bbo/ZKTnrFz5VIQSVMFCI/JdE+HuVcvQPk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oVaEa51xreja/9f7RMeGwPpIAh+5Dt+DtpwjknXyT6Ic1tJq+fBLAuKJ87dUkGjSX/bqw5vGhniU9KJvLEznf1QG2x+7yb+E8TuFvMdqaq2uAD7W3EYoB+wWRWbsjftOKWn69F6fsRhcfeEuqzN/kv5UAE/g9LUF80cP7z187GQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Uh25NjGk; arc=fail smtp.client-ip=52.101.46.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Uh25NjGk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jkmxhvqSjpjEM1Ry5YXSRFFMZfnSqgFgbjXsnXgvCbhKT5zwBwXSS29YHzHtOiKgjFCjD281W2/HWlxZx+wkDo/Zw6TnsbazMJRoD1LVu4iltiBceYW0UgKICBh0MyAedmB6/c6+Zo5/UTIsRF5ZQi/EvIUNvWlpb3YBVnfcDMGp/+K3jxUej/jWZcuY9B53FYu+3fhZMSzzDK1eD9fznMd3e7WWFr7xskmy1sHolA16rGvWpF1qjQW9P0AO8DzmuW7PquT9E7J+/dOrBLFYfcmGVAEzY4kIGZwnpxPIXFGIBKjGT0pb6aPxhUurfA/ir2C2d83yepAozImG2vcXiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCacEnv3jFgTu+llFs1ktz1QQR/9JDZVdeP3XUil9go=;
 b=Vc0aM9azAw9/WRfGUNdgDiPs5RM0aHJp6tmquo2Lngs6bymz70/WHvArxfjiEGR5jKynvA6eAhBk7vySNBKWz/vMAD/VBiD6c1chMvsSUNYGhBhpE3CR3BeBG8MatYmFiiEeGwJk5L7MeuagEa6OOFjLi23DJK/ouBabzFQQlzsK7OsImlIOO/cc1P7xdfI8GhbD+fFwNic4qFwRwmhUnhs2FaGTg2yvwXZSAD/K8fRlyz/7HKOmsRCC7CQknssq6WTp+kO6lOawyRQfpn7r7bVb9GS10vk+Td7UNwqL68rWDS+81KqJBE7eQ0b15qwW8R3WU5OJhnJAGDFmsCs1/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCacEnv3jFgTu+llFs1ktz1QQR/9JDZVdeP3XUil9go=;
 b=Uh25NjGk9tEzGkoYeJRW6BS5e4Rkbo2Yd9UfyPFyDamfrNoBbNGdq7k96LZYqME8USyVkfp3MLUkzpr2IuYOBhZ13HKwYnFRFHKD0fTgMlnDMxqjvKp/rSdOyW+hsP5SeH4TWw4z+gnz3X1e4GAXyjh39/6IYVSt343gxsAWBefp17D8TMSvvcyj7sm/D0LMqtpTLzoQzTUTC9ozwu924A2B4KRZBQuhQqrpWTnVE9ZGYAU6ZOTYjyWi/fyss5SGVzbhYCcw3d9EcuMP8PQuI6CG0fBXRpYCkIKj972fnEfB0N/VG9sg+Lro4D2a3RxTOqSqhAWJlbhxvhVgoNUMsQ==
Received: from BYAPR02CA0062.namprd02.prod.outlook.com (2603:10b6:a03:54::39)
 by LV8PR12MB9617.namprd12.prod.outlook.com (2603:10b6:408:2a0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Sun, 10 May
 2026 21:23:26 +0000
Received: from CO1PEPF00012E60.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::5a) by BYAPR02CA0062.outlook.office365.com
 (2603:10b6:a03:54::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.22 via Frontend Transport; Sun,
 10 May 2026 21:23:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF00012E60.mail.protection.outlook.com (10.167.249.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Sun, 10 May 2026 21:23:26 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 10 May
 2026 14:23:15 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 10 May 2026 14:23:15 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 10 May 2026 14:23:14 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kees@kernel.org>,
	<baolu.lu@linux.intel.com>, <miko.lenczewski@arm.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH v5 4/6] iommu/arm-smmu-v3: Skip EVTQ/PRIQ setup in kdump kernel
Date: Sun, 10 May 2026 14:23:03 -0700
Message-ID: <8de5639630e5723d6f371093cef93733f0ca534d.1778416609.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1778416609.git.nicolinc@nvidia.com>
References: <cover.1778416609.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E60:EE_|LV8PR12MB9617:EE_
X-MS-Office365-Filtering-Correlation-Id: 27c9f1f1-bd69-4567-01a7-08deaeda5f82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700016|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	bTEc642wjMn05CM4a748muOUGFxuYR/dP85welu+3RhzmuDetiYtM83Vgd4DwMHOKbpTQ3Y49qjBMJZB1yuwE+WIpMKVjYDr2aQTvnNXq/7SXfujf1srB8vnMAPUo7VPvzABzWqrT9RZ5dF07SPGhj105dXXGbfXSPqHwFg6SCuO9qKQCfU3whK0ZufB51yWUMLHrLot1qAPiNjVthURiqFw/iYYuDySzfsAXEDzb9j8J9oVLHXp0uvkqIdXHy3veZZ4htXcEM3eEvK1PWyQjfHhl28iMbQ67ae6vBNF7PbHvd21HPx9h2pkfG4zLAf1PovzelCyfNVTIIiufi8awFeGmxltX55HlI4F0wPnu1t6KJrLUrZAX3bv626M/RIvGN+ibf5/Dm6nneLeFJQcYCy5qKkdVUjdyR53hHRfslGJMZ2Z8CJc1eSnC2o2+ITnUKr+LaVpWFhVgMN1UWoOi3tiF7QEZ8IymcIq0xLDDRLK6HrB8E5imo75YfQBJtlSJUK3EDHCNzAKZ1jAzxktWLOCBnZFMjmIhG7kszy97knuXc3fvGn64UQ/WeaKTBfZdIsROcoYXeTwFrp6aTwxjjp08g6RftXewjuw2TIpVqjxPLalHt3oxrWumLygH3eaR3UvbENPqMpTSWnKpgtrOJ5JfWqZJWqKmkridl/mkjLEgTq6BYM2q3ZllSY/rJgJzz+Ju+ZCIO4UPMTx5zHctiT58Slg86b902Z6LjEdaAc=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700016)(82310400026)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Bt0berCGqy9QKPtNqHbM/O1PM5xrhjV6Kk0trO5gRb50SY18rqBg4D9d87kUrCQtQcHod1E4oVRE5nHL/uiqHTCbdYdqbMTxmMADWV9W8lI0/SNZBV9hKuueJ3qcrMethjq9A8TA23M9eIIUfKu+ZbP36tEDiLYbb4B8kYuC/CULyWpeNRXMrQUXonCkPrreUY+Oz/T6IH+eTKyfTeRWCny7fiDQlO7Az4DDPXCPT3koM01byaDn1NvnpUasir0GOACXSCJhR/T7uL/CfWMrbJkcIFzTnFebeb+yjm5XfKR9yitpC7B1oGCgkcYsfXHR8kJ1BuRoTtDxsB4DO4CnCUcEyLjkNrsahQJB1kJK5f5KKDx4EsBTBBKiMMzihHzCerBru31HGbgFLUINmhqe2jvmTdPvR19fKwC/KC2ydTZT2ljg+8gy1GYhmsDWoeOg
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 21:23:26.0581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27c9f1f1-bd69-4567-01a7-08deaeda5f82
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9617

In kdump cases, the crashed kernel's CDs and page tables can be corrupted,
which could trigger event spamming. Also, we cannot serve page requests.

Skip the EVTQ/PRIQ setup entirely rather than enabling then disabling them.

Also add some inline comments explaining that.

Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel")
Cc: stable@vger.kernel.org # v6.12+
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 43 +++++++++++++--------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index ebb0826d74541..b7298218bac9a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5211,21 +5211,35 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	cmd.opcode = CMDQ_OP_TLBI_NSNH_ALL;
 	arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
 
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
+	 * tables might be corrupted, triggering event spamming.
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
@@ -5258,9 +5272,6 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
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

