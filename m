Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AAE1CDFBC
	for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 18:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730400224; cv=fail; b=CFN8nxoMxJUxycc8L6RIW4QlXheZo8BVIEvK4BFLsgvgadMYsjxIRcleiO2zNhV3I0Ny+ej/Ml5dQkml76zX6adr9/5uUx5KdxDa65hXchVXDflebQAInZ3yCmhpEIw7lFfYrLr/G2k/fKv8g57qRGkUiaEIWM3rvtZ8JyUEGKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730400224; c=relaxed/simple;
	bh=D0wT/KPOob419H8a7ywwVXAG7CRLLhE+8O3VcZJfVx8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tCkk/W/NktCkgdOI3MiYA/w2LUNB/sUjXX84iR2Rx61GN5PYiQZkZCvKn6tvkXIiaTYHwxUOD/AvB827S71ExiebqUwy24ILZ/YFk8UaMEGgV44310Vb4pCl90tuS5PxdBnpOUYebB/0D8gLe1Nspc5g4TN87XJrTPCKuFGxS8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gYdrWuHU; arc=fail smtp.client-ip=40.107.236.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gYdrWuHU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sW//lW4JiTaTXTrwrB7QlvKqvnRNrsfT5b2qUzf6dEDLiP23vql7zaBa1a0zdC7m7lPX6xHRBxf/fqYU+24HykDtDibWyqImPF4jy5h1IBMQJ7VapqjpI2bJCNtoyHMht9GRcsjG4BII9O4sxxOzU5hcs8CrFSINR8njPC/3bc5MsISPLMRIGDaR/WRH+E6oTHPeX0UAD4OnZz7Q7x/iFNIqQ3p+4FT0yQjB8JWDfOlKvY1ds9tkAFzJ8pJoz4Lkn9G+EBAYd9WRk4fxUXsyfb45YjlBiknNm0Aweq1jXEFJnW+1RPoF3ojJA87zLEYCH+/xAEqOVfFJky2H52m+uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSK8nZP4RcgWxlR8jBJDds4tamPMaiIv9Ra0Rf7BW44=;
 b=cMVGucVG1RUpeiZRfvH2nm6k5Icp61twUoDrkUSTZ2+3F3UGuLJ+zisYz43qOVEFSYihrDs64n27sNzsuEqWz2JD0K0rA++zzoxfakFTIcHpSftbVndv0CSTE4ANZMksp8/KG3+X1pMK8zlC1jzM+Qyqu+aURTUh99sTVgbGrVJvXfn2IHVjz7NGtLYkGQsAp3BXPpr9kGrAd2kKxV/3LjQPdrD01m0pJ97ND+nvqU/X/ccNqaOL06iA7brkak2aRmK85gJ5E9rsGzxWqCiGC5adkoMfSbqmjolIXLqqoD2sVoYAw5WRo2Vik1wfxDYpakLWXABQwOKBS6ENnn+6Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSK8nZP4RcgWxlR8jBJDds4tamPMaiIv9Ra0Rf7BW44=;
 b=gYdrWuHUhpwK1z2XKS6KXz0AwNXmHiDsnwuo/oVqYyHBEFvuBCr3KH6/FVji2rDomJl4smk/7pEvqpbqp7IjvtqhMOLPtwQ8rWdm3ImIciCRBjFggq2tZDUDYkmPmQ6Hh/D2/6wJ1lPmeSqTuls8j2P3GVa/rP+9IYi0aFgjW74=
Received: from CH0PR07CA0008.namprd07.prod.outlook.com (2603:10b6:610:32::13)
 by IA0PR12MB8277.namprd12.prod.outlook.com (2603:10b6:208:3de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23; Thu, 31 Oct
 2024 18:43:38 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::dd) by CH0PR07CA0008.outlook.office365.com
 (2603:10b6:610:32::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.22 via Frontend
 Transport; Thu, 31 Oct 2024 18:43:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 18:43:37 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Oct
 2024 13:43:26 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v8 08/10] iommu/amd: Modify clear_dte_entry() to avoid in-place update
Date: Thu, 31 Oct 2024 18:42:41 +0000
Message-ID: <20241031184243.4184-9-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031184243.4184-1-suravee.suthikulpanit@amd.com>
References: <20241031184243.4184-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|IA0PR12MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: 4085d3a3-f893-4c75-24e4-08dcf9dbeede
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4qbFMVfhhhP+GyIhNleYr1heuatzmqPWTZDe6cLt8zkHLHjG11PknLlmiPfu?=
 =?us-ascii?Q?TPn470KSEiLJO8gWTVsfOoJ5rBpSN6TAI8nlsfj5blDWOGVck4cBVnAxyMaX?=
 =?us-ascii?Q?0tczMbD9Tg6uwzjsqUr8aqjKYknKR19IgoBRizcEXyxaFGAmaiI/laPkp8F2?=
 =?us-ascii?Q?pg2eiIQaaX+dGBzNs3oB56n3OyM+/0pw0bJ1SLkTK5J0bx82YBn/CG3tuu8h?=
 =?us-ascii?Q?yJNOBNm5+LdZ0Mwx29JOu4pBdpY6Emk1m0PRLbOGDvmA1oHRZQKg69+u5H5Q?=
 =?us-ascii?Q?fp7vEuyD5w9P1cfZ6wmOQMo0QkymYHTDQo0wvbPdSn5Q3Kvei+pPNRjOoGXn?=
 =?us-ascii?Q?5s6YZUANa8B5pujH27qFJsPSkbPLM9cZ8UEdNHHApY9bznINU/C66m18rVZw?=
 =?us-ascii?Q?Nfi9IpzC97a//Putr/EeLsXmyQ669aYXmzXqwOfVt2czvNKd+niPvxbw91Sf?=
 =?us-ascii?Q?1jVsfQ8kCdho4E0AYE/boU+Rs7MTzl9PDIDL+paHgoA5aBfo6ae8fQQmXCVq?=
 =?us-ascii?Q?eljo9sNbGG+LHH3KVbjkA/XYnLo+hW+9++r8Q4S4ZbrFrjUMokFRNzzTNwL+?=
 =?us-ascii?Q?KUlhwDT7KD6qGZb8+iluYxvT/kCo4o7nm9ZOVwNz1cV+FUpF8NgIUgPuTT3S?=
 =?us-ascii?Q?eg86WY1sxjGE6zX5UMUPQxwYqVXk/1pX3BvQu9rHmNHZjRiqC4IVz2dO57Dr?=
 =?us-ascii?Q?DjP5o6WWM8tVpfmvjceOmcewK8rGz6XqIIYWikisUeE7u0MKuG1LTAKlBe04?=
 =?us-ascii?Q?oETSb9BeJuMiLkgFmhxiyphW2IPWBCBMMZmmX1eppyp9s+5kYGeS0TXrMKvi?=
 =?us-ascii?Q?OIcQ8B1WRs3h/oLYIpIUgwteG9jgoUJI9vDU0dGNg0stR/E2L4ER/kjVGcU8?=
 =?us-ascii?Q?y23QM8cvbQLexrNP7pERt8QgW0K8wFx25+696ITzC+jVKFLANmELwxE6/lC7?=
 =?us-ascii?Q?Ci/sZFhKTSoyVJ7Ed5lWf/5h5FB0LnykjGkPwQIyNaJh6bqxdc3ee6ocnXW1?=
 =?us-ascii?Q?AEMhd0W9ezKQXMXTLdxE3z8UIVk5YVKiARM86sC1N8+Ax2WJx5EJggOOpdaN?=
 =?us-ascii?Q?ljLVlLyDJnNG7Hs01jMpRdl0AA5nYNgsePJZ5K4ZdfBsyhn+yS0buid22Xsj?=
 =?us-ascii?Q?MbEnPy9L2EzKaNUYfAS0fNkEFdC6g+Ykv5VbCY9Jw6zdjkcZtD9kmF6fZipe?=
 =?us-ascii?Q?Z2NvWBdSZZVKQR1+1+ihmqNW9ryuxNP82RBHZtLzddSWTVoYAGqgysN4oRL+?=
 =?us-ascii?Q?+UR18JSMRlS8UwGF17zzHQnGAkhw4R1uDlYGtgp5HyXWDZJKBG9dfoBT17fG?=
 =?us-ascii?Q?+9UslYgbSPwXTH2/5t4aepbhAtvzethiEOMTZ46hLmI4G5p8mQiecSI1hA0p?=
 =?us-ascii?Q?QvVrfY3Rwn0AT3BuRNUTNaFbdpNIyS0FfZesepGwo0nW2fjqbw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 18:43:37.9676
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4085d3a3-f893-4c75-24e4-08dcf9dbeede
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8277

By reusing the make_clear_dte() and update_dte256().

Also, there is no need to set TV bit for non-SNP system when clearing DTE
for blocked domain, and no longer need to apply erratum 63 in clear_dte()
since it is already stored in struct ivhd_dte_flags and apply in
set_dte_entry().

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 1262ea7150f6..f0ae0d7734b5 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2111,19 +2111,16 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	}
 }
 
-static void clear_dte_entry(struct amd_iommu *iommu, u16 devid)
+/*
+ * Clear DMA-remap related flags to block all DMA (blockeded domain)
+ */
+static void clear_dte_entry(struct amd_iommu *iommu, struct iommu_dev_data *dev_data)
 {
-	struct dev_table_entry *dev_table = get_dev_table(iommu);
-
-	/* remove entry from the device table seen by the hardware */
-	dev_table[devid].data[0]  = DTE_FLAG_V;
-
-	if (!amd_iommu_snp_en)
-		dev_table[devid].data[0] |= DTE_FLAG_TV;
-
-	dev_table[devid].data[1] &= DTE_FLAG_MASK;
+	struct dev_table_entry new = {};
+	struct dev_table_entry *dte = &get_dev_table(iommu)[dev_data->devid];
 
-	amd_iommu_apply_erratum_63(iommu, devid);
+	make_clear_dte(dev_data, dte, &new);
+	update_dte256(iommu, dev_data, &new);
 }
 
 /* Update and flush DTE for the given device */
@@ -2134,7 +2131,7 @@ static void dev_update_dte(struct iommu_dev_data *dev_data, bool set)
 	if (set)
 		set_dte_entry(iommu, dev_data);
 	else
-		clear_dte_entry(iommu, dev_data->devid);
+		clear_dte_entry(iommu, dev_data);
 
 	clone_aliases(iommu, dev_data->dev);
 	device_flush_dte(dev_data);
-- 
2.34.1

