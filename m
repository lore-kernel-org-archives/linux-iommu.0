Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A454C20C033
	for <iommu@lists.linux.dev>; Fri,  7 Mar 2025 09:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741341541; cv=fail; b=GVk6ivjQZpmoUxbCd6LueSiLWFqETdQRAfyfd0sj2fw8y/Wy0RBXYyIByUEH3rsa8LAcL8wj2Eq3iUQUaqsWlbCJE1ixmW5EkhSR13l/qlEolxGcLA/tp+x5PgCdN79ctZnAMfWoIMAL+H6nUjaCV/wZ9znIOBZzwmpaBZMPXqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741341541; c=relaxed/simple;
	bh=qGx++0YMC8v8fiNaPXN7dLFQIKqpB82keWgGGp41rTI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FrhLcsfhO2mONCkQs9u+WTuK1oAs6KqwlLfJVlnO5gTC6zjzHu6/3tVX22x6VKHAokLMtkLo65rI+a/MiQLefZez+iL02ZBrYDvpsLuHVDxxZcZ+VEAb+3fIE+rzKwjA1UbdtOsGfKZFoZXUm/vVrvVe/0lyGccyVnGsengsbEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xZrZ9U69; arc=fail smtp.client-ip=40.107.237.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xZrZ9U69"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kYUMOMy4YoPNVbMEt8EKgvMR2iKF9NUjkcaiTQyOYBqJo5PHlkhDztq2zHsof8KVbuzK54izaQzAsJypCSUa1pNQdvd/039s0FvsuY5fjo+bQkS7ARBQ5TIsAMBysv1CxNFuNZ9xN0mjfrOlJ5ocCQR6/cJJGEVHb0OMIJhn+tvwBlRWSCGxeWg0Mtbbrx0Ohlqo1sKaQ4FThNass9ITiVGOj4yAekJSWsemdA22e4IGQggY8u2T+wOZz3gF1awDa/MXlQSceJQRku+NP9Yelm4Sz6jszWDwf7geRn81r2y3fWy+HOi4mYf3KDZInZNL3iTamDn/Zy3TuSLUo45RCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kIQX8gd+l/HtoWIPeNNNMzQ7TZnvxEDR5vu7cIrw0JY=;
 b=Tj9XZUPrk6BkNiEpathkEKYmN/exiKKY951UO5wAfhBikKD4LtNT+aHhsEMGYb7h0kLOGwmSJAVBT5GoSIfDOHjWZZ84AxsKzCYXQgwFK3w+K8WLND6uQzCMxwL+Tx88XBRJLOhNQfptyGFugDlX7nIU/KSwXWN89WRhoLjHhRfE+jVEHV+IQE1zzmjH3+4kc8oZtMMXfNX3HoFjhT3X5HGqn8S1n2ITy03cV0QBsyqKoD38Vxsiz60rohdd3metqfncn6iJSP18MJVLGasAQ1JDEAjbaunO63uXsNmQCsIuSjscgHOIckTvHIPGMpbxJgphiVXvMLi+zAgAdHon2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIQX8gd+l/HtoWIPeNNNMzQ7TZnvxEDR5vu7cIrw0JY=;
 b=xZrZ9U69kEACR1u73AAAz5gwooka+Ym80kGcreP65O/wGOUCHJuPLoeJ+sUFOvq5SP1mzZVfoHJ/3rcGXkelT3Y4PLqXhCkv015YICDt0I+1QhUGEgxOKPBCt/EBVqMLByyFjzXm0U/RjwX0LUxOCq2Os+bNAryeonmfXmwX3WU=
Received: from SJ0PR05CA0081.namprd05.prod.outlook.com (2603:10b6:a03:332::26)
 by BY5PR12MB4196.namprd12.prod.outlook.com (2603:10b6:a03:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Fri, 7 Mar
 2025 09:58:56 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::ef) by SJ0PR05CA0081.outlook.office365.com
 (2603:10b6:a03:332::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.9 via Frontend Transport; Fri, 7
 Mar 2025 09:58:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 09:58:55 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Mar
 2025 03:58:52 -0600
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <vasant.hegde@amd.com>, <sarunkod@amd.com>
Subject: [PATCH 1/4] iommu/amd: Introduce generic function to set multibit feature value
Date: Fri, 7 Mar 2025 15:28:19 +0530
Message-ID: <20250307095822.2274-2-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250307095822.2274-1-sarunkod@amd.com>
References: <20250307095822.2274-1-sarunkod@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|BY5PR12MB4196:EE_
X-MS-Office365-Filtering-Correlation-Id: cd9a428c-0f0e-4026-edfc-08dd5d5eac83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yDOJZVI9jpM4XiTZBqbt6ylLEIOQaUx/EznO1/x41lnFNWuLZnfP9BsthtqN?=
 =?us-ascii?Q?CcavrS+qrxavz5XZkeTFE8IE3tPeS2wT/qZQWP69GyFugWCFvckEcu9EBHyg?=
 =?us-ascii?Q?TKNMZzTcCg5jJN5YJ8KP6vs3mJTQ35RWMde0e+vgcUpKI1i8RjGi07qmzC3c?=
 =?us-ascii?Q?mTPp2zErfqEEzEZrDvweO5rbisEiMHtAPyoOM3foMbS161Q7WXSpro226LYU?=
 =?us-ascii?Q?Y8zp5dLbL7qPJV3KHbpKPmlLdnawwTbxSdfyH1LdrHGy64ZbiDG+QpjEFxjt?=
 =?us-ascii?Q?NR+jCi1IKeUPBEAJg9SZdw2HN+s+TxaGA4eO3QEfdxBVNpfwox9Fuc4xXWPa?=
 =?us-ascii?Q?JxG68ZW2N9OYxr/8LFiTJB6VmW5y3EektTFMMs2+cUju9oQw0311tqmIEaWB?=
 =?us-ascii?Q?O+bq+5tOdXPcQTBe8wmMqC8eeiHN62hIdwSljmrA9MFT+Q4g5pjTFM08h/by?=
 =?us-ascii?Q?zjo29LHIt1oo6mCKhvsQxqJoT90BAm5Cm/+RaBdu7beSp+lB7J7nP2K7828M?=
 =?us-ascii?Q?rBKvhGFJsXJdGxGF782XP1+TdJ4AxMqhhn1kHC9HqeN7LfirYjWy9aHz/Po4?=
 =?us-ascii?Q?zZYuxOhajYoQfBdmB6a8UcmSBz+XzagLMmVwJMkAAOLPRwipTm4LU0UrhRoM?=
 =?us-ascii?Q?qdteZ1deRlvPEAIhEIZChwbsMTyfSFTA+fB5zkEy3NAZPxTnxljG3opZ6Vi5?=
 =?us-ascii?Q?yMMJbN45+FZiVQ8zvvGwBpEnR/lhe5c743K0eP3lF0Cg8MYkXANBRnfGr/id?=
 =?us-ascii?Q?56004QUw/RGnj0FuEJcjGv3wN6rL/PF8leOkmfzAi7zBLnWQdvcc0jglRI6S?=
 =?us-ascii?Q?dhUTjZ5NY6uPrE2Hrrn3wJLruN2vAkWrpcrq2ULcajPgzMzKE1itu0qrZgkN?=
 =?us-ascii?Q?oNi+uYRqFhCzQYOxuyq++4jIx6m2dhVgaahysCqCnJVq6ifqhKe/wUe1Kczg?=
 =?us-ascii?Q?EgANMDtLv5dKEflkY14oqALmimeEe/Qo+Q5aGBZQuAD8D2YKnOu0ZK7Y+F2v?=
 =?us-ascii?Q?xruLTL3ApRKHBjE4VJXBW28wRdfTfovTS7nFlJVx72666cra9b2ILQGN/a8C?=
 =?us-ascii?Q?XqNaGi1DtCJWHVZ91ozfyCZyqOf9IFktaRI/jvJihjiXXpbD/5FqwqCiVqlD?=
 =?us-ascii?Q?vid3Ryt16UBhab5gUeypni+P8VWdkPjCI/my8L1kiXITHFknn4xUb7jKqKzJ?=
 =?us-ascii?Q?zkHnAxKCPnzw0XOXTfrpUYIGUKPpNDx+RKhW2u7RIGoGh8rG08s5UUHEkd7B?=
 =?us-ascii?Q?rpmIOn+6XUlVIcXCEjF8tK3+ASQxuNQfNV1LZBCya0ijfBJdMtYx8almIZZH?=
 =?us-ascii?Q?1L3eX5WBI86IQALPP6OfOatQqHwHdzWw34gXqKe+LifSweT3VjrYKyJJXcPm?=
 =?us-ascii?Q?iPIizRT4H5ecJYQKKrzNAjoapkmm/E/DY9Is5WOmlhSpjfeNq0inaecsmsox?=
 =?us-ascii?Q?nQLko4DS9qr0DcT9QKvitHBgK79l1CgC0Kmr2zQOenZH/gatd1HdklRK8j3+?=
 =?us-ascii?Q?YTi0vtnkOSqVSFw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 09:58:55.7552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd9a428c-0f0e-4026-edfc-08dd5d5eac83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4196

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

