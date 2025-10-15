Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011034.outbound.protection.outlook.com [40.93.194.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F9C30C63B
	for <iommu@lists.linux.dev>; Wed, 15 Oct 2025 19:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760557412; cv=fail; b=Zw8gf3306tmUjDhGTr7bsbCgLq16oe1LmKMzvrHdsYYPg4X7x71jeSyUWAaqlxyox4AR/GmzVXdodZS9IgLwBH+6Jnfdr529TQN7OzFga8ZNh+QAmOi9Fqu8ODH7AtY171VpRSqkJ9yoOrguzwt4Zq0OXjvW99o2yclXTqYOFeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760557412; c=relaxed/simple;
	bh=JDuf1bmurJWeoOAmlXZPCa/gVvFm9iP+3zRdVnzI5Jk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aQDb6xwim7n//1ilRioxXfVpHacq7qcQNxuy0L0BCc04bGX6pDL+p1BzHWzkK5edSOtB4VRY1BIzPakbqd1SyAsJ6BUDEwhsrMPAEeJp8cir3Y/uiddxe+Kr+jxxI86Qm662PKzyj1h4CoFITiGHgdTOiIsvZLmG+6a/e6mVoVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JFLun4bb; arc=fail smtp.client-ip=40.93.194.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JFLun4bb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wYwh6/H1pqf6BKLI/HD8E43l+jQZe9w2oq93KQFSMmokxYVKkKcV1RvxGe2WKo8FSltUciUP6Zr03LFPpDYwGMGd8K6tj18000OxGZsfc1OPkEN9GG79QzlQmnh5H25m4oSOt+VoQB9FcJsSQBP1xUoa+TZZrB9eCd9OultJM0ZieMQ6zuZKxrlxd9x+fMSXwZR/MKIJgKDewU063aF1AMFtGk22fFmIUKxtmiQQl9oQgSNDrpscSvuSud/71kB0qn6QjCa5HJGO3pzr09XOSQWRO8PWFtten9Wb32WHu/TyQbIe/aOlvCgvUKRyD3/+cmi3tTQbJRHO/fPaQNSePQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQPZ2Ncg+4MgV6Jh+y+9hHIgmnmqRb5QXVJPdVm6DCs=;
 b=fHbkqSV9Bq63AbGo6nHCC6frQS0iFWvUqI6L+S6aralDEhsfJwV3H8JcawQuft7S63mTygzgl9PxDWSVcPs/HKak1biHtPpU/RDi0AtyzsWs8L3jKtG87mDaD7vdqro0g/Rt0CfPbY3290hFfl/jVg1t06pahnpg4caXdtgH9yDFlKNf21PIPsOKDq8GP+rlESFy8buGcNh2H5coRPOcyQG99TjwmshI9MJ/ER38zAywHdE9ah93topmxk9ph2AeGxSC6wfpALpReZJmDq9FGo+2g9eClB/0vP+UopGLov6uhng6fB0V/nqhURPc/HarlWp7WSs/vKWYKscuEc8zow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQPZ2Ncg+4MgV6Jh+y+9hHIgmnmqRb5QXVJPdVm6DCs=;
 b=JFLun4bbcbDIURtqtRmslh/yuWvdGGVbUoKLrlB9oraZz+tdLKZJ7Fvb9SepM14w8RCGv2rKEj6vX9lkptWt6WQQwy25n8Q8TubZGmliZsJ3yjqGGLCwLrybXt2HexkhyTZnaGBNMGMcwywC09hfJWTzZaQ45q3+7gXbzUEqqxhgkxlpYD2hEUuj5a/OzAR6RQvqP2dmC0KiCckB8xJAJtrX1PnzmryXwUOk/INUiqUNhx8oR18CWs9snizcV8+snrJ68fkaeF8Zdo41xsBk1UUL/cHCg+p/lwyqY2b4351q7HsiKZvco4/C1+GMCa5xMF8Jt7R3yrSQyz5VUx52dg==
Received: from CH0P223CA0026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::27)
 by IA0PR12MB7750.namprd12.prod.outlook.com (2603:10b6:208:431::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 19:43:25 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:116:cafe::8f) by CH0P223CA0026.outlook.office365.com
 (2603:10b6:610:116::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.11 via Frontend Transport; Wed,
 15 Oct 2025 19:43:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Wed, 15 Oct 2025 19:43:25 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Wed, 15 Oct
 2025 12:43:08 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Oct
 2025 12:43:08 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Oct 2025 12:43:07 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <jgg@nvidia.com>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<balbirs@nvidia.com>, <miko.lenczewski@arm.com>, <peterz@infradead.org>,
	<kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 6/7] iommu/arm-smmu-v3: Add arm_smmu_invs based arm_smmu_domain_inv_range()
Date: Wed, 15 Oct 2025 12:42:51 -0700
Message-ID: <e2fdd2ac36d1b9379d8844401317387c954e2fbf.1760555863.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1760555863.git.nicolinc@nvidia.com>
References: <cover.1760555863.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|IA0PR12MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: 21727b7d-671c-435d-16c3-08de0c231b74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014|3613699012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jf41FheqodvIWaeySHX81Avccy9Q6FE7KQ5Rw+rKea8Vs7/dCVqbOZ4BhV80?=
 =?us-ascii?Q?IHajtgkmPTgHg+Bhh+TkSSnlvGBvXr0ZCv4JGTS8RHM1oo+V+fZgu5gfxfHq?=
 =?us-ascii?Q?Az1AS39gPvE50Zi1umEp3fURXIe+BxbmB5GeJXehf1y+yBYXEc6mId1mRHMl?=
 =?us-ascii?Q?UjdhGIY4xKPMaNWlqCtZUePy8mp2CiutZiB02apDhRcui9b1Cdu5fL71oHDk?=
 =?us-ascii?Q?6N0NFfbjCcbrzIHnmHC6S+h7IOEZWzy0GE4u6J5jJ2bGdFJIFJUakRu+Rjx5?=
 =?us-ascii?Q?J2dDcjsHuZ/fn+YhqcIY8lMN3KrVPNw/mYPikkSd5Y9zWeMdboFGqpA3W1/K?=
 =?us-ascii?Q?XrFOGEbZd7R5MCoBP1mIgRNvKJ/z3GtOp0men+WetWjwEXeNwD6LPGwVTEp+?=
 =?us-ascii?Q?NHxR1FBLm000/sIjNG1b09ZrGkYHpvYSRpUVs8JACsRqitfZX7VmekTnmkiJ?=
 =?us-ascii?Q?49mxGZfg2wwXK6rMeBFFDaE68rmcJ4qf7QFQY+6+BKS8vnGbBecWdH++Xhex?=
 =?us-ascii?Q?1SqZAR31njQygx7Baa8jCD+7nzW/FS5BE/lvo3BngbZJ0DtyR0FeL9xc16AE?=
 =?us-ascii?Q?//pkmBN0nwhchKKVEWMQMsXnusu4/hAnhJ+uAwMeJrLT+DjtGp2HYOSJc3nz?=
 =?us-ascii?Q?7q7f/hvWXyR+LngKFI30uisqyNBwY/CKaDBg2MICOUWkOfYgBwFez82SRcQX?=
 =?us-ascii?Q?SV+tw9JoiNHxPHb2yshOUmsqcQ5K72F2y+YPSsgrH9COAh2iztwisNh+k/bA?=
 =?us-ascii?Q?bVQ1fOGco1TpPWboRvDQevBFUMLJqdJrWuH4kA1Sc7IdseolKJsUgNABQN6B?=
 =?us-ascii?Q?yE2IfdANbPpv3IKSK+p92VG+/Cl46cMM09cOEoKy7UzZkU1bwGhWHtHib3ST?=
 =?us-ascii?Q?tvV4db4pGUytXn8VAYyXsgqLOusMbix+A+BQvcaTB1engfm8aWcoe+KrhlS0?=
 =?us-ascii?Q?/wtgHLVGaLEzKgmdpyBAWhf7SbhjeM+Du3GMshsSsH2BEr1OovyVf9PfEoOD?=
 =?us-ascii?Q?BpuopHBHuJ0XB0rbr5N9sNXojDyJA8gDA2faon/hDU02fmV82ZYmhDJwmJBu?=
 =?us-ascii?Q?zOqxApeOE+lIyI2OyVhV4xrDsXOL+8/GIN+iXxo35eGfYtEvH4O7tgZEoqAs?=
 =?us-ascii?Q?YkSjtXNA4avyUw8qKw2u7/1weSju3jGwVmpp5YLhlphD5N6+i9R8thjWJk1g?=
 =?us-ascii?Q?auSzvdGFdEZ9umOrQmQvrwh1A1SGEopRAmwuASuWEVafl+3GyvLdnoIX2Lz5?=
 =?us-ascii?Q?Ngd7WXuMzXf3xotoocWPzKDAR3NydEZYLp8LQ1cvEqpUDSQt1zgrkml24ZF2?=
 =?us-ascii?Q?C0OnzCwr2xFMfmzMfNvF8K0KS4TqbDMgAfsW//Cf03VvtG/v71hD9/9cL/RQ?=
 =?us-ascii?Q?iAzWVLuYEBPQzTV0vnkoEvS/0gOpHqxzplNsGJ4UvpTmoGuQOS0NSHkusa9h?=
 =?us-ascii?Q?T9HdKbCOq563Tq+P7gegcLiImh81vYCG0UzRkcYPS43I6LsODQr3nm/7XuA3?=
 =?us-ascii?Q?Qs3GkVxFQDvuuxMKo5U8l4Fu/7hZ1o/fRjx4oV9FUKG2J329eKSZw7kKfyvR?=
 =?us-ascii?Q?b6nt0EQwN8ojkS9pOmirIEGkKt1SaR8nDW0CojAo?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014)(3613699012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 19:43:25.5619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21727b7d-671c-435d-16c3-08de0c231b74
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7750

Each smmu_domain now has an arm_smmu_invs that specifies the invalidation
steps to perform after any change the IOPTEs. This includes supports for
basic ASID/VMID, the special case for nesting, and ATC invalidations.

Introduce a new arm_smmu_domain_inv helper iterating smmu_domain->invs to
convert the invalidation array to commands. Any invalidation request with
no size specified means an entire flush over a range based one.

Take advantage of the sorted array to compatible batch operations together
to the same SMMU. For instance, ATC invaliations for multiple SIDs can be
pushed as a batch.

ATC invalidations must be completed before the driver disables ATS. Or the
device is permitted to ignore any racing invalidation that would cause an
SMMU timeout. The sequencing is done with a rwlock where holding the write
side of the rwlock means that there are no outstanding ATC invalidations.
If ATS is not used the rwlock is ignored, similar to the existing code.

Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   9 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 218 ++++++++++++++++++--
 2 files changed, 214 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index b1dbcc6747baa..ab166de50f3e1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1078,6 +1078,15 @@ void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
 int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
 			    unsigned long iova, size_t size);
 
+void arm_smmu_domain_inv_range(struct arm_smmu_domain *smmu_domain,
+			       unsigned long iova, size_t size,
+			       unsigned int granule, bool leaf);
+
+static inline void arm_smmu_domain_inv(struct arm_smmu_domain *smmu_domain)
+{
+	arm_smmu_domain_inv_range(smmu_domain, 0, 0, 0, false);
+}
+
 void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
 			      struct arm_smmu_cmdq *cmdq);
 int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9f7945c98e3c7..e74c788c23673 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2500,23 +2500,19 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 	arm_smmu_atc_inv_domain(smmu_domain, 0, 0);
 }
 
-static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
-				     unsigned long iova, size_t size,
-				     size_t granule,
-				     struct arm_smmu_domain *smmu_domain)
+static void arm_smmu_cmdq_batch_add_range(struct arm_smmu_device *smmu,
+					  struct arm_smmu_cmdq_batch *cmds,
+					  struct arm_smmu_cmdq_ent *cmd,
+					  unsigned long iova, size_t size,
+					  size_t granule, size_t pgsize)
 {
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	unsigned long end = iova + size, num_pages = 0, tg = 0;
+	unsigned long end = iova + size, num_pages = 0, tg = pgsize;
 	size_t inv_range = granule;
-	struct arm_smmu_cmdq_batch cmds;
 
 	if (!size)
 		return;
 
 	if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
-		/* Get the leaf page size */
-		tg = __ffs(smmu_domain->domain.pgsize_bitmap);
-
 		num_pages = size >> tg;
 
 		/* Convert page size of 12,14,16 (log2) to 1,2,3 */
@@ -2536,8 +2532,6 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 			num_pages++;
 	}
 
-	arm_smmu_cmdq_batch_init(smmu, &cmds, cmd);
-
 	while (iova < end) {
 		if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
 			/*
@@ -2565,9 +2559,26 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 		}
 
 		cmd->tlbi.addr = iova;
-		arm_smmu_cmdq_batch_add(smmu, &cmds, cmd);
+		arm_smmu_cmdq_batch_add(smmu, cmds, cmd);
 		iova += inv_range;
 	}
+}
+
+static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
+				     unsigned long iova, size_t size,
+				     size_t granule,
+				     struct arm_smmu_domain *smmu_domain)
+{
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct arm_smmu_cmdq_batch cmds;
+	size_t pgsize;
+
+	/* Get the leaf page size */
+	pgsize = __ffs(smmu_domain->domain.pgsize_bitmap);
+
+	arm_smmu_cmdq_batch_init(smmu, &cmds, cmd);
+	arm_smmu_cmdq_batch_add_range(smmu, &cmds, cmd, iova, size, granule,
+				      pgsize);
 	arm_smmu_cmdq_batch_submit(smmu, &cmds);
 }
 
@@ -2623,6 +2634,187 @@ void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
 	__arm_smmu_tlb_inv_range(&cmd, iova, size, granule, smmu_domain);
 }
 
+static bool arm_smmu_inv_size_too_big(struct arm_smmu_device *smmu, size_t size,
+				      size_t granule)
+{
+	size_t max_tlbi_ops;
+
+	/* 0 size means invalidate all */
+	if (!size || size == SIZE_MAX)
+		return true;
+
+	if (smmu->features & ARM_SMMU_FEAT_RANGE_INV)
+		return false;
+
+	/*
+	 * Borrowed from the MAX_TLBI_OPS in arch/arm64/include/asm/tlbflush.h,
+	 * this is used as a threshold to replace "size_opcode" commands with a
+	 * single "nsize_opcode" command, when SMMU doesn't implement the range
+	 * invalidation feature, where there can be too many per-granule TLBIs,
+	 * resulting in a soft lockup.
+	 */
+	max_tlbi_ops = 1 << (ilog2(granule) - 3);
+	return size >= max_tlbi_ops * granule;
+}
+
+/* Used by non INV_TYPE_ATS* invalidations */
+static void arm_smmu_inv_to_cmdq_batch(struct arm_smmu_inv *inv,
+				       struct arm_smmu_cmdq_batch *cmds,
+				       struct arm_smmu_cmdq_ent *cmd,
+				       unsigned long iova, size_t size,
+				       unsigned int granule)
+{
+	if (arm_smmu_inv_size_too_big(inv->smmu, size, granule)) {
+		cmd->opcode = inv->nsize_opcode;
+		/* nsize_opcode always needs a sync, no batching */
+		arm_smmu_cmdq_issue_cmd_with_sync(inv->smmu, cmd);
+		return;
+	}
+
+	cmd->opcode = inv->size_opcode;
+	arm_smmu_cmdq_batch_add_range(inv->smmu, cmds, cmd, iova, size, granule,
+				      inv->pgsize);
+}
+
+static inline bool arm_smmu_invs_end_batch(struct arm_smmu_inv *cur,
+					   struct arm_smmu_inv *next)
+{
+	/* Changing smmu means changing command queue */
+	if (cur->smmu != next->smmu)
+		return true;
+	/* The batch for S2 TLBI must be done before nested S1 ASIDs */
+	if (cur->type != INV_TYPE_S2_VMID_S1_CLEAR &&
+	    next->type == INV_TYPE_S2_VMID_S1_CLEAR)
+		return true;
+	/* ATS must be after a sync of the S1/S2 invalidations */
+	if (!arm_smmu_inv_is_ats(cur) && arm_smmu_inv_is_ats(next))
+		return true;
+	return false;
+}
+
+void arm_smmu_domain_inv_range(struct arm_smmu_domain *smmu_domain,
+			       unsigned long iova, size_t size,
+			       unsigned int granule, bool leaf)
+{
+	struct arm_smmu_cmdq_batch cmds = {};
+	struct arm_smmu_invs *invs;
+	struct arm_smmu_inv *cur;
+	struct arm_smmu_inv *end;
+	bool locked = false;
+
+	/*
+	 * An invalidation request must follow some IOPTE change and then load
+	 * an invalidation array. In the meantime, a domain attachment mutates
+	 * the array and then stores an STE/CD asking SMMU HW to acquire those
+	 * changed IOPTEs. In other word, these two are interdependent and can
+	 * race.
+	 *
+	 * In a race, the RCU design (with its underlying memory barriers) can
+	 * ensure the invalidation array to always get updated before loaded.
+	 *
+	 * smp_mb() is used here, paired with the smp_mb() following the array
+	 * update in a concurrent attach, to ensure:
+	 *  - HW sees the new IOPTEs if it walks after STE installation
+	 *  - Invalidation thread sees the updated array with the new ASID.
+	 *
+	 *  [CPU0]                        | [CPU1]
+	 *                                |
+	 *  change IOPTEs and TLB flush:  |
+	 *  arm_smmu_domain_inv_range() { | arm_smmu_install_new_domain_invs {
+	 *    ...                         |   rcu_assign_pointer(new_invs);
+	 *    smp_mb(); // ensure IOPTEs  |   smp_mb(); // ensure new_invs
+	 *    ...                         |   kfree_rcu(old_invs, rcu);
+	 *    // load invalidation array  | }
+	 *    invs = rcu_dereference();   | arm_smmu_install_ste_for_dev {
+	 *                                |   STE = TTB0 // read new IOPTEs
+	 */
+	smp_mb();
+
+	rcu_read_lock();
+	invs = rcu_dereference(smmu_domain->invs);
+
+	/*
+	 * Avoid locking unless ATS is being used. No ATC invalidation can be
+	 * going on after a domain is detached.
+	 */
+	if (invs->has_ats) {
+		read_lock(&invs->rwlock);
+		locked = true;
+	}
+
+	cur = invs->inv;
+	end = cur + READ_ONCE(invs->num_invs);
+	/* Skip any leading entry marked as a trash */
+	for (; cur != end; cur++)
+		if (refcount_read(&cur->users))
+			break;
+	while (cur != end) {
+		struct arm_smmu_device *smmu = cur->smmu;
+		struct arm_smmu_cmdq_ent cmd = {
+			/*
+			 * Pick size_opcode to run arm_smmu_get_cmdq(). This can
+			 * be changed to nsize_opcode, which would result in the
+			 * same CMDQ pointer.
+			 */
+			.opcode = cur->size_opcode,
+		};
+		struct arm_smmu_inv *next;
+
+		if (!cmds.num)
+			arm_smmu_cmdq_batch_init(smmu, &cmds, &cmd);
+
+		switch (cur->type) {
+		case INV_TYPE_S1_ASID:
+			cmd.tlbi.asid = cur->id;
+			cmd.tlbi.leaf = leaf;
+			arm_smmu_inv_to_cmdq_batch(cur, &cmds, &cmd, iova, size,
+						   granule);
+			break;
+		case INV_TYPE_S2_VMID:
+			cmd.tlbi.vmid = cur->id;
+			cmd.tlbi.leaf = leaf;
+			arm_smmu_inv_to_cmdq_batch(cur, &cmds, &cmd, iova, size,
+						   granule);
+			break;
+		case INV_TYPE_S2_VMID_S1_CLEAR:
+			/* CMDQ_OP_TLBI_S12_VMALL already flushed S1 entries */
+			if (arm_smmu_inv_size_too_big(cur->smmu, size, granule))
+				continue;
+			cmd.tlbi.vmid = cur->id;
+			arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
+			break;
+		case INV_TYPE_ATS:
+			arm_smmu_atc_inv_to_cmd(cur->ssid, iova, size, &cmd);
+			cmd.atc.sid = cur->id;
+			arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
+			break;
+		case INV_TYPE_ATS_FULL:
+			arm_smmu_atc_inv_to_cmd(IOMMU_NO_PASID, 0, 0, &cmd);
+			cmd.atc.sid = cur->id;
+			arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
+			break;
+		default:
+			WARN_ON_ONCE(1);
+			continue;
+		}
+
+		/* Skip any trash entry in-between */
+		for (next = cur + 1; next != end; next++)
+			if (refcount_read(&next->users))
+				break;
+
+		if (cmds.num &&
+		    (next == end || arm_smmu_invs_end_batch(cur, next))) {
+			arm_smmu_cmdq_batch_submit(smmu, &cmds);
+			cmds.num = 0;
+		}
+		cur = next;
+	}
+	if (locked)
+		read_unlock(&invs->rwlock);
+	rcu_read_unlock();
+}
+
 static void arm_smmu_tlb_inv_page_nosync(struct iommu_iotlb_gather *gather,
 					 unsigned long iova, size_t granule,
 					 void *cookie)
-- 
2.43.0

