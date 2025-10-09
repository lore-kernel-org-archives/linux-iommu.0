Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012058.outbound.protection.outlook.com [40.107.200.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B447289E13
	for <iommu@lists.linux.dev>; Thu,  9 Oct 2025 23:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760054309; cv=fail; b=sOKrc1BlXYyOiuUmdGHUhZPXpG1UqsEaQnqAkLs7r2TYRFHQS+K/cjWpJFr3gtz/XRjLu7k5Khk6b3CvTjgs3RS+dSb+TlkqKjGENhokMODfBNWj+oqlzZvqCQ5xPFxWnwdLNJ64rjIMlXJnAVhTYR9lds7JRL21WA74DVmTm6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760054309; c=relaxed/simple;
	bh=L1o+fPwP3iQgZ845uumg/DXr1Fyq+bMbq/IaXwFbBWc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M20gG0fKLuKhXooFv8T7/G8rVHDpNKfsm24/mCk/s3ii6XfGikgEaiZlCxbqwGavlMB0VPJWkKEylvZ85aJ6A70vmWJk53S4XOzc6GoevRRJq/ce4dDGC5LzYuLfZE4NofX0YvCxiKrm24yijBn4kH+0Er0vcot+oVWLatBC7kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qE6YL5mt; arc=fail smtp.client-ip=40.107.200.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qE6YL5mt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vn257RAShohCOqDaE0d5nuUngRFm7utNg7rjFyHNkRZTHOHdJMeZ8Nh6A2gvZOEr5N0rh2iAmcIzG+YDLzftNiaD8PVBnaM9m/fS/VQ37VgE45v0vF3YoUrOaWL4W4PtQmRLK9fn+QdqlzsqiXyesjX1lde4RBUaec3jPt0Mbr/ZnXpp533D95fQGe20B+0crvgUFVp+Xw6F3HiVZRw4nloQFCIgVLPh2OYETTRaMv2KoOzVJzvKG9nuPlnjt0H9F2dOkJuJAFRTVB70ObmwuDCYAKQLEpxl55DUZcw2lEiP02OkwI2QjbxKpDZr8ppNq5dFCAN+cvCA+SnXmM12wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6toszXUe1Ds/fq20+NhRrkRrjPtESk0AuBs8KWj6TeA=;
 b=c/SmBijhc8BLyY/k8U9afmKzGUII5RzKd5u7aod7a4Ly5Ep4q4SO+jGkA1yOG1O/N11ZNofwtVQnSp1ZOW29AWDhAKSQLm29xj7itJpHPw/bbdxvOGaRHYp9e907CwGeiCufVvEXx4PuSBRKbe+Q8MWlyQJHesJr+Ff0DN5k9l5WPh7Xf9dQ13fjalGK6KgRG0NH5uleTwTLyQPJ7F7543l7a9XX2Mmh4vm14k+bEg/S8YRbiqDdioOzA78BDLQegQrc3UAn3NsK0fORHeU/a5Yx1yR6DvZ2x7A9euvpu9E0fD5GiQdGZ7P3G2XqVRr5vQGhuuYjKHi99mdGtxpzdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6toszXUe1Ds/fq20+NhRrkRrjPtESk0AuBs8KWj6TeA=;
 b=qE6YL5mtc1birExHi1NZ1nIpRPb+r8Hz4eTLCyYAdQtyzGi4mgyV4oHgdi6Qxp87WxrmePzwxOOHMzpvvehTMoR9/cjWoDQgl0m6BNEJ+IhuulhTPPk3L5BVN252hMlMStCvJaE0BzInI9kmwVMz/QLuGHu78J6+3VoZKLwB8fo=
Received: from DS7PR03CA0225.namprd03.prod.outlook.com (2603:10b6:5:3ba::20)
 by SA5PPF916D632A9.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Thu, 9 Oct
 2025 23:58:20 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::db) by DS7PR03CA0225.outlook.office365.com
 (2603:10b6:5:3ba::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Thu, 9
 Oct 2025 23:58:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 23:58:19 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Oct
 2025 16:58:13 -0700
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
Subject: [PATCH v3 01/15] iommu/amd: Rename DEV_DOMID_MASK to DTE_DOMID_MASK
Date: Thu, 9 Oct 2025 23:57:41 +0000
Message-ID: <20251009235755.4497-2-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|SA5PPF916D632A9:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a415b68-1c7c-4001-4134-08de078fb8e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5TcEKABjNyYkPJ78bivW0TMzXT18h9LWzVMLIjBKlbnRkTRuE6Z5MwRkU3e1?=
 =?us-ascii?Q?GGRvdKIDWRf3gzJQI7EMy5kUtHGcIqsj/lOOAyuieo3uH0i1mdo+dULGqOtO?=
 =?us-ascii?Q?xylX2zqgT2keCdHe9NXd9iu+i3yt1/Z/5+oLHTdmxD/o7SxqMUjo11k64yjw?=
 =?us-ascii?Q?sGsRt7AzDo6uvQkSvhPORE4XE9sNtnczcXpT2R9ktQo7GGr7XOvzLF/ubnli?=
 =?us-ascii?Q?oelhlgyiRyKAm9HcL1zmVFnkR+IIuSZMlxOg63UlUT2D2CwpPm10hEXBGcMU?=
 =?us-ascii?Q?5mx26ywkwRuqoqg/YYuDX68C/OobJgSAtqQkK6RgBCDb6x7NQ9DxTSZPIaK3?=
 =?us-ascii?Q?4Kcv/bee4v1NY1OUI1qXwuP9txMWuMr3fh6xbFCisfD7UN5uyNqFKH73I6UB?=
 =?us-ascii?Q?6TBdmppBZlvtVg/MOZnrDpsFGClSCrX3UIeAUzK6fjTkAJKoz7G/B5v18vLO?=
 =?us-ascii?Q?LGbalWGxTis8jMHXA1e0UFSiPoli1cMs+ihEjitBmpjXQwLjdj0sSblM3yrR?=
 =?us-ascii?Q?yu9w5jEBVYNczIc/ON61RlA0uutE4L/3HPm4BsSnXm5/hKmm5I6xwgSkp+rs?=
 =?us-ascii?Q?MkU5dmNe+5OYrLsL14zlV6iDPEUgbL4l3zbClVFHFefpQmBPY1WkTVfIGkOI?=
 =?us-ascii?Q?83kn0rR2plSe5Z77vdP97w/QWojLjWH9tpX7kqoHDr+mfmNCddJo2UEQ4x9z?=
 =?us-ascii?Q?7mEBL0De9o1f1ovlIUXvTfpMmolkxzSdajLHSHBzU+TIydtVfWtnixC8sswU?=
 =?us-ascii?Q?LS4y8UrVmeni1Q3ONnRHM2Bp/ojGeuboKtIo+4xVLHd2Yn0BsNWCuETN6f6z?=
 =?us-ascii?Q?o6z/BpHC444gsyFVcf3srm1lvavxejbouAPN4E2GesBt1LNCcMeezPy90J20?=
 =?us-ascii?Q?bfbgkrBL09XmpgkMvczvCiIrdqSfZQy9D+7G4CWSgZ2Avsmx6LotVem8OFvG?=
 =?us-ascii?Q?APtSkg/VdyxWuxLthOhlPKyt6tt4JgGB2ybQ1pr1HYU9EHEkVJ3AEcdK80Ah?=
 =?us-ascii?Q?lxJrwNJB7XCWn9SyV/tA19wrWuuDRgdNF2YNbxEDiyk3QOyutPD5svufjKAA?=
 =?us-ascii?Q?JUnw5QiH3CWAu/1mahF0ZnrJhrxJfZB8JXj13QHll0HqxepGx9uq4N90Jeeo?=
 =?us-ascii?Q?6I0NMocpjrlCo5Dt+mS2xAg0UCJG/3ZLh3tVYRv5VJOeoJ9kxiVHf3Maey9F?=
 =?us-ascii?Q?MvE4d8LyleZnkdPAHQ2GQNxqm/MdXULKV3E6B9+SLMqKYsK+xHhATHw7zpG2?=
 =?us-ascii?Q?CvOrFqa36zYkb7MSI2QJqrRZ2UiXzWnyEGMXG6lVEVmc3BnX1LkHPQGMYx7H?=
 =?us-ascii?Q?nFe6QzS642ZoNCyGgUD9lQamjmOMtWsT8MRadvced/mAV8nwpeuRSemgfkyq?=
 =?us-ascii?Q?A5yniYHgoNRkKp8Zh/FmYsTYFr9zTeWC22AOhd3mcLWqBn+Ez9a1kJLu6Ck2?=
 =?us-ascii?Q?Y6iFcwl/VAe8dY29Pl005FzEZBLj535XlETZ57v7JP0TpNa8EbpnNAeOgQmy?=
 =?us-ascii?Q?e/2m+AK7MqwpKjj6n4WjlSEyD61bHIyRJsD+Qs5l9TWM2sqgHlKjAiNwkWP1?=
 =?us-ascii?Q?+btDwPk7iSO1avYbLkA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 23:58:19.6214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a415b68-1c7c-4001-4134-08de078fb8e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF916D632A9

Also change the define to use GENMASK_ULL instead.
There is no functional change.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 2 +-
 drivers/iommu/amd/iommu.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index a698a2e7ce2a..556f1df32d53 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -422,7 +422,7 @@
 
 #define DTE_FLAG_IOTLB	BIT_ULL(32)
 #define DTE_FLAG_MASK	(0x3ffULL << 32)
-#define DEV_DOMID_MASK	0xffffULL
+#define DTE_DOMID_MASK	GENMASK_ULL(15, 0)
 
 #define DTE_GCR3_14_12	GENMASK_ULL(60, 58)
 #define DTE_GCR3_30_15	GENMASK_ULL(31, 16)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b57a6993179d..a9b17d31a969 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2094,7 +2094,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	if (dev_data->ats_enabled)
 		new.data[1] |= DTE_FLAG_IOTLB;
 
-	old_domid = READ_ONCE(dte->data[1]) & DEV_DOMID_MASK;
+	old_domid = READ_ONCE(dte->data[1]) & DTE_DOMID_MASK;
 	new.data[1] |= domid;
 
 	/*
-- 
2.34.1

