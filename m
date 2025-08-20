Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B8E2E6127
	for <iommu@lists.linux.dev>; Wed, 20 Aug 2025 11:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755689449; cv=fail; b=QuDhVcOKo6dw4EPK09UI9/DNV0HhJZIzn2GI+Z29z1uvkbuVJCmiHQwDwyThtmQj7K1RnWn76fHdHUzqmLx0KmXxO8mGiJcjyznzFNbI9eZk0mQJpN0Bo9y45g17hN4eAqPgJl8S0E8dVcCT0MyT13dheiuUPgM5l87ogQfgLVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755689449; c=relaxed/simple;
	bh=byqtmsmD3XsyUzfT4TtDRZ9zZ/H2eVW4RoBlciqjPOQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tbl+3i5hCoc3EXZqPG13rBIXwMr9gMorP4m3xc6oYsSIuBi4w+ScjJgf7gMYXzNIKJ5JTVjlAojOGYxwjEmdqxBbI81q1vdIA8JErde3RRMdJZYU5nON2h1+GqhMLednkFBN4I3ockTWgcQavLQPG4yiboAfoJ6CkFVw7sKP0qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cYrpKbHh; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cYrpKbHh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IS5J7YC68biYkUYOdTX6SC0HUZDryhMf1375fFhgKv6DvvvoFQqK/BwZ7BAgbkhaTAboPYfv4R6koVtaQ9/EkQuYUvIGCYqA34giuOBw4+PT8iobFw7mOsuu8Clbrn2FaqX5TfzjcS7BPpql5r2zt+88rTzxd4qpXcn8X/dEXht647FueMQNz73n0bnee1MpZF9sTdo3llx6h98f9Er04Z7bUAvbHZy4/eTt06TC0/NXGOLg3LW/d+So/SCCBu1uUu/EchF/iCkXMaiP8ict0t4Uf8JLUDtdKMQrgI6JFdS/p4ZVt63QuTbmdkD85XOtIhghJ6wyII1f0S9XoV42FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+m3phihemuvFtcvv3H9+TtHD4DsYKt5jjhIdSYVAWY=;
 b=btIpKfQmH4r6l16M3oB+X1yLlfH8EU39nmMrQr31g/A0MPMFGbpe4okRrqAYzdziwhfeXu8lHgKyd/5AQREDNGWrVetWjpQEmryBW3EXdt2FSRt6WiU13KMMcK42O4rkNc/ndJeFP3Q2hekLlmqZy5Axe/FkiuMU0atRWdPKY57w1v0NE2GHhC4NS3LwEroCv7U45OV9g4pFzDT6piuQtGIFW9HxGBnWy5IQ/BGMTkNNhR057Q+j2TB0xL/WEbcVqN5ByP/Hiq1OXzgBgl1AQ/B4HO/YLMWpSPV68ccLCc12SwP3IvluT57i+KddeoLX3wHFngJKnlbnSMaDig2C5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+m3phihemuvFtcvv3H9+TtHD4DsYKt5jjhIdSYVAWY=;
 b=cYrpKbHhRVelrRSxhhAhIR3m+Zq9lhprscOnsHm8MMjukBFnZBSuvoT04fOek3PlljKBcVIZHv+PR1mXjSX/7FNloEf5x2vv3xrCktxraWiA+UpR7oWl60DC4YHHl2+GBqjbOMMJagdn3B6Q0hO++cHCjtoNdCnHpManVRz/Bek=
Received: from BN9PR03CA0692.namprd03.prod.outlook.com (2603:10b6:408:ef::7)
 by DS7PR12MB6117.namprd12.prod.outlook.com (2603:10b6:8:9b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.24; Wed, 20 Aug 2025 11:30:44 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:408:ef:cafe::3b) by BN9PR03CA0692.outlook.office365.com
 (2603:10b6:408:ef::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 11:30:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.0 via Frontend Transport; Wed, 20 Aug 2025 11:30:44 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 06:30:39 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <jgg@nvidia.com>, <nicolinc@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>, <will@kernel.org>,
	<joro@8bytes.org>, <kevin.tian@intel.com>, <jsnitsel@redhat.com>,
	<vasant.hegde@amd.com>, <iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH 3/8] iommu/amd: Making amd_iommu_pdev_enable_cap_ats non-static
Date: Wed, 20 Aug 2025 11:30:04 +0000
Message-ID: <20250820113009.5233-4-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820113009.5233-1-suravee.suthikulpanit@amd.com>
References: <20250820113009.5233-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|DS7PR12MB6117:EE_
X-MS-Office365-Filtering-Correlation-Id: e582840f-9774-42de-e2ca-08dddfdd0075
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n2cxh4N55WeEhB3+6pMIGVn1NmVKJOsyq+WRP1rKzcdBL4ZI8BUPEhgkJ78k?=
 =?us-ascii?Q?46/elbisUW0U/aRoeVFD4ufDcjbEb1drBlxPumyABJJU9FwXx2CcYIQjHn74?=
 =?us-ascii?Q?A+wdgmgdy896/8k9Y/TWOY77bjQ1uBn0Jth+26Qf/ptwUFhJCrYMV9NX4wi0?=
 =?us-ascii?Q?QgElV2kExOT+NJYl6Xs68PiWEF5+mdLioUnxAZEIBLm90rlnXNRqapjaW6dB?=
 =?us-ascii?Q?AVfCasA2dAMtXn6H/yMf0otgSStJf1FlWF5x11p684yUdihjfc3CK3rogNwU?=
 =?us-ascii?Q?NCJSaBNZzxkVoQS2seFR9phw+nlFhQxzCslM64dalGK/EC/+dUCH+WhmvthW?=
 =?us-ascii?Q?snDb/I8CqswbtSUP1/grub0ksY7W+G3iikIHz0cQ/QY0dFEnlqKX8n64hcY8?=
 =?us-ascii?Q?KODJRUHn8/kwONwBcdNFHNCPwsmj0AoxLcTqAiBHfMDHPBM+w1kqn6uFbPT2?=
 =?us-ascii?Q?BE/2i6WYCPVbno4BKJdX9H2R8gIiQO6SpZ4J0Fn3jgWC9Nu5J2w1WE4D8dz2?=
 =?us-ascii?Q?JAG56UXwoCQ+MVE2SZBvyg6PbEvGzn2pFeL7ksvmXkOg0w4QCcB9ncWpW0QP?=
 =?us-ascii?Q?gK6tYmzHizquEen3wLuKuj7IcWXx/pWnZNg+0mox1d+kniNI6KoPRjEYC0Vi?=
 =?us-ascii?Q?2qBgQ9swJeHCJB2b3pzuir0lHojxBt1xYAiOT88742PLZw1MwfELzLvpuChy?=
 =?us-ascii?Q?nP7SCQJdVwV1KlHr44yGSSC/dDoeNPF8zbYYP6hj9NOs2z7qW+ynLDTJLkJN?=
 =?us-ascii?Q?jYsPIWon0kQ9Rve/xoQnSiz/yT+fE+SPQ+m5ACpTosrrpmCihqfddjJEN/r3?=
 =?us-ascii?Q?1Jp7EqcF/Xc4UNgbsqnRaLv4bCHshMXIEKd0DU+Dv8V9kG5vUDCgDrfnPcjm?=
 =?us-ascii?Q?LTwupS6NNEUJy0sXlSf2EELF5yIOcImnxg7SuNB4LzGOSPYZ6OMFAXekg/vQ?=
 =?us-ascii?Q?r8cu4VRjMQEt3a9gVlmBJ4v/3/4fwYsTYPE6dWlqPzcppVLPZfnyv+W3QuGi?=
 =?us-ascii?Q?GKDINQTxTA6LDlvLCmpi0WPfTqV8K3IU2oLPH+IWiYQ3XzKbu8uWcq9zHtFE?=
 =?us-ascii?Q?TnsHo8BGreb3p7v8TpPY7bC/A8DoWNI4WdGwEMbshrQ1Ugk+nGT/SQEquRPD?=
 =?us-ascii?Q?a3eo9gpjrlEXNTphXBjc1z0FhEpFVP/JEX8L89kqfpauK4Y9NeLTTQJWoPcg?=
 =?us-ascii?Q?3sZuZZFPjtKqmukClonhywSxjDuwrEQTWMjFvgCaR+3EyYPmaAaf+A1l1czy?=
 =?us-ascii?Q?GdV8c+cjdYHIsc2+76Tepz93P1q8K2yk5ua2+teyLIuLjua6ZyKJYqohWWIs?=
 =?us-ascii?Q?VYlhOqr4b+TxSpi3lHJHk7vdGb2dEodVISclcOPt/Zr+pkmKsc+04tc42nQI?=
 =?us-ascii?Q?LTrN7BYUVLuhE21fDkAEF+9M4j7M/ZYOdefRWxst8grosG7kZHS9J2ElAxhK?=
 =?us-ascii?Q?A3o7JIS9V1D+AQLI549PvtSw+F7P+pXMM+nzq6GHNHvmHgqDbPkt5Ex6kq7n?=
 =?us-ascii?Q?R9w1/lcO89CwKyEoSm0tAkRtbB6grtBX9f5F?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 11:30:44.4477
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e582840f-9774-42de-e2ca-08dddfdd0075
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6117

To allow reuse in subsequent patches.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h | 1 +
 drivers/iommu/amd/iommu.c     | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 5085aa353522..3ff380afb9f4 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -27,6 +27,7 @@ void iommu_feature_enable(struct amd_iommu *iommu, u8 bit);
 void *__init iommu_alloc_4k_pages(struct amd_iommu *iommu,
 				  gfp_t gfp, size_t size);
 int amd_iommu_pdom_id_alloc(void);
+int amd_iommu_pdev_enable_cap_ats(struct pci_dev *pdev);
 
 #ifdef CONFIG_AMD_IOMMU_DEBUGFS
 void amd_iommu_debugfs_setup(void);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 207fef84a4c5..44f9a8990d87 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -531,7 +531,7 @@ static u32 pdev_get_caps(struct pci_dev *pdev)
 	return flags;
 }
 
-static inline int pdev_enable_cap_ats(struct pci_dev *pdev)
+int amd_iommu_pdev_enable_cap_ats(struct pci_dev *pdev)
 {
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(&pdev->dev);
 	int ret = -EINVAL;
@@ -629,7 +629,7 @@ static inline void pdev_disable_cap_pasid(struct pci_dev *pdev)
 static void pdev_enable_caps(struct pci_dev *pdev)
 {
 	pdev_enable_cap_pasid(pdev);
-	pdev_enable_cap_ats(pdev);
+	amd_iommu_pdev_enable_cap_ats(pdev);
 	pdev_enable_cap_pri(pdev);
 }
 
@@ -2303,7 +2303,7 @@ int __amd_iommu_attach_device(struct device *dev, struct protection_domain *doma
 		if (amd_iommu_iopf_add_device(iommu, dev_data))
 			pdev_disable_cap_pri(pdev);
 	} else if (pdev) {
-		pdev_enable_cap_ats(pdev);
+		amd_iommu_pdev_enable_cap_ats(pdev);
 	}
 
 	/* Update data structures */
-- 
2.34.1

