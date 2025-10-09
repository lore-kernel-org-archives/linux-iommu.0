Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010040.outbound.protection.outlook.com [52.101.193.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E4428E571
	for <iommu@lists.linux.dev>; Thu,  9 Oct 2025 23:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760054352; cv=fail; b=tOiX/3J8AJrrRRPb8k5kMqn4koTjA9ZP4hDd1tMTP3Dz56b6LPK6xngr4nzVP98SuYhaNhfhrMo6zDyozQapjLCgFLBBQKQGc/CX0VwxaixSq12SIyChfCRz73OhKOP0AsbCXj4vztecdZE84GD4rwUhUBptq8zXnuojrY6ywnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760054352; c=relaxed/simple;
	bh=85LSuVESoVvXqgYw+uwK/Q6KK8sQFgdHnRB4FxHa9R4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tTaS5FldVkzG5MtC5ucU+VjHrZKb6+C98SOcUKB8wtCsflSBo/Str8DXR9l/ql8TEttEuCUmef1zUzeuwcez/EnVODTiTSujrkSGXdN9rCBvTFEluPYvoIDAXYasOJFMS7q5mb4TsOEF1w/mjM0uADUhlPT1gndBaJ5QP6542h4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Gvjmt9bL; arc=fail smtp.client-ip=52.101.193.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Gvjmt9bL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+1GiuD6fiwhjMT/q0cHHLQkLBvPRDvRXjAPUyVvkdwYLyrZjXR8pOCreg7Km+HlI0cPMciMYInVbiLdG84M8RB1Nkj8Fy+kw2b/T9sD0BlB+JFeS6EhmPo5AfT2Xi2lvV+JD8bQJac1VR1BfKoUJs6FUgoNdorNqIpN11m2ynaR8pCBulWvY2IRO/55yrzuHAkQaND38XaatrE7xTnh7xpgmQikKKumCkGd0KKvnr0wCWMmm4rQzt/OhpLDdBvwSUeNdYXiKfqMdfDCPlZIQir8dbuyespqW+zhyos1kLUAiHbh04u+0hJEu5YKmoOejxCZVrqCo19epc26siMCVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njQFmJ3FvbhKuEhnbs9S+Ncl1ubyom44WTRQmyzozWk=;
 b=M6N5Pn0P3fGKBwW0T1wrG1CFRpkKCJr2XQeQa/XvWmTGo1YeNt+D+2vPtl6N0mWoFuyn0xx+LoX6vxfLXeEfncMYeKXRzxd0QvoGGGnS22+2EgfDARWisnsw+awDyI3NoGmPnlaq/WntnmWhGmr2aXrOG6RK51e/mUCrgsb5fpRODopOuAbSOP19M6A3r66Qv1qgPB/o5pI+7WoKX7z4lCp0eMEeymO9QIQB7HoiCy+DQ2ALGXRGZMby51FEkB6rhRKoYaYX4+gOaubjK8koVO+PqQvvYE4sF5ks0T5w39mZA3o2YOQclA5lOyloGv2Vrym+rZxuedo6IjWlCGGNjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njQFmJ3FvbhKuEhnbs9S+Ncl1ubyom44WTRQmyzozWk=;
 b=Gvjmt9bLDa6hiVz2ZWNvKFwaK5LnUyN7ZEujXs2VCJSqBeQoXr6BfbpjCSWz9pfjjwaEB6dzjeL8RVnr9WFpCbVrAfxstYXLYpZKfRkMsLVPg7pHa8nOnP43lDCiOENjVnjcDLZcGTvQdVYxpKEq+ZkOh+K6PzzEPklSLqO7JLw=
Received: from CH2PR03CA0007.namprd03.prod.outlook.com (2603:10b6:610:59::17)
 by MN2PR12MB4158.namprd12.prod.outlook.com (2603:10b6:208:15f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 23:59:04 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::48) by CH2PR03CA0007.outlook.office365.com
 (2603:10b6:610:59::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Thu,
 9 Oct 2025 23:59:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 23:59:04 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Oct
 2025 16:58:58 -0700
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
Subject: [PATCH v3 09/15] iommu/amd: Always enable GCR3TRPMode when supported.
Date: Thu, 9 Oct 2025 23:57:49 +0000
Message-ID: <20251009235755.4497-10-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251009235755.4497-1-suravee.suthikulpanit@amd.com>
References: <20251009235755.4497-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|MN2PR12MB4158:EE_
X-MS-Office365-Filtering-Correlation-Id: 10ffeeb1-6eb4-4dbe-afa3-08de078fd39a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c/4lRpQft1XrvNj8I82Owj8YvymBP9GNKEumYWnipN67lD7hEYdFejA7X/02?=
 =?us-ascii?Q?ZhH7WhyPc2YUy05wzkl6Bx+SHyjzu1K9Gibb6Az6Ov4hDCBnc2SepLGHgCaT?=
 =?us-ascii?Q?+n93PqzJWRRdYA57cF7w71YqRblkjHOFpgBdkAG+jrtutz44diSr9Vq5pPOE?=
 =?us-ascii?Q?3CNWjDyjK2GgZ6sAcknz+xaITjSmdagu4TT0DnCf/tZFuUQ2rc8N2cwbuuyS?=
 =?us-ascii?Q?HwoqO368fP3eGnApP50hNeQDlS1hq10R24rAFsDIJKc2odP3cYUz5ojJ5tVM?=
 =?us-ascii?Q?NfXBCYkqg3a+1FzsTdW0ysY8TtUBQpfJPB+Lve4Y4iSMDjVJ1XwRVcoYcV8q?=
 =?us-ascii?Q?ms7oaErJpigXQC0En8uKMf+0C+32zSq3aH73B9TmilK/EH6cSYMd76TJLg9X?=
 =?us-ascii?Q?Xw+c634slTTdSALlCNxV+7xIczl3TTShd+NA4lnjnTdO2B5Tt6+Y6iadCo+k?=
 =?us-ascii?Q?O/P9owWggrZ6IRuXg1SrI1Tn/5sSFpD8SejCD6GqlGBLFyeKup3w8lwYUNI2?=
 =?us-ascii?Q?ryTibYQddT7IEoo+vdLmE14EC41J5eDaDA6J36KWA+Uqbov5iqZ9WFGxhd7Q?=
 =?us-ascii?Q?+8jy23D5on8u+LpK2DN7vojWkSFlW+XHH65fCLgedK6/otC413GZ7wQaQLMV?=
 =?us-ascii?Q?7/TkDRj9z00uiCdKmsFJ1DBoY4Htd0A2Z9uJ9mzVqh8wG3gihqMA/KwYpAol?=
 =?us-ascii?Q?MVijbuxFnocnWfDBX9PMEzY3Fa2GcFn0h+Vr+6sYWwJgHk8f+vqpukoqujoZ?=
 =?us-ascii?Q?Zdht/M5UAuwQOF9KWL+5/SO0pV8dcarEqlkyl/jQDt7xX/HVeqvbCTfiH/30?=
 =?us-ascii?Q?5vtQcWz1Qy0YNN2sZ5chUK8qOcnLQD9W8QVAGL/oIWs1DAlGpMISdYe1YIxl?=
 =?us-ascii?Q?A61eZcbe2kau+l8+/IhgGGZLcmc9HN4WsjT1zbPMQaL9sdCo4rneryNHEoj0?=
 =?us-ascii?Q?CH/okjoz1PA0+kqo5HIMCVJ07gjLxnNkasKo6OwXfNwJLwpPbrvmxtyYOln8?=
 =?us-ascii?Q?LkMsYogKUBVp2Rh2+NltCzAgCU3ttfeIWyKmtrCgRSos+R9hDI4d7hPji7t6?=
 =?us-ascii?Q?grBHTycsYmnT/Iam7mRMneoOlugbPKOgFhyu4LkpVaPEyUXlS31KKiAxZJ/B?=
 =?us-ascii?Q?Vy9Pe7PllGPbNybzre81wZjb+CdU8yEws3iRGJC32jnDn1QfMnAbAVF6FWl3?=
 =?us-ascii?Q?r5h0i6gtEQqwN0i0+ipwUJpHsVwHL3FgCwTpRgKx1K5wNog5vykMzdPN32PL?=
 =?us-ascii?Q?N8epPd0u7GAh//BZnUxOCyZaCWc2SugrVl4KzuEZUkSHM4gdFJoGAskZQsiq?=
 =?us-ascii?Q?/a5gPcx4lCDlO+NXM8AqwEaWLbR4GRnbWZ6vyRNBKG9YO5BFCAnDJevMKGAQ?=
 =?us-ascii?Q?HHIbm8Mpi5QhBjp5r5C8hHrWaIqAdHLKxXS4kJFbkQWSkyEjGorgS285RQLM?=
 =?us-ascii?Q?CgXu9XNR/ZkikdlfktaCO9dyr1HmIyRBb7t+RYTJDLEDVFePLEXVAJmTLYwv?=
 =?us-ascii?Q?s7kTZvpJFWWGHUR5aNrV0jSnunrB0ZaDvUgwhSzI2zige1djejP4b1hhfJxL?=
 =?us-ascii?Q?fhb+m9nS2VI429TRAsQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 23:59:04.4232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ffeeb1-6eb4-4dbe-afa3-08de078fd39a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4158

The GCR3TRPMode feature allows the DTE[GCR3TRP] field to be configured
with GPA (instead of SPA). This simplifies the implementation, and is
a pre-requisite for nested translation support.

Therefore, always enable this feature if available.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 1 +
 drivers/iommu/amd/init.c            | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 556f1df32d53..9226edd8af69 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -185,6 +185,7 @@
 #define CONTROL_EPH_EN		45
 #define CONTROL_XT_EN		50
 #define CONTROL_INTCAPXT_EN	51
+#define CONTROL_GCR3TRPMODE	58
 #define CONTROL_IRTCACHEDIS	59
 #define CONTROL_SNPAVIC_EN	61
 
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index f2991c11867c..c45a4bd89569 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1122,6 +1122,9 @@ static void iommu_enable_gt(struct amd_iommu *iommu)
 		return;
 
 	iommu_feature_enable(iommu, CONTROL_GT_EN);
+
+	if (check_feature2(FEATURE_GCR3TRPMODE))
+		iommu_feature_enable(iommu, CONTROL_GCR3TRPMODE);
 }
 
 /* sets a specific bit in the device table entry. */
-- 
2.34.1

