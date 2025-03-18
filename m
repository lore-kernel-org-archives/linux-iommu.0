Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08990D528
	for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 06:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742279521; cv=fail; b=ZEKpjl/cwlH+aKmtJGgHtIY0mekStog9IOQ2SXyKdZ0D70fNdTQU76A0qkkY52FfnvOV2Hb16yebJXtv8EAW7zGXtJkWt37Pu10CBlCKmcU9V510LUgsDY1iaoW9n61fvCxO9r5fIRBwx4z9qQru8RebOUEh8ewa3gnAKjLhnmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742279521; c=relaxed/simple;
	bh=qGx++0YMC8v8fiNaPXN7dLFQIKqpB82keWgGGp41rTI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BTS6cFNm4neK18s3SMewIIa9nQ2IW2aF7I7C30S8E2eseanhRVikzilWHJKVbCkJpMfiQYa+eYkdyHNdfTW4kswjluMsAIZWB9YwkKUZxCKPsYJRuFPYYCtaC7GOkib5khMqMxFyuql4f79TtY0fRJwV+NWYSa1D1GYmPpzyB2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BXeGTdfb; arc=fail smtp.client-ip=40.107.223.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BXeGTdfb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NoI3LiGrjTqZKNcG/17Cx6untp08u94cLcVakdt3kyQaiKGNUPgYQSgIcvonCcalzyUcOF6oi0OHy1w8nbKiES5K5QJ6svq+iGsNnetlMIwd4lyjwZ5YONmWgqXMCEIihwG5X0wXxniz4ox9EnvLS5Bqodz9ZcNwPl2YgzezHgdEvngcdqIEG6tdncETE/4uonauUwYpb93KvDgE62gaX+vs9F362bQqBP5CGegbg1Ktg5dXJi15ZKgqwLBmPW1Nd9PkNeNxc3/RWrK/LCmm8bH3uEGTxQv9FTah9OI/ZeKR8tLU2oOs+k0h/JRXysS6kzAUJyM3A0mfXr3Nh8Id+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kIQX8gd+l/HtoWIPeNNNMzQ7TZnvxEDR5vu7cIrw0JY=;
 b=uHFxtrLqEMqpRJwkJHzqzMODfbo/s6tyy+ji/WNsyHfp+++wO4AOAyUqnCjwx3iI9q37t/tpomFjzp+yfE4mgvZ8sQ+yDJxLssh3wBZzlJnUz/pYam/TAORLemk+qLzZ1OewzO11dkK6fXxRQQscFlNCoDaBaZXMMzRHBmSXFB0xFlHSgXPBXvmcoBcZv6gxUoyaexaPVgSaTzzLF+nlKIdoho/SUjPUq4f5EqCRCzinGBNScK0uoXDcHf94gQLLDHTPljSsiVNaobLx5dcOZqa7jCE0RIF0o9k5PGiAF7AnZ+Xlex9uLqq+O7lOYwMO03FzB1x+pLeIvXe8FBeHGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIQX8gd+l/HtoWIPeNNNMzQ7TZnvxEDR5vu7cIrw0JY=;
 b=BXeGTdfbRo4TlBqVPUX54wpByHZUqKCK+RM3W74mTXVnYYLto8LnrPNqTMGB2VL8LIzBKt2Duvi9QW06frCDoKttRy/NsZjescHW2505muNM317om1n0FosfgihNSswzsyEq5KNeWffTeZI4ZobsmGzhhEkpIpJzNPAYv+kvq3I=
Received: from PH7P220CA0152.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::10)
 by MN2PR12MB4375.namprd12.prod.outlook.com (2603:10b6:208:24f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 06:31:56 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:510:33b:cafe::c0) by PH7P220CA0152.outlook.office365.com
 (2603:10b6:510:33b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Tue,
 18 Mar 2025 06:31:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 06:31:55 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Mar
 2025 01:31:52 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <vasant.hegde@amd.com>, <sarunkod@amd.com>
Subject: [PATCH v2 1/4] iommu/amd: Introduce generic function to set multibit feature value
Date: Tue, 18 Mar 2025 12:01:20 +0530
Message-ID: <20250318063123.2556-2-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318063123.2556-1-sarunkod@amd.com>
References: <20250318063123.2556-1-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|MN2PR12MB4375:EE_
X-MS-Office365-Filtering-Correlation-Id: 7891d6c7-6e05-4ce5-84b9-08dd65e6941b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rzWZphsEUOFLo2HlPXGdOEdj7snbtHELUz1kkamvhVAoQdt5VQ41/yv5xnln?=
 =?us-ascii?Q?T4/N4U7ohgBCbIKAXsHMSYI4QcsfdI5kz/DybUfLzHxaxqeSiFri6zpAZgwX?=
 =?us-ascii?Q?dTuID5W01biHuj55H68MBKRHWxqxSHw7vJNtQQ2uUF2HmSrcfKHWsiizd/vR?=
 =?us-ascii?Q?vMN2ti/4M/xCwzd3D4ZA/E1oosu/hkzLeyHveKxTL7n+X1oBj3FXTHzbmT6Y?=
 =?us-ascii?Q?iuLg8SAUNTSKGE7oVEn8WWB4X5eicVi7Ppv2CQfQbKQoOCpezRkM1ULL/VjW?=
 =?us-ascii?Q?IvT2sf2mS9XJUxjr/0QO9P2c8sApqan7VQp3ltSKvMWuXklMR/fYNOhb4lk4?=
 =?us-ascii?Q?23VSQT8SMra7aPUL9Wzf8oHbOuJhu2xsIyI90vfiARsOsYWL8tCINFrHI251?=
 =?us-ascii?Q?UnwKkN4WrkClgq9PYVgd1UnSEaWa1hSoAfCtSVRT4bEFbBIB3Ub40NY+c3Ls?=
 =?us-ascii?Q?6Z7EPjQCorpZ+5/ygc8Mj2UQJtCAeh5OGOISO1sWedYKIWJ3V3ZuMS5jOI3J?=
 =?us-ascii?Q?Syg2c/KWQ+qrECK/Are6erg70eoSUqw4KVOue2Lg/RR62RVw9TrNZimqFBcT?=
 =?us-ascii?Q?RX4QEOfJLyGQrNnmtDqJgIXDc7IfVizO0Lcfie0HFt3C5aN2oJGf0gt7IJ7y?=
 =?us-ascii?Q?+Wg3npFvbzqOfYNAT8kz3+ALpKKOb21D93NZUVhEe1NKn2Od048SAXOmryJS?=
 =?us-ascii?Q?P7XghV8RtrcaQp/M6A+qN9xtXS3/BBmHXA21n34C15Of3TiyHgLIc+Jejvwy?=
 =?us-ascii?Q?sTcrwokF5+HWty6Sn2s57RlZplwH9zibzDBH3E094zh4y+4vN5iJg1kNJQu/?=
 =?us-ascii?Q?oB8H0GtDkQLbLSR904PCHf+5WpKf1lXQe6gfxBZAmifxhq/ijKSbXDI3kdHc?=
 =?us-ascii?Q?l32XKmDBvCwrM5bh9WH8OEFv0RyNWEJ+PM56BDs/lnmjOf2N9Be5ih1ChL4t?=
 =?us-ascii?Q?bRYXze8/BwiGI39N24gCMWn15ylXWOODLwHb9y20YafTvdOQmWj+bkVUBMq5?=
 =?us-ascii?Q?zEqAqMy75kA8m5fCru3KGSvip455JbVxtnkjkKs4BRbeofzaX/+qUdfnVzF0?=
 =?us-ascii?Q?DwBnDN4ofu0WAXTQLjm57nWTqPJT+HLruInwgapdwKYa8h5k1gFPC/AyeWJH?=
 =?us-ascii?Q?bw6QUEx7UhP/ZHKqfU+6aCkFqx0v2JFDSUfoalAKBINO2XY0XxCqARfQrLeK?=
 =?us-ascii?Q?KlzPSdy/31oxrHqb2W/ApSpM8Jb/q4KlrMzsBOF7vmdo6tjPCDI1Ecm70Z7e?=
 =?us-ascii?Q?BYCEliGsaeiS1MjUw/pVAYL9G3zOUNKVJp+L07sjHrFqcMA8bCDwK0CPyBph?=
 =?us-ascii?Q?l7pNoI3KrDtHwwvUikZjs70yQGTy1YQDkH/HbsJOBd9YbYLwJrdrJqFPz5oS?=
 =?us-ascii?Q?Ekpa2tZ/k6W+BN6TZ1/9bOkofa4qVz8lX0WV+gPmupbou5PJf4W0nyDNDOEB?=
 =?us-ascii?Q?6a/NTcdrDqvSPIc/l4gvzbQaihs+Ki+QhaaXTmchn03ABWziAnZNwzzKFVMr?=
 =?us-ascii?Q?+DQBpjKppiXPcls=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 06:31:55.6630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7891d6c7-6e05-4ce5-84b9-08dd65e6941b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4375

Define generic function `iommu_feature_set()` to set the values
in the feature control register and replace `iommu_set_inv_tlb_timeout()`
with it.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  2 +-
 drivers/iommu/amd/init.c            | 27 ++++++++++-----------------
 2 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 23caea22f8dc..dcc6fbfa62e2 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -181,7 +181,7 @@
 #define CONTROL_IRTCACHEDIS	59
 #define CONTROL_SNPAVIC_EN	61
 
-#define CTRL_INV_TO_MASK	(7 << CONTROL_INV_TIMEOUT)
+#define CTRL_INV_TO_MASK	7
 #define CTRL_INV_TO_NONE	0
 #define CTRL_INV_TO_1MS		1
 #define CTRL_INV_TO_10MS	2
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index cb536d372b12..eaea9dc8af9d 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -412,33 +412,26 @@ static void iommu_set_device_table(struct amd_iommu *iommu)
 			&entry, sizeof(entry));
 }
 
-/* Generic functions to enable/disable certain features of the IOMMU. */
-void iommu_feature_enable(struct amd_iommu *iommu, u8 bit)
+static void iommu_feature_set(struct amd_iommu *iommu, u64 val, u64 mask, u8 shift)
 {
 	u64 ctrl;
 
 	ctrl = readq(iommu->mmio_base +  MMIO_CONTROL_OFFSET);
-	ctrl |= (1ULL << bit);
+	mask <<= shift;
+	ctrl &= ~mask;
+	ctrl |= (val << shift) & mask;
 	writeq(ctrl, iommu->mmio_base +  MMIO_CONTROL_OFFSET);
 }
 
-static void iommu_feature_disable(struct amd_iommu *iommu, u8 bit)
+/* Generic functions to enable/disable certain features of the IOMMU. */
+void iommu_feature_enable(struct amd_iommu *iommu, u8 bit)
 {
-	u64 ctrl;
-
-	ctrl = readq(iommu->mmio_base + MMIO_CONTROL_OFFSET);
-	ctrl &= ~(1ULL << bit);
-	writeq(ctrl, iommu->mmio_base + MMIO_CONTROL_OFFSET);
+	iommu_feature_set(iommu, 1ULL, 1ULL, bit);
 }
 
-static void iommu_set_inv_tlb_timeout(struct amd_iommu *iommu, int timeout)
+static void iommu_feature_disable(struct amd_iommu *iommu, u8 bit)
 {
-	u64 ctrl;
-
-	ctrl = readq(iommu->mmio_base + MMIO_CONTROL_OFFSET);
-	ctrl &= ~CTRL_INV_TO_MASK;
-	ctrl |= (timeout << CONTROL_INV_TIMEOUT) & CTRL_INV_TO_MASK;
-	writeq(ctrl, iommu->mmio_base + MMIO_CONTROL_OFFSET);
+	iommu_feature_set(iommu, 0ULL, 1ULL, bit);
 }
 
 /* Function to enable the hardware */
@@ -2652,7 +2645,7 @@ static void iommu_init_flags(struct amd_iommu *iommu)
 	iommu_feature_enable(iommu, CONTROL_COHERENT_EN);
 
 	/* Set IOTLB invalidation timeout to 1s */
-	iommu_set_inv_tlb_timeout(iommu, CTRL_INV_TO_1S);
+	iommu_feature_set(iommu, CTRL_INV_TO_1S, CTRL_INV_TO_MASK, CONTROL_INV_TIMEOUT);
 
 	/* Enable Enhanced Peripheral Page Request Handling */
 	if (check_feature(FEATURE_EPHSUP))
-- 
2.34.1

