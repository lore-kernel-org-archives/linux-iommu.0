Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBF53A1B0
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 00:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723769766; cv=fail; b=Ep+fzF5w34W1AgInVT41K+QS7KM/JjrJvFHj8XJ0W1+SahEsiIYIpB+FoXhC21dufKHv7qahSrFcGe28wEmWXeqHImAwvTXEaBJjXMHr2vRAlgrPpR4uWMFVT+nhI9PtRkCdqBDhkhK9KFFg9gmrYShF1x5Z4N/jeVmbXodhWIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723769766; c=relaxed/simple;
	bh=05h5kmXHey6y+aGU2U4EsCITU6D1QD6cGbX2bcb4Ui4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nxdbsv+Eig7Loxsn9MLWLvmtEY97snux1hA6R/xjiNvxYQdGfNbuhQ7f4iQECKmDzG1PmyD4eJawQxZIm238qnvGH/gZyFZIGAukBEF8QA/fCGNxfIbCTJ3itxZk8yLBD7jDtkMQGMhtJgFEtiM+pJnQivmLsc0I2/wr2PD2+Ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iFf7Pomx; arc=fail smtp.client-ip=40.107.94.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iFf7Pomx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O9ajcrALUgmyN7nXs1+RIErMl6NYciMiJdLMMuoqUTbZh5SE44jaFwZnUPj0fCbXGbaYn3plWNCBU9wbrbDtZn1kl0bWQ0n8YzeVUGGdaoTW6752zIL+z9LAVEAYdq5Co4OIJ9eu1FTR/ByexcU+aNu6LS6dACoinenFYPPBxjr8oXvFUJJ3mzDDyELJRgzKO0tlo9zMQVm9elxVloITfA5c7hIB217wOT04puKxbxb+tjVtGXI7TQnqt2BnJuB0A5JzWx8zHjYtyJUYK8lPOKExqrQxUPTWSPw8ITx29QY0N5i1AP2GB982Je6VPgu1nbP+84MzSg1p/rE4XIPeYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPDubkbMqgbcv/zjTjwGcmhEwYLX+bEDSLRIn9Ad+Dk=;
 b=TZ19KBHGKtI7alyNh+b7QdCxYxYcMU9Pk98QhzhxVe2N46a49/TgtihPCWbMNnrD1XIRHpwszOOyCoOtgPM+a/s6YtWEPyefmuedcVwBCcBjf6hxE2Tvyaa9wCe5qTKvofQ+7Qe8c4bX2V+fh+aTpiOfu6wa3sZNCa3lgHbTbevYt1KDr6nXgOnwUYFwOnVuY9EzCJbwiID3WF7Pxc2cuDN7712gNCBdt385YO++DZB4FL1jTM41e8AXbl8F8u7Xs0iUPzbTMfOJ/W+sFAMm0b1hmhotZjpnsTtMHnYXMF7LdjCyu5rUpUh1FX5lA9hwQGmTc0qXOoRGrGDFWkbVVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPDubkbMqgbcv/zjTjwGcmhEwYLX+bEDSLRIn9Ad+Dk=;
 b=iFf7PomxhYpohDz5jxnM6iJLjInaKc9kBSEH9X7pV6Fvk9NSuAV57iLi590+ho5YoPi8W+RauhVEKcmUh1ZF8NRp7ome5wbOlN95iyi4R3UK6kBN45cqp+kZD4ZkRoGfhBGKpcijZ2cGpY0iIFz3MdLRmxxKPg009yyNYuXDK/MlFmZ/t/f2dnKmZs99BDxn24HuYyznx0uWg2J1j+XrUer/GJKiD3Q2NaBbdOcNT8tE+t7dqgaQhxfDERj0KY7CD5ovr9c7YkzDcbn+3vtBIqwJquE6MUO0rq68sJWVpM+DjrSkAdMdUXm8suRBpoFv3kKX5+wMJKRr/DqKxx8Iww==
Received: from BN9PR03CA0093.namprd03.prod.outlook.com (2603:10b6:408:fd::8)
 by CH2PR12MB4117.namprd12.prod.outlook.com (2603:10b6:610:ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 00:56:01 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:408:fd:cafe::e9) by BN9PR03CA0093.outlook.office365.com
 (2603:10b6:408:fd::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Fri, 16 Aug 2024 00:56:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 00:56:00 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 17:55:43 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 17:55:43 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 15 Aug 2024 17:55:42 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v12 05/10] iommu/arm-smmu-v3: Make symbols public for CONFIG_TEGRA241_CMDQV
Date: Thu, 15 Aug 2024 17:55:26 -0700
Message-ID: <ce5463b8e25474c0a0aaeb93df3be2d0ee3ae3aa.1723754745.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723754745.git.nicolinc@nvidia.com>
References: <cover.1723754745.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|CH2PR12MB4117:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d7a2103-95c7-48da-bac6-08dcbd8e3294
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nZ2P4vV+TQmW4li1yU8Ji8W0oldU0Uh9/KapmqBzdL6G4oCGdDKPUtvOQxBn?=
 =?us-ascii?Q?O4K9SO3vRAKP3JmbTEUTxYS5Zx+Xp2NVRF2+ZiduYs9+5x4Fy453zMC72f3M?=
 =?us-ascii?Q?IWEtejweNO2AAWu0JJRM3On0gAUbLjdenZ6IdASwMXWjYGcBYQh6nG7IwkyW?=
 =?us-ascii?Q?tBIQ1Ejn6rSTHxaPfnGYanFU453XA47WQNyCyknwAiCF1vVvphiKBOew4gMa?=
 =?us-ascii?Q?ivsIGZNxKngX9zVCRa+wkgcG3ivqdHXuUbljgkdSG5m0Dez0ugagFSzyR+Ax?=
 =?us-ascii?Q?z/5a/kAgTTSiY6AXnrBHCQFF5GqihTJrhh8d68ZHCEHIiJC8dBw0riC9Ay2v?=
 =?us-ascii?Q?1KKYydiAmg5L6rBFdGibEuKKove7mW+Or1An8hhlF7qs+khHh40fALTmOZ+J?=
 =?us-ascii?Q?o6QKf4GEWZOwPYPiSHsT0RhG+jEcRZIA+e9D2NVnjKZi8aOFISkc1lifv3aJ?=
 =?us-ascii?Q?Sr08oMXRmKdxekiAbtVd3V8wGSpY7yQyIP3QbS17VaJZYy40stCEZDgYeWVP?=
 =?us-ascii?Q?5tZLR7g3Lbb0BSQATxsijuW15uZajq695hchePfG/lpFcDITV2jqBePyBerW?=
 =?us-ascii?Q?oNwZ6A8ZK8FriCgeu5IFN2oJqT8SYXyisgkQ/aMEyjh2TFz25k+lAlTmzaPu?=
 =?us-ascii?Q?hVPreVRZx/yBYRwuumBcU/eiySIuWd9wF/dtPXMrurlptany4vXGKUZ3obH5?=
 =?us-ascii?Q?ABzOw4vHfn+9v1n8JJ0i3QA9iJH54YjEH2GVWiJP4ptHi2fevxgYFLLIhcOb?=
 =?us-ascii?Q?fHpam4/e4n/e9Gnu8t/BM5/Fdg1iUkEQ47qLpS9Mm5Saf80jlhAxEFZEH1sG?=
 =?us-ascii?Q?9fC8/DE7ZMxdCHHHf+Avmiyz8MFE8J9A5KkF9QQR+rzTora2rOFrBExWGTIA?=
 =?us-ascii?Q?5cQMhC9QlD/3xVaZKF9aGAALHaUVGAx2Q3xsC94WTxKnBH+qREsRgNiT2RXQ?=
 =?us-ascii?Q?lgoEbkWJ0WUTgWZa3yWh8NTP9kUXwnbN2FWgrao56kWeXJGTXp5dw6P0Jind?=
 =?us-ascii?Q?rKzDeOZq3JM7VJizAGl0uk+E5gj/jQcgVy2nbvEcwAegR0qr2eelV0Uznhuv?=
 =?us-ascii?Q?EYeJq98yIyJF9FjiyQKCCQA5/dOxfma0rLtLq4tn55M8kDP9HTZB8A466L2n?=
 =?us-ascii?Q?RENgNfdemdEqgGrAnlxn7pqadyzUKLrwXCQEk3QsIDeGbTTHC78LnkrigXsZ?=
 =?us-ascii?Q?5lnig5LrpbDWsOIdGAfTaL7DywJawHExM1lZbEJe8uERrkigAbk8OKepkQ3B?=
 =?us-ascii?Q?7cS74V8QTpohLPWJ11VOY5JkJw9occUD7+4ncucpnfn2bL4IpCCIT5/J6DaO?=
 =?us-ascii?Q?/xAn5GY5r5YCQ6xdVT6Zy6XBYve1L7pTKcQVyHZbJPqzfLOWiUKbeZWgFeqP?=
 =?us-ascii?Q?is7pMOQLhadmeOQ3mhu00jzbW9Kde143h9EYgjdRa7S3bNyZYDsaCypwmIDJ?=
 =?us-ascii?Q?BzdkvcpNuLfeifBGwZXnCHq3rd2JsUsA?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 00:56:00.9350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d7a2103-95c7-48da-bac6-08dcbd8e3294
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4117

The symbols __arm_smmu_cmdq_skip_err(), arm_smmu_init_one_queue(), and
arm_smmu_cmdq_init() need to be used by the tegra241-cmdqv compilation
unit in a following patch.

Remove the static and put prototypes in the header.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 18 ++++++++----------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  9 +++++++++
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index e664c40b14ae..df1149095860 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -365,8 +365,8 @@ static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
 		  CMDQ_SYNC_1_MSIADDR_MASK;
 }
 
-static void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
-				     struct arm_smmu_cmdq *cmdq)
+void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
+			      struct arm_smmu_cmdq *cmdq)
 {
 	static const char * const cerror_str[] = {
 		[CMDQ_ERR_CERROR_NONE_IDX]	= "No error",
@@ -3512,12 +3512,10 @@ static struct iommu_dirty_ops arm_smmu_dirty_ops = {
 };
 
 /* Probing and initialisation functions */
-static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
-				   struct arm_smmu_queue *q,
-				   void __iomem *page,
-				   unsigned long prod_off,
-				   unsigned long cons_off,
-				   size_t dwords, const char *name)
+int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
+			    struct arm_smmu_queue *q, void __iomem *page,
+			    unsigned long prod_off, unsigned long cons_off,
+			    size_t dwords, const char *name)
 {
 	size_t qsz;
 
@@ -3555,8 +3553,8 @@ static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 	return 0;
 }
 
-static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
-			      struct arm_smmu_cmdq *cmdq)
+int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
+		       struct arm_smmu_cmdq *cmdq)
 {
 	unsigned int nents = 1 << cmdq->q.llq.max_n_shift;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 6c5739f6b90f..6c5dc2f10a33 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -813,6 +813,15 @@ void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
 int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
 			    unsigned long iova, size_t size);
 
+void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
+			      struct arm_smmu_cmdq *cmdq);
+int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
+			    struct arm_smmu_queue *q, void __iomem *page,
+			    unsigned long prod_off, unsigned long cons_off,
+			    size_t dwords, const char *name);
+int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
+		       struct arm_smmu_cmdq *cmdq);
+
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
 bool arm_smmu_master_sva_supported(struct arm_smmu_master *master);
-- 
2.43.0

