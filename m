Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9D27EF10
	for <iommu@lists.linux.dev>; Sun, 28 Jul 2024 22:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722206720; cv=fail; b=KS9TEUcige6nWiCBEfZ0b+BjIGw6csXxRo6yaBiJu+PSP1bSEP/+QHNKqALFynOUj4/hGH/DVOEV1R4XOBnwqoruFvvKwE1TF+RkVXcE0SZdV8Azv2aKhY7lgtesYZt2rGx3rOaw8kxqLiRVm+SNgXv/Qn6Gguk3kGq2AGvjWBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722206720; c=relaxed/simple;
	bh=dsAHJUbsGTPuiKCW7n7YR4iCllYos119LtCwFV/7rTQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tdO8gub+sdrsezjGBSEb9SGnTGOzsSYTrKU2DZwnqjioYAuUZFPmJ3vwChjTiVonMguBoH78Sxc+PrBJWPyxXRk6DRkmDYxJVDt4uzTLJqfL6ICLSweHd9K/5o2F+gTG6tiQEzqgNLnOLOFMJW99lUoZnQ7aTWXW2yo2RxK3pkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OQl1fZ9p; arc=fail smtp.client-ip=40.107.94.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OQl1fZ9p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQyxpGivdkkff0JFkjV/dm8cu/m9UmbEhp3qiVoti3e0Jr5MYx8LG3/S0J/OlnWaPq9f9uIxeI8Pnh298E1+3ymJYbTYkPbycpMoPzK1sUlGMl9XHHYD9vJc8qK/w0L3IsQSkqON4WpO1O32Gei6pEitKiP7MjpEF+hTKzlWS0F7CUjnb21pjinOuNcTkSs1Nm5dbO2hmF/eNwuBsGl0nwbFA1UGw5wCohAW3EgX6u3Allam3z4HBoFHwiUQTBKOXXnbek8isRfJIqO+hyF3Y1mvJxBzDSS8ZgZbi8+xdt/EUdj9BaMjnqGB/alXwHCxSYLjpr4eRYmVPLU0bFSF5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41SMbmXA1PL2XA4MRC3xrC1ZAH6GVqfqgvwuMEyz9rQ=;
 b=dD5tfNszxLV3fSRTtEAZtS9484jagSBL3l3TbRbP28Ljz0qP7hqesSMYs/9aJnRKi9wjfUiTfnDYKE3TleDzr2y4NP8E1gVVaUbxf6se2ReFQqNYck5u7NNQgZ7ShrYc+rZHjqsdDvZqlM+bh9TVKzo06pE9RGy0w9qL6l/dfPLtYB4XNSux0CEILfO9mTvMA41jYKxNbX7CPzp/WJ0XZbVxuDfrRaYf9uCaej+kP3HDlKO0i3nCfsg0MjWu8EC8pHnTc+r7fFCklHRhxnwlMacw/fs1XqPa4Jdpxqhir795cV1WSh0BHtRUtoehK0e/3v4XW/lZ3W3yBe9aSfkYGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41SMbmXA1PL2XA4MRC3xrC1ZAH6GVqfqgvwuMEyz9rQ=;
 b=OQl1fZ9pNTRhU/mvTJQAQw30csmZTd1Tx0C9OllOMbUEvnP9zrKMZQoBvuFBVmy5oNbHPdVTVTzrsbNNArvjWWSjXaptX6GXoQtyi9QHptbbRsgcShVjopIKWMpGIsu/0aqu6DHi0edpG1eVMbcCJTMKmi74xYyUAInf6csl4AZ2sfKazNdyCMWgy6/IfUIJ50VUlVyzRQjo7GOx+kyB6B54r8Itjv++LR7087Mtz1v9gdgugN/IegGxmePzIvPZlD4rlUB5yMgAps3+tfFO5cbteXXdB1rjfgj5ghXroQyUbBKy0t/VdG2QUabk2xqEbee7s+T0jdI+5JtAYWAr5Q==
Received: from BL1PR13CA0189.namprd13.prod.outlook.com (2603:10b6:208:2be::14)
 by SA1PR12MB8162.namprd12.prod.outlook.com (2603:10b6:806:33a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.26; Sun, 28 Jul
 2024 22:45:14 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:208:2be:cafe::26) by BL1PR13CA0189.outlook.office365.com
 (2603:10b6:208:2be::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.14 via Frontend
 Transport; Sun, 28 Jul 2024 22:45:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.11 via Frontend Transport; Sun, 28 Jul 2024 22:45:13 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 28 Jul
 2024 15:45:07 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 28 Jul
 2024 15:45:06 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 28 Jul 2024 15:45:05 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v10 5/9] iommu/arm-smmu-v3: Make symbols public for CONFIG_TEGRA241_CMDQV
Date: Sun, 28 Jul 2024 15:44:50 -0700
Message-ID: <294090fe478aa8beac1f3de741d828c8e63e0522.1722206275.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1722206275.git.nicolinc@nvidia.com>
References: <cover.1722206275.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|SA1PR12MB8162:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f05b073-d8d5-48a6-c83a-08dcaf56f1c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hHvk4VtN04tCsxdq9WpY7x26qchYOVg6ritaUwqYVIKoRW9Hk1XR2wCsBidl?=
 =?us-ascii?Q?3hLP9j6Uqa5g6sahkshQKbAOTEAz2LDb/PRRBOaox8zNHKked92/ILUsHVV7?=
 =?us-ascii?Q?qj4zzfzK5tRAQDP3lFagAhATH1AUhwtNOqAqy7Eh1joBmPfr0VXnI5wzOnl6?=
 =?us-ascii?Q?9fq9cK23717jawfS8RUseF9hPrG3u0db8/OadBKmG++HJ0Jux7TStLWIbp/m?=
 =?us-ascii?Q?n69j8NtiiQCwBYzNpvKez+BwripmefDd+QAjEpL5+4HT3knpMV7cuLlCa6Ud?=
 =?us-ascii?Q?NFfdFF/DrfLr+o/JQ/7ZWSkMlY9foUT1EhvdXxXQLGZidA0GflBoYkn2sQQX?=
 =?us-ascii?Q?wzwdklvjXfPPT8SiH9USj1pExefszBW0SSfZH1yVjxBQTRI3k+YHMvoFdr0a?=
 =?us-ascii?Q?DvFWbW+ljJSADRMDDBZGlmlWV+do0euAmaJauMOUZEkZN2LfwX4uO/rAPFTQ?=
 =?us-ascii?Q?sHU8HDYncuuMd4dDAJos2tJrn5SZPo/ekW77pLUsUf6bfFz7HjFtkWOLEaem?=
 =?us-ascii?Q?myB5jn5q1Z5x54Q1NtJdimwUcrARU57SrsNayhUB1xj7xpntydoCbUXM+omK?=
 =?us-ascii?Q?PqFFX+YJgWykmq+KYsqGFQImXkL6Jn7rq3WIZSPHtEa++Y7LBDvIxhrgUI9v?=
 =?us-ascii?Q?L4Gub5PNP9wfNlBwtWg0Zks/JSvJCFLd/R97sGh81gu9zvxmks4JmOaL6mZX?=
 =?us-ascii?Q?pFOBAOSSnnoJYgc7xFGEyP5Av/ykImABOoWC+D0Bq8OusbfEPKE7QxFTQz1J?=
 =?us-ascii?Q?xi7NkF6pwtWq+G437jg1c1wJwm7uqAcsYJg9iAolzHBIuBC0ElAHEbH6doE3?=
 =?us-ascii?Q?+cOqkwtcJzpI0ntWok2bHikvYzAGEvH1sKoKpMCwWQojY2cfr+f+mqIdUVnW?=
 =?us-ascii?Q?ZCOamLtlABKrz1Tv6yFWTgwB6PBwYkKp4egevSSnUu8YnhYzIOFM6Dk9VT10?=
 =?us-ascii?Q?ktIBv2SwQalv+TWrX/DKIuDNyxiy3aDSrP8ZKdYoXYT5nc9ufPeyPIOLCki7?=
 =?us-ascii?Q?0QWdUS55h/nf14NsRUncN/PsN0R1lKQaBlwVP/nVd/gdvYSC0C1lmMbiRJ3P?=
 =?us-ascii?Q?JQfSgjeIU6nYQPi04bJh1agFEv/iaAWiec594Rrj7wf5DotftrByx3u9lURu?=
 =?us-ascii?Q?Ih1TSF8jlrqFSFv8269lEV1Infx0n3xUAiW8i2cbKyMXUkg+JaCpF59P76F/?=
 =?us-ascii?Q?Fbe1Ts9Qo7kMgEY6CzGemBLjsGpxiUVMwbNHRu6SqMvbu/R2yWPiZIPcMOG4?=
 =?us-ascii?Q?+EU6FN8m/D0MSI8e+q1oMpBcjUzn576E5LA7e70N7XGmqYHAqwLoMIQmExxG?=
 =?us-ascii?Q?YeT8F1s197FOVOhdF/p6XO7hYhAGFk0APsNCosUcaardzXbAG7Mpvoo+Hqn1?=
 =?us-ascii?Q?sX8ssK9OSDAO/8op+OZ/nUwzmB0yjqO8gWNduytz2rkCz3knyA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2024 22:45:13.6252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f05b073-d8d5-48a6-c83a-08dcaf56f1c8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8162

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
index e664c40b14aee..df11490958606 100644
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
index 6c5739f6b90f5..6c5dc2f10a330 100644
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

