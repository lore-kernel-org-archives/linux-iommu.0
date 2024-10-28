Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C534A1B0F3B
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 09:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730108438; cv=fail; b=aJBv/yTONrmLt3+fT6AkX5p3lhZgE4uoeQH5Wd9Wy8QhrnqYX07JZuXgrLGFZ6axa3rmPzK4dTjlYirGT2NYZXG+wtMytvMFnoTN3eTzWCsQT/YpHrKAmfAdqWWMI9R+HA5qTJ3ghmR/6NqHFmvt6g2Xa3PF1cNANr+dDgkzPyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730108438; c=relaxed/simple;
	bh=EsBD+Eb8HXXPlyNaWwptoxX0VraCIU3xYVvIz0SaiVo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ij8lkbKxHqVoJbRnJnJ6DlRFTSNr+PeVm73+uSCYBkrTUHhTHiH0olGg/2syfidaIlkt08uyy14e57GH0zbKKmdGRB37NrE1Njq1Msanr6gZdAoTZo+8+kBksPBFyXGzC3kAmhFBjKcoX76FY/2F1o2iNpSRbNoqrNzmPsBzPok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yAas9k5L; arc=fail smtp.client-ip=40.107.220.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yAas9k5L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ryrNl7vY1lqUU2CRCGKLNgbbZ6sYMQeFkdjmvmHa2eR81SF3GugdgUJw0+pLLJuYbcO/bvaDP56oeB/BfZx9iwjt8tev5HwoGKLLzK1mKOZc5Qm7AksDqH8DKyKo2cO02eLuFnZU0juSer2YqKR2eG8rd5Q5yjCZGIMmjqCIecwTw0RFZJJ3b201SbAcjOhAQHGPtWfxa3CGHt86ZozqK5ntQJchEE5XFLBKvwumVQyhY8PFqvhGueb7xiZdYeztBA1tOsm8Bs0Ojew27WxnfyfHFK43GIPtgM8X7ZpaOJ4YLKNzy5TwSvgfh57G5SRQ6eWIkqHKPgA2zlQrG0+jGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUWuWCXZdJgKeqGF6ECbcieeTuWspqNfhISf5+g6HL0=;
 b=c0hVZL6QB5MVsooDthoOZhnKxhXHig1yT53qDIJ9qrMOqCg22OsnwOStObzd9TNjLHbR0hg//DLNZNtCD5nnZtdpcLLghKcCDTP6KcgnAfeSvN7PJqdaCHqMi3SOvjbG6spBFlhz7ZvUofo8Sc/vaTjRZyvuiO1FM3oQc6+TviF8BlR/vpSzZqCjnVW1irUQr7w4iLtgOxXoaEHskAf/UnrFbgnv0iC2MQaFEOy/KEfkv7qxXIctcnG7z0/S/3bSsZhadJ9JlbRIylAlTKkviZSrYT0hCC3DOvX8jMCV49N2ENOr+cMsnewg5Dm1d3Uk0KSu+XBM1zrUCif6lH/f0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUWuWCXZdJgKeqGF6ECbcieeTuWspqNfhISf5+g6HL0=;
 b=yAas9k5LbCvnjtchEby9v6pl/35lT63wZNS8NYVijGF8l5uAi2d38ntPc47SN4SiJf1sRhjbSGlSq1cZAszd2o8Pm4+EstM+ZsBoqK6BqckhwJXruXRNbo/XEI9dys/SJLXd/3s8aUyCXKtEPvA+EQ/oLzDirISuNXPhHnEUbz8=
Received: from BY3PR05CA0009.namprd05.prod.outlook.com (2603:10b6:a03:254::14)
 by IA1PR12MB8261.namprd12.prod.outlook.com (2603:10b6:208:3f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Mon, 28 Oct
 2024 09:40:33 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::9d) by BY3PR05CA0009.outlook.office365.com
 (2603:10b6:a03:254::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.8 via Frontend
 Transport; Mon, 28 Oct 2024 09:40:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 09:40:33 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 04:40:29 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Vasant Hegde <vasant.hegde@amd.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: [PATCH v5 07/12] iommu/amd: Separate page table setup from domain allocation
Date: Mon, 28 Oct 2024 09:38:05 +0000
Message-ID: <20241028093810.5901-8-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028093810.5901-1-vasant.hegde@amd.com>
References: <20241028093810.5901-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|IA1PR12MB8261:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bf38493-4c21-4fc9-98d6-08dcf734919f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0HxXnz6eCkOiHmoLitGJ8nkXj1zwPRk37G2uAY17U50EfhHX4DKBca7KDZfz?=
 =?us-ascii?Q?DWIUdtreZQasBu6Xs8hPDk4ikwY+GGK9wRurE5Woy2JY8m/kFy/E8guYjpkx?=
 =?us-ascii?Q?ag7B6Aa2XCgVm9tmS/k+AYTgKqMJz6yI+AJU4KgWH7h/HxOrxERjdNmkgaOc?=
 =?us-ascii?Q?gIkvZUUUuuvoVU97m+YVVkXYqdVsJNMliFT1Cic8Jda/+o3WhPD8DGAKb1Nd?=
 =?us-ascii?Q?FdOwgk126gKUk1TpnKRrlhYC17nvT8v8NN8Jkm3KgPXMlOC5t+egvDuTNNEq?=
 =?us-ascii?Q?hIQr5kFvEYyfUBQMLcO5WGdWwGpPxLIpkMzq5lUk38cnTtGxyQfaul9GXA5N?=
 =?us-ascii?Q?PVHYb/WW5ykca1UxSGBTlZFCdVox+ODW6KQcWg+VCCKeyb9Xl4ngpK/EDjIZ?=
 =?us-ascii?Q?ALHBsnVQ/dimwjkaXw9Fiymh+8HSPt3QKP+FTGtyl2qfeOPK53M8Zxb+J7xd?=
 =?us-ascii?Q?45EeDqxbOLRrrfgH/10jTDLPsxDPd/f/A3zl1DwbZa7brGdoILieaUdajMUs?=
 =?us-ascii?Q?2pvKwr/J3kc0AMMr6HOTxthq9Fdes6rlTHmVjrs7+alh8xeQSUE7tPiqdieD?=
 =?us-ascii?Q?pCAXlYSTvUO9NTfQ6jxgE61Y31kSdd5/fH+d88Hsz8eZQWUYLoTnaZQFMlem?=
 =?us-ascii?Q?GiNssLVrRdFkDLwK5UwPdjSuV9Rcia1QRV/WlPmoWzc+lgdy6OQfMQEe28m8?=
 =?us-ascii?Q?4qQ1UzTkWhVR1gXM1/7qQpBtMoeMHIVU9/56eaaZP9qHSyWCcnLRG0488djG?=
 =?us-ascii?Q?b8OK+9BPtMhufPWuY0KutummVC17JB5/eaGk4rGg9OhoWYrbVSFBCKhuXT33?=
 =?us-ascii?Q?oXiEiy13YHxxwFToLYtYUp9ehtF3TKdZAt2liRIRg+jc7xzP81ByJRnlglE/?=
 =?us-ascii?Q?GtNODnFLl2XeSYnkwWYR+hyNsOqMsgar1Lfu906A+n0faWJ0OVwuEm32wk0l?=
 =?us-ascii?Q?1+eBc40HiRCheSm4OPCNXrJ7HygT3DlU77ToCs+ZuqPUmJNacNJZFebhjvE/?=
 =?us-ascii?Q?mvNAO8Ncr+vo3eW2CP6EN7PzpsK2jk/jI0nRZPp20uWRvHcBF7zPp+TTl2iH?=
 =?us-ascii?Q?pVyVlOZrhGB1S/0g0Abv5IMJ2FURxPYT09lKMwpjmlYlyNLKxyR87Omr8b2+?=
 =?us-ascii?Q?BKaVk8z9hiUYuXCaZ/I/phxF7owvHcYeSjkkB+lQF17uUtDb7qwPd/k6tpyS?=
 =?us-ascii?Q?1HmWkfzvADNxTfyG6rLfYtkT4nLqH5OE/zsmBMvilx/rRASQqce6AIoaLH16?=
 =?us-ascii?Q?Jj6GQHFG6ea93czy4rRUyX8GbH9Mh3f6ziuQdYInd7hMdlIqy121t/jyBhsi?=
 =?us-ascii?Q?H3E/DJCsPwBcVmBP+kcBPpEgV02CMhZBAxOC/TbM6pjpg6eENSK+DJa9VZFZ?=
 =?us-ascii?Q?l2CQvdy6LveiQ0cifawf7zFmIoneroRZQ6bwq6BcSzLzV+G65Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 09:40:33.1721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf38493-4c21-4fc9-98d6-08dcf734919f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8261

Currently protection_domain_alloc() allocates domain and also sets up
page table. Page table setup is required for PAGING domain only. Domain
type like SVA doesn't need page table. Hence move page table setup code
to separate function.

Also SVA domain allocation path does not call pdom_setup_pgtable().
Hence remove IOMMU_DOMAIN_SVA type check.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jacob Pan <jacob.pan@linux.microsoft.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 42 ++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 8364cd6fa47d..6285fd1afd50 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2265,28 +2265,36 @@ void protection_domain_free(struct protection_domain *domain)
 
 struct protection_domain *protection_domain_alloc(unsigned int type, int nid)
 {
-	struct io_pgtable_ops *pgtbl_ops;
 	struct protection_domain *domain;
-	int pgtable;
 
 	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
 	if (!domain)
 		return NULL;
 
 	domain->id = domain_id_alloc();
-	if (!domain->id)
-		goto err_free;
+	if (!domain->id) {
+		kfree(domain);
+		return NULL;
+	}
 
 	spin_lock_init(&domain->lock);
 	INIT_LIST_HEAD(&domain->dev_list);
 	INIT_LIST_HEAD(&domain->dev_data_list);
 	domain->iop.pgtbl.cfg.amd.nid = nid;
 
+	return domain;
+}
+
+static int pdom_setup_pgtable(struct protection_domain *domain,
+			      unsigned int type)
+{
+	struct io_pgtable_ops *pgtbl_ops;
+	int pgtable;
+
 	switch (type) {
 	/* No need to allocate io pgtable ops in passthrough mode */
 	case IOMMU_DOMAIN_IDENTITY:
-	case IOMMU_DOMAIN_SVA:
-		return domain;
+		return 0;
 	case IOMMU_DOMAIN_DMA:
 		pgtable = amd_iommu_pgtable;
 		break;
@@ -2298,7 +2306,7 @@ struct protection_domain *protection_domain_alloc(unsigned int type, int nid)
 		pgtable = AMD_IOMMU_V1;
 		break;
 	default:
-		goto err_id;
+		return -EINVAL;
 	}
 
 	switch (pgtable) {
@@ -2309,20 +2317,14 @@ struct protection_domain *protection_domain_alloc(unsigned int type, int nid)
 		domain->pd_mode = PD_MODE_V2;
 		break;
 	default:
-		goto err_id;
+		return -EINVAL;
 	}
-
 	pgtbl_ops =
 		alloc_io_pgtable_ops(pgtable, &domain->iop.pgtbl.cfg, domain);
 	if (!pgtbl_ops)
-		goto err_id;
+		return -ENOMEM;
 
-	return domain;
-err_id:
-	domain_id_free(domain->id);
-err_free:
-	kfree(domain);
-	return NULL;
+	return 0;
 }
 
 static inline u64 dma_max_address(void)
@@ -2345,6 +2347,7 @@ static struct iommu_domain *do_iommu_domain_alloc(unsigned int type,
 	bool dirty_tracking = flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
 	struct protection_domain *domain;
 	struct amd_iommu *iommu = NULL;
+	int ret;
 
 	if (dev)
 		iommu = get_amd_iommu_from_dev(dev);
@@ -2364,6 +2367,13 @@ static struct iommu_domain *do_iommu_domain_alloc(unsigned int type,
 	if (!domain)
 		return ERR_PTR(-ENOMEM);
 
+	ret = pdom_setup_pgtable(domain, type);
+	if (ret) {
+		domain_id_free(domain->id);
+		kfree(domain);
+		return ERR_PTR(ret);
+	}
+
 	domain->domain.geometry.aperture_start = 0;
 	domain->domain.geometry.aperture_end   = dma_max_address();
 	domain->domain.geometry.force_aperture = true;
-- 
2.31.1

