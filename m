Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012025.outbound.protection.outlook.com [52.101.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7763532AACE
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 18:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769540143; cv=fail; b=UoBPbkTdpYufRQsTHQQvic3z2TjUDgPB//pxbGP/jnBZnCC7PhacVWxCNVQg8MBx2Bso2kR5DdJRSLI3QMrkv1B1AItqSbsIf7pN+NnIZQTpEYtOdukS2iZNtGKy9gxWocsPWX7oJ1x/bZMJtfaAFaQw0KvDyglwFa5s1MFE6BE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769540143; c=relaxed/simple;
	bh=5c0e5VhCU278NJsJYAjT5aCbVoXdKsz/cgSGfY0Od+M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NZUJTaJBIMTtyZEI/+S0kw9zW+IAb74WKhOSwPbndvrk+c3dvKtSIIohU3V8AY8AnB+hDUZn/H00ipXoRJono8/aSF7R5USgKimvkp2agkAhOioxpgK37pPXHEkvEe7HqeUsvGgdaYPzmhZSsMLvHccxIKKJxjrnIeqZjvvMDa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NsxS1IOE; arc=fail smtp.client-ip=52.101.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NsxS1IOE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nmL73lS+r9UaLTeahd7UOwz/sDXemrvy5nrD+roiwXVbtXhVC4lEwW0VRX7mIqECWdrARwzJ+TMrgJLTyuG+ezmSJH+pDpNv5u+/mJu4yzwD3JIHRiIQ7wSdySNzq4jwK6pZDweLtVJsVtoO8c9M+c+uYnLyKbPV88byKxWHFJB+cOsw3pNUOoAiWHF4Tzpg0qy49Qc3v4CtsWXYlUT1qNcxni2yz1Fhklhi8NOEJtgvlezpe/92O+sEHwcBtMMiC4RkoSIz4G85Rz1pDXY4T4x9eHLxH1arguuY7okaEBGjAFfUXjI2Eruo+PukXC2UfXI4JdIp58LQm8+Bk8WIxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krpA+Zc5qTbSRzNfxQXK2DLZtPlX/eXklnj0jozptD0=;
 b=TrnyBs9827DNb1AmxACU1t3XQjuX/xuPFCIHTRW0J5Tx3kmaHeJbNWcUQ2dN04+Kp6Vz42umKNMJtFxWCSOCbAwaCJH/LZHuzrMr+QVbZzFyr+zCcFsZXWxxzTReCr03DISKmLY5wv5my/ECJdNeyQW2spX9G+Zs05s+vH3IefgwwJe9ZGjaLijkjKmoCjWdPy33hM3vEB57IhPlhht+UEuwPjFhRF34ADtLFf21wn0beLbwP1iiVTH9oPcCIZ++bsGlW/2AvuyUDQehzxQzRiwP12S0szFYjDE7+POu4qmlLfIQ7nz8o34UO5J0qUhvk6dStZ94MaW8v3s3Mx/vYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krpA+Zc5qTbSRzNfxQXK2DLZtPlX/eXklnj0jozptD0=;
 b=NsxS1IOEMuAtCucXXax5l5MxsoxfHHU0IWtT3/uwPPrKwZyPe+K/RIuZbpwDW3VZqdSa3FQl4rpFWCPOOvwCfFnTmrwV3BFzufC+fEI3Xb6gVkubezDD/L37tIQv57acLdWkRQ+/SyZiMap9bq13eQ1HuGcaO6Sy8J0Jz1Sq0OwZEnpN7mbsaB8SoMt10kRVMSsL990asxz5/EYwkQYawoWzXLBetcWbVQ6EPz/dyXVrQDcmcg30Mll/RAXn9H9p42o/nrkjvWM726Qthq+FqNcKYofa/Fc8b6oPDyNWRft6D4agDnrC3rWQGj9IvBRKUGJA2fsMB4V2pUP2S/roMw==
Received: from SJ0PR03CA0153.namprd03.prod.outlook.com (2603:10b6:a03:338::8)
 by SN7PR12MB8028.namprd12.prod.outlook.com (2603:10b6:806:341::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Tue, 27 Jan
 2026 18:55:34 +0000
Received: from SJ1PEPF00002320.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::53) by SJ0PR03CA0153.outlook.office365.com
 (2603:10b6:a03:338::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Tue,
 27 Jan 2026 18:55:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002320.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 18:55:34 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 10:55:14 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 10:55:13 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 27 Jan 2026 10:55:12 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v11 7/8] iommu/arm-smmu-v3: Add arm_smmu_invs based arm_smmu_domain_inv_range()
Date: Tue, 27 Jan 2026 10:54:59 -0800
Message-ID: <693bf688dccb92cc94e916c652a6a5d7bdbeb441.1769539310.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769539310.git.nicolinc@nvidia.com>
References: <cover.1769539310.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002320:EE_|SN7PR12MB8028:EE_
X-MS-Office365-Filtering-Correlation-Id: 108d254b-a7c9-406f-df1e-08de5dd5a6ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|3613699012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FIwiPRcsgMfSL6vx9CaYESaoIfSV1IVIIDKW9dR59OK5hjtRVp2iXrhqFG6S?=
 =?us-ascii?Q?f0UH5OWdqiw4vkMfIazOP9XA+/DssVabY3GX9KL63X/DIP85RKGZTKJS4Hug?=
 =?us-ascii?Q?/YUEVQv+4bLag49aJ6uZ4opajRNEqDpaqV7wksk8//KS4NXJoeI3p2rwoe4n?=
 =?us-ascii?Q?03/tRKZHEdnkGZsrSJTAdOerfnoxBA7l2SAG3K+evHp5JhQ57Q/K13ADzauy?=
 =?us-ascii?Q?aOwy6LgC7sWO39AXrQy1tOVMp10GvCzE4MP43v4A5Rmbs7w+m6hXNqUhVukO?=
 =?us-ascii?Q?8ihGgtoyJkrTgWLHtEgy3zbjsH1EcYmnbZwAVhxsN4+UIhB1H/H3VG8GJqZC?=
 =?us-ascii?Q?Wb2LuExDILqgdvdjOmq0EJJt0uH3anizoWutVpUy5NaojG/xYt3mid3/JSah?=
 =?us-ascii?Q?FGh2GzvXSIZyT9MvOxeOdXnVxrTEtpB+Q9yoI9IR7sByjQBhAfeh8g9MDfnF?=
 =?us-ascii?Q?CPpEZUvsxF7Y5B7EQlc8ZzhiHuxgbIDFLA3B2o4uyPwyKWVw6+sLtvNGOFxO?=
 =?us-ascii?Q?BQNbxr9MhEyuNHAs4vlhnWbXByl34CgbgVXpsJZ4b/W661Lij98RoF5kkOkH?=
 =?us-ascii?Q?MhZXVaLmOdO9BzSVGjDO9arw2DrZcV/q5i/N5++U7q25cw04nYOxLTy4kMxf?=
 =?us-ascii?Q?wzEaxVUepQlpyahzDE1wRjIk4DqU+X6EQPtkpVT0pX7kMTHQWr1s5ujJS8ek?=
 =?us-ascii?Q?rGZV7ULWg9M3lssitDXhnUVaf4j2bb0c3xBLcBZvPyy3mmbk8aWuJiZpkYDF?=
 =?us-ascii?Q?O0XKjgluWzaq6Jzk+2vmJrgJNyx2oVAdv5E+O7G7EhZOge6J+y9fg9lgoAzY?=
 =?us-ascii?Q?QJh1q4bjsyhlKpaMAE9gnFldyYrHI8K6rtLYpTkQAwTw+heZZWsP/pF5rSHP?=
 =?us-ascii?Q?WsAIrU+T3JwOv76wgKO9oqAelJfHExt6pZ8VXSnW3jVE1sEqw2TbDS9gYx65?=
 =?us-ascii?Q?iVMl8VOec+Ck8HJHRsxfLpIB8xPoeqvLh5mxsD3D6A1FYENOUBPQ8adw88Bt?=
 =?us-ascii?Q?Tl0PnQ94saBVw9zNE5vT5el2kCaXyvJ/dUyqCGe0mJV6mFq0JpWkNDsneYlv?=
 =?us-ascii?Q?kr95vLMmbNucnB3/j13XDfKkyZXf+NwQXSMCXgtnoS5glO8rc2JPaYAI2NCj?=
 =?us-ascii?Q?k73fIiWaSzdOpj7FMNT7jfE98O5K/Y2dlRdG4V9tvLhMB5pbXlG52OB5fKZq?=
 =?us-ascii?Q?1kkbdFJnGoa2IVmDhSB3tEW2QTWbgKo24WJqDw5s6RkwH7jtoFhTBUL6O0OR?=
 =?us-ascii?Q?diy4VT3GZQU2OlAUGEYOcOxAt+wXt/bIuO5XYxAP3+zRg5EQgFKX/6vYrVTj?=
 =?us-ascii?Q?atAunYHL2/n8C2rDNStNfKaRTek9e3G/b6jRuy/wmdTU7uc+4QjnW8orw4Ru?=
 =?us-ascii?Q?RvSvDd7tJqiUOG7sBCzIxhd67DLgVDuu1Wf2ko5/vrErcrQ8xX2v2B2Pi3ZU?=
 =?us-ascii?Q?+oyHxhZ1FJzTp9rHvnWEjUhBcQIrnAT/gejbKoZSiukc2bmkwYGL0Ig3gCuK?=
 =?us-ascii?Q?DkrHQDECZYb+p9f7Ld8/l7Dt5ab000LoxEwGidpAJxAWtm3WqEyipr5RmH2W?=
 =?us-ascii?Q?Ehb5rFT5wBoozdY2M+HbboHaC87+KD6X5m1OgfQb2jbPyuP6CqM5wXq+ApCB?=
 =?us-ascii?Q?1bgfjGGnA2OQoPUX9fp/vYqrxOjlfUMdGpk21OuZ8Ec+UXr5lg/u0y1dlJpB?=
 =?us-ascii?Q?ofRCvmFYjh/EKcqSvi7hO+yi8xs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(3613699012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 18:55:34.2894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 108d254b-a7c9-406f-df1e-08de5dd5a6ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8028

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
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   9 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 225 ++++++++++++++++++--
 2 files changed, 221 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 83d7e4952dff..534e9a5ddca3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1087,6 +1087,15 @@ void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
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
index 2114af1dd5ed..b9db98c793a7 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2591,23 +2591,19 @@ static void arm_smmu_tlb_inv_context(void *cookie)
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
@@ -2627,8 +2623,6 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 			num_pages++;
 	}
 
-	arm_smmu_cmdq_batch_init(smmu, &cmds, cmd);
-
 	while (iova < end) {
 		if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
 			/*
@@ -2656,9 +2650,26 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
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
 
@@ -2714,6 +2725,194 @@ void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
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
+		arm_smmu_cmdq_batch_add(inv->smmu, cmds, cmd);
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
+static void __arm_smmu_domain_inv_range(struct arm_smmu_invs *invs,
+					unsigned long iova, size_t size,
+					unsigned int granule, bool leaf)
+{
+	struct arm_smmu_cmdq_batch cmds = {};
+	struct arm_smmu_inv *cur;
+	struct arm_smmu_inv *end;
+
+	cur = invs->inv;
+	end = cur + READ_ONCE(invs->num_invs);
+	/* Skip any leading entry marked as a trash */
+	for (; cur != end; cur++)
+		if (READ_ONCE(cur->users))
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
+			if (READ_ONCE(next->users))
+				break;
+
+		if (cmds.num &&
+		    (next == end || arm_smmu_invs_end_batch(cur, next))) {
+			arm_smmu_cmdq_batch_submit(smmu, &cmds);
+			cmds.num = 0;
+		}
+		cur = next;
+	}
+}
+
+void arm_smmu_domain_inv_range(struct arm_smmu_domain *smmu_domain,
+			       unsigned long iova, size_t size,
+			       unsigned int granule, bool leaf)
+{
+	struct arm_smmu_invs *invs;
+
+	/*
+	 * An invalidation request must follow some IOPTE change and then load
+	 * an invalidation array. In the meantime, a domain attachment mutates
+	 * the array and then stores an STE/CD asking SMMU HW to acquire those
+	 * changed IOPTEs.
+	 *
+	 * When running alone, a domain attachment relies on the dma_wmb() in
+	 * arm_smmu_write_entry() used by arm_smmu_install_ste_for_dev().
+	 *
+	 * But in a race, these two can be interdependent, making it a special
+	 * case requiring an additional smp_mb() for the write->read ordering.
+	 * Pairing with the dma_wmb() in arm_smmu_install_ste_for_dev(), this
+	 * makes sure that IOPTE update prior to this point is visable to SMMU
+	 * hardware before we load the updated invalidation array.
+	 *
+	 *  [CPU0]                        | [CPU1]
+	 *  change IOPTE on new domain:   |
+	 *  arm_smmu_domain_inv_range() { | arm_smmu_install_new_domain_invs()
+	 *    smp_mb(); // ensures IOPTE  | arm_smmu_install_ste_for_dev {
+	 *              // seen by SMMU   |   dma_wmb(); // ensures invs update
+	 *    // load the updated invs    |              // before updating STE
+	 *    invs = rcu_dereference();   |   STE = TTB0;
+	 *    ...                         |   ...
+	 *  }                             | }
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
+		unsigned long flags;
+
+		read_lock_irqsave(&invs->rwlock, flags);
+		__arm_smmu_domain_inv_range(invs, iova, size, granule, leaf);
+		read_unlock_irqrestore(&invs->rwlock, flags);
+	} else {
+		__arm_smmu_domain_inv_range(invs, iova, size, granule, leaf);
+	}
+
+	rcu_read_unlock();
+}
+
 static void arm_smmu_tlb_inv_page_nosync(struct iommu_iotlb_gather *gather,
 					 unsigned long iova, size_t granule,
 					 void *cookie)
-- 
2.43.0

