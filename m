Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0821F1A2388
	for <iommu@lists.linux.dev>; Wed,  5 Mar 2025 05:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741151129; cv=fail; b=pQKdsXhpenRkoP5Mi/JK+baDxpezIWzS5y+NBUmMfPzc227KX7KG2+lEK/PXzJCtbSLLpzAJCMMkPXv9ZPHBfQkj53X5/AEhAzqaFqoik582XtBcboQXSpmWiIq7KHXr5cklcH8At1jR+CZCWYI1fjqX43sF7ABOOaNRj4EYIxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741151129; c=relaxed/simple;
	bh=TfiRdHafv2cuGdmtYC9j1n7g7lGWNSqBaQr87UMK2Kw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BpgbNpe5mhU53J04w6SLV24JJw5RDbjVruz8RRRO4o0+DRlBG6ToQvePf5h3Gu3l7QomibT8ch/wYoy66i6UQkWf+p0GKoNn1O3VshBxJWe835xii6szsPGB0msWR9T9swKbU7y6wUhKRKRS+JBnxK6dvtCxSKTjvuBOiNs5Vkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=swkZfCW1; arc=fail smtp.client-ip=40.107.92.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="swkZfCW1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E8qPjeEv4xzXFbmfrGdtgX0hCpJ9FulJKY+lDZHMRj4gGZZDHcd705nT8EtlXUFjB1IGeMt/Iin/To8czX/MICzdtyWgFhz19OcNVGTsj14nrP3Ax06XfTWE530C/8NytWgFfwHsymi4xIu1AVkbhbqJhZfVOLj0BCG+Fi4tbR6RWN3S+Oty3lRUV9G4f8Zo3fDeM4A2gY+AA8ZPyENUsrYl4ZGX4MbhIrW6jk7hhlqsY2jZW6IMyyi0zQ+1TOTD7vbPQl64/Hwp2TVQWlmRqP3tF18P9jB3lN7Lm4vBuJCqwpH6Qvv7yqoPOtnkqujD1DKQPlQMbVH6B2N4yzAMVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bZ/ZHj6ooYmdyVrpdOUn5MDJjwanAD+IPlSgRaMfWg8=;
 b=ua2HNYFh3CUmDU1z7KtAqw1Umo8/RjFzn7smsK35T5vNvU59zQL/iqo8MQ3lXl9UBaSQ+TyjwQBVHzBOIQtk1UJenj0lZJNtXqqXddK0O+j5mJ9PYfJqU/bHaQydnLyCwsKKdbMoLpzeWj2EOIIyL9xxVetF35yuz4rAqpUV2HDMHSzUjXM0a5AxhaD5i7XWI+5izLhSom2XDUm3x8Na3beQw3s+qZNq9vA2YoN1Nj3pVDXPsXZwFze8CIgMItrYKQJOK14e/3ni1eZ+f5kmGDzO1CuEb2hXiMQhWbGE111rjeMy4AkvGng1Km8VVQR6ZRZipdPfw7SNsAskDGH5+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZ/ZHj6ooYmdyVrpdOUn5MDJjwanAD+IPlSgRaMfWg8=;
 b=swkZfCW14dW4l1qa8BY5hZInEpzgab+lEHdhzX2GfdPKmzinSyWDBVXlxy5avHPbYRQrtfSB1cdfaTQTQaO+GOmuSIdYnLD9QA7ijZp34NurDZ+dMNB2rJb+CqryNt46inhWRcMpCtub3N4Q+tJcL39x3eAg3RNl92LB1bRChLT2OyxTHHwbG7Hfo4H5rdjEe+7aSR9Ckmlfjf12mXD+SjuhBTVZJMXjlRX9mqIp8HkCmiYOQer4vkhE/wCkal9WvIe7acVYbUsRg6i4IZikKtOabYiQnkNEYb1hfttsePCTDH2jO9KJwOhu1TbkRRYRnGuNyWcqZYVC3aWRQeujyw==
Received: from BN9PR03CA0144.namprd03.prod.outlook.com (2603:10b6:408:fe::29)
 by PH7PR12MB6610.namprd12.prod.outlook.com (2603:10b6:510:212::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 05:05:22 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:fe:cafe::c6) by BN9PR03CA0144.outlook.office365.com
 (2603:10b6:408:fe::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 05:05:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 05:05:22 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Mar 2025
 21:05:09 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Mar
 2025 21:05:08 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 4 Mar 2025 21:05:08 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v1 1/4] iommu/arm-smmu-v3: Pass in vmid to arm_smmu_make_s2_domain_ste()
Date: Tue, 4 Mar 2025 21:04:00 -0800
Message-ID: <214b10db02f1046efdc70e2c4803111357f60070.1741150594.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741150594.git.nicolinc@nvidia.com>
References: <cover.1741150594.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|PH7PR12MB6610:EE_
X-MS-Office365-Filtering-Correlation-Id: ad65fe9e-ac1c-4603-7ef6-08dd5ba35536
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|30052699003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LKOubk2EL9+5UC3BGh7HjYEdM2RAs/HaNVIMT5RiLeY+VBtrel42J1Pc+6q9?=
 =?us-ascii?Q?+Rf/vcryYRzTT9OOgtUbSg1Ig6vOutVyrF+QOlzAIGWIoDzxuv/kxjq7GuqR?=
 =?us-ascii?Q?2Ilu6STD1MNbU/QsBDWyOPZ3cQ83lwB5GLv9AHnME3qxyDtLvE/VOmuaOSyf?=
 =?us-ascii?Q?o5+9Hq+1YseLkYsEmRNOXtMprS+rHNz6KLJNhUcb8g8bJo/V4FIau5UABq4k?=
 =?us-ascii?Q?bs4yqU8cLIGckU8Qr0wHONXslx6n8xOZKrUCTeynb9+ciPsw5FFuc3XC1jos?=
 =?us-ascii?Q?7kvwzhnrgc6+VQSXXK6cHFWdy/pLTnMf9APsbrI5O3zfD7XkpXD0Ul2KD3bR?=
 =?us-ascii?Q?Du6mJ4qEt745ZnQuk4RMDjW5a+tLFddccODJNfnIsoG+e94znx5sWshqEeKj?=
 =?us-ascii?Q?GqPBoOhZKUKnbZVQjg4VkPH0+Wt+3VUr0dKRqB3GGAh+A5oV5Y5/6o4WOYM6?=
 =?us-ascii?Q?PHFK3OLQ7ZnjevuGkcOkRQYfRfFd/BtXdCeNMt5+ZgvqXQ2eMF80VSwmL1Xq?=
 =?us-ascii?Q?fsMCObv9PsOmemvezPFJFWMtR+g9E1D6iLF1u1WcwvH7KhtdIBe0NseLvdDq?=
 =?us-ascii?Q?9f46GE+yAWDB/U99/I2IUqlI6llMaHLCPsrUrky3VNZw5ubb96vMeU+clhFq?=
 =?us-ascii?Q?ub3oZpifKVnY8PaPRN9xZXt4pVZerLRr4o5Z4keEofhCJRi9D7FKimu4SqhN?=
 =?us-ascii?Q?fFXoW/o3AbnS4hWxjlxG7ufuA+KDcjxj1vWG8shALkZhY4Lc2zv4rGa4whAl?=
 =?us-ascii?Q?qs06tpF3ekLhErEyOlqw2sRF3NiI80rum8hgdOSU+2d11Clo1pyqUJSyo4aE?=
 =?us-ascii?Q?R6zyw4c0H/04sA9Bb2xGL52tfmr8bQZbAQN1l13usdYUWLalS8SX/pe4AYFx?=
 =?us-ascii?Q?6orB9uOv1kKFPon0SyORZtHybz3q//C5zmWDPl5iGJ3Sr8xOHW4NhIqwp5xw?=
 =?us-ascii?Q?YF/mFdZrratYw0rhAW0xRx9DxDnWrjqSHZMHZ0e3DR8Zur537KB2smEXWplX?=
 =?us-ascii?Q?LpiJnKnm+YoCK11samMx0I55sKoNu5Q3vuHoVxcLsn5yvKFZ0qlhn/wqf2Ys?=
 =?us-ascii?Q?LbV71JbwYG7Rat0I1cNFpdA/bTOEWAsMRxavYjml8N//r2GtA7POVPb7ekoS?=
 =?us-ascii?Q?vsghdSlJXIZz5RSL9yZxVULSBKgRtFve0PaisUJCMFufdYS+5cr3AIs8LTZd?=
 =?us-ascii?Q?if0xgjaqF1g4yiSNjss5knDgRwvxVl2/kHW42zRjbfhAXzko78QotZb5Kfik?=
 =?us-ascii?Q?w8xNW+ht+j0i2fAUz/0QjN35okn20Dc+7RqMRQzJIQ2hh9MjUe2Ni70uR76H?=
 =?us-ascii?Q?nPMza1foOMUgAJmrIl86Rp5HqDoGNB0Hg5bufVSPm9sPhs6eLXy2ftSD4YE/?=
 =?us-ascii?Q?TZnzOA11ZqoI1zYpmKnNKsBZOTI5d91jGwF499mHbKGCnjWCNT2I8cGkqFnQ?=
 =?us-ascii?Q?h1MvEOy7P1Brz1kxZO0UoFUKouA5dmsJO2syBnob0j2TPdQNBca5iTqiHD7X?=
 =?us-ascii?Q?f7GMkVI3nx7+XwQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(30052699003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 05:05:22.1878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad65fe9e-ac1c-4603-7ef6-08dd5ba35536
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6610

An stage-2 STE requires a vmid that has been so far allocated per domain,
so arm_smmu_make_s2_domain_ste() has been extracting the vmid from the S2
domain.

To share an S2 parent domain across vSMMUs in the same VM, a vmid will be
no longer allocated for nor stored in the S2 domain, but per vSMMU, which
means the arm_smmu_make_s2_domain_ste() can get a vmid either from an S2
domain (non nesting parent) or a vSMMU.

Allow to pass in vmid explicitly to arm_smmu_make_s2_domain_ste(), giving
its callers a chance to pick the vmid between a domain or a vSMMU.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h         | 2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 6 ++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c    | 3 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c         | 6 +++---
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index bd9d7c85576a..e08c4ede4b2d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -887,7 +887,7 @@ struct arm_smmu_entry_writer_ops {
 void arm_smmu_make_abort_ste(struct arm_smmu_ste *target);
 void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
 				 struct arm_smmu_master *master,
-				 struct arm_smmu_domain *smmu_domain,
+				 struct arm_smmu_domain *smmu_domain, u16 vmid,
 				 bool ats_enabled);
 
 #if IS_ENABLED(CONFIG_KUNIT)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 5aa2e7af58b4..ff8b550159f2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -34,8 +34,9 @@ static void arm_smmu_make_nested_cd_table_ste(
 	struct arm_smmu_ste *target, struct arm_smmu_master *master,
 	struct arm_smmu_nested_domain *nested_domain, bool ats_enabled)
 {
-	arm_smmu_make_s2_domain_ste(
-		target, master, nested_domain->vsmmu->s2_parent, ats_enabled);
+	arm_smmu_make_s2_domain_ste(target, master,
+				    nested_domain->vsmmu->s2_parent,
+				    nested_domain->vsmmu->vmid, ats_enabled);
 
 	target->data[0] = cpu_to_le64(STRTAB_STE_0_V |
 				      FIELD_PREP(STRTAB_STE_0_CFG,
@@ -76,6 +77,7 @@ static void arm_smmu_make_nested_domain_ste(
 	case STRTAB_STE_0_CFG_BYPASS:
 		arm_smmu_make_s2_domain_ste(target, master,
 					    nested_domain->vsmmu->s2_parent,
+					    nested_domain->vsmmu->vmid,
 					    ats_enabled);
 		break;
 	case STRTAB_STE_0_CFG_ABORT:
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
index d2671bfd3798..7fac5a112c5c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
@@ -316,7 +316,8 @@ static void arm_smmu_test_make_s2_ste(struct arm_smmu_ste *ste,
 	io_pgtable.cfg.arm_lpae_s2_cfg.vtcr.sl = 3;
 	io_pgtable.cfg.arm_lpae_s2_cfg.vtcr.tsz = 4;
 
-	arm_smmu_make_s2_domain_ste(ste, &master, &smmu_domain, ats_enabled);
+	arm_smmu_make_s2_domain_ste(ste, &master, &smmu_domain,
+				    smmu_domain.s2_cfg.vmid, ats_enabled);
 }
 
 static void arm_smmu_v3_write_ste_test_s2_to_abort(struct kunit *test)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 358072b4e293..310bb4109ec9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1656,10 +1656,9 @@ EXPORT_SYMBOL_IF_KUNIT(arm_smmu_make_cdtable_ste);
 
 void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
 				 struct arm_smmu_master *master,
-				 struct arm_smmu_domain *smmu_domain,
+				 struct arm_smmu_domain *smmu_domain, u16 vmid,
 				 bool ats_enabled)
 {
-	struct arm_smmu_s2_cfg *s2_cfg = &smmu_domain->s2_cfg;
 	const struct io_pgtable_cfg *pgtbl_cfg =
 		&io_pgtable_ops_to_pgtable(smmu_domain->pgtbl_ops)->cfg;
 	typeof(&pgtbl_cfg->arm_lpae_s2_cfg.vtcr) vtcr =
@@ -1690,7 +1689,7 @@ void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
 		   FIELD_PREP(STRTAB_STE_2_VTCR_S2TG, vtcr->tg) |
 		   FIELD_PREP(STRTAB_STE_2_VTCR_S2PS, vtcr->ps);
 	target->data[2] = cpu_to_le64(
-		FIELD_PREP(STRTAB_STE_2_S2VMID, s2_cfg->vmid) |
+		FIELD_PREP(STRTAB_STE_2_S2VMID, vmid) |
 		FIELD_PREP(STRTAB_STE_2_VTCR, vtcr_val) |
 		STRTAB_STE_2_S2AA64 |
 #ifdef __BIG_ENDIAN
@@ -2969,6 +2968,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	}
 	case ARM_SMMU_DOMAIN_S2:
 		arm_smmu_make_s2_domain_ste(&target, master, smmu_domain,
+					    smmu_domain->s2_cfg.vmid,
 					    state.ats_enabled);
 		arm_smmu_install_ste_for_dev(master, &target);
 		arm_smmu_clear_cd(master, IOMMU_NO_PASID);
-- 
2.43.0

