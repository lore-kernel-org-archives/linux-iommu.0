Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2073.outbound.protection.outlook.com [40.107.212.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349831BE238
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 15:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723823045; cv=fail; b=kHT70wE0eXTEupzH6VQwYv4vLfiSD55SOICRhZNM2FOydOlSGPaJqhwI6xZQWIphW0qyka0YXNXM7qmUGxcGLun2a6dwV7vGcFdXBMgWPUgOdruOn1bLMMKywN4IJzyAGWP9BwdokqfA1rMIergF19nHirp1uy5TGN99fPRyHUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723823045; c=relaxed/simple;
	bh=KrPZB66agISseWt7Q2zzehienaGaHegGf55hH3fx8es=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z2PwqMeJhyz80kgBYOuLLoEYzZzgImYj9wgKGWVWjBdLwbf79rZzyxzrU2mSSKYHWWyMXUInKIIU3Bg4uNeL5wgyBiDpMT8TvJrZudNz+baBgLiqEMXlYu+V+/4+HtUo5ATOnDV/4FvIpijIdX0aa9cEIoQK4FwyOC5KdfYn1og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GxkPVQRy; arc=fail smtp.client-ip=40.107.212.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GxkPVQRy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LK0jBlC7JVp9DkwogH5gfYXwNkbHRptmv8gROsWg7FHUSsIxW67kyqwExt4VMRBpsL0Bvw+ryCShBD78ZkqmFTDllez950bJU9y7960yymkZAuGms5ElDwwvK2msHnjmnWYbHmuoKQ/A7wU5I3l1DzA8d/gNnJOXpVtzqJD/02UANf26ysQD3KuVCHahmBa9jNR2bYSABwrDOwJxtMOeILuQJZW5lOIbt+AYr++9o+xytu/pDebJCEaYLFVFbXx6OYBzCZwo2MHMlFPIt/9oEoUuhK1KeAFVm++X8nHqJTax0bEwVoykJ2woQ9EOEK6YjlCKoeC1YMuSRDs2R6qiWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+/6C6+FA+X9tdsHvdZ4SOeMkvW0vZ2TKosZ3qVNkzI=;
 b=YN8Msk2k4QcMVUCSvAI2bFcLqNkd+9bz6VauL9V9Ya6RYY854tg4xb1UBHUqma1b4pShDLvRJWnpUpy5r8Lk8Ej+iAiYymulC9w7vP25VwW66XJCbxocbn9HyOI4zUR95R0NIMvE0XC/JRHn1COC0AdO9saf+Qp07l2cYsrm98YsaQT7TDCPNaVlEOtYfE6Vu/lk3UWzhkabJwQnjE10T6U7xBrUVEgN+yl1zDnLbxi3RAfU+kSf99ZRvdSmHIdfQumYdFTgphxny29dIz9KCqtFv7mgf2NHgglo9jBfXy+fiCf/EL1EnbasqOoXt1Z3Xg/NAPGPg48KA8HdM4UNyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+/6C6+FA+X9tdsHvdZ4SOeMkvW0vZ2TKosZ3qVNkzI=;
 b=GxkPVQRygARY5EUE3S/7Qg6P3R/f+RgIuwZ1viBwQSr9z/D3Dub5YEb7UefB6WUeeVKif9bDiEahWXW731MduV5/QWYL0C3AkBttT03R8A+10H/txg1B0m7sZtTHQjLCQN0S8xsxKozUgValI7FsvA2q25TtR61d7IAH6vD4pk8=
Received: from MW4PR04CA0326.namprd04.prod.outlook.com (2603:10b6:303:82::31)
 by SJ1PR12MB6052.namprd12.prod.outlook.com (2603:10b6:a03:489::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 16 Aug
 2024 15:43:58 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:303:82:cafe::4a) by MW4PR04CA0326.outlook.office365.com
 (2603:10b6:303:82::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20 via Frontend
 Transport; Fri, 16 Aug 2024 15:43:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 15:43:58 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 Aug
 2024 10:43:54 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jon.grimm@amd.com>, <santosh.shukla@amd.com>, <pandoh@google.com>,
	<kumaranand@google.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH 1/2] iommu/amd: Introduce struct gcr3_tbl_info.giov
Date: Fri, 16 Aug 2024 15:43:30 +0000
Message-ID: <20240816154331.5003-2-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816154331.5003-1-suravee.suthikulpanit@amd.com>
References: <20240816154331.5003-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|SJ1PR12MB6052:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e360eef-2711-40f2-3673-08dcbe0a3e77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XtYvamNWbZW86LeW+CCCWLfntsDx2ULn7QLub0X1pOsfkZzm6tTdWyzu61oK?=
 =?us-ascii?Q?BgWQKcI2SutVt4sNt67HAf6bf0R60pNN03Jtr1OXkVf5GoP3xlOHXn54kZFV?=
 =?us-ascii?Q?W9oyaUeDjxnQluuO9QtcDKjvCnDWld3AxzFW9lTL32Zf3MX5bMFWVKiC61pK?=
 =?us-ascii?Q?VcxVYKXaguGm3O9Y8JlrLhTmHx1sHbbuNMBXrODSkOi/5mjKAldTE31ebeFj?=
 =?us-ascii?Q?DC/S22IC+LmgraNqBGbJlBJRIOgBFH09sXD7ZfTFpsP6ZhaUvjzvC88sRhL6?=
 =?us-ascii?Q?ilwXefBLPejflALZyGdlEHLjDpfShA8aqf0CWd2IKKUq0mWhiMuICgUpE4ix?=
 =?us-ascii?Q?ZVfMw661nkR/M8TA4lqvX1xw5XtHs4ChzAFVaE/HyeWcUlhIKKG565Eppelv?=
 =?us-ascii?Q?oSVnyZr4f5QawfMdKXINIyJZSo5yjqdCMM7dGudELwfz1JdUy+d5QsJBX8Mz?=
 =?us-ascii?Q?mx8YaFpRD0CnXzDr6GeyS9JTq3L8K8mkWDiDmtNSQteOC5YuOAauI/qqW2wY?=
 =?us-ascii?Q?HyYjAkeSLpoPymE31QEC7BZknTCaBH4DViz7MRXokSq8Gbz6WdYvfhA6yFRk?=
 =?us-ascii?Q?wNO9UuuSQ6/Lke+iLV/IocCz9570Wnzo1/YCtXGmgSTwD04A17ufuEH6eCww?=
 =?us-ascii?Q?wHM64z9PfJsfZeAYMsAAt/jVEZ0rN8wbVlA0RSmwQu/rGZ1MB7MaIaJ1PP/E?=
 =?us-ascii?Q?iXU4wIaogbB7fBBG3h9BNV3aFnZOGXkr1FxhdFrTR2SlOaigg9+LficdQ7aa?=
 =?us-ascii?Q?xPFSoyaZ26asrQmAh9NVBdtxIzUHfkYpOWeFx6vgcKTp7Wyc2qJ2GWBoFips?=
 =?us-ascii?Q?QpLAvAsHdf+1WNExgXpuoa675CsYSvC2gYOF91/oLLe9+1tQg8Kj7ujwlT6d?=
 =?us-ascii?Q?1yyzCxcfCCZRPAsAQIxrWinGGpFZ+O1mC9oQmQf6Gq/fbNWlCoH1JNwDzprg?=
 =?us-ascii?Q?yr6Kw9LmTWnb94f4+gH+0AArNKLY3pTuLdobNHbpKI2WEbKhk0XMByyEY5Xh?=
 =?us-ascii?Q?JQRCe7FmP50iHBYuS+IJEZq7G5mfRiRYalmyW6RzariJUV1Yj4wscAekpjUK?=
 =?us-ascii?Q?tVI47bvzJJ4qcWtl7My98sBN+0enB8mYrU3u9J6+BBlc3ff5nitdXs256IJc?=
 =?us-ascii?Q?7QGCtL2aBp1o09i/wYZiU6x+AjAAoSkJe+uU5OIAigP2KtaDg7LFuOp09Sf9?=
 =?us-ascii?Q?/G+0oofEcrfVy0qqo4BzUwsnO0f+d/jGYfgAz3MBHRwx3ux43OCessLOUH66?=
 =?us-ascii?Q?JEyMUVmTkmAzusyZ+B3ilEB/lKF8LrgCE5wP4LuTkElmfWjDiJa6WICWp6xo?=
 =?us-ascii?Q?2eROTD8wnnNSBCU3tnzy9lmhAkfcueIGuf5lw8Z0DyHCMaVq0xwlTa7+ap6I?=
 =?us-ascii?Q?po/J1weo/YtTUjnuponWQWisIFY3bNBQYdc0J5SdqpiHMuHP1PyKXGnOC1yU?=
 =?us-ascii?Q?QQU2QApAIGa7oS2MR+NbJtqpgx8cXQlU?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 15:43:58.4843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e360eef-2711-40f2-3673-08dcbe0a3e77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6052

To track DTE[GIOV] programming during IOMMU domain attach, also add logic
to determine if the GIOV is required, and set the variable accordinglly.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/iommu.c           | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 2b76b5dedc1d..9be761ba0214 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -544,6 +544,7 @@ struct gcr3_tbl_info {
 	int	glx;		/* Number of levels for GCR3 table */
 	u32	pasid_cnt;	/* Track attached PASIDs */
 	u16	domid;		/* Per device domain ID */
+	bool	giov;		/* Track DTE[GIOV] */
 };
 
 struct amd_io_pgtable {
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 87c5385ce3f2..4667b6c4906f 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2011,6 +2011,16 @@ static int init_gcr3_table(struct iommu_dev_data *dev_data,
 	if (ret)
 		free_gcr3_table(&dev_data->gcr3_info);
 
+	if (!ret) {
+		/*
+		 * GIOV is required for PD_MODE_V2 because we need
+		 * to support the case where the end-point device
+		 * does not have PASID in the TLP prefix when setting
+		 * up to use the v2 table.
+		 */
+		dev_data->gcr3_info.giov = true;
+	}
+
 	return ret;
 }
 
-- 
2.34.1

