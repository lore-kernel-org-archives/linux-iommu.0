Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B39A2E03FE
	for <iommu@lists.linux.dev>; Wed, 20 Aug 2025 11:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755689466; cv=fail; b=PmflVtQy64wGKExwDNEmX7Ba+0WOmNtQ/nVajVBKGPCFLbna6k8hOXtjXv/nONqsisuYiD2FFHoSDHLYvp7E8YyREebww/yxsSvX6XV9tBkLNfA7K2acVZ5V6C5FGZ8eomJTh7J1nNPt7PyYxF+0OHLsmPKVdw02yVI6kU323C4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755689466; c=relaxed/simple;
	bh=dAGzko4PV8GyFjKqLie4tGEAP4AlZRx5/ooOEYyOMA4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JI3aaQgB5LlicXMUtEUlXj3NDsq/CzlGEM0DByWjx56Jn82G5hdsq6a2KLw8CWWFnXoCqd4aND+vO1mJx7bpiaISmRqHc2q22xEEn7dqbT69kj/2D9ifOnyZCQwmelb9KqDCgSK4LxrBXMGnvrDYgOmLVNFN/8QZOBPlaLABT5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oMmY2twM; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oMmY2twM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHB58vNseWul5fd/BGfWlvr8pc7fAYSmMkySvCdYSi+a+/cWc4oa0tZSFiwHHyoPlgDWlxDPVmIyx8sung8+MwJHCB23ZyMhHwoPWTTFXESvskXj3WVdAxKO5yU0mU2vnc5XEP6SqxpL0+vepJJgsscx1lz/XHM9FiTKWh0iQ+fJIGAPNOviQipqLXme1KenL51yT85dl+bnRPEyhpKxhI+ekl6rBlu+UCwf/sNktmHljuxxmmGv1BSopVJGx9/LBErokO7ginFCU/N20Xd788W5yszsjldEJzMsdVeouRdXucLHnSpF0Z9X5M5/lrN1z8UTTjPfoiMEHFuzZ/Yc3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2eY91uStOMbjxVpX+Ooj1pyTqHzjlfcd+b9VlOanmU=;
 b=QqtpLSQp0CNzz7pOxPRIkYbf5i0UuSFz1QL8ycXHEZqru8h2c1dZxuexTwEoW8DeS3aG+fag3xo9fPMczSNwNkd25FJoZi/ncuiQCgjXb/St5pNXTxlC1VAJoQVyd6eniUFwjRkx1sbnVmHhrYvF7TDorhDS6Sk8EeOB/dd0eVS+4sHudORUGTKp3xkj5XsxQKyOi9prc+DxprrQSP7FnFaiWGCAVnis0W0NKaMLYYu/2uI13AJpMPC9I8F5k6CknzAAhS2QHYYmaTbE6kP6FBxPlWWRkrmynj/otSFBXn/VggP9i07F7ktnkmx64fUsySnjoVKZ5c4l+ITWNRuECw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2eY91uStOMbjxVpX+Ooj1pyTqHzjlfcd+b9VlOanmU=;
 b=oMmY2twMjYIWxQDEOfVChoe3c4or1dN0MZVa3y/TfLj+tMvhFaAHAXmk/nFKPjOPOIIs5KVWrlzxnRM7k2+jPg+7ZTWcE+bDlNrEDO/cCGORFaAiaYEVfH/vbFDolusNoK+lDZVLVKyBCY2HcX0bV+dAzPVm+7fK8FbKHmREiX4=
Received: from BLAP220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::35)
 by MN0PR12MB5908.namprd12.prod.outlook.com (2603:10b6:208:37c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 11:30:59 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:208:32c:cafe::5e) by BLAP220CA0030.outlook.office365.com
 (2603:10b6:208:32c::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 11:30:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.0 via Frontend Transport; Wed, 20 Aug 2025 11:30:59 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 06:30:54 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <jgg@nvidia.com>, <nicolinc@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>, <will@kernel.org>,
	<joro@8bytes.org>, <kevin.tian@intel.com>, <jsnitsel@redhat.com>,
	<vasant.hegde@amd.com>, <iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH 6/8] iommu/amd: Add support for nest parent domain allocation
Date: Wed, 20 Aug 2025 11:30:07 +0000
Message-ID: <20250820113009.5233-7-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|MN0PR12MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: cac1c507-68e6-471c-2ec2-08dddfdd097a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jBauyU1E1yhlh/YHXPIa7NS6+3DLr7mKSz3pSpgtgDgIK6qmM88XBfKlvrZ5?=
 =?us-ascii?Q?8cwxqDQ3oT2o3P/a2HcndrPBgXIP2np0aYRciHbCY3dX3teA2qflH5eUv1U7?=
 =?us-ascii?Q?IaEDcSzoPx1GHv1qBY8TmxO6ftSQhLhZt7IPXgNHVZaxnsGtTmfBo3bZ2eW7?=
 =?us-ascii?Q?wiTkRrayP+9MTOOe9exTLrT4zAaXrj1Q0wNBQ84H7Ar3PC9yByLCkTPMckVQ?=
 =?us-ascii?Q?2H5HltN9nCpGEpL/r+wI0FJzskAn+UUi9o4KrKe7s1oqu4IOROJuJHdY2VhI?=
 =?us-ascii?Q?GV5Rs6VzfmjflyqiFXd01YpdPsenU9RFCFamd/4dQB2G9L1/cTGKlJ+mh4hz?=
 =?us-ascii?Q?XqDBoUrMLGiXZ4i9eoGQyHM+6vcvyvYQncwFNojEsh4mWv9MIoZFJnwiRG1P?=
 =?us-ascii?Q?TPpKGmRt+4ZS0893/zSrzF300MffwtdQk7/7izRydElLTurE9InKUrlEuxSq?=
 =?us-ascii?Q?KjQm+rkZtEL1Zkj6WKJmre7hTPleuHXYiwMh5y5Y1lZBGoPuunXo7re9AMI0?=
 =?us-ascii?Q?YmEfcpuXkD+S3tuhiVZHMSxg7YqHKpkSA13GHhL7yJTfT22/aZ3VNJT5mWV6?=
 =?us-ascii?Q?QzNdiRoohygdxhafoDyoroTWNdqUS/fylLdcwxntJzuqrUSNXIYyrvSls61G?=
 =?us-ascii?Q?HENgSViKFJi9WVPtAU8T28MvOyUukmuRwYnY0tSmdaYbmhVUlWVZulPnjJ7v?=
 =?us-ascii?Q?veR+7H8Epbtz5EQbGbv7br/xpbg3GLgVBM60vzPxCDdwXIjR5dRdaFvpbLEk?=
 =?us-ascii?Q?zH4bgFn6jQszmMMq1QI0MpyH7KlkrVHmY66dFpsW6uB1knksmTpq9Y3wyhuA?=
 =?us-ascii?Q?zTdoC1y8lcMcDL0ICI2dxiBvm4XciDKAYY4zHyBeAGtPmbvm4icm3IIU7xeo?=
 =?us-ascii?Q?Ub7Zk6EukYG181kVm4LDf1sMVF5BC1R9Gkk/DMGnBV06TZ/Cobg2CaHTe13f?=
 =?us-ascii?Q?XJCOTQa0JOQam3/NsSRTRRmY9Gt3JsYYTBRDC/nNuLJKct5hRidIhHTEsVEP?=
 =?us-ascii?Q?QqJTgMFt2uCWn0D7nFF3BqaLXmbK4AFiTGTEI/jzGBb9f69XRAGnTwy5TJf/?=
 =?us-ascii?Q?BTAU+44WwCXL6VQcTkDKpAkTuc+qHkEInv4YBCgfED3npLDljatAaaGHOf51?=
 =?us-ascii?Q?dOcMMYcgT4Zdf4gkBQ1bYN6jz52g/7rx0D3awFhm5prVgizhlstIkz/RDzOH?=
 =?us-ascii?Q?V4eoasdBQgLi/yxLwx671f0sXWEta/mm5Ue7wQAfhxqkwfwccS8CYBtRwCqm?=
 =?us-ascii?Q?zkLTqoiTAlEaA+K/3fiZNVhgawTK4M7hZfzwtk+BX2hsh7cvaYXDSZwU5uwg?=
 =?us-ascii?Q?xtsEUHILFuNfHI71RzqCv9I0BXfBaFCnGQF8TLT4Frd37VjvfDjND4g3FFMT?=
 =?us-ascii?Q?Mq6aOIb2MbvJQeZvvHcmSvgHOXUH/L1d6RApu7uoJ53krRVXkGcgCLyoc3YN?=
 =?us-ascii?Q?CU2pyzYOY9q2iUkgLz6Q7fJV0Yk3+i24ZBGSEGdamGQF7U3YHz5Uu+rvH/hi?=
 =?us-ascii?Q?TurjDwpj1lZcEZo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 11:30:59.5822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cac1c507-68e6-471c-2ec2-08dddfdd097a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5908

To support nested translation, the nest parent domain is allocated with
IOMMU_HWPT_ALLOC_NEST_PARENT flag, and stores information of the v1 page
table for stage 2 (i.e. GPA->SPA).

Also, only support nest parent domain on AMD system, which can support
the Guest CR3 Table (GCR3TRPMode) feature. This feature is required in
order to program DTE[GCR3 Table Root Pointer] with the GPA.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/iommu.c           | 24 ++++++++++++++++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 44c44943802c..5343b99913e4 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -110,6 +110,7 @@
 
 
 /* Extended Feature 2 Bits */
+#define FEATURE_GCR3TRPMODE	BIT_ULL(3)
 #define FEATURE_SNPAVICSUP	GENMASK_ULL(7, 5)
 #define FEATURE_SNPAVICSUP_GAM(x) \
 	(FIELD_GET(FEATURE_SNPAVICSUP, x) == 0x1)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index f463774e4b71..46682c8ba28d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2599,20 +2599,39 @@ do_iommu_domain_alloc(struct device *dev, u32 flags,
 	return &domain->domain;
 }
 
+static inline bool is_nest_parent_supported(u32 flags)
+{
+	/* Only allow nest parent when these features are supported */
+	if ((flags & IOMMU_HWPT_ALLOC_NEST_PARENT) &&
+	    (!check_feature(FEATURE_GT) ||
+	     !check_feature(FEATURE_GIOSUP) ||
+	     !check_feature2(FEATURE_GCR3TRPMODE)))
+		return false;
+
+	return true;
+}
+
 static struct iommu_domain *
 amd_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 				    const struct iommu_user_data *user_data)
 
 {
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
 	const u32 supported_flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
-						IOMMU_HWPT_ALLOC_PASID;
+						IOMMU_HWPT_ALLOC_PASID |
+						IOMMU_HWPT_ALLOC_NEST_PARENT;
 
-	if ((flags & ~supported_flags) || user_data)
+	/* Check supported flags */
+	if ((flags & ~supported_flags) || user_data || !is_nest_parent_supported(flags))
 		return ERR_PTR(-EOPNOTSUPP);
 
+	pr_debug("%s: IOMMU devid=%#x, flags=%#x\n", __func__, dev_data->devid, flags);
+
 	switch (flags & supported_flags) {
 	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING:
+	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING | IOMMU_HWPT_ALLOC_NEST_PARENT:
+	case IOMMU_HWPT_ALLOC_NEST_PARENT:
 		/* Allocate domain with v1 page table for dirty tracking */
 		if (!amd_iommu_hd_support(iommu))
 			break;
@@ -2626,6 +2645,7 @@ amd_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 		/* If nothing specific is required use the kernel commandline default */
 		return do_iommu_domain_alloc(dev, 0, amd_iommu_pgtable);
 	default:
+		pr_err("%s: Unhandled flag : 0x%x\n", __func__, flags);
 		break;
 	}
 	return ERR_PTR(-EOPNOTSUPP);
-- 
2.34.1

