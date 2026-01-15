Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011042.outbound.protection.outlook.com [52.101.52.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8842D839C
	for <iommu@lists.linux.dev>; Thu, 15 Jan 2026 06:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768457361; cv=fail; b=nsLGZQQ7Lln9rQu3dCjjHATh4Q4cyMF8Kl/9NjBuk/gCWC3V7ize7KVIm3nv1a6dQNYdVsBdWryt6Nctn7rrVPhPjj8PZ9lSaYjgeZ8J8PbCSKmRzLlIAhtQNkXGAQOR9xLl7RToCsMUlE37VIPrq/ZzG991DHYsBpAqgy1od2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768457361; c=relaxed/simple;
	bh=EJJgtUoCKj6FhyMVkQTa1AGYFjX+NIDYWgv1lqoTy+c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FlpxoKp+k9zn7TqeVfhnAPT//fc/f8pFpScy0WXidlVvGCEnFhaPPl23Ld3wamMGpCm9S0/5O4l9T6naJyeI5iqAdpDGNgNOPjQo24tXMSfesUCrwPQDwvG6lMqeeewm87XW2GhDwTz2ChwFdvMNNEFlVqjn9iHKEpGKe+jhj/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=470R9TJF; arc=fail smtp.client-ip=52.101.52.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="470R9TJF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c6Dxm+22IjEKAvoT0OwEouFDyFGCvvsAIa1N5NU1G3s1b74+7LDTWJBkQgTuZ3KNw6FaBmTgRiXS3hLO0qO4b+tM8YLBdrWdqN9dc4SYfXIRqMPpJ1QjOzT1YRdi/kPgy59CoDxooXie84KpUAQAPlnuV2SdaChFujXfcLx2qNjhj/jXv743GJXbmeQYGgQJLDoJ4sM/Q3FIIKd2NMC29aAQyyQcDayJ58BvOQuLQpOAFNXhSS9R7B8MotfFmgD0aMBzUBGApWvXEcBMLy/3jKYGKOt/SD43oZ/2VKyuFYOqX0vVZ1uM3ocVzSsUkLZk551jXjJBq5XNqVxJ8Uxlqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PK53GPvKI6mUiT/N+CgLS/T7xXZIp5miW5Z7f+uxhb8=;
 b=QPk+aKmItYgjBDyxGwWupb4bTeWm6KI/Rmlr4F/Vo41DNtF0PCXb02rBvCzo9w/VT8UfqVc1YJWOm3ZjvpNQwXu2/j8H8ewAmfHNKT6aUdbWzm7X7gi9fI321FU4wbbK4dDrvke7qbvYXu7Y7XNzjzKVntloHPauFkvEHemwb7+A5N/mywRJReqOtNPX7pFjr6Tpj2A5BwN6BNC2lDal8BCuslpQUq3UY3pbKWirLD5AaXcYORaW4HrHcWyk0p22iL5OqOj7pWHRaiXpyZtDvYYrjHdlJ6Q82imO0LsQyeCUsJ6KmAIHGTYfm/1WmoYgUbTM4WXTGRDJBMb4tYyZZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PK53GPvKI6mUiT/N+CgLS/T7xXZIp5miW5Z7f+uxhb8=;
 b=470R9TJF/+c4UVezg+ZYWorjIn9I87DGxDS182CaJrRnEQSxgWI/dlUGt0T9LwzYSNRJuTt+aGJ0FerJ7y1qcthALeiPNEHmJcX0piAqUCQVqZ29KZuPUSBwoWFz0/IXhSTPfE+YY6ic6LGXl4a/5wRhSEvDcu43HEaywwMCgbA=
Received: from SN1PR12CA0050.namprd12.prod.outlook.com (2603:10b6:802:20::21)
 by CH1PPFC908D89D1.namprd12.prod.outlook.com (2603:10b6:61f:fc00::623) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 06:09:10 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:802:20:cafe::9b) by SN1PR12CA0050.outlook.office365.com
 (2603:10b6:802:20::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Thu,
 15 Jan 2026 06:09:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 15 Jan 2026 06:09:10 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 15 Jan
 2026 00:09:04 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <jgg@nvidia.com>, <nicolinc@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>, <will@kernel.org>,
	<joro@8bytes.org>, <kevin.tian@intel.com>, <jsnitsel@redhat.com>,
	<vasant.hegde@amd.com>, <iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v6 06/13] iommu/amd: Always enable GCR3TRPMode when supported.
Date: Thu, 15 Jan 2026 06:08:07 +0000
Message-ID: <20260115060814.10692-7-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260115060814.10692-1-suravee.suthikulpanit@amd.com>
References: <20260115060814.10692-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|CH1PPFC908D89D1:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ce2c90d-db76-46a5-2a82-08de53fc9970
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TMTKDSvihp6GQ9scjyqzQo6nDUrxQJZ5LEWkOACL7K2cH6OWBWF6RfnlGkgQ?=
 =?us-ascii?Q?0k5ae8a5kDrcQ3HCUEsoCkPcyeySmma6gWxx83Gr+QV4HmqNDU7J3dO2cpF0?=
 =?us-ascii?Q?2vE/JU1YlcQkGrbL60cT1A/bTsjz4gV7uzWfxCLQlU4MpEc1kZjGr88IgTbR?=
 =?us-ascii?Q?5EEuNYniQ2aT0TaHmNn5PMsTBdhBD1NY6T8kJYRX8gHoew7oCUbgdz70qRoU?=
 =?us-ascii?Q?R45yh1UbqyoTCjlk/7/iz4Fbhx0w2ZI0QrhxSOAI3ZFJkmnoFHM91zf0ZIwB?=
 =?us-ascii?Q?wWIihVVIWfrh52yi1Fr9saPeRcx3o0jQ96/XnAdQ8tuhITnpwJ/MD14KOhtQ?=
 =?us-ascii?Q?ZwWCh/qJEs9o2tu9WW0b1gnQgegfW8yKZ91j934FZbLMeNuWJQaUB3nDUdgc?=
 =?us-ascii?Q?/o0LOT6Vii3LQlg+RdkKfT1QpOv51b/oBNPIfcpZxTYByFrnyzY1L/3nB0tm?=
 =?us-ascii?Q?3eOQQd/nMRJtl9pmtOdwi6MYMd4NIErIOD4+5hWPhAYwIYmHLOs0xRUV6zeZ?=
 =?us-ascii?Q?bQ7qG2S9XESh9yIgWVgkJH6HkFr3UuwUOcR+CrYUtus9VkvIu9GxlZXzWA+c?=
 =?us-ascii?Q?Y4jbEeSpW2SrQD2HOQjXgLpIaCbXNUc3S53nYMMjIJOU0PVBUgZTxlmj21IE?=
 =?us-ascii?Q?aFBOdNz24L3IoqnNnLn+TGO0pom+OLPtLmMVD26A1A7jkZQewsM0jLodWSN4?=
 =?us-ascii?Q?dXpGNeA6140VsUD6IJmnjsBxgnGjJ2eCroEDra6dUWMFYV499FVirDAjYpgw?=
 =?us-ascii?Q?qzu79/2g/h7XDm5xzakA4MyjN0raekOU05pKe0E1Nw88CKP1zHr0nndDVdvc?=
 =?us-ascii?Q?f0u3vfdSMHMIqeEpJu150cL5c3CQKwesPb1TWMV7NsXPbtiphPeeFaKsGT+K?=
 =?us-ascii?Q?9LU7NbalTxc1KMdH2UUIeh4xTS+TN5F9Fm0YgceAnFbf/8/qdSE2cEm7JgRG?=
 =?us-ascii?Q?bvxnP2fxbAwWm5CceYaedNTCFN0O+f+t7uxweB1Gq3RVMTjS268DQNHfVH9G?=
 =?us-ascii?Q?JaZ1NY5OqHpZJnd3LovUbmOVgZ6AoVupfyy700DT2MjYUXq3S/UPZa09pJ4+?=
 =?us-ascii?Q?LzsMQipWXguGM/2zv/cPkpp/kkGG9f3/vVwK6luHhkfjqBxcMYC/DxqvWz75?=
 =?us-ascii?Q?8nuszTPt/J3UDeCqgTuvPLM+MHMf8BwsUWnhTPLL3rHS7FxQAtjt28EF47Zc?=
 =?us-ascii?Q?utAG0g/xsDiXzHvvdVYoKIod0Vfm5YeS4wIp8/eX7bfDSax9N5wBByW1B8ey?=
 =?us-ascii?Q?ZCJZ3GOEhbc1oOMcXByzEDLtiwaZ99LH4nVMu9YyP5MHnLOD20Andtu7cSc5?=
 =?us-ascii?Q?PSwVtcIcgZL2R4i3az5bu+TAUbyQ7lDqwaYAc1OVf9DwOFLkp/DJH3OkseaQ?=
 =?us-ascii?Q?hPWl3mYgpbZdSwiLl5XHL151oAWL7/15b5QFrNPkiXkwkQPc8t9xbj5XghpV?=
 =?us-ascii?Q?p0m5LgmMMMwP3UdCNEwa8qAFGGKitpiMjTNhL82l9NpteQE7/HitqSJ2F6Lo?=
 =?us-ascii?Q?t8wgQccuIUNN5pc20bO4CUd4lE+47HdQM6f5eC9g7qo1ajKS2o7X2ZV6jHRp?=
 =?us-ascii?Q?w5/jlPhNQNeowzIMw5ajjYWvFe3FAW3TKK3t79Hgajy3rJkzrITbakwXRMK9?=
 =?us-ascii?Q?jN9cHQg1bX3046GBbraydI3Dwznn8ZEBlu411zZBSXjH?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 06:09:10.3608
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce2c90d-db76-46a5-2a82-08de53fc9970
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC908D89D1

The GCR3TRPMode feature allows the DTE[GCR3TRP] field to be configured
with GPA (instead of SPA). This simplifies the implementation, and is
a pre-requisite for nested translation support.

Therefore, always enable this feature if available.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 2 ++
 drivers/iommu/amd/init.c            | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 14801d734684..d8753841cd1f 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -108,6 +108,7 @@
 
 /* Extended Feature 2 Bits */
 #define FEATURE_SEVSNPIO_SUP	BIT_ULL(1)
+#define FEATURE_GCR3TRPMODE	BIT_ULL(3)
 #define FEATURE_SNPAVICSUP	GENMASK_ULL(7, 5)
 #define FEATURE_SNPAVICSUP_GAM(x) \
 	(FIELD_GET(FEATURE_SNPAVICSUP, x) == 0x1)
@@ -186,6 +187,7 @@
 #define CONTROL_EPH_EN		45
 #define CONTROL_XT_EN		50
 #define CONTROL_INTCAPXT_EN	51
+#define CONTROL_GCR3TRPMODE	58
 #define CONTROL_IRTCACHEDIS	59
 #define CONTROL_SNPAVIC_EN	61
 
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index cfbc9ff105c3..b1c344ed7dbd 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1122,6 +1122,14 @@ static void iommu_enable_gt(struct amd_iommu *iommu)
 		return;
 
 	iommu_feature_enable(iommu, CONTROL_GT_EN);
+
+	/*
+	 * This feature needs to be enabled prior to a call
+	 * to iommu_snp_enable(). Since this function is called
+	 * in early_enable_iommu(), it is safe to enable here.
+	 */
+	if (check_feature2(FEATURE_GCR3TRPMODE))
+		iommu_feature_enable(iommu, CONTROL_GCR3TRPMODE);
 }
 
 /* sets a specific bit in the device table entry. */
-- 
2.34.1

