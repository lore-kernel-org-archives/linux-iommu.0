Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7042C18FDC9
	for <iommu@lists.linux.dev>; Wed,  7 Aug 2024 02:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722996743; cv=fail; b=O6RzM9NL9srRTPdcdDKIH1/OJoSogBJODmqsOncVQFsWmSA1LbrY59+XCppi71eZmI8vKc2FoynpshpIs3B/ZCsmLHgTmEo+A9WuO1fkmAgvu/oG8UdCENXx4FVNw11msEbCtPzw0+WZYDcWFwUXno8RQ3PHsCUdxGZXCfbnIyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722996743; c=relaxed/simple;
	bh=05h5kmXHey6y+aGU2U4EsCITU6D1QD6cGbX2bcb4Ui4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nxz0b4L82Rr3XW59PUnusQX5sELaHRf9fioFT7yHp5N8/NZCGRqtUM/jIVBbEcuWLQSM4elkPVpwLGgxvKTl80yryODz7Kbg3Aygv2EsJzXJypaBl9A4eKdu5Z6b8mQmIO4yL4HRuZ8kO+oxSCFKrFEO/ceFerHbJ8GvKAeHV+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AZW1ZgOQ; arc=fail smtp.client-ip=40.107.93.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AZW1ZgOQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/5O7WAmn4YDihHnd96LP9XZmN1wrpLOJEfZGSmRVazU4XFoxS0j63FRh+TWiHTb7DCADyue0VAe3S4KOj0VG2dTcKUCJbNNmCcHNKSc6OufmMER8vhLPIh00QvtaL6HsDHvvCoHPvpDziJj3M8YVr3Y26OdDgJXWkJSfMbacquOjUaGwkXWLSyVoN3womaiKpKgzipxBBzoM+pXMMA4nUs1NkZACmgNx9ciUNkqs3hVuM0erK+PVKI1pk1qn1bXcwsPVG3pqzc8Dgtu1FLsGvRZ10GQsYLRHFQo+Q1XmJruuoXKByw05b4OW2cp/CowS14GcbiUoiUHHNK/ZOV5JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPDubkbMqgbcv/zjTjwGcmhEwYLX+bEDSLRIn9Ad+Dk=;
 b=DWyx7TFafzsyVIqRqhS3qg3b12TzW7Tv+aVijm9KQuXc0zPL9GxWDB2JNX67i5AxiVr+hACSi9cix/ZPe/isItIp02KALV+amYsVhGA5cqkCRlOixgqByAwszUJT+TNHtURox6Um+CwX0pEHtiBeHX7aShihtLnOZKHMtojV/wHc2yN82CltikZ9REYFoEgdeJ7mUjWpOboSqSf86t9od/iA61GkB5CaIaYM4HsVzEwo0xzqhG3XzPhcGAtFwRYo69S/aPNIXSdnP0OcLCKvXUqXYYqVfae/RDjdOQEHs/rmrvUAlOh6+VJOKtepKcxCnR+tUBPQZOAU+H8s+C1TdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPDubkbMqgbcv/zjTjwGcmhEwYLX+bEDSLRIn9Ad+Dk=;
 b=AZW1ZgOQB97E8rHtp/daKWS4cggiIctdjWkD3YbNOCCYJ1SX5b4McQXHqtITDecYXl+V1RqBcI3yuRki3xRW8JiHBouOMswM6Llk3AB3iP0R60xhzcvn1faxtB94Q+DsPYhqWqPTzeyVSaJMSBgJgk2Waq5pDXbbUUcEPOiZJrzKY3UxumRKcm9F14VvBybdThpmz9LskY4IrNNZXtttTmRuqXuCrpINJNT2qLW+NZ2t1dB3ZWu+8q8v8Cvi3CMW5nSA7qDo+LO5SDn9s64iB+CkncBHx6IveFF8w0oOdW7JIlarb5ViVk5SQsfCcDmB7GiEvLjIfcDAK2fryaHUpA==
Received: from PH0PR07CA0019.namprd07.prod.outlook.com (2603:10b6:510:5::24)
 by CY8PR12MB7147.namprd12.prod.outlook.com (2603:10b6:930:5d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.34; Wed, 7 Aug
 2024 02:12:18 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:510:5:cafe::20) by PH0PR07CA0019.outlook.office365.com
 (2603:10b6:510:5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27 via Frontend
 Transport; Wed, 7 Aug 2024 02:12:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Wed, 7 Aug 2024 02:12:18 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 Aug 2024
 19:12:03 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 Aug 2024
 19:12:03 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 6 Aug 2024 19:12:02 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v11 5/9] iommu/arm-smmu-v3: Make symbols public for CONFIG_TEGRA241_CMDQV
Date: Tue, 6 Aug 2024 19:11:50 -0700
Message-ID: <1972ecc4d24189a055728609f130430b1e1cdd75.1722993435.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1722993435.git.nicolinc@nvidia.com>
References: <cover.1722993435.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|CY8PR12MB7147:EE_
X-MS-Office365-Filtering-Correlation-Id: e68ec2b8-d20a-4806-8042-08dcb6865d05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8Hf3sQxKEgWpBZoakR9BNY2YQurhvSuDBM35UOyHrKlti3C29tAHAeIsNt3O?=
 =?us-ascii?Q?phZTjm4ddypx3xAkVRyzQa7JlCiUMJox+j38YOQGVHVEg2kXaTSqURCQc6/e?=
 =?us-ascii?Q?zvItNP9LADhE1ndmg0E1Vv0unS1CDu04JzZdEo4fdD0uSU7xJ9Zf49z4b6V9?=
 =?us-ascii?Q?sOVW6rEKoXzemcyiD8o1rB5hOHD7xfoIUrxni/eutNkMLS43RJo+de/aOImO?=
 =?us-ascii?Q?RXxZaQXXpi+t8LAlauS+jvfvYjKIKr6F3mzhkH/Y63autPSFN71T/vab1L7o?=
 =?us-ascii?Q?7aKrjHG8ocHmLAK3t3EQT85WWDDShaLA5CuM7WylPZn591GjECJRtmpVSZCv?=
 =?us-ascii?Q?BfkEs24EjGnUxfSLUI+AtRI80NiN12S3j4/RwjjsrNeClUXaSp6MbXE6kyWs?=
 =?us-ascii?Q?XvYpkMMjLN8bd4wNnwP/NExm+o0NG5ZKIinwwbc5okUwCRppIfKDfTbfZYo3?=
 =?us-ascii?Q?Nt/Xy8IfAL+r8Lwe4n7ZMP5ARpU6c5fnA5wrP1f5LGZUJjyNT6Rd73uNv6pf?=
 =?us-ascii?Q?klopDOmv9wTBf+R+jyndQz8YrkytA4d3VHJkITE7WCe2Zc7W3aUsZFVfKtBt?=
 =?us-ascii?Q?hcOzIR7d4pR9An99lIb+0wzvMT+lA+bb+jxXyU3UAgi8bhokITWOamfbMtfY?=
 =?us-ascii?Q?sXUpN3GaaALIhM9Q4yg0Nyg8i6PC7sN2TbyDTEZImrtcm5+R/eyZgiZBC/1s?=
 =?us-ascii?Q?AT/3Nuz7ReN3itQVzBig7aIypxToDHRpbwQk+9KL42OBz3CgkT1RQ0tK2bNc?=
 =?us-ascii?Q?HYciLAaITAMN1xXY6JtVP5mKgZg58ZCQo9MFcHsWZuKYs4PyCZ8ZAi/bpPWO?=
 =?us-ascii?Q?bo185/YtXmMxvyyjvwF9pX4yjUBObHeBk3qr5SA5GtYWDnVeV/knZjLoEPAi?=
 =?us-ascii?Q?go7rTH9rkBxkFAx0btYeMfL+s5ejiowhJbqFx+qzXrztm2rJACZRsBTTE2tQ?=
 =?us-ascii?Q?tqsh52snSA8SEtIDdghwj5neLJP/hUigFBK6LjlEclPX7kSzegnB6XkbNapV?=
 =?us-ascii?Q?DVcy8uWBIGxeBtm5t0ChQUWDFgMyYwOXnyjTCYEZ4UHISVS0TdwKf8/7db74?=
 =?us-ascii?Q?gu6FAWxYSXrkUdryk3g6CmpRJmnDd8Kocc+n/sDw/6VxKCkB8+2/bAJdiQ+F?=
 =?us-ascii?Q?CJVqHhNljyV/yZ/6uRuOBa/ZXy8QWa8ceD9fQEoSHeF0PHNNe7WvHkuQdcQg?=
 =?us-ascii?Q?lSbk+2noA94SbpW1JSOjnUdmrUxh8+Kda016Q9kiVgU1G6DxCt+dSFxegoaW?=
 =?us-ascii?Q?xQlDdKr4GTbU4NnPHnvVOJhNSbGRHWJ7J1QzhaWjxrgWUK6nqbAh67nhjUN+?=
 =?us-ascii?Q?pTUJabDecaOvDdrBJDdLpVuKBNpkm2MCneRx6H5q43TvqdNGRb1hT1cs96Zt?=
 =?us-ascii?Q?+UzWqZ4ZJA/Wq9hwY1QTybxL+GSSmNcIOs/HpHzO8xBEuF6aqLY/rpEmZWE0?=
 =?us-ascii?Q?NGhnRBDiGHZfdNIunNWt3XrvAvh/c9hZ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 02:12:18.0875
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e68ec2b8-d20a-4806-8042-08dcb6865d05
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7147

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

