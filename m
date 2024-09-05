Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B197483CD5
	for <iommu@lists.linux.dev>; Thu,  5 Sep 2024 02:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725504068; cv=fail; b=rQhWUtZPyj9aGwneecnqfliBp9lZbKn8+9+lEbLPqCXOnZ10k11QxjoJecf/Zc60O1gjcY5ZN7cuP4uWyUKiJKT5dTKkHlnWE9c4qr9MupJRrGz9ByDkK7grjfLr/IAqj7PB6VROr6eCCFHC/veaPrY0zax6CD57dwYWSoYGYfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725504068; c=relaxed/simple;
	bh=++bv1aUfSbXv/1WyBvgOjvbSLX7cQ6aweAjON4gRqVU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CUr15Z5o4B43LIF62HTP6oj0u1oo8VGitNtMF99KNYsxFNnBg4OI/CWo78ZfF+ZVa7krx6puO4rV7QH0HCh3O8o1JVUI6s2CD6Zb6o/5Zqk1aYALoteEJkOztiRW/fM8DXxzUO+lebOgd5zMDOqxEY2CaoRbFnqaqQfgIlWZ/wQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qdujY4MA; arc=fail smtp.client-ip=40.107.92.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qdujY4MA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qVCP+arzrEWXtqZqsOnn0liEvjGxmd/Qvp/x3TDc+eO9iA0HFm4BarbgUCu4VmkL/sOKEfm6lUC+1nlaofGo+L4IQDxHpU4dxrvFyxYkxgwBGWj4/YRTPJ2Sxbn2M379Fw7mpKC0M91k1EeFmwIlvHCRny3nuiq5CNqaXCkBEDR64fBtkmfDMFFzYEWEBRBUVR8DZ8eWPdIGDtOODRUqVr/Qq3d+2Rv70BuY5dT88ZX6BB5B3MZ8RZeH2U6mseMzNUbeLrVfnFXw2tA4ErCGPFEdgOqgffvo6pqU6ReFOMymVJna2d/YtsS77WOqUxeUlq8uvzuCT1jTyKmNBfnnkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8TibWp9FpTNLL/o3oqHvhsK55sU8YtcPbhfctcehuuA=;
 b=ImEhVvQiwHsyJU3vMoC9r5aFfKAysXSs5yHrf8fySID7aI41PYgQnJrghuZi1JHxLXalSNpUEampuGg6wrGxKR/ek8C+VLWDM7o4OVKYt3bz3u5ofFt+0bRPAZoU91xPhGPHrRAXyIN+cia/rL7C8xuGd5fmRWCtKFDXgnEFrvvnNWEvYsjaPbO6j5ZIb13Cl+sZZmkEkakRg72nUKv4/EbstbSFQrh3kdoLibEpUJ8aVzOTR5CCQnWSvvgp1yuPqqdyE3YFbtu1pKQ8Bt0/CchMyYAjRFXImVsnhcYPAcfcRP7oegl40W8FHchbjKpi/S/zsDDH6da0K9TlJWgjFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TibWp9FpTNLL/o3oqHvhsK55sU8YtcPbhfctcehuuA=;
 b=qdujY4MA6UGM4Zb/S10XuNc0OReTwzlPqETr7mEG7Ll5LlyZWhNiJkLyztG6rsturLzD6GthDaygrnOSlHrljyApV1XkZfm7RHwX2pAvSNcxVGxcBih3e0tmkh1LVxF0vxSvhzso82vjC576yEGYEROi9E/FknyqIE0hC2keTqwTfN0KMojSHTJ8f8DbF0CbAZMEnuQZl0zNaLpV+brD+IUXvm78GQj+j9A184o22ekGjsQLPxJwzmO1DdjMTs9Z5BQpIbnu/of7dV3RuAJMbw0QOxb8pe6kVHPdUeK+Fez0k/T2cqHc0vVgmHjghybZb6i/7HsiMXanBfItmhwfoA==
Received: from MW4P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::28)
 by SJ2PR12MB8183.namprd12.prod.outlook.com (2603:10b6:a03:4f4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 02:41:02 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:303:115:cafe::f) by MW4P220CA0023.outlook.office365.com
 (2603:10b6:303:115::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Thu, 5 Sep 2024 02:41:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.2 via Frontend Transport; Thu, 5 Sep 2024 02:41:02 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Sep 2024
 19:40:54 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 4 Sep 2024 19:40:54 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 4 Sep 2024 19:40:53 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <jonathanh@nvidia.com>, <jgg@nvidia.com>,
	<linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <mochs@nvidia.com>
Subject: [PATCH next 1/2] iommu/tegra241-cmdqv: Drop static at local variable
Date: Wed, 4 Sep 2024 19:40:42 -0700
Message-ID: <13fd3accb5b7ed6ec11cc6b7435f79f84af9f45f.1725503154.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725503154.git.nicolinc@nvidia.com>
References: <cover.1725503154.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|SJ2PR12MB8183:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b856bcc-eab9-4d7d-bfa6-08dccd542e99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LMhed7zU1sj26ygTbeAHwYql1FdX2fKusZElvkT2lbUSZTHQJXXzcFd7iLGa?=
 =?us-ascii?Q?IyZHcmyY3eczL7+SLxeGEZS8NwCNuznNsWlo1X33ctdNolgXmc7M5BXcJONg?=
 =?us-ascii?Q?bLMyPReumeSOmO9X2x2WLLJUcuXL4lO5CrX3L0XVK/LGtcQvqWSzDdUILblg?=
 =?us-ascii?Q?74atWtwL0qXQm4SHKiuziDYfA26Q5eMRAdenabWXjN7Boyo43jInfnXxSRZc?=
 =?us-ascii?Q?PMhrKAMr5DF/UGMv0WCaqce9X727Wd31q3ZPg+iFHl6rorGR+OLi6tYVHQVB?=
 =?us-ascii?Q?wDV+jXGAb7QPGN9/jcxaJowC5ah/jiX5rJaz/FMRo2VzKHFdXEFUITaSgHbY?=
 =?us-ascii?Q?28TJ0DKgK0zNmNUgDcGqTkKjVE8HsBAFr/GIFMcU80uqWyIbvjVoQwnfSp7Y?=
 =?us-ascii?Q?CE48z1zcNHSbmk3RixRfIrnAPF7DFjq2VmgE0w52aiQrBwGDC+Kifvwtm2BE?=
 =?us-ascii?Q?okD6m25XFXQBDBnYFToXxp9s7/mojji8Hs+6vNy68VwWgYoWOi75gEDq3AyQ?=
 =?us-ascii?Q?i4FiY14lyFNMWfXEUq2xbYNS5NWf5oZxhDuVH+MY9MP+EzW3Ln5iiJR4v45N?=
 =?us-ascii?Q?BpChT6p5iHeTu3y/xYx4TtowTUONDt1KSRCa4i8dWqbCPw3OdWOQOkQ4X5JD?=
 =?us-ascii?Q?Lhvuw2KNpi1gxF3m1UEmAYIGA1E1O8pCndVWc6acwUKQGJMXf2rPTrLqTZG9?=
 =?us-ascii?Q?zzJpEIA2dVbEvXR4Owcuh/pdbYzWQ6rnWQXcKlxRLfXyeeDkgZREBMe5W6dZ?=
 =?us-ascii?Q?ywuI6O3XdPIQJ6LQo+xfVvbNV3p6MkGrwKjB86xGr39mP2OOY8NGEJDLaSBz?=
 =?us-ascii?Q?bvFBcJTiGZIINpkN5CjLLRYVl814g7SRtZKGhV4cu79PHdxo/7Y7Pq+xST0l?=
 =?us-ascii?Q?/4pPx/YOe5RmjMUtUjNgsmatK8sGpYtecjykmfaTJn0RQE3LhRZ4MgDAkhiK?=
 =?us-ascii?Q?Vhl4xJrSzHUXMapuHX9qtM1y1APrqX1PNAKdD7erKcKyDAN/zHxHfTMWqRx7?=
 =?us-ascii?Q?nt5uSLn/Bf1Tsh0QldgCeQYSHoozgkKW76ciizGCiUDCDn+fH40HblRHTxud?=
 =?us-ascii?Q?jMfAZERqiL5BXQGXCIVpdyo3wOQUS6Kld6lH9IzX2Ono3RrAhTp4fIwov+5N?=
 =?us-ascii?Q?kzXTxw8CuQzCpUwissDwAmGoFnGnpGc6V18lIqM1d+4agrEEsnS4IB7YnD6M?=
 =?us-ascii?Q?D6vE1UC8CZZO/WqxR8pFQb33l7MUsKZlNSf+BUkjTtn6Nbewx6tX+lLrsoF1?=
 =?us-ascii?Q?J04pOdtdj0OLjT486gXWWgN48HZBWah1ELXHA5L2lV8PYX8ZvgN+hnnuageG?=
 =?us-ascii?Q?WM/UXYPoUjTsAckPA7CZo1SwNmFGSEvFTBynJuNkaJ7UZwPxCU98l4AYPCfS?=
 =?us-ascii?Q?dq9qG+NMWw2BpB3L3PNeRdA6edW+FsISYKcTsfrbDXS0bqcewN+7N9lNpTm5?=
 =?us-ascii?Q?r+SPlgISfSZFO/jDZX4S/imNVZn54X6i?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 02:41:02.1761
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b856bcc-eab9-4d7d-bfa6-08dccd542e99
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8183

This is likely a typo. Drop it.

Fixes: 918eb5c856f6 ("iommu/arm-smmu-v3: Add in-kernel support for NVIDIA Tegra241 (Grace) CMDQV")
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 240b54192177..0766dc2789cb 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -761,8 +761,8 @@ static struct arm_smmu_device *
 __tegra241_cmdqv_probe(struct arm_smmu_device *smmu, struct resource *res,
 		       int irq)
 {
-	static struct arm_smmu_device *new_smmu;
 	struct tegra241_cmdqv *cmdqv = NULL;
+	struct arm_smmu_device *new_smmu;
 	struct tegra241_vintf *vintf;
 	void __iomem *base;
 	u32 regval;
-- 
2.43.0

