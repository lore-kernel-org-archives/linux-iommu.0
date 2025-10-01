Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013039.outbound.protection.outlook.com [40.107.201.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671EE2D7DEA
	for <iommu@lists.linux.dev>; Wed,  1 Oct 2025 06:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759299070; cv=fail; b=tGyk8AK4pYTicN/tWAZze6/IsZ+zIMpyHHEnYqBQ/W8BHsYE82w3sIuSMdoaLl5qjIEsYrGkBh0Ro3dGSjjZcVMZn12JY37mrbZ6c8L7w8XVEXu8QhyetaPXepZliKxzG0FUXGCis/cJEzL57qW83YujRYOoPwcs6JApLdT9AFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759299070; c=relaxed/simple;
	bh=XoiQgTSE57ZO1LjTEdVNrOdLyxjBUfkxLT1WkgXfqhc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mCDeX16vrk80q293lR2SQSBI/W8bzmxQsPlV0dOVaO/COzqtql29cX3pzkVKdNifpJnWEWQJadNhFRXFHqMxiVDwNmNRLgAhF3H3ZTrEOESbyxAIvmOdnrfbgl/3D1qKwEr9zWndiaRjRj+a04QKqmfPknBJXa36Lmys9LSohzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Arvq4uIT; arc=fail smtp.client-ip=40.107.201.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Arvq4uIT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KCV0QTpaQNvtWMV6Oo2kQ13lYTJdkqvZiQSuq72nd7IUYAn4v453gZsuLwEnp7fpwuhT2Hvk7owWNufe5I7laukGEfBttSZUlS6OxT3DmBCvrLnpXp7IDK5g4+uB2s6CB0j6LWyWuJVndjc6tgbGjEVGWkq+2fKzkg6P7Oix/ysnq18lDa+nk1iaOmix44IS2yATER16u/ScQVDZYtNbhCPSq/r0cDe2uVXzQyQpSDYk02AkI3zHRcwt+qYH/4D67lMDhb74gmXTu7NJdKSztwHqVKviulrNTe+BCwO/1hfs+fxOVYuuZybEhZyzLeBrOTUBkgOD74eClfkPhgbXYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6LinOVJGGNxsvHHJk/e2OQ2vSwM4Np5K1o1sX8XVp8=;
 b=hb7jIf29u4BcTqv9x4ntFFkmIBNENGu1GmrG3RICemGtTZ2wkxomcimj3AvOuq3CnTIWH7QpsQNAziTCQOYaz8k2fq6omXgUku7PT/cnzfvqG3mHcXs/LHOMIGVI08GXvQGEUEgOH6YtAHma0q5IBlhNRA5PRECqTivJRDFUFT8Tp+npN18+RLuCZd/Mr/E1sFOcjQMFczX6efMK3fC0P6cK8Bs+3JVHHsingtZUDg93KZOw6HV4E0echSbKzuJ3Wmqji9h8C2MwfUm81rXIaI/sM+iilTwpvx3aAFnRX1bn9rl5dI62Xa+Yihbcnmj0/c749vcACtPZRIauoa1nNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6LinOVJGGNxsvHHJk/e2OQ2vSwM4Np5K1o1sX8XVp8=;
 b=Arvq4uITJmqzuusQLXxWlAY8YIsE4nZQ9d5tKB2V7DnelD0Y5IK/lECPlFpiEnAMwoB0cqQamBsraFwE7hknWQfZJ1DqPOKb+ZKgcfQaqZMtQ8T7vyz7Hj5cgzazhWU6zqzp4ndSuiSunDiAOm1Wy0or+aJimeLqx46vCierTsc=
Received: from SA1PR03CA0023.namprd03.prod.outlook.com (2603:10b6:806:2d3::28)
 by SJ0PR12MB6878.namprd12.prod.outlook.com (2603:10b6:a03:483::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 06:11:05 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:2d3:cafe::8c) by SA1PR03CA0023.outlook.office365.com
 (2603:10b6:806:2d3::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Wed,
 1 Oct 2025 06:11:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 06:11:05 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 30 Sep
 2025 23:10:59 -0700
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
Subject: [PATCH v2 09/12] iommu/amd: Add support for nest parent domain allocation
Date: Wed, 1 Oct 2025 06:09:51 +0000
Message-ID: <20251001060954.5030-10-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
References: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|SJ0PR12MB6878:EE_
X-MS-Office365-Filtering-Correlation-Id: 24f20304-0829-44bf-35a1-08de00b14e2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T+r6LXC9aKAX75OWHDcFxm0i9+f6nkgMvPDMtVlTSjLV8C3rRy/QfGWuObAO?=
 =?us-ascii?Q?cBE2/zXajmxn7Rb3BUL98rrPwPnmLGRLQxmVFmifBDN3mjfK7FgJoXRqsqFT?=
 =?us-ascii?Q?3CdcCnjPdO1fJlJwf1DxtiLzpgFewlQjH2SI7kDwkpN9sts5pBi1DmknjMlc?=
 =?us-ascii?Q?4hxDoSWqRlGOQamO3MnxGWn6dn8dnUhECo0ITRsb7++va+eGaismq7w1BPd6?=
 =?us-ascii?Q?qeiAmGYXQM7waCtrNrSPZEW/NYOn6SVWikoOiy//5hqPXxtB9FoynRAaO0hs?=
 =?us-ascii?Q?pdzxU27GJPvI1rPFXw0Tj81XP/3SF+FdW6sZ3WtlkgOTYHPQcmntcgiU84y3?=
 =?us-ascii?Q?u5VKXpYW7V0D6cR9gAOEn4usMGjfX1hRwMrh5gREoIKrsXQfk4pO0BlEmQo9?=
 =?us-ascii?Q?Zz4DGtW0QgchZosERVb9JbUs2Mnwh/4/7rF5o5DOOyVyfApt/cnPxSwtybQQ?=
 =?us-ascii?Q?Eao1o5KYFUn0mZySgKiZUVzhvpgd662DK4PH32D9dXMtqvtZvyy/rLIZKZDH?=
 =?us-ascii?Q?1DO2/OnL979RUQMClcUY1rHtpziMtthzR789p+priKY5XLZwdPm0YuZ/lS12?=
 =?us-ascii?Q?fzAOmnrpUssLzKUfmgrowYQUADW7q6mG/Fe7QePTJjxkKGqCebpHrZSJKu7I?=
 =?us-ascii?Q?zr68fXfTFQUB1VQy4ARJyQdXP+u2r/X0CTVLzpYiZKYGyY2NXRKhxbW4qFIh?=
 =?us-ascii?Q?POtDOUFCfrEJvT3abODzOhGqCUePfPNUBTNQ9WmlQCHbKn0oVcetCv2UWi6D?=
 =?us-ascii?Q?KidUBDWemRYLCABgb9YAOW/GmZwU1qVBnKx4/Ih7Yr0Dkt8VW9K2eA+DfXyf?=
 =?us-ascii?Q?tjS48m7c3ueoJQgQmUqlYn1Nrx40Q95ULZkgGRaCNRaG9B/dwBP+5Lt1lr4D?=
 =?us-ascii?Q?mw4CKlRBHAu3RWPC7C1e21nK+He58oLnrKmxTS+sQIvzlbH6a0TNjINmTA6/?=
 =?us-ascii?Q?Q1ph4jw5c1pQbzLMaxgiJaj1dCscgmkiOjGgDB14+QpFOATq4SkJOD2FXp0J?=
 =?us-ascii?Q?XgfytMDU5Cjz2dyF3rimdsVkWuDayH8sLUJagVs17jGuPbo2yZZg/Czgjmlb?=
 =?us-ascii?Q?NOyOPKtF4+fmJaMNYfC/WCeXSn85xNLlAbeIWu71OxFd0VoJgTBBzfFhVe8h?=
 =?us-ascii?Q?YEcK+8kisC5aEDtvAvtZg4yVE5mXUaEFTEpBRpT9VyjAMcazlN6xyn3Z9nGJ?=
 =?us-ascii?Q?/f7Lmh9HJI1HVjzcY2Cb6TvaWBKell8ojX/9Eg/JXObhT2hf4HKOMhXOjvD4?=
 =?us-ascii?Q?/OFovBZrE/kwDQiWS2NBU1cYqgBtarm9MJOqBAx1Xne2b61RGMZDoECwbYQp?=
 =?us-ascii?Q?aLYXl9iCziYH0RI2StsR5jqVtbVmeGBB6UlQuDAdzpS7vKt3IiVJc0N/SEDs?=
 =?us-ascii?Q?t9Gg+uLCkiz7/uQ1ufAm3TpDq8Xnx8DIhmDKUdkZP37t8/671LnG88ld4tfY?=
 =?us-ascii?Q?UP5dIE5/pVLEnEGre1F/H4ewwlsEtY5dECWg2jdQU7+QflYrlxKG0MBxyQfU?=
 =?us-ascii?Q?I/BA5oDD06Lbg+GjvJZgo5DL3O+Vbjpch0hn+9x5xeoxAx56BGvQsL1qnJvU?=
 =?us-ascii?Q?Fq3wCweIq1JMM7EQ+34=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 06:11:05.3165
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f20304-0829-44bf-35a1-08de00b14e2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6878

To support nested translation, the nest parent domain is allocated with
IOMMU_HWPT_ALLOC_NEST_PARENT flag, and stores information of the v1 page
table for stage 2 (i.e. GPA->SPA).

Also, only support nest parent domain on AMD system, which can support
the Guest CR3 Table (GCR3TRPMode) feature. This feature is required in
order to program DTE[GCR3 Table Root Pointer] with the GPA.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/iommu.c           | 27 +++++++++++++++++++++++----
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 556f1df32d53..d8c755b2045d 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -107,6 +107,7 @@
 
 
 /* Extended Feature 2 Bits */
+#define FEATURE_GCR3TRPMODE	BIT_ULL(3)
 #define FEATURE_SNPAVICSUP	GENMASK_ULL(7, 5)
 #define FEATURE_SNPAVICSUP_GAM(x) \
 	(FIELD_GET(FEATURE_SNPAVICSUP, x) == 0x1)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index e0bfcda678a8..facee0f7a131 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2584,6 +2584,18 @@ do_iommu_domain_alloc(struct device *dev, u32 flags,
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
@@ -2591,15 +2603,22 @@ amd_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 {
 	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
 	const u32 supported_flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
-						IOMMU_HWPT_ALLOC_PASID;
+						IOMMU_HWPT_ALLOC_PASID |
+						IOMMU_HWPT_ALLOC_NEST_PARENT;
 
-	if ((flags & ~supported_flags) || user_data)
+	if ((flags & ~supported_flags) || user_data || !is_nest_parent_supported(flags))
 		return ERR_PTR(-EOPNOTSUPP);
 
 	switch (flags & supported_flags) {
 	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING:
-		/* Allocate domain with v1 page table for dirty tracking */
-		if (!amd_iommu_hd_support(iommu))
+	case IOMMU_HWPT_ALLOC_NEST_PARENT:
+	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING | IOMMU_HWPT_ALLOC_NEST_PARENT:
+		/*
+		 * Allocate domain with v1 page table for dirty tracking
+		 * and/or Nest parent.
+		 */
+		if ((flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING) &&
+		    !amd_iommu_hd_support(iommu))
 			break;
 		return do_iommu_domain_alloc(dev, flags, PD_MODE_V1);
 	case IOMMU_HWPT_ALLOC_PASID:
-- 
2.34.1

