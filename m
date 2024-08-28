Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7896C13D53D
	for <iommu@lists.linux.dev>; Wed, 28 Aug 2024 11:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724843492; cv=fail; b=od9lQMYFX+czwR1rhgdT1kXUE4kWTekM9xRMZRrlGq5zht90gf9SabrjmUaHK/ncQoZm2TwscHKx0trCW2D1XqGjxCCOh7mF2VydzX3H/f1uHC+x6enJ7NP+QyvLxvqDyBJNavmpBmjgZDm6QULQtUBtzF+YTaScGGsCc12/5E0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724843492; c=relaxed/simple;
	bh=42mFuZA5FlXtNAZMDTokpUWVwKILwx0BvvmHG3axBII=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jRz9AlYE3DwZqMG0Dj+/UYLD6SMIbkklXJ/01u42J47fPUv3JkPg7b+YyVRPj7TxGaXeibwI5bbUSj8d+0zd8vEKPd4pDJOADN/7IeNs0/V01w53ERdWpn82wM7A/pgeSuJBIqaGeEJPdTv/bG410fYTv1ZFIfvG/hGVt9LaMt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HX5FQECX; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HX5FQECX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AOE8ulqgTV1xiFB6WakIgCL0GyHfOZa8IUtssW7zTBDkzkXTSq6JvjU7jsvRadtG2EYYsOHyHjD8wap5wCzwekfgZyTtKL4f1YmjFg6XynMRLxwhRGYe1eFD+1UnmSwqKz65/frek5xWqpjoj2p7yMYY5faNAcg0AbTpNY1Pve//sdyfjZQe81D+tHL/s2KdpVQEsIT+HkTnbJuV0nGqsqW616JmcFj1pk2gnpatUvcb6cC2AvJc9nEMl2w8c+yZZgkujCc0mwo4Lpgf+6XJGMZ5/phjQyExRH9iIa/WcH+7dCGEwS8orVSN2dOtHOY+pOlH+gulQB+fblLmm94wfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mt9Vqgg3mL+aFezlmkSaDsxST+vYgf8H44/15ym0i7M=;
 b=rLJRChluuXqPALl+gFMs0ATTmVkia0Q0sp7D9UsSB/fO5K0kkcieEYtO4Ucs4M/Aj6Y5hylFd/78C5+6qw0HWwKJoPshfsxaVSzMtRBrOiUykXobieu2APGnSX8BDDusBSuKHAyQ8E7mwtQ+he1nU0jC1wJxWEalLezxE5qCR+xKcL42qY1gLOpF1pUf/DfYvj19tyslWhXv/4S61SMgqJyCk3w7FVLf1zz3+1c6dDq4OfsF4n6Bwpw5rQBuB0P+J2K7y1q64vCkl9GK0Dv+KvUa7FHfDLUykGeU2MsIHHNXeYQ3dDeF79UE0ItOpc7zmv1rLxI+inQcuvC4MG8hsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mt9Vqgg3mL+aFezlmkSaDsxST+vYgf8H44/15ym0i7M=;
 b=HX5FQECXRMASoQH2eNXIWkcBYOCqKhBR7/fY0judCM98wjuIH79TbNIh4rwkkV8sePy/w85CFPvoFGayuj+awyaYwQaouZ2MkKrB/TRjsb/4lFjJc9DYfE82yF7A23+z2g9Ur2n5ieXSiUEZSjTBxS94yWD7UpN2zh8Cvc08o5U=
Received: from MW4PR04CA0039.namprd04.prod.outlook.com (2603:10b6:303:6a::14)
 by SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 11:11:27 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:303:6a:cafe::82) by MW4PR04CA0039.outlook.office365.com
 (2603:10b6:303:6a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27 via Frontend
 Transport; Wed, 28 Aug 2024 11:11:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 28 Aug 2024 11:11:27 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 Aug
 2024 06:11:24 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 2/8] iommu/amd: Make amd_iommu_is_attach_deferred() static
Date: Wed, 28 Aug 2024 11:10:23 +0000
Message-ID: <20240828111029.5429-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828111029.5429-1-vasant.hegde@amd.com>
References: <20240828111029.5429-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|SA1PR12MB8144:EE_
X-MS-Office365-Filtering-Correlation-Id: d1e7a051-ff72-4aae-6d18-08dcc7522938
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RQkTDiniCQhar+e2AcN9k/pcy5eulShxdiMHlypW5FrLDyyeC/Pd/5GnYyit?=
 =?us-ascii?Q?/DRURr2VSIyFYI0lSdfIhMzwH3FrFlnbU90mQacljlyXxAxOm9iAMzg9MfAa?=
 =?us-ascii?Q?3gN0FgDBzFGHyDV817mx+ecNfTjWK9T60/pOhVGJTyAiaURtTJe17/Owschj?=
 =?us-ascii?Q?4LpDd59s6iNY23CNIpPIVhHg3QO3O07ttGL6fXQBaEJZApED64W64aihRzCZ?=
 =?us-ascii?Q?vjWntjiIbCFEpboy5ceIAQDeHt8LuxPr82I/xR+VlnTCv8nBEQfhGll9YPJ1?=
 =?us-ascii?Q?Mi7RQRmc7Y4me+V1UWA9tNl6SudIGjuTZtafHGjRza2XcPqk4Z9TlWBs+BPj?=
 =?us-ascii?Q?/NWNQOMwRoES1scgSo/IOcgUnwAEdeOo10/KvDYYsSNBfd5qOabNjcgatgEt?=
 =?us-ascii?Q?EimgZzkWNojYmZnyKeJLJ+OpLcYLGTftHfRnd72x1Xp7sjJy+XtxzetLi5ol?=
 =?us-ascii?Q?1al7w88UzCeO8lFRclBdA04gjxGfoDmFe3hpfnTdxwXg2pE3hqtdm45ybQky?=
 =?us-ascii?Q?qwmb2uTwLeXR4eL0ZdeaB7Tmss2c3wpAGLLOIebduhYvQHw343SPtbWl98iZ?=
 =?us-ascii?Q?6Yn1bm9p+IXrbyKMMgZNUG0ghFue0q91d20zxdpJBSTWm+v1WnCOVbhrmEgs?=
 =?us-ascii?Q?N3FWkmGCM8lO/75Gf+aupTik1nNLzZ8IvLFJdGvacMigDrns/SeMipku0ez5?=
 =?us-ascii?Q?5PFyhlw2J8yzexU8OQhzqf7FDIBp2+gYo3Oj0niHF0j9oG2K0ZLt5yBj7bWD?=
 =?us-ascii?Q?q3xjWond/tHg6LQZJRVnLQv+du0HClheJBRmi6WNpBk5bhJHtIy4XXERubXZ?=
 =?us-ascii?Q?VWKssOVKObXGtOlBvXvNzWSoZj9HHV8U0p/FwC4e3Nb0J3YMWh44MH44bAko?=
 =?us-ascii?Q?rPnWZ+6mJ2WE0X5aCspnO47nYv9OUlTf98khVhgdEA7rb548qOJqdW9/rvLs?=
 =?us-ascii?Q?mm1eSZ10qTyNyREFZi2vIS/k0dSGVuI6GUnjZrwDePnSjHSPJrRUQ1b+blkR?=
 =?us-ascii?Q?jZCWaWz8edgCo8Meqy7EVenAVnTfs1Rs/VW23n2pgYVGFIr8rNPiOBpl4KFK?=
 =?us-ascii?Q?oOVQyaiKHfDieQvD1oNhOakFoUDfbHQkdFiAvma99vs1SVKcqg55K8rVtS5o?=
 =?us-ascii?Q?SkDozcfq7NLsctgIN8aSeoxG2gTYuf5GcdI4ekVIN24zCTcg5DVX03JDNJFJ?=
 =?us-ascii?Q?8RkXLXQIzWDHDqybNSz2bbNXQr8DngeWEN+tkQyBwU1B3lpgskpuC33QOcfj?=
 =?us-ascii?Q?WM/b7zdYmBugKBveDNbiq+uAEfaMwkktLvxCgEtK8vVj7USNk7qIfMEs19y0?=
 =?us-ascii?Q?V+kgLd+YIBllJael3QKx3wS0CFl4Cr7ohiQAriv+bB+Mcn+cHxXOmbli/0wM?=
 =?us-ascii?Q?DpGWyNUs9ppadbbV05lSTkN2GyExH9GgoSRD5TLord76WK2Ryo5WLM2E2UGn?=
 =?us-ascii?Q?BR5N0CzVPgxwQxsjLsfM4kVKiAjCCM6P?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 11:11:27.1171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e7a051-ff72-4aae-6d18-08dcc7522938
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8144

amd_iommu_is_attach_deferred() is a callback function called by
iommu_ops. Make it as static.

No functional changes intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h | 1 -
 drivers/iommu/amd/iommu.c     | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 52e18b5f99fd..a9e207ec2bbb 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -180,7 +180,6 @@ static inline struct protection_domain *to_pdomain(struct iommu_domain *dom)
 }
 
 bool translation_pre_enabled(struct amd_iommu *iommu);
-bool amd_iommu_is_attach_deferred(struct device *dev);
 int __init add_special_device(u8 type, u8 id, u32 *devid, bool cmd_line);
 
 #ifdef CONFIG_DMI
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index e13e401c52de..c57ea47183c3 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2785,7 +2785,7 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 	list_add_tail(&region->list, head);
 }
 
-bool amd_iommu_is_attach_deferred(struct device *dev)
+static bool amd_iommu_is_attach_deferred(struct device *dev)
 {
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 
-- 
2.31.1

